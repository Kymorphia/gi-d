module Gtk.RecentInfo;

import GLib.Boxed;
import GLib.DateTime;
import GLib.ErrorG;
import GObject.ObjectG;
import Gid.gid;
import Gio.AppInfo;
import Gio.AppInfoT;
import Gio.Icon;
import Gio.IconT;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkRecentInfo` contains the metadata associated with an item in the
 * recently used files list.
 */
class RecentInfo : Boxed
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  void* cPtr(bool makeCopy = false)
  {
    return makeCopy ? copy_ : cInstancePtr;
  }

  static GType getType()
  {
    return gtk_recent_info_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a `GAppInfo` for the specified `GtkRecentInfo`
   * In case of error, error will be set either with a
   * %GTK_RECENT_MANAGER_ERROR or a %G_IO_ERROR
   * Params:
   *   appName = the name of the application that should
   *     be mapped to a `GAppInfo`; if %NULL is used then the default
   *     application for the MIME type is used
   * Returns: the newly created `GAppInfo`
   */
  AppInfo createAppInfo(string appName)
  {
    GAppInfo* _cretval;
    const(char)* _appName = appName.toCString(false);
    GError *_err;
    _cretval = gtk_recent_info_create_app_info(cast(GtkRecentInfo*)cPtr, _appName, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = _cretval ? ObjectG.getDObject!AppInfo(cast(GAppInfo*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Checks whether the resource pointed by info still exists.
   * At the moment this check is done only on resources pointing
   * to local files.
   * Returns: %TRUE if the resource exists
   */
  bool exists()
  {
    bool _retval;
    _retval = gtk_recent_info_exists(cast(GtkRecentInfo*)cPtr);
    return _retval;
  }

  /**
   * Gets the time when the resource
   * was added to the recently used resources list.
   * Returns: a `GDateTime` for the time
   *   when the resource was added
   */
  DateTime getAdded()
  {
    GDateTime* _cretval;
    _cretval = gtk_recent_info_get_added(cast(GtkRecentInfo*)cPtr);
    auto _retval = _cretval ? new DateTime(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the number of days elapsed since the last update
   * of the resource pointed by info.
   * Returns: a positive integer containing the number of days
   *   elapsed since the time this resource was last modified
   */
  int getAge()
  {
    int _retval;
    _retval = gtk_recent_info_get_age(cast(GtkRecentInfo*)cPtr);
    return _retval;
  }

  /**
   * Gets the data regarding the application that has registered the resource
   * pointed by info.
   * If the command line contains any escape characters defined inside the
   * storage specification, they will be expanded.
   * Params:
   *   appName = the name of the application that has registered this item
   *   appExec = return location for the string containing
   *     the command line
   *   count = return location for the number of times this item was registered
   *   stamp = return location for the time this item was last
   *     registered for this application
   * Returns: %TRUE if an application with app_name has registered this
   *   resource inside the recently used list, or %FALSE otherwise. The
   *   app_exec string is owned by the `GtkRecentInfo` and should not be
   *   modified or freed
   */
  bool getApplicationInfo(string appName, out string appExec, out uint count, out DateTime stamp)
  {
    bool _retval;
    const(char)* _appName = appName.toCString(false);
    char* _appExec;
    GDateTime* _stamp;
    _retval = gtk_recent_info_get_application_info(cast(GtkRecentInfo*)cPtr, _appName, &_appExec, cast(uint*)&count, &_stamp);
    appExec = _appExec.fromCString(false);
    stamp = new DateTime(cast(void*)_stamp, false);
    return _retval;
  }

  /**
   * Retrieves the list of applications that have registered this resource.
   * Returns: a newly
   *   allocated %NULL-terminated array of strings. Use [GLib.Global.strfreev] to free it.
   */
  string[] getApplications()
  {
    char** _cretval;
    size_t _cretlength;
    _cretval = gtk_recent_info_get_applications(cast(GtkRecentInfo*)cPtr, &_cretlength);
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
   * Gets the $(LPAREN)short$(RPAREN) description of the resource.
   * Returns: the description of the resource. The returned string
   *   is owned by the recent manager, and should not be freed.
   */
  string getDescription()
  {
    const(char)* _cretval;
    _cretval = gtk_recent_info_get_description(cast(GtkRecentInfo*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Gets the name of the resource.
   * If none has been defined, the basename
   * of the resource is obtained.
   * Returns: the display name of the resource. The returned string
   *   is owned by the recent manager, and should not be freed.
   */
  string getDisplayName()
  {
    const(char)* _cretval;
    _cretval = gtk_recent_info_get_display_name(cast(GtkRecentInfo*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Retrieves the icon associated to the resource MIME type.
   * Returns: a `GIcon` containing the icon
   */
  Icon getGicon()
  {
    GIcon* _cretval;
    _cretval = gtk_recent_info_get_gicon(cast(GtkRecentInfo*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Icon(cast(GIcon*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Returns all groups registered for the recently used item info.
   * The array of returned group names will be %NULL terminated, so
   * length might optionally be %NULL.
   * Returns: a newly allocated %NULL terminated array of strings.
   *   Use [GLib.Global.strfreev] to free it.
   */
  string[] getGroups()
  {
    char** _cretval;
    size_t _cretlength;
    _cretval = gtk_recent_info_get_groups(cast(GtkRecentInfo*)cPtr, &_cretlength);
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
   * Gets the MIME type of the resource.
   * Returns: the MIME type of the resource. The returned string
   *   is owned by the recent manager, and should not be freed.
   */
  string getMimeType()
  {
    const(char)* _cretval;
    _cretval = gtk_recent_info_get_mime_type(cast(GtkRecentInfo*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Gets the time when the meta-data
   * for the resource was last modified.
   * Returns: a `GDateTime` for the time
   *   when the resource was last modified
   */
  DateTime getModified()
  {
    GDateTime* _cretval;
    _cretval = gtk_recent_info_get_modified(cast(GtkRecentInfo*)cPtr);
    auto _retval = _cretval ? new DateTime(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the value of the “private” flag.
   * Resources in the recently used list that have this flag
   * set to %TRUE should only be displayed by the applications
   * that have registered them.
   * Returns: %TRUE if the private flag was found, %FALSE otherwise
   */
  bool getPrivateHint()
  {
    bool _retval;
    _retval = gtk_recent_info_get_private_hint(cast(GtkRecentInfo*)cPtr);
    return _retval;
  }

  /**
   * Computes a valid UTF-8 string that can be used as the
   * name of the item in a menu or list.
   * For example, calling this function on an item that refers
   * to “file:///foo/bar.txt” will yield “bar.txt”.
   * Returns: A newly-allocated string in UTF-8 encoding
   *   free it with [GLib.Global.gfree]
   */
  string getShortName()
  {
    char* _cretval;
    _cretval = gtk_recent_info_get_short_name(cast(GtkRecentInfo*)cPtr);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * Gets the URI of the resource.
   * Returns: the URI of the resource. The returned string is
   *   owned by the recent manager, and should not be freed.
   */
  string getUri()
  {
    const(char)* _cretval;
    _cretval = gtk_recent_info_get_uri(cast(GtkRecentInfo*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Gets a displayable version of the resource’s URI.
   * If the resource is local, it returns a local path; if the
   * resource is not local, it returns the UTF-8 encoded content
   * of [Gtk.RecentInfo.getUri].
   * Returns: a newly allocated UTF-8 string containing the
   *   resource’s URI or %NULL. Use [GLib.Global.gfree] when done using it.
   */
  string getUriDisplay()
  {
    char* _cretval;
    _cretval = gtk_recent_info_get_uri_display(cast(GtkRecentInfo*)cPtr);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * Gets the time when the meta-data
   * for the resource was last visited.
   * Returns: a `GDateTime` for the time
   *   when the resource was last visited
   */
  DateTime getVisited()
  {
    GDateTime* _cretval;
    _cretval = gtk_recent_info_get_visited(cast(GtkRecentInfo*)cPtr);
    auto _retval = _cretval ? new DateTime(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Checks whether an application registered this resource using app_name.
   * Params:
   *   appName = a string containing an application name
   * Returns: %TRUE if an application with name app_name was found,
   *   %FALSE otherwise
   */
  bool hasApplication(string appName)
  {
    bool _retval;
    const(char)* _appName = appName.toCString(false);
    _retval = gtk_recent_info_has_application(cast(GtkRecentInfo*)cPtr, _appName);
    return _retval;
  }

  /**
   * Checks whether group_name appears inside the groups
   * registered for the recently used item info.
   * Params:
   *   groupName = name of a group
   * Returns: %TRUE if the group was found
   */
  bool hasGroup(string groupName)
  {
    bool _retval;
    const(char)* _groupName = groupName.toCString(false);
    _retval = gtk_recent_info_has_group(cast(GtkRecentInfo*)cPtr, _groupName);
    return _retval;
  }

  /**
   * Checks whether the resource is local or not by looking at the
   * scheme of its URI.
   * Returns: %TRUE if the resource is local
   */
  bool isLocal()
  {
    bool _retval;
    _retval = gtk_recent_info_is_local(cast(GtkRecentInfo*)cPtr);
    return _retval;
  }

  /**
   * Gets the name of the last application that have registered the
   * recently used resource represented by info.
   * Returns: an application name. Use [GLib.Global.gfree] to free it.
   */
  string lastApplication()
  {
    char* _cretval;
    _cretval = gtk_recent_info_last_application(cast(GtkRecentInfo*)cPtr);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * Checks whether two `GtkRecentInfo` point to the same resource.
   * Params:
   *   infoB = a `GtkRecentInfo`
   * Returns: %TRUE if both `GtkRecentInfo` point to the same
   *   resource, %FALSE otherwise
   */
  bool match(RecentInfo infoB)
  {
    bool _retval;
    _retval = gtk_recent_info_match(cast(GtkRecentInfo*)cPtr, infoB ? cast(GtkRecentInfo*)infoB.cPtr(false) : null);
    return _retval;
  }
}
