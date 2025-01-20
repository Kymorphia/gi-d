module GLib.Bytes;

import GLib.Boxed;
import GLib.ByteArray;
import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.gid;

/**
 * A simple refcounted data type representing an immutable sequence of zero or
 * more bytes from an unspecified origin.
 * The purpose of a #GBytes is to keep the memory region that it holds
 * alive for as long as anyone holds a reference to the bytes.  When
 * the last reference count is dropped, the memory is released. Multiple
 * unrelated callers can use byte data in the #GBytes without coordinating
 * their activities, resting assured that the byte data will not change or
 * move while they hold a reference.
 * A #GBytes can come from many different origins that may have
 * different procedures for freeing the memory region.  Examples are
 * memory from [GLib.Global.gmalloc], from memory slices, from a #GMappedFile or
 * memory from other allocators.
 * #GBytes work well as keys in #GHashTable. Use [GLib.Bytes.equal] and
 * [GLib.Bytes.hash] as parameters to [GLib.HashTable.new_] or [GLib.HashTable.newFull].
 * #GBytes can also be used as keys in a #GTree by passing the [GLib.Bytes.compare]
 * function to [GLib.Tree.new_].
 * The data pointed to by this bytes must not be modified. For a mutable
 * array of bytes see #GByteArray. Use [GLib.Bytes.unrefToArray] to create a
 * mutable array for a #GBytes sequence. To create an immutable #GBytes from
 * a mutable #GByteArray, use the [GLib.ByteArray.freeToBytes] function.
 */
