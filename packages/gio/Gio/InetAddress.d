module Gio.InetAddress;

import GObject.ObjectG;
import GObject.Types;
import Gid.Gid;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * #GInetAddress represents an IPv4 or IPv6 internet address. Use
 * g_resolver_lookup_by_name() or g_resolver_lookup_by_name_async() to
 * look up the #GInetAddress for a hostname. Use
 * g_resolver_lookup_by_address() or
 * g_resolver_lookup_by_address_async() to look up the hostname for a
 * #GInetAddress.
 *
 * To actually connect to a remote host, you will need a
 * #GInetSocketAddress (which includes a #GInetAddress as well as a
 * port number).
 */
class InetAddress : ObjectG
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_inet_address_get_type();
  }

  /**
   * a new #GInetAddress corresponding to the "any" address
   * for @family.
   * Free the returned object with g_object_unref().
   */
  static InetAddress newAny(SocketFamily family)
  {
    GInetAddress* _cretval;
    _cretval = g_inet_address_new_any(family);
    InetAddress _retval = ObjectG.getDObject!InetAddress(cast(GInetAddress*)_cretval, true);
    return _retval;
  }

  /**
   * a new #GInetAddress corresponding to @family and @bytes.
   * Free the returned object with g_object_unref().
   */
  static InetAddress newFromBytes(ubyte[] bytes, SocketFamily family)
  {
    GInetAddress* _cretval;
    auto _bytes = cast(const(ubyte)*)(bytes ~ 0).ptr;
    _cretval = g_inet_address_new_from_bytes(_bytes, family);
    InetAddress _retval = ObjectG.getDObject!InetAddress(cast(GInetAddress*)_cretval, true);
    return _retval;
  }

  /**
   * a new #GInetAddress corresponding
   * to @string, or %NULL if @string could not be parsed.
   * Free the returned object with g_object_unref().
   */
  static InetAddress newFromString(string string_)
  {
    GInetAddress* _cretval;
    const(char)* _string_ = string_.toCString(false);
    _cretval = g_inet_address_new_from_string(_string_);
    InetAddress _retval = ObjectG.getDObject!InetAddress(cast(GInetAddress*)_cretval, true);
    return _retval;
  }

  /**
   * a new #GInetAddress corresponding to the loopback address
   * for @family.
   * Free the returned object with g_object_unref().
   */
  static InetAddress newLoopback(SocketFamily family)
  {
    GInetAddress* _cretval;
    _cretval = g_inet_address_new_loopback(family);
    InetAddress _retval = ObjectG.getDObject!InetAddress(cast(GInetAddress*)_cretval, true);
    return _retval;
  }

  /**
   * %TRUE if @address and @other_address are equal, %FALSE otherwise.
   */
  bool equal(InetAddress otherAddress)
  {
    bool _retval;
    _retval = g_inet_address_equal(cPtr!GInetAddress, otherAddress ? otherAddress.cPtr!GInetAddress : null);
    return _retval;
  }

  /**
   * @address's family
   */
  SocketFamily getFamily()
  {
    GSocketFamily _cretval;
    _cretval = g_inet_address_get_family(cPtr!GInetAddress);
    SocketFamily _retval = cast(SocketFamily)_cretval;
    return _retval;
  }

  /**
   * %TRUE if @address is the "any" address for its family.
   */
  bool getIsAny()
  {
    bool _retval;
    _retval = g_inet_address_get_is_any(cPtr!GInetAddress);
    return _retval;
  }

  /**
   * %TRUE if @address is a link-local address.
   */
  bool getIsLinkLocal()
  {
    bool _retval;
    _retval = g_inet_address_get_is_link_local(cPtr!GInetAddress);
    return _retval;
  }

  /**
   * %TRUE if @address is the loopback address for its family.
   */
  bool getIsLoopback()
  {
    bool _retval;
    _retval = g_inet_address_get_is_loopback(cPtr!GInetAddress);
    return _retval;
  }

  /**
   * %TRUE if @address is a global multicast address.
   */
  bool getIsMcGlobal()
  {
    bool _retval;
    _retval = g_inet_address_get_is_mc_global(cPtr!GInetAddress);
    return _retval;
  }

  /**
   * %TRUE if @address is a link-local multicast address.
   */
  bool getIsMcLinkLocal()
  {
    bool _retval;
    _retval = g_inet_address_get_is_mc_link_local(cPtr!GInetAddress);
    return _retval;
  }

  /**
   * %TRUE if @address is a node-local multicast address.
   */
  bool getIsMcNodeLocal()
  {
    bool _retval;
    _retval = g_inet_address_get_is_mc_node_local(cPtr!GInetAddress);
    return _retval;
  }

  /**
   * %TRUE if @address is an organization-local multicast address.
   */
  bool getIsMcOrgLocal()
  {
    bool _retval;
    _retval = g_inet_address_get_is_mc_org_local(cPtr!GInetAddress);
    return _retval;
  }

  /**
   * %TRUE if @address is a site-local multicast address.
   */
  bool getIsMcSiteLocal()
  {
    bool _retval;
    _retval = g_inet_address_get_is_mc_site_local(cPtr!GInetAddress);
    return _retval;
  }

  /**
   * %TRUE if @address is a multicast address.
   */
  bool getIsMulticast()
  {
    bool _retval;
    _retval = g_inet_address_get_is_multicast(cPtr!GInetAddress);
    return _retval;
  }

  /**
   * %TRUE if @address is a site-local address.
   */
  bool getIsSiteLocal()
  {
    bool _retval;
    _retval = g_inet_address_get_is_site_local(cPtr!GInetAddress);
    return _retval;
  }

  /**
   * the number of bytes used for the native version of @address.
   */
  size_t getNativeSize()
  {
    size_t _retval;
    _retval = g_inet_address_get_native_size(cPtr!GInetAddress);
    return _retval;
  }

  /**
   * a representation of @address as a string, which should be
   * freed after use.
   */
  string toString_()
  {
    char* _cretval;
    _cretval = g_inet_address_to_string(cPtr!GInetAddress);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }
}
