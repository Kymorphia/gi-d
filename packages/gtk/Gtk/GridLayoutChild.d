module Gtk.GridLayoutChild;

import Gid.gid;
import Gtk.LayoutChild;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkLayoutChild` subclass for children in a `GtkGridLayout`.
 */
class GridLayoutChild : LayoutChild
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
    return gtk_grid_layout_child_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Retrieves the column number to which child attaches its left side.
   * Returns: the column number
   */
  int getColumn()
  {
    int _retval;
    _retval = gtk_grid_layout_child_get_column(cast(GtkGridLayoutChild*)cPtr);
    return _retval;
  }

  /**
   * Retrieves the number of columns that child spans to.
   * Returns: the number of columns
   */
  int getColumnSpan()
  {
    int _retval;
    _retval = gtk_grid_layout_child_get_column_span(cast(GtkGridLayoutChild*)cPtr);
    return _retval;
  }

  /**
   * Retrieves the row number to which child attaches its top side.
   * Returns: the row number
   */
  int getRow()
  {
    int _retval;
    _retval = gtk_grid_layout_child_get_row(cast(GtkGridLayoutChild*)cPtr);
    return _retval;
  }

  /**
   * Retrieves the number of rows that child spans to.
   * Returns: the number of row
   */
  int getRowSpan()
  {
    int _retval;
    _retval = gtk_grid_layout_child_get_row_span(cast(GtkGridLayoutChild*)cPtr);
    return _retval;
  }

  /**
   * Sets the column number to attach the left side of child.
   * Params:
   *   column = the attach point for child
   */
  void setColumn(int column)
  {
    gtk_grid_layout_child_set_column(cast(GtkGridLayoutChild*)cPtr, column);
  }

  /**
   * Sets the number of columns child spans to.
   * Params:
   *   span = the span of child
   */
  void setColumnSpan(int span)
  {
    gtk_grid_layout_child_set_column_span(cast(GtkGridLayoutChild*)cPtr, span);
  }

  /**
   * Sets the row to place child in.
   * Params:
   *   row = the row for child
   */
  void setRow(int row)
  {
    gtk_grid_layout_child_set_row(cast(GtkGridLayoutChild*)cPtr, row);
  }

  /**
   * Sets the number of rows child spans to.
   * Params:
   *   span = the span of child
   */
  void setRowSpan(int span)
  {
    gtk_grid_layout_child_set_row_span(cast(GtkGridLayoutChild*)cPtr, span);
  }
}
