module xml_tree;

import core.exception : RangeError;
import std.utf : toUTF32;
import std_includes;

class XmlTree
{
  this()
  {
    xmlDoc = new XmlNode("xml");
  }

  void parse(string data, string fileName = "<UNKNOWN>")
  {
    enum State
    {
      Start, // Start of document
      Xml, // XML doc <?xml ?> node
      Element, // Inside an element tag
      Node // Inside element content (node)
    }

    dstring xmlstr = toUTF32(data);
    uint lineCount = 1;
    uint charIndex;
    XmlNode[] nodeStack;
    State state;

    void error(string message)
    {
      throw new XmlParseError(message, fileName, lineCount, charIndex);
    }

    void pop(size_t len = 1)
    {
      foreach (i; 0 .. len)
      {
        if (xmlstr[i] == '\n')
        {
          lineCount++;
          charIndex = 0;
        }
        else
          charIndex++;
      }

      xmlstr = xmlstr.drop(len);
    }

    dstring popval(size_t len = 1)
    {
      dstring retval = xmlstr[0 .. len];
      pop(len);
      return retval;
    }

    // Skip whitespace, returns true if there was any
    bool skipWhiteSpace()
    {
      auto len = xmlstr.countUntil!(x => !isWhite(x));
      pop(len);
      return len > 0;
    }

    bool match(dstring m)
    {
      if (xmlstr.startsWith(m))
      {
        pop(m.length);
        return true;
      }
      return false;
    }

    bool parseName(out dstring name)
    {
      if (xmlstr.empty || !isValidElemStartChar(xmlstr[0]))
        return false;

      auto len = xmlstr[1 .. $].countUntil!(x => !isValidElemChar(x));
      name ~= popval(1 + len);
      return true;
    }

    bool parseAttribute(out dstring name, out dstring val)
    {
      if (!parseName(name))
        return false;

      if (!match("="))
        error("Expected '=' delimiter for XML attribute value");

      dchar quotechar;

      if (!xmlstr.empty)
        quotechar = popval()[0];

      if (quotechar != '"' && quotechar != '\'')
        error("Expected XML attribute value quote character");

      auto len = xmlstr.countUntil!(x => x.among(quotechar, '<', '&') != 0);

      if (len < xmlstr.length && (xmlstr[len] == '<' || xmlstr[len] == '&'))
        error(format("Unexpected character '%s' in XML attribute value", xmlstr[len]));

      val ~= popval(len);

      if (!match([quotechar]))
        error("Unexpected EOF looking for XML attribute value closing quote");

      return true;
    }

    bool parseContent(out dstring val)
    {
      if (xmlstr.empty)
        return false;

      while (!xmlstr.empty && xmlstr[0] != '<')
      {
        if (match("&"))
        {
          if (match("#x"))
          {
            dchar d = 0;

            while (!xmlstr.empty && xmlstr[0] != ';')
            {
              if (xmlstr[0] >= '0' && xmlstr[0] <= '9')
                d = d << 4 | (popval()[0] - '0');
              else if (xmlstr[0] >= 'a' && xmlstr[0] <= 'f')
                d = d << 4 | (popval()[0] - 'a' + 0xa);
              else if (xmlstr[0] >= 'A' && xmlstr[0] <= 'F')
                d = d << 4 | (popval()[0] - 'A' + 0xA);
              else
                error(format("Invalid digit '%s' in XML hex numeric entity",
                    xmlstr[0]));
            }

            if (!match(";"))
              error(
                  "Unexpected EOF while looking for XML hex numeric entity terminator");

            val ~= d;
          }
          else if (match("#"))
          {
            dchar d = 0;

            while (!xmlstr.empty && xmlstr[0] != ';')
            {
              if (xmlstr[0] >= '0' && xmlstr[0] <= '9')
                d = d * 10 + (popval()[0] - '0');
              else
                error(format("Invalid digit '%s' in XML numeric entity", xmlstr[0]));
            }

            if (!match(";"))
              error("Unexpected EOF while looking for XML numeric entity terminator");

            val ~= d;
          }
          else if (match("amp;"))
            val ~= '&';
          else if (match("lt;"))
            val ~= '<';
          else if (match("gt;"))
            val ~= '>';
          else if (match("apos;"))
            val ~= '\'';
          else if (match("quot;"))
            val ~= '"';
          else
            error("Unknown XML character entity");
        }
        else // Not a & character entity
          val ~= popval();
      }

      return true;
    }

    while (!xmlstr.empty)
    {
      dstring name, val;

      skipWhiteSpace();

      if (state == State.Node && match("</")) // Closing element?
      {
        if (!parseName(name))
          error("Invalid XML element name");

        if (name != nodeStack[$ - 1].name)
          error(format("Unexpected XML closing element '%s', expected '%s'",
              name, nodeStack[$ - 1].name));

        nodeStack = nodeStack[0 .. $ - 1];
      }
      else if (match("<!--")) // Comment
      {
        auto len = xmlstr.countUntil("-->");

        if (len == -1)
          error("Unexpected EOF looking for comment closing");

        pop(len + 3);
      }
      else if (state == State.Node && match("<")) // Opening/standalone element?
      {
        auto parseLine = lineCount;

        if (!parseName(name))
          error("Invalid XML element name");

        nodeStack ~= new XmlNode(name, fileName, parseLine);
        state = State.Element;

        if (nodeStack.length > 1)
        {
          nodeStack[$ - 1].parent = nodeStack[$ - 2];
          nodeStack[$ - 2].children ~= nodeStack[$ - 1];
        }
        else
          root = nodeStack[0];
      }
      else if (state == State.Element && match("/>")) // End of standalone element?
      {
        nodeStack = nodeStack[0 .. $ - 1];
        state = State.Node;
      }
      else if (state == State.Element && match(">")) // End of element?
        state = State.Node;
      else if (state == State.Start && match("<?xml"))
        state = State.Xml;
      else if (state == State.Xml && parseAttribute(name, val)) // <?xml attribute name="value"?
        xmlDoc.attrs[name] = val;
      else if (state == State.Xml && match("?>"))
        state = State.Node;
      else if (state == State.Element && parseAttribute(name, val)) // Attribute name="value"?
        nodeStack[$ - 1].attrs[name] = val;
      else if (state == State.Node && parseContent(val)) // Node content?
      {
        if (!nodeStack.empty)
          nodeStack[$ - 1].content = val;
      }
      else if (!xmlstr.empty)
        error(format("Unexpected character '%s'", xmlstr[0]));
    }

    if (!nodeStack.empty)
      error("Unexpected EOF with unterminated XML elements");
  }

