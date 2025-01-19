module Gtk.SortListModel;

import GObject.ObjectG;
import Gid.gid;
import Gio.ListModel;
import Gio.ListModelT;
import Gtk.SectionModel;
import Gtk.SectionModelT;
import Gtk.Sorter;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * A `GListModel` that sorts the elements of an underlying model
 * according to a `GtkSorter`.
 * The model is a stable sort. If two items compare equal according
 * to the sorter, the one that appears first in the original model will
 * also appear first after sorting.
 * Note that if you change the sorter, the previous order will have no
 * influence on the new order. If you want that, consider using a
 * `GtkMultiSorter` and appending the previous sorter to it.
 * The model can be set up to do incremental sorting, so that
 * sorting long lists doesn't block the UI. See
 * [Gtk.SortListModel.setIncremental] for details.
 * `GtkSortListModel` is a generic model and because of that it
 * cannot take advantage of any external knowledge when sorting.
 * If you run into performance issues with `GtkSortListModel`,
 * it is strongly recommended that you write your own sorting list
 * model.
 * `GtkSortListModel` allows sorting the items into sections. It
 * implements `GtkSectionModel` and when property@Gtk.SortListModel:section-sorter
 * is set, it will sort all items with that sorter and items comparing
 * equal with it will be put into the same section.
 * The [Gtk.SortListModel.sorter] will then be used to sort items
 * inside their sections.
 */
class SortListModel : ObjectG, ListModel, SectionModel
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
    return gtk_sort_list_model_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin ListModelT!();
  mixin SectionModelT!();

  /**
   * Creates a new sort list model that uses the sorter to sort model.
   * Params:
   *   model = the model to sort
   *   sorter = the `GtkSorter` to sort model with,
   * Returns: a new `GtkSortListModel`
   */
  this(ListModel model, Sorter sorter)
  {
    GtkSortListModel* _cretval;
    _cretval = gtk_sort_list_model_new(model ? cast(GListModel*)(cast(ObjectG)model).cPtr(true) : null, sorter ? cast(GtkSorter*)sorter.cPtr(true) : null);
    this(_cretval, true);
  }

  /**
   * Returns whether incremental sorting is enabled.
   * See [Gtk.SortListModel.setIncremental].
   * Returns: %TRUE if incremental sorting is enabled
   */
  bool getIncremental()
  {
    bool _retval;
    _retval = gtk_sort_list_model_get_incremental(cast(GtkSortListModel*)cPtr);
    return _retval;
  }

  /**
   * Gets the model currently sorted or %NULL if none.
   * Returns: The model that gets sorted
   */
  ListModel getModel()
  {
    GListModel* _cretval;
    _cretval = gtk_sort_list_model_get_model(cast(GtkSortListModel*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!ListModel(cast(GListModel*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Estimates progress of an ongoing sorting operation.
   * The estimate is the number of items that would still need to be
   * sorted to finish the sorting operation if this was a linear
   * algorithm. So this number is not related to how many items are
   * already correctly sorted.
   * If you want to estimate the progress, you can use code like this:
   * ```c
   * pending \= gtk_sort_list_model_get_pending $(LPAREN)self$(RPAREN);
   * model \= gtk_sort_list_model_get_model $(LPAREN)self$(RPAREN);
   * progress \= 1.0 - pending / $(LPAREN)double$(RPAREN) MAX $(LPAREN)1, g_list_model_get_n_items $(LPAREN)model$(RPAREN)$(RPAREN);
   * ```
   * If no sort operation is ongoing - in particular when
   * [Gtk.SortListModel.incremental] is %FALSE - this
   * function returns 0.
   * Returns: a progress estimate of remaining items to sort
   */
  uint getPending()
  {
    uint _retval;
    _retval = gtk_sort_list_model_get_pending(cast(GtkSortListModel*)cPtr);
    return _retval;
  }

  /**
   * Gets the section sorter that is used to sort items of self into
   * sections.
   * Returns: the sorter of #self
   */
  Sorter getSectionSorter()
  {
    GtkSorter* _cretval;
    _cretval = gtk_sort_list_model_get_section_sorter(cast(GtkSortListModel*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Sorter(cast(GtkSorter*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the sorter that is used to sort self.
   * Returns: the sorter of #self
   */
  Sorter getSorter()
  {
    GtkSorter* _cretval;
    _cretval = gtk_sort_list_model_get_sorter(cast(GtkSortListModel*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Sorter(cast(GtkSorter*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Sets the sort model to do an incremental sort.
   * When incremental sorting is enabled, the `GtkSortListModel` will not do
   * a complete sort immediately, but will instead queue an idle handler that
   * incrementally sorts the items towards their correct position. This of
   * course means that items do not instantly appear in the right place. It
   * also means that the total sorting time is a lot slower.
   * When your filter blocks the UI while sorting, you might consider
   * turning this on. Depending on your model and sorters, this may become
   * interesting around 10,000 to 100,000 items.
   * By default, incremental sorting is disabled.
   * See [Gtk.SortListModel.getPending] for progress information
   * about an ongoing incremental sorting operation.
   * Params:
   *   incremental = %TRUE to sort incrementally
   */
  void setIncremental(bool incremental)
  {
    gtk_sort_list_model_set_incremental(cast(GtkSortListModel*)cPtr, incremental);
  }

  /**
   * Sets the model to be sorted.
   * The model's item type must conform to the item type of self.
   * Params:
   *   model = The model to be sorted
   */
  void setModel(ListModel model)
  {
    gtk_sort_list_model_set_model(cast(GtkSortListModel*)cPtr, model ? cast(GListModel*)(cast(ObjectG)model).cPtr(false) : null);
  }

  /**
   * Sets a new section sorter on self.
   * Params:
   *   sorter = the `GtkSorter` to sort model with
   */
  void setSectionSorter(Sorter sorter)
  {
    gtk_sort_list_model_set_section_sorter(cast(GtkSortListModel*)cPtr, sorter ? cast(GtkSorter*)sorter.cPtr(false) : null);
  }

  /**
   * Sets a new sorter on self.
   * Params:
   *   sorter = the `GtkSorter` to sort model with
   */
  void setSorter(Sorter sorter)
  {
    gtk_sort_list_model_set_sorter(cast(GtkSortListModel*)cPtr, sorter ? cast(GtkSorter*)sorter.cPtr(false) : null);
  }
}
