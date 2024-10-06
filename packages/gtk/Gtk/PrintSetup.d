module Gtk.PrintSetup;

import GLib.Boxed;
import GObject.ObjectG;
import Gid.gid;
import Gtk.PageSetup;
import Gtk.PrintSettings;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * A `GtkPrintSetup` is an auxiliary object for printing that allows decoupling
 * the setup from the printing.
 * A print setup is obtained by calling [Gtk.PrintDialog.setup],
 * and can later be passed to print functions such as [Gtk.PrintDialog.print].
 * Print setups can be reused for multiple print calls.
 * Applications may wish to store the page_setup and print_settings from the print setup
 * and copy them to the PrintDialog if they want to keep using them.
 */
class PrintSetup : Boxed
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
    return gtk_print_setup_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Returns the page setup of setup.
   * It may be different from the `GtkPrintDialog`'s page setup
   * if the user changed it during the setup process.
   * Returns: the page setup, or `NULL`
   */
  PageSetup getPageSetup()
  {
    GtkPageSetup* _cretval;
    _cretval = gtk_print_setup_get_page_setup(cast(GtkPrintSetup*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!PageSetup(cast(GtkPageSetup*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns the print settings of setup.
   * They may be different from the `GtkPrintDialog`'s settings
   * if the user changed them during the setup process.
   * Returns: the print settings, or `NULL`
   */
  PrintSettings getPrintSettings()
  {
    GtkPrintSettings* _cretval;
    _cretval = gtk_print_setup_get_print_settings(cast(GtkPrintSetup*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!PrintSettings(cast(GtkPrintSettings*)_cretval, false) : null;
    return _retval;
  }
}
