module Gtk.ColumnViewSorter;

import GObject.ObjectG;
import Gid.gid;
import Gtk.ColumnViewColumn;
import Gtk.Sorter;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkColumnViewSorter` is a sorter implementation that
 * is geared towards the needs of `GtkColumnView`.
 * The sorter returned by [Gtk.ColumnView.getSorter] is
 * a `GtkColumnViewSorter`.
 * In column views, sorting can be configured by associating
 * sorters with columns, and users can invert sort order by clicking
 * on column headers. The API of `GtkColumnViewSorter` is designed
 * to allow saving and restoring this configuration.
 * If you are only interested in the primary sort column $(LPAREN)i.e. the
 * column where a sort indicator is shown in the header$(RPAREN), then
 * you can just look at property@Gtk.ColumnViewSorter:primary-sort-column
 * and property@Gtk.ColumnViewSorter:primary-sort-order.
 * If you want to store the full sort configuration, including
 * secondary sort columns that are used for tie breaking, then
 * you can use [Gtk.ColumnViewSorter.getNthSortColumn].
 * To get notified about changes, use [Gtk.Sorter.changed].
 * To restore a saved sort configuration on a `GtkColumnView`,
 * use code like:
 * ```
 * sorter \= gtk_column_view_get_sorter $(LPAREN)view$(RPAREN);
 * for $(LPAREN)i \= gtk_column_view_sorter_get_n_sort_columns $(LPAREN)sorter$(RPAREN) - 1; i >\= 0; i--$(RPAREN)
 * {
 * column \= gtk_column_view_sorter_get_nth_sort_column $(LPAREN)sorter, i, &order$(RPAREN);
 * gtk_column_view_sort_by_column $(LPAREN)view, column, order$(RPAREN);
 * }
 * ```
 */
class ColumnViewSorter : Sorter
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
    return gtk_column_view_sorter_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Returns the number of columns by which the sorter sorts.
   * If the sorter of the primary sort column does not determine
   * a total order, then the secondary sorters are consulted to
   * break the ties.
   * Use the [Gtk.Sorter.changed] signal to get notified
   * when the number of sort columns changes.
   * Returns: the number of sort columns
   */
  uint getNSortColumns()
  {
    uint _retval;
    _retval = gtk_column_view_sorter_get_n_sort_columns(cast(GtkColumnViewSorter*)cPtr);
    return _retval;
  }

  /**
   * Gets the position'th sort column and its associated sort order.
   * Use the [Gtk.Sorter.changed] signal to get notified
   * when sort columns change.
   * Params:
   *   position = the position of the sort column to retrieve $(LPAREN)0 for the
   *     primary sort column$(RPAREN)
   *   sortOrder = return location for the sort order
   * Returns: the positions sort column
   */
  ColumnViewColumn getNthSortColumn(uint position, out SortType sortOrder)
  {
    GtkColumnViewColumn* _cretval;
    _cretval = gtk_column_view_sorter_get_nth_sort_column(cast(GtkColumnViewSorter*)cPtr, position, &sortOrder);
    auto _retval = _cretval ? ObjectG.getDObject!ColumnViewColumn(cast(GtkColumnViewColumn*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns the primary sort column.
   * The primary sort column is the one that displays the triangle
   * in a column view header.
   * Returns: the primary sort column
   */
  ColumnViewColumn getPrimarySortColumn()
  {
    GtkColumnViewColumn* _cretval;
    _cretval = gtk_column_view_sorter_get_primary_sort_column(cast(GtkColumnViewSorter*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!ColumnViewColumn(cast(GtkColumnViewColumn*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns the primary sort order.
   * The primary sort order determines whether the triangle displayed
   * in the column view header of the primary sort column points upwards
   * or downwards.
   * If there is no primary sort column, then this function returns
   * `GTK_SORT_ASCENDING`.
   * Returns: the primary sort order
   */
  SortType getPrimarySortOrder()
  {
    GtkSortType _cretval;
    _cretval = gtk_column_view_sorter_get_primary_sort_order(cast(GtkColumnViewSorter*)cPtr);
    SortType _retval = cast(SortType)_cretval;
    return _retval;
  }
}
