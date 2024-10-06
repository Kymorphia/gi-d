module GLib.Checksum;

import GLib.Boxed;
import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.gid;

/**
 * GLib provides a generic API for computing checksums $(LPAREN)or ‘digests’$(RPAREN)
 * for a sequence of arbitrary bytes, using various hashing algorithms
 * like MD5, SHA-1 and SHA-256. Checksums are commonly used in various
 * environments and specifications.
 * To create a new `GChecksum`, use [GLib.Checksum.new_]. To free
 * a `GChecksum`, use [GLib.Checksum.free].
 * GLib supports incremental checksums using the `GChecksum` data
 * structure, by calling [GLib.Checksum.update] as long as there’s data
 * available and then using [GLib.Checksum.getString] or
 * [GLib.Checksum.getDigest] to compute the checksum and return it
 * either as a string in hexadecimal form, or as a raw sequence of bytes. To
 * compute the checksum for binary blobs and nul-terminated strings in
 * one go, use the convenience functions func@GLib.compute_checksum_for_data
 * and func@GLib.compute_checksum_for_string, respectively.
 */
class Checksum : Boxed
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
    return g_checksum_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new #GChecksum, using the checksum algorithm checksum_type.
   * If the checksum_type is not known, %NULL is returned.
   * A #GChecksum can be used to compute the checksum, or digest, of an
   * arbitrary binary blob, using different hashing algorithms.
   * A #GChecksum works by feeding a binary blob through [GLib.Checksum.update]
   * until there is data to be checked; the digest can then be extracted
   * using [GLib.Checksum.getString], which will return the checksum as a
   * hexadecimal string; or [GLib.Checksum.getDigest], which will return a
   * vector of raw bytes. Once either [GLib.Checksum.getString] or
   * [GLib.Checksum.getDigest] have been called on a #GChecksum, the checksum
   * will be closed and it won't be possible to call [GLib.Checksum.update]
   * on it anymore.
   * Params:
   *   checksumType = the desired type of checksum
   * Returns: the newly created #GChecksum, or %NULL.
   *   Use [GLib.Checksum.free] to free the memory allocated by it.
   */
  this(ChecksumType checksumType)
  {
    GChecksum* _cretval;
    _cretval = g_checksum_new(checksumType);
    this(_cretval, true);
  }

  /**
   * Copies a #GChecksum. If checksum has been closed, by calling
   * [GLib.Checksum.getString] or [GLib.Checksum.getDigest], the copied
   * checksum will be closed as well.
   * Returns: the copy of the passed #GChecksum. Use
   *   [GLib.Checksum.free] when finished using it.
   */
  Checksum copy()
  {
    GChecksum* _cretval;
    _cretval = g_checksum_copy(cast(GChecksum*)cPtr);
    auto _retval = _cretval ? new Checksum(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Gets the digest as a hexadecimal string.
   * Once this function has been called the #GChecksum can no longer be
   * updated with [GLib.Checksum.update].
   * The hexadecimal characters will be lower case.
   * Returns: the hexadecimal representation of the checksum. The
   *   returned string is owned by the checksum and should not be modified
   *   or freed.
   */
  string getString()
  {
    const(char)* _cretval;
    _cretval = g_checksum_get_string(cast(GChecksum*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Resets the state of the checksum back to its initial state.
   */
  void reset()
  {
    g_checksum_reset(cast(GChecksum*)cPtr);
  }

  /**
   * Feeds data into an existing #GChecksum. The checksum must still be
   * open, that is [GLib.Checksum.getString] or [GLib.Checksum.getDigest] must
   * not have been called on checksum.
   * Params:
   *   data = buffer used to compute the checksum
   */
  void update(ubyte[] data)
  {
    ptrdiff_t _length;
    if (data)
      _length = cast(ptrdiff_t)data.length;

    auto _data = cast(const(ubyte)*)data.ptr;
    g_checksum_update(cast(GChecksum*)cPtr, _data, _length);
  }

  /**
   * Gets the length in bytes of digests of type checksum_type
   * Params:
   *   checksumType = a #GChecksumType
   * Returns: the checksum length, or -1 if checksum_type is
   *   not supported.
   */
  static ptrdiff_t typeGetLength(ChecksumType checksumType)
  {
    ptrdiff_t _retval;
    _retval = g_checksum_type_get_length(checksumType);
    return _retval;
  }
}
