module Gio.AppInfoT;

public import GLib.ErrorG;
public import GLib.List;
public import GLib.Types;
public import GObject.ObjectG;
public import GObject.Types;
public import Gid.Gid;
public import Gio.AppLaunchContext;
public import Gio.AsyncResult;
public import Gio.Cancellable;
public import Gio.File;
public import Gio.Icon;
public import Gio.Types;
public import Gio.c.functions;
public import Gio.c.types;

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
template AppInfoT(TStruct)
{

  /**
   * new #GAppInfo for given command.
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
    AppInfo _retval = ObjectG.getDObject!AppInfo(cast(GAppInfo*)_cretval, true);
    return _retval;
  }

  /**
   * a newly allocated #GList of references to #GAppInfos.
   */
  static List!(AppInfo, GAppInfo*) getAll()
  {
    GList* _cretval;
    _cretval = g_app_info_get_all();
    List!(AppInfo, GAppInfo*) _retval = _cretval ? new List!(AppInfo, GAppInfo*)(_cretval, GidOwnership.Full) : null;
    return _retval;
  }

  /**
   * #GList of #GAppInfos
   * for given @content_type or %NULL on error.
   */
  static List!(AppInfo, GAppInfo*) getAllForType(string contentType)
  {
    GList* _cretval;
    const(char)* _contentType = contentType.toCString(false);
    _cretval = g_app_info_get_all_for_type(_contentType);
    List!(AppInfo, GAppInfo*) _retval = _cretval ? new List!(AppInfo, GAppInfo*)(_cretval, GidOwnership.Full) : null;
    return _retval;
  }

  /**
   * #GAppInfo for given @content_type or
   * %NULL on error.
   */
  static AppInfo getDefaultForType(string contentType, bool mustSupportUris)
  {
    GAppInfo* _cretval;
    const(char)* _contentType = contentType.toCString(false);
    _cretval = g_app_info_get_default_for_type(_contentType, mustSupportUris);
    AppInfo _retval = ObjectG.getDObject!AppInfo(cast(GAppInfo*)_cretval, true);
    return _retval;
  }

  /**
   * Asynchronously gets the default #GAppInfo for a given content type.
   */
  static void getDefaultForTypeAsync(string contentType, bool mustSupportUris, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    const(char)* _contentType = contentType.toCString(false);
    ptrFreezeGC(cast(void*)&callback);
    g_app_info_get_default_for_type_async(_contentType, mustSupportUris, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * #GAppInfo for given @content_type or
   * %NULL on error.
   */
  static AppInfo getDefaultForTypeFinish(AsyncResult result)
  {
    GAppInfo* _cretval;
    GError *_err;
    _cretval = g_app_info_get_default_for_type_finish(result ? (cast(ObjectG)result).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    AppInfo _retval = ObjectG.getDObject!AppInfo(cast(GAppInfo*)_cretval, true);
    return _retval;
  }

  /**
   * #GAppInfo for given @uri_scheme or
   * %NULL on error.
   */
  static AppInfo getDefaultForUriScheme(string uriScheme)
  {
    GAppInfo* _cretval;
    const(char)* _uriScheme = uriScheme.toCString(false);
    _cretval = g_app_info_get_default_for_uri_scheme(_uriScheme);
    AppInfo _retval = ObjectG.getDObject!AppInfo(cast(GAppInfo*)_cretval, true);
    return _retval;
  }

  /**
   * Asynchronously gets the default application for handling URIs with
   * the given URI scheme. A URI scheme is the initial part
   * of the URI, up to but not including the ':', e.g. "http",
   * "ftp" or "sip".
   */
  static void getDefaultForUriSchemeAsync(string uriScheme, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    const(char)* _uriScheme = uriScheme.toCString(false);
    ptrFreezeGC(cast(void*)&callback);
    g_app_info_get_default_for_uri_scheme_async(_uriScheme, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * #GAppInfo for given @uri_scheme or
   * %NULL on error.
   */
  static AppInfo getDefaultForUriSchemeFinish(AsyncResult result)
  {
    GAppInfo* _cretval;
    GError *_err;
    _cretval = g_app_info_get_default_for_uri_scheme_finish(result ? (cast(ObjectG)result).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    AppInfo _retval = ObjectG.getDObject!AppInfo(cast(GAppInfo*)_cretval, true);
    return _retval;
  }

  /**
   * #GList of #GAppInfos
   * for given @content_type or %NULL on error.
   */
  static List!(AppInfo, GAppInfo*) getFallbackForType(string contentType)
  {
    GList* _cretval;
    const(char)* _contentType = contentType.toCString(false);
    _cretval = g_app_info_get_fallback_for_type(_contentType);
    List!(AppInfo, GAppInfo*) _retval = _cretval ? new List!(AppInfo, GAppInfo*)(_cretval, GidOwnership.Full) : null;
    return _retval;
  }

  /**
   * #GList of #GAppInfos
   * for given @content_type or %NULL on error.
   */
  static List!(AppInfo, GAppInfo*) getRecommendedForType(string contentType)
  {
    GList* _cretval;
    const(char)* _contentType = contentType.toCString(false);
    _cretval = g_app_info_get_recommended_for_type(_contentType);
    List!(AppInfo, GAppInfo*) _retval = _cretval ? new List!(AppInfo, GAppInfo*)(_cretval, GidOwnership.Full) : null;
    return _retval;
  }

  /**
   * %TRUE on success, %FALSE on error.
   */
  static bool launchDefaultForUri(string uri, AppLaunchContext context)
  {
    bool _retval;
    const(char)* _uri = uri.toCString(false);
    GError *_err;
    _retval = g_app_info_launch_default_for_uri(_uri, context ? context.cPtr!GAppLaunchContext : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

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
  static void launchDefaultForUriAsync(string uri, AppLaunchContext context, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    const(char)* _uri = uri.toCString(false);
    ptrFreezeGC(cast(void*)&callback);
    g_app_info_launch_default_for_uri_async(_uri, context ? context.cPtr!GAppLaunchContext : null, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * %TRUE if the launch was successful, %FALSE if @error is set
   */
  static bool launchDefaultForUriFinish(AsyncResult result)
  {
    bool _retval;
    GError *_err;
    _retval = g_app_info_launch_default_for_uri_finish(result ? (cast(ObjectG)result).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Removes all changes to the type associations done by
   * g_app_info_set_as_default_for_type(),
   * g_app_info_set_as_default_for_extension(),
   * g_app_info_add_supports_type() or
   * g_app_info_remove_supports_type().
   */
  static void resetTypeAssociations(string contentType)
  {
    const(char)* _contentType = contentType.toCString(false);
    g_app_info_reset_type_associations(_contentType);
  }

  /**
   * %TRUE on success, %FALSE on error.
   */
  override bool addSupportsType(string contentType)
  {
    bool _retval;
    const(char)* _contentType = contentType.toCString(false);
    GError *_err;
    _retval = g_app_info_add_supports_type(cPtr!GAppInfo, _contentType, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * %TRUE if @appinfo can be deleted
   */
  override bool canDelete()
  {
    bool _retval;
    _retval = g_app_info_can_delete(cPtr!GAppInfo);
    return _retval;
  }

  /**
   * %TRUE if it is possible to remove supported
   * content types from a given @appinfo, %FALSE if not.
   */
  override bool canRemoveSupportsType()
  {
    bool _retval;
    _retval = g_app_info_can_remove_supports_type(cPtr!GAppInfo);
    return _retval;
  }

  /**
   * %TRUE if @appinfo has been deleted
   */
  override bool delete_()
  {
    bool _retval;
    _retval = g_app_info_delete(cPtr!GAppInfo);
    return _retval;
  }

  /**
   * a duplicate of @appinfo.
   */
  override AppInfo dup()
  {
    GAppInfo* _cretval;
    _cretval = g_app_info_dup(cPtr!GAppInfo);
    AppInfo _retval = ObjectG.getDObject!AppInfo(cast(GAppInfo*)_cretval, true);
    return _retval;
  }

  /**
   * %TRUE if @appinfo1 is equal to @appinfo2. %FALSE otherwise.
   */
  override bool equal(AppInfo appinfo2)
  {
    bool _retval;
    _retval = g_app_info_equal(cPtr!GAppInfo, appinfo2 ? (cast(ObjectG)appinfo2).cPtr!GAppInfo : null);
    return _retval;
  }

  /**
   * a string containing the @appinfo's commandline,
   * or %NULL if this information is not available
   */
  override string getCommandline()
  {
    const(char)* _cretval;
    _cretval = g_app_info_get_commandline(cPtr!GAppInfo);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * a string containing a description of the
   * application @appinfo, or %NULL if none.
   */
  override string getDescription()
  {
    const(char)* _cretval;
    _cretval = g_app_info_get_description(cPtr!GAppInfo);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * the display name of the application for @appinfo, or the name if
   * no display name is available.
   */
  override string getDisplayName()
  {
    const(char)* _cretval;
    _cretval = g_app_info_get_display_name(cPtr!GAppInfo);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * a string containing the @appinfo's application
   * binaries name
   */
  override string getExecutable()
  {
    const(char)* _cretval;
    _cretval = g_app_info_get_executable(cPtr!GAppInfo);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * the default #GIcon for @appinfo or %NULL
   * if there is no default icon.
   */
  override Icon getIcon()
  {
    GIcon* _cretval;
    _cretval = g_app_info_get_icon(cPtr!GAppInfo);
    Icon _retval = ObjectG.getDObject!Icon(cast(GIcon*)_cretval, false);
    return _retval;
  }

  /**
   * a string containing the application's ID.
   */
  override string getId()
  {
    const(char)* _cretval;
    _cretval = g_app_info_get_id(cPtr!GAppInfo);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * the name of the application for @appinfo.
   */
  override string getName()
  {
    const(char)* _cretval;
    _cretval = g_app_info_get_name(cPtr!GAppInfo);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * a list of content types.
   */
  override string[] getSupportedTypes()
  {
    const(char*)* _cretval;
    _cretval = g_app_info_get_supported_types(cPtr!GAppInfo);
    string[] _retval;

    if (_cretval)
    {
      uint _cretlength;
      for (; _cretval[_cretlength] != null; _cretlength++)
        break;
      _retval = new string[_cretlength];
      foreach (i; 0 .. _cretlength)
        _retval[i] = _cretval[i].fromCString(false);
    }
    return _retval;
  }

  /**
   * %TRUE on successful launch, %FALSE otherwise.
   */
  override bool launch(List!(File, GFile*) files, AppLaunchContext context)
  {
    bool _retval;
    GError *_err;
    _retval = g_app_info_launch(cPtr!GAppInfo, files.cPtr, context ? context.cPtr!GAppLaunchContext : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * %TRUE on successful launch, %FALSE otherwise.
   */
  override bool launchUris(List!(string, char*) uris, AppLaunchContext context)
  {
    bool _retval;
    GError *_err;
    _retval = g_app_info_launch_uris(cPtr!GAppInfo, uris.cPtr, context ? context.cPtr!GAppLaunchContext : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Async version of g_app_info_launch_uris().
   *
   * The @callback is invoked immediately after the application launch, but it
   * waits for activation in case of D-Bus–activated applications and also provides
   * extended error information for sandboxed applications, see notes for
   * g_app_info_launch_default_for_uri_async().
   */
  override void launchUrisAsync(List!(string, char*) uris, AppLaunchContext context, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    ptrFreezeGC(cast(void*)&callback);
    g_app_info_launch_uris_async(cPtr!GAppInfo, uris.cPtr, context ? context.cPtr!GAppLaunchContext : null, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * %TRUE on successful launch, %FALSE otherwise.
   */
  override bool launchUrisFinish(AsyncResult result)
  {
    bool _retval;
    GError *_err;
    _retval = g_app_info_launch_uris_finish(cPtr!GAppInfo, result ? (cast(ObjectG)result).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * %TRUE on success, %FALSE on error.
   */
  override bool removeSupportsType(string contentType)
  {
    bool _retval;
    const(char)* _contentType = contentType.toCString(false);
    GError *_err;
    _retval = g_app_info_remove_supports_type(cPtr!GAppInfo, _contentType, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * %TRUE on success, %FALSE on error.
   */
  override bool setAsDefaultForExtension(string extension)
  {
    bool _retval;
    const(char)* _extension = extension.toCString(false);
    GError *_err;
    _retval = g_app_info_set_as_default_for_extension(cPtr!GAppInfo, _extension, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * %TRUE on success, %FALSE on error.
   */
  override bool setAsDefaultForType(string contentType)
  {
    bool _retval;
    const(char)* _contentType = contentType.toCString(false);
    GError *_err;
    _retval = g_app_info_set_as_default_for_type(cPtr!GAppInfo, _contentType, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * %TRUE on success, %FALSE on error.
   */
  override bool setAsLastUsedForType(string contentType)
  {
    bool _retval;
    const(char)* _contentType = contentType.toCString(false);
    GError *_err;
    _retval = g_app_info_set_as_last_used_for_type(cPtr!GAppInfo, _contentType, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * %TRUE if the @appinfo should be shown, %FALSE otherwise.
   */
  override bool shouldShow()
  {
    bool _retval;
    _retval = g_app_info_should_show(cPtr!GAppInfo);
    return _retval;
  }

  /**
   * %TRUE if the @appinfo supports files.
   */
  override bool supportsFiles()
  {
    bool _retval;
    _retval = g_app_info_supports_files(cPtr!GAppInfo);
    return _retval;
  }

  /**
   * %TRUE if the @appinfo supports URIs.
   */
  override bool supportsUris()
  {
    bool _retval;
    _retval = g_app_info_supports_uris(cPtr!GAppInfo);
    return _retval;
  }
}
