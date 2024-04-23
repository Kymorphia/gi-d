module Gio.DesktopAppInfoLookupT;

public import GObject.ObjectG;
public import Gid.Gid;
public import Gio.AppInfo;
public import Gio.Types;
public import Gio.c.functions;
public import Gio.c.types;

/**
 * #GDesktopAppInfoLookup is an opaque data structure and can only be accessed
 * using the following functions.
 */
template DesktopAppInfoLookupT(TStruct)
{

  /**
   * #GAppInfo for given @uri_scheme or
   * %NULL on error.
   */
  override AppInfo getDefaultForUriScheme(string uriScheme)
  {
    GAppInfo* _cretval;
    const(char)* _uriScheme = uriScheme.toCString(false);
    _cretval = g_desktop_app_info_lookup_get_default_for_uri_scheme(cPtr!GDesktopAppInfoLookup, _uriScheme);
    AppInfo _retval = ObjectG.getDObject!AppInfo(cast(GAppInfo*)_cretval, true);
    return _retval;
  }
}
