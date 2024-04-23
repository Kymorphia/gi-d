module Gio.DesktopAppInfoLookup;

import GObject.ObjectG;
import Gid.Gid;
import Gio.AppInfo;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * #GDesktopAppInfoLookup is an opaque data structure and can only be accessed
 * using the following functions.
 */
interface DesktopAppInfoLookup
{

  static GType getType()
  {
    return g_desktop_app_info_lookup_get_type();
  }

  /**
   * #GAppInfo for given @uri_scheme or
   * %NULL on error.
   */
  AppInfo getDefaultForUriScheme(string uriScheme);
}
