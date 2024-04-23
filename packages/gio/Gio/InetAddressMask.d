module Gio.InetAddressMask;

import GLib.ErrorG;
import GObject.ObjectG;
import GObject.Types;
import Gid.Gid;
import Gio.InetAddress;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * #GInetAddressMask represents a range of IPv4 or IPv6 addresses
 * described by a base address and a length indicating how many bits
 * of the base address are relevant for matching purposes. These are
 * often given in string form. Eg, "10.0.0.0/8", or "fe80::/10".
 */
class InetAddressMask : ObjectG
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_inet_address_mask_get_type();
  }

  /**
   * a new #GInetAddressMask, or %NULL on error
   */
  this(InetAddress addr, uint length)
  {
    GInetAddressMask* _cretval;
    GError *_err;
    _cretval = g_inet_address_mask_new(addr ? addr.cPtr!GInetAddress : null, length, &_err);
    if (_err)
      throw new ErrorG(_err);
    this(_cretval, true);
  }

  /**
   * a new #GInetAddressMask corresponding to @string, or %NULL
   * on error.
   */
  static InetAddressMask newFromString(string maskString)
  {
    GInetAddressMask* _cretval;
    const(char)* _maskString = maskString.toCString(false);
    GError *_err;
    _cretval = g_inet_address_mask_new_from_string(_maskString, &_err);
    if (_err)
      throw new ErrorG(_err);
    InetAddressMask _retval = ObjectG.getDObject!InetAddressMask(cast(GInetAddressMask*)_cretval, true);
    return _retval;
  }

  /**
   * whether @mask and @mask2 are the same mask
   */
  bool equal(InetAddressMask mask2)
  {
    bool _retval;
    _retval = g_inet_address_mask_equal(cPtr!GInetAddressMask, mask2 ? mask2.cPtr!GInetAddressMask : null);
    return _retval;
  }

  /**
   * @mask's base address
   */
  InetAddress getAddress()
  {
    GInetAddress* _cretval;
    _cretval = g_inet_address_mask_get_address(cPtr!GInetAddressMask);
    InetAddress _retval = ObjectG.getDObject!InetAddress(cast(GInetAddress*)_cretval, false);
    return _retval;
  }

  /**
   * the #GSocketFamily of @mask's address
   */
  SocketFamily getFamily()
  {
    GSocketFamily _cretval;
    _cretval = g_inet_address_mask_get_family(cPtr!GInetAddressMask);
    SocketFamily _retval = cast(SocketFamily)_cretval;
    return _retval;
  }

  /**
   * @mask's length
   */
  uint getLength()
  {
    uint _retval;
    _retval = g_inet_address_mask_get_length(cPtr!GInetAddressMask);
    return _retval;
  }

  /**
   * whether @address falls within the range described by
   * @mask.
   */
  bool matches(InetAddress address)
  {
    bool _retval;
    _retval = g_inet_address_mask_matches(cPtr!GInetAddressMask, address ? address.cPtr!GInetAddress : null);
    return _retval;
  }

  /**
   * a string corresponding to @mask.
   */
  string toString_()
  {
    char* _cretval;
    _cretval = g_inet_address_mask_to_string(cPtr!GInetAddressMask);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }
}
