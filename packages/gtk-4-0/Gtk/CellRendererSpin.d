module Gtk.CellRendererSpin;

import Gid.gid;
import Gtk.CellRendererText;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * Renders a spin button in a cell
 * `GtkCellRendererSpin` renders text in a cell like `GtkCellRendererText` from
 * which it is derived. But while `GtkCellRendererText` offers a simple entry to
 * edit the text, `GtkCellRendererSpin` offers a `GtkSpinButton` widget. Of course,
 * that means that the text has to be parseable as a floating point number.
 * The range of the spinbutton is taken from the adjustment property of the
 * cell renderer, which can be set explicitly or mapped to a column in the
 * tree model, like all properties of cell renders. `GtkCellRendererSpin`
 * also has properties for the `GtkCellRendererSpin:climb-rate` and the number
 * of `GtkCellRendererSpin:digits` to display. Other `GtkSpinButton` properties
 * can be set in a handler for the `GtkCellRenderer::editing-started` signal.

 * Deprecated: List views use widgets to display their contents.
 *   You should use [Gtk.SpinButton] instead
 */
class CellRendererSpin : CellRendererText
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return gtk_cell_renderer_spin_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new `GtkCellRendererSpin`.
   * Returns: a new `GtkCellRendererSpin`
   */
  this()
  {
    GtkCellRenderer* _cretval;
    _cretval = gtk_cell_renderer_spin_new();
    this(_cretval, false);
  }
}
