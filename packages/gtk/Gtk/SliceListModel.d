module Gtk.SliceListModel;

import GObject.ObjectG;
import Gid.gid;
import Gio.ListModel;
import Gio.ListModelT;
import Gtk.SectionModel;
import Gtk.SectionModelT;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkSliceListModel` is a list model that presents a slice of another model.
 * This is useful when implementing paging by setting the size to the number
 * of elements per page and updating the offset whenever a different page is
 * opened.
 * `GtkSliceListModel` passes through sections from the underlying model.
 */
class SliceListModel : ObjectG, ListModel, SectionModel
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
    return gtk_slice_list_model_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin ListModelT!();
  mixin SectionModelT!();

  /**
   * Creates a new slice model.
   * It presents the slice from offset to offset + size
   * of the given model.
   * Params:
   *   model = The model to use
   *   offset = the offset of the slice
   *   size = maximum size of the slice
   * Returns: A new `GtkSliceListModel`
   */
  this(ListModel model, uint offset, uint size)
  {
    GtkSliceListModel* _cretval;
    _cretval = gtk_slice_list_model_new(model ? cast(GListModel*)(cast(ObjectG)model).cPtr(true) : null, offset, size);
    this(_cretval, true);
  }

  /**
   * Gets the model that is currently being used or %NULL if none.
   * Returns: The model in use
   */
  ListModel getModel()
  {
    GListModel* _cretval;
    _cretval = gtk_slice_list_model_get_model(cast(GtkSliceListModel*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!ListModel(cast(GListModel*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the offset set via [Gtk.SliceListModel.setOffset].
   * Returns: The offset
   */
  uint getOffset()
  {
    uint _retval;
    _retval = gtk_slice_list_model_get_offset(cast(GtkSliceListModel*)cPtr);
    return _retval;
  }

  /**
   * Gets the size set via [Gtk.SliceListModel.setSize].
   * Returns: The size
   */
  uint getSize()
  {
    uint _retval;
    _retval = gtk_slice_list_model_get_size(cast(GtkSliceListModel*)cPtr);
    return _retval;
  }

  /**
   * Sets the model to show a slice of.
   * The model's item type must conform to self's item type.
   * Params:
   *   model = The model to be sliced
   */
  void setModel(ListModel model)
  {
    gtk_slice_list_model_set_model(cast(GtkSliceListModel*)cPtr, model ? cast(GListModel*)(cast(ObjectG)model).cPtr(false) : null);
  }

  /**
   * Sets the offset into the original model for this slice.
   * If the offset is too large for the sliced model,
   * self will end up empty.
   * Params:
   *   offset = the new offset to use
   */
  void setOffset(uint offset)
  {
    gtk_slice_list_model_set_offset(cast(GtkSliceListModel*)cPtr, offset);
  }

  /**
   * Sets the maximum size. self will never have more items
   * than size.
   * It can however have fewer items if the offset is too large
   * or the model sliced from doesn't have enough items.
   * Params:
   *   size = the maximum size
   */
  void setSize(uint size)
  {
    gtk_slice_list_model_set_size(cast(GtkSliceListModel*)cPtr, size);
  }
}
