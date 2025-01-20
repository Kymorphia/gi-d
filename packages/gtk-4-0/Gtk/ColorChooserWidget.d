module Gtk.ColorChooserWidget;

import Gid.gid;
import Gtk.Accessible;
import Gtk.AccessibleT;
import Gtk.Buildable;
import Gtk.BuildableT;
import Gtk.ColorChooser;
import Gtk.ColorChooserT;
import Gtk.ConstraintTarget;
import Gtk.ConstraintTargetT;
import Gtk.Types;
import Gtk.Widget;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * The `GtkColorChooserWidget` widget lets the user select a color.
 * By default, the chooser presents a predefined palette of colors,
 * plus a small number of settable custom colors. It is also possible
 * to select a different color with the single-color editor.
 * To enter the single-color editing mode, use the context menu of any
 * color of the palette, or use the '+' button to add a new custom color.
 * The chooser automatically remembers the last selection, as well
 * as custom colors.
 * To create a `GtkColorChooserWidget`, use [Gtk.ColorChooserWidget.new_].
 * To change the initially selected color, use
 * [Gtk.ColorChooser.setRgba]. To get the selected color use
 * [Gtk.ColorChooser.getRgba].
 * The `GtkColorChooserWidget` is used in the [Gtk.ColorChooserDialog]
 * to provide a dialog for selecting colors.
 * # CSS names
 * `GtkColorChooserWidget` has a single CSS node with name colorchooser.

 * Deprecated: Direct use of `GtkColorChooserWidget` is deprecated.
 */
class ColorChooserWidget : Widget, ColorChooser
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return gtk_color_chooser_widget_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin ColorChooserT!();

  /**
   * Creates a new `GtkColorChooserWidget`.
   * Returns: a new `GtkColorChooserWidget`
   */
  this()
  {
    GtkWidget* _cretval;
    _cretval = gtk_color_chooser_widget_new();
    this(_cretval, false);
  }
}
