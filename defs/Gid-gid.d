//!kind gid Namespace

import core.exception : OutOfMemoryError;
import core.memory : GC;
import core.stdc.string : memset, strlen;
import std.conv : to;
import std.string : toStringz;
import std.traits : hasMember, isScalarType;
public import std.typecons : Flag, No, Yes;

import GLib.Boxed;
import GLib.c.functions;
import GLib.c.types;
import GObject.ObjectG;
import GObject.c.functions;

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

  if (!GC.inFinalizer)
    GC.clrAttr(ptr, GC.BlkAttr.NO_MOVE); // FIXME - This call fails with an core.exception.InvalidMemoryOperationError if called during finalization, should removeRoot also not be called?
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
 * Freeze a delegate to C heap memory and pin the context in the GC.
 * Params:
 *   dlg = Pointer to the delegate to freeze
 * Returns: The duplicated delegate in C heap memory
 */
void* freezeDelegate(void* dlg)
{
  auto dlgCast = cast(void delegate()*)dlg;
  ptrFreezeGC(dlgCast.ptr);
  return g_memdup2(dlg, (*dlgCast).sizeof);
}

/**
 * Destroy a C heap memory allocated duplicated delegate and unpin context in the GC which was created with freezeDelegate().
 * Params:
 *   dlg = The C heap memory allocated delegate
 */
