module GLib.BookmarkFile;

import GLib.Boxed;
import GLib.DateTime;
import GLib.ErrorG;
import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.Gid;

/**
 * GBookmarkFile lets you parse, edit or create files containing bookmarks
 * to URI, along with some meta-data about the resource pointed by the URI
 * like its MIME type, the application that is registering the bookmark and
 * the icon that should be used to represent the bookmark. The data is stored
 * using the
 * [Desktop Bookmark Specification](http://www.gnome.org/~ebassi/bookmark-spec).
 *
 * The syntax of the bookmark files is described in detail inside the
 * Desktop Bookmark Specification, here is a quick summary: bookmark
 * files use a sub-class of the XML Bookmark Exchange Language
 * specification, consisting of valid UTF-8 encoded XML, under the
 * <xbel> root element; each bookmark is stored inside a
 * <bookmark> element, using its URI: no relative paths can
 * be used inside a bookmark file. The bookmark may have a user defined
 * title and description, to be used instead of the URI. Under the
 * <metadata> element, with its owner attribute set to
 * `http://freedesktop.org`, is stored the meta-data about a resource
 * pointed by its URI. The meta-data consists of the resource's MIME
 * type; the applications that have registered a bookmark; the groups
 * to which a bookmark belongs to; a visibility flag, used to set the
 * bookmark as "private" to the applications and groups that has it
 * registered; the URI and MIME type of an icon, to be used when
 * displaying the bookmark inside a GUI.
 *
 * Here is an example of a bookmark file:
 * [bookmarks.xbel](https://gitlab.gnome.org/GNOME/glib/-/blob/HEAD/glib/tests/bookmarks.xbel)
 *
 * A bookmark file might contain more than one bookmark; each bookmark
 * is accessed through its URI.
 *
 * The important caveat of bookmark files is that when you add a new
 * bookmark you must also add the application that is registering it, using
 * g_bookmark_file_add_application() or g_bookmark_file_set_application_info().
 * If a bookmark has no applications then it won't be dumped when creating
 * the on disk representation, using g_bookmark_file_to_data() or
 * g_bookmark_file_to_file().
 *
 * The #GBookmarkFile parser was added in GLib 2.12.
 */
