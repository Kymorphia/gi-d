module Gio.AppInfo;

import GLib.ErrorG;
import GLib.List;
import GLib.Types;
import GObject.ObjectG;
import GObject.Types;
import Gid.Gid;
import Gio.AppLaunchContext;
import Gio.AsyncResult;
import Gio.Cancellable;
import Gio.File;
import Gio.Icon;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * #GAppInfo and #GAppLaunchContext are used for describing and launching
 * applications installed on the system.
 *
 * As of GLib 2.20, URIs will always be converted to POSIX paths
 * (using g_file_get_path()) when using g_app_info_launch() even if
 * the application requested an URI and not a POSIX path. For example
 * for a desktop-file based application with Exec key `totem
 * %U` and a single URI, `sftp://foo/file.avi`, then
 * `/home/user/.gvfs/sftp on foo/file.avi` will be passed. This will
 * only work if a set of suitable GIO extensions (such as gvfs 2.26
 * compiled with FUSE support), is available and operational; if this
 * is not the case, the URI will be passed unmodified to the application.
 * Some URIs, such as `mailto:`, of course cannot be mapped to a POSIX
 * path (in gvfs there's no FUSE mount for it); such URIs will be
 * passed unmodified to the application.
 *
 * Specifically for gvfs 2.26 and later, the POSIX URI will be mapped
 * back to the GIO URI in the #GFile constructors (since gvfs
 * implements the #GVfs extension point). As such, if the application
 * needs to examine the URI, it needs to use g_file_get_uri() or
 * similar on #GFile. In other words, an application cannot assume
 * that the URI passed to e.g. g_file_new_for_commandline_arg() is
 * equal to the result of g_file_get_uri(). The following snippet
 * illustrates this:
 *
 * |[
 * GFile *f;
 * char *uri;
 *
 * file = g_file_new_for_commandline_arg (uri_from_commandline);
 *
 * uri = g_file_get_uri (file);
 * strcmp (uri, uri_from_commandline) == 0;
 * g_free (uri);
 *
 * if (g_file_has_uri_scheme (file, "cdda"))
 * {
 * // do something special with uri
 * }
 * g_object_unref (file);
 * ]|
 *
 * This code will work when both `cdda://sr0/Track 1.wav` and
 * `/home/user/.gvfs/cdda on sr0/Track 1.wav` is passed to the
 * application. It should be noted that it's generally not safe
 * for applications to rely on the format of a particular URIs.
 * Different launcher applications (e.g. file managers) may have
 * different ideas of what a given URI means.
 */
interface AppInfo
{

  static GType getType()
  {
    return g_app_info_get_type();
  }

  /**
   * new #GAppInfo for given command.
   */
  static AppInfo createFromCommandline(string commandline, string applicationName, AppInfoCreateFlags flags);

  /**
   * a newly allocated #GList of references to #GAppInfos.
   */
  static List!(AppInfo, GAppInfo*) getAll();

  /**
   * #GList of #GAppInfos
   * for given @content_type or %NULL on error.
   */
  static List!(AppInfo, GAppInfo*) getAllForType(string contentType);

  /**
   * #GAppInfo for given @content_type or
   * %NULL on error.
   */
  static AppInfo getDefaultForType(string contentType, bool mustSupportUris);

  /**
   * Asynchronously gets the default #GAppInfo for a given content type.
   */
  static void getDefaultForTypeAsync(string contentType, bool mustSupportUris, Cancellable cancellable, AsyncReadyCallback callback);

  /**
   * #GAppInfo for given @content_type or
   * %NULL on error.
   */
  static AppInfo getDefaultForTypeFinish(AsyncResult result);

  /**
   * #GAppInfo for given @uri_scheme or
   * %NULL on error.
   */
  static AppInfo getDefaultForUriScheme(string uriScheme);

  /**
   * Asynchronously gets the default application for handling URIs with
   * the given URI scheme. A URI scheme is the initial part
   * of the URI, up to but not including the ':', e.g. "http",
   * "ftp" or "sip".
   */
  static void getDefaultForUriSchemeAsync(string uriScheme, Cancellable cancellable, AsyncReadyCallback callback);

  /**
   * #GAppInfo for given @uri_scheme or
   * %NULL on error.
   */
  static AppInfo getDefaultForUriSchemeFinish(AsyncResult result);

  /**
   * #GList of #GAppInfos
   * for given @content_type or %NULL on error.
   */
  static List!(AppInfo, GAppInfo*) getFallbackForType(string contentType);

  /**
   * #GList of #GAppInfos
   * for given @content_type or %NULL on error.
   */
  static List!(AppInfo, GAppInfo*) getRecommendedForType(string contentType);

  /**
   * %TRUE on success, %FALSE on error.
   */
  static bool launchDefaultForUri(string uri, AppLaunchContext context);

  /**
   * Async version of g_app_info_launch_default_for_uri().
   *
   * This version is useful if you are interested in receiving
   * error information in the case where the application is
   * sandboxed and the portal may present an application chooser
   * dialog to the user.
   *
   * This is also useful if you want to be sure that the D-Bus–activated
   * applications are really started before termination and if you are interested
   * in receiving error information from their activation.
   */
  static void launchDefaultForUriAsync(string uri, AppLaunchContext context, Cancellable cancellable, AsyncReadyCallback callback);

  /**
   * %TRUE if the launch was successful, %FALSE if @error is set
   */
  static bool launchDefaultForUriFinish(AsyncResult result);

  /**
   * Removes all changes to the type associations done by
   * g_app_info_set_as_default_for_type(),
   * g_app_info_set_as_default_for_extension(),
   * g_app_info_add_supports_type() or
   * g_app_info_remove_supports_type().
   */
  static void resetTypeAssociations(string contentType);

  /**
   * %TRUE on success, %FALSE on error.
   */
  bool addSupportsType(string contentType);

  /**
   * %TRUE if @appinfo can be deleted
   */
  bool canDelete();

  /**
   * %TRUE if it is possible to remove supported
   * content types from a given @appinfo, %FALSE if not.
   */
  bool canRemoveSupportsType();

  /**
   * %TRUE if @appinfo has been deleted
   */
  bool delete_();

  /**
   * a duplicate of @appinfo.
   */
  AppInfo dup();

  /**
   * %TRUE if @appinfo1 is equal to @appinfo2. %FALSE otherwise.
   */
  bool equal(AppInfo appinfo2);

  /**
   * a string containing the @appinfo's commandline,
   * or %NULL if this information is not available
   */
  string getCommandline();

  /**
   * a string containing a description of the
   * application @appinfo, or %NULL if none.
   */
  string getDescription();

  /**
   * the display name of the application for @appinfo, or the name if
   * no display name is available.
   */
  string getDisplayName();

  /**
   * a string containing the @appinfo's application
   * binaries name
   */
  string getExecutable();

  /**
   * the default #GIcon for @appinfo or %NULL
   * if there is no default icon.
   */
  Icon getIcon();

  /**
   * a string containing the application's ID.
   */
  string getId();

  /**
   * the name of the application for @appinfo.
   */
  string getName();

  /**
   * a list of content types.
   */
  string[] getSupportedTypes();

  /**
   * %TRUE on successful launch, %FALSE otherwise.
   */
  bool launch(List!(File, GFile*) files, AppLaunchContext context);

  /**
   * %TRUE on successful launch, %FALSE otherwise.
   */
  bool launchUris(List!(string, char*) uris, AppLaunchContext context);

  /**
   * Async version of g_app_info_launch_uris().
   *
   * The @callback is invoked immediately after the application launch, but it
   * waits for activation in case of D-Bus–activated applications and also provides
   * extended error information for sandboxed applications, see notes for
   * g_app_info_launch_default_for_uri_async().
   */
  void launchUrisAsync(List!(string, char*) uris, AppLaunchContext context, Cancellable cancellable, AsyncReadyCallback callback);

  /**
   * %TRUE on successful launch, %FALSE otherwise.
   */
  bool launchUrisFinish(AsyncResult result);

  /**
   * %TRUE on success, %FALSE on error.
   */
  bool removeSupportsType(string contentType);

  /**
   * %TRUE on success, %FALSE on error.
   */
  bool setAsDefaultForExtension(string extension);

  /**
   * %TRUE on success, %FALSE on error.
   */
  bool setAsDefaultForType(string contentType);

  /**
   * %TRUE on success, %FALSE on error.
   */
  bool setAsLastUsedForType(string contentType);

  /**
   * %TRUE if the @appinfo should be shown, %FALSE otherwise.
   */
  bool shouldShow();

  /**
   * %TRUE if the @appinfo supports files.
   */
  bool supportsFiles();

  /**
   * %TRUE if the @appinfo supports URIs.
   */
  bool supportsUris();
}
