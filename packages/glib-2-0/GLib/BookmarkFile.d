module GLib.BookmarkFile;

import GLib.Boxed;
import GLib.DateTime;
import GLib.ErrorG;
import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.gid;

/**
 * `GBookmarkFile` lets you parse, edit or create files containing bookmarks.
 * Bookmarks refer to a URI, along with some meta-data about the resource
 * pointed by the URI like its MIME type, the application that is registering
 * the bookmark and the icon that should be used to represent the bookmark.
 * The data is stored using the
 * [Desktop Bookmark Specification](http://www.gnome.org/~ebassi/bookmark-spec).
 * The syntax of the bookmark files is described in detail inside the
 * Desktop Bookmark Specification, here is a quick summary: bookmark
 * files use a sub-class of the XML Bookmark Exchange Language
 * specification, consisting of valid UTF-8 encoded XML, under the
 * `<xbel>` root element; each bookmark is stored inside a
 * `<bookmark>` element, using its URI: no relative paths can
 * be used inside a bookmark file. The bookmark may have a user defined
 * title and description, to be used instead of the URI. Under the
 * `<metadata>` element, with its owner attribute set to
 * `http://freedesktop.org`, is stored the meta-data about a resource
 * pointed by its URI. The meta-data consists of the resource's MIME
 * type; the applications that have registered a bookmark; the groups
 * to which a bookmark belongs to; a visibility flag, used to set the
 * bookmark as "private" to the applications and groups that has it
 * registered; the URI and MIME type of an icon, to be used when
 * displaying the bookmark inside a GUI.
 * Here is an example of a bookmark file:
 * [bookmarks.xbel](https://gitlab.gnome.org/GNOME/glib/-/blob/HEAD/glib/tests/bookmarks.xbel)
 * A bookmark file might contain more than one bookmark; each bookmark
 * is accessed through its URI.
 * The important caveat of bookmark files is that when you add a new
 * bookmark you must also add the application that is registering it, using
 * [GLib.BookmarkFile.addApplication] or [GLib.BookmarkFile.setApplicationInfo].
 * If a bookmark has no applications then it won't be dumped when creating
 * the on disk representation, using [GLib.BookmarkFile.toData] or
 * [GLib.BookmarkFile.toFile].
 */
