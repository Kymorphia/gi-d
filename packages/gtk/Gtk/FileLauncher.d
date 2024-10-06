module Gtk.FileLauncher;

import GLib.ErrorG;
import GObject.ObjectG;
import Gid.gid;
import Gio.AsyncResult;
import Gio.AsyncResultT;
import Gio.Cancellable;
import Gio.File;
import Gio.FileT;
import Gio.Types;
import Gtk.Types;
import Gtk.Window;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * A `GtkFileLauncher` object collects the arguments that are needed to open a
 * file with an application.
 * Depending on system configuration, user preferences and available APIs, this
 * may or may not show an app chooser dialog or launch the default application
 * right away.
 * The operation is started with the [Gtk.FileLauncher.launch] function.
 * This API follows the GIO async pattern, and the result can be obtained by
 * calling [Gtk.FileLauncher.launchFinish].
 * To launch uris that don't represent files, use [Gtk.UriLauncher].
 */
class FileLauncher : ObjectG
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
    return gtk_file_launcher_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new `GtkFileLauncher` object.
   * Params:
   *   file = the file to open
   * Returns: the new `GtkFileLauncher`
   */
  this(File file)
  {
    GtkFileLauncher* _cretval;
    _cretval = gtk_file_launcher_new(file ? cast(GFile*)(cast(ObjectG)file).cPtr(false) : null);
    this(_cretval, true);
  }

  /**
   * Returns whether to ask the user to choose an app for opening the file.
   * Returns: `TRUE` if always asking for app
   */
  bool getAlwaysAsk()
  {
    bool _retval;
    _retval = gtk_file_launcher_get_always_ask(cast(GtkFileLauncher*)cPtr);
    return _retval;
  }

  /**
   * Gets the file that will be opened.
   * Returns: the file
   */
  File getFile()
  {
    GFile* _cretval;
    _cretval = gtk_file_launcher_get_file(cast(GtkFileLauncher*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!File(cast(GFile*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns whether to make the file writable for the handler.
   * Returns: `TRUE` if the file will be made writable
   */
  bool getWritable()
  {
    bool _retval;
    _retval = gtk_file_launcher_get_writable(cast(GtkFileLauncher*)cPtr);
    return _retval;
  }

  /**
   * Launch an application to open the file.
   * This may present an app chooser dialog to the user.
   * The callback will be called when the operation is completed.
   * It should call [Gtk.FileLauncher.launchFinish] to obtain
   * the result.
   * Params:
   *   parent = the parent `GtkWindow`
   *   cancellable = a `GCancellable` to cancel the operation
   *   callback = a callback to call when the operation is complete
   */
  void launch(Window parent, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(AsyncReadyCallback*)data;

      (*_dlg)(sourceObject ? ObjectG.getDObject!ObjectG(cast(void*)sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(cast(void*)res, false) : null);
    }

    auto _callback = freezeDelegate(cast(void*)&callback);
    gtk_file_launcher_launch(cast(GtkFileLauncher*)cPtr, parent ? cast(GtkWindow*)parent.cPtr(false) : null, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_callbackCallback, _callback);
  }

  /**
   * Finishes the [Gtk.FileLauncher.launch] call and
   * returns the result.
   * Params:
   *   result = a `GAsyncResult`
   * Returns: `TRUE` if an application was launched,
   *   or `FALSE` and error is set
   */
  bool launchFinish(AsyncResult result)
  {
    bool _retval;
    GError *_err;
    _retval = gtk_file_launcher_launch_finish(cast(GtkFileLauncher*)cPtr, result ? cast(GAsyncResult*)(cast(ObjectG)result).cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Launch a file manager to show the file in its parent directory.
   * This is only supported native files. It will fail if file
   * is e.g. a http:// uri.
   * The callback will be called when the operation is completed.
   * It should call [Gtk.FileLauncher.openContainingFolderFinish]
   * to obtain the result.
   * Params:
   *   parent = the parent `GtkWindow`
   *   cancellable = a `GCancellable` to cancel the operation
   *   callback = a callback to call when the operation is complete
   */
  void openContainingFolder(Window parent, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(AsyncReadyCallback*)data;

      (*_dlg)(sourceObject ? ObjectG.getDObject!ObjectG(cast(void*)sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(cast(void*)res, false) : null);
    }

    auto _callback = freezeDelegate(cast(void*)&callback);
    gtk_file_launcher_open_containing_folder(cast(GtkFileLauncher*)cPtr, parent ? cast(GtkWindow*)parent.cPtr(false) : null, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_callbackCallback, _callback);
  }

  /**
   * Finishes the [Gtk.FileLauncher.openContainingFolder]
   * call and returns the result.
   * Params:
   *   result = a `GAsyncResult`
   * Returns: `TRUE` if an application was launched,
   *   or `FALSE` and error is set
   */
  bool openContainingFolderFinish(AsyncResult result)
  {
    bool _retval;
    GError *_err;
    _retval = gtk_file_launcher_open_containing_folder_finish(cast(GtkFileLauncher*)cPtr, result ? cast(GAsyncResult*)(cast(ObjectG)result).cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Sets whether to awlays ask the user to choose an app for opening the file.
   * If `FALSE`, the file might be opened with a default app or the previous choice.
   * Params:
   *   alwaysAsk = a `gboolean`
   */
  void setAlwaysAsk(bool alwaysAsk)
  {
    gtk_file_launcher_set_always_ask(cast(GtkFileLauncher*)cPtr, alwaysAsk);
  }

  /**
   * Sets the file that will be opened.
   * Params:
   *   file = a `GFile`
   */
  void setFile(File file)
  {
    gtk_file_launcher_set_file(cast(GtkFileLauncher*)cPtr, file ? cast(GFile*)(cast(ObjectG)file).cPtr(false) : null);
  }

  /**
   * Sets whether to make the file writable for the handler.
   * Params:
   *   writable = a `gboolean`
   */
  void setWritable(bool writable)
  {
    gtk_file_launcher_set_writable(cast(GtkFileLauncher*)cPtr, writable);
  }
}
