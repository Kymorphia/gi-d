//!kind gid Namespace

import core.exception : OutOfMemoryError;
import core.memory : GC;
import core.stdc.string : memset, strlen;
import std.string : toStringz;
import std.traits : hasMember;
public import std.typecons : Flag, No, Yes;

import GLib.Boxed;
import GLib.c.functions;
import GLib.c.types;
import GObject.ObjectG;

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
    char* cstr = cast(char*)g_malloc(dstr.length + 1);

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

  if (transfer && cstr)
    g_free(cast(void*)cstr);

  return dstr;
}

/**
 * An alias for g_malloc0 for allocating memory for interfacing with glib.
 */
alias safeMalloc = g_malloc0;

/**
 * Free a pointer allocated with malloc() but only if it is not null.
 */
alias safeFree = g_free;

/**
 * Duplicate a zero terminate C string.
 * Params:
 *   s = The zero terminated string to duplicate
 * Returns: The duplicate string
 * Throws: OutOfMemoryError
 */
char* strdup(const(char)* s)
{
  if (!s)
    return null;

  auto len = strlen(s);

  if (auto dup = cast(char*)g_malloc(len))
  {
    dup[0 .. len] = s[0 .. len];
    return dup;
  }

  throw new OutOfMemoryError;
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
 *   useMalloc = Yes.UseMalloc to use g_malloc() to allocate the array, No to use D memory (defaults to No)
 *   zeroTerm = Yes.ZeroTerminated if the resulting array should be zero terminated (defaults to No)
 *   array = The array to copy
 * Returns: C array or null if array is empty
 */
T* arrayDtoC(T, Flag!"UseMalloc" useMalloc = No.UseMalloc, Flag!"ZeroTerm" zeroTerm = No.ZeroTerm)(T[] array)
{
  if (array.length == 0)
    return null;

  T* retArray;

  static if (useMalloc)
  {
    static if (zeroTerm)
    {
      retArray = cast(T*)g_malloc((array.length + 1) * T.sizeof);

      if (retArray)
        zero(cast(void*)&retArray[array.length], T.sizeof);
    }
    else
      retArray = cast(T*)g_malloc(array.length * T.sizeof);

    if (!retArray)
      throw new OutOfMemoryError;
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
    retarray[i] = toCString(array[i], useMalloc);
  }
  else
    retArray[0 .. array.length] = array[0 .. $];

  return retArray;
}

/**
 * Template to convert a GHashTable to a D associative array.
 *   `K`: The key D type
 *   `V`: The value D type
 *   `owned`: Set to true if caller takes ownership of hash (frees it), false to leave it alone (default)
 * Params:
 *   hash = The hash table to convert
 * Returns: The D associative array which is a copy of the data in hash
 */
V[K] hashTableToMap(K, V, bool owned = false)(GHashTable* hash)
{
  GHashTableIter iter;
  void* key;
  void* value;
  V[K] map;

  for (g_hash_table_iter_init(&iter, hash); g_hash_table_iter_next(&iter, &key, &value); )
    map[containerGetItem!K(key)] = containerGetItem!V(value);

  static if (owned)
    g_hash_table_unref(hash);

  return map;
}

/**
 * Convert a D map to a GHashTable.
 * Params:
 *   K = The key type
 *   V = The value type
 *   map = The D map
 * Returns: A newly allocated GHashTable.
 */
GHashTable* mapToHashTable(K, V)(V[K] map)
{
  GDestroyNotify valDestroyFunc;

  static if (is(V : ObjectG))
    valDestroyFunc = g_object_unref;
  else static if (is(V : string))
    valDestroyFunc = g_free;

  static if (is(K : string))
    g_hash_table_new_full(g_str_hash, g_str_equal, g_free, valDestroyFunc);
  else
    g_hash_table_new_full(g_direct_hash, g_direct_equal, null, valDestroyFunc);
}

/**
* Template to get a D item from a container C data item. Used internally for binding containers.
* Params:
*   T = The D item type
*   data = The container C data pointer
* Returns: The D item which is a copy of the C item
*/
T containerGetItem(T)(void* data)
{
  static if (is(T : ObjectG) || is(T == interface) || is(T : Boxed))
    return ObjectG.getDObject!T(data, false);
  else static if (is(T : string))
    return fromCString(cast(const(char)*)data, false);
  else static if (__traits(compiles, new T(data, false)))
    return new T(data, false);
  else static if (is(T : void*))
    return data;
  else
    assert(0);
}

/**
 * Template to copy a container C item to another C item. Used internally for binding containers.
 * Params:
 *   T = The D item type
 *   data = The container C data pointer
 * Returns: A copy of the C item
 */
void* containerCopyItem(T)(void* data)
{
  if (!data)
    return null;

  static if (is(T : ObjectG) || is(T == interface))
    return ObjectG.ref_(data);
  else static if (is(T : Boxed))
    return Boxed.boxedCopy!T(data);
  else static if (is(T : string))
    return strdup(cast(const(char)*)data);
  else static if (__traits(compiles, T.ref_(data)))
    return T.ref_(data);
  else static if (is(T : void*))
    return data;
  else
    assert(0);
}

/**
 * Free a container C item. Used internally for binding containers.
 * Params:
 *   T = The D item type
 *   data = The container C data pointer
 */
void containerFreeItem(T)(void* data)
{
  static if (is(T : ObjectG) || is(T == interface))
    ObjectG.unref(data);
  else static if (is(T : Boxed))
    Boxed.boxedFree!T(data);
  else static if (is(T : string))
    g_free(data);
  else static if (__traits(compiles, T.unref(data)))
    T.unref(data);
  else static if (is(T : void*))
  {
  }
  else
    assert(0);
}

/// Exception class used for ObjectG constructor errors
class GidConstructException : Exception
{
  this(string msg)
  {
    super(msg);
  }
}
