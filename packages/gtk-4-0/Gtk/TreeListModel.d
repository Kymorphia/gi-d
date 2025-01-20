module Gtk.TreeListModel;

import GObject.ObjectG;
import Gid.gid;
import Gio.ListModel;
import Gio.ListModelT;
import Gtk.TreeListRow;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkTreeListModel` is a list model that can create child models on demand.
 */
class TreeListModel : ObjectG, ListModel
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
    return gtk_tree_list_model_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin ListModelT!();

  /**
   * Creates a new empty `GtkTreeListModel` displaying root
   * with all rows collapsed.
   * Params:
   *   root = The `GListModel` to use as root
   *   passthrough = %TRUE to pass through items from the models
   *   autoexpand = %TRUE to set the autoexpand property and expand the root model
   *   createFunc = Function to call to create the `GListModel` for the children
   *     of an item
   * Returns: a newly created `GtkTreeListModel`.
   */
  this(ListModel root, bool passthrough, bool autoexpand, TreeListModelCreateModelFunc createFunc)
  {
    extern(C) GListModel* _createFuncCallback(ObjectC* item, void* userData)
    {
      ListModel _dretval;
      auto _dlg = cast(TreeListModelCreateModelFunc*)userData;

      _dretval = (*_dlg)(item ? ObjectG.getDObject!ObjectG(cast(void*)item, false) : null);
      GListModel* _retval = cast(GListModel*)(cast(ObjectG)_dretval).cPtr(true);

      return _retval;
    }

    GtkTreeListModel* _cretval;
    auto _createFunc = freezeDelegate(cast(void*)&createFunc);
    _cretval = gtk_tree_list_model_new(root ? cast(GListModel*)(cast(ObjectG)root).cPtr(true) : null, passthrough, autoexpand, &_createFuncCallback, _createFunc, &thawDelegate);
    this(_cretval, true);
  }

  /**
   * Gets whether the model is set to automatically expand new rows
   * that get added.
   * This can be either rows added by changes to the underlying
   * models or via [Gtk.TreeListRow.setExpanded].
   * Returns: %TRUE if the model is set to autoexpand
   */
  bool getAutoexpand()
  {
    bool _retval;
    _retval = gtk_tree_list_model_get_autoexpand(cast(GtkTreeListModel*)cPtr);
    return _retval;
  }

  /**
   * Gets the row item corresponding to the child at index position for
   * self's root model.
   * If position is greater than the number of children in the root model,
   * %NULL is returned.
   * Do not confuse this function with [Gtk.TreeListModel.getRow].
   * Params:
   *   position = position of the child to get
   * Returns: the child in position
   */
  TreeListRow getChildRow(uint position)
  {
    GtkTreeListRow* _cretval;
    _cretval = gtk_tree_list_model_get_child_row(cast(GtkTreeListModel*)cPtr, position);
    auto _retval = _cretval ? ObjectG.getDObject!TreeListRow(cast(GtkTreeListRow*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Gets the root model that self was created with.
   * Returns: the root model
   */
  ListModel getModel()
  {
    GListModel* _cretval;
    _cretval = gtk_tree_list_model_get_model(cast(GtkTreeListModel*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!ListModel(cast(GListModel*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets whether the model is passing through original row items.
   * If this function returns %FALSE, the `GListModel` functions for self
   * return custom `GtkTreeListRow` objects. You need to call
   * [Gtk.TreeListRow.getItem] on these objects to get the original
   * item.
   * If %TRUE, the values of the child models are passed through in their
   * original state. You then need to call [Gtk.TreeListModel.getRow]
   * to get the custom `GtkTreeListRow`s.
   * Returns: %TRUE if the model is passing through original row items
   */
  bool getPassthrough()
  {
    bool _retval;
    _retval = gtk_tree_list_model_get_passthrough(cast(GtkTreeListModel*)cPtr);
    return _retval;
  }

  /**
   * Gets the row object for the given row.
   * If position is greater than the number of items in self,
   * %NULL is returned.
   * The row object can be used to expand and collapse rows as
   * well as to inspect its position in the tree. See its
   * documentation for details.
   * This row object is persistent and will refer to the current
   * item as long as the row is present in self, independent of
   * other rows being added or removed.
   * If self is set to not be passthrough, this function is
   * equivalent to calling [Gio.ListModel.getItem].
   * Do not confuse this function with [Gtk.TreeListModel.getChildRow].
   * Params:
   *   position = the position of the row to fetch
   * Returns: The row item
   */
  TreeListRow getRow(uint position)
  {
    GtkTreeListRow* _cretval;
    _cretval = gtk_tree_list_model_get_row(cast(GtkTreeListModel*)cPtr, position);
    auto _retval = _cretval ? ObjectG.getDObject!TreeListRow(cast(GtkTreeListRow*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Sets whether the model should autoexpand.
   * If set to %TRUE, the model will recursively expand all rows that
   * get added to the model. This can be either rows added by changes
   * to the underlying models or via [Gtk.TreeListRow.setExpanded].
   * Params:
   *   autoexpand = %TRUE to make the model autoexpand its rows
   */
  void setAutoexpand(bool autoexpand)
  {
    gtk_tree_list_model_set_autoexpand(cast(GtkTreeListModel*)cPtr, autoexpand);
  }
}
