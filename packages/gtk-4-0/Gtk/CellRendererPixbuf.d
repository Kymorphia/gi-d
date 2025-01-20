module Gtk.CellRendererPixbuf;

import Gid.gid;
import Gtk.CellRenderer;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * Renders a pixbuf in a cell
 * A `GtkCellRendererPixbuf` can be used to render an image in a cell. It allows
 * to render either a given `GdkPixbuf` $(LPAREN)set via the
 * `GtkCellRendererPixbuf:pixbuf` property$(RPAREN) or a named icon $(LPAREN)set via the
 * `GtkCellRendererPixbuf:icon-name` property$(RPAREN).
 * To support the tree view, `GtkCellRendererPixbuf` also supports rendering two
 * alternative pixbufs, when the `GtkCellRenderer:is-expander` property is %TRUE.
 * If the `GtkCellRenderer:is-expanded property` is %TRUE and the
 * `GtkCellRendererPixbuf:pixbuf-expander-open` property is set to a pixbuf, it
 * renders that pixbuf, if the `GtkCellRenderer:is-expanded` property is %FALSE
 * and the `GtkCellRendererPixbuf:pixbuf-expander-closed` property is set to a
 * pixbuf, it renders that one.

 * Deprecated: List views use widgets to display their contents. You
 *   should use [Gtk.Image] for icons, and [Gtk.Picture] for images
 */
class CellRendererPixbuf : CellRenderer
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return gtk_cell_renderer_pixbuf_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new `GtkCellRendererPixbuf`. Adjust rendering
   * parameters using object properties. Object properties can be set
   * globally $(LPAREN)with [GObject.ObjectG.set]$(RPAREN). Also, with `GtkTreeViewColumn`, you
   * can bind a property to a value in a `GtkTreeModel`. For example, you
   * can bind the “pixbuf” property on the cell renderer to a pixbuf value
   * in the model, thus rendering a different image in each row of the
   * `GtkTreeView`.
   * Returns: the new cell renderer
   */
  this()
  {
    GtkCellRenderer* _cretval;
    _cretval = gtk_cell_renderer_pixbuf_new();
    this(_cretval, false);
  }
}
