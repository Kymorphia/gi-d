module Gtk.FilterListModel;

import GObject.ObjectG;
import Gid.gid;
import Gio.ListModel;
import Gio.ListModelT;
import Gtk.Filter;
import Gtk.SectionModel;
import Gtk.SectionModelT;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkFilterListModel` is a list model that filters the elements of
 * the underlying model according to a `GtkFilter`.
 * It hides some elements from the other model according to
 * criteria given by a `GtkFilter`.
 * The model can be set up to do incremental filtering, so that
 * filtering long lists doesn't block the UI. See
 * [Gtk.FilterListModel.setIncremental] for details.
 * `GtkFilterListModel` passes through sections from the underlying model.
 */
class FilterListModel : ObjectG, ListModel, SectionModel
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
    return gtk_filter_list_model_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin ListModelT!GtkFilterListModel;
  mixin SectionModelT!GtkFilterListModel;

  /**
   * Creates a new `GtkFilterListModel` that will filter model using the given
   * filter.
   * Params:
   *   model = the model to sort
   *   filter = filter
   * Returns: a new `GtkFilterListModel`
   */
  this(ListModel model, Filter filter)
  {
    GtkFilterListModel* _cretval;
    _cretval = gtk_filter_list_model_new(model ? cast(GListModel*)(cast(ObjectG)model).cPtr(true) : null, filter ? cast(GtkFilter*)filter.cPtr(true) : null);
    this(_cretval, true);
  }

  /**
   * Gets the `GtkFilter` currently set on self.
   * Returns: The filter currently in use
   */
  Filter getFilter()
  {
    GtkFilter* _cretval;
    _cretval = gtk_filter_list_model_get_filter(cast(GtkFilterListModel*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Filter(cast(GtkFilter*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns whether incremental filtering is enabled.
   * See [Gtk.FilterListModel.setIncremental].
   * Returns: %TRUE if incremental filtering is enabled
   */
  bool getIncremental()
  {
    bool _retval;
    _retval = gtk_filter_list_model_get_incremental(cast(GtkFilterListModel*)cPtr);
    return _retval;
  }

  /**
   * Gets the model currently filtered or %NULL if none.
   * Returns: The model that gets filtered
   */
  ListModel getModel()
  {
    GListModel* _cretval;
    _cretval = gtk_filter_list_model_get_model(cast(GtkFilterListModel*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!ListModel(cast(GListModel*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns the number of items that have not been filtered yet.
   * You can use this value to check if self is busy filtering by
   * comparing the return value to 0 or you can compute the percentage
   * of the filter remaining by dividing the return value by the total
   * number of items in the underlying model:
   * ```c
   * pending \= gtk_filter_list_model_get_pending $(LPAREN)self$(RPAREN);
   * model \= gtk_filter_list_model_get_model $(LPAREN)self$(RPAREN);
   * percentage \= pending / $(LPAREN)double$(RPAREN) g_list_model_get_n_items $(LPAREN)model$(RPAREN);
   * ```
   * If no filter operation is ongoing - in particular when
   * [Gtk.FilterListModel.incremental] is %FALSE - this
   * function returns 0.
   * Returns: The number of items not yet filtered
   */
  uint getPending()
  {
    uint _retval;
    _retval = gtk_filter_list_model_get_pending(cast(GtkFilterListModel*)cPtr);
    return _retval;
  }

  /**
   * Sets the filter used to filter items.
   * Params:
   *   filter = filter to use
   */
  void setFilter(Filter filter)
  {
    gtk_filter_list_model_set_filter(cast(GtkFilterListModel*)cPtr, filter ? cast(GtkFilter*)filter.cPtr(false) : null);
  }

  /**
   * Sets the filter model to do an incremental sort.
   * When incremental filtering is enabled, the `GtkFilterListModel` will not
   * run filters immediately, but will instead queue an idle handler that
   * incrementally filters the items and adds them to the list. This of course
   * means that items are not instantly added to the list, but only appear
   * incrementally.
   * When your filter blocks the UI while filtering, you might consider
   * turning this on. Depending on your model and filters, this may become
   * interesting around 10,000 to 100,000 items.
   * By default, incremental filtering is disabled.
   * See [Gtk.FilterListModel.getPending] for progress information
   * about an ongoing incremental filtering operation.
   * Params:
   *   incremental = %TRUE to enable incremental filtering
   */
  void setIncremental(bool incremental)
  {
    gtk_filter_list_model_set_incremental(cast(GtkFilterListModel*)cPtr, incremental);
  }

  /**
   * Sets the model to be filtered.
   * Note that GTK makes no effort to ensure that model conforms to
   * the item type of self. It assumes that the caller knows what they
   * are doing and have set up an appropriate filter to ensure that item
   * types match.
   * Params:
   *   model = The model to be filtered
   */
  void setModel(ListModel model)
  {
    gtk_filter_list_model_set_model(cast(GtkFilterListModel*)cPtr, model ? cast(GListModel*)(cast(ObjectG)model).cPtr(false) : null);
  }
}