class Bytes : Boxed
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  void* cPtr(bool makeCopy = false)
  {
    return makeCopy ? copy_ : cInstancePtr;
  }

  static GType getType()
  {
    return g_bytes_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new #GBytes from data.
   * data is copied. If size is 0, data may be %NULL.
   * Params:
   *   data = the data to be used for the bytes
   * Returns: a new #GBytes
   */
  this(ubyte[] data)
  {
    GBytes* _cretval;
    size_t _size;
    if (data)
      _size = cast(size_t)data.length;

    auto _data = cast(const(void)*)data.ptr;
    _cretval = g_bytes_new(_data, _size);
    this(_cretval, true);
  }

  /**
   * Compares the two #GBytes values.
   * This function can be used to sort GBytes instances in lexicographical order.
   * If bytes1 and bytes2 have different length but the shorter one is a
   * prefix of the longer one then the shorter one is considered to be less than
   * the longer one. Otherwise the first byte where both differ is used for
   * comparison. If bytes1 has a smaller value at that position it is
   * considered less, otherwise greater than bytes2.
   * Params:
   *   bytes2 = a pointer to a #GBytes to compare with bytes1
   * Returns: a negative value if bytes1 is less than bytes2, a positive value
   *   if bytes1 is greater than bytes2, and zero if bytes1 is equal to
   *   bytes2
   */
  int compare(Bytes bytes2)
  {
    int _retval;
    _retval = g_bytes_compare(cast(GBytes*)cPtr, bytes2 ? cast(GBytes*)bytes2.cPtr(false) : null);
    return _retval;
  }

  /**
   * Compares the two #GBytes values being pointed to and returns
   * %TRUE if they are equal.
   * This function can be passed to [GLib.HashTable.new_] as the key_equal_func
   * parameter, when using non-%NULL #GBytes pointers as keys in a #GHashTable.
   * Params:
   *   bytes2 = a pointer to a #GBytes to compare with bytes1
   * Returns: %TRUE if the two keys match.
   */
  bool equal(Bytes bytes2)
  {
    bool _retval;
    _retval = g_bytes_equal(cast(GBytes*)cPtr, bytes2 ? cast(GBytes*)bytes2.cPtr(false) : null);
    return _retval;
  }

  /**
   * Get the byte data in the #GBytes. This data should not be modified.
   * This function will always return the same pointer for a given #GBytes.
   * %NULL may be returned if size is 0. This is not guaranteed, as the #GBytes
   * may represent an empty string with data non-%NULL and size as 0. %NULL will
   * not be returned if size is non-zero.
   * Returns: a pointer to the byte data, or %NULL
   */
  ubyte[] getData()
  {
    const(void)* _cretval;
    size_t _cretlength;
    _cretval = g_bytes_get_data(cast(GBytes*)cPtr, &_cretlength);
    ubyte[] _retval;

    if (_cretval)
    {
      _retval = cast(ubyte[] )_cretval[0 .. _cretlength];
    }
    return _retval;
  }

  /**
   * Gets a pointer to a region in bytes.
   * The region starts at offset many bytes from the start of the data
   * and contains n_elements many elements of element_size size.
   * n_elements may be zero, but element_size must always be non-zero.
   * Ideally, element_size is a static constant $(LPAREN)eg: sizeof a struct$(RPAREN).
   * This function does careful bounds checking $(LPAREN)including checking for
   * arithmetic overflows$(RPAREN) and returns a non-%NULL pointer if the
   * specified region lies entirely within the bytes. If the region is
   * in some way out of range, or if an overflow has occurred, then %NULL
   * is returned.
   * Note: it is possible to have a valid zero-size region. In this case,
   * the returned pointer will be equal to the base pointer of the data of
   * bytes, plus offset.  This will be non-%NULL except for the case
   * where bytes itself was a zero-sized region.  Since it is unlikely
   * that you will be using this function to check for a zero-sized region
   * in a zero-sized bytes, %NULL effectively always means "error".
   * Params:
   *   elementSize = a non-zero element size
   *   offset = an offset to the start of the region within the bytes
   *   nElements = the number of elements in the region
   * Returns: the requested region, or %NULL in case of an error
   */
  const(void)* getRegion(size_t elementSize, size_t offset, size_t nElements)
  {
    const(void)* _retval;
    _retval = g_bytes_get_region(cast(GBytes*)cPtr, elementSize, offset, nElements);
    return _retval;
  }

  /**
   * Get the size of the byte data in the #GBytes.
   * This function will always return the same value for a given #GBytes.
   * Returns: the size
   */
  size_t getSize()
  {
    size_t _retval;
    _retval = g_bytes_get_size(cast(GBytes*)cPtr);
    return _retval;
  }

  /**
   * Creates an integer hash code for the byte data in the #GBytes.
   * This function can be passed to [GLib.HashTable.new_] as the key_hash_func
   * parameter, when using non-%NULL #GBytes pointers as keys in a #GHashTable.
   * Returns: a hash value corresponding to the key.
   */
  uint hash()
  {
    uint _retval;
    _retval = g_bytes_hash(cast(GBytes*)cPtr);
    return _retval;
  }

  /**
   * Creates a #GBytes which is a subsection of another #GBytes. The offset +
   * length may not be longer than the size of bytes.
   * A reference to bytes will be held by the newly created #GBytes until
   * the byte data is no longer needed.
   * Since 2.56, if offset is 0 and length matches the size of bytes, then
   * bytes will be returned with the reference count incremented by 1. If bytes
   * is a slice of another #GBytes, then the resulting #GBytes will reference
   * the same #GBytes instead of bytes. This allows consumers to simplify the
   * usage of #GBytes when asynchronously writing to streams.
   * Params:
   *   offset = offset which subsection starts at
   *   length = length of subsection
   * Returns: a new #GBytes
   */
  Bytes newFromBytes(size_t offset, size_t length)
  {
    GBytes* _cretval;
    _cretval = g_bytes_new_from_bytes(cast(GBytes*)cPtr, offset, length);
    auto _retval = _cretval ? new Bytes(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Unreferences the bytes, and returns a new mutable #GByteArray containing
   * the same byte data.
   * As an optimization, the byte data is transferred to the array without copying
   * if this was the last reference to bytes and bytes was created with
   * [GLib.Bytes.new_], [GLib.Bytes.newTake] or [GLib.ByteArray.freeToBytes]. In all
   * other cases the data is copied.
   * Do not use it if bytes contains more than %G_MAXUINT
   * bytes. #GByteArray stores the length of its data in #guint, which
   * may be shorter than #gsize, that bytes is using.
   * Returns: a new mutable #GByteArray containing the same byte data
   */
  ByteArray unrefToArray()
  {
    GByteArray* _cretval;
    _cretval = g_bytes_unref_to_array(cast(GBytes*)cPtr);
    ByteArray _retval = new ByteArray(cast(GByteArray*)_cretval, GidOwnership.Full);
    return _retval;
  }

  /**
   * Unreferences the bytes, and returns a pointer the same byte data
   * contents.
   * As an optimization, the byte data is returned without copying if this was
   * the last reference to bytes and bytes was created with [GLib.Bytes.new_],
   * [GLib.Bytes.newTake] or [GLib.ByteArray.freeToBytes]. In all other cases the
   * data is copied.
   * Returns: a pointer to the same byte data, which should be
   *   freed with [GLib.Global.gfree]
   */
  ubyte[] unrefToData()
  {
    void* _cretval;
    size_t _cretlength;
    _cretval = g_bytes_unref_to_data(cast(GBytes*)cPtr, &_cretlength);
    ubyte[] _retval;

    if (_cretval)
    {
      _retval = cast(ubyte[] )_cretval[0 .. _cretlength];
    }
    return _retval;
  }
}
