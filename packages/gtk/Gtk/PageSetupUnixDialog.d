module Gtk.PageSetupUnixDialog;

import GObject.ObjectG;
import Gid.gid;
import Gtk.Accessible;
import Gtk.AccessibleT;
import Gtk.Buildable;
import Gtk.BuildableT;
import Gtk.ConstraintTarget;
import Gtk.ConstraintTargetT;
import Gtk.Dialog;
import Gtk.Native;
import Gtk.NativeT;
import Gtk.PageSetup;
import Gtk.PrintSettings;
import Gtk.Root;
import Gtk.RootT;
import Gtk.ShortcutManager;
import Gtk.ShortcutManagerT;
import Gtk.Types;
import Gtk.Window;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkPageSetupUnixDialog` implements a page setup dialog for platforms
 * which don’t provide a native page setup dialog, like Unix.
 * ![An example GtkPageSetupUnixDialog](pagesetupdialog.png)
 * It can be used very much like any other GTK dialog, at the
 * cost of the portability offered by the high-level printing
 * API in [Gtk.PrintOperation].
 * ## CSS nodes
 * `GtkPageSetupUnixDialog` has a single CSS node with the name `window` and
 * style class `.pagesetup`.
 */
class PageSetupUnixDialog : Dialog
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
    return gtk_page_setup_unix_dialog_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new page setup dialog.
   * Params:
   *   title = the title of the dialog
   *   parent = transient parent of the dialog
   * Returns: the new `GtkPageSetupUnixDialog`
   */
  this(string title, Window parent)
  {
    GtkWidget* _cretval;
    const(char)* _title = title.toCString(false);
    _cretval = gtk_page_setup_unix_dialog_new(_title, parent ? cast(GtkWindow*)parent.cPtr(false) : null);
    this(_cretval, false);
  }

  /**
   * Gets the currently selected page setup from the dialog.
   * Returns: the current page setup
   */
  PageSetup getPageSetup()
  {
    GtkPageSetup* _cretval;
    _cretval = gtk_page_setup_unix_dialog_get_page_setup(cast(GtkPageSetupUnixDialog*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!PageSetup(cast(GtkPageSetup*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the current print settings from the dialog.
   * Returns: the current print settings
   */
  PrintSettings getPrintSettings()
  {
    GtkPrintSettings* _cretval;
    _cretval = gtk_page_setup_unix_dialog_get_print_settings(cast(GtkPageSetupUnixDialog*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!PrintSettings(cast(GtkPrintSettings*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Sets the `GtkPageSetup` from which the page setup
   * dialog takes its values.
   * Params:
   *   pageSetup = a `GtkPageSetup`
   */
  void setPageSetup(PageSetup pageSetup)
  {
    gtk_page_setup_unix_dialog_set_page_setup(cast(GtkPageSetupUnixDialog*)cPtr, pageSetup ? cast(GtkPageSetup*)pageSetup.cPtr(false) : null);
  }

  /**
   * Sets the `GtkPrintSettings` from which the page setup dialog
   * takes its values.
   * Params:
   *   printSettings = a `GtkPrintSettings`
   */
  void setPrintSettings(PrintSettings printSettings)
  {
    gtk_page_setup_unix_dialog_set_print_settings(cast(GtkPageSetupUnixDialog*)cPtr, printSettings ? cast(GtkPrintSettings*)printSettings.cPtr(false) : null);
  }
}
