module Gtk.FileChooserT;

public import Gtk.FileChooserIfaceProxy;
public import GLib.ErrorG;
public import GObject.ObjectG;
public import Gid.gid;
public import Gio.File;
public import Gio.FileT;
public import Gio.ListModel;
public import Gio.ListModelT;
public import Gtk.FileFilter;
public import Gtk.Types;
public import Gtk.c.functions;
public import Gtk.c.types;

/**
 * `GtkFileChooser` is an interface that can be implemented by file
 * selection widgets.
 * In GTK, the main objects that implement this interface are
 * [Gtk.FileChooserWidget] and [Gtk.FileChooserDialog].
 * You do not need to write an object that implements the `GtkFileChooser`
 * interface unless you are trying to adapt an existing file selector to
 * expose a standard programming interface.
 * `GtkFileChooser` allows for shortcuts to various places in the filesystem.
 * In the default implementation these are displayed in the left pane. It
 * may be a bit confusing at first that these shortcuts come from various
 * sources and in various flavours, so lets explain the terminology here:
 * - Bookmarks: are created by the user, by dragging folders from the
 * right pane to the left pane, or by using the “Add”. Bookmarks
 * can be renamed and deleted by the user.
 * - Shortcuts: can be provided by the application. For example, a Paint
 * program may want to add a shortcut for a Clipart folder. Shortcuts
 * cannot be modified by the user.
 * - Volumes: are provided by the underlying filesystem abstraction. They are
 * the “roots” of the filesystem.
 * # File Names and Encodings
 * When the user is finished selecting files in a `GtkFileChooser`, your
 * program can get the selected filenames as `GFile`s.
 * # Adding options
 * You can add extra widgets to a file chooser to provide options
 * that are not present in the default design, by using
 * [Gtk.FileChooser.addChoice]. Each choice has an identifier and
 * a user visible label; additionally, each choice can have multiple
 * options. If a choice has no option, it will be rendered as a
 * check button with the given label; if a choice has options, it will
 * be rendered as a combo box.

 * Deprecated: Use [Gtk.FileDialog] instead
 */
