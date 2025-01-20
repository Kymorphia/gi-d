module Gtk.CellRendererSpinner;

import Gid.gid;
import Gtk.CellRenderer;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * Renders a spinning animation in a cell
 * `GtkCellRendererSpinner` renders a spinning animation in a cell, very
 * similar to `GtkSpinner`. It can often be used as an alternative
 * to a `GtkCellRendererProgress` for displaying indefinite activity,
 * instead of actual progress.
 * To start the animation in a cell, set the `GtkCellRendererSpinner:active`
 * property to %TRUE and increment the `GtkCellRendererSpinner:pulse` property
 * at regular intervals. The usual way to set the cell renderer properties
 * for each cell is to bind them to columns in your tree model using e.g.
 * [Gtk.TreeViewColumn.addAttribute].

 * Deprecated: List views use widgets to display their contents.
 *   You should use [Gtk.Spinner] instead
 */
class CellRendererSpinner : CellRenderer
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return gtk_cell_renderer_spinner_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Returns a new cell renderer which will show a spinner to indicate
   * activity.
   * Returns: a new `GtkCellRenderer`
   */
  this()
  {
    GtkCellRenderer* _cretval;
    _cretval = gtk_cell_renderer_spinner_new();
    this(_cretval, false);
  }
}
