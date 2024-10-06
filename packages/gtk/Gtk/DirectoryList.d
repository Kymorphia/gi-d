module Gtk.DirectoryList;

import GLib.ErrorG;
import GObject.ObjectG;
import Gid.gid;
import Gio.File;
import Gio.FileT;
import Gio.ListModel;
import Gio.ListModelT;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkDirectoryList` is a list model that wraps [Gio.File.enumerateChildrenAsync].
 * It presents a `GListModel` and fills it asynchronously with the `GFileInfo`s
 * returned from that function.
 * Enumeration will start automatically when the
 * [Gtk.DirectoryList.file] property is set.
 * While the `GtkDirectoryList` is being filled, the
 * [Gtk.DirectoryList.loading] property will be set to %TRUE. You can
 * listen to that property if you want to show information like a `GtkSpinner`
 * or a "Loading..." text.
 * If loading fails at any point, the [Gtk.DirectoryList.error]
 * property will be set to give more indication about the failure.
 * The `GFileInfo`s returned from a `GtkDirectoryList` have the "standard::file"
 * attribute set to the `GFile` they refer to. This way you can get at the file
 * that is referred to in the same way you would via [Gio.FileEnumerator.getChild].
 * This means you do not need access to the `GtkDirectoryList`, but can access
 * the `GFile` directly from the `GFileInfo` when operating with a `GtkListView`
 * or similar.
 */
class DirectoryList : ObjectG, ListModel
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
    return gtk_directory_list_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin ListModelT!GtkDirectoryList;

  /**
   * Creates a new `GtkDirectoryList`.
   * The `GtkDirectoryList` is querying the given file
   * with the given attributes.
   * Params:
   *   attributes = The attributes to query with
   *   file = The file to query
   * Returns: a new `GtkDirectoryList`
   */
  this(string attributes, File file)
  {
    GtkDirectoryList* _cretval;
    const(char)* _attributes = attributes.toCString(false);
    _cretval = gtk_directory_list_new(_attributes, file ? cast(GFile*)(cast(ObjectG)file).cPtr(false) : null);
    this(_cretval, true);
  }

  /**
   * Gets the attributes queried on the children.
   * Returns: The queried attributes
   */
  string getAttributes()
  {
    const(char)* _cretval;
    _cretval = gtk_directory_list_get_attributes(cast(GtkDirectoryList*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Gets the loading error, if any.
   * If an error occurs during the loading process, the loading process
   * will finish and this property allows querying the error that happened.
   * This error will persist until a file is loaded again.
   * An error being set does not mean that no files were loaded, and all
   * successfully queried files will remain in the list.
   * Returns: The loading error or %NULL if
   *   loading finished successfully
   */
  ErrorG getError()
  {
    const(GError)* _cretval;
    _cretval = gtk_directory_list_get_error(cast(GtkDirectoryList*)cPtr);
    auto _retval = _cretval ? new ErrorG(cast(GError*)_cretval) : null;
    return _retval;
  }

  /**
   * Gets the file whose children are currently enumerated.
   * Returns: The file whose children are enumerated
   */
  File getFile()
  {
    GFile* _cretval;
    _cretval = gtk_directory_list_get_file(cast(GtkDirectoryList*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!File(cast(GFile*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the IO priority set via [Gtk.DirectoryList.setIoPriority].
   * Returns: The IO priority.
   */
  int getIoPriority()
  {
    int _retval;
    _retval = gtk_directory_list_get_io_priority(cast(GtkDirectoryList*)cPtr);
    return _retval;
  }

  /**
   * Returns whether the directory list is monitoring
   * the directory for changes.
   * Returns: %TRUE if the directory is monitored
   */
  bool getMonitored()
  {
    bool _retval;
    _retval = gtk_directory_list_get_monitored(cast(GtkDirectoryList*)cPtr);
    return _retval;
  }

  /**
   * Returns %TRUE if the children enumeration is currently in
   * progress.
   * Files will be added to self from time to time while loading is
   * going on. The order in which are added is undefined and may change
   * in between runs.
   * Returns: %TRUE if self is loading
   */
  bool isLoading()
  {
    bool _retval;
    _retval = gtk_directory_list_is_loading(cast(GtkDirectoryList*)cPtr);
    return _retval;
  }

  /**
   * Sets the attributes to be enumerated and starts the enumeration.
   * If attributes is %NULL, the list of file infos will still be created, it will just
   * not contain any extra attributes.
   * Params:
   *   attributes = the attributes to enumerate
   */
  void setAttributes(string attributes)
  {
    const(char)* _attributes = attributes.toCString(false);
    gtk_directory_list_set_attributes(cast(GtkDirectoryList*)cPtr, _attributes);
  }

  /**
   * Sets the file to be enumerated and starts the enumeration.
   * If file is %NULL, the result will be an empty list.
   * Params:
   *   file = the `GFile` to be enumerated
   */
  void setFile(File file)
  {
    gtk_directory_list_set_file(cast(GtkDirectoryList*)cPtr, file ? cast(GFile*)(cast(ObjectG)file).cPtr(false) : null);
  }

  /**
   * Sets the IO priority to use while loading directories.
   * Setting the priority while self is loading will reprioritize the
   * ongoing load as soon as possible.
   * The default IO priority is %G_PRIORITY_DEFAULT, which is higher than
   * the GTK redraw priority. If you are loading a lot of directories in
   * parallel, lowering it to something like %G_PRIORITY_DEFAULT_IDLE
   * may increase responsiveness.
   * Params:
   *   ioPriority = IO priority to use
   */
  void setIoPriority(int ioPriority)
  {
    gtk_directory_list_set_io_priority(cast(GtkDirectoryList*)cPtr, ioPriority);
  }

  /**
   * Sets whether the directory list will monitor the directory
   * for changes.
   * If monitoring is enabled, the ::items-changed signal will
   * be emitted when the directory contents change.
   * When monitoring is turned on after the initial creation
   * of the directory list, the directory is reloaded to avoid
   * missing files that appeared between the initial loading
   * and when monitoring was turned on.
   * Params:
   *   monitored = %TRUE to monitor the directory for changes
   */
  void setMonitored(bool monitored)
  {
    gtk_directory_list_set_monitored(cast(GtkDirectoryList*)cPtr, monitored);
  }
}
