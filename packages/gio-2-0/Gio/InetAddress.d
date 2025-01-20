module Gio.InetAddress;

import GObject.ObjectG;
import Gid.gid;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * `GInetAddress` represents an IPv4 or IPv6 internet address. Use
 * [Gio.Resolver.lookupByName] or
 * [Gio.Resolver.lookupByNameAsync] to look up the `GInetAddress` for
 * a hostname. Use [Gio.Resolver.lookupByAddress] or
 * [Gio.Resolver.lookupByAddressAsync] to look up the hostname for a
 * `GInetAddress`.
 * To actually connect to a remote host, you will need a
 * [Gio.InetSocketAddress] $(LPAREN)which includes a `GInetAddress` as well as a
 * port number$(RPAREN).
 */
class InetAddress : ObjectG
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
    return g_inet_address_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a #GInetAddress for the "any" address $(LPAREN)unassigned/"don't
   * care"$(RPAREN) for family.
   * Params:
   *   family = the address family
   * Returns: a new #GInetAddress corresponding to the "any" address
   *   for family.
   *   Free the returned object with [GObject.ObjectG.unref].
   */
  static InetAddress newAny(SocketFamily family)
  {
    GInetAddress* _cretval;
    _cretval = g_inet_address_new_any(family);
    auto _retval = _cretval ? ObjectG.getDObject!InetAddress(cast(GInetAddress*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Creates a new #GInetAddress from the given family and bytes.
   * bytes should be 4 bytes for %G_SOCKET_FAMILY_IPV4 and 16 bytes for
   * %G_SOCKET_FAMILY_IPV6.
   * Params:
   *   bytes = raw address data
   *   family = the address family of bytes
   * Returns: a new #GInetAddress corresponding to family and bytes.
   *   Free the returned object with [GObject.ObjectG.unref].
   */
  static InetAddress newFromBytes(ubyte[] bytes, SocketFamily family)
  {
    GInetAddress* _cretval;
    auto _bytes = cast(const(ubyte)*)(bytes ~ ubyte.init).ptr;
    _cretval = g_inet_address_new_from_bytes(_bytes, family);
    auto _retval = _cretval ? ObjectG.getDObject!InetAddress(cast(GInetAddress*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Parses string as an IP address and creates a new #GInetAddress.
   * Params:
   *   string_ = a string representation of an IP address
   * Returns: a new #GInetAddress corresponding
   *   to string, or %NULL if string could not be parsed.
   *   Free the returned object with [GObject.ObjectG.unref].
   */
  static InetAddress newFromString(string string_)
  {
    GInetAddress* _cretval;
    const(char)* _string_ = string_.toCString(false);
    _cretval = g_inet_address_new_from_string(_string_);
    auto _retval = _cretval ? ObjectG.getDObject!InetAddress(cast(GInetAddress*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Creates a #GInetAddress for the loopback address for family.
   * Params:
   *   family = the address family
   * Returns: a new #GInetAddress corresponding to the loopback address
   *   for family.
   *   Free the returned object with [GObject.ObjectG.unref].
   */
  static InetAddress newLoopback(SocketFamily family)
  {
    GInetAddress* _cretval;
    _cretval = g_inet_address_new_loopback(family);
    auto _retval = _cretval ? ObjectG.getDObject!InetAddress(cast(GInetAddress*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Checks if two #GInetAddress instances are equal, e.g. the same address.
   * Params:
   *   otherAddress = Another #GInetAddress.
   * Returns: %TRUE if address and other_address are equal, %FALSE otherwise.
   */
  bool equal(InetAddress otherAddress)
  {
    bool _retval;
    _retval = g_inet_address_equal(cast(GInetAddress*)cPtr, otherAddress ? cast(GInetAddress*)otherAddress.cPtr(false) : null);
    return _retval;
  }

  /**
   * Gets address's family
   * Returns: address's family
   */
  SocketFamily getFamily()
  {
    GSocketFamily _cretval;
    _cretval = g_inet_address_get_family(cast(GInetAddress*)cPtr);
    SocketFamily _retval = cast(SocketFamily)_cretval;
    return _retval;
  }

  /**
   * Tests whether address is the "any" address for its family.
   * Returns: %TRUE if address is the "any" address for its family.
   */
  bool getIsAny()
  {
    bool _retval;
    _retval = g_inet_address_get_is_any(cast(GInetAddress*)cPtr);
    return _retval;
  }

  /**
   * Tests whether address is a link-local address $(LPAREN)that is, if it
   * identifies a host on a local network that is not connected to the
   * Internet$(RPAREN).
   * Returns: %TRUE if address is a link-local address.
   */
  bool getIsLinkLocal()
  {
    bool _retval;
    _retval = g_inet_address_get_is_link_local(cast(GInetAddress*)cPtr);
    return _retval;
  }

  /**
   * Tests whether address is the loopback address for its family.
   * Returns: %TRUE if address is the loopback address for its family.
   */
  bool getIsLoopback()
  {
    bool _retval;
    _retval = g_inet_address_get_is_loopback(cast(GInetAddress*)cPtr);
    return _retval;
  }

  /**
   * Tests whether address is a global multicast address.
   * Returns: %TRUE if address is a global multicast address.
   */
  bool getIsMcGlobal()
  {
    bool _retval;
    _retval = g_inet_address_get_is_mc_global(cast(GInetAddress*)cPtr);
    return _retval;
  }

  /**
   * Tests whether address is a link-local multicast address.
   * Returns: %TRUE if address is a link-local multicast address.
   */
  bool getIsMcLinkLocal()
  {
    bool _retval;
    _retval = g_inet_address_get_is_mc_link_local(cast(GInetAddress*)cPtr);
    return _retval;
  }

  /**
   * Tests whether address is a node-local multicast address.
   * Returns: %TRUE if address is a node-local multicast address.
   */
  bool getIsMcNodeLocal()
  {
    bool _retval;
    _retval = g_inet_address_get_is_mc_node_local(cast(GInetAddress*)cPtr);
    return _retval;
  }

  /**
   * Tests whether address is an organization-local multicast address.
   * Returns: %TRUE if address is an organization-local multicast address.
   */
  bool getIsMcOrgLocal()
  {
    bool _retval;
    _retval = g_inet_address_get_is_mc_org_local(cast(GInetAddress*)cPtr);
    return _retval;
  }

  /**
   * Tests whether address is a site-local multicast address.
   * Returns: %TRUE if address is a site-local multicast address.
   */
  bool getIsMcSiteLocal()
  {
    bool _retval;
    _retval = g_inet_address_get_is_mc_site_local(cast(GInetAddress*)cPtr);
    return _retval;
  }

  /**
   * Tests whether address is a multicast address.
   * Returns: %TRUE if address is a multicast address.
   */
  bool getIsMulticast()
  {
    bool _retval;
    _retval = g_inet_address_get_is_multicast(cast(GInetAddress*)cPtr);
    return _retval;
  }

  /**
   * Tests whether address is a site-local address such as 10.0.0.1
   * $(LPAREN)that is, the address identifies a host on a local network that can
   * not be reached directly from the Internet, but which may have
   * outgoing Internet connectivity via a NAT or firewall$(RPAREN).
   * Returns: %TRUE if address is a site-local address.
   */
  bool getIsSiteLocal()
  {
    bool _retval;
    _retval = g_inet_address_get_is_site_local(cast(GInetAddress*)cPtr);
    return _retval;
  }

  /**
   * Gets the size of the native raw binary address for address. This
   * is the size of the data that you get from [Gio.InetAddress.toBytes].
   * Returns: the number of bytes used for the native version of address.
   */
  size_t getNativeSize()
  {
    size_t _retval;
    _retval = g_inet_address_get_native_size(cast(GInetAddress*)cPtr);
    return _retval;
  }

  /**
   * Converts address to string form.
   * Returns: a representation of address as a string, which should be
   *   freed after use.
   */
  string toString_()
  {
    char* _cretval;
    _cretval = g_inet_address_to_string(cast(GInetAddress*)cPtr);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }
}
