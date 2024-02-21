module gid;

import core.exception : OutOfMemoryError;
import core.stdc.stdlib : free, malloc;
import core.stdc.string : strlen;
import std.string : toStringz;
public import std.typecons : BitFlags, Yes;

/// Container ownership
enum GidOwnership
{
  None, /// No ownership transfer
  Container, /// Owns container
  Full, /// Owns container and the items in it
}

/**
 * Convert a D string to a zero terminated C string, with allocation parameter.
 * Params:
 *   dstr = String to convert
 *   transfer = true if string is being transferred to C (use g_malloc), false for D allocation (no transfer)
 * Returns: Zero terminated C string (D or C allocation)
 */
char* toCString(string dstr, bool transfer)
{
  if (dstr == null)
    return null;

  if (transfer)
  {
    char* cstr = cast(char*)malloc(dstr.length + 1);

    if (!cstr)
      throw new OutOfMemoryError();

    cstr[0 .. dstr.length] = dstr[];
    cstr[dstr.length] = '\0';
    return cstr;
  }

  return cast(char*)dstr.toStringz;
}

/**
 * Convert a C string to a D string, with parameter to consume (free) the C string with g_free().
 * Params:
 *   cstr = Zero terminated C string
 *   transfer = true to transfer the string (free it with g_free()), false to just copy it
 * Returns: The D string copy
 */
string fromCString(const(char)* cstr, bool transfer)
{
  if (!cstr)
    return null;

  string dstr = cstr[0 .. strlen(cstr)].dup;

  if (transfer)
    free(cast(void*)cstr);

  return dstr;
}

/// Exception class used for ObjectG constructor errors
class GidConstructException : Exception
{
  this(string msg)
  {
    super(msg);
  }
}
