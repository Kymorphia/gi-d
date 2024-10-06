module Gtk.FontChooserDialog;

import Gid.gid;
import Gtk.Accessible;
import Gtk.AccessibleT;
import Gtk.Buildable;
import Gtk.BuildableT;
import Gtk.ConstraintTarget;
import Gtk.ConstraintTargetT;
import Gtk.Dialog;
import Gtk.FontChooser;
import Gtk.FontChooserT;
import Gtk.Native;
import Gtk.NativeT;
import Gtk.Root;
import Gtk.RootT;
import Gtk.ShortcutManager;
import Gtk.ShortcutManagerT;
import Gtk.Types;
import Gtk.Window;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * The `GtkFontChooserDialog` widget is a dialog for selecting a font.
 * ![An example GtkFontChooserDialog](fontchooser.png)
 * `GtkFontChooserDialog` implements the [Gtk.FontChooser] interface
 * and does not provide much API of its own.
 * To create a `GtkFontChooserDialog`, use [Gtk.FontChooserDialog.new_].
 * # GtkFontChooserDialog as GtkBuildable
 * The `GtkFontChooserDialog` implementation of the `GtkBuildable`
 * interface exposes the buttons with the names “select_button”
 * and “cancel_button”.
 * ## CSS nodes
 * `GtkFontChooserDialog` has a single CSS node with the name `window` and style
 * class `.fontchooser`.

 * Deprecated: Use [Gtk.FontDialog] instead
 */
class FontChooserDialog : Dialog, FontChooser
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
    return gtk_font_chooser_dialog_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin FontChooserT!GtkFontChooserDialog;

  /**
   * Creates a new `GtkFontChooserDialog`.
   * Params:
   *   title = Title of the dialog
   *   parent = Transient parent of the dialog
   * Returns: a new `GtkFontChooserDialog`

   * Deprecated: Use [Gtk.FontDialog] instead
   */
  this(string title, Window parent)
  {
    GtkWidget* _cretval;
    const(char)* _title = title.toCString(false);
    _cretval = gtk_font_chooser_dialog_new(_title, parent ? cast(GtkWindow*)parent.cPtr(false) : null);
    this(_cretval, false);
  }
}
