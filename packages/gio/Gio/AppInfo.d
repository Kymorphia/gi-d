module Gio.AppInfo;

public import Gio.AppInfoIfaceProxy;
import GLib.ErrorG;
import GLib.List;
import GObject.ObjectG;
import Gid.gid;
import Gio.AppLaunchContext;
import Gio.AsyncResult;
import Gio.AsyncResultT;
import Gio.Cancellable;
import Gio.File;
import Gio.FileT;
import Gio.Icon;
import Gio.IconT;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * Information about an installed application and methods to launch
 * it $(LPAREN)with file arguments$(RPAREN).
 * `GAppInfo` and `GAppLaunchContext` are used for describing and launching
 * applications installed on the system.
 * As of GLib 2.20, URIs will always be converted to POSIX paths
 * $(LPAREN)using [Gio.File.getPath]$(RPAREN) when using [Gio.AppInfo.launch]
 * even if the application requested an URI and not a POSIX path. For example
 * for a desktop-file based application with Exec key `totem
 * %U` and a single URI, `sftp://foo/file.avi`, then
 * `/home/user/.gvfs/sftp on foo/file.avi` will be passed. This will
 * only work if a set of suitable GIO extensions $(LPAREN)such as GVfs 2.26
 * compiled with FUSE support$(RPAREN), is available and operational; if this
 * is not the case, the URI will be passed unmodified to the application.
 * Some URIs, such as `mailto:`, of course cannot be mapped to a POSIX
 * path $(LPAREN)in GVfs there's no FUSE mount for it$(RPAREN); such URIs will be
 * passed unmodified to the application.
 * Specifically for GVfs 2.26 and later, the POSIX URI will be mapped
 * back to the GIO URI in the [Gio.File] constructors $(LPAREN)since GVfs
 * implements the GVfs extension point$(RPAREN). As such, if the application
 * needs to examine the URI, it needs to use [Gio.File.getUri]
 * or similar on [Gio.File]. In other words, an application cannot
 * assume that the URI passed to e.g. [Gio.File.newForCommandlineArg]
 * is equal to the result of [Gio.File.getUri]. The following snippet
 * illustrates this:
 * ```c
 * GFile *f;
 * char *uri;
 * file \= g_file_new_for_commandline_arg $(LPAREN)uri_from_commandline$(RPAREN);
 * uri \= g_file_get_uri $(LPAREN)file$(RPAREN);
 * strcmp $(LPAREN)uri, uri_from_commandline$(RPAREN) \=\= 0;
 * g_free $(LPAREN)uri$(RPAREN);
 * if $(LPAREN)g_file_has_uri_scheme $(LPAREN)file, "cdda"$(RPAREN)$(RPAREN)
 * {
 * // do something special with uri
 * }
 * g_object_unref $(LPAREN)file$(RPAREN);
 * ```
 * This code will work when both `cdda://sr0/Track 1.wav` and
 * `/home/user/.gvfs/cdda on sr0/Track 1.wav` is passed to the
 * application. It should be noted that it's generally not safe
 * for applications to rely on the format of a particular URIs.
 * Different launcher applications $(LPAREN)e.g. file managers$(RPAREN) may have
 * different ideas of what a given URI means.
 */
interface AppInfo
{

  static GType getType()
  {
    return g_app_info_get_type();
  }

