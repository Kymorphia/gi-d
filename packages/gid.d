module gid;

import core.exception : OutOfMemoryError;
import core.memory : GC;
import core.stdc.stdlib : free, malloc;
import core.stdc.string : memset, strlen;
import std.string : toStringz;
public import std.typecons : Flag, No, Yes;

/// Container ownership
enum GidOwnership
{
  None, /// No ownership transfer
  Container, /// Owns container
  Full, /// Owns container and the items in it
}

/**
 * Prevent the garbage collector from freeing or moving a memory region.
 * Necessary when passing data to C which might not have any remaining pointers to it in D heap memory.
 * Params:
 *   ptr = Pointer to anywhere inside the region to prevent collection/move of
 */
void ptrFreezeGC(const void* ptr)
{
  GC.addRoot(ptr);
  GC.setAttr(ptr, GC.BlkAttr.NO_MOVE);
}

/**
 * Re-enable garbage collection and moving of a memory region which was frozen by ptrFreezeGC().
 * Params:
 *   ptr = Pointer to anywhere inside the region to re-enable garbage collection of
 */
void ptrThawGC(const void* ptr)
{
  GC.removeRoot(ptr);
  GC.clrAttr(ptr, GC.BlkAttr.NO_MOVE);
}

/**
 * GDestroyNotify callback which can be used to re-enable garbage collection and moving for a memory region frozen by ptrFreezeGC().
 * Params:
 *   ptr = The data to re-enable garbage collection and moving of.
 */
extern(C) void ptrThawDestroyNotify(void* ptr)
{
  GC.removeRoot(ptr);
  GC.clrAttr(ptr, GC.BlkAttr.NO_MOVE);
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
 * Zero a memory area.
 * Params:
 *   p = Pointer to the memory area
 *   len = Length in bytes of memory area
 */
void zero(void* p, size_t len)
{
  memset(p, 0, len);
}

/**
 * Template to copy a D array for use by C.
 * Params:
 *   T = The array type
 *   malloc = Yes.Malloc to use C malloc() to allocate the array, No to use D memory (defaults to No)
 *   zeroTerm = Yes.ZeroTerminated if the resulting array should be zero terminated (defaults to No)
 *   array = The array to copy
 * Returns: C array or null if array is empty
 */
T* arrayDtoC(T, Flag!"Malloc" malloc = No.Malloc, Flag!"ZeroTerm" zeroTerm = No.ZeroTerm)(T[] array)
{
  if (array.length == 0)
    return null;

  T* retArray;

  static if (malloc)
  {
    static if (zeroTerm)
    {
      retArray = cast(T*)g_malloc_n(array.length + 1, T.sizeof);
      zero(cast(void*)&retArray[array.length], T.sizeof);
    }
    else
      retArray = cast(T*)g_malloc_n(array.length, T.sizeof);
  }
  else // No.Malloc, local D allocation
  {
    static if (zeroTerm)
    {
      retArray = new T[array.length + 1].ptr;
      zero(&retArray[array.length], T.sizeof);
    }
    else
      retArray = new T[array.length].ptr;
  }

  static if (hasMember!(T, "cPtrRef"))
  {
    foreach(i, elem; array)
      retArray[i] = elem.cPtrRef;
  }
  else static if (is(T : string))
  {
    foreach(i, elem; array)
      retarray[i] = toCString(array[i], malloc);
  }
  else
    retArray[0 .. array.length] = array[0 .. $];

  return retArray;
}

/// Exception class used for ObjectG constructor errors
class GidConstructException : Exception
{
  this(string msg)
  {
    super(msg);
  }
}
