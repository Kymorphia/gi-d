module xml_patch;

import std_includes;
import xml_tree;

/**
 * XML patching class.
 *
 * Patch syntax
 *
 * XmlSelector:
 *   Provides a way of selecting a node or attribute
 *   Values with spaces can be double quoted
 *   Node IDs are separated by periods: repository.namespace
 *   Paths default to being relative to repository.namespace unless "repository" or "namespace" is specified
 *   "name" attributes can be matched in square brackets: function[my_function]
 *   Other attribute values can be matched with ATTR=VAL syntax: function[c:identifier=g_boxed_copy]
 *   Multiple attributes can be matched (logic AND) by seperating them with commas: function[my_function,version=1.22]
 *   When selecting an attribute it follows surrounded by a second set of square brackets: record[my_struct][opaque]
 *   If the selected node does not have any attribute selection criteria it can be empty brackets: namespace[][name]
 *
 * XmlTree:
 *   A verbatim XML tree.
 *
 * NOTE: The operator names (set, del, add) are handled externally.
 *
 * Change attribute: set XmlSelector[Attr] AttrValue
 * Change node: set XmlSelector XmlTree
 * Delete attribute: del XmlSelector[Attr]
 * Delete node: del XmlSelector
 * Add node: add XmlSelector XmlTree
 */
class XmlPatch
{
  this()
  {
  }

  this(string filename, uint lineNumber)
  {
    this.filename = filename;
    this.lineNumber = lineNumber;
  }

  /**
   * Parse a set (change) XML patch command.
   * Params:
   *   sel = XML node or attribute selector
   *   val = XML content for a node or attribute value for an attribute
   */
  void parseSetCmd(dstring sel, dstring val)
  {
    op = XmlPatchOp.Set;
    parseSelector(sel);

    if (selAttrId.empty) // Set XML node?
      nodeValue = new XmlTree(val, "<VALUE>");
    else // Set XML attribute value
      attrValue = val;
  }

  /**
   * Parse a delete XML patch command.
   * Params:
   *   sel = XML node or attribute selector
   */
  void parseDeleteCmd(dstring sel)
  {
    op = XmlPatchOp.Delete;
    parseSelector(sel);
  }

  /**
   * Parse an add XML node patch command.
   * Params:
   *   sel = XML node or attribute selector to add new node under
   *   xmlVal = The XML tree to parse and add
   */
  void parseAddCmd(dstring sel, dstring xmlVal)
  {
    op = XmlPatchOp.Delete;
    parseSelector(sel);
    nodeValue = new XmlTree(xmlVal, "<VALUE>");
  }

  /**
   * Parse a patch specification into a patch object.
   * Params:
   *   patchSpec = The path command specification to parse
   */
  void parseSelector(dstring patchSpec)
  { // State machine enum for parts of the patch specification
    enum Part
    {
      NodeName, // XML node name
      AttrNameValOrId, // Attribute "name" value to match or another attribute ID if "=" is present
      AttrId, // Additional attribute ID (ID must be specified)
      AttrVal, // Attribute match value
      AttrEnd, // Attribute [] block has ended (waiting for end of patch spec, '.' node separator, or '[' attribute selector)
      AttrSelId, // Attribute select ID
      End, // Expect end of selector
    }

    Part part;
    ulong lastNdx;
    dstring attrId;

    foreach (i, c; patchSpec)
    {
      final switch (part) with (Part)
      {
        case NodeName: // Expect node name
          if (c == '.' || c == '[')
          {
            if (i == lastNdx)
              throw new Exception("Invalid empty node ID in XML patch specification");

            selectors.length++;
            selectors[$ - 1].id = patchSpec[lastNdx .. i];

            if (c == '[')
              part = AttrNameValOrId; // Next part will be a "name" attribute value to match or an attribute ID if '=' is found

            lastNdx = i + 1;
          }
          break;
        case AttrNameValOrId: // Expected "name" attribute match value or an attribute ID
          if (c == '=' || c == ',' || c == ']')
          {
            if (i > lastNdx) // Was string non-empty?
            {
              if (c == '=') // Is an attribute value specified?
              {
                attrId = patchSpec[lastNdx .. i]; // Store attribute ID until value is captured
                part = AttrVal;
              }
              else
              {
                selectors[$ - 1].attrs["name"] = patchSpec[lastNdx .. i]; // Parsed "name" attribute value, set it in the current selector
                part = c == ',' ? AttrId : AttrEnd;
              }

              lastNdx = i + 1;
            }
            else if (c != ']')
              throw new Exception("Unexpected empty attribute ID");
            else
              part = AttrEnd;
          }
          break;
        case AttrId: // Expected attribute ID
          if (c == '=')
          {
            attrId = patchSpec[lastNdx .. i];
            part = AttrVal;
            lastNdx = i + 1;
          }
          else if (c == ',' || c == ']')
            throw new Exception("Unexpected attribute ID without a value");
          break;
        case AttrVal: // Expect attribute value
          if (c == ',' || c == ']')
          {
            selectors[$ - 1].attrs[attrId] = patchSpec[lastNdx .. i]; // Parsed attribute value, set it in the current selector
            part = c == ',' ? AttrId : AttrEnd;
            lastNdx = i + 1;
          }
          break;
        case AttrEnd:
          if (c == '[')
            part = AttrSelId;
          else if (c == '.')
            part = NodeName;
          else
            throw new Exception("Unexpected character at end of attributes selector block");

          lastNdx = i + 1;
          break;
        case AttrSelId:
          if (c == ']')
          {
            selAttrId = patchSpec[lastNdx .. i];
            part = End;
          }
          break;
        case End:
          throw new Exception("Found unexpected character at end of selector");
      }
    }
  }

  /**
   * Get a selector string from a patch.
   * Params:
   *   count = Count of selector components to show (0 to show all)
   * Returns: Selector string
   */
  dstring selectorString(uint count)
  {
    dstring s;

    foreach (sel; selectors)
    {
      if (!s.empty)
        s ~= ".";

      s ~= sel.id;

      if (sel.attrs.length > 0)
      {
        s ~= "[";

        if ("name" in sel.attrs)
          s ~= sel.attrs["name"];

        foreach (at; sel.attrs.byKeyValue)
        {
          if (at.key != "name")
          {
            if (s[$ - 1] != '[')
              s ~= ",";

            s ~= at.key ~ "=" ~ at.value;
          }
        }

        s ~= "]";
      }

      if (count != 0)
      {
        count--;

        if (count == 0)
          break;
      }
    }

    return s;
  }

  XmlPatchOp op; /// Patch operation
  XmlSelector[] selectors; /// Selection path
  dstring selAttrId; /// The selected attribute of the node matched by selectors (null if selecting a node)
  dstring attrValue; /// Attribute value (if selAttrId is set)
  XmlTree nodeValue; /// Node value (parsed XML tree) or null
  string filename; /// Name of definition file the XML patch command came from
  uint lineNumber; /// Line number in filename of the XML patch command
}

/// XML selector. All criteria is logically ANDed.
struct XmlSelector
{
  dstring id; /// Node id to match
  dstring[dstring] attrs; /// Attributes to match
}

/// XML patch operation
enum XmlPatchOp : ubyte
{
  Set, /// Set a node (replace) or attribute
  Delete, /// Delete a node or attribute
  Add, /// Add a node
}
