module GLib.Bytes;

import GLib.Boxed;
import GLib.ByteArray;
import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.Gid;

/**
 * A simple refcounted data type representing an immutable sequence of zero or
 * more bytes from an unspecified origin.
 *
 * The purpose of a #GBytes is to keep the memory region that it holds
 * alive for as long as anyone holds a reference to the bytes.  When
 * the last reference count is dropped, the memory is released. Multiple
 * unrelated callers can use byte data in the #GBytes without coordinating
 * their activities, resting assured that the byte data will not change or
 * move while they hold a reference.
 *
 * A #GBytes can come from many different origins that may have
 * different procedures for freeing the memory region.  Examples are
 * memory from g_malloc(), from memory slices, from a #GMappedFile or
 * memory from other allocators.
 *
 * #GBytes work well as keys in #GHashTable. Use g_bytes_equal() and
 * g_bytes_hash() as parameters to g_hash_table_new() or g_hash_table_new_full().
 * #GBytes can also be used as keys in a #GTree by passing the g_bytes_compare()
 * function to g_tree_new().
 *
 * The data pointed to by this bytes must not be modified. For a mutable
 * array of bytes see #GByteArray. Use g_bytes_unref_to_array() to create a
 * mutable array for a #GBytes sequence. To create an immutable #GBytes from
 * a mutable #GByteArray, use the g_byte_array_free_to_bytes() function.
 */
class Bytes : Boxed
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  T* cPtr(T)(bool makeCopy = false)
  if (is(T == GBytes))
  {
    return makeCopy ? copy_!T : cast(T*)cInstancePtr;
  }

  static GType getType()
  {
    return g_bytes_get_type();
  }

  /**
   * a new #GBytes
   */
  this(ubyte[] data)
  {
    GBytes* _cretval;
    auto _data = cast(const(void)*)data.ptr;
    _cretval = g_bytes_new(_data, data ? cast(size_t)data.length : 0);
    this(_cretval, true);
  }

  /**
   * a negative value if @bytes1 is less than @bytes2, a positive value
   * if @bytes1 is greater than @bytes2, and zero if @bytes1 is equal to
   * @bytes2
   */
  int compare(Bytes bytes2)
  {
    int _retval;
    _retval = g_bytes_compare(cPtr!GBytes, bytes2 ? bytes2.cPtr!GBytes : null);
    return _retval;
  }

  /**
   * %TRUE if the two keys match.
   */
  bool equal(Bytes bytes2)
  {
    bool _retval;
    _retval = g_bytes_equal(cPtr!GBytes, bytes2 ? bytes2.cPtr!GBytes : null);
    return _retval;
  }

  /**
   * a pointer to the byte data, or %NULL
   */
  ubyte[] getData()
  {
    const(void)* _cretval;
    size_t _cretlength;
    _cretval = g_bytes_get_data(cPtr!GBytes, &_cretlength);
    ubyte[] _retval;

    if (_cretval)
    {
      _retval = cast(ubyte[] )_cretval[0 .. _cretlength];
    }
    return _retval;
  }

  /**
   * the requested region, or %NULL in case of an error
   */
  const(void)* getRegion(size_t elementSize, size_t offset, size_t nElements)
  {
    const(void)* _retval;
    _retval = g_bytes_get_region(cPtr!GBytes, elementSize, offset, nElements);
    return _retval;
  }

  /**
   * the size
   */
  size_t getSize()
  {
    size_t _retval;
    _retval = g_bytes_get_size(cPtr!GBytes);
    return _retval;
  }

  /**
   * a hash value corresponding to the key.
   */
  uint hash()
  {
    uint _retval;
    _retval = g_bytes_hash(cPtr!GBytes);
    return _retval;
  }

  /**
   * a new #GBytes
   */
  Bytes newFromBytes(size_t offset, size_t length)
  {
    GBytes* _cretval;
    _cretval = g_bytes_new_from_bytes(cPtr!GBytes, offset, length);
    Bytes _retval = new Bytes(cast(GBytes*)_cretval, true);
    return _retval;
  }

  /**
   * a new mutable #GByteArray containing the same byte data
   */
  ByteArray unrefToArray()
  {
    GByteArray* _cretval;
    _cretval = g_bytes_unref_to_array(cPtr!GBytes);
    ByteArray _retval = _cretval ? new ByteArray(_cretval) : null;
    return _retval;
  }

  /**
   * a pointer to the same byte data, which should be
   * freed with g_free()
   */
  ubyte[] unrefToData()
  {
    void* _cretval;
    size_t _cretlength;
    _cretval = g_bytes_unref_to_data(cPtr!GBytes, &_cretlength);
    ubyte[] _retval;

    if (_cretval)
    {
      _retval = cast(ubyte[] )_cretval[0 .. _cretlength];
    }
    return _retval;
  }
}