template FileChooserT()
{

  /**
   * Adds filter to the list of filters that the user can select between.
   * When a filter is selected, only files that are passed by that
   * filter are displayed.
   * Note that the chooser takes ownership of the filter if it is floating,
   * so you have to ref and sink it if you want to keep a reference.
   * Params:
   *   filter = a `GtkFileFilter`

   * Deprecated: Use [Gtk.FileDialog] instead
   */
  override void addFilter(FileFilter filter)
  {
    gtk_file_chooser_add_filter(cast(GtkFileChooser*)cPtr, filter ? cast(GtkFileFilter*)filter.cPtr(false) : null);
  }

  /**
   * Adds a folder to be displayed with the shortcut folders
   * in a file chooser.
   * Params:
   *   folder = a `GFile` for the folder to add
   * Returns: %TRUE if the folder could be added successfully,
   *   %FALSE otherwise.

   * Deprecated: Use [Gtk.FileDialog] instead
   */
  override bool addShortcutFolder(File folder)
  {
    bool _retval;
    GError *_err;
    _retval = gtk_file_chooser_add_shortcut_folder(cast(GtkFileChooser*)cPtr, folder ? cast(GFile*)(cast(ObjectG)folder).cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Gets the type of operation that the file chooser is performing.
   * Returns: the action that the file selector is performing

   * Deprecated: Use [Gtk.FileDialog] instead
   */
  override FileChooserAction getAction()
  {
    GtkFileChooserAction _cretval;
    _cretval = gtk_file_chooser_get_action(cast(GtkFileChooser*)cPtr);
    FileChooserAction _retval = cast(FileChooserAction)_cretval;
    return _retval;
  }

  /**
   * Gets the currently selected option in the 'choice' with the given ID.
   * Params:
   *   id = the ID of the choice to get
   * Returns: the ID of the currently selected option

   * Deprecated: Use [Gtk.FileDialog] instead
   */
  override string getChoice(string id)
  {
    const(char)* _cretval;
    const(char)* _id = id.toCString(false);
    _cretval = gtk_file_chooser_get_choice(cast(GtkFileChooser*)cPtr, _id);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Gets whether file chooser will offer to create new folders.
   * Returns: %TRUE if the Create Folder button should be displayed.

   * Deprecated: Use [Gtk.FileDialog] instead
   */
  override bool getCreateFolders()
  {
    bool _retval;
    _retval = gtk_file_chooser_get_create_folders(cast(GtkFileChooser*)cPtr);
    return _retval;
  }

  /**
   * Gets the current folder of chooser as `GFile`.
   * Returns: the `GFile` for the current folder.

   * Deprecated: Use [Gtk.FileDialog] instead
   */
  override File getCurrentFolder()
  {
    GFile* _cretval;
    _cretval = gtk_file_chooser_get_current_folder(cast(GtkFileChooser*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!File(cast(GFile*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Gets the current name in the file selector, as entered by the user.
   * This is meant to be used in save dialogs, to get the currently typed
   * filename when the file itself does not exist yet.
   * Returns: The raw text from the file chooser’s “Name” entry. Free with
   *   [GLib.Global.gfree]. Note that this string is not a full pathname or URI; it is
   *   whatever the contents of the entry are. Note also that this string is
   *   in UTF-8 encoding, which is not necessarily the system’s encoding for
   *   filenames.

   * Deprecated: Use [Gtk.FileDialog] instead
   */
  override string getCurrentName()
  {
    char* _cretval;
    _cretval = gtk_file_chooser_get_current_name(cast(GtkFileChooser*)cPtr);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * Gets the `GFile` for the currently selected file in
   * the file selector.
   * If multiple files are selected, one of the files will be
   * returned at random.
   * If the file chooser is in folder mode, this function returns
   * the selected folder.
   * Returns: a selected `GFile`. You own the
   *   returned file; use [GObject.ObjectG.unref] to release it.

   * Deprecated: Use [Gtk.FileDialog] instead
   */
  override File getFile()
  {
    GFile* _cretval;
    _cretval = gtk_file_chooser_get_file(cast(GtkFileChooser*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!File(cast(GFile*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Lists all the selected files and subfolders in the current folder
   * of chooser as `GFile`.
   * Returns: a list model containing a `GFile` for each
   *   selected file and subfolder in the current folder. Free the returned
   *   list with [GObject.ObjectG.unref].

   * Deprecated: Use [Gtk.FileDialog] instead
   */
  override ListModel getFiles()
  {
    GListModel* _cretval;
    _cretval = gtk_file_chooser_get_files(cast(GtkFileChooser*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!ListModel(cast(GListModel*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Gets the current filter.
   * Returns: the current filter

   * Deprecated: Use [Gtk.FileDialog] instead
   */
  override FileFilter getFilter()
  {
    GtkFileFilter* _cretval;
    _cretval = gtk_file_chooser_get_filter(cast(GtkFileChooser*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!FileFilter(cast(GtkFileFilter*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the current set of user-selectable filters, as a list model.
   * See [Gtk.FileChooser.addFilter] and
   * [Gtk.FileChooser.removeFilter] for changing individual filters.
   * You should not modify the returned list model. Future changes to
   * chooser may or may not affect the returned model.
   * Returns: a `GListModel` containing the current set
   *   of user-selectable filters.

   * Deprecated: Use [Gtk.FileDialog] instead
   */
  override ListModel getFilters()
  {
    GListModel* _cretval;
    _cretval = gtk_file_chooser_get_filters(cast(GtkFileChooser*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!ListModel(cast(GListModel*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Gets whether multiple files can be selected in the file
   * chooser.
   * Returns: %TRUE if multiple files can be selected.

   * Deprecated: Use [Gtk.FileDialog] instead
   */
  override bool getSelectMultiple()
  {
    bool _retval;
    _retval = gtk_file_chooser_get_select_multiple(cast(GtkFileChooser*)cPtr);
    return _retval;
  }

  /**
   * Queries the list of shortcut folders in the file chooser.
   * You should not modify the returned list model. Future changes to
   * chooser may or may not affect the returned model.
   * Returns: A list model of `GFile`s

   * Deprecated: Use [Gtk.FileDialog] instead
   */
  override ListModel getShortcutFolders()
  {
    GListModel* _cretval;
    _cretval = gtk_file_chooser_get_shortcut_folders(cast(GtkFileChooser*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!ListModel(cast(GListModel*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Removes a 'choice' that has been added with [Gtk.FileChooser.addChoice].
   * Params:
   *   id = the ID of the choice to remove

   * Deprecated: Use [Gtk.FileDialog] instead
   */
  override void removeChoice(string id)
  {
    const(char)* _id = id.toCString(false);
    gtk_file_chooser_remove_choice(cast(GtkFileChooser*)cPtr, _id);
  }

  /**
   * Removes filter from the list of filters that the user can select between.
   * Params:
   *   filter = a `GtkFileFilter`

   * Deprecated: Use [Gtk.FileDialog] instead
   */
  override void removeFilter(FileFilter filter)
  {
    gtk_file_chooser_remove_filter(cast(GtkFileChooser*)cPtr, filter ? cast(GtkFileFilter*)filter.cPtr(false) : null);
  }

  /**
   * Removes a folder from the shortcut folders in a file chooser.
   * Params:
   *   folder = a `GFile` for the folder to remove
   * Returns: %TRUE if the folder could be removed successfully,
   *   %FALSE otherwise.

   * Deprecated: Use [Gtk.FileDialog] instead
   */
  override bool removeShortcutFolder(File folder)
  {
    bool _retval;
    GError *_err;
    _retval = gtk_file_chooser_remove_shortcut_folder(cast(GtkFileChooser*)cPtr, folder ? cast(GFile*)(cast(ObjectG)folder).cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Sets the type of operation that the chooser is performing.
   * The user interface is adapted to suit the selected action.
   * For example, an option to create a new folder might be shown
   * if the action is %GTK_FILE_CHOOSER_ACTION_SAVE but not if the
   * action is %GTK_FILE_CHOOSER_ACTION_OPEN.
   * Params:
   *   action = the action that the file selector is performing

   * Deprecated: Use [Gtk.FileDialog] instead
   */
  override void setAction(FileChooserAction action)
  {
    gtk_file_chooser_set_action(cast(GtkFileChooser*)cPtr, action);
  }

  /**
   * Selects an option in a 'choice' that has been added with
   * [Gtk.FileChooser.addChoice].
   * For a boolean choice, the possible options are "true" and "false".
   * Params:
   *   id = the ID of the choice to set
   *   option = the ID of the option to select

   * Deprecated: Use [Gtk.FileDialog] instead
   */
  override void setChoice(string id, string option)
  {
    const(char)* _id = id.toCString(false);
    const(char)* _option = option.toCString(false);
    gtk_file_chooser_set_choice(cast(GtkFileChooser*)cPtr, _id, _option);
  }

  /**
   * Sets whether file chooser will offer to create new folders.
   * This is only relevant if the action is not set to be
   * %GTK_FILE_CHOOSER_ACTION_OPEN.
   * Params:
   *   createFolders = %TRUE if the Create Folder button should be displayed

   * Deprecated: Use [Gtk.FileDialog] instead
   */
  override void setCreateFolders(bool createFolders)
  {
    gtk_file_chooser_set_create_folders(cast(GtkFileChooser*)cPtr, createFolders);
  }

  /**
   * Sets the current folder for chooser from a `GFile`.
   * Params:
   *   file = the `GFile` for the new folder
   * Returns: %TRUE if the folder could be changed successfully, %FALSE
   *   otherwise.

   * Deprecated: Use [Gtk.FileDialog] instead
   */
  override bool setCurrentFolder(File file)
  {
    bool _retval;
    GError *_err;
    _retval = gtk_file_chooser_set_current_folder(cast(GtkFileChooser*)cPtr, file ? cast(GFile*)(cast(ObjectG)file).cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Sets the current name in the file selector, as if entered
   * by the user.
   * Note that the name passed in here is a UTF-8 string rather
   * than a filename. This function is meant for such uses as a
   * suggested name in a “Save As...” dialog.  You can pass
   * “Untitled.doc” or a similarly suitable suggestion for the name.
   * If you want to preselect a particular existing file, you should
   * use [Gtk.FileChooser.setFile] instead.
   * Please see the documentation for those functions for an example
   * of using [Gtk.FileChooser.setCurrentName] as well.
   * Params:
   *   name = the filename to use, as a UTF-8 string

   * Deprecated: Use [Gtk.FileDialog] instead
   */
  override void setCurrentName(string name)
  {
    const(char)* _name = name.toCString(false);
    gtk_file_chooser_set_current_name(cast(GtkFileChooser*)cPtr, _name);
  }

  /**
   * Sets file as the current filename for the file chooser.
   * This includes changing to the file’s parent folder and actually selecting
   * the file in list. If the chooser is in %GTK_FILE_CHOOSER_ACTION_SAVE mode,
   * the file’s base name will also appear in the dialog’s file name entry.
   * If the file name isn’t in the current folder of chooser, then the current
   * folder of chooser will be changed to the folder containing file.
   * Note that the file must exist, or nothing will be done except
   * for the directory change.
   * If you are implementing a save dialog, you should use this function if
   * you already have a file name to which the user may save; for example,
   * when the user opens an existing file and then does “Save As…”. If you
   * don’t have a file name already — for example, if the user just created
   * a new file and is saving it for the first time, do not call this function.
   * Instead, use something similar to this:
   * ```c
   * static void
   * prepare_file_chooser $(LPAREN)GtkFileChooser *chooser,
   * GFile          *existing_file$(RPAREN)
   * {
   * gboolean document_is_new \= $(LPAREN)existing_file \=\= NULL$(RPAREN);
   * if $(LPAREN)document_is_new$(RPAREN)
   * {
   * GFile *default_file_for_saving \= g_file_new_for_path $(LPAREN)"./out.txt"$(RPAREN);
   * // the user just created a new document
   * gtk_file_chooser_set_current_folder $(LPAREN)chooser, default_file_for_saving, NULL$(RPAREN);
   * gtk_file_chooser_set_current_name $(LPAREN)chooser, "Untitled document"$(RPAREN);
   * g_object_unref $(LPAREN)default_file_for_saving$(RPAREN);
   * }
   * else
   * {
   * // the user edited an existing document
   * gtk_file_chooser_set_file $(LPAREN)chooser, existing_file, NULL$(RPAREN);
   * }
   * }
   * ```
   * Params:
   *   file = the `GFile` to set as current
   * Returns: Not useful

   * Deprecated: Use [Gtk.FileDialog] instead
   */
  override bool setFile(File file)
  {
    bool _retval;
    GError *_err;
    _retval = gtk_file_chooser_set_file(cast(GtkFileChooser*)cPtr, file ? cast(GFile*)(cast(ObjectG)file).cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Sets the current filter.
   * Only the files that pass the filter will be displayed.
   * If the user-selectable list of filters is non-empty, then
   * the filter should be one of the filters in that list.
   * Setting the current filter when the list of filters is
   * empty is useful if you want to restrict the displayed
   * set of files without letting the user change it.
   * Params:
   *   filter = a `GtkFileFilter`

   * Deprecated: Use [Gtk.FileDialog] instead
   */
  override void setFilter(FileFilter filter)
  {
    gtk_file_chooser_set_filter(cast(GtkFileChooser*)cPtr, filter ? cast(GtkFileFilter*)filter.cPtr(false) : null);
  }

  /**
   * Sets whether multiple files can be selected in the file chooser.
   * This is only relevant if the action is set to be
   * %GTK_FILE_CHOOSER_ACTION_OPEN or
   * %GTK_FILE_CHOOSER_ACTION_SELECT_FOLDER.
   * Params:
   *   selectMultiple = %TRUE if multiple files can be selected.

   * Deprecated: Use [Gtk.FileDialog] instead
   */
  override void setSelectMultiple(bool selectMultiple)
  {
    gtk_file_chooser_set_select_multiple(cast(GtkFileChooser*)cPtr, selectMultiple);
  }
}