  /**
   * Creates a new #GAppInfo from the given information.
   * Note that for commandline, the quoting rules of the Exec key of the
   * [freedesktop.org Desktop Entry Specification](http://freedesktop.org/Standards/desktop-entry-spec)
   * are applied. For example, if the commandline contains
   * percent-encoded URIs, the percent-character must be doubled in order to prevent it from
   * being swallowed by Exec key unquoting. See the specification for exact quoting rules.
   * Params:
   *   commandline = the commandline to use
   *   applicationName = the application name, or %NULL to use commandline
   *   flags = flags that can specify details of the created #GAppInfo
   * Returns: new #GAppInfo for given command.
   */
  static AppInfo createFromCommandline(string commandline, string applicationName, AppInfoCreateFlags flags)
  {
    GAppInfo* _cretval;
    const(char)* _commandline = commandline.toCString(false);
    const(char)* _applicationName = applicationName.toCString(false);
    GError *_err;
    _cretval = g_app_info_create_from_commandline(_commandline, _applicationName, flags, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = _cretval ? ObjectG.getDObject!AppInfo(cast(GAppInfo*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Gets a list of all of the applications currently registered
   * on this system.
   * For desktop files, this includes applications that have
   * `NoDisplay\=true` set or are excluded from display by means
   * of `OnlyShowIn` or `NotShowIn`. See [Gio.AppInfo.shouldShow].
   * The returned list does not include applications which have
   * the `Hidden` key set.
   * Returns: a newly allocated #GList of references to #GAppInfos.
   */
  static List!(AppInfo, GAppInfo) getAll()
  {
    GList* _cretval;
    _cretval = g_app_info_get_all();
    List!(AppInfo, GAppInfo) _retval = new List!(AppInfo, GAppInfo)(cast(GList*)_cretval, GidOwnership.Full);
    return _retval;
  }

  /**
   * Gets a list of all #GAppInfos for a given content type,
   * including the recommended and fallback #GAppInfos. See
   * [Gio.AppInfo.getRecommendedForType] and
   * [Gio.AppInfo.getFallbackForType].
   * Params:
   *   contentType = the content type to find a #GAppInfo for
   * Returns: #GList of #GAppInfos
   *   for given content_type or %NULL on error.
   */
  static List!(AppInfo, GAppInfo) getAllForType(string contentType)
  {
    GList* _cretval;
    const(char)* _contentType = contentType.toCString(false);
    _cretval = g_app_info_get_all_for_type(_contentType);
    List!(AppInfo, GAppInfo) _retval = new List!(AppInfo, GAppInfo)(cast(GList*)_cretval, GidOwnership.Full);
    return _retval;
  }

  /**
   * Gets the default #GAppInfo for a given content type.
   * Params:
   *   contentType = the content type to find a #GAppInfo for
   *   mustSupportUris = if %TRUE, the #GAppInfo is expected to
   *     support URIs
   * Returns: #GAppInfo for given content_type or
   *   %NULL on error.
   */
  static AppInfo getDefaultForType(string contentType, bool mustSupportUris)
  {
    GAppInfo* _cretval;
    const(char)* _contentType = contentType.toCString(false);
    _cretval = g_app_info_get_default_for_type(_contentType, mustSupportUris);
    auto _retval = _cretval ? ObjectG.getDObject!AppInfo(cast(GAppInfo*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Asynchronously gets the default #GAppInfo for a given content type.
   * Params:
   *   contentType = the content type to find a #GAppInfo for
   *   mustSupportUris = if %TRUE, the #GAppInfo is expected to
   *     support URIs
   *   cancellable = optional #GCancellable object, %NULL to ignore
   *   callback = a #GAsyncReadyCallback to call when the request is done
   */
  static void getDefaultForTypeAsync(string contentType, bool mustSupportUris, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(AsyncReadyCallback*)data;

      (*_dlg)(sourceObject ? ObjectG.getDObject!ObjectG(cast(void*)sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(cast(void*)res, false) : null);
    }

    const(char)* _contentType = contentType.toCString(false);
    auto _callback = freezeDelegate(cast(void*)&callback);
    g_app_info_get_default_for_type_async(_contentType, mustSupportUris, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_callbackCallback, _callback);
  }

  /**
   * Finishes a default #GAppInfo lookup started by
   * [Gio.AppInfo.getDefaultForTypeAsync].
   * If no #GAppInfo is found, then error will be set to %G_IO_ERROR_NOT_FOUND.
   * Params:
   *   result = a #GAsyncResult
   * Returns: #GAppInfo for given content_type or
   *   %NULL on error.
   */
  static AppInfo getDefaultForTypeFinish(AsyncResult result)
  {
    GAppInfo* _cretval;
    GError *_err;
    _cretval = g_app_info_get_default_for_type_finish(result ? cast(GAsyncResult*)(cast(ObjectG)result).cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = _cretval ? ObjectG.getDObject!AppInfo(cast(GAppInfo*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Gets the default application for handling URIs with
   * the given URI scheme. A URI scheme is the initial part
   * of the URI, up to but not including the ':', e.g. "http",
   * "ftp" or "sip".
   * Params:
   *   uriScheme = a string containing a URI scheme.
   * Returns: #GAppInfo for given uri_scheme or
   *   %NULL on error.
   */
  static AppInfo getDefaultForUriScheme(string uriScheme)
  {
    GAppInfo* _cretval;
    const(char)* _uriScheme = uriScheme.toCString(false);
    _cretval = g_app_info_get_default_for_uri_scheme(_uriScheme);
    auto _retval = _cretval ? ObjectG.getDObject!AppInfo(cast(GAppInfo*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Asynchronously gets the default application for handling URIs with
   * the given URI scheme. A URI scheme is the initial part
   * of the URI, up to but not including the ':', e.g. "http",
   * "ftp" or "sip".
   * Params:
   *   uriScheme = a string containing a URI scheme.
   *   cancellable = optional #GCancellable object, %NULL to ignore
   *   callback = a #GAsyncReadyCallback to call when the request is done
   */
  static void getDefaultForUriSchemeAsync(string uriScheme, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(AsyncReadyCallback*)data;

      (*_dlg)(sourceObject ? ObjectG.getDObject!ObjectG(cast(void*)sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(cast(void*)res, false) : null);
    }

    const(char)* _uriScheme = uriScheme.toCString(false);
    auto _callback = freezeDelegate(cast(void*)&callback);
    g_app_info_get_default_for_uri_scheme_async(_uriScheme, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_callbackCallback, _callback);
  }

  /**
   * Finishes a default #GAppInfo lookup started by
   * [Gio.AppInfo.getDefaultForUriSchemeAsync].
   * If no #GAppInfo is found, then error will be set to %G_IO_ERROR_NOT_FOUND.
   * Params:
   *   result = a #GAsyncResult
   * Returns: #GAppInfo for given uri_scheme or
   *   %NULL on error.
   */
  static AppInfo getDefaultForUriSchemeFinish(AsyncResult result)
  {
    GAppInfo* _cretval;
    GError *_err;
    _cretval = g_app_info_get_default_for_uri_scheme_finish(result ? cast(GAsyncResult*)(cast(ObjectG)result).cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = _cretval ? ObjectG.getDObject!AppInfo(cast(GAppInfo*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Gets a list of fallback #GAppInfos for a given content type, i.e.
   * those applications which claim to support the given content type
   * by MIME type subclassing and not directly.
   * Params:
   *   contentType = the content type to find a #GAppInfo for
   * Returns: #GList of #GAppInfos
   *   for given content_type or %NULL on error.
   */
  static List!(AppInfo, GAppInfo) getFallbackForType(string contentType)
  {
    GList* _cretval;
    const(char)* _contentType = contentType.toCString(false);
    _cretval = g_app_info_get_fallback_for_type(_contentType);
    List!(AppInfo, GAppInfo) _retval = new List!(AppInfo, GAppInfo)(cast(GList*)_cretval, GidOwnership.Full);
    return _retval;
  }

  /**
   * Gets a list of recommended #GAppInfos for a given content type, i.e.
   * those applications which claim to support the given content type exactly,
   * and not by MIME type subclassing.
   * Note that the first application of the list is the last used one, i.e.
   * the last one for which [Gio.AppInfo.setAsLastUsedForType] has been
   * called.
   * Params:
   *   contentType = the content type to find a #GAppInfo for
   * Returns: #GList of #GAppInfos
   *   for given content_type or %NULL on error.
   */
  static List!(AppInfo, GAppInfo) getRecommendedForType(string contentType)
  {
    GList* _cretval;
    const(char)* _contentType = contentType.toCString(false);
    _cretval = g_app_info_get_recommended_for_type(_contentType);
    List!(AppInfo, GAppInfo) _retval = new List!(AppInfo, GAppInfo)(cast(GList*)_cretval, GidOwnership.Full);
    return _retval;
  }

  /**
   * Utility function that launches the default application
   * registered to handle the specified uri. Synchronous I/O
   * is done on the uri to detect the type of the file if
   * required.
   * The D-Bus–activated applications don't have to be started if your application
   * terminates too soon after this function. To prevent this, use
   * [Gio.AppInfo.launchDefaultForUriAsync] instead.
   * Params:
   *   uri = the uri to show
   *   context = an optional #GAppLaunchContext
   * Returns: %TRUE on success, %FALSE on error.
   */
  static bool launchDefaultForUri(string uri, AppLaunchContext context)
  {
    bool _retval;
    const(char)* _uri = uri.toCString(false);
    GError *_err;
    _retval = g_app_info_launch_default_for_uri(_uri, context ? cast(GAppLaunchContext*)context.cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Async version of [Gio.AppInfo.launchDefaultForUri].
   * This version is useful if you are interested in receiving
   * error information in the case where the application is
   * sandboxed and the portal may present an application chooser
   * dialog to the user.
   * This is also useful if you want to be sure that the D-Bus–activated
   * applications are really started before termination and if you are interested
   * in receiving error information from their activation.
   * Params:
   *   uri = the uri to show
   *   context = an optional #GAppLaunchContext
   *   cancellable = a #GCancellable
   *   callback = a #GAsyncReadyCallback to call when the request is done
   */
  static void launchDefaultForUriAsync(string uri, AppLaunchContext context, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(AsyncReadyCallback*)data;

      (*_dlg)(sourceObject ? ObjectG.getDObject!ObjectG(cast(void*)sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(cast(void*)res, false) : null);
    }

    const(char)* _uri = uri.toCString(false);
    auto _callback = freezeDelegate(cast(void*)&callback);
    g_app_info_launch_default_for_uri_async(_uri, context ? cast(GAppLaunchContext*)context.cPtr(false) : null, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_callbackCallback, _callback);
  }

  /**
   * Finishes an asynchronous launch-default-for-uri operation.
   * Params:
   *   result = a #GAsyncResult
   * Returns: %TRUE if the launch was successful, %FALSE if error is set
   */
  static bool launchDefaultForUriFinish(AsyncResult result)
  {
    bool _retval;
    GError *_err;
    _retval = g_app_info_launch_default_for_uri_finish(result ? cast(GAsyncResult*)(cast(ObjectG)result).cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Removes all changes to the type associations done by
   * [Gio.AppInfo.setAsDefaultForType],
   * [Gio.AppInfo.setAsDefaultForExtension],
   * [Gio.AppInfo.addSupportsType] or
   * [Gio.AppInfo.removeSupportsType].
   * Params:
   *   contentType = a content type
   */
  static void resetTypeAssociations(string contentType)
  {
    const(char)* _contentType = contentType.toCString(false);
    g_app_info_reset_type_associations(_contentType);
  }

  /**
   * Adds a content type to the application information to indicate the
   * application is capable of opening files with the given content type.
   * Params:
   *   contentType = a string.
   * Returns: %TRUE on success, %FALSE on error.
   */
  bool addSupportsType(string contentType);

  /**
   * Obtains the information whether the #GAppInfo can be deleted.
   * See [Gio.AppInfo.delete_].
   * Returns: %TRUE if appinfo can be deleted
   */
  bool canDelete();

  /**
   * Checks if a supported content type can be removed from an application.
   * Returns: %TRUE if it is possible to remove supported
   *   content types from a given appinfo, %FALSE if not.
   */
  bool canRemoveSupportsType();

  /**
   * Tries to delete a #GAppInfo.
   * On some platforms, there may be a difference between user-defined
   * #GAppInfos which can be deleted, and system-wide ones which cannot.
   * See [Gio.AppInfo.canDelete].
   * Returns: %TRUE if appinfo has been deleted
   */
  bool delete_();

  /**
   * Creates a duplicate of a #GAppInfo.
   * Returns: a duplicate of appinfo.
   */
  AppInfo dup();

  /**
   * Checks if two #GAppInfos are equal.
   * Note that the check *may not* compare each individual
   * field, and only does an identity check. In case detecting changes in the
   * contents is needed, program code must additionally compare relevant fields.
   * Params:
   *   appinfo2 = the second #GAppInfo.
   * Returns: %TRUE if appinfo1 is equal to appinfo2. %FALSE otherwise.
   */
  bool equal(AppInfo appinfo2);

  /**
   * Gets the commandline with which the application will be
   * started.
   * Returns: a string containing the appinfo's commandline,
   *   or %NULL if this information is not available
   */
  string getCommandline();

  /**
   * Gets a human-readable description of an installed application.
   * Returns: a string containing a description of the
   *   application appinfo, or %NULL if none.
   */
  string getDescription();

  /**
   * Gets the display name of the application. The display name is often more
   * descriptive to the user than the name itself.
   * Returns: the display name of the application for appinfo, or the name if
   *   no display name is available.
   */
  string getDisplayName();

  /**
   * Gets the executable's name for the installed application.
   * This is intended to be used for debugging or labelling what program is going
   * to be run. To launch the executable, use [Gio.AppInfo.launch] and related
   * functions, rather than spawning the return value from this function.
   * Returns: a string containing the appinfo's application
   *   binaries name
   */
  string getExecutable();

  /**
   * Gets the icon for the application.
   * Returns: the default #GIcon for appinfo or %NULL
   *   if there is no default icon.
   */
  Icon getIcon();

  /**
   * Gets the ID of an application. An id is a string that
   * identifies the application. The exact format of the id is
   * platform dependent. For instance, on Unix this is the
   * desktop file id from the xdg menu specification.
   * Note that the returned ID may be %NULL, depending on how
   * the appinfo has been constructed.
   * Returns: a string containing the application's ID.
   */
  string getId();

  /**
   * Gets the installed name of the application.
   * Returns: the name of the application for appinfo.
   */
  string getName();

  /**
   * Retrieves the list of content types that app_info claims to support.
   * If this information is not provided by the environment, this function
   * will return %NULL.
   * This function does not take in consideration associations added with
   * [Gio.AppInfo.addSupportsType], but only those exported directly by
   * the application.
   * Returns: a list of content types.
   */
  string[] getSupportedTypes();

  /**
   * Launches the application. Passes files to the launched application
   * as arguments, using the optional context to get information
   * about the details of the launcher $(LPAREN)like what screen it is on$(RPAREN).
   * On error, error will be set accordingly.
   * To launch the application without arguments pass a %NULL files list.
   * Note that even if the launch is successful the application launched
   * can fail to start if it runs into problems during startup. There is
   * no way to detect this.
   * Some URIs can be changed when passed through a GFile $(LPAREN)for instance
   * unsupported URIs with strange formats like mailto:$(RPAREN), so if you have
   * a textual URI you want to pass in as argument, consider using
   * [Gio.AppInfo.launchUris] instead.
   * The launched application inherits the environment of the launching
   * process, but it can be modified with [Gio.AppLaunchContext.setenv]
   * and [Gio.AppLaunchContext.unsetenv].
   * On UNIX, this function sets the `GIO_LAUNCHED_DESKTOP_FILE`
   * environment variable with the path of the launched desktop file and
   * `GIO_LAUNCHED_DESKTOP_FILE_PID` to the process id of the launched
   * process. This can be used to ignore `GIO_LAUNCHED_DESKTOP_FILE`,
   * should it be inherited by further processes. The `DISPLAY`,
   * `XDG_ACTIVATION_TOKEN` and `DESKTOP_STARTUP_ID` environment
   * variables are also set, based on information provided in context.
   * Params:
   *   files = a #GList of #GFile objects
   *   context = a #GAppLaunchContext or %NULL
   * Returns: %TRUE on successful launch, %FALSE otherwise.
   */
  bool launch(List!(File, GFile) files, AppLaunchContext context);

  /**
   * Launches the application. This passes the uris to the launched application
   * as arguments, using the optional context to get information
   * about the details of the launcher $(LPAREN)like what screen it is on$(RPAREN).
   * On error, error will be set accordingly. If the application only supports
   * one URI per invocation as part of their command-line, multiple instances
   * of the application will be spawned.
   * To launch the application without arguments pass a %NULL uris list.
   * Note that even if the launch is successful the application launched
   * can fail to start if it runs into problems during startup. There is
   * no way to detect this.
   * Params:
   *   uris = a #GList containing URIs to launch.
   *   context = a #GAppLaunchContext or %NULL
   * Returns: %TRUE on successful launch, %FALSE otherwise.
   */
  bool launchUris(List!(string, char*) uris, AppLaunchContext context);

  /**
   * Async version of [Gio.AppInfo.launchUris].
   * The callback is invoked immediately after the application launch, but it
   * waits for activation in case of D-Bus–activated applications and also provides
   * extended error information for sandboxed applications, see notes for
   * [Gio.AppInfo.launchDefaultForUriAsync].
   * Params:
   *   uris = a #GList containing URIs to launch.
   *   context = a #GAppLaunchContext or %NULL
   *   cancellable = a #GCancellable
   *   callback = a #GAsyncReadyCallback to call when the request is done
   */
  void launchUrisAsync(List!(string, char*) uris, AppLaunchContext context, Cancellable cancellable, AsyncReadyCallback callback);

  /**
   * Finishes a [Gio.AppInfo.launchUrisAsync] operation.
   * Params:
   *   result = a #GAsyncResult
   * Returns: %TRUE on successful launch, %FALSE otherwise.
   */
  bool launchUrisFinish(AsyncResult result);

  /**
   * Removes a supported type from an application, if possible.
   * Params:
   *   contentType = a string.
   * Returns: %TRUE on success, %FALSE on error.
   */
  bool removeSupportsType(string contentType);

  /**
   * Sets the application as the default handler for the given file extension.
   * Params:
   *   extension = a string containing the file extension
   *     $(LPAREN)without the dot$(RPAREN).
   * Returns: %TRUE on success, %FALSE on error.
   */
  bool setAsDefaultForExtension(string extension);

  /**
   * Sets the application as the default handler for a given type.
   * Params:
   *   contentType = the content type.
   * Returns: %TRUE on success, %FALSE on error.
   */
  bool setAsDefaultForType(string contentType);

  /**
   * Sets the application as the last used application for a given type.
   * This will make the application appear as first in the list returned
   * by [Gio.AppInfo.getRecommendedForType], regardless of the default
   * application for that content type.
   * Params:
   *   contentType = the content type.
   * Returns: %TRUE on success, %FALSE on error.
   */
  bool setAsLastUsedForType(string contentType);

  /**
   * Checks if the application info should be shown in menus that
   * list available applications.
   * Returns: %TRUE if the appinfo should be shown, %FALSE otherwise.
   */
  bool shouldShow();

  /**
   * Checks if the application accepts files as arguments.
   * Returns: %TRUE if the appinfo supports files.
   */
  bool supportsFiles();

  /**
   * Checks if the application supports reading files and directories from URIs.
   * Returns: %TRUE if the appinfo supports URIs.
   */
  bool supportsUris();
}
