module code_writer;

import core.sys.posix.signal : SIGTRAP;
import core.stdc.signal : raise;
import std.algorithm : endsWith, startsWith;
import std.conv : to;
import std.file : exists, mkdirRecurse, fileRead = read, fileWrite = write;
import std.path : dirName;
import std.string : splitLines, strip;

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
      rhs = rhs[1 .. $];

    if (rhs == "")
      return this ~= [""];

    return this ~= rhs.splitLines;
  }

  void write()
  {
    if (!exists(fileName.dirName()))
      mkdirRecurse(fileName.dirName());

    dstring content;
    dstring indent = "";

    foreach (l; lines)
    {
      if (l.endsWith('}') && indent.length >= 2)
        indent.length -= 2;

      if (l.startsWith("*"))
        content ~= indent ~ " " ~ l.strip ~ '\n'; // Indent an extra space for multiline comments
      else
        content ~= indent ~ l.strip ~ '\n';

      if (l.endsWith('{'))
        indent ~= "  ";
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

  dstring tabs; // Current indentation tab characters
  bool statement; // True if in a statement
  int paramList = 0; // Parameter list
}
