module Gio.DesktopAppInfoLookup;

public import Gio.DesktopAppInfoLookupIfaceProxy;
import GObject.ObjectG;
import Gid.gid;
import Gio.AppInfo;
import Gio.AppInfoT;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * #GDesktopAppInfoLookup is an opaque data structure and can only be accessed
 * using the following functions.

 * Deprecated: The #GDesktopAppInfoLookup interface is deprecated and
 *   unused by GIO.
 */
interface DesktopAppInfoLookup
{

  static GType getType()
  {
    return g_desktop_app_info_lookup_get_type();
  }

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
  AppInfo getDefaultForUriScheme(string uriScheme);
}
