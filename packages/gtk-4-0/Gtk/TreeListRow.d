module Gtk.TreeListRow;

import GObject.ObjectG;
import Gid.gid;
import Gio.ListModel;
import Gio.ListModelT;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkTreeListRow` is used by `GtkTreeListModel` to represent items.
 * It allows navigating the model as a tree and modify the state of rows.
 * `GtkTreeListRow` instances are created by a `GtkTreeListModel` only
 * when the [Gtk.TreeListModel.passthrough] property is not set.
 * There are various support objects that can make use of `GtkTreeListRow`
 * objects, such as the [Gtk.TreeExpander] widget that allows displaying
 * an icon to expand or collapse a row or [Gtk.TreeListRowSorter] that
 * makes it possible to sort trees properly.
 */
class TreeListRow : ObjectG
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
    return gtk_tree_list_row_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * If self is not expanded or position is greater than the
   * number of children, %NULL is returned.
   * Params:
   *   position = position of the child to get
   * Returns: the child in position
   */
  TreeListRow getChildRow(uint position)
  {
    GtkTreeListRow* _cretval;
    _cretval = gtk_tree_list_row_get_child_row(cast(GtkTreeListRow*)cPtr, position);
    auto _retval = _cretval ? ObjectG.getDObject!TreeListRow(cast(GtkTreeListRow*)_cretval, true) : null;
    return _retval;
  }

  /**
   * If the row is expanded, gets the model holding the children of self.
   * This model is the model created by the
   * [Gtk.TreeListModelCreateModelFunc]
   * and contains the original items, no matter what value
   * [Gtk.TreeListModel.passthrough] is set to.
   * Returns: The model containing the children
   */
  ListModel getChildren()
  {
    GListModel* _cretval;
    _cretval = gtk_tree_list_row_get_children(cast(GtkTreeListRow*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!ListModel(cast(GListModel*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the depth of this row.
   * Rows that correspond to items in the root model have a depth
   * of zero, rows corresponding to items of models of direct children
   * of the root model have a depth of 1 and so on.
   * The depth of a row never changes until the row is removed from its model
   * at which point it will forever return 0.
   * Returns: The depth of this row
   */
  uint getDepth()
  {
    uint _retval;
    _retval = gtk_tree_list_row_get_depth(cast(GtkTreeListRow*)cPtr);
    return _retval;
  }

  /**
   * Gets if a row is currently expanded.
   * Returns: %TRUE if the row is expanded
   */
  bool getExpanded()
  {
    bool _retval;
    _retval = gtk_tree_list_row_get_expanded(cast(GtkTreeListRow*)cPtr);
    return _retval;
  }

  /**
   * Gets the item corresponding to this row,
   * Returns: The item
   *   of this row. This function is only marked as nullable for backwards
   *   compatibility reasons.
   */
  ObjectG getItem()
  {
    ObjectC* _cretval;
    _cretval = gtk_tree_list_row_get_item(cast(GtkTreeListRow*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!ObjectG(cast(ObjectC*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Gets the row representing the parent for self.
   * That is the row that would need to be collapsed
   * to make this row disappear.
   * If self is a row corresponding to the root model,
   * %NULL is returned.
   * The value returned by this function never changes
   * until the row is removed from its model at which point
   * it will forever return %NULL.
   * Returns: The parent of self
   */
  TreeListRow getParent()
  {
    GtkTreeListRow* _cretval;
    _cretval = gtk_tree_list_row_get_parent(cast(GtkTreeListRow*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!TreeListRow(cast(GtkTreeListRow*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Returns the position in the `GtkTreeListModel` that self occupies
   * at the moment.
   * Returns: The position in the model
   */
  uint getPosition()
  {
    uint _retval;
    _retval = gtk_tree_list_row_get_position(cast(GtkTreeListRow*)cPtr);
    return _retval;
  }

  /**
   * Checks if a row can be expanded.
   * This does not mean that the row is actually expanded,
   * this can be checked with [Gtk.TreeListRow.getExpanded].
   * If a row is expandable never changes until the row is removed
   * from its model at which point it will forever return %FALSE.
   * Returns: %TRUE if the row is expandable
   */
  bool isExpandable()
  {
    bool _retval;
    _retval = gtk_tree_list_row_is_expandable(cast(GtkTreeListRow*)cPtr);
    return _retval;
  }

  /**
   * Expands or collapses a row.
   * If a row is expanded, the model of calling the
   * [Gtk.TreeListModelCreateModelFunc] for the row's
   * item will be inserted after this row. If a row is collapsed,
   * those items will be removed from the model.
   * If the row is not expandable, this function does nothing.
   * Params:
   *   expanded = %TRUE if the row should be expanded
   */
  void setExpanded(bool expanded)
  {
    gtk_tree_list_row_set_expanded(cast(GtkTreeListRow*)cPtr, expanded);
  }
}
