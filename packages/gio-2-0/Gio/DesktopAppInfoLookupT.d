module Gio.DesktopAppInfoLookupT;

public import Gio.DesktopAppInfoLookupIfaceProxy;
public import GObject.ObjectG;
public import Gid.gid;
public import Gio.AppInfo;
public import Gio.AppInfoT;
public import Gio.Types;
public import Gio.c.functions;
public import Gio.c.types;

/**
 * #GDesktopAppInfoLookup is an opaque data structure and can only be accessed
 * using the following functions.

 * Deprecated: The #GDesktopAppInfoLookup interface is deprecated and
 *   unused by GIO.
 */
template DesktopAppInfoLookupT()
{

  /**
   * Gets the default application for launching applications
   * using this URI scheme for a particular #GDesktopAppInfoLookup
   * implementation.
   * The #GDesktopAppInfoLookup interface and this function is used
   * to implement [Gio.AppInfo.getDefaultForUriScheme] backends
   * in a GIO module. There is no reason for applications to use it
   * directly. Applications should use [Gio.AppInfo.getDefaultForUriScheme].
   * Params:
   *   uriScheme = a string containing a URI scheme.
   * Returns: #GAppInfo for given uri_scheme or
   *   %NULL on error.

   * Deprecated: The #GDesktopAppInfoLookup interface is deprecated and
   *   unused by GIO.
   */
  override AppInfo getDefaultForUriScheme(string uriScheme)
  {
    GAppInfo* _cretval;
    const(char)* _uriScheme = uriScheme.toCString(false);
    _cretval = g_desktop_app_info_lookup_get_default_for_uri_scheme(cast(GDesktopAppInfoLookup*)cPtr, _uriScheme);
    auto _retval = _cretval ? ObjectG.getDObject!AppInfo(cast(GAppInfo*)_cretval, true) : null;
    return _retval;
  }
}
