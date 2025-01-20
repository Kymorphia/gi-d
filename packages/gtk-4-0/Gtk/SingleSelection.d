module Gtk.SingleSelection;

import GObject.ObjectG;
import Gid.gid;
import Gio.ListModel;
import Gio.ListModelT;
import Gtk.SectionModel;
import Gtk.SectionModelT;
import Gtk.SelectionModel;
import Gtk.SelectionModelT;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkSingleSelection` is a `GtkSelectionModel` that allows selecting a single
 * item.
 * Note that the selection is *persistent* -- if the selected item is removed
 * and re-added in the same signal@Gio.ListModel::items-changed emission, it
 * stays selected. In particular, this means that changing the sort order of an
 * underlying sort model will preserve the selection.
 */
class SingleSelection : ObjectG, ListModel, SectionModel, SelectionModel
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
    return gtk_single_selection_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin ListModelT!();
  mixin SectionModelT!();
  mixin SelectionModelT!();

  /**
   * Creates a new selection to handle model.
   * Params:
   *   model = the `GListModel` to manage
   * Returns: a new `GtkSingleSelection`
   */
  this(ListModel model)
  {
    GtkSingleSelection* _cretval;
    _cretval = gtk_single_selection_new(model ? cast(GListModel*)(cast(ObjectG)model).cPtr(true) : null);
    this(_cretval, true);
  }

  /**
   * Checks if autoselect has been enabled or disabled via
   * [Gtk.SingleSelection.setAutoselect].
   * Returns: %TRUE if autoselect is enabled
   */
  bool getAutoselect()
  {
    bool _retval;
    _retval = gtk_single_selection_get_autoselect(cast(GtkSingleSelection*)cPtr);
    return _retval;
  }

  /**
   * If %TRUE, [Gtk.SelectionModel.unselectItem] is supported and allows
   * unselecting the selected item.
   * Returns: %TRUE to support unselecting
   */
  bool getCanUnselect()
  {
    bool _retval;
    _retval = gtk_single_selection_get_can_unselect(cast(GtkSingleSelection*)cPtr);
    return _retval;
  }

  /**
   * Gets the model that self is wrapping.
   * Returns: The model being wrapped
   */
  ListModel getModel()
  {
    GListModel* _cretval;
    _cretval = gtk_single_selection_get_model(cast(GtkSingleSelection*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!ListModel(cast(GListModel*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the position of the selected item.
   * If no item is selected, %GTK_INVALID_LIST_POSITION is returned.
   * Returns: The position of the selected item
   */
  uint getSelected()
  {
    uint _retval;
    _retval = gtk_single_selection_get_selected(cast(GtkSingleSelection*)cPtr);
    return _retval;
  }

  /**
   * Gets the selected item.
   * If no item is selected, %NULL is returned.
   * Returns: The selected item
   */
  ObjectG getSelectedItem()
  {
    ObjectC* _cretval;
    _cretval = gtk_single_selection_get_selected_item(cast(GtkSingleSelection*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!ObjectG(cast(ObjectC*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Enables or disables autoselect.
   * If autoselect is %TRUE, self will enforce that an item is always
   * selected. It will select a new item when the currently selected
   * item is deleted and it will disallow unselecting the current item.
   * Params:
   *   autoselect = %TRUE to always select an item
   */
  void setAutoselect(bool autoselect)
  {
    gtk_single_selection_set_autoselect(cast(GtkSingleSelection*)cPtr, autoselect);
  }

  /**
   * If %TRUE, unselecting the current item via
   * [Gtk.SelectionModel.unselectItem] is supported.
   * Note that setting [Gtk.SingleSelection.autoselect] will
   * cause unselecting to not work, so it practically makes no sense
   * to set both at the same time the same time.
   * Params:
   *   canUnselect = %TRUE to allow unselecting
   */
  void setCanUnselect(bool canUnselect)
  {
    gtk_single_selection_set_can_unselect(cast(GtkSingleSelection*)cPtr, canUnselect);
  }

  /**
   * Sets the model that self should wrap.
   * If model is %NULL, self will be empty.
   * Params:
   *   model = A `GListModel` to wrap
   */
  void setModel(ListModel model)
  {
    gtk_single_selection_set_model(cast(GtkSingleSelection*)cPtr, model ? cast(GListModel*)(cast(ObjectG)model).cPtr(false) : null);
  }

  /**
   * Selects the item at the given position.
   * If the list does not have an item at position or
   * %GTK_INVALID_LIST_POSITION is given, the behavior depends on the
   * value of the [Gtk.SingleSelection.autoselect] property:
   * If it is set, no change will occur and the old item will stay
   * selected. If it is unset, the selection will be unset and no item
   * will be selected.
   * Params:
   *   position = the item to select or %GTK_INVALID_LIST_POSITION
   */
  void setSelected(uint position)
  {
    gtk_single_selection_set_selected(cast(GtkSingleSelection*)cPtr, position);
  }
}
