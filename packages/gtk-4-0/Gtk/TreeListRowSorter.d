module Gtk.TreeListRowSorter;

import GObject.ObjectG;
import Gid.gid;
import Gtk.Sorter;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkTreeListRowSorter` is a special-purpose sorter that will apply a given
 * sorter to the levels in a tree.
 * Here is an example for setting up a column view with a tree model and
 * a `GtkTreeListSorter`:
 * ```c
 * column_sorter \= gtk_column_view_get_sorter $(LPAREN)view$(RPAREN);
 * sorter \= gtk_tree_list_row_sorter_new $(LPAREN)g_object_ref $(LPAREN)column_sorter$(RPAREN)$(RPAREN);
 * sort_model \= gtk_sort_list_model_new $(LPAREN)tree_model, sorter$(RPAREN);
 * selection \= gtk_single_selection_new $(LPAREN)sort_model$(RPAREN);
 * gtk_column_view_set_model $(LPAREN)view, G_LIST_MODEL $(LPAREN)selection$(RPAREN)$(RPAREN);
 * ```
 */
class TreeListRowSorter : Sorter
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
    return gtk_tree_list_row_sorter_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Create a special-purpose sorter that applies the sorting
   * of sorter to the levels of a `GtkTreeListModel`.
   * Note that this sorter relies on [Gtk.TreeListModel.passthrough]
   * being %FALSE as it can only sort [Gtk.TreeListRow]s.
   * Params:
   *   sorter = a `GtkSorter`
   * Returns: a new `GtkTreeListRowSorter`
   */
  this(Sorter sorter)
  {
    GtkTreeListRowSorter* _cretval;
    _cretval = gtk_tree_list_row_sorter_new(sorter ? cast(GtkSorter*)sorter.cPtr(true) : null);
    this(_cretval, true);
  }

  /**
   * Returns the sorter used by self.
   * Returns: the sorter used
   */
  Sorter getSorter()
  {
    GtkSorter* _cretval;
    _cretval = gtk_tree_list_row_sorter_get_sorter(cast(GtkTreeListRowSorter*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Sorter(cast(GtkSorter*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Sets the sorter to use for items with the same parent.
   * This sorter will be passed the [Gtk.TreeListRow.item] of
   * the tree list rows passed to self.
   * Params:
   *   sorter = The sorter to use
   */
  void setSorter(Sorter sorter)
  {
    gtk_tree_list_row_sorter_set_sorter(cast(GtkTreeListRowSorter*)cPtr, sorter ? cast(GtkSorter*)sorter.cPtr(false) : null);
  }
}