class BookmarkFile : Boxed
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  T* cPtr(T)(bool makeCopy = false)
  if (is(T == GBookmarkFile))
  {
    return makeCopy ? copy_!T : cast(T*)cInstancePtr;
  }

  static GType getType()
  {
    return g_bookmark_file_get_type();
  }

  /**
   * an empty #GBookmarkFile
   */
  this()
  {
    GBookmarkFile* _cretval;
    _cretval = g_bookmark_file_new();
    this(_cretval, true);
  }

  /**
   * Adds the application with @name and @exec to the list of
   * applications that have registered a bookmark for @uri into
   * @bookmark.
   *
   * Every bookmark inside a #GBookmarkFile must have at least an
   * application registered.  Each application must provide a name, a
   * command line useful for launching the bookmark, the number of times
   * the bookmark has been registered by the application and the last
   * time the application registered this bookmark.
   *
   * If @name is %NULL, the name of the application will be the
   * same returned by g_get_application_name(); if @exec is %NULL, the
   * command line will be a composition of the program name as
   * returned by g_get_prgname() and the "\%u" modifier, which will be
   * expanded to the bookmark's URI.
   *
   * This function will automatically take care of updating the
   * registrations count and timestamping in case an application
   * with the same @name had already registered a bookmark for
   * @uri inside @bookmark.
   *
   * If no bookmark for @uri is found, one is created.
   */
  void addApplication(string uri, string name, string exec)
  {
    const(char)* _uri = uri.toCString(false);
    const(char)* _name = name.toCString(false);
    const(char)* _exec = exec.toCString(false);
    g_bookmark_file_add_application(cPtr!GBookmarkFile, _uri, _name, _exec);
  }

  /**
   * Adds @group to the list of groups to which the bookmark for @uri
   * belongs to.
   *
   * If no bookmark for @uri is found then it is created.
   */
  void addGroup(string uri, string group)
  {
    const(char)* _uri = uri.toCString(false);
    const(char)* _group = group.toCString(false);
    g_bookmark_file_add_group(cPtr!GBookmarkFile, _uri, _group);
  }

  /**
   * the copy of @bookmark. Use
   * g_bookmark_free() when finished using it.
   */
  BookmarkFile copy()
  {
    GBookmarkFile* _cretval;
    _cretval = g_bookmark_file_copy(cPtr!GBookmarkFile);
    BookmarkFile _retval = new BookmarkFile(cast(GBookmarkFile*)_cretval, true);
    return _retval;
  }

  /**
   * a timestamp
   */
  long getAdded(string uri)
  {
    long _retval;
    const(char)* _uri = uri.toCString(false);
    GError *_err;
    _retval = g_bookmark_file_get_added(cPtr!GBookmarkFile, _uri, &_err);
    if (_err)
      throw new BookmarkFileException(_err);
    return _retval;
  }

  /**
   * a #GDateTime
   */
  DateTime getAddedDateTime(string uri)
  {
    GDateTime* _cretval;
    const(char)* _uri = uri.toCString(false);
    GError *_err;
    _cretval = g_bookmark_file_get_added_date_time(cPtr!GBookmarkFile, _uri, &_err);
    if (_err)
      throw new BookmarkFileException(_err);
    DateTime _retval = new DateTime(cast(GDateTime*)_cretval, false);
    return _retval;
  }

  /**
   * %TRUE on success.
   */
  bool getAppInfo(string uri, string name, out string exec, out uint count, out long stamp)
  {
    bool _retval;
    const(char)* _uri = uri.toCString(false);
    const(char)* _name = name.toCString(false);
    char* _exec;
    GError *_err;
    _retval = g_bookmark_file_get_app_info(cPtr!GBookmarkFile, _uri, _name, &_exec, cast(uint*)&count, cast(long*)&stamp, &_err);
    if (_err)
      throw new BookmarkFileException(_err);
    exec = _exec.fromCString(true);
    return _retval;
  }

  /**
   * %TRUE on success.
   */
  bool getApplicationInfo(string uri, string name, out string exec, out uint count, out DateTime stamp)
  {
    bool _retval;
    const(char)* _uri = uri.toCString(false);
    const(char)* _name = name.toCString(false);
    char* _exec;
    GDateTime* _stamp;
    GError *_err;
    _retval = g_bookmark_file_get_application_info(cPtr!GBookmarkFile, _uri, _name, &_exec, cast(uint*)&count, &_stamp, &_err);
    if (_err)
      throw new BookmarkFileException(_err);
    exec = _exec.fromCString(true);
    stamp = new DateTime(cast(void*)_stamp, false);
    return _retval;
  }

  /**
   * a newly allocated %NULL-terminated array of strings.
   * Use g_strfreev() to free it.
   */
  string[] getApplications(string uri)
  {
    char** _cretval;
    size_t _cretlength;
    const(char)* _uri = uri.toCString(false);
    GError *_err;
    _cretval = g_bookmark_file_get_applications(cPtr!GBookmarkFile, _uri, &_cretlength, &_err);
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
   * a newly allocated string or %NULL if the specified
   * URI cannot be found.
   */
  string getDescription(string uri)
  {
    char* _cretval;
    const(char)* _uri = uri.toCString(false);
    GError *_err;
    _cretval = g_bookmark_file_get_description(cPtr!GBookmarkFile, _uri, &_err);
    if (_err)
      throw new BookmarkFileException(_err);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * a newly allocated %NULL-terminated array of group names.
   * Use g_strfreev() to free it.
   */
  string[] getGroups(string uri)
  {
    char** _cretval;
    size_t _cretlength;
    const(char)* _uri = uri.toCString(false);
    GError *_err;
    _cretval = g_bookmark_file_get_groups(cPtr!GBookmarkFile, _uri, &_cretlength, &_err);
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
   * %TRUE if the icon for the bookmark for the URI was found.
   * You should free the returned strings.
   */
  bool getIcon(string uri, out string href, out string mimeType)
  {
    bool _retval;
    const(char)* _uri = uri.toCString(false);
    char* _href;
    char* _mimeType;
    GError *_err;
    _retval = g_bookmark_file_get_icon(cPtr!GBookmarkFile, _uri, &_href, &_mimeType, &_err);
    if (_err)
      throw new BookmarkFileException(_err);
    href = _href.fromCString(true);
    mimeType = _mimeType.fromCString(true);
    return _retval;
  }

  /**
   * %TRUE if the private flag is set, %FALSE otherwise.
   */
  bool getIsPrivate(string uri)
  {
    bool _retval;
    const(char)* _uri = uri.toCString(false);
    GError *_err;
    _retval = g_bookmark_file_get_is_private(cPtr!GBookmarkFile, _uri, &_err);
    if (_err)
      throw new BookmarkFileException(_err);
    return _retval;
  }

  /**
   * a newly allocated string or %NULL if the specified
   * URI cannot be found.
   */
  string getMimeType(string uri)
  {
    char* _cretval;
    const(char)* _uri = uri.toCString(false);
    GError *_err;
    _cretval = g_bookmark_file_get_mime_type(cPtr!GBookmarkFile, _uri, &_err);
    if (_err)
      throw new BookmarkFileException(_err);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * a timestamp
   */
  long getModified(string uri)
  {
    long _retval;
    const(char)* _uri = uri.toCString(false);
    GError *_err;
    _retval = g_bookmark_file_get_modified(cPtr!GBookmarkFile, _uri, &_err);
    if (_err)
      throw new BookmarkFileException(_err);
    return _retval;
  }

  /**
   * a #GDateTime
   */
  DateTime getModifiedDateTime(string uri)
  {
    GDateTime* _cretval;
    const(char)* _uri = uri.toCString(false);
    GError *_err;
    _cretval = g_bookmark_file_get_modified_date_time(cPtr!GBookmarkFile, _uri, &_err);
    if (_err)
      throw new BookmarkFileException(_err);
    DateTime _retval = new DateTime(cast(GDateTime*)_cretval, false);
    return _retval;
  }

  /**
   * the number of bookmarks
   */
  int getSize()
  {
    int _retval;
    _retval = g_bookmark_file_get_size(cPtr!GBookmarkFile);
    return _retval;
  }

  /**
   * a newly allocated string or %NULL if the specified
   * URI cannot be found.
   */
  string getTitle(string uri)
  {
    char* _cretval;
    const(char)* _uri = uri.toCString(false);
    GError *_err;
    _cretval = g_bookmark_file_get_title(cPtr!GBookmarkFile, _uri, &_err);
    if (_err)
      throw new BookmarkFileException(_err);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * a newly allocated %NULL-terminated array of strings.
   * Use g_strfreev() to free it.
   */
  string[] getUris()
  {
    char** _cretval;
    size_t _cretlength;
    _cretval = g_bookmark_file_get_uris(cPtr!GBookmarkFile, &_cretlength);
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
   * a timestamp.
   */
  long getVisited(string uri)
  {
    long _retval;
    const(char)* _uri = uri.toCString(false);
    GError *_err;
    _retval = g_bookmark_file_get_visited(cPtr!GBookmarkFile, _uri, &_err);
    if (_err)
      throw new BookmarkFileException(_err);
    return _retval;
  }

  /**
   * a #GDateTime
   */
  DateTime getVisitedDateTime(string uri)
  {
    GDateTime* _cretval;
    const(char)* _uri = uri.toCString(false);
    GError *_err;
    _cretval = g_bookmark_file_get_visited_date_time(cPtr!GBookmarkFile, _uri, &_err);
    if (_err)
      throw new BookmarkFileException(_err);
    DateTime _retval = new DateTime(cast(GDateTime*)_cretval, false);
    return _retval;
  }

  /**
   * %TRUE if the application @name was found
   */
  bool hasApplication(string uri, string name)
  {
    bool _retval;
    const(char)* _uri = uri.toCString(false);
    const(char)* _name = name.toCString(false);
    GError *_err;
    _retval = g_bookmark_file_has_application(cPtr!GBookmarkFile, _uri, _name, &_err);
    if (_err)
      throw new BookmarkFileException(_err);
    return _retval;
  }

  /**
   * %TRUE if @group was found.
   */
  bool hasGroup(string uri, string group)
  {
    bool _retval;
    const(char)* _uri = uri.toCString(false);
    const(char)* _group = group.toCString(false);
    GError *_err;
    _retval = g_bookmark_file_has_group(cPtr!GBookmarkFile, _uri, _group, &_err);
    if (_err)
      throw new BookmarkFileException(_err);
    return _retval;
  }

  /**
   * %TRUE if @uri is inside @bookmark, %FALSE otherwise
   */
  bool hasItem(string uri)
  {
    bool _retval;
    const(char)* _uri = uri.toCString(false);
    _retval = g_bookmark_file_has_item(cPtr!GBookmarkFile, _uri);
    return _retval;
  }

  /**
   * %TRUE if a desktop bookmark could be loaded.
   */
  bool loadFromData(ubyte[] data)
  {
    bool _retval;
    auto _data = cast(const(ubyte)*)data.ptr;
    GError *_err;
    _retval = g_bookmark_file_load_from_data(cPtr!GBookmarkFile, _data, data ? cast(size_t)data.length : 0, &_err);
    if (_err)
      throw new BookmarkFileException(_err);
    return _retval;
  }

  /**
   * %TRUE if a key file could be loaded, %FALSE otherwise
   */
  bool loadFromDataDirs(string file, out string fullPath)
  {
    bool _retval;
    const(char)* _file = file.toCString(false);
    char* _fullPath;
    GError *_err;
    _retval = g_bookmark_file_load_from_data_dirs(cPtr!GBookmarkFile, _file, &_fullPath, &_err);
    if (_err)
      throw new BookmarkFileException(_err);
    fullPath = _fullPath.fromCString(true);
    return _retval;
  }

  /**
   * %TRUE if a desktop bookmark file could be loaded
   */
  bool loadFromFile(string filename)
  {
    bool _retval;
    const(char)* _filename = filename.toCString(false);
    GError *_err;
    _retval = g_bookmark_file_load_from_file(cPtr!GBookmarkFile, _filename, &_err);
    if (_err)
      throw new BookmarkFileException(_err);
    return _retval;
  }

  /**
   * %TRUE if the URI was successfully changed
   */
  bool moveItem(string oldUri, string newUri)
  {
    bool _retval;
    const(char)* _oldUri = oldUri.toCString(false);
    const(char)* _newUri = newUri.toCString(false);
    GError *_err;
    _retval = g_bookmark_file_move_item(cPtr!GBookmarkFile, _oldUri, _newUri, &_err);
    if (_err)
      throw new BookmarkFileException(_err);
    return _retval;
  }

  /**
   * %TRUE if the application was successfully removed.
   */
  bool removeApplication(string uri, string name)
  {
    bool _retval;
    const(char)* _uri = uri.toCString(false);
    const(char)* _name = name.toCString(false);
    GError *_err;
    _retval = g_bookmark_file_remove_application(cPtr!GBookmarkFile, _uri, _name, &_err);
    if (_err)
      throw new BookmarkFileException(_err);
    return _retval;
  }

  /**
   * %TRUE if @group was successfully removed.
   */
  bool removeGroup(string uri, string group)
  {
    bool _retval;
    const(char)* _uri = uri.toCString(false);
    const(char)* _group = group.toCString(false);
    GError *_err;
    _retval = g_bookmark_file_remove_group(cPtr!GBookmarkFile, _uri, _group, &_err);
    if (_err)
      throw new BookmarkFileException(_err);
    return _retval;
  }

  /**
   * %TRUE if the bookmark was removed successfully.
   */
  bool removeItem(string uri)
  {
    bool _retval;
    const(char)* _uri = uri.toCString(false);
    GError *_err;
    _retval = g_bookmark_file_remove_item(cPtr!GBookmarkFile, _uri, &_err);
    if (_err)
      throw new BookmarkFileException(_err);
    return _retval;
  }

  /**
   * Sets the time the bookmark for @uri was added into @bookmark.
   *
   * If no bookmark for @uri is found then it is created.
   */
  void setAdded(string uri, long added)
  {
    const(char)* _uri = uri.toCString(false);
    g_bookmark_file_set_added(cPtr!GBookmarkFile, _uri, added);
  }

  /**
   * Sets the time the bookmark for @uri was added into @bookmark.
   *
   * If no bookmark for @uri is found then it is created.
   */
  void setAddedDateTime(string uri, DateTime added)
  {
    const(char)* _uri = uri.toCString(false);
    g_bookmark_file_set_added_date_time(cPtr!GBookmarkFile, _uri, added ? added.cPtr!GDateTime : null);
  }

  /**
   * %TRUE if the application's meta-data was successfully
   * changed.
   */
  bool setAppInfo(string uri, string name, string exec, int count, long stamp)
  {
    bool _retval;
    const(char)* _uri = uri.toCString(false);
    const(char)* _name = name.toCString(false);
    const(char)* _exec = exec.toCString(false);
    GError *_err;
    _retval = g_bookmark_file_set_app_info(cPtr!GBookmarkFile, _uri, _name, _exec, count, stamp, &_err);
    if (_err)
      throw new BookmarkFileException(_err);
    return _retval;
  }

  /**
   * %TRUE if the application's meta-data was successfully
   * changed.
   */
  bool setApplicationInfo(string uri, string name, string exec, int count, DateTime stamp)
  {
    bool _retval;
    const(char)* _uri = uri.toCString(false);
    const(char)* _name = name.toCString(false);
    const(char)* _exec = exec.toCString(false);
    GError *_err;
    _retval = g_bookmark_file_set_application_info(cPtr!GBookmarkFile, _uri, _name, _exec, count, stamp ? stamp.cPtr!GDateTime : null, &_err);
    if (_err)
      throw new BookmarkFileException(_err);
    return _retval;
  }

  /**
   * Sets @description as the description of the bookmark for @uri.
   *
   * If @uri is %NULL, the description of @bookmark is set.
   *
   * If a bookmark for @uri cannot be found then it is created.
   */
  void setDescription(string uri, string description)
  {
    const(char)* _uri = uri.toCString(false);
    const(char)* _description = description.toCString(false);
    g_bookmark_file_set_description(cPtr!GBookmarkFile, _uri, _description);
  }

  /**
   * Sets a list of group names for the item with URI @uri.  Each previously
   * set group name list is removed.
   *
   * If @uri cannot be found then an item for it is created.
   */
  void setGroups(string uri, string[] groups)
  {
    const(char)* _uri = uri.toCString(false);
    char*[] _tmpgroups;
    foreach (s; groups)
      _tmpgroups ~= s.toCString(false);
    const(char*)* _groups = _tmpgroups.ptr;
    g_bookmark_file_set_groups(cPtr!GBookmarkFile, _uri, _groups, groups ? cast(size_t)groups.length : 0);
  }

  /**
   * Sets the icon for the bookmark for @uri. If @href is %NULL, unsets
   * the currently set icon. @href can either be a full URL for the icon
   * file or the icon name following the Icon Naming specification.
   *
   * If no bookmark for @uri is found one is created.
   */
  void setIcon(string uri, string href, string mimeType)
  {
    const(char)* _uri = uri.toCString(false);
    const(char)* _href = href.toCString(false);
    const(char)* _mimeType = mimeType.toCString(false);
    g_bookmark_file_set_icon(cPtr!GBookmarkFile, _uri, _href, _mimeType);
  }

  /**
   * Sets the private flag of the bookmark for @uri.
   *
   * If a bookmark for @uri cannot be found then it is created.
   */
  void setIsPrivate(string uri, bool isPrivate)
  {
    const(char)* _uri = uri.toCString(false);
    g_bookmark_file_set_is_private(cPtr!GBookmarkFile, _uri, isPrivate);
  }

  /**
   * Sets @mime_type as the MIME type of the bookmark for @uri.
   *
   * If a bookmark for @uri cannot be found then it is created.
   */
  void setMimeType(string uri, string mimeType)
  {
    const(char)* _uri = uri.toCString(false);
    const(char)* _mimeType = mimeType.toCString(false);
    g_bookmark_file_set_mime_type(cPtr!GBookmarkFile, _uri, _mimeType);
  }

  /**
   * Sets the last time the bookmark for @uri was last modified.
   *
   * If no bookmark for @uri is found then it is created.
   *
   * The "modified" time should only be set when the bookmark's meta-data
   * was actually changed.  Every function of #GBookmarkFile that
   * modifies a bookmark also changes the modification time, except for
   * g_bookmark_file_set_visited_date_time().
   */
  void setModified(string uri, long modified)
  {
    const(char)* _uri = uri.toCString(false);
    g_bookmark_file_set_modified(cPtr!GBookmarkFile, _uri, modified);
  }

  /**
   * Sets the last time the bookmark for @uri was last modified.
   *
   * If no bookmark for @uri is found then it is created.
   *
   * The "modified" time should only be set when the bookmark's meta-data
   * was actually changed.  Every function of #GBookmarkFile that
   * modifies a bookmark also changes the modification time, except for
   * g_bookmark_file_set_visited_date_time().
   */
  void setModifiedDateTime(string uri, DateTime modified)
  {
    const(char)* _uri = uri.toCString(false);
    g_bookmark_file_set_modified_date_time(cPtr!GBookmarkFile, _uri, modified ? modified.cPtr!GDateTime : null);
  }

  /**
   * Sets @title as the title of the bookmark for @uri inside the
   * bookmark file @bookmark.
   *
   * If @uri is %NULL, the title of @bookmark is set.
   *
   * If a bookmark for @uri cannot be found then it is created.
   */
  void setTitle(string uri, string title)
  {
    const(char)* _uri = uri.toCString(false);
    const(char)* _title = title.toCString(false);
    g_bookmark_file_set_title(cPtr!GBookmarkFile, _uri, _title);
  }

  /**
   * Sets the time the bookmark for @uri was last visited.
   *
   * If no bookmark for @uri is found then it is created.
   *
   * The "visited" time should only be set if the bookmark was launched,
   * either using the command line retrieved by g_bookmark_file_get_application_info()
   * or by the default application for the bookmark's MIME type, retrieved
   * using g_bookmark_file_get_mime_type().  Changing the "visited" time
   * does not affect the "modified" time.
   */
  void setVisited(string uri, long visited)
  {
    const(char)* _uri = uri.toCString(false);
    g_bookmark_file_set_visited(cPtr!GBookmarkFile, _uri, visited);
  }

  /**
   * Sets the time the bookmark for @uri was last visited.
   *
   * If no bookmark for @uri is found then it is created.
   *
   * The "visited" time should only be set if the bookmark was launched,
   * either using the command line retrieved by g_bookmark_file_get_application_info()
   * or by the default application for the bookmark's MIME type, retrieved
   * using g_bookmark_file_get_mime_type().  Changing the "visited" time
   * does not affect the "modified" time.
   */
  void setVisitedDateTime(string uri, DateTime visited)
  {
    const(char)* _uri = uri.toCString(false);
    g_bookmark_file_set_visited_date_time(cPtr!GBookmarkFile, _uri, visited ? visited.cPtr!GDateTime : null);
  }

  /**
   * a newly allocated string holding the contents of the #GBookmarkFile
   */
  ubyte[] toData()
  {
    ubyte* _cretval;
    size_t _cretlength;
    GError *_err;
    _cretval = g_bookmark_file_to_data(cPtr!GBookmarkFile, &_cretlength, &_err);
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
   * %TRUE if the file was successfully written.
   */
  bool toFile(string filename)
  {
    bool _retval;
    const(char)* _filename = filename.toCString(false);
    GError *_err;
    _retval = g_bookmark_file_to_file(cPtr!GBookmarkFile, _filename, &_err);
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
