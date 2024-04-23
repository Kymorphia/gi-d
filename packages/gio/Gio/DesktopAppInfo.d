module Gio.DesktopAppInfo;

import GLib.KeyFile;
import GLib.List;
import GLib.Types;
import GObject.ObjectG;
import GObject.Types;
import Gid.Gid;
import Gio.AppInfo;
import Gio.AppInfoT;
import Gio.AppLaunchContext;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * #GDesktopAppInfo is an implementation of #GAppInfo based on
 * desktop files.
 *
 * Note that `<gio/gdesktopappinfo.h>` belongs to the UNIX-specific
 * GIO interfaces, thus you have to use the `gio-unix-2.0.pc` pkg-config
 * file when using it.
 */
class DesktopAppInfo : ObjectG, AppInfo
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_desktop_app_info_get_type();
  }

  mixin AppInfoT!GDesktopAppInfo;

  /**
   * a new #GDesktopAppInfo, or %NULL if no desktop
   * file with that id exists.
   */
  this(string desktopId)
  {
    GDesktopAppInfo* _cretval;
    const(char)* _desktopId = desktopId.toCString(false);
    _cretval = g_desktop_app_info_new(_desktopId);
    this(_cretval, true);
  }

  /**
   * a new #GDesktopAppInfo or %NULL on error.
   */
  static DesktopAppInfo newFromFilename(string filename)
  {
    GDesktopAppInfo* _cretval;
    const(char)* _filename = filename.toCString(false);
    _cretval = g_desktop_app_info_new_from_filename(_filename);
    DesktopAppInfo _retval = ObjectG.getDObject!DesktopAppInfo(cast(GDesktopAppInfo*)_cretval, true);
    return _retval;
  }

  /**
   * a new #GDesktopAppInfo or %NULL on error.
   */
  static DesktopAppInfo newFromKeyfile(KeyFile keyFile)
  {
    GDesktopAppInfo* _cretval;
    _cretval = g_desktop_app_info_new_from_keyfile(keyFile ? keyFile.cPtr!GKeyFile : null);
    DesktopAppInfo _retval = ObjectG.getDObject!DesktopAppInfo(cast(GDesktopAppInfo*)_cretval, true);
    return _retval;
  }

  /**
   * a list of #GDesktopAppInfo
   * objects.
   */
  static List!(DesktopAppInfo, GDesktopAppInfo*) getImplementations(string interface_)
  {
    GList* _cretval;
    const(char)* _interface_ = interface_.toCString(false);
    _cretval = g_desktop_app_info_get_implementations(_interface_);
    List!(DesktopAppInfo, GDesktopAppInfo*) _retval = _cretval ? new List!(DesktopAppInfo, GDesktopAppInfo*)(_cretval, GidOwnership.Full) : null;
    return _retval;
  }

  /**
   * Sets the name of the desktop that the application is running in.
   * This is used by g_app_info_should_show() and
   * g_desktop_app_info_get_show_in() to evaluate the
   * `OnlyShowIn` and `NotShowIn`
   * desktop entry fields.
   *
   * Should be called only once; subsequent calls are ignored.
   */
  static void setDesktopEnv(string desktopEnv)
  {
    const(char)* _desktopEnv = desktopEnv.toCString(false);
    g_desktop_app_info_set_desktop_env(_desktopEnv);
  }

  /**
   * the locale-specific action name
   */
  string getActionName(string actionName)
  {
    char* _cretval;
    const(char)* _actionName = actionName.toCString(false);
    _cretval = g_desktop_app_info_get_action_name(cPtr!GDesktopAppInfo, _actionName);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * the boolean value, or %FALSE if the key
   * is not found
   */
  bool getBoolean(string key)
  {
    bool _retval;
    const(char)* _key = key.toCString(false);
    _retval = g_desktop_app_info_get_boolean(cPtr!GDesktopAppInfo, _key);
    return _retval;
  }

  /**
   * The unparsed Categories key from the desktop file;
   * i.e. no attempt is made to split it by ';' or validate it.
   */
  string getCategories()
  {
    const(char)* _cretval;
    _cretval = g_desktop_app_info_get_categories(cPtr!GDesktopAppInfo);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * The full path to the file for @info,
   * or %NULL if not known.
   */
  string getFilename()
  {
    const(char)* _cretval;
    _cretval = g_desktop_app_info_get_filename(cPtr!GDesktopAppInfo);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * The value of the GenericName key
   */
  string getGenericName()
  {
    const(char)* _cretval;
    _cretval = g_desktop_app_info_get_generic_name(cPtr!GDesktopAppInfo);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * %TRUE if hidden, %FALSE otherwise.
   */
  bool getIsHidden()
  {
    bool _retval;
    _retval = g_desktop_app_info_get_is_hidden(cPtr!GDesktopAppInfo);
    return _retval;
  }

  /**
   * The value of the Keywords key
   */
  string[] getKeywords()
  {
    const(char*)* _cretval;
    _cretval = g_desktop_app_info_get_keywords(cPtr!GDesktopAppInfo);
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
   * a newly allocated string, or %NULL if the key
   * is not found
   */
  string getLocaleString(string key)
  {
    char* _cretval;
    const(char)* _key = key.toCString(false);
    _cretval = g_desktop_app_info_get_locale_string(cPtr!GDesktopAppInfo, _key);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * The value of the NoDisplay key
   */
  bool getNodisplay()
  {
    bool _retval;
    _retval = g_desktop_app_info_get_nodisplay(cPtr!GDesktopAppInfo);
    return _retval;
  }

  /**
   * %TRUE if the @info should be shown in @desktop_env according to the
   * `OnlyShowIn` and `NotShowIn` keys, %FALSE
   * otherwise.
   */
  bool getShowIn(string desktopEnv)
  {
    bool _retval;
    const(char)* _desktopEnv = desktopEnv.toCString(false);
    _retval = g_desktop_app_info_get_show_in(cPtr!GDesktopAppInfo, _desktopEnv);
    return _retval;
  }

  /**
   * the startup WM class, or %NULL if none is set
   * in the desktop file.
   */
  string getStartupWmClass()
  {
    const(char)* _cretval;
    _cretval = g_desktop_app_info_get_startup_wm_class(cPtr!GDesktopAppInfo);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * a newly allocated string, or %NULL if the key
   * is not found
   */
  string getString(string key)
  {
    char* _cretval;
    const(char)* _key = key.toCString(false);
    _cretval = g_desktop_app_info_get_string(cPtr!GDesktopAppInfo, _key);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * a %NULL-terminated string array or %NULL if the specified
   * key cannot be found. The array should be freed with g_strfreev().
   */
  string[] getStringList(string key)
  {
    char** _cretval;
    size_t _cretlength;
    const(char)* _key = key.toCString(false);
    _cretval = g_desktop_app_info_get_string_list(cPtr!GDesktopAppInfo, _key, &_cretlength);
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
   * %TRUE if the @key exists
   */
  bool hasKey(string key)
  {
    bool _retval;
    const(char)* _key = key.toCString(false);
    _retval = g_desktop_app_info_has_key(cPtr!GDesktopAppInfo, _key);
    return _retval;
  }

  /**
   * Activates the named application action.
   *
   * You may only call this function on action names that were
   * returned from g_desktop_app_info_list_actions().
   *
   * Note that if the main entry of the desktop file indicates that the
   * application supports startup notification, and @launch_context is
   * non-%NULL, then startup notification will be used when activating the
   * action (and as such, invocation of the action on the receiving side
   * must signal the end of startup notification when it is completed).
   * This is the expected behaviour of applications declaring additional
   * actions, as per the desktop file specification.
   *
   * As with g_app_info_launch() there is no way to detect failures that
   * occur while using this function.
   */
  void launchAction(string actionName, AppLaunchContext launchContext)
  {
    const(char)* _actionName = actionName.toCString(false);
    g_desktop_app_info_launch_action(cPtr!GDesktopAppInfo, _actionName, launchContext ? launchContext.cPtr!GAppLaunchContext : null);
  }

  /**
   * a list of strings, always non-%NULL
   */
  string[] listActions()
  {
    const(char*)* _cretval;
    _cretval = g_desktop_app_info_list_actions(cPtr!GDesktopAppInfo);
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
}
