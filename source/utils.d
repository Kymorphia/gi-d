module utils;

import std.string : toUpper;

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
