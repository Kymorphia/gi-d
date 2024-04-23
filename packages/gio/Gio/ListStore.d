module Gio.ListStore;

import GLib.Types;
import GObject.ObjectG;
import GObject.Types;
import Gid.Gid;
import Gio.ListModel;
import Gio.ListModelT;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * #GListStore is a simple implementation of #GListModel that stores all
 * items in memory.
 *
 * It provides insertions, deletions, and lookups in logarithmic time
 * with a fast path for the common case of iterating the list linearly.
 */
class ListStore : ObjectG, ListModel
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_list_store_get_type();
  }

  mixin ListModelT!GListStore;

  /**
   * a new #GListStore
   */
  this(GType itemType)
  {
    GListStore* _cretval;
    _cretval = g_list_store_new(itemType);
    this(_cretval, true);
  }

  /**
   * Appends @item to @store. @item must be of type #GListStore:item-type.
   *
   * This function takes a ref on @item.
   *
   * Use g_list_store_splice() to append multiple items at the same time
   * efficiently.
   */
  void append(ObjectG item)
  {
    g_list_store_append(cPtr!GListStore, item ? item.cPtr!ObjectC : null);
  }

  /**
   * Whether @store contains @item. If it was found, @position will be
   * set to the position where @item occurred for the first time.
   */
  bool find(ObjectG item, out uint position)
  {
    bool _retval;
    _retval = g_list_store_find(cPtr!GListStore, item ? item.cPtr!ObjectC : null, cast(uint*)&position);
    return _retval;
  }

  /**
   * Whether @store contains @item. If it was found, @position will be
   * set to the position where @item occurred for the first time.
   */
  bool findWithEqualFunc(ObjectG item, EqualFunc equalFunc, out uint position)
  {
    static EqualFunc _static_equalFunc;

    extern(C) bool _equalFuncCallback(const(void)* a, const(void)* b)
    {
      bool _retval = _static_equalFunc(a, b);
      return _retval;
    }

    _static_equalFunc = equalFunc;
    bool _retval;
    _retval = g_list_store_find_with_equal_func(cPtr!GListStore, item ? item.cPtr!ObjectC : null, &_equalFuncCallback, cast(uint*)&position);
    _static_equalFunc = null;
    return _retval;
  }

  /**
   * Whether @store contains @item. If it was found, @position will be
   * set to the position where @item occurred for the first time.
   */
  bool findWithEqualFuncFull(ObjectG item, EqualFuncFull equalFunc, out uint position)
  {
    static EqualFuncFull _static_equalFunc;

    extern(C) bool _equalFuncCallback(const(void)* a, const(void)* b, void* userData)
    {
      bool _retval = _static_equalFunc(a, b);
      return _retval;
    }

    _static_equalFunc = equalFunc;
    bool _retval;
    ptrFreezeGC(cast(void*)&equalFunc);
    _retval = g_list_store_find_with_equal_func_full(cPtr!GListStore, item ? item.cPtr!ObjectC : null, &_equalFuncCallback, cast(void*)&equalFunc, cast(uint*)&position);
    _static_equalFunc = null;
    return _retval;
  }

  /**
   * Inserts @item into @store at @position. @item must be of type
   * #GListStore:item-type or derived from it. @position must be smaller
   * than the length of the list, or equal to it to append.
   *
   * This function takes a ref on @item.
   *
   * Use g_list_store_splice() to insert multiple items at the same time
   * efficiently.
   */
  void insert(uint position, ObjectG item)
  {
    g_list_store_insert(cPtr!GListStore, position, item ? item.cPtr!ObjectC : null);
  }

  /**
   * the position at which @item was inserted
   */
  uint insertSorted(ObjectG item, CompareDataFunc compareFunc)
  {
    static CompareDataFunc _static_compareFunc;

    extern(C) int _compareFuncCallback(const(void)* a, const(void)* b, void* userData)
    {
      int _retval = _static_compareFunc(a, b);
      return _retval;
    }

    _static_compareFunc = compareFunc;
    uint _retval;
    ptrFreezeGC(cast(void*)&compareFunc);
    _retval = g_list_store_insert_sorted(cPtr!GListStore, item ? item.cPtr!ObjectC : null, &_compareFuncCallback, cast(void*)&compareFunc);
    _static_compareFunc = null;
    return _retval;
  }

  /**
   * Removes the item from @store that is at @position. @position must be
   * smaller than the current length of the list.
   *
   * Use g_list_store_splice() to remove multiple items at the same time
   * efficiently.
   */
  void remove(uint position)
  {
    g_list_store_remove(cPtr!GListStore, position);
  }

  /**
   * Removes all items from @store.
   */
  void removeAll()
  {
    g_list_store_remove_all(cPtr!GListStore);
  }

  /**
   * Sort the items in @store according to @compare_func.
   */
  void sort(CompareDataFunc compareFunc)
  {
    static CompareDataFunc _static_compareFunc;

    extern(C) int _compareFuncCallback(const(void)* a, const(void)* b, void* userData)
    {
      int _retval = _static_compareFunc(a, b);
      return _retval;
    }

    _static_compareFunc = compareFunc;
    ptrFreezeGC(cast(void*)&compareFunc);
    g_list_store_sort(cPtr!GListStore, &_compareFuncCallback, cast(void*)&compareFunc);
    _static_compareFunc = null;
  }

  /**
   * Changes @store by removing @n_removals items and adding @n_additions
   * items to it. @additions must contain @n_additions items of type
   * #GListStore:item-type.  %NULL is not permitted.
   *
   * This function is more efficient than g_list_store_insert() and
   * g_list_store_remove(), because it only emits
   * #GListModel::items-changed once for the change.
   *
   * This function takes a ref on each item in @additions.
   *
   * The parameters @position and @n_removals must be correct (ie:
   * @position + @n_removals must be less than or equal to the length of
   * the list at the time this function is called).
   */
  void splice(uint position, uint nRemovals, ObjectG[] additions)
  {
    ObjectC*[] _tmpadditions;
    foreach (obj; additions)
      _tmpadditions ~= obj ? obj.cPtr!ObjectC : null;
    void** _additions = cast(void**)_tmpadditions.ptr;
    g_list_store_splice(cPtr!GListStore, position, nRemovals, _additions, additions ? cast(uint)additions.length : 0);
  }
}