  XmlNode root;
  XmlNode xmlDoc;
}

class XmlNode
{
  this(dstring name, string parseFile = null, uint parseLine = 0)
  {
    this.name = name;
    this.parseFile = parseFile;
    this.parseLine = parseLine;
  }

  /// Node full name including its ancestry names separated by periods.
  @property dstring fullname()
  {
    dstring s;

    for (auto n = this; n; n = n.parent)
      s = s.empty ? n.name : n.name ~ "." ~ s;

    return s;
  }

  dstring opIndex(dstring key)
  {
    dstring retval;

    try
      retval = attrs[key];
    catch (RangeError e)
      throw new XmlAttrError(this, key);

    return retval;
  }

  dstring get(dstring key, dstring def = null)
  {
    return attrs.get(key, def);
  }

  /**
   * Find a child by name.
   * Params:
   *   childName = Name of child node to find
   * Returns: The first XmlNode child with childName or null if not found
   */
  XmlNode findChild(dstring childName)
  {
    foreach (child; children)
      if (child.name == childName)
        return child;

    return null;
  }

  /**
   * Find a child by name and throw XmlChildNotFoundError if not found.
   * Params:
   *   childName = Name of child node to find
   * Returns: The first XmlNode child with childName
   */
  XmlNode requireChild(dstring childName)
  {
    if (auto retval = findChild(childName))
      return retval;

    throw new XmlChildNotFoundError(this, childName);
  }

  /**
   * Display a warning message with node location details.
   * Params:
   *   msg = The message
   */
  void warn(dstring msg)
  {
    stderr.writeln(format("WARNING: %s (node '%s' in file '%s' at line %s)",
        msg, fullname, parseFile, parseLine));
  }

  XmlNode parent; /// Parent XML node
  XmlNode[] children; /// Children nodes
  dstring name; /// Name of node
  dstring[dstring] attrs; /// Node attribute values
  dstring content; /// The text content between open and closing element

  string parseFile; /// Name of parsed XML file
  uint parseLine; /// Line number in original XML file that the node name was parsed on
}

class XmlParseError : Exception
{
  this(string msg, string file, size_t line, size_t index)
  {
    super(msg);
    this.file = file;
    this.line = line;
    this.index = index;
  }

