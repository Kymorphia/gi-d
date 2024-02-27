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
 *   transfer = true to transfer the string (freed with g_free()), false to just copy it
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

/**
 * Template to get a D item from a container C data item. Used internally for binding containers.
 * Params:
 *   T = The D item type
 *   data = The container C data pointer
 * Returns: The D item which is a copy of the C item
 */
T containerGetItem(T)(void* data)
  if (is(T : string) || is(T : void*))
{
  static if (is(T : string))
    return fromCString(data, false);
  else static if (is(T : void*))
    return data;
}

/**
 * Template to copy a container C item to another C item. Used internally for binding containers.
 * Params:
 *   T = The D item type
 *   data = The container C data pointer
 * Returns: A copy of the C item
 */
void* containerCopyItem(T)(void* data)
  if (is(T : string) || is(T : void*))
{
  static if (is(T : string))
    return g_strdup(cast(const(char)*)data);
  else static if (is(T : void*))
    return data;
}

/**
 * Free a container C item. Used internally for binding containers.
 * Params:
 *   T = The D item type
 *   data = The container C data pointer
 */
void containerFreeItem(T)(void* data)
  if (is(T : string) || is(T : void*))
{
  static if (is(T : string))
    g_free(data);
  else static if (is(T : void*))
  {
  }
}

/// Exception class used for ObjectG constructor errors
class GidConstructException : Exception
{
  this(string msg)
  {
    super(msg);
  }
}
