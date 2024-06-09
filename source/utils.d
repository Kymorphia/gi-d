module utils;

import core.stdc.signal : raise;
import core.sys.posix.signal : SIGTRAP;
public import std.experimental.logger;

public import code_traps;
public import std_includes;

static this()
{
  sharedLog(cast(shared Logger)new GidLogger);
}

/// Create our own logger to strip out some of the extra info
class GidLogger : Logger
{
  this(LogLevel lv = LogLevel.all) @safe
  {
    super(lv);
  }

  override void writeLogMsg(ref LogEntry entry)
  {
    if (entry.logLevel == LogLevel.info)
      writeln(entry.msg);
    else
      writeln(entry.logLevel.to!string.capitalize ~ ": " ~ entry.msg);
  }
}

void breakpoint()
{
  raise(SIGTRAP);
}

/**
 * Normalize a D type by removing any trailing "_t" and converting to SnakeCase.
 * Params:
 *   typeStr = The D type string to normalize
 * Returns: Normalized D type string
 */
dstring normalizeDTypeName(dstring typeStr)
{
  return (typeStr.endsWith("_t") ? typeStr[0 .. $ - 2] : typeStr).camelCase(true);
}

/**
 * Changes snake or kabob case to camelCase.
 * Params:
 *   snakeCase = snake_case string
 * Returns: camelCase string
 */
dstring camelCase(dstring snakeCase, bool firstUpper = false)
{
  dstring camelStr;
  bool upperNext = firstUpper;
  ulong lastPos;

  foreach (i, c; snakeCase)
  {
    if (c == '_' || c == '-')
    {
      upperNext = true;
      camelStr ~= snakeCase[lastPos .. i];
      lastPos = i + 1;
    }
    else if (upperNext)
    {
      upperNext = false;
      camelStr ~= c.toUpper;
      lastPos = i + 1;
    }
  }

  if (lastPos == 0)
    return snakeCase;

  if (lastPos < snakeCase.length)
    camelStr ~= snakeCase[lastPos .. $];

  return camelStr;
}

unittest
{
  assert("i_am_snake".camelCase.equal("iAmSnake"));
  assert("i_am__snake".camelCase.equal("iAmSnake"));
  assert("_i_am__snake_".camelCase.equal("IAmSnake"));
  assert("i_am__snake".camelCase(true).equal("IAmSnake"));
  assert("i-am-kabob".camelCase.equal("iAmKabob"));
  assert("i-am--kabob".camelCase.equal("iAmKabob"));
  assert("-i-am--kabob-".camelCase.equal("IAmKabob"));
  assert("i-am--kabob".camelCase(true).equal("IAmKabob"));
  assert("i_am_snake-kabob".camelCase.equal("iAmSnakeKabob"));
  assert("blah".camelCase().equal("blah"));
  assert("blah".camelCase(true).equal("Blah"));
}

/**
 * Tokenize a type string into words and '*' pointers
 * Params:
 *   type = The type string
 * Returns: 
 */
dstring[] tokenizeType(dstring type)
{
  dstring[] tokens;
  ulong lastStart;

  foreach (i, c; type)
  {
    if (c.among('*', ' ', '(', ')'))
    {
      if (lastStart < i)
        tokens ~= type[lastStart .. i];

      if (c != ' ')
        tokens ~= [c];

      lastStart = i + 1;
    }
  }

  if (lastStart < type.length)
    tokens ~= type[lastStart .. $];

  return tokens;
}

unittest
{
  assert(" const  char  * ".tokenizeType.equal(["const"d, "char", "*"]));
  assert(" const  (char)  *  *".tokenizeType.equal(["const"d, "(", "char", ")", "*", "*"]));
  assert("const char**".tokenizeType.equal(["const"d, "char", "*", "*"]));
  assert("const char".tokenizeType.equal(["const"d, "char"]));
}