  override string toString() const
  {
    return format("XmlParseError: %s (in file '%s', at line %s, index %s)",
        msg, file, line, index);
  }

  string file;
  size_t line;
  size_t index;
}

/// XML attribute lookup error. Used for catching missing required attributes.
class XmlAttrError : RangeError
{
  this(XmlNode node, dstring attrName)
  {
    super("Attribute " ~ attrName.to!string ~ " not found");
    this.node = node;
    this.attrName = attrName;
  }

  override string toString()
  {
    return format("XmlAttrError: %s (in node %s, in file '%s', line %s)",
        msg, node.fullname, node.parseFile, node.parseLine);
  }

  XmlNode node; /// The XML node
  dstring attrName; /// The attribute name
}

/// XML child node not found error. Used for catching missing child nodes.
class XmlChildNotFoundError : Exception
{
  this(XmlNode node, dstring childName)
  {
    super("Child node " ~ childName.to!string ~ " not found");
    this.node = node;
    this.childName = childName;
  }

  override string toString()
  {
    return format("XmlChildNotFoundError: %s (in node %s, in file '%s', line %s)",
        msg, node.fullname, node.parseFile, node.parseLine);
  }

  XmlNode node; /// The XML node
  dstring childName; /// The name of the child which is missing
}

/**
 * Check if a character is a whitespace character
 * Params:
 *   ch = Character to check
 * Returns: true if whitespace, false otherwise
 */
bool isWhite(dchar ch)
{
  return ch == ' ' || ch == '\t' || ch == '\n' || ch == '\r';
}

/**
 * Check if a unicode character is a valid XML element start character (we don't allow any unicode chars, contrary to the standard)
 * Params:
 *   ch = The character
 * Returns: true if valid start character, false otherwise
 */
bool isValidElemStartChar(dchar ch)
{
  return (ch >= 'A' && ch <= 'Z') || (ch >= 'a' && ch <= 'z') || ch == ':' || ch == '_';
}

/**
 * Check if a unicode character is a valid XML element start character (we don't allow any unicode chars, contrary to the standard)
 * Params:
 *   ch = The character
 * Returns: true if valid start character, false otherwise
 */
bool isValidElemChar(dchar ch)
{
  return isValidElemStartChar(ch) || ch == '-' || ch == '.' || (ch >= '0' && ch <= '9');
}

unittest
{
  string data = `<?xml version="1.0"?>
<repository version="1.2"
            xmlns="http://www.gtk.org/introspection/core/1.0"
            xmlns:c="http://www.gtk.org/introspection/c/1.0"
            xmlns:glib="http://www.gtk.org/introspection/glib/1.0">
  <package name="glib-2.0"/>
  <c:include name="glib.h"/>
  <namespace name="GLib"
             version="2.0"
             shared-library="libgobject-2.0.so.0,libglib-2.0.so.0"
             c:identifier-prefixes="G"
             c:symbol-prefixes="g,glib">
    <alias name="DateDay" c:type="GDateDay">
      <doc xml:space="preserve"
           filename="glib-2.0.c"
           line="289">Integer representing a day of the month; between 1 and 31.

The %G_DATE_BAD_DAY value represents an invalid day of the month.</doc>
      <source-position filename="gdate.h" line="52"/>
      <type name="guint8" c:type="guint8"/>
    </alias>
    <test>&amp; &lt; &gt; &apos; &quot; &#x31; &#50;</test>
  </namespace>
</repository>
`;

  auto tree = new XmlTree();
  tree.parse(data);

  assert(tree.xmlDoc.attrs["version"] == "1.0");
  assert(tree.root.name == "repository");
  assert(tree.root.attrs["version"] == "1.2");
  assert(tree.root.attrs["xmlns:glib"] == "http://www.gtk.org/introspection/glib/1.0");
  assert(tree.root.children[0].name == "package");
  assert(tree.root.children[0].attrs["name"] == "glib-2.0");
  assert(tree.root.children[2].name == "namespace");
  assert(tree.root.children[2].attrs["name"] == "GLib");
  assert(tree.root.children[2].children[1].name == "test");
  assert(tree.root.children[2].children[1].content == "& < > ' \" 1 2"d);

  string noAttrEqual = `<?xml version="1.0"?><repository version`;
  tree = new XmlTree();
  assertThrown(tree.parse(noAttrEqual));
}
