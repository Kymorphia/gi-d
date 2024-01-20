module utils;

public import std_includes;

/**
 * Changes snake case to camelCase.
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
    if (c == '_')
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
  assert(" const  char  * ".tokenizeType.equal(["const"d,"char","*"]));
  assert(" const  (char)  *  *".tokenizeType.equal(["const"d,"(","char",")","*", "*"]));
  assert("const char**".tokenizeType.equal(["const"d,"char","*","*"]));
}

/**
 * Split a string by whitespace with double quoted substring support.
 * Params:
 *   s = The string to split
 * Returns: A splitter range of the tokenized strings
 */
auto splitQuoted(dstring s)
{
  bool inQuoted;

  bool doSplit(dchar c)
  {
    bool retval = c == '"' || (!inQuoted && c.isWhite);

    if (c == '"')
      inQuoted = !inQuoted;

    return retval;
  }

  return splitter!(doSplit)(s).filter!(x => !x.empty);
}

unittest
{
  assert(splitQuoted("a b c  d").equal(["a"d, "b", "c", "d"]));
  assert(splitQuoted("a \"quoted value\"\t b c  d").equal(["a"d, "quoted value", "b", "c", "d"]));
}