extern(C) void thawDelegate(void* dlg)
{
  ptrThawGC((cast(void delegate()*)dlg).ptr);
  safeFree(dlg);
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
  if (dstr is null)
    return null;

  if (transfer)
  {
    char* cstr = cast(char*)g_try_malloc(dstr.length + 1);

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

  if (auto dup = cast(char*)g_try_malloc(len))
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
      retArray = cast(T*)g_try_malloc((array.length + 1) * T.sizeof);

      if (retArray)
        zero(cast(void*)&retArray[array.length], T.sizeof);
    }
    else
      retArray = cast(T*)g_try_malloc(array.length * T.sizeof);

    if (!retArray)
      throw new OutOfMemoryError;
  }
  else // No.Malloc, local D allocation
  {
    static if (zeroTerm)
    {
      retArray = new T[array.length + 1].ptr;
      zero(&retArray[array.length], T.sizeof); // Zero terminate
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
 * Convert a GLib GByteArray to a D array.
 * Params:
 *   ownership = The ownership of the GArray, None (default): do nothing with it, Container: free container only, Full: unref
 *   gByteArray = The GArray instance
 * Returns: D array of the given type
 */
ubyte[] gByteArrayToD(GidOwnership ownership = GidOwnership.None)(GByteArray* gByteArray)
{
  ubyte[] a;

  if (!gByteArray)
    return a;

  a.length = gByteArray.len;
  a[0 .. $] = gByteArray.data[0 .. gByteArray.len];

  static if (ownership == GidOwnership.Full)
    g_byte_array_unref(gByteArray);
  else static if (ownership == GidOwnership.Container)
    g_byte_array_free(gByteArray, false); // Don't free the data (container only)

  return a;
}

/**
 * Convert a GLib GBytes to a D array.
 * Params:
 *   ownership = The ownership of the GBytes, None (default): do nothing with it, Container/Full: unref
 *   gBytes = The GBytes instance
 * Returns: D array of the given type
 */
ubyte[] gBytesToD(GidOwnership ownership = GidOwnership.None)(GBytes* gBytes)
{
  ubyte[] a;

  if (!gBytes)
    return a;

  a.length = g_bytes_get_size(gBytes);
  a[0 .. $] = (cast(ubyte*)g_bytes_get_data(gBytes, null))[0 .. a.length];

  static if (ownership != GidOwnership.None)
    g_bytes_unref(gBytes);

  return a;
}

/**
 * Convert a GLib GArray to a D array.
 * Params:
 *   T = The type of elements in the array
 *   ownership = The ownership of the GArray, None (default): do nothing with it, Container: free container only, Full: unref
 *   gArray = The GArray instance
 * Returns: D array of the given type
 */
T[] gArrayToD(T, GidOwnership ownership = GidOwnership.None)(GArray* gArray)
  if (containerTypeIsSupported!T)
{
  T[] a;

  if (!gArray)
    return a;

  assert(g_array_get_element_size(gArray) == containerTypeSize!T,
    "GArray element size " ~ g_array_get_element_size(gArray).to!string ~ " not equal to type " ~ T.stringof);

  a.length = gArray.len;

  static if (!containerTypeIsSimple!T && !is(T == void*) && !is(T == const(void)*))
    foreach (i; 0 .. gArray.len)
      a[i] = containerGetItem!T((cast(void**)gArray.data)[i]);
  else
    a[0 .. $] = (cast(T*)gArray.data)[0 .. gArray.len];

  static if (ownership == GidOwnership.Full)
    g_array_unref(gArray);
  else static if (ownership == GidOwnership.Container)
    g_array_free(gArray, false); // Don't free the data (container only)

  return a;
}

/**
 * Convert a GLib GPtrArray to a D array.
 * Params:
 *   T = The type of elements in the pointer array
 *   ownership = The ownership of the GPtrArray, None (default): do nothing with it, Container: free container only, Full: unref
 *   ptrArray = The pointer array instance
 * Returns: D array of the given type
 */
T[] gPtrArrayToD(T, GidOwnership ownership = GidOwnership.None)(GPtrArray* ptrArray)
  if (containerTypeIsSupported!T && !containerTypeIsSimple!T)
{
  T[] a;

  if (!ptrArray)
    return a;

  a.length = ptrArray.len;

  foreach (i; 0 .. ptrArray.len)
    a[i] = containerGetItem!T(ptrArray.pdata[i]);

  static if (ownership == GidOwnership.Full)
    g_ptr_array_unref(ptrArray);
  else static if (ownership == GidOwnership.Container)
    g_ptr_array_free(ptrArray, false); // Don't free the data (container only)

  return a;
}

/**
 * Convert a GLib GList to a D array.
 * Params:
 *   T = The type of elements in the list
 *   ownership = The ownership of the GList, None (default): do nothing with it, Container: free list only, Full: free list and items
 *   list = The list
 * Returns: D array of the given type
 */
T[] gListToD(T, GidOwnership ownership = GidOwnership.None)(GList* list)
  if (containerTypeIsSupported!T && !containerTypeIsSimple!T)
{
  T[] a;

  for (auto n = list; n; )
  {
    a.length++;
    a[$ - 1] = containerGetItem!T(n.data);

    static if (ownership == GidOwnership.Full && !is(T == void*) && !is(T == const(void)*))
      containerFreeItem!T(n.data);

    static if (ownership != GidOwnership.None)
    {
      auto tmp = n;
      n = g_list_remove_link(n, n);
      g_list_free_1(tmp);
    }
    else
      n = n.next;
  }

  return a;
}

/**
 * Convert a GLib GSList to a D array.
 * Params:
 *   T = The type of elements in the list
 *   ownership = The ownership of the GSList, None (default): do nothing with it, Container: free list only, Full: free list and items
 *   list = The list
 * Returns: D array of the given type
 */
T[] gSListToD(T, GidOwnership ownership = GidOwnership.None)(GSList* list)
  if (containerTypeIsSupported!T && !containerTypeIsSimple!T)
{
  T[] a;

  for (auto n = list; n; )
  {
    a.length++;
    a[$ - 1] = containerGetItem!T(n.data);

    static if (ownership == GidOwnership.Full && !is(T == void*) && !is(T == const(void)*))
      containerFreeItem!T(n.data);

    static if (ownership != GidOwnership.None)
    {
      auto tmp = n;
      n = g_slist_remove_link(n, n);
      g_slist_free_1(tmp);
    }
    else
      n = n.next;
  }

  return a;
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
V[K] gHashTableToD(K, V, GidOwnership ownership = GidOwnership.None)(GHashTable* hash)
  if ((is(K == string) || is(K == const(void)*))
    && (is(V : ObjectG) || is(V == interface) || is(V == string) || is(V == void*)))
{
  GHashTableIter iter;
  void* key;
  void* value;
  V[K] map;

  for (g_hash_table_iter_init(&iter, hash); g_hash_table_iter_next(&iter, &key, &value); )
    map[containerGetItem!K(key)] = containerGetItem!V(value);

  static if (ownership == GidOwnership.Container)
  {
    g_hash_table_steal_all(hash);
    g_hash_table_destroy(hash);
  }
  else static if (ownership == GidOwnership.Full)
    g_hash_table_unref(hash);

  return map;
}

/**
 * Template to convert a D ubyte array to a GByteArray for passing to C functions
 * Params:
 *   a = The D array
 * Returns: New GArray which should be freed with containerFree!() template (if ownership not taken by C code)
 */
GByteArray* gByteArrayFromD(ubyte[] a)
{
  auto gByteArray = g_byte_array_sized_new(cast(uint)a.length);

  if (a.length > 0)
    g_byte_array_append(gByteArray, a.ptr, cast(uint)a.length);

  return gByteArray;
}

/**
 * Template to convert a D ubyte array to a GBytes for passing to C functions
 * Params:
 *   a = The D array
 * Returns: New GBytes which should be freed with containerFree!() template (if ownership not taken by C code)
 */
GBytes* gBytesFromD(ubyte[] a)
{
  return g_bytes_new(cast(const(void)*)a.ptr, a.length);
}

/**
 * Template to convert a D array to a GArray for passing to C functions
 * Params:
 *   T = Type of the array values
 *   zeroTerminated = Set to true to enable zero termination in GArray (defaults to false)
 *   a = The D array
 * Returns: New GArray which should be freed with containerFree!() template (if ownership not taken by C code)
 */
GArray* gArrayFromD(T, bool zeroTerminated = false)(T[] a)
  if (containerTypeIsSupported!T)
{
  auto gArray = g_array_sized_new(zeroTerminated, false, containerTypeSize!T, cast(uint)a.length);

  static if (!containerTypeIsSimple!T && !is(T == void*) && !is(T == const(void)*))
  {
    extern(C) void clearFunc(void* elem)
    {
      containerFreeItem!T(*cast(void**)elem);
      *cast(void**)elem = null;
    }

    g_array_set_clear_func(gArray, &clearFunc);
    g_array_set_size(gArray, cast(uint)a.length);

    foreach (i; 0 .. a.length)
      containerSetItem(a[i], cast(void*)&gArray.data[i * containerTypeSize!T]);
  }
  else
    g_array_append_vals(gArray, a.ptr, cast(uint)a.length);

  return gArray;
}

/**
 * Template to convert a D array to a GPtrArray for passing to C functions
 * Params:
 *   T = Type of the array values
 *   zeroTerminated = Set to true to enable zero termination in GPtrArray (defaults to false)
 *   a = The D array
 * Returns: New GPtrArray which should be freed with containerFree!() template (if ownership not taken by C code)
 */
GPtrArray* gPtrArrayFromD(T, bool zeroTerminated = false)(T[] a)
  if (containerTypeIsSupported!T && !containerTypeIsSimple!T)
{
  auto gPtrArray = g_ptr_array_new();

  static if (!is(T == void*) && !is(T == const(void)*))
  {
    extern(C) void clearFunc(void* elem)
    {
      containerFreeItem!T(elem);
    }

    g_ptr_array_set_free_func(gPtrArray, &clearFunc);
  }

  g_ptr_array_set_size(gPtrArray, cast(int)a.length);

  foreach (i; 0 .. a.length)
    containerSetItem(a[i], cast(void*)&gPtrArray.pdata[i]);

  return gPtrArray;
}

/**
 * Template to convert a D array to a GList for passing to C functions
 * Params:
 *   T = Type of the array values
 *   a = The D array
 * Returns: New GList which should be freed with containerFree!() template (if ownership not taken by C code)
 */
GList* gListFromD(T)(T[] a)
  if (containerTypeIsSupported!T && !containerTypeIsSimple!T)
{
  GList* list;

  foreach (i; 0 .. a.length)
  {
    list = g_list_prepend(list, null);
    containerSetItem(a[i], cast(void*)&list.data);
  }

  return g_list_reverse(list); // Prepend and reverse for optimization purposes
}

/**
 * Template to convert a D array to a GSList for passing to C functions
 * Params:
 *   T = Type of the array values
 *   zeroTerminated = Set to true to enable zero termination in GArray (defaults to false)
 *   a = The D array
 * Returns: New GSList which should be freed with containerFree!() template (if ownership not taken by C code)
 */
GSList* gSListFromD(T)(T[] a)
  if (containerTypeIsSupported!T && !containerTypeIsSimple!T)
{
  GSList* list;

  foreach (i; 0 .. a.length)
  {
    list = g_slist_prepend(list, null);
    containerSetItem(a[i], cast(void*)&list.data);
  }

  return g_slist_reverse(list); // Prepend and reverse for optimization purposes
}

/**
 * Convert a D map to a GHashTable.
 * Params:
 *   K = The key type
 *   V = The value type
 *   map = The D map
 * Returns: A newly allocated GHashTable.
 */
GHashTable* gHashTableFromD(K, V)(V[K] map)
  if ((is(K == string) || is(K == const(void)*))
    && (is(V : ObjectG) || is(V == interface) || is(V == string) || is(V == void*)))
{
  GDestroyNotify valDestroyFunc;

  static if (is(V : ObjectG) || is(T == interface))
    valDestroyFunc = cast(GDestroyNotify)g_object_unref;
  else static if (is(V : string))
    valDestroyFunc = g_free;

  GHashTable* hash;

  static if (is(K : string))
    hash = g_hash_table_new_full(g_str_hash, g_str_equal, g_free, valDestroyFunc);
  else
    hash = g_hash_table_new_full(g_direct_hash, g_direct_equal, null, valDestroyFunc);

  foreach (k, v; map)
  {
    void* keyptr;
    void* valptr;

    containerSetItem!K(k, &keyptr);
    containerSetItem!V(v, &valptr);
    g_hash_table_insert(hash, keyptr, valptr);
  }

  return hash;
}

/**
 * Check if a type is a Boxed or Reffed type
 * Params:
 *   T = Type to check
 * Returns: true if type is a boxed or reffed type
 */
bool isTypeBoxedOrReffed(T)()
{
  return __traits(compiles, {auto c = new T(cast(void*)null, false); c.cPtr(false);});
}

/**
 * Check if a type is supported for the purpose of transforming between C and D containers
 * Params:
 *   T = The type to check
 * Returns: true if the type can be used for container C to/from D transformation
 */
bool containerTypeIsSupported(T)()
{
  return is(T : ObjectG) || is(T == interface) || is(T == string) || isTypeBoxedOrReffed!T || containerTypeIsSimple!T
    || is(T == void*) || is(T == const(void)*);
}

/**
 * Check if a type is considered a simple container type (can be copied directly)
 * Params:
 *   T = The D type to check
 * Returns: bool if type is considered simple
 */
bool containerTypeIsSimple(T)()
{
  return isScalarType!T || is(T == struct) || is(T == union);
}

/**
 * Get the size required for the type of an element for a container.
 * Params:
 *   T = The type
 * Returns: The element size in bytes
 */
uint containerTypeSize(T)()
  if (containerTypeIsSupported!T)
{
  static if (containerTypeIsSimple!T)
    return T.sizeof;
  else
    return (void*).sizeof;
}

/**
 * Free a GLib container type.
 * Params:
 *   CT = The C struct type pointer of the container type
 *   T = The type of the item stored in the container
 *   ownership = The ownership of the container from the perspective of a called C function
 *     (None is the default and frees container and items, Container frees only the container, Full does nothing)
 *   container = The GLib C container pointer
 */
void containerFree(CT, T, GidOwnership ownership = GidOwnership.None)(CT container)
{
  static if (ownership == GidOwnership.Full)
    return;

  static if (is(CT == GByteArray*))
  {
    if (ownership == GidOwnership.None)
      g_byte_array_unref(container);
    else // GidOwnership.Container
      g_byte_array_free(container, false);
  }
  else static if (is(CT == GBytes*))
  {
    if (ownership != GidOwnership.None)
      g_bytes_unref(container);
  }
  else static if (is(CT == GArray*))
  {
    if (ownership == GidOwnership.None)
      g_array_unref(container);
    else // GidOwnership.Container
      g_array_free(container, false);
  }
  else static if (is(CT == GPtrArray*))
  {
    if (ownership == GidOwnership.None)
      g_ptr_array_unref(container);
    else // GidOwnership.Container
      g_ptr_array_free(container, false);
  }
  else static if (is(CT == GList*))
  {
    static if (ownership == GidOwnership.None)
    {
      for (auto n = container; n; )
      {
        auto tmp = n;
        n = n.next;
        containerFreeItem!T(n.data);
        g_list_free_1(n);
      }
    }
    else
      g_list_free(container);
  }
  else static if (is(CT == GSList*))
  {
    static if (ownership == GidOwnership.None)
    {
      for (auto n = container; n; )
      {
        auto tmp = n;
        n = n.next;
        containerFreeItem!T(n.data);
        g_slist_free_1(n);
      }
    }
    else
      g_slist_free(container);
  }
  else static if (is(CT == GHashTable*))
  {
    static if (ownership == GidOwnership.Container)
      g_hash_table_steal_all(container);

    g_hash_table_destroy(container);
  }
  else
    assert(0, "containerFree: unsupported container type " ~ CT.stringof);
}

/**
* Template to get a D value from a container C data item. Used internally for transforming C containers.
* Params:
*   T = The D item type
*   data = The container C data pointer
* Returns: The D item which is a copy of the C item
*/
T containerGetItem(T)(void* data)
  if (containerTypeIsSupported!T)
{
  static if (is(T : ObjectG) || is(T == interface))
    return ObjectG.getDObject!T(data, false);
  else static if (is(T == string))
    return fromCString(cast(const(char)*)data, false);
  else static if (isTypeBoxedOrReffed!T)
    return new T(data, false);
  else static if (is(T == void*) || is(T == const(void)*))
    return data;
  else static if (containerTypeIsSimple!T)
    return *(cast(T*)data);
  else
    assert(0);
}

/**
* Template to set a C container item from a D value. Used internally for transforming C containers.
* Params:
*   T = The D item type
*   data = The container C data pointer
*/
void containerSetItem(T)(T val, void* data)
  if (containerTypeIsSupported!T)
{
  static if (is(T : ObjectG) || isTypeBoxedOrReffed!T)
    *(cast(void**)data) = val.cPtr(true);
  else static if (is(T == interface))
  {
    if (auto objG = cast(ObjectG)val)
      *(cast(void**)data) = objG.cPtr(true);
    else
      assert(0, "Object implementing " ~ T.stringof ~ " interface is not an ObjectG");
  }
  else static if (is(T == string))
    *cast(char**)data = toCString(val, true); // Transfer the string to C (use g_malloc)
  else static if (is(T == void*) || is(T == const(void)*))
    *(cast(void**)data) = cast(void*)val;
  else static if (containerTypeIsSimple!T)
    *(cast(T*)data) = val;
  else
    assert(0);
}

/**
 * Free a container C item. Used internally for binding containers.
 * Does nothing if the type does not need to be freed.
 * Params:
 *   T = The D item type
 *   data = The container C data pointer
 */
void containerFreeItem(T)(void* data)
  if (containerTypeIsSupported!T)
{
  static if (is(T : ObjectG) || is(T == interface))
    ObjectG.unref(data);
  else static if (is(T : Boxed))
    Boxed.boxedFree!T(data);
  else static if (__traits(compiles, T.unref(data))) // Reffed types
    T.unref(data);
  else static if (is(T : string))
    g_free(data);
}

/// Exception class used for ObjectG constructor errors
class GidConstructException : Exception
{
  this(string msg)
  {
    super(msg);
  }
}
