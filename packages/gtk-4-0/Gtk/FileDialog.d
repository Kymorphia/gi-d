module Gtk.FileDialog;

import GLib.ErrorG;
import GObject.ObjectG;
import Gid.gid;
import Gio.AsyncResult;
import Gio.AsyncResultT;
import Gio.Cancellable;
import Gio.File;
import Gio.FileT;
import Gio.ListModel;
import Gio.ListModelT;
import Gio.Types;
import Gtk.FileFilter;
import Gtk.Types;
import Gtk.Window;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * A `GtkFileDialog` object collects the arguments that
 * are needed to present a file chooser dialog to the
 * user, such as a title for the dialog and whether it
 * should be modal.
 * The dialog is shown with [Gtk.FileDialog.open],
 * [Gtk.FileDialog.save], etc. These APIs follow the
 * GIO async pattern, and the result can be obtained by calling
 * the corresponding finish function, for example
 * [Gtk.FileDialog.openFinish].
 */
class FileDialog : ObjectG
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return gtk_file_dialog_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new `GtkFileDialog` object.
   * Returns: the new `GtkFileDialog`
   */
  this()
  {
    GtkFileDialog* _cretval;
    _cretval = gtk_file_dialog_new();
    this(_cretval, true);
  }

  string getAcceptLabel()
  {
    const(char)* _cretval;
    _cretval = gtk_file_dialog_get_accept_label(cast(GtkFileDialog*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Gets the filter that will be selected by default
   * in the file chooser dialog.
   * Returns: the current filter
   */
  FileFilter getDefaultFilter()
  {
    GtkFileFilter* _cretval;
    _cretval = gtk_file_dialog_get_default_filter(cast(GtkFileDialog*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!FileFilter(cast(GtkFileFilter*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the filters that will be offered to the user
   * in the file chooser dialog.
   * Returns: the filters, as
   *   a `GListModel` of `GtkFileFilters`
   */
  ListModel getFilters()
  {
    GListModel* _cretval;
    _cretval = gtk_file_dialog_get_filters(cast(GtkFileDialog*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!ListModel(cast(GListModel*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the file that will be initially selected in
   * the file chooser dialog.
   * Returns: the file
   */
  File getInitialFile()
  {
    GFile* _cretval;
    _cretval = gtk_file_dialog_get_initial_file(cast(GtkFileDialog*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!File(cast(GFile*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the folder that will be set as the
   * initial folder in the file chooser dialog.
   * Returns: the folder
   */
  File getInitialFolder()
  {
    GFile* _cretval;
    _cretval = gtk_file_dialog_get_initial_folder(cast(GtkFileDialog*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!File(cast(GFile*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the name for the file that should be initially set.
   * Returns: the name
   */
  string getInitialName()
  {
    const(char)* _cretval;
    _cretval = gtk_file_dialog_get_initial_name(cast(GtkFileDialog*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Returns whether the file chooser dialog
   * blocks interaction with the parent window
   * while it is presented.
   * Returns: `TRUE` if the file chooser dialog is modal
   */
  bool getModal()
  {
    bool _retval;
    _retval = gtk_file_dialog_get_modal(cast(GtkFileDialog*)cPtr);
    return _retval;
  }

  /**
   * Returns the title that will be shown on the
   * file chooser dialog.
   * Returns: the title
   */
  string getTitle()
  {
    const(char)* _cretval;
    _cretval = gtk_file_dialog_get_title(cast(GtkFileDialog*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * This function initiates a file selection operation by
   * presenting a file chooser dialog to the user.
   * The callback will be called when the dialog is dismissed.
   * It should call [Gtk.FileDialog.openFinish]
   * to obtain the result.
   * Params:
   *   parent = the parent `GtkWindow`
   *   cancellable = a `GCancellable` to cancel the operation
   *   callback = a callback to call when the operation is complete
   */
  void open(Window parent, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(AsyncReadyCallback*)data;

      (*_dlg)(sourceObject ? ObjectG.getDObject!ObjectG(cast(void*)sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(cast(void*)res, false) : null);
    }

    auto _callback = freezeDelegate(cast(void*)&callback);
    gtk_file_dialog_open(cast(GtkFileDialog*)cPtr, parent ? cast(GtkWindow*)parent.cPtr(false) : null, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_callbackCallback, _callback);
  }

  /**
   * Finishes the [Gtk.FileDialog.open] call and
   * returns the resulting file.
   * Params:
   *   result = a `GAsyncResult`
   * Returns: the file that was selected.
   *   Otherwise, `NULL` is returned and error is set
   */
  File openFinish(AsyncResult result)
  {
    GFile* _cretval;
    GError *_err;
    _cretval = gtk_file_dialog_open_finish(cast(GtkFileDialog*)cPtr, result ? cast(GAsyncResult*)(cast(ObjectG)result).cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = _cretval ? ObjectG.getDObject!File(cast(GFile*)_cretval, true) : null;
    return _retval;
  }

  /**
   * This function initiates a multi-file selection operation by
   * presenting a file chooser dialog to the user.
   * The file chooser will initially be opened in the directory
   * propertyGtk.FileDialog:initial-folder.
   * The callback will be called when the dialog is dismissed.
   * It should call [Gtk.FileDialog.openMultipleFinish]
   * to obtain the result.
   * Params:
   *   parent = the parent `GtkWindow`
   *   cancellable = a `GCancellable` to cancel the operation
   *   callback = a callback to call when the operation is complete
   */
  void openMultiple(Window parent, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(AsyncReadyCallback*)data;

      (*_dlg)(sourceObject ? ObjectG.getDObject!ObjectG(cast(void*)sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(cast(void*)res, false) : null);
    }

    auto _callback = freezeDelegate(cast(void*)&callback);
    gtk_file_dialog_open_multiple(cast(GtkFileDialog*)cPtr, parent ? cast(GtkWindow*)parent.cPtr(false) : null, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_callbackCallback, _callback);
  }

  /**
   * Finishes the [Gtk.FileDialog.open] call and
   * returns the resulting files in a `GListModel`.
   * Params:
   *   result = a `GAsyncResult`
   * Returns: the file that was selected,
   *   as a `GListModel` of `GFiles`. Otherwise, `NULL` is returned
   *   and error is set
   */
  ListModel openMultipleFinish(AsyncResult result)
  {
    GListModel* _cretval;
    GError *_err;
    _cretval = gtk_file_dialog_open_multiple_finish(cast(GtkFileDialog*)cPtr, result ? cast(GAsyncResult*)(cast(ObjectG)result).cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = _cretval ? ObjectG.getDObject!ListModel(cast(GListModel*)_cretval, true) : null;
    return _retval;
  }

  /**
   * This function initiates a file save operation by
   * presenting a file chooser dialog to the user.
   * The callback will be called when the dialog is dismissed.
   * It should call [Gtk.FileDialog.saveFinish]
   * to obtain the result.
   * Params:
   *   parent = the parent `GtkWindow`
   *   cancellable = a `GCancellable` to cancel the operation
   *   callback = a callback to call when the operation is complete
   */
  void save(Window parent, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(AsyncReadyCallback*)data;

      (*_dlg)(sourceObject ? ObjectG.getDObject!ObjectG(cast(void*)sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(cast(void*)res, false) : null);
    }

    auto _callback = freezeDelegate(cast(void*)&callback);
    gtk_file_dialog_save(cast(GtkFileDialog*)cPtr, parent ? cast(GtkWindow*)parent.cPtr(false) : null, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_callbackCallback, _callback);
  }

  /**
   * Finishes the [Gtk.FileDialog.save] call and
   * returns the resulting file.
   * Params:
   *   result = a `GAsyncResult`
   * Returns: the file that was selected.
   *   Otherwise, `NULL` is returned and error is set
   */
  File saveFinish(AsyncResult result)
  {
    GFile* _cretval;
    GError *_err;
    _cretval = gtk_file_dialog_save_finish(cast(GtkFileDialog*)cPtr, result ? cast(GAsyncResult*)(cast(ObjectG)result).cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = _cretval ? ObjectG.getDObject!File(cast(GFile*)_cretval, true) : null;
    return _retval;
  }

  /**
   * This function initiates a directory selection operation by
   * presenting a file chooser dialog to the user.
   * If you pass initial_folder, the file chooser will initially be
   * opened in the parent directory of that folder, otherwise, it
   * will be in the directory propertyGtk.FileDialog:initial-folder.
   * The callback will be called when the dialog is dismissed.
   * It should call [Gtk.FileDialog.selectFolderFinish]
   * to obtain the result.
   * Params:
   *   parent = the parent `GtkWindow`
   *   cancellable = a `GCancellable` to cancel the operation
   *   callback = a callback to call when the operation is complete
   */
  void selectFolder(Window parent, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(AsyncReadyCallback*)data;

      (*_dlg)(sourceObject ? ObjectG.getDObject!ObjectG(cast(void*)sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(cast(void*)res, false) : null);
    }

    auto _callback = freezeDelegate(cast(void*)&callback);
    gtk_file_dialog_select_folder(cast(GtkFileDialog*)cPtr, parent ? cast(GtkWindow*)parent.cPtr(false) : null, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_callbackCallback, _callback);
  }

  /**
   * Finishes the [Gtk.FileDialog.selectFolder] call and
   * returns the resulting file.
   * Params:
   *   result = a `GAsyncResult`
   * Returns: the file that was selected.
   *   Otherwise, `NULL` is returned and error is set
   */
  File selectFolderFinish(AsyncResult result)
  {
    GFile* _cretval;
    GError *_err;
    _cretval = gtk_file_dialog_select_folder_finish(cast(GtkFileDialog*)cPtr, result ? cast(GAsyncResult*)(cast(ObjectG)result).cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = _cretval ? ObjectG.getDObject!File(cast(GFile*)_cretval, true) : null;
    return _retval;
  }

  /**
   * This function initiates a multi-directory selection operation by
   * presenting a file chooser dialog to the user.
   * The file chooser will initially be opened in the directory
   * propertyGtk.FileDialog:initial-folder.
   * The callback will be called when the dialog is dismissed.
   * It should call [Gtk.FileDialog.selectMultipleFoldersFinish]
   * to obtain the result.
   * Params:
   *   parent = the parent `GtkWindow`
   *   cancellable = a `GCancellable` to cancel the operation
   *   callback = a callback to call when the operation is complete
   */
  void selectMultipleFolders(Window parent, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(AsyncReadyCallback*)data;

      (*_dlg)(sourceObject ? ObjectG.getDObject!ObjectG(cast(void*)sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(cast(void*)res, false) : null);
    }

    auto _callback = freezeDelegate(cast(void*)&callback);
    gtk_file_dialog_select_multiple_folders(cast(GtkFileDialog*)cPtr, parent ? cast(GtkWindow*)parent.cPtr(false) : null, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_callbackCallback, _callback);
  }

  /**
   * Finishes the [Gtk.FileDialog.selectMultipleFolders]
   * call and returns the resulting files in a `GListModel`.
   * Params:
   *   result = a `GAsyncResult`
   * Returns: the file that was selected,
   *   as a `GListModel` of `GFiles`. Otherwise, `NULL` is returned
   *   and error is set
   */
  ListModel selectMultipleFoldersFinish(AsyncResult result)
  {
    GListModel* _cretval;
    GError *_err;
    _cretval = gtk_file_dialog_select_multiple_folders_finish(cast(GtkFileDialog*)cPtr, result ? cast(GAsyncResult*)(cast(ObjectG)result).cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = _cretval ? ObjectG.getDObject!ListModel(cast(GListModel*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Sets the label shown on the file chooser's accept button.
   * Leaving the accept label unset or setting it as `NULL` will fall back to
   * a default label, depending on what API is used to launch the file dialog.
   * Params:
   *   acceptLabel = the new accept label
   */
  void setAcceptLabel(string acceptLabel)
  {
    const(char)* _acceptLabel = acceptLabel.toCString(false);
    gtk_file_dialog_set_accept_label(cast(GtkFileDialog*)cPtr, _acceptLabel);
  }

  /**
   * Sets the filter that will be selected by default
   * in the file chooser dialog.
   * If set to %NULL, the first item in [Gtk.FileDialog.filters]
   * will be used as the default filter. If that list is empty, the dialog
   * will be unfiltered.
   * Params:
   *   filter = a `GtkFileFilter`
   */
  void setDefaultFilter(FileFilter filter)
  {
    gtk_file_dialog_set_default_filter(cast(GtkFileDialog*)cPtr, filter ? cast(GtkFileFilter*)filter.cPtr(false) : null);
  }

  /**
   * Sets the filters that will be offered to the user
   * in the file chooser dialog.
   * Params:
   *   filters = a `GListModel` of `GtkFileFilters`
   */
  void setFilters(ListModel filters)
  {
    gtk_file_dialog_set_filters(cast(GtkFileDialog*)cPtr, filters ? cast(GListModel*)(cast(ObjectG)filters).cPtr(false) : null);
  }

  /**
   * Sets the file that will be initially selected in
   * the file chooser dialog.
   * This function is a shortcut for calling both
   * [Gtk.FileDialog.setInitialFolder] and
   * [Gtk.FileDialog.setInitialName] with the directory and
   * name of file respectively.
   * Params:
   *   file = a `GFile`
   */
  void setInitialFile(File file)
  {
    gtk_file_dialog_set_initial_file(cast(GtkFileDialog*)cPtr, file ? cast(GFile*)(cast(ObjectG)file).cPtr(false) : null);
  }

  /**
   * Sets the folder that will be set as the
   * initial folder in the file chooser dialog.
   * Params:
   *   folder = a `GFile`
   */
  void setInitialFolder(File folder)
  {
    gtk_file_dialog_set_initial_folder(cast(GtkFileDialog*)cPtr, folder ? cast(GFile*)(cast(ObjectG)folder).cPtr(false) : null);
  }

  /**
   * Sets the name for the file that should be initially set.
   * For saving dialogs, this will usually be pre-entered into the name field.
   * If a file with this name already exists in the directory set via
   * propertyGtk.FileDialog:initial-folder, the dialog should preselect it.
   * Params:
   *   name = a UTF8 string
   */
  void setInitialName(string name)
  {
    const(char)* _name = name.toCString(false);
    gtk_file_dialog_set_initial_name(cast(GtkFileDialog*)cPtr, _name);
  }

  /**
   * Sets whether the file chooser dialog
   * blocks interaction with the parent window
   * while it is presented.
   * Params:
   *   modal = the new value
   */
  void setModal(bool modal)
  {
    gtk_file_dialog_set_modal(cast(GtkFileDialog*)cPtr, modal);
  }

  /**
   * Sets the title that will be shown on the
   * file chooser dialog.
   * Params:
   *   title = the new title
   */
  void setTitle(string title)
  {
    const(char)* _title = title.toCString(false);
    gtk_file_dialog_set_title(cast(GtkFileDialog*)cPtr, _title);
  }
}
