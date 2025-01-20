module Gio.AppInfoT;

public import Gio.AppInfoIfaceProxy;
public import GLib.ErrorG;
public import GLib.List;
public import GObject.ObjectG;
public import Gid.gid;
public import Gio.AppLaunchContext;
public import Gio.AsyncResult;
public import Gio.AsyncResultT;
public import Gio.Cancellable;
public import Gio.File;
public import Gio.FileT;
public import Gio.Icon;
public import Gio.IconT;
public import Gio.Types;
public import Gio.c.functions;
public import Gio.c.types;

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
template AppInfoT()
{
















  /**
   * Adds a content type to the application information to indicate the
   * application is capable of opening files with the given content type.
   * Params:
   *   contentType = a string.
   * Returns: %TRUE on success, %FALSE on error.
   */
  override bool addSupportsType(string contentType)
  {
    bool _retval;
    const(char)* _contentType = contentType.toCString(false);
    GError *_err;
    _retval = g_app_info_add_supports_type(cast(GAppInfo*)cPtr, _contentType, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Obtains the information whether the #GAppInfo can be deleted.
   * See [Gio.AppInfo.delete_].
   * Returns: %TRUE if appinfo can be deleted
   */
  override bool canDelete()
  {
    bool _retval;
    _retval = g_app_info_can_delete(cast(GAppInfo*)cPtr);
    return _retval;
  }

  /**
   * Checks if a supported content type can be removed from an application.
   * Returns: %TRUE if it is possible to remove supported
   *   content types from a given appinfo, %FALSE if not.
   */
  override bool canRemoveSupportsType()
  {
    bool _retval;
    _retval = g_app_info_can_remove_supports_type(cast(GAppInfo*)cPtr);
    return _retval;
  }

  /**
   * Tries to delete a #GAppInfo.
   * On some platforms, there may be a difference between user-defined
   * #GAppInfos which can be deleted, and system-wide ones which cannot.
   * See [Gio.AppInfo.canDelete].
   * Returns: %TRUE if appinfo has been deleted
   */
  override bool delete_()
  {
    bool _retval;
    _retval = g_app_info_delete(cast(GAppInfo*)cPtr);
    return _retval;
  }

  /**
   * Creates a duplicate of a #GAppInfo.
   * Returns: a duplicate of appinfo.
   */
  override AppInfo dup()
  {
    GAppInfo* _cretval;
    _cretval = g_app_info_dup(cast(GAppInfo*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!AppInfo(cast(GAppInfo*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Checks if two #GAppInfos are equal.
   * Note that the check *may not* compare each individual
   * field, and only does an identity check. In case detecting changes in the
   * contents is needed, program code must additionally compare relevant fields.
   * Params:
   *   appinfo2 = the second #GAppInfo.
   * Returns: %TRUE if appinfo1 is equal to appinfo2. %FALSE otherwise.
   */
  override bool equal(AppInfo appinfo2)
  {
    bool _retval;
    _retval = g_app_info_equal(cast(GAppInfo*)cPtr, appinfo2 ? cast(GAppInfo*)(cast(ObjectG)appinfo2).cPtr(false) : null);
    return _retval;
  }

  /**
   * Gets the commandline with which the application will be
   * started.
   * Returns: a string containing the appinfo's commandline,
   *   or %NULL if this information is not available
   */
  override string getCommandline()
  {
    const(char)* _cretval;
    _cretval = g_app_info_get_commandline(cast(GAppInfo*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Gets a human-readable description of an installed application.
   * Returns: a string containing a description of the
   *   application appinfo, or %NULL if none.
   */
  override string getDescription()
  {
    const(char)* _cretval;
    _cretval = g_app_info_get_description(cast(GAppInfo*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Gets the display name of the application. The display name is often more
   * descriptive to the user than the name itself.
   * Returns: the display name of the application for appinfo, or the name if
   *   no display name is available.
   */
  override string getDisplayName()
  {
    const(char)* _cretval;
    _cretval = g_app_info_get_display_name(cast(GAppInfo*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Gets the executable's name for the installed application.
   * This is intended to be used for debugging or labelling what program is going
   * to be run. To launch the executable, use [Gio.AppInfo.launch] and related
   * functions, rather than spawning the return value from this function.
   * Returns: a string containing the appinfo's application
   *   binaries name
   */
  override string getExecutable()
  {
    const(char)* _cretval;
    _cretval = g_app_info_get_executable(cast(GAppInfo*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Gets the icon for the application.
   * Returns: the default #GIcon for appinfo or %NULL
   *   if there is no default icon.
   */
  override Icon getIcon()
  {
    GIcon* _cretval;
    _cretval = g_app_info_get_icon(cast(GAppInfo*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Icon(cast(GIcon*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the ID of an application. An id is a string that
   * identifies the application. The exact format of the id is
   * platform dependent. For instance, on Unix this is the
   * desktop file id from the xdg menu specification.
   * Note that the returned ID may be %NULL, depending on how
   * the appinfo has been constructed.
   * Returns: a string containing the application's ID.
   */
  override string getId()
  {
    const(char)* _cretval;
    _cretval = g_app_info_get_id(cast(GAppInfo*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Gets the installed name of the application.
   * Returns: the name of the application for appinfo.
   */
  override string getName()
  {
    const(char)* _cretval;
    _cretval = g_app_info_get_name(cast(GAppInfo*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Retrieves the list of content types that app_info claims to support.
   * If this information is not provided by the environment, this function
   * will return %NULL.
   * This function does not take in consideration associations added with
   * [Gio.AppInfo.addSupportsType], but only those exported directly by
   * the application.
   * Returns: a list of content types.
   */
  override string[] getSupportedTypes()
  {
    const(char*)* _cretval;
    _cretval = g_app_info_get_supported_types(cast(GAppInfo*)cPtr);
    string[] _retval;

    if (_cretval)
    {
      uint _cretlength;
      for (; _cretval[_cretlength] !is null; _cretlength++)
        break;
      _retval = new string[_cretlength];
      foreach (i; 0 .. _cretlength)
        _retval[i] = _cretval[i].fromCString(false);
    }
    return _retval;
  }

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
  override bool launch(List!(File) files, AppLaunchContext context)
  {
    bool _retval;
    GError *_err;
    _retval = g_app_info_launch(cast(GAppInfo*)cPtr, files.cPtr, context ? cast(GAppLaunchContext*)context.cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

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
  override bool launchUris(List!(string) uris, AppLaunchContext context)
  {
    bool _retval;
    GError *_err;
    _retval = g_app_info_launch_uris(cast(GAppInfo*)cPtr, uris.cPtr, context ? cast(GAppLaunchContext*)context.cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

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
  override void launchUrisAsync(List!(string) uris, AppLaunchContext context, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(AsyncReadyCallback*)data;

      (*_dlg)(sourceObject ? ObjectG.getDObject!ObjectG(cast(void*)sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(cast(void*)res, false) : null);
    }

    auto _callback = freezeDelegate(cast(void*)&callback);
    g_app_info_launch_uris_async(cast(GAppInfo*)cPtr, uris.cPtr, context ? cast(GAppLaunchContext*)context.cPtr(false) : null, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_callbackCallback, _callback);
  }

  /**
   * Finishes a [Gio.AppInfo.launchUrisAsync] operation.
   * Params:
   *   result = a #GAsyncResult
   * Returns: %TRUE on successful launch, %FALSE otherwise.
   */
  override bool launchUrisFinish(AsyncResult result)
  {
    bool _retval;
    GError *_err;
    _retval = g_app_info_launch_uris_finish(cast(GAppInfo*)cPtr, result ? cast(GAsyncResult*)(cast(ObjectG)result).cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Removes a supported type from an application, if possible.
   * Params:
   *   contentType = a string.
   * Returns: %TRUE on success, %FALSE on error.
   */
  override bool removeSupportsType(string contentType)
  {
    bool _retval;
    const(char)* _contentType = contentType.toCString(false);
    GError *_err;
    _retval = g_app_info_remove_supports_type(cast(GAppInfo*)cPtr, _contentType, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Sets the application as the default handler for the given file extension.
   * Params:
   *   extension = a string containing the file extension
   *     $(LPAREN)without the dot$(RPAREN).
   * Returns: %TRUE on success, %FALSE on error.
   */
  override bool setAsDefaultForExtension(string extension)
  {
    bool _retval;
    const(char)* _extension = extension.toCString(false);
    GError *_err;
    _retval = g_app_info_set_as_default_for_extension(cast(GAppInfo*)cPtr, _extension, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Sets the application as the default handler for a given type.
   * Params:
   *   contentType = the content type.
   * Returns: %TRUE on success, %FALSE on error.
   */
  override bool setAsDefaultForType(string contentType)
  {
    bool _retval;
    const(char)* _contentType = contentType.toCString(false);
    GError *_err;
    _retval = g_app_info_set_as_default_for_type(cast(GAppInfo*)cPtr, _contentType, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Sets the application as the last used application for a given type.
   * This will make the application appear as first in the list returned
   * by [Gio.AppInfo.getRecommendedForType], regardless of the default
   * application for that content type.
   * Params:
   *   contentType = the content type.
   * Returns: %TRUE on success, %FALSE on error.
   */
  override bool setAsLastUsedForType(string contentType)
  {
    bool _retval;
    const(char)* _contentType = contentType.toCString(false);
    GError *_err;
    _retval = g_app_info_set_as_last_used_for_type(cast(GAppInfo*)cPtr, _contentType, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Checks if the application info should be shown in menus that
   * list available applications.
   * Returns: %TRUE if the appinfo should be shown, %FALSE otherwise.
   */
  override bool shouldShow()
  {
    bool _retval;
    _retval = g_app_info_should_show(cast(GAppInfo*)cPtr);
    return _retval;
  }

  /**
   * Checks if the application accepts files as arguments.
   * Returns: %TRUE if the appinfo supports files.
   */
  override bool supportsFiles()
  {
    bool _retval;
    _retval = g_app_info_supports_files(cast(GAppInfo*)cPtr);
    return _retval;
  }

  /**
   * Checks if the application supports reading files and directories from URIs.
   * Returns: %TRUE if the appinfo supports URIs.
   */
  override bool supportsUris()
  {
    bool _retval;
    _retval = g_app_info_supports_uris(cast(GAppInfo*)cPtr);
    return _retval;
  }
}
