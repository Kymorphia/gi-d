module Gio.InetAddressMask;

import GLib.ErrorG;
import GObject.ObjectG;
import Gid.gid;
import Gio.InetAddress;
import Gio.Initable;
import Gio.InitableT;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * `GInetAddressMask` represents a range of IPv4 or IPv6 addresses
 * described by a base address and a length indicating how many bits
 * of the base address are relevant for matching purposes. These are
 * often given in string form. For example, `10.0.0.0/8`, or `fe80::/10`.
 */
class InetAddressMask : ObjectG, Initable
{

  this()
  {
  }

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_inet_address_mask_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin InitableT!GInetAddressMask;

  /**
   * Creates a new #GInetAddressMask representing all addresses whose
   * first length bits match addr.
   * Params:
   *   addr = a #GInetAddress
   *   length = number of bits of addr to use
   * Returns: a new #GInetAddressMask, or %NULL on error
   */
  this(InetAddress addr, uint length)
  {
    GInetAddressMask* _cretval;
    GError *_err;
    _cretval = g_inet_address_mask_new(addr ? cast(GInetAddress*)addr.cPtr(false) : null, length, &_err);
    if (_err)
      throw new ErrorG(_err);
    this(_cretval, true);
  }

  /**
   * Parses mask_string as an IP address and $(LPAREN)optional$(RPAREN) length, and
   * creates a new #GInetAddressMask. The length, if present, is
   * delimited by a "/". If it is not present, then the length is
   * assumed to be the full length of the address.
   * Params:
   *   maskString = an IP address or address/length string
   * Returns: a new #GInetAddressMask corresponding to string, or %NULL
   *   on error.
   */
  static InetAddressMask newFromString(string maskString)
  {
    GInetAddressMask* _cretval;
    const(char)* _maskString = maskString.toCString(false);
    GError *_err;
    _cretval = g_inet_address_mask_new_from_string(_maskString, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = _cretval ? ObjectG.getDObject!InetAddressMask(cast(GInetAddressMask*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Tests if mask and mask2 are the same mask.
   * Params:
   *   mask2 = another #GInetAddressMask
   * Returns: whether mask and mask2 are the same mask
   */
  bool equal(InetAddressMask mask2)
  {
    bool _retval;
    _retval = g_inet_address_mask_equal(cast(GInetAddressMask*)cPtr, mask2 ? cast(GInetAddressMask*)mask2.cPtr(false) : null);
    return _retval;
  }

  /**
   * Gets mask's base address
   * Returns: mask's base address
   */
  InetAddress getAddress()
  {
    GInetAddress* _cretval;
    _cretval = g_inet_address_mask_get_address(cast(GInetAddressMask*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!InetAddress(cast(GInetAddress*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the #GSocketFamily of mask's address
   * Returns: the #GSocketFamily of mask's address
   */
  SocketFamily getFamily()
  {
    GSocketFamily _cretval;
    _cretval = g_inet_address_mask_get_family(cast(GInetAddressMask*)cPtr);
    SocketFamily _retval = cast(SocketFamily)_cretval;
    return _retval;
  }

  /**
   * Gets mask's length
   * Returns: mask's length
   */
  uint getLength()
  {
    uint _retval;
    _retval = g_inet_address_mask_get_length(cast(GInetAddressMask*)cPtr);
    return _retval;
  }

  /**
   * Tests if address falls within the range described by mask.
   * Params:
   *   address = a #GInetAddress
   * Returns: whether address falls within the range described by
   *   mask.
   */
  bool matches(InetAddress address)
  {
    bool _retval;
    _retval = g_inet_address_mask_matches(cast(GInetAddressMask*)cPtr, address ? cast(GInetAddress*)address.cPtr(false) : null);
    return _retval;
  }

  /**
   * Converts mask back to its corresponding string form.
   * Returns: a string corresponding to mask.
   */
  string toString_()
  {
    char* _cretval;
    _cretval = g_inet_address_mask_to_string(cast(GInetAddressMask*)cPtr);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }
}