class BookmarkFile : Boxed
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
    return g_bookmark_file_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new empty #GBookmarkFile object.
   * Use [GLib.BookmarkFile.loadFromFile], [GLib.BookmarkFile.loadFromData]
   * or [GLib.BookmarkFile.loadFromDataDirs] to read an existing bookmark
   * file.
   * Returns: an empty #GBookmarkFile
   */
  this()
  {
    GBookmarkFile* _cretval;
    _cretval = g_bookmark_file_new();
    this(_cretval, true);
  }

  /**
   * Adds the application with name and exec to the list of
   * applications that have registered a bookmark for uri into
   * bookmark.
   * Every bookmark inside a #GBookmarkFile must have at least an
   * application registered.  Each application must provide a name, a
   * command line useful for launching the bookmark, the number of times
   * the bookmark has been registered by the application and the last
   * time the application registered this bookmark.
   * If name is %NULL, the name of the application will be the
   * same returned by [GLib.Global.getApplicationName]; if exec is %NULL, the
   * command line will be a composition of the program name as
   * returned by [GLib.Global.getPrgname] and the "\%u" modifier, which will be
   * expanded to the bookmark's URI.
   * This function will automatically take care of updating the
   * registrations count and timestamping in case an application
   * with the same name had already registered a bookmark for
   * uri inside bookmark.
   * If no bookmark for uri is found, one is created.
   * Params:
   *   uri = a valid URI
   *   name = the name of the application registering the bookmark
   *     or %NULL
   *   exec = command line to be used to launch the bookmark or %NULL
   */
  void addApplication(string uri, string name, string exec)
  {
    const(char)* _uri = uri.toCString(false);
    const(char)* _name = name.toCString(false);
    const(char)* _exec = exec.toCString(false);
    g_bookmark_file_add_application(cast(GBookmarkFile*)cPtr, _uri, _name, _exec);
  }

  /**
   * Adds group to the list of groups to which the bookmark for uri
   * belongs to.
   * If no bookmark for uri is found then it is created.
   * Params:
   *   uri = a valid URI
   *   group = the group name to be added
   */
  void addGroup(string uri, string group)
  {
    const(char)* _uri = uri.toCString(false);
    const(char)* _group = group.toCString(false);
    g_bookmark_file_add_group(cast(GBookmarkFile*)cPtr, _uri, _group);
  }

  /**
   * Deeply copies a bookmark #GBookmarkFile object to a new one.
   * Returns: the copy of bookmark. Use
   *   g_bookmark_free$(LPAREN)$(RPAREN) when finished using it.
   */
  BookmarkFile copy()
  {
    GBookmarkFile* _cretval;
    _cretval = g_bookmark_file_copy(cast(GBookmarkFile*)cPtr);
    auto _retval = _cretval ? new BookmarkFile(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Gets the time the bookmark for uri was added to bookmark
   * In the event the URI cannot be found, -1 is returned and
   * error is set to %G_BOOKMARK_FILE_ERROR_URI_NOT_FOUND.
   * Params:
   *   uri = a valid URI
   * Returns: a timestamp

   * Deprecated: Use [GLib.BookmarkFile.getAddedDateTime] instead, as
   *   `time_t` is deprecated due to the year 2038 problem.
   */
  long getAdded(string uri)
  {
    long _retval;
    const(char)* _uri = uri.toCString(false);
    GError *_err;
    _retval = g_bookmark_file_get_added(cast(GBookmarkFile*)cPtr, _uri, &_err);
    if (_err)
      throw new BookmarkFileException(_err);
    return _retval;
  }

  /**
   * Gets the time the bookmark for uri was added to bookmark
   * In the event the URI cannot be found, %NULL is returned and
   * error is set to %G_BOOKMARK_FILE_ERROR_URI_NOT_FOUND.
   * Params:
   *   uri = a valid URI
   * Returns: a #GDateTime
   */
  DateTime getAddedDateTime(string uri)
  {
    GDateTime* _cretval;
    const(char)* _uri = uri.toCString(false);
    GError *_err;
    _cretval = g_bookmark_file_get_added_date_time(cast(GBookmarkFile*)cPtr, _uri, &_err);
    if (_err)
      throw new BookmarkFileException(_err);
    auto _retval = _cretval ? new DateTime(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the registration information of app_name for the bookmark for
   * uri.  See [GLib.BookmarkFile.setApplicationInfo] for more information about
   * the returned data.
   * The string returned in app_exec must be freed.
   * In the event the URI cannot be found, %FALSE is returned and
   * error is set to %G_BOOKMARK_FILE_ERROR_URI_NOT_FOUND.  In the
   * event that no application with name app_name has registered a bookmark
   * for uri,  %FALSE is returned and error is set to
   * %G_BOOKMARK_FILE_ERROR_APP_NOT_REGISTERED. In the event that unquoting
   * the command line fails, an error of the %G_SHELL_ERROR domain is
   * set and %FALSE is returned.
   * Params:
   *   uri = a valid URI
   *   name = an application's name
   *   exec = return location for the command line of the application, or %NULL
   *   count = return location for the registration count, or %NULL
   *   stamp = return location for the last registration time, or %NULL
   * Returns: %TRUE on success.

   * Deprecated: Use [GLib.BookmarkFile.getApplicationInfo] instead, as
   *   `time_t` is deprecated due to the year 2038 problem.
   */
  bool getAppInfo(string uri, string name, out string exec, out uint count, out long stamp)
  {
    bool _retval;
    const(char)* _uri = uri.toCString(false);
    const(char)* _name = name.toCString(false);
    char* _exec;
    GError *_err;
    _retval = g_bookmark_file_get_app_info(cast(GBookmarkFile*)cPtr, _uri, _name, &_exec, cast(uint*)&count, cast(long*)&stamp, &_err);
    if (_err)
      throw new BookmarkFileException(_err);
    exec = _exec.fromCString(true);
    return _retval;
  }

  /**
   * Gets the registration information of app_name for the bookmark for
   * uri.  See [GLib.BookmarkFile.setApplicationInfo] for more information about
   * the returned data.
   * The string returned in app_exec must be freed.
   * In the event the URI cannot be found, %FALSE is returned and
   * error is set to %G_BOOKMARK_FILE_ERROR_URI_NOT_FOUND.  In the
   * event that no application with name app_name has registered a bookmark
   * for uri,  %FALSE is returned and error is set to
   * %G_BOOKMARK_FILE_ERROR_APP_NOT_REGISTERED. In the event that unquoting
   * the command line fails, an error of the %G_SHELL_ERROR domain is
   * set and %FALSE is returned.
   * Params:
   *   uri = a valid URI
   *   name = an application's name
   *   exec = return location for the command line of the application, or %NULL
   *   count = return location for the registration count, or %NULL
   *   stamp = return location for the last registration time, or %NULL
   * Returns: %TRUE on success.
   */
  bool getApplicationInfo(string uri, string name, out string exec, out uint count, out DateTime stamp)
  {
    bool _retval;
    const(char)* _uri = uri.toCString(false);
    const(char)* _name = name.toCString(false);
    char* _exec;
    GDateTime* _stamp;
    GError *_err;
    _retval = g_bookmark_file_get_application_info(cast(GBookmarkFile*)cPtr, _uri, _name, &_exec, cast(uint*)&count, &_stamp, &_err);
    if (_err)
      throw new BookmarkFileException(_err);
    exec = _exec.fromCString(true);
    stamp = new DateTime(cast(void*)_stamp, false);
    return _retval;
  }

  /**
   * Retrieves the names of the applications that have registered the
   * bookmark for uri.
   * In the event the URI cannot be found, %NULL is returned and
   * error is set to %G_BOOKMARK_FILE_ERROR_URI_NOT_FOUND.
   * Params:
   *   uri = a valid URI
   * Returns: a newly allocated %NULL-terminated array of strings.
   *   Use [GLib.Global.strfreev] to free it.
   */
  string[] getApplications(string uri)
  {
    char** _cretval;
    size_t _cretlength;
    const(char)* _uri = uri.toCString(false);
    GError *_err;
    _cretval = g_bookmark_file_get_applications(cast(GBookmarkFile*)cPtr, _uri, &_cretlength, &_err);
    if (_err)
      throw new BookmarkFileException(_err);
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
   * Retrieves the description of the bookmark for uri.
   * In the event the URI cannot be found, %NULL is returned and
   * error is set to %G_BOOKMARK_FILE_ERROR_URI_NOT_FOUND.
   * Params:
   *   uri = a valid URI
   * Returns: a newly allocated string or %NULL if the specified
   *   URI cannot be found.
   */
  string getDescription(string uri)
  {
    char* _cretval;
    const(char)* _uri = uri.toCString(false);
    GError *_err;
    _cretval = g_bookmark_file_get_description(cast(GBookmarkFile*)cPtr, _uri, &_err);
    if (_err)
      throw new BookmarkFileException(_err);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * Retrieves the list of group names of the bookmark for uri.
   * In the event the URI cannot be found, %NULL is returned and
   * error is set to %G_BOOKMARK_FILE_ERROR_URI_NOT_FOUND.
   * The returned array is %NULL terminated, so length may optionally
   * be %NULL.
   * Params:
   *   uri = a valid URI
   * Returns: a newly allocated %NULL-terminated array of group names.
   *   Use [GLib.Global.strfreev] to free it.
   */
  string[] getGroups(string uri)
  {
    char** _cretval;
    size_t _cretlength;
    const(char)* _uri = uri.toCString(false);
    GError *_err;
    _cretval = g_bookmark_file_get_groups(cast(GBookmarkFile*)cPtr, _uri, &_cretlength, &_err);
    if (_err)
      throw new BookmarkFileException(_err);
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
   * Gets the icon of the bookmark for uri.
   * In the event the URI cannot be found, %FALSE is returned and
   * error is set to %G_BOOKMARK_FILE_ERROR_URI_NOT_FOUND.
   * Params:
   *   uri = a valid URI
   *   href = return location for the icon's location or %NULL
   *   mimeType = return location for the icon's MIME type or %NULL
   * Returns: %TRUE if the icon for the bookmark for the URI was found.
   *   You should free the returned strings.
   */
  bool getIcon(string uri, out string href, out string mimeType)
  {
    bool _retval;
    const(char)* _uri = uri.toCString(false);
    char* _href;
    char* _mimeType;
    GError *_err;
    _retval = g_bookmark_file_get_icon(cast(GBookmarkFile*)cPtr, _uri, &_href, &_mimeType, &_err);
    if (_err)
      throw new BookmarkFileException(_err);
    href = _href.fromCString(true);
    mimeType = _mimeType.fromCString(true);
    return _retval;
  }

  /**
   * Gets whether the private flag of the bookmark for uri is set.
   * In the event the URI cannot be found, %FALSE is returned and
   * error is set to %G_BOOKMARK_FILE_ERROR_URI_NOT_FOUND.  In the
   * event that the private flag cannot be found, %FALSE is returned and
   * error is set to %G_BOOKMARK_FILE_ERROR_INVALID_VALUE.
   * Params:
   *   uri = a valid URI
   * Returns: %TRUE if the private flag is set, %FALSE otherwise.
   */
  bool getIsPrivate(string uri)
  {
    bool _retval;
    const(char)* _uri = uri.toCString(false);
    GError *_err;
    _retval = g_bookmark_file_get_is_private(cast(GBookmarkFile*)cPtr, _uri, &_err);
    if (_err)
      throw new BookmarkFileException(_err);
    return _retval;
  }

  /**
   * Retrieves the MIME type of the resource pointed by uri.
   * In the event the URI cannot be found, %NULL is returned and
   * error is set to %G_BOOKMARK_FILE_ERROR_URI_NOT_FOUND.  In the
   * event that the MIME type cannot be found, %NULL is returned and
   * error is set to %G_BOOKMARK_FILE_ERROR_INVALID_VALUE.
   * Params:
   *   uri = a valid URI
   * Returns: a newly allocated string or %NULL if the specified
   *   URI cannot be found.
   */
  string getMimeType(string uri)
  {
    char* _cretval;
    const(char)* _uri = uri.toCString(false);
    GError *_err;
    _cretval = g_bookmark_file_get_mime_type(cast(GBookmarkFile*)cPtr, _uri, &_err);
    if (_err)
      throw new BookmarkFileException(_err);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * Gets the time when the bookmark for uri was last modified.
   * In the event the URI cannot be found, -1 is returned and
   * error is set to %G_BOOKMARK_FILE_ERROR_URI_NOT_FOUND.
   * Params:
   *   uri = a valid URI
   * Returns: a timestamp

   * Deprecated: Use [GLib.BookmarkFile.getModifiedDateTime] instead, as
   *   `time_t` is deprecated due to the year 2038 problem.
   */
  long getModified(string uri)
  {
    long _retval;
    const(char)* _uri = uri.toCString(false);
    GError *_err;
    _retval = g_bookmark_file_get_modified(cast(GBookmarkFile*)cPtr, _uri, &_err);
    if (_err)
      throw new BookmarkFileException(_err);
    return _retval;
  }

  /**
   * Gets the time when the bookmark for uri was last modified.
   * In the event the URI cannot be found, %NULL is returned and
   * error is set to %G_BOOKMARK_FILE_ERROR_URI_NOT_FOUND.
   * Params:
   *   uri = a valid URI
   * Returns: a #GDateTime
   */
  DateTime getModifiedDateTime(string uri)
  {
    GDateTime* _cretval;
    const(char)* _uri = uri.toCString(false);
    GError *_err;
    _cretval = g_bookmark_file_get_modified_date_time(cast(GBookmarkFile*)cPtr, _uri, &_err);
    if (_err)
      throw new BookmarkFileException(_err);
    auto _retval = _cretval ? new DateTime(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the number of bookmarks inside bookmark.
   * Returns: the number of bookmarks
   */
  int getSize()
  {
    int _retval;
    _retval = g_bookmark_file_get_size(cast(GBookmarkFile*)cPtr);
    return _retval;
  }

  /**
   * Returns the title of the bookmark for uri.
   * If uri is %NULL, the title of bookmark is returned.
   * In the event the URI cannot be found, %NULL is returned and
   * error is set to %G_BOOKMARK_FILE_ERROR_URI_NOT_FOUND.
   * Params:
   *   uri = a valid URI or %NULL
   * Returns: a newly allocated string or %NULL if the specified
   *   URI cannot be found.
   */
  string getTitle(string uri)
  {
    char* _cretval;
    const(char)* _uri = uri.toCString(false);
    GError *_err;
    _cretval = g_bookmark_file_get_title(cast(GBookmarkFile*)cPtr, _uri, &_err);
    if (_err)
      throw new BookmarkFileException(_err);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * Returns all URIs of the bookmarks in the bookmark file bookmark.
   * The array of returned URIs will be %NULL-terminated, so length may
   * optionally be %NULL.
   * Returns: a newly allocated %NULL-terminated array of strings.
   *   Use [GLib.Global.strfreev] to free it.
   */
  string[] getUris()
  {
    char** _cretval;
    size_t _cretlength;
    _cretval = g_bookmark_file_get_uris(cast(GBookmarkFile*)cPtr, &_cretlength);
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
   * Gets the time the bookmark for uri was last visited.
   * In the event the URI cannot be found, -1 is returned and
   * error is set to %G_BOOKMARK_FILE_ERROR_URI_NOT_FOUND.
   * Params:
   *   uri = a valid URI
   * Returns: a timestamp.

   * Deprecated: Use [GLib.BookmarkFile.getVisitedDateTime] instead, as
   *   `time_t` is deprecated due to the year 2038 problem.
   */
  long getVisited(string uri)
  {
    long _retval;
    const(char)* _uri = uri.toCString(false);
    GError *_err;
    _retval = g_bookmark_file_get_visited(cast(GBookmarkFile*)cPtr, _uri, &_err);
    if (_err)
      throw new BookmarkFileException(_err);
    return _retval;
  }

  /**
   * Gets the time the bookmark for uri was last visited.
   * In the event the URI cannot be found, %NULL is returned and
   * error is set to %G_BOOKMARK_FILE_ERROR_URI_NOT_FOUND.
   * Params:
   *   uri = a valid URI
   * Returns: a #GDateTime
   */
  DateTime getVisitedDateTime(string uri)
  {
    GDateTime* _cretval;
    const(char)* _uri = uri.toCString(false);
    GError *_err;
    _cretval = g_bookmark_file_get_visited_date_time(cast(GBookmarkFile*)cPtr, _uri, &_err);
    if (_err)
      throw new BookmarkFileException(_err);
    auto _retval = _cretval ? new DateTime(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Checks whether the bookmark for uri inside bookmark has been
   * registered by application name.
   * In the event the URI cannot be found, %FALSE is returned and
   * error is set to %G_BOOKMARK_FILE_ERROR_URI_NOT_FOUND.
   * Params:
   *   uri = a valid URI
   *   name = the name of the application
   * Returns: %TRUE if the application name was found
   */
  bool hasApplication(string uri, string name)
  {
    bool _retval;
    const(char)* _uri = uri.toCString(false);
    const(char)* _name = name.toCString(false);
    GError *_err;
    _retval = g_bookmark_file_has_application(cast(GBookmarkFile*)cPtr, _uri, _name, &_err);
    if (_err)
      throw new BookmarkFileException(_err);
    return _retval;
  }

  /**
   * Checks whether group appears in the list of groups to which
   * the bookmark for uri belongs to.
   * In the event the URI cannot be found, %FALSE is returned and
   * error is set to %G_BOOKMARK_FILE_ERROR_URI_NOT_FOUND.
   * Params:
   *   uri = a valid URI
   *   group = the group name to be searched
   * Returns: %TRUE if group was found.
   */
  bool hasGroup(string uri, string group)
  {
    bool _retval;
    const(char)* _uri = uri.toCString(false);
    const(char)* _group = group.toCString(false);
    GError *_err;
    _retval = g_bookmark_file_has_group(cast(GBookmarkFile*)cPtr, _uri, _group, &_err);
    if (_err)
      throw new BookmarkFileException(_err);
    return _retval;
  }

  /**
   * Looks whether the desktop bookmark has an item with its URI set to uri.
   * Params:
   *   uri = a valid URI
   * Returns: %TRUE if uri is inside bookmark, %FALSE otherwise
   */
  bool hasItem(string uri)
  {
    bool _retval;
    const(char)* _uri = uri.toCString(false);
    _retval = g_bookmark_file_has_item(cast(GBookmarkFile*)cPtr, _uri);
    return _retval;
  }

  /**
   * Loads a bookmark file from memory into an empty #GBookmarkFile
   * structure.  If the object cannot be created then error is set to a
   * #GBookmarkFileError.
   * Params:
   *   data = desktop bookmarks
   *     loaded in memory
   * Returns: %TRUE if a desktop bookmark could be loaded.
   */
  bool loadFromData(ubyte[] data)
  {
    bool _retval;
    size_t _length;
    if (data)
      _length = cast(size_t)data.length;

    auto _data = cast(const(ubyte)*)data.ptr;
    GError *_err;
    _retval = g_bookmark_file_load_from_data(cast(GBookmarkFile*)cPtr, _data, _length, &_err);
    if (_err)
      throw new BookmarkFileException(_err);
    return _retval;
  }

  /**
   * This function looks for a desktop bookmark file named file in the
   * paths returned from [GLib.Global.getUserDataDir] and [GLib.Global.getSystemDataDirs],
   * loads the file into bookmark and returns the file's full path in
   * full_path.  If the file could not be loaded then error is
   * set to either a #GFileError or #GBookmarkFileError.
   * Params:
   *   file = a relative path to a filename to open and parse
   *   fullPath = return location for a string
   *     containing the full path of the file, or %NULL
   * Returns: %TRUE if a key file could be loaded, %FALSE otherwise
   */
  bool loadFromDataDirs(string file, out string fullPath)
  {
    bool _retval;
    const(char)* _file = file.toCString(false);
    char* _fullPath;
    GError *_err;
    _retval = g_bookmark_file_load_from_data_dirs(cast(GBookmarkFile*)cPtr, _file, &_fullPath, &_err);
    if (_err)
      throw new BookmarkFileException(_err);
    fullPath = _fullPath.fromCString(true);
    return _retval;
  }

  /**
   * Loads a desktop bookmark file into an empty #GBookmarkFile structure.
   * If the file could not be loaded then error is set to either a #GFileError
   * or #GBookmarkFileError.
   * Params:
   *   filename = the path of a filename to load, in the
   *     GLib file name encoding
   * Returns: %TRUE if a desktop bookmark file could be loaded
   */
  bool loadFromFile(string filename)
  {
    bool _retval;
    const(char)* _filename = filename.toCString(false);
    GError *_err;
    _retval = g_bookmark_file_load_from_file(cast(GBookmarkFile*)cPtr, _filename, &_err);
    if (_err)
      throw new BookmarkFileException(_err);
    return _retval;
  }

  /**
   * Changes the URI of a bookmark item from old_uri to new_uri.  Any
   * existing bookmark for new_uri will be overwritten.  If new_uri is
   * %NULL, then the bookmark is removed.
   * In the event the URI cannot be found, %FALSE is returned and
   * error is set to %G_BOOKMARK_FILE_ERROR_URI_NOT_FOUND.
   * Params:
   *   oldUri = a valid URI
   *   newUri = a valid URI, or %NULL
   * Returns: %TRUE if the URI was successfully changed
   */
  bool moveItem(string oldUri, string newUri)
  {
    bool _retval;
    const(char)* _oldUri = oldUri.toCString(false);
    const(char)* _newUri = newUri.toCString(false);
    GError *_err;
    _retval = g_bookmark_file_move_item(cast(GBookmarkFile*)cPtr, _oldUri, _newUri, &_err);
    if (_err)
      throw new BookmarkFileException(_err);
    return _retval;
  }

  /**
   * Removes application registered with name from the list of applications
   * that have registered a bookmark for uri inside bookmark.
   * In the event the URI cannot be found, %FALSE is returned and
   * error is set to %G_BOOKMARK_FILE_ERROR_URI_NOT_FOUND.
   * In the event that no application with name app_name has registered
   * a bookmark for uri,  %FALSE is returned and error is set to
   * %G_BOOKMARK_FILE_ERROR_APP_NOT_REGISTERED.
   * Params:
   *   uri = a valid URI
   *   name = the name of the application
   * Returns: %TRUE if the application was successfully removed.
   */
  bool removeApplication(string uri, string name)
  {
    bool _retval;
    const(char)* _uri = uri.toCString(false);
    const(char)* _name = name.toCString(false);
    GError *_err;
    _retval = g_bookmark_file_remove_application(cast(GBookmarkFile*)cPtr, _uri, _name, &_err);
    if (_err)
      throw new BookmarkFileException(_err);
    return _retval;
  }

  /**
   * Removes group from the list of groups to which the bookmark
   * for uri belongs to.
   * In the event the URI cannot be found, %FALSE is returned and
   * error is set to %G_BOOKMARK_FILE_ERROR_URI_NOT_FOUND.
   * In the event no group was defined, %FALSE is returned and
   * error is set to %G_BOOKMARK_FILE_ERROR_INVALID_VALUE.
   * Params:
   *   uri = a valid URI
   *   group = the group name to be removed
   * Returns: %TRUE if group was successfully removed.
   */
  bool removeGroup(string uri, string group)
  {
    bool _retval;
    const(char)* _uri = uri.toCString(false);
    const(char)* _group = group.toCString(false);
    GError *_err;
    _retval = g_bookmark_file_remove_group(cast(GBookmarkFile*)cPtr, _uri, _group, &_err);
    if (_err)
      throw new BookmarkFileException(_err);
    return _retval;
  }

  /**
   * Removes the bookmark for uri from the bookmark file bookmark.
   * Params:
   *   uri = a valid URI
   * Returns: %TRUE if the bookmark was removed successfully.
   */
  bool removeItem(string uri)
  {
    bool _retval;
    const(char)* _uri = uri.toCString(false);
    GError *_err;
    _retval = g_bookmark_file_remove_item(cast(GBookmarkFile*)cPtr, _uri, &_err);
    if (_err)
      throw new BookmarkFileException(_err);
    return _retval;
  }

  /**
   * Sets the time the bookmark for uri was added into bookmark.
   * If no bookmark for uri is found then it is created.
   * Params:
   *   uri = a valid URI
   *   added = a timestamp or -1 to use the current time

   * Deprecated: Use [GLib.BookmarkFile.setAddedDateTime] instead, as
   *   `time_t` is deprecated due to the year 2038 problem.
   */
  void setAdded(string uri, long added)
  {
    const(char)* _uri = uri.toCString(false);
    g_bookmark_file_set_added(cast(GBookmarkFile*)cPtr, _uri, added);
  }

  /**
   * Sets the time the bookmark for uri was added into bookmark.
   * If no bookmark for uri is found then it is created.
   * Params:
   *   uri = a valid URI
   *   added = a #GDateTime
   */
  void setAddedDateTime(string uri, DateTime added)
  {
    const(char)* _uri = uri.toCString(false);
    g_bookmark_file_set_added_date_time(cast(GBookmarkFile*)cPtr, _uri, added ? cast(GDateTime*)added.cPtr(false) : null);
  }

  /**
   * Sets the meta-data of application name inside the list of
   * applications that have registered a bookmark for uri inside
   * bookmark.
   * You should rarely use this function; use [GLib.BookmarkFile.addApplication]
   * and [GLib.BookmarkFile.removeApplication] instead.
   * name can be any UTF-8 encoded string used to identify an
   * application.
   * exec can have one of these two modifiers: "\%f", which will
   * be expanded as the local file name retrieved from the bookmark's
   * URI; "\%u", which will be expanded as the bookmark's URI.
   * The expansion is done automatically when retrieving the stored
   * command line using the [GLib.BookmarkFile.getApplicationInfo] function.
   * count is the number of times the application has registered the
   * bookmark; if is < 0, the current registration count will be increased
   * by one, if is 0, the application with name will be removed from
   * the list of registered applications.
   * stamp is the Unix time of the last registration; if it is -1, the
   * current time will be used.
   * If you try to remove an application by setting its registration count to
   * zero, and no bookmark for uri is found, %FALSE is returned and
   * error is set to %G_BOOKMARK_FILE_ERROR_URI_NOT_FOUND; similarly,
   * in the event that no application name has registered a bookmark
   * for uri,  %FALSE is returned and error is set to
   * %G_BOOKMARK_FILE_ERROR_APP_NOT_REGISTERED.  Otherwise, if no bookmark
   * for uri is found, one is created.
   * Params:
   *   uri = a valid URI
   *   name = an application's name
   *   exec = an application's command line
   *   count = the number of registrations done for this application
   *   stamp = the time of the last registration for this application
   * Returns: %TRUE if the application's meta-data was successfully
   *   changed.

   * Deprecated: Use [GLib.BookmarkFile.setApplicationInfo] instead, as
   *   `time_t` is deprecated due to the year 2038 problem.
   */
  bool setAppInfo(string uri, string name, string exec, int count, long stamp)
  {
    bool _retval;
    const(char)* _uri = uri.toCString(false);
    const(char)* _name = name.toCString(false);
    const(char)* _exec = exec.toCString(false);
    GError *_err;
    _retval = g_bookmark_file_set_app_info(cast(GBookmarkFile*)cPtr, _uri, _name, _exec, count, stamp, &_err);
    if (_err)
      throw new BookmarkFileException(_err);
    return _retval;
  }

  /**
   * Sets the meta-data of application name inside the list of
   * applications that have registered a bookmark for uri inside
   * bookmark.
   * You should rarely use this function; use [GLib.BookmarkFile.addApplication]
   * and [GLib.BookmarkFile.removeApplication] instead.
   * name can be any UTF-8 encoded string used to identify an
   * application.
   * exec can have one of these two modifiers: "\%f", which will
   * be expanded as the local file name retrieved from the bookmark's
   * URI; "\%u", which will be expanded as the bookmark's URI.
   * The expansion is done automatically when retrieving the stored
   * command line using the [GLib.BookmarkFile.getApplicationInfo] function.
   * count is the number of times the application has registered the
   * bookmark; if is < 0, the current registration count will be increased
   * by one, if is 0, the application with name will be removed from
   * the list of registered applications.
   * stamp is the Unix time of the last registration.
   * If you try to remove an application by setting its registration count to
   * zero, and no bookmark for uri is found, %FALSE is returned and
   * error is set to %G_BOOKMARK_FILE_ERROR_URI_NOT_FOUND; similarly,
   * in the event that no application name has registered a bookmark
   * for uri,  %FALSE is returned and error is set to
   * %G_BOOKMARK_FILE_ERROR_APP_NOT_REGISTERED.  Otherwise, if no bookmark
   * for uri is found, one is created.
   * Params:
   *   uri = a valid URI
   *   name = an application's name
   *   exec = an application's command line
   *   count = the number of registrations done for this application
   *   stamp = the time of the last registration for this application,
   *     which may be %NULL if count is 0
   * Returns: %TRUE if the application's meta-data was successfully
   *   changed.
   */
  bool setApplicationInfo(string uri, string name, string exec, int count, DateTime stamp)
  {
    bool _retval;
    const(char)* _uri = uri.toCString(false);
    const(char)* _name = name.toCString(false);
    const(char)* _exec = exec.toCString(false);
    GError *_err;
    _retval = g_bookmark_file_set_application_info(cast(GBookmarkFile*)cPtr, _uri, _name, _exec, count, stamp ? cast(GDateTime*)stamp.cPtr(false) : null, &_err);
    if (_err)
      throw new BookmarkFileException(_err);
    return _retval;
  }

  /**
   * Sets description as the description of the bookmark for uri.
   * If uri is %NULL, the description of bookmark is set.
   * If a bookmark for uri cannot be found then it is created.
   * Params:
   *   uri = a valid URI or %NULL
   *   description = a string
   */
  void setDescription(string uri, string description)
  {
    const(char)* _uri = uri.toCString(false);
    const(char)* _description = description.toCString(false);
    g_bookmark_file_set_description(cast(GBookmarkFile*)cPtr, _uri, _description);
  }

  /**
   * Sets a list of group names for the item with URI uri.  Each previously
   * set group name list is removed.
   * If uri cannot be found then an item for it is created.
   * Params:
   *   uri = an item's URI
   *   groups = an array of
   *     group names, or %NULL to remove all groups
   */
  void setGroups(string uri, string[] groups)
  {
    const(char)* _uri = uri.toCString(false);
    size_t _length;
    if (groups)
      _length = cast(size_t)groups.length;

    const(char)*[] _tmpgroups;
    foreach (s; groups)
      _tmpgroups ~= s.toCString(false);
    const(char*)* _groups = _tmpgroups.ptr;
    g_bookmark_file_set_groups(cast(GBookmarkFile*)cPtr, _uri, _groups, _length);
  }

  /**
   * Sets the icon for the bookmark for uri. If href is %NULL, unsets
   * the currently set icon. href can either be a full URL for the icon
   * file or the icon name following the Icon Naming specification.
   * If no bookmark for uri is found one is created.
   * Params:
   *   uri = a valid URI
   *   href = the URI of the icon for the bookmark, or %NULL
   *   mimeType = the MIME type of the icon for the bookmark
   */
  void setIcon(string uri, string href, string mimeType)
  {
    const(char)* _uri = uri.toCString(false);
    const(char)* _href = href.toCString(false);
    const(char)* _mimeType = mimeType.toCString(false);
    g_bookmark_file_set_icon(cast(GBookmarkFile*)cPtr, _uri, _href, _mimeType);
  }

  /**
   * Sets the private flag of the bookmark for uri.
   * If a bookmark for uri cannot be found then it is created.
   * Params:
   *   uri = a valid URI
   *   isPrivate = %TRUE if the bookmark should be marked as private
   */
  void setIsPrivate(string uri, bool isPrivate)
  {
    const(char)* _uri = uri.toCString(false);
    g_bookmark_file_set_is_private(cast(GBookmarkFile*)cPtr, _uri, isPrivate);
  }

  /**
   * Sets mime_type as the MIME type of the bookmark for uri.
   * If a bookmark for uri cannot be found then it is created.
   * Params:
   *   uri = a valid URI
   *   mimeType = a MIME type
   */
  void setMimeType(string uri, string mimeType)
  {
    const(char)* _uri = uri.toCString(false);
    const(char)* _mimeType = mimeType.toCString(false);
    g_bookmark_file_set_mime_type(cast(GBookmarkFile*)cPtr, _uri, _mimeType);
  }

  /**
   * Sets the last time the bookmark for uri was last modified.
   * If no bookmark for uri is found then it is created.
   * The "modified" time should only be set when the bookmark's meta-data
   * was actually changed.  Every function of #GBookmarkFile that
   * modifies a bookmark also changes the modification time, except for
   * [GLib.BookmarkFile.setVisitedDateTime].
   * Params:
   *   uri = a valid URI
   *   modified = a timestamp or -1 to use the current time

   * Deprecated: Use [GLib.BookmarkFile.setModifiedDateTime] instead, as
   *   `time_t` is deprecated due to the year 2038 problem.
   */
  void setModified(string uri, long modified)
  {
    const(char)* _uri = uri.toCString(false);
    g_bookmark_file_set_modified(cast(GBookmarkFile*)cPtr, _uri, modified);
  }

  /**
   * Sets the last time the bookmark for uri was last modified.
   * If no bookmark for uri is found then it is created.
   * The "modified" time should only be set when the bookmark's meta-data
   * was actually changed.  Every function of #GBookmarkFile that
   * modifies a bookmark also changes the modification time, except for
   * [GLib.BookmarkFile.setVisitedDateTime].
   * Params:
   *   uri = a valid URI
   *   modified = a #GDateTime
   */
  void setModifiedDateTime(string uri, DateTime modified)
  {
    const(char)* _uri = uri.toCString(false);
    g_bookmark_file_set_modified_date_time(cast(GBookmarkFile*)cPtr, _uri, modified ? cast(GDateTime*)modified.cPtr(false) : null);
  }

  /**
   * Sets title as the title of the bookmark for uri inside the
   * bookmark file bookmark.
   * If uri is %NULL, the title of bookmark is set.
   * If a bookmark for uri cannot be found then it is created.
   * Params:
   *   uri = a valid URI or %NULL
   *   title = a UTF-8 encoded string
   */
  void setTitle(string uri, string title)
  {
    const(char)* _uri = uri.toCString(false);
    const(char)* _title = title.toCString(false);
    g_bookmark_file_set_title(cast(GBookmarkFile*)cPtr, _uri, _title);
  }

  /**
   * Sets the time the bookmark for uri was last visited.
   * If no bookmark for uri is found then it is created.
   * The "visited" time should only be set if the bookmark was launched,
   * either using the command line retrieved by [GLib.BookmarkFile.getApplicationInfo]
   * or by the default application for the bookmark's MIME type, retrieved
   * using [GLib.BookmarkFile.getMimeType].  Changing the "visited" time
   * does not affect the "modified" time.
   * Params:
   *   uri = a valid URI
   *   visited = a timestamp or -1 to use the current time

   * Deprecated: Use [GLib.BookmarkFile.setVisitedDateTime] instead, as
   *   `time_t` is deprecated due to the year 2038 problem.
   */
  void setVisited(string uri, long visited)
  {
    const(char)* _uri = uri.toCString(false);
    g_bookmark_file_set_visited(cast(GBookmarkFile*)cPtr, _uri, visited);
  }

  /**
   * Sets the time the bookmark for uri was last visited.
   * If no bookmark for uri is found then it is created.
   * The "visited" time should only be set if the bookmark was launched,
   * either using the command line retrieved by [GLib.BookmarkFile.getApplicationInfo]
   * or by the default application for the bookmark's MIME type, retrieved
   * using [GLib.BookmarkFile.getMimeType].  Changing the "visited" time
   * does not affect the "modified" time.
   * Params:
   *   uri = a valid URI
   *   visited = a #GDateTime
   */
  void setVisitedDateTime(string uri, DateTime visited)
  {
    const(char)* _uri = uri.toCString(false);
    g_bookmark_file_set_visited_date_time(cast(GBookmarkFile*)cPtr, _uri, visited ? cast(GDateTime*)visited.cPtr(false) : null);
  }

  /**
   * This function outputs bookmark as a string.
   * Returns: a newly allocated string holding the contents of the #GBookmarkFile
   */
  ubyte[] toData()
  {
    ubyte* _cretval;
    size_t _cretlength;
    GError *_err;
    _cretval = g_bookmark_file_to_data(cast(GBookmarkFile*)cPtr, &_cretlength, &_err);
    if (_err)
      throw new BookmarkFileException(_err);
    ubyte[] _retval;

    if (_cretval)
    {
      _retval = cast(ubyte[] )_cretval[0 .. _cretlength];
    }
    return _retval;
  }

  /**
   * This function outputs bookmark into a file.  The write process is
   * guaranteed to be atomic by using [GLib.Global.fileSetContents] internally.
   * Params:
   *   filename = path of the output file
   * Returns: %TRUE if the file was successfully written.
   */
  bool toFile(string filename)
  {
    bool _retval;
    const(char)* _filename = filename.toCString(false);
    GError *_err;
    _retval = g_bookmark_file_to_file(cast(GBookmarkFile*)cPtr, _filename, &_err);
    if (_err)
      throw new BookmarkFileException(_err);
    return _retval;
  }

  static Quark errorQuark()
  {
    Quark _retval;
    _retval = g_bookmark_file_error_quark();
    return _retval;
  }
}

class BookmarkFileException : ErrorG
{
  this(GError* err)
  {
    super(err);
  }

  this(Code code, string msg)
  {
    super(BookmarkFile.errorQuark, cast(int)code, msg);
  }

  alias Code = GBookmarkFileError;
}
