module code_writer;

import core.sys.posix.signal : SIGTRAP;
import core.stdc.signal : raise;
import std.file : fileRead = read, fileWrite = write;

import std_includes;

/**
 * Code writer object.
 * Automatically indents D code.
 * Provides some file update build optimizations (only writes existing files if changed).
 * Also when debugging is enabled allows for a debugger trap (SIGTRAP) to be emitted when
 * when one or more file names and line numbers are matched.
 */
class CodeWriter
{
  this(string fileName, dstring[] content = [])
  {
    this.fileName = fileName;
    lines = content;

    trapActive.length = trapFiles.length;

    foreach (i, name; trapFiles)
      trapActive[i] = fileName.endsWith(name);
  }

  this(string fileName, dstring content)
  {
    this(fileName, content.splitLines);
  }

  CodeWriter opOpAssign(string op)(dstring[] rhs) if (op == "~")
  {
    lines ~= rhs;

    foreach (i, ref active; trapActive)
    {
      if (active && lines.length >= trapLines[i])
      {
        active = false;
        raise(SIGTRAP);
      }
    }

    return this;
  }

  CodeWriter opOpAssign(string op)(dstring rhs) if (op == "~")
  { // Remove end newline to have identical behavior of raw text append
    if (rhs.endsWith('\n'))
      rhs = rhs[0 .. $ - 1];

    if (rhs == "")
      return this ~= [""];

    return this ~= rhs.splitLines;
  }

  void write()
  {
    if (!exists(fileName.dirName()))
      mkdirRecurse(fileName.dirName());

    dstring content;
    uint indent;
    bool indentStatement; // Used for indenting a single line after a control statement without a open/close brace block

    foreach (line; lines)
    {
      if (!inComment)
      {
        if (line.startsWith("/*")) // Start of multi-line comment?
          inComment = true;
        else if (line.endsWith('}') && indent >= 2) // End brace for a control block?
          indent -= 2;
        else if (line.endsWith('{'))
          indentStatement = false; // Don't add single statement indent if indent statement is followed by an open brace
      }

      auto calcIndent = indent
        + (line.startsWith("*") ? 1 : 0) // Indent an extra space for multiline comments
        + (indentStatement ? 2 : 0); // Indent statements without braces

      auto stripLine = line.strip;

      if (stripLine.length > 0)
        content ~= (cast(dchar)' ').repeat(calcIndent).array ~ stripLine ~ "\n"d;
      else
        content ~= "\n";

      indentStatement = false;

      if (inComment)
      {
        if (line.endsWith("*/")) // End of multi-line comment?
          inComment = false;
      }
      else if (line.endsWith('{')) // Open brace for a control block increases indent
        indent += 2;
      else if (["else", "for ", "foreach ", "if ", "static if ", "version(", "while "].filter!(x => line.startsWith(x))
          .empty != true)
        indentStatement = true;
    }

    string strContent = content.to!string;

    // Only write file if it has changed, to optimize builds
    if (!exists(fileName) || fileRead(fileName) != strContent)
      fileWrite(fileName, strContent);
  }

  static void setDebugTrap(string fileName, uint line)
  {
    trapFiles ~= fileName;
    trapLines ~= line;
  }

  dstring[] lines; // Array of lines

private:
  static string[] trapFiles; // Array of filenames to trap on
  static uint[] trapLines; // Array of line numbers for each file to trap on (0 for wildcard)

  string fileName; // Name of file the buffer will be written to
  bool[] trapActive; // Array of booleans indicating if a trap is active and not yet triggered (true)

  bool inComment; // True if inside a multi-line comment
}