/**
 * Strip "const" and parenthesis from a type.
 * Params:
 *   type = The type string
 * Returns: Type string with all "const" and parenthesis stripped out
 */
dstring stripConst(dstring type)
{
  if (!type.startsWith("const")) // Optimization
    return type;

  return tokenizeType(type).filter!(x => !x.among("const"d, "("d, ")"d)).join;
}

/**
 * Strip "const", parenthesis, and pointer '*' from a type.
 * Params:
 *   type = The type string
 * Returns: Type string with all "const" and parenthesis stripped out
 */
dstring stripConstPtr(dstring type)
{
  if (!type.startsWith("const")) // Optimization
    return type;

  return tokenizeType(type).filter!(x => !x.among("const"d, "("d, ")"d, "*"d)).join;
}

/**
 * Split a string by whitespace with double quoted substring support.
 * Params:
 *   s = The string to split
 * Returns: A splitter range of the tokenized strings
 */
auto splitQuoted(dstring s)
{
  dchar quoteChar = 0;

  bool doSplit(dchar c)
  {
    if (!quoteChar)
    {
      if (c == '"' || c == '\'')
      {
        quoteChar = c;
        return true;
      }

      return c.isWhite;
    }
    else if (c == quoteChar)
    {
      quoteChar = 0;
      return true;
    }

    return false;
  }

  return splitter!(doSplit)(s).filter!(x => !x.empty);
}

unittest
{
  assert(splitQuoted("a b c  d").equal(["a"d, "b", "c", "d"]));
  assert(splitQuoted("a \"double quoted value\"\t b c  d").equal([
    "a"d, "double quoted value", "b", "c", "d"
  ]));
  assert(splitQuoted("a 'single quoted value'\t b c  d").equal([
    "a"d, "single quoted value", "b", "c", "d"
  ]));
  assert(splitQuoted("a'single quoted value'\tb c  d").equal([
    "a"d, "single quoted value", "b", "c", "d"
  ]));
}

/**
 * Check if a string matches a given pattern with * wildcards.
 * Params:
 *   str = The string to match
 *   pattern = The pattern with * wildcard matching
 * Returns: true if str matches pattern, false otherwise.
 */
bool matchWild(dstring str, dstring pattern)
{
  dstring[] matches = pattern.split('*');

  if (matches.length <= 1) // No wildcards?
    return str == pattern;

  if (!matches[0].empty) // Pattern does not start with wildcard?
  {
    if (!str.startsWith(matches[0]))
      return false;

    str = str[matches[1].length .. $];
    matches = matches[1 .. $];
  }

  while (matches.length > 0)
  {
    if (matches.length == 1 && matches[0].empty) // Wildcard at end of pattern?
      return true;

    auto ndx = str.countUntil(matches[0]);

    if (ndx == -1)
      return false;

    str = str[ndx + matches[0].length .. $];
    matches = matches[1 .. $];
  }

  return str.empty;
}

unittest
{
  assert(matchWild("Hello Beautiful World", "Hello Beautiful World"));
  assert(matchWild("Hello Beautiful World", "Hello*"));
  assert(matchWild("Hello Beautiful World", "*World"));
  assert(matchWild("Hello Beautiful World", "Hello*World"));
  assert(matchWild("Hello Beautiful World", "*Beautiful*"));
  assert(matchWild("Hello Beautiful World", "*Hello*World*"));

  assert(!matchWild("Hello Beautiful World", "Hello"));
  assert(!matchWild("Hello Beautiful World", "*Hello"));
  assert(!matchWild("Hello Beautiful World", "Help*"));
  assert(!matchWild("Hello Beautiful World", "Hello*Full"));
}

/**
 * Count the number of stars at the end of a type string.
 * Params:
 *   type = The type string
 * Returns: Number of stars '*' on the end of the string
 */
int countStars(dstring type)
{
  auto count = type.retro
    .filter!(x => x != ')')
    .countUntil!(x => x != '*');
  return count > 0 ? cast(int)count : 0;
}
