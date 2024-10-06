module Gtk.CustomSorter;

import Gid.gid;
import Gtk.Sorter;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkCustomSorter` is a `GtkSorter` implementation that sorts via a callback
 * function.
 */
class CustomSorter : Sorter
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
    return gtk_custom_sorter_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }
  import GObject.ObjectG;

  // Define a sort delegate that takes ObjectG objects, instead of the CompareDataFunc which is passed raw ObjectC pointers
  alias CustomSortDelegate = int delegate(ObjectG aObj, ObjectG bObj);

  /**
   * Creates a new `GtkSorter` that works by calling
   * sortFunc to compare items.
   * If sortFunc is null, all items are considered equal.
   * Params:
   *   sortFunc = the callback delegate to use for sorting
   * Returns: a new `CustomSorter`
   */
  this(CustomSortDelegate sortFunc)
  {
    extern(C) int _sortFuncCallback(const(void)* a, const(void)* b, void* userData)
    {
      auto _dlg = cast(CustomSortDelegate*)userData;
      auto aObj = cast(ObjectC*)a;
      auto bObj = cast(ObjectC*)b;

      int _retval = (*_dlg)(ObjectG.getDObject!ObjectG(aObj), ObjectG.getDObject!ObjectG(bObj));
      return _retval;
    }

    GtkCustomSorter* _cretval;
    auto _sortFunc = freezeDelegate(cast(void*)&sortFunc);
    _cretval = gtk_custom_sorter_new(&_sortFuncCallback, _sortFunc, &thawDelegate);
    this(_cretval, true);
  }

  /**
   * Sets $(LPAREN)or unsets$(RPAREN) the function used for sorting items.
   * If sort_func is %NULL, all items are considered equal.
   * If the sort func changes its sorting behavior,
   * [Gtk.Sorter.changed] needs to be called.
   * If a previous function was set, its user_destroy will be
   * called now.
   * Params:
   *   sortFunc = function to sort items
   */
  void setSortFunc(CustomSortDelegate sortFunc)
  {
    extern(C) int _sortFuncCallback(const(void)* a, const(void)* b, void* userData)
    {
      auto _dlg = cast(CustomSortDelegate*)userData;
      auto aObj = cast(ObjectC*)a;
      auto bObj = cast(ObjectC*)b;

      int _retval = (*_dlg)(ObjectG.getDObject!ObjectG(aObj), ObjectG.getDObject!ObjectG(bObj));
      return _retval;
    }

    auto _sortFunc = freezeDelegate(cast(void*)&sortFunc);
    gtk_custom_sorter_set_sort_func(cast(GtkCustomSorter*)cPtr, &_sortFuncCallback, _sortFunc, &thawDelegate);
  }
}
