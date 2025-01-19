module Gtk.MultiSelection;

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
 * `GtkMultiSelection` is a `GtkSelectionModel` that allows selecting multiple
 * elements.
 */
class MultiSelection : ObjectG, ListModel, SectionModel, SelectionModel
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
    return gtk_multi_selection_get_type();
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
   * Returns: a new `GtkMultiSelection`
   */
  this(ListModel model)
  {
    GtkMultiSelection* _cretval;
    _cretval = gtk_multi_selection_new(model ? cast(GListModel*)(cast(ObjectG)model).cPtr(true) : null);
    this(_cretval, true);
  }

  /**
   * Returns the underlying model of self.
   * Returns: the underlying model
   */
  ListModel getModel()
  {
    GListModel* _cretval;
    _cretval = gtk_multi_selection_get_model(cast(GtkMultiSelection*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!ListModel(cast(GListModel*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Sets the model that self should wrap.
   * If model is %NULL, self will be empty.
   * Params:
   *   model = A `GListModel` to wrap
   */
  void setModel(ListModel model)
  {
    gtk_multi_selection_set_model(cast(GtkMultiSelection*)cPtr, model ? cast(GListModel*)(cast(ObjectG)model).cPtr(false) : null);
  }
}
