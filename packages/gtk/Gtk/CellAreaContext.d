module Gtk.CellAreaContext;

import GObject.ObjectG;
import Gid.gid;
import Gtk.CellArea;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * Stores geometrical information for a series of rows in a GtkCellArea
 * The `GtkCellAreaContext` object is created by a given `GtkCellArea`
 * implementation via its `GtkCellAreaClass.create_context$(LPAREN)$(RPAREN)` virtual
 * method and is used to store cell sizes and alignments for a series of
 * `GtkTreeModel` rows that are requested and rendered in the same context.
 * `GtkCellLayout` widgets can create any number of contexts in which to
 * request and render groups of data rows. However, it’s important that the
 * same context which was used to request sizes for a given `GtkTreeModel`
 * row also be used for the same row when calling other `GtkCellArea` APIs
 * such as gtk_cell_area_render$(LPAREN)$(RPAREN) and [Gtk.CellArea.event].

 * Deprecated: This object will be removed in GTK 5
 */
class CellAreaContext : ObjectG
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
    return gtk_cell_area_context_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Allocates a width and/or a height for all rows which are to be
   * rendered with context.
   * Usually allocation is performed only horizontally or sometimes
   * vertically since a group of rows are usually rendered side by
   * side vertically or horizontally and share either the same width
   * or the same height. Sometimes they are allocated in both horizontal
   * and vertical orientations producing a homogeneous effect of the
   * rows. This is generally the case for `GtkTreeView` when
   * `GtkTreeView:fixed-height-mode` is enabled.
   * Params:
   *   width = the allocated width for all `GtkTreeModel` rows rendered
   *     with context, or -1
   *   height = the allocated height for all `GtkTreeModel` rows rendered
   *     with context, or -1

   * Deprecated: This object will be removed in GTK 5
   */
  void allocate(int width, int height)
  {
    gtk_cell_area_context_allocate(cast(GtkCellAreaContext*)cPtr, width, height);
  }

  /**
   * Fetches the current allocation size for context.
   * If the context was not allocated in width or height, or if the
   * context was recently reset with [Gtk.CellAreaContext.reset],
   * the returned value will be -1.
   * Params:
   *   width = location to store the allocated width
   *   height = location to store the allocated height

   * Deprecated: This object will be removed in GTK 5
   */
  void getAllocation(out int width, out int height)
  {
    gtk_cell_area_context_get_allocation(cast(GtkCellAreaContext*)cPtr, cast(int*)&width, cast(int*)&height);
  }

  /**
   * Fetches the `GtkCellArea` this context was created by.
   * This is generally unneeded by layouting widgets; however,
   * it is important for the context implementation itself to
   * fetch information about the area it is being used for.
   * For instance at `GtkCellAreaContextClass.allocate$(LPAREN)$(RPAREN)` time
   * it’s important to know details about any cell spacing
   * that the `GtkCellArea` is configured with in order to
   * compute a proper allocation.
   * Returns: the `GtkCellArea` this context was created by.

   * Deprecated: This object will be removed in GTK 5
   */
  CellArea getArea()
  {
    GtkCellArea* _cretval;
    _cretval = gtk_cell_area_context_get_area(cast(GtkCellAreaContext*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!CellArea(cast(GtkCellArea*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the accumulative preferred height for all rows which have been
   * requested with this context.
   * After [Gtk.CellAreaContext.reset] is called and/or before ever
   * requesting the size of a `GtkCellArea`, the returned values are 0.
   * Params:
   *   minimumHeight = location to store the minimum height
   *   naturalHeight = location to store the natural height

   * Deprecated: This object will be removed in GTK 5
   */
  void getPreferredHeight(out int minimumHeight, out int naturalHeight)
  {
    gtk_cell_area_context_get_preferred_height(cast(GtkCellAreaContext*)cPtr, cast(int*)&minimumHeight, cast(int*)&naturalHeight);
  }

  /**
   * Gets the accumulative preferred height for width for all rows
   * which have been requested for the same said width with this context.
   * After [Gtk.CellAreaContext.reset] is called and/or before ever
   * requesting the size of a `GtkCellArea`, the returned values are -1.
   * Params:
   *   width = a proposed width for allocation
   *   minimumHeight = location to store the minimum height
   *   naturalHeight = location to store the natural height

   * Deprecated: This object will be removed in GTK 5
   */
  void getPreferredHeightForWidth(int width, out int minimumHeight, out int naturalHeight)
  {
    gtk_cell_area_context_get_preferred_height_for_width(cast(GtkCellAreaContext*)cPtr, width, cast(int*)&minimumHeight, cast(int*)&naturalHeight);
  }

  /**
   * Gets the accumulative preferred width for all rows which have been
   * requested with this context.
   * After [Gtk.CellAreaContext.reset] is called and/or before ever
   * requesting the size of a `GtkCellArea`, the returned values are 0.
   * Params:
   *   minimumWidth = location to store the minimum width
   *   naturalWidth = location to store the natural width

   * Deprecated: This object will be removed in GTK 5
   */
  void getPreferredWidth(out int minimumWidth, out int naturalWidth)
  {
    gtk_cell_area_context_get_preferred_width(cast(GtkCellAreaContext*)cPtr, cast(int*)&minimumWidth, cast(int*)&naturalWidth);
  }

  /**
   * Gets the accumulative preferred width for height for all rows which
   * have been requested for the same said height with this context.
   * After [Gtk.CellAreaContext.reset] is called and/or before ever
   * requesting the size of a `GtkCellArea`, the returned values are -1.
   * Params:
   *   height = a proposed height for allocation
   *   minimumWidth = location to store the minimum width
   *   naturalWidth = location to store the natural width

   * Deprecated: This object will be removed in GTK 5
   */
  void getPreferredWidthForHeight(int height, out int minimumWidth, out int naturalWidth)
  {
    gtk_cell_area_context_get_preferred_width_for_height(cast(GtkCellAreaContext*)cPtr, height, cast(int*)&minimumWidth, cast(int*)&naturalWidth);
  }

  /**
   * Causes the minimum and/or natural height to grow if the new
   * proposed sizes exceed the current minimum and natural height.
   * This is used by `GtkCellAreaContext` implementations during
   * the request process over a series of `GtkTreeModel` rows to
   * progressively push the requested height over a series of
   * [Gtk.CellArea.getPreferredHeight] requests.
   * Params:
   *   minimumHeight = the proposed new minimum height for context
   *   naturalHeight = the proposed new natural height for context

   * Deprecated: This object will be removed in GTK 5
   */
  void pushPreferredHeight(int minimumHeight, int naturalHeight)
  {
    gtk_cell_area_context_push_preferred_height(cast(GtkCellAreaContext*)cPtr, minimumHeight, naturalHeight);
  }

  /**
   * Causes the minimum and/or natural width to grow if the new
   * proposed sizes exceed the current minimum and natural width.
   * This is used by `GtkCellAreaContext` implementations during
   * the request process over a series of `GtkTreeModel` rows to
   * progressively push the requested width over a series of
   * [Gtk.CellArea.getPreferredWidth] requests.
   * Params:
   *   minimumWidth = the proposed new minimum width for context
   *   naturalWidth = the proposed new natural width for context

   * Deprecated: This object will be removed in GTK 5
   */
  void pushPreferredWidth(int minimumWidth, int naturalWidth)
  {
    gtk_cell_area_context_push_preferred_width(cast(GtkCellAreaContext*)cPtr, minimumWidth, naturalWidth);
  }

  /**
   * Resets any previously cached request and allocation
   * data.
   * When underlying `GtkTreeModel` data changes its
   * important to reset the context if the content
   * size is allowed to shrink. If the content size
   * is only allowed to grow $(LPAREN)this is usually an option
   * for views rendering large data stores as a measure
   * of optimization$(RPAREN), then only the row that changed
   * or was inserted needs to be $(LPAREN)re$(RPAREN)requested with
   * [Gtk.CellArea.getPreferredWidth].
   * When the new overall size of the context requires
   * that the allocated size changes $(LPAREN)or whenever this
   * allocation changes at all$(RPAREN), the variable row
   * sizes need to be re-requested for every row.
   * For instance, if the rows are displayed all with
   * the same width from top to bottom then a change
   * in the allocated width necessitates a recalculation
   * of all the displayed row heights using
   * [Gtk.CellArea.getPreferredHeightForWidth].

   * Deprecated: This object will be removed in GTK 5
   */
  void reset()
  {
    gtk_cell_area_context_reset(cast(GtkCellAreaContext*)cPtr);
  }
}
