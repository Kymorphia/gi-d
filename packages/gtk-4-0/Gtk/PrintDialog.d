module Gtk.PrintDialog;

import GLib.ErrorG;
import GObject.ObjectG;
import Gid.gid;
import Gio.AsyncResult;
import Gio.AsyncResultT;
import Gio.Cancellable;
import Gio.File;
import Gio.FileT;
import Gio.OutputStream;
import Gio.Types;
import Gtk.PageSetup;
import Gtk.PrintSettings;
import Gtk.PrintSetup;
import Gtk.Types;
import Gtk.Window;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * A `GtkPrintDialog` object collects the arguments that
 * are needed to present a print dialog to the user, such
 * as a title for the dialog and whether it should be modal.
 * The dialog is shown with the [Gtk.PrintDialog.setup] function.
 * The actual printing can be done with [Gtk.PrintDialog.print] or
 * [Gtk.PrintDialog.printFile]. These APIs follows the GIO async pattern,
 * and the results can be obtained by calling the corresponding finish methods.
 */
class PrintDialog : ObjectG
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return gtk_print_dialog_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new `GtkPrintDialog` object.
   * Returns: the new `GtkPrintDialog`
   */
  this()
  {
    GtkPrintDialog* _cretval;
    _cretval = gtk_print_dialog_new();
    this(_cretval, true);
  }

  /**
   * Returns the label that will be shown on the
   * accept button of the print dialog.
   * Returns: the accept label
   */
  string getAcceptLabel()
  {
    const(char)* _cretval;
    _cretval = gtk_print_dialog_get_accept_label(cast(GtkPrintDialog*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Returns whether the print dialog blocks
   * interaction with the parent window while
   * it is presented.
   * Returns: whether the print dialog is modal
   */
  bool getModal()
  {
    bool _retval;
    _retval = gtk_print_dialog_get_modal(cast(GtkPrintDialog*)cPtr);
    return _retval;
  }

  /**
   * Returns the page setup.
   * Returns: the page setup
   */
  PageSetup getPageSetup()
  {
    GtkPageSetup* _cretval;
    _cretval = gtk_print_dialog_get_page_setup(cast(GtkPrintDialog*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!PageSetup(cast(GtkPageSetup*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns the print settings for the print dialog.
   * Returns: the settings
   */
  PrintSettings getPrintSettings()
  {
    GtkPrintSettings* _cretval;
    _cretval = gtk_print_dialog_get_print_settings(cast(GtkPrintDialog*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!PrintSettings(cast(GtkPrintSettings*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns the title that will be shown on the
   * print dialog.
   * Returns: the title
   */
  string getTitle()
  {
    const(char)* _cretval;
    _cretval = gtk_print_dialog_get_title(cast(GtkPrintDialog*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * This function prints content from a stream.
   * If you pass `NULL` as setup, then this method will present a print dialog.
   * Otherwise, it will attempt to print directly, without user interaction.
   * The callback will be called when the printing is done. It should call
   * [Gtk.PrintDialog.printFinish] to obtain the results.
   * Params:
   *   parent = the parent `GtkWindow`
   *   setup = the `GtkPrintSetup` to use
   *   cancellable = a `GCancellable` to cancel the operation
   *   callback = a callback to call when the operation is complete
   */
  void print(Window parent, PrintSetup setup, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(AsyncReadyCallback*)data;

      (*_dlg)(sourceObject ? ObjectG.getDObject!ObjectG(cast(void*)sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(cast(void*)res, false) : null);
    }

    auto _callback = freezeDelegate(cast(void*)&callback);
    gtk_print_dialog_print(cast(GtkPrintDialog*)cPtr, parent ? cast(GtkWindow*)parent.cPtr(false) : null, setup ? cast(GtkPrintSetup*)setup.cPtr(false) : null, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_callbackCallback, _callback);
  }

  /**
   * This function prints a file.
   * If you pass `NULL` as setup, then this method will present a print dialog.
   * Otherwise, it will attempt to print directly, without user interaction.
   * The callback will be called when the printing is done. It should call
   * [Gtk.PrintDialog.printFileFinish] to obtain the results.
   * Params:
   *   parent = the parent `GtkWindow`
   *   setup = the `GtkPrintSetup` to use
   *   file = the `GFile` to print
   *   cancellable = a `GCancellable` to cancel the operation
   *   callback = a callback to call when the operation is complete
   */
  void printFile(Window parent, PrintSetup setup, File file, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(AsyncReadyCallback*)data;

      (*_dlg)(sourceObject ? ObjectG.getDObject!ObjectG(cast(void*)sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(cast(void*)res, false) : null);
    }

    auto _callback = freezeDelegate(cast(void*)&callback);
    gtk_print_dialog_print_file(cast(GtkPrintDialog*)cPtr, parent ? cast(GtkWindow*)parent.cPtr(false) : null, setup ? cast(GtkPrintSetup*)setup.cPtr(false) : null, file ? cast(GFile*)(cast(ObjectG)file).cPtr(false) : null, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_callbackCallback, _callback);
  }

  /**
   * Finishes the [Gtk.PrintDialog.printFile] call and
   * returns the results.
   * Params:
   *   result = a `GAsyncResult`
   * Returns: Whether the call was successful
   */
  bool printFileFinish(AsyncResult result)
  {
    bool _retval;
    GError *_err;
    _retval = gtk_print_dialog_print_file_finish(cast(GtkPrintDialog*)cPtr, result ? cast(GAsyncResult*)(cast(ObjectG)result).cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Finishes the [Gtk.PrintDialog.print] call and
   * returns the results.
   * If the call was successful, the content to be printed should be
   * written to the returned output stream. Otherwise, `NULL` is returned.
   * The overall results of the print operation will be returned in the
   * [Gio.OutputStream.close] call, so if you are interested in the
   * results, you need to explicitly close the output stream $(LPAREN)it will be
   * closed automatically if you just unref it$(RPAREN). Be aware that the close
   * call may not be instant as it operation will for the printer to finish
   * printing.
   * Params:
   *   result = a `GAsyncResult`
   * Returns: a [Gio.OutputStream]
   */
  OutputStream printFinish(AsyncResult result)
  {
    GOutputStream* _cretval;
    GError *_err;
    _cretval = gtk_print_dialog_print_finish(cast(GtkPrintDialog*)cPtr, result ? cast(GAsyncResult*)(cast(ObjectG)result).cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = _cretval ? ObjectG.getDObject!OutputStream(cast(GOutputStream*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Sets the label that will be shown on the
   * accept button of the print dialog shown for
   * [Gtk.PrintDialog.setup].
   * Params:
   *   acceptLabel = the new accept label
   */
  void setAcceptLabel(string acceptLabel)
  {
    const(char)* _acceptLabel = acceptLabel.toCString(false);
    gtk_print_dialog_set_accept_label(cast(GtkPrintDialog*)cPtr, _acceptLabel);
  }

  /**
   * Sets whether the print dialog blocks
   * interaction with the parent window while
   * it is presented.
   * Params:
   *   modal = the new value
   */
  void setModal(bool modal)
  {
    gtk_print_dialog_set_modal(cast(GtkPrintDialog*)cPtr, modal);
  }

  /**
   * Set the page setup for the print dialog.
   * Params:
   *   pageSetup = the new page setup
   */
  void setPageSetup(PageSetup pageSetup)
  {
    gtk_print_dialog_set_page_setup(cast(GtkPrintDialog*)cPtr, pageSetup ? cast(GtkPageSetup*)pageSetup.cPtr(false) : null);
  }

  /**
   * Sets the print settings for the print dialog.
   * Params:
   *   printSettings = the new print settings
   */
  void setPrintSettings(PrintSettings printSettings)
  {
    gtk_print_dialog_set_print_settings(cast(GtkPrintDialog*)cPtr, printSettings ? cast(GtkPrintSettings*)printSettings.cPtr(false) : null);
  }

  /**
   * Sets the title that will be shown on the print dialog.
   * Params:
   *   title = the new title
   */
  void setTitle(string title)
  {
    const(char)* _title = title.toCString(false);
    gtk_print_dialog_set_title(cast(GtkPrintDialog*)cPtr, _title);
  }

  /**
   * This function presents a print dialog to let the user select a printer,
   * and set up print settings and page setup.
   * The callback will be called when the dialog is dismissed.
   * It should call [Gtk.PrintDialog.setupFinish]
   * to obtain the results in the form of a [Gtk.PrintSetup],
   * that can then be passed to [Gtk.PrintDialog.print]
   * or [Gtk.PrintDialog.printFile].
   * One possible use for this method is to have the user select a printer,
   * then show a page setup UI in the application $(LPAREN)e.g. to arrange images
   * on a page$(RPAREN), then call [Gtk.PrintDialog.print] on self
   * to do the printing without further user interaction.
   * Params:
   *   parent = the parent `GtkWindow`
   *   cancellable = a `GCancellable` to cancel the operation
   *   callback = a callback to call when the operation is complete
   */
  void setup(Window parent, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(AsyncReadyCallback*)data;

      (*_dlg)(sourceObject ? ObjectG.getDObject!ObjectG(cast(void*)sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(cast(void*)res, false) : null);
    }

    auto _callback = freezeDelegate(cast(void*)&callback);
    gtk_print_dialog_setup(cast(GtkPrintDialog*)cPtr, parent ? cast(GtkWindow*)parent.cPtr(false) : null, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_callbackCallback, _callback);
  }

  /**
   * Finishes the [Gtk.PrintDialog.setup] call.
   * If the call was successful, it returns a [Gtk.PrintSetup]
   * which contains the print settings and page setup information that
   * will be used to print.
   * Params:
   *   result = a `GAsyncResult`
   * Returns: The `GtkPrintSetup` object that resulted from the call,
   *   or `NULL` if the call was not successful
   */
  PrintSetup setupFinish(AsyncResult result)
  {
    GtkPrintSetup* _cretval;
    GError *_err;
    _cretval = gtk_print_dialog_setup_finish(cast(GtkPrintDialog*)cPtr, result ? cast(GAsyncResult*)(cast(ObjectG)result).cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = _cretval ? new PrintSetup(cast(void*)_cretval, true) : null;
    return _retval;
  }
}
