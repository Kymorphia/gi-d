module Gio.DesktopAppInfo;

import GLib.KeyFile;
import GLib.List;
import GObject.ObjectG;
import Gid.gid;
import Gio.AppInfo;
import Gio.AppInfoT;
import Gio.AppLaunchContext;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * `GDesktopAppInfo` is an implementation of [Gio.AppInfo] based on
 * desktop files.
 * Note that `<gio/gdesktopappinfo.h>` belongs to the UNIX-specific
 * GIO interfaces, thus you have to use the `gio-unix-2.0.pc` pkg-config
 * file or the `GioUnix-2.0` GIR namespace when using it.
 */
class DesktopAppInfo : ObjectG, AppInfo
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
    return g_desktop_app_info_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin AppInfoT!GDesktopAppInfo;

  /**
   * Creates a new #GDesktopAppInfo based on a desktop file id.
   * A desktop file id is the basename of the desktop file, including the
   * .desktop extension. GIO is looking for a desktop file with this name
   * in the `applications` subdirectories of the XDG
   * data directories $(LPAREN)i.e. the directories specified in the `XDG_DATA_HOME`
   * and `XDG_DATA_DIRS` environment variables$(RPAREN). GIO also supports the
   * prefix-to-subdirectory mapping that is described in the
   * [Menu Spec](http://standards.freedesktop.org/menu-spec/latest/)
   * $(LPAREN)i.e. a desktop id of kde-foo.desktop will match
   * `/usr/share/applications/kde/foo.desktop`$(RPAREN).
   * Params:
   *   desktopId = the desktop file id
   * Returns: a new #GDesktopAppInfo, or %NULL if no desktop
   *   file with that id exists.
   */
  this(string desktopId)
  {
    GDesktopAppInfo* _cretval;
    const(char)* _desktopId = desktopId.toCString(false);
    _cretval = g_desktop_app_info_new(_desktopId);
    this(_cretval, true);
  }

  /**
   * Creates a new #GDesktopAppInfo.
   * Params:
   *   filename = the path of a desktop file, in the GLib
   *     filename encoding
   * Returns: a new #GDesktopAppInfo or %NULL on error.
   */
  static DesktopAppInfo newFromFilename(string filename)
  {
    GDesktopAppInfo* _cretval;
    const(char)* _filename = filename.toCString(false);
    _cretval = g_desktop_app_info_new_from_filename(_filename);
    auto _retval = _cretval ? ObjectG.getDObject!DesktopAppInfo(cast(GDesktopAppInfo*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Creates a new #GDesktopAppInfo.
   * Params:
   *   keyFile = an opened #GKeyFile
   * Returns: a new #GDesktopAppInfo or %NULL on error.
   */
  static DesktopAppInfo newFromKeyfile(KeyFile keyFile)
  {
    GDesktopAppInfo* _cretval;
    _cretval = g_desktop_app_info_new_from_keyfile(keyFile ? cast(GKeyFile*)keyFile.cPtr(false) : null);
    auto _retval = _cretval ? ObjectG.getDObject!DesktopAppInfo(cast(GDesktopAppInfo*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Gets all applications that implement interface.
   * An application implements an interface if that interface is listed in
   * the Implements\= line of the desktop file of the application.
   * Params:
   *   interface_ = the name of the interface
   * Returns: a list of #GDesktopAppInfo
   *   objects.
   */
  static List!(DesktopAppInfo, GDesktopAppInfo) getImplementations(string interface_)
  {
    GList* _cretval;
    const(char)* _interface_ = interface_.toCString(false);
    _cretval = g_desktop_app_info_get_implementations(_interface_);
    List!(DesktopAppInfo, GDesktopAppInfo) _retval = new List!(DesktopAppInfo, GDesktopAppInfo)(cast(GList*)_cretval, GidOwnership.Full);
    return _retval;
  }

  /**
   * Sets the name of the desktop that the application is running in.
   * This is used by [Gio.AppInfo.shouldShow] and
   * [Gio.DesktopAppInfo.getShowIn] to evaluate the
   * `OnlyShowIn` and `NotShowIn`
   * desktop entry fields.
   * Should be called only once; subsequent calls are ignored.
   * Params:
   *   desktopEnv = a string specifying what desktop this is

   * Deprecated: do not use this API.  Since 2.42 the value of the
   *   `XDG_CURRENT_DESKTOP` environment variable will be used.
   */
  static void setDesktopEnv(string desktopEnv)
  {
    const(char)* _desktopEnv = desktopEnv.toCString(false);
    g_desktop_app_info_set_desktop_env(_desktopEnv);
  }

  /**
   * Gets the user-visible display name of the "additional application
   * action" specified by action_name.
   * This corresponds to the "Name" key within the keyfile group for the
   * action.
   * Params:
   *   actionName = the name of the action as from
   *     [Gio.DesktopAppInfo.listActions]
   * Returns: the locale-specific action name
   */
  string getActionName(string actionName)
  {
    char* _cretval;
    const(char)* _actionName = actionName.toCString(false);
    _cretval = g_desktop_app_info_get_action_name(cast(GDesktopAppInfo*)cPtr, _actionName);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * Looks up a boolean value in the keyfile backing info.
   * The key is looked up in the "Desktop Entry" group.
   * Params:
   *   key = the key to look up
   * Returns: the boolean value, or %FALSE if the key
   *   is not found
   */
  bool getBoolean(string key)
  {
    bool _retval;
    const(char)* _key = key.toCString(false);
    _retval = g_desktop_app_info_get_boolean(cast(GDesktopAppInfo*)cPtr, _key);
    return _retval;
  }

  /**
   * Gets the categories from the desktop file.
   * Returns: The unparsed Categories key from the desktop file;
   *   i.e. no attempt is made to split it by ';' or validate it.
   */
  string getCategories()
  {
    const(char)* _cretval;
    _cretval = g_desktop_app_info_get_categories(cast(GDesktopAppInfo*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * When info was created from a known filename, return it.  In some
   * situations such as the #GDesktopAppInfo returned from
   * [Gio.DesktopAppInfo.newFromKeyfile], this function will return %NULL.
   * Returns: The full path to the file for info,
   *   or %NULL if not known.
   */
  string getFilename()
  {
    const(char)* _cretval;
    _cretval = g_desktop_app_info_get_filename(cast(GDesktopAppInfo*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Gets the generic name from the desktop file.
   * Returns: The value of the GenericName key
   */
  string getGenericName()
  {
    const(char)* _cretval;
    _cretval = g_desktop_app_info_get_generic_name(cast(GDesktopAppInfo*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * A desktop file is hidden if the Hidden key in it is
   * set to True.
   * Returns: %TRUE if hidden, %FALSE otherwise.
   */
  bool getIsHidden()
  {
    bool _retval;
    _retval = g_desktop_app_info_get_is_hidden(cast(GDesktopAppInfo*)cPtr);
    return _retval;
  }

  /**
   * Gets the keywords from the desktop file.
   * Returns: The value of the Keywords key
   */
  string[] getKeywords()
  {
    const(char*)* _cretval;
    _cretval = g_desktop_app_info_get_keywords(cast(GDesktopAppInfo*)cPtr);
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
   * Looks up a localized string value in the keyfile backing info
   * translated to the current locale.
   * The key is looked up in the "Desktop Entry" group.
   * Params:
   *   key = the key to look up
   * Returns: a newly allocated string, or %NULL if the key
   *   is not found
   */
  string getLocaleString(string key)
  {
    char* _cretval;
    const(char)* _key = key.toCString(false);
    _cretval = g_desktop_app_info_get_locale_string(cast(GDesktopAppInfo*)cPtr, _key);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * Gets the value of the NoDisplay key, which helps determine if the
   * application info should be shown in menus. See
   * %G_KEY_FILE_DESKTOP_KEY_NO_DISPLAY and [Gio.AppInfo.shouldShow].
   * Returns: The value of the NoDisplay key
   */
  bool getNodisplay()
  {
    bool _retval;
    _retval = g_desktop_app_info_get_nodisplay(cast(GDesktopAppInfo*)cPtr);
    return _retval;
  }

  /**
   * Checks if the application info should be shown in menus that list available
   * applications for a specific name of the desktop, based on the
   * `OnlyShowIn` and `NotShowIn` keys.
   * desktop_env should typically be given as %NULL, in which case the
   * `XDG_CURRENT_DESKTOP` environment variable is consulted.  If you want
   * to override the default mechanism then you may specify desktop_env,
   * but this is not recommended.
   * Note that [Gio.AppInfo.shouldShow] for info will include this check $(LPAREN)with
   * %NULL for desktop_env$(RPAREN) as well as additional checks.
   * Params:
   *   desktopEnv = a string specifying a desktop name
   * Returns: %TRUE if the info should be shown in desktop_env according to the
   *   `OnlyShowIn` and `NotShowIn` keys, %FALSE
   *   otherwise.
   */
  bool getShowIn(string desktopEnv)
  {
    bool _retval;
    const(char)* _desktopEnv = desktopEnv.toCString(false);
    _retval = g_desktop_app_info_get_show_in(cast(GDesktopAppInfo*)cPtr, _desktopEnv);
    return _retval;
  }

  /**
   * Retrieves the StartupWMClass field from info. This represents the
   * WM_CLASS property of the main window of the application, if launched
   * through info.
   * Returns: the startup WM class, or %NULL if none is set
   *   in the desktop file.
   */
  string getStartupWmClass()
  {
    const(char)* _cretval;
    _cretval = g_desktop_app_info_get_startup_wm_class(cast(GDesktopAppInfo*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Looks up a string value in the keyfile backing info.
   * The key is looked up in the "Desktop Entry" group.
   * Params:
   *   key = the key to look up
   * Returns: a newly allocated string, or %NULL if the key
   *   is not found
   */
  string getString(string key)
  {
    char* _cretval;
    const(char)* _key = key.toCString(false);
    _cretval = g_desktop_app_info_get_string(cast(GDesktopAppInfo*)cPtr, _key);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * Looks up a string list value in the keyfile backing info.
   * The key is looked up in the "Desktop Entry" group.
   * Params:
   *   key = the key to look up
   * Returns: a %NULL-terminated string array or %NULL if the specified
   *   key cannot be found. The array should be freed with [GLib.Global.strfreev].
   */
  string[] getStringList(string key)
  {
    char** _cretval;
    size_t _cretlength;
    const(char)* _key = key.toCString(false);
    _cretval = g_desktop_app_info_get_string_list(cast(GDesktopAppInfo*)cPtr, _key, &_cretlength);
    string[] _retval;

    if (_cretval)
    {
      _retval = new string[_cretlength];
      foreach (i; 0 .. _cretlength)
        _retval[i] = _cretval[i].fromCString(true);
    }
    return _retval;
  }

  /**
   * Returns whether key exists in the "Desktop Entry" group
   * of the keyfile backing info.
   * Params:
   *   key = the key to look up
   * Returns: %TRUE if the key exists
   */
  bool hasKey(string key)
  {
    bool _retval;
    const(char)* _key = key.toCString(false);
    _retval = g_desktop_app_info_has_key(cast(GDesktopAppInfo*)cPtr, _key);
    return _retval;
  }

  /**
   * Activates the named application action.
   * You may only call this function on action names that were
   * returned from [Gio.DesktopAppInfo.listActions].
   * Note that if the main entry of the desktop file indicates that the
   * application supports startup notification, and launch_context is
   * non-%NULL, then startup notification will be used when activating the
   * action $(LPAREN)and as such, invocation of the action on the receiving side
   * must signal the end of startup notification when it is completed$(RPAREN).
   * This is the expected behaviour of applications declaring additional
   * actions, as per the desktop file specification.
   * As with [Gio.AppInfo.launch] there is no way to detect failures that
   * occur while using this function.
   * Params:
   *   actionName = the name of the action as from
   *     [Gio.DesktopAppInfo.listActions]
   *   launchContext = a #GAppLaunchContext
   */
  void launchAction(string actionName, AppLaunchContext launchContext)
  {
    const(char)* _actionName = actionName.toCString(false);
    g_desktop_app_info_launch_action(cast(GDesktopAppInfo*)cPtr, _actionName, launchContext ? cast(GAppLaunchContext*)launchContext.cPtr(false) : null);
  }

  /**
   * Returns the list of "additional application actions" supported on the
   * desktop file, as per the desktop file specification.
   * As per the specification, this is the list of actions that are
   * explicitly listed in the "Actions" key of the [Desktop Entry] group.
   * Returns: a list of strings, always non-%NULL
   */
  string[] listActions()
  {
    const(char*)* _cretval;
    _cretval = g_desktop_app_info_list_actions(cast(GDesktopAppInfo*)cPtr);
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
}
