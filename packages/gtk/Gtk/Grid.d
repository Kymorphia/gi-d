module Gtk.Grid;

import GObject.ObjectG;
import Gid.gid;
import Gtk.Accessible;
import Gtk.AccessibleT;
import Gtk.Buildable;
import Gtk.BuildableT;
import Gtk.ConstraintTarget;
import Gtk.ConstraintTargetT;
import Gtk.Orientable;
import Gtk.OrientableT;
import Gtk.Types;
import Gtk.Widget;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkGrid` is a container which arranges its child widgets in
 * rows and columns.
 * ![An example GtkGrid](grid.png)
 * It supports arbitrary positions and horizontal/vertical spans.
 * Children are added using [Gtk.Grid.attach]. They can span multiple
 * rows or columns. It is also possible to add a child next to an existing
 * child, using [Gtk.Grid.attachNextTo]. To remove a child from the
 * grid, use [Gtk.Grid.remove].
 * The behaviour of `GtkGrid` when several children occupy the same grid
 * cell is undefined.
 * # GtkGrid as GtkBuildable
 * Every child in a `GtkGrid` has access to a custom [Gtk.Buildable]
 * element, called `<layout>`. It can by used to specify a position in the
 * grid and optionally spans. All properties that can be used in the `<layout>`
 * element are implemented by [Gtk.GridLayoutChild].
 * It is implemented by `GtkWidget` using [Gtk.LayoutManager].
 * To showcase it, here is a simple example:
 * ```xml
 * <object class\="GtkGrid" id\="my_grid">
 * <child>
 * <object class\="GtkButton" id\="button1">
 * <property name\="label">Button 1</property>
 * <layout>
 * <property name\="column">0</property>
 * <property name\="row">0</property>
 * </layout>
 * </object>
 * </child>
 * <child>
 * <object class\="GtkButton" id\="button2">
 * <property name\="label">Button 2</property>
 * <layout>
 * <property name\="column">1</property>
 * <property name\="row">0</property>
 * </layout>
 * </object>
 * </child>
 * <child>
 * <object class\="GtkButton" id\="button3">
 * <property name\="label">Button 3</property>
 * <layout>
 * <property name\="column">2</property>
 * <property name\="row">0</property>
 * <property name\="row-span">2</property>
 * </layout>
 * </object>
 * </child>
 * <child>
 * <object class\="GtkButton" id\="button4">
 * <property name\="label">Button 4</property>
 * <layout>
 * <property name\="column">0</property>
 * <property name\="row">1</property>
 * <property name\="column-span">2</property>
 * </layout>
 * </object>
 * </child>
 * </object>
 * ```
 * It organizes the first two buttons side-by-side in one cell each.
 * The third button is in the last column but spans across two rows.
 * This is defined by the `row-span` property. The last button is
 * located in the second row and spans across two columns, which is
 * defined by the `column-span` property.
 * # CSS nodes
 * `GtkGrid` uses a single CSS node with name `grid`.
 * # Accessibility
 * Until GTK 4.10, `GtkGrid` used the `GTK_ACCESSIBLE_ROLE_GROUP` role.
 * Starting from GTK 4.12, `GtkGrid` uses the `GTK_ACCESSIBLE_ROLE_GENERIC` role.
 */
class Grid : Widget, Orientable
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return gtk_grid_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin OrientableT!();

  /**
   * Creates a new grid widget.
   * Returns: the new `GtkGrid`
   */
  this()
  {
    GtkWidget* _cretval;
    _cretval = gtk_grid_new();
    this(_cretval, false);
  }

  /**
   * Adds a widget to the grid.
   * The position of child is determined by column and row.
   * The number of “cells” that child will occupy is determined
   * by width and height.
   * Params:
   *   child = the widget to add
   *   column = the column number to attach the left side of child to
   *   row = the row number to attach the top side of child to
   *   width = the number of columns that child will span
   *   height = the number of rows that child will span
   */
  void attach(Widget child, int column, int row, int width, int height)
  {
    gtk_grid_attach(cast(GtkGrid*)cPtr, child ? cast(GtkWidget*)child.cPtr(false) : null, column, row, width, height);
  }

  /**
   * Adds a widget to the grid.
   * The widget is placed next to sibling, on the side determined by
   * side. When sibling is %NULL, the widget is placed in row $(LPAREN)for
   * left or right placement$(RPAREN) or column 0 $(LPAREN)for top or bottom placement$(RPAREN),
   * at the end indicated by side.
   * Attaching widgets labeled `[1]`, `[2]`, `[3]` with `sibling \=\= %NULL` and
   * `side \=\= %GTK_POS_LEFT` yields a layout of `[3][2][1]`.
   * Params:
   *   child = the widget to add
   *   sibling = the child of grid that child will be placed
   *     next to, or %NULL to place child at the beginning or end
   *   side = the side of sibling that child is positioned next to
   *   width = the number of columns that child will span
   *   height = the number of rows that child will span
   */
  void attachNextTo(Widget child, Widget sibling, PositionType side, int width, int height)
  {
    gtk_grid_attach_next_to(cast(GtkGrid*)cPtr, child ? cast(GtkWidget*)child.cPtr(false) : null, sibling ? cast(GtkWidget*)sibling.cPtr(false) : null, side, width, height);
  }

  /**
   * Returns which row defines the global baseline of grid.
   * Returns: the row index defining the global baseline
   */
  int getBaselineRow()
  {
    int _retval;
    _retval = gtk_grid_get_baseline_row(cast(GtkGrid*)cPtr);
    return _retval;
  }

  /**
   * Gets the child of grid whose area covers the grid
   * cell at column, row.
   * Params:
   *   column = the left edge of the cell
   *   row = the top edge of the cell
   * Returns: the child at the given position
   */
  Widget getChildAt(int column, int row)
  {
    GtkWidget* _cretval;
    _cretval = gtk_grid_get_child_at(cast(GtkGrid*)cPtr, column, row);
    auto _retval = _cretval ? ObjectG.getDObject!Widget(cast(GtkWidget*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns whether all columns of grid have the same width.
   * Returns: whether all columns of grid have the same width.
   */
  bool getColumnHomogeneous()
  {
    bool _retval;
    _retval = gtk_grid_get_column_homogeneous(cast(GtkGrid*)cPtr);
    return _retval;
  }

  /**
   * Returns the amount of space between the columns of grid.
   * Returns: the column spacing of grid
   */
  uint getColumnSpacing()
  {
    uint _retval;
    _retval = gtk_grid_get_column_spacing(cast(GtkGrid*)cPtr);
    return _retval;
  }

  /**
   * Returns the baseline position of row.
   * See [Gtk.Grid.setRowBaselinePosition].
   * Params:
   *   row = a row index
   * Returns: the baseline position of row
   */
  BaselinePosition getRowBaselinePosition(int row)
  {
    GtkBaselinePosition _cretval;
    _cretval = gtk_grid_get_row_baseline_position(cast(GtkGrid*)cPtr, row);
    BaselinePosition _retval = cast(BaselinePosition)_cretval;
    return _retval;
  }

  /**
   * Returns whether all rows of grid have the same height.
   * Returns: whether all rows of grid have the same height.
   */
  bool getRowHomogeneous()
  {
    bool _retval;
    _retval = gtk_grid_get_row_homogeneous(cast(GtkGrid*)cPtr);
    return _retval;
  }

  /**
   * Returns the amount of space between the rows of grid.
   * Returns: the row spacing of grid
   */
  uint getRowSpacing()
  {
    uint _retval;
    _retval = gtk_grid_get_row_spacing(cast(GtkGrid*)cPtr);
    return _retval;
  }

  /**
   * Inserts a column at the specified position.
   * Children which are attached at or to the right of this position
   * are moved one column to the right. Children which span across this
   * position are grown to span the new column.
   * Params:
   *   position = the position to insert the column at
   */
  void insertColumn(int position)
  {
    gtk_grid_insert_column(cast(GtkGrid*)cPtr, position);
  }

  /**
   * Inserts a row or column at the specified position.
   * The new row or column is placed next to sibling, on the side
   * determined by side. If side is %GTK_POS_TOP or %GTK_POS_BOTTOM,
   * a row is inserted. If side is %GTK_POS_LEFT of %GTK_POS_RIGHT,
   * a column is inserted.
   * Params:
   *   sibling = the child of grid that the new row or column will be
   *     placed next to
   *   side = the side of sibling that child is positioned next to
   */
  void insertNextTo(Widget sibling, PositionType side)
  {
    gtk_grid_insert_next_to(cast(GtkGrid*)cPtr, sibling ? cast(GtkWidget*)sibling.cPtr(false) : null, side);
  }

  /**
   * Inserts a row at the specified position.
   * Children which are attached at or below this position
   * are moved one row down. Children which span across this
   * position are grown to span the new row.
   * Params:
   *   position = the position to insert the row at
   */
  void insertRow(int position)
  {
    gtk_grid_insert_row(cast(GtkGrid*)cPtr, position);
  }

  /**
   * Queries the attach points and spans of child inside the given `GtkGrid`.
   * Params:
   *   child = a `GtkWidget` child of grid
   *   column = the column used to attach the left side of child
   *   row = the row used to attach the top side of child
   *   width = the number of columns child spans
   *   height = the number of rows child spans
   */
  void queryChild(Widget child, out int column, out int row, out int width, out int height)
  {
    gtk_grid_query_child(cast(GtkGrid*)cPtr, child ? cast(GtkWidget*)child.cPtr(false) : null, cast(int*)&column, cast(int*)&row, cast(int*)&width, cast(int*)&height);
  }

  /**
   * Removes a child from grid.
   * The child must have been added with
   * [Gtk.Grid.attach] or [Gtk.Grid.attachNextTo].
   * Params:
   *   child = the child widget to remove
   */
  void remove(Widget child)
  {
    gtk_grid_remove(cast(GtkGrid*)cPtr, child ? cast(GtkWidget*)child.cPtr(false) : null);
  }

  /**
   * Removes a column from the grid.
   * Children that are placed in this column are removed,
   * spanning children that overlap this column have their
   * width reduced by one, and children after the column
   * are moved to the left.
   * Params:
   *   position = the position of the column to remove
   */
  void removeColumn(int position)
  {
    gtk_grid_remove_column(cast(GtkGrid*)cPtr, position);
  }

  /**
   * Removes a row from the grid.
   * Children that are placed in this row are removed,
   * spanning children that overlap this row have their
   * height reduced by one, and children below the row
   * are moved up.
   * Params:
   *   position = the position of the row to remove
   */
  void removeRow(int position)
  {
    gtk_grid_remove_row(cast(GtkGrid*)cPtr, position);
  }

  /**
   * Sets which row defines the global baseline for the entire grid.
   * Each row in the grid can have its own local baseline, but only
   * one of those is global, meaning it will be the baseline in the
   * parent of the grid.
   * Params:
   *   row = the row index
   */
  void setBaselineRow(int row)
  {
    gtk_grid_set_baseline_row(cast(GtkGrid*)cPtr, row);
  }

  /**
   * Sets whether all columns of grid will have the same width.
   * Params:
   *   homogeneous = %TRUE to make columns homogeneous
   */
  void setColumnHomogeneous(bool homogeneous)
  {
    gtk_grid_set_column_homogeneous(cast(GtkGrid*)cPtr, homogeneous);
  }

  /**
   * Sets the amount of space between columns of grid.
   * Params:
   *   spacing = the amount of space to insert between columns
   */
  void setColumnSpacing(uint spacing)
  {
    gtk_grid_set_column_spacing(cast(GtkGrid*)cPtr, spacing);
  }

  /**
   * Sets how the baseline should be positioned on row of the
   * grid, in case that row is assigned more space than is requested.
   * The default baseline position is %GTK_BASELINE_POSITION_CENTER.
   * Params:
   *   row = a row index
   *   pos = a `GtkBaselinePosition`
   */
  void setRowBaselinePosition(int row, BaselinePosition pos)
  {
    gtk_grid_set_row_baseline_position(cast(GtkGrid*)cPtr, row, pos);
  }

  /**
   * Sets whether all rows of grid will have the same height.
   * Params:
   *   homogeneous = %TRUE to make rows homogeneous
   */
  void setRowHomogeneous(bool homogeneous)
  {
    gtk_grid_set_row_homogeneous(cast(GtkGrid*)cPtr, homogeneous);
  }

  /**
   * Sets the amount of space between rows of grid.
   * Params:
   *   spacing = the amount of space to insert between rows
   */
  void setRowSpacing(uint spacing)
  {
    gtk_grid_set_row_spacing(cast(GtkGrid*)cPtr, spacing);
  }
}
