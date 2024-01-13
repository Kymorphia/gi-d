module xmltree;

import std.algorithm : countUntil, startsWith;
import std.conv : to;
import std.exception : assertThrown;
import std.format : format;
import std.range : drop, dropOne, empty;
import std.utf : toUTF32;

class XmlTree
{
  this()
  {
    xmlDoc = new XmlNode("xml");
  }

  void parse(string data, string fileName="<UNKNOWN>")
  {
    enum State
    {
      Start, // Start of document
      Xml, // XML doc <?xml ?> node
      Element, // Inside an element tag
      Node // Inside element content (node)
    }

    dstring xmlstr = toUTF32(data);
    auto totalLength = xmlstr.length;
    size_t lineCount;
    size_t charIndex;
    XmlNode[] nodeStack;
    State state;

    void error(string message)
    {
      throw new XmlParseError(message, fileName, lineCount, charIndex);
    }

    void pop(size_t count=1)
    {
      charIndex += count;
      xmlstr = xmlstr.drop(count);
    }

    dstring popval(size_t count=1)
    {
      dstring retval = xmlstr[0 .. count];
      pop(count);
      return retval;
    }

    // Skip whitespace, returns true if there was any
    bool skipWhiteSpace()
    {
      bool retval;
      while (!xmlstr.empty && isWhite(xmlstr[0]))
      {
        if (xmlstr[0] == '\n')
        {
          lineCount++;
          xmlstr = xmlstr.dropOne;
          charIndex = 0;
        }
        else
          pop();

        retval = true;
      }
      return retval;
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

      name ~= popval();

      while (!xmlstr.empty && isValidElemChar(xmlstr[0]))
        name ~= popval();

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

      while (!xmlstr.empty && xmlstr[0] != quotechar)
      {
        if (xmlstr[0] == '<' || xmlstr[0] == '&')
          error(format("Unexpected character '%s' in XML attribute value", xmlstr[0]));

        val ~= popval();
      }

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
                error(format("Invalid digit '%s' in XML hex numeric entity", xmlstr[0]));
            }

            if (!match(";"))
              error("Unexpected EOF while looking for XML hex numeric entity terminator");

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
          error(format("Unexpected XML closing element '%s', expected '%s'", name, nodeStack[$ - 1].name));

        nodeStack = nodeStack[0 .. $ - 1];
      }
      else if (match("<!--")) // Comment
      {
        auto count = xmlstr.countUntil("-->");

        if (count == -1)
          error("Unexpected EOF looking for comment closing");

        pop(count + 3);
      }
      else if (state == State.Node && match("<")) // Opening/standalone element?
      {
        if (!parseName(name))
          error("Invalid XML element name");

        nodeStack ~= new XmlNode(name);
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
  this(dstring name)
  {
    this.name = name;
  }

  XmlNode parent;
  XmlNode[] children;
  dstring name;
  dstring[dstring] attrs;
  dstring content;
}

class XmlParseError : Exception
{
  this(string message, string file, size_t line, size_t index)
  {
    super(message);
    _message = message;
    _file = file;
    _line = line;
    _index = index;
  }

  override string toString() const
  {
    return format("XmlParseError: %s (in file %s, at line %s, index %s)", _message, _file, _line, _index);
  }

private:
  string _message;
  string _file;
  size_t _line;
  size_t _index;
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
