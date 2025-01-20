module GLib.Hmac;

import GLib.Boxed;
import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.gid;

/**
 * HMACs should be used when producing a cookie or hash based on data
 * and a key. Simple mechanisms for using SHA1 and other algorithms to
 * digest a key and data together are vulnerable to various security
 * issues.
 * [HMAC](http://en.wikipedia.org/wiki/HMAC)
 * uses algorithms like SHA1 in a secure way to produce a digest of a
 * key and data.
 * Both the key and data are arbitrary byte arrays of bytes or characters.
 * Support for HMAC Digests has been added in GLib 2.30, and support for SHA-512
 * in GLib 2.42. Support for SHA-384 was added in GLib 2.52.
 * To create a new `GHmac`, use [GLib.Hmac.new_]. To free a `GHmac`, use
 * [GLib.Hmac.unref].
 */
class Hmac : Boxed
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
    return g_hmac_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new #GHmac, using the digest algorithm digest_type.
   * If the digest_type is not known, %NULL is returned.
   * A #GHmac can be used to compute the HMAC of a key and an
   * arbitrary binary blob, using different hashing algorithms.
   * A #GHmac works by feeding a binary blob through [GLib.Hmac.update]
   * until the data is complete; the digest can then be extracted
   * using [GLib.Hmac.getString], which will return the checksum as a
   * hexadecimal string; or [GLib.Hmac.getDigest], which will return a
   * array of raw bytes. Once either [GLib.Hmac.getString] or
   * [GLib.Hmac.getDigest] have been called on a #GHmac, the HMAC
   * will be closed and it won't be possible to call [GLib.Hmac.update]
   * on it anymore.
   * Support for digests of type %G_CHECKSUM_SHA512 has been added in GLib 2.42.
   * Support for %G_CHECKSUM_SHA384 was added in GLib 2.52.
   * Params:
   *   digestType = the desired type of digest
   *   key = the key for the HMAC
   * Returns: the newly created #GHmac, or %NULL.
   *   Use [GLib.Hmac.unref] to free the memory allocated by it.
   */
  this(ChecksumType digestType, ubyte[] key)
  {
    GHmac* _cretval;
    size_t _keyLen;
    if (key)
      _keyLen = cast(size_t)key.length;

    auto _key = cast(const(ubyte)*)key.ptr;
    _cretval = g_hmac_new(digestType, _key, _keyLen);
    this(_cretval, true);
  }

  /**
   * Copies a #GHmac. If hmac has been closed, by calling
   * [GLib.Hmac.getString] or [GLib.Hmac.getDigest], the copied
   * HMAC will be closed as well.
   * Returns: the copy of the passed #GHmac. Use [GLib.Hmac.unref]
   *   when finished using it.
   */
  Hmac copy()
  {
    GHmac* _cretval;
    _cretval = g_hmac_copy(cast(GHmac*)cPtr);
    auto _retval = _cretval ? new Hmac(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Gets the digest from checksum as a raw binary array and places it
   * into buffer. The size of the digest depends on the type of checksum.
   * Once this function has been called, the #GHmac is closed and can
   * no longer be updated with [GLib.Checksum.update].
   * Params:
   *   buffer = output buffer
   */
  void getDigest(ref ubyte[] buffer)
  {
    size_t _digestLen;
    g_hmac_get_digest(cast(GHmac*)cPtr, buffer.ptr, &_digestLen);
  }

  /**
   * Gets the HMAC as a hexadecimal string.
   * Once this function has been called the #GHmac can no longer be
   * updated with [GLib.Hmac.update].
   * The hexadecimal characters will be lower case.
   * Returns: the hexadecimal representation of the HMAC. The
   *   returned string is owned by the HMAC and should not be modified
   *   or freed.
   */
  string getString()
  {
    const(char)* _cretval;
    _cretval = g_hmac_get_string(cast(GHmac*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Feeds data into an existing #GHmac.
   * The HMAC must still be open, that is [GLib.Hmac.getString] or
   * [GLib.Hmac.getDigest] must not have been called on hmac.
   * Params:
   *   data = buffer used to compute the checksum
   */
  void update(ubyte[] data)
  {
    ptrdiff_t _length;
    if (data)
      _length = cast(ptrdiff_t)data.length;

    auto _data = cast(const(ubyte)*)data.ptr;
    g_hmac_update(cast(GHmac*)cPtr, _data, _length);
  }
}
