module GLib.Checksum;

import GLib.Boxed;
import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.Gid;

/**
 * An opaque structure representing a checksumming operation.
 *
 * To create a new GChecksum, use g_checksum_new(). To free
 * a GChecksum, use g_checksum_free().
 */
class Checksum : Boxed
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  T* cPtr(T)(bool makeCopy = false)
  if (is(T == GChecksum))
  {
    return makeCopy ? copy_!T : cast(T*)cInstancePtr;
  }

  static GType getType()
  {
    return g_checksum_get_type();
  }

  /**
   * the newly created #GChecksum, or %NULL.
   * Use g_checksum_free() to free the memory allocated by it.
   */
  this(ChecksumType checksumType)
  {
    GChecksum* _cretval;
    _cretval = g_checksum_new(checksumType);
    this(_cretval, true);
  }

  /**
   * the copy of the passed #GChecksum. Use
   * g_checksum_free() when finished using it.
   */
  Checksum copy()
  {
    GChecksum* _cretval;
    _cretval = g_checksum_copy(cPtr!GChecksum);
    Checksum _retval = new Checksum(cast(GChecksum*)_cretval, true);
    return _retval;
  }

  /**
   * the hexadecimal representation of the checksum. The
   * returned string is owned by the checksum and should not be modified
   * or freed.
   */
  string getString()
  {
    const(char)* _cretval;
    _cretval = g_checksum_get_string(cPtr!GChecksum);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Resets the state of the @checksum back to its initial state.
   */
  void reset()
  {
    g_checksum_reset(cPtr!GChecksum);
  }

  /**
   * Feeds @data into an existing #GChecksum. The checksum must still be
   * open, that is g_checksum_get_string() or g_checksum_get_digest() must
   * not have been called on @checksum.
   */
  void update(ubyte[] data)
  {
    auto _data = cast(const(ubyte)*)data.ptr;
    g_checksum_update(cPtr!GChecksum, _data, data ? cast(ptrdiff_t)data.length : 0);
  }

  /**
   * the checksum length, or -1 if @checksum_type is
   * not supported.
   */
  static ptrdiff_t typeGetLength(ChecksumType checksumType)
  {
    ptrdiff_t _retval;
    _retval = g_checksum_type_get_length(checksumType);
    return _retval;
  }
}
