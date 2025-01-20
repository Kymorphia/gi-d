module Gtk.CellRendererProgress;

import Gid.gid;
import Gtk.CellRenderer;
import Gtk.Orientable;
import Gtk.OrientableT;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * Renders numbers as progress bars
 * `GtkCellRendererProgress` renders a numeric value as a progress par in a cell.
 * Additionally, it can display a text on top of the progress bar.

 * Deprecated: List views use widgets to display their contents.
 *   You should use [Gtk.ProgressBar] instead
 */
class CellRendererProgress : CellRenderer, Orientable
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return gtk_cell_renderer_progress_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin OrientableT!();

  /**
   * Creates a new `GtkCellRendererProgress`.
   * Returns: the new cell renderer
   */
  this()
  {
    GtkCellRenderer* _cretval;
    _cretval = gtk_cell_renderer_progress_new();
    this(_cretval, false);
  }
}
