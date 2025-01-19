module Gtk.MapListModel;

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
 * A `GtkMapListModel` maps the items in a list model to different items.
 * `GtkMapListModel` uses a [Gtk.MapListModelMapFunc].
 * Example: Create a list of `GtkEventControllers`
 * ```c
 * static gpointer
 * map_to_controllers $(LPAREN)gpointer widget,
 * gpointer data$(RPAREN)
 * {
 * gpointer result \= gtk_widget_observe_controllers $(LPAREN)widget$(RPAREN);
 * g_object_unref $(LPAREN)widget$(RPAREN);
 * return result;
 * }
 * widgets \= gtk_widget_observe_children $(LPAREN)widget$(RPAREN);
 * controllers \= gtk_map_list_model_new $(LPAREN)widgets,
 * map_to_controllers,
 * NULL, NULL$(RPAREN);
 * model \= gtk_flatten_list_model_new $(LPAREN)GTK_TYPE_EVENT_CONTROLLER,
 * controllers$(RPAREN);
 * ```
 * `GtkMapListModel` will attempt to discard the mapped objects as soon as
 * they are no longer needed and recreate them if necessary.
 * `GtkMapListModel` passes through sections from the underlying model.
 */
class MapListModel : ObjectG, ListModel, SectionModel
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
    return gtk_map_list_model_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin ListModelT!();
  mixin SectionModelT!();

  /**
   * Creates a new `GtkMapListModel` for the given arguments.
   * Params:
   *   model = The model to map
   *   mapFunc = map function
   * Returns: a new `GtkMapListModel`
   */
  this(ListModel model, MapListModelMapFunc mapFunc)
  {
    extern(C) ObjectC* _mapFuncCallback(ObjectC* item, void* userData)
    {
      ObjectG _dretval;
      auto _dlg = cast(MapListModelMapFunc*)userData;

      _dretval = (*_dlg)(item ? ObjectG.getDObject!ObjectG(cast(void*)item, true) : null);
      ObjectC* _retval = cast(ObjectC*)_dretval.cPtr(true);

      return _retval;
    }

    GtkMapListModel* _cretval;
    auto _mapFunc = freezeDelegate(cast(void*)&mapFunc);
    _cretval = gtk_map_list_model_new(model ? cast(GListModel*)(cast(ObjectG)model).cPtr(true) : null, &_mapFuncCallback, _mapFunc, &thawDelegate);
    this(_cretval, true);
  }

  /**
   * Gets the model that is currently being mapped or %NULL if none.
   * Returns: The model that gets mapped
   */
  ListModel getModel()
  {
    GListModel* _cretval;
    _cretval = gtk_map_list_model_get_model(cast(GtkMapListModel*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!ListModel(cast(GListModel*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Checks if a map function is currently set on self.
   * Returns: %TRUE if a map function is set
   */
  bool hasMap()
  {
    bool _retval;
    _retval = gtk_map_list_model_has_map(cast(GtkMapListModel*)cPtr);
    return _retval;
  }

  /**
   * Sets the function used to map items.
   * The function will be called whenever an item needs to be mapped
   * and must return the item to use for the given input item.
   * Note that `GtkMapListModel` may call this function multiple times
   * on the same item, because it may delete items it doesn't need anymore.
   * GTK makes no effort to ensure that map_func conforms to the item type
   * of self. It assumes that the caller knows what they are doing and the map
   * function returns items of the appropriate type.
   * Params:
   *   mapFunc = map function
   */
  void setMapFunc(MapListModelMapFunc mapFunc)
  {
    extern(C) ObjectC* _mapFuncCallback(ObjectC* item, void* userData)
    {
      ObjectG _dretval;
      auto _dlg = cast(MapListModelMapFunc*)userData;

      _dretval = (*_dlg)(item ? ObjectG.getDObject!ObjectG(cast(void*)item, true) : null);
      ObjectC* _retval = cast(ObjectC*)_dretval.cPtr(true);

      return _retval;
    }

    auto _mapFunc = freezeDelegate(cast(void*)&mapFunc);
    gtk_map_list_model_set_map_func(cast(GtkMapListModel*)cPtr, &_mapFuncCallback, _mapFunc, &thawDelegate);
  }

  /**
   * Sets the model to be mapped.
   * GTK makes no effort to ensure that model conforms to the item type
   * expected by the map function. It assumes that the caller knows what
   * they are doing and have set up an appropriate map function.
   * Params:
   *   model = The model to be mapped
   */
  void setModel(ListModel model)
  {
    gtk_map_list_model_set_model(cast(GtkMapListModel*)cPtr, model ? cast(GListModel*)(cast(ObjectG)model).cPtr(false) : null);
  }
}
