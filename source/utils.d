module utils;

import std_includes;

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
