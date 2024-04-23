module GLib.Hmac;

import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.Gid;

/**
 * An opaque structure representing a HMAC operation.
 * To create a new GHmac, use g_hmac_new(). To free
 * a GHmac, use g_hmac_unref().
 */
class Hmac
{
  GHmac* cInstancePtr;
  bool owned;

  this(void* ptr, bool owned = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for GLib.Hmac");

    cInstancePtr = cast(GHmac*)ptr;

    this.owned = owned;
  }

  ~this()
  {
    if (owned)
      g_hmac_unref(cInstancePtr);
  }

  T* cPtr(T)()
  if (is(T == GHmac))
  {
    return cast(T*)cInstancePtr;
  }

  /**
   * Gets the digest from @checksum as a raw binary array and places it
   * into @buffer. The size of the digest depends on the type of checksum.
   *
   * Once this function has been called, the #GHmac is closed and can
   * no longer be updated with g_checksum_update().
   */
  void getDigest(ref ubyte[] buffer)
  {
    auto _digestLen = buffer ? cast(size_t)buffer.length : 0;
    g_hmac_get_digest(cPtr!GHmac, buffer.ptr, &_digestLen);
  }

  /**
   * the hexadecimal representation of the HMAC. The
   * returned string is owned by the HMAC and should not be modified
   * or freed.
   */
  string getString()
  {
    const(char)* _cretval;
    _cretval = g_hmac_get_string(cPtr!GHmac);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Feeds @data into an existing #GHmac.
   *
   * The HMAC must still be open, that is g_hmac_get_string() or
   * g_hmac_get_digest() must not have been called on @hmac.
   */
  void update(ubyte[] data)
  {
    auto _data = cast(const(ubyte)*)data.ptr;
    g_hmac_update(cPtr!GHmac, _data, data ? cast(ptrdiff_t)data.length : 0);
  }
}
