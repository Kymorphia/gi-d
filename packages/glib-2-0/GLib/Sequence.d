module GLib.Sequence;

import GLib.SequenceIter;
import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.gid;

/**
 * The #GSequence struct is an opaque data type representing a
 * [sequence][glib-Sequences] data type.
 */
class Sequence
{
  GSequence* cInstancePtr;
  bool owned;

  this(void* ptr, bool owned = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for GLib.Sequence");

    cInstancePtr = cast(GSequence*)ptr;

    this.owned = owned;
  }

  ~this()
  {
    if (owned)
      g_sequence_free(cInstancePtr);
  }

  void* cPtr()
  {
    return cast(void*)cInstancePtr;
  }

  /**
   * Adds a new item to the end of seq.
   * Params:
   *   data = the data for the new item
   * Returns: an iterator pointing to the new item
   */
  SequenceIter append(void* data)
  {
    GSequenceIter* _cretval;
    _cretval = g_sequence_append(cast(GSequence*)cPtr, data);
    auto _retval = _cretval ? new SequenceIter(cast(GSequenceIter*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Calls func for each item in the sequence passing user_data
   * to the function. func must not modify the sequence itself.
   * Params:
   *   func = the function to call for each item in seq
   */
  void foreach_(Func func)
  {
    extern(C) void _funcCallback(void* data, void* userData)
    {
      auto _dlg = cast(Func*)userData;

      (*_dlg)(data);
    }

    auto _func = cast(void*)&func;
    g_sequence_foreach(cast(GSequence*)cPtr, &_funcCallback, _func);
  }

  /**
   * Returns the begin iterator for seq.
   * Returns: the begin iterator for seq.
   */
  SequenceIter getBeginIter()
  {
    GSequenceIter* _cretval;
    _cretval = g_sequence_get_begin_iter(cast(GSequence*)cPtr);
    auto _retval = _cretval ? new SequenceIter(cast(GSequenceIter*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns the end iterator for seg
   * Returns: the end iterator for seq
   */
  SequenceIter getEndIter()
  {
    GSequenceIter* _cretval;
    _cretval = g_sequence_get_end_iter(cast(GSequence*)cPtr);
    auto _retval = _cretval ? new SequenceIter(cast(GSequenceIter*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns the iterator at position pos. If pos is negative or larger
   * than the number of items in seq, the end iterator is returned.
   * Params:
   *   pos = a position in seq, or -1 for the end
   * Returns: The #GSequenceIter at position pos
   */
  SequenceIter getIterAtPos(int pos)
  {
    GSequenceIter* _cretval;
    _cretval = g_sequence_get_iter_at_pos(cast(GSequence*)cPtr, pos);
    auto _retval = _cretval ? new SequenceIter(cast(GSequenceIter*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns the positive length $(LPAREN)>\= 0$(RPAREN) of seq. Note that this method is
   * O$(LPAREN)h$(RPAREN) where `h' is the height of the tree. It is thus more efficient
   * to use [GLib.Sequence.isEmpty] when comparing the length to zero.
   * Returns: the length of seq
   */
  int getLength()
  {
    int _retval;
    _retval = g_sequence_get_length(cast(GSequence*)cPtr);
    return _retval;
  }

  /**
   * Inserts data into seq using cmp_func to determine the new
   * position. The sequence must already be sorted according to cmp_func;
   * otherwise the new position of data is undefined.
   * cmp_func is called with two items of the seq, and cmp_data.
   * It should return 0 if the items are equal, a negative value
   * if the first item comes before the second, and a positive value
   * if the second item comes before the first.
   * Note that when adding a large amount of data to a #GSequence,
   * it is more efficient to do unsorted insertions and then call
   * [GLib.Sequence.sort] or [GLib.Sequence.sortIter].
   * Params:
   *   data = the data to insert
   *   cmpFunc = the function used to compare items in the sequence
   * Returns: a #GSequenceIter pointing to the new item.
   */
  SequenceIter insertSorted(void* data, CompareDataFunc cmpFunc)
  {
    extern(C) int _cmpFuncCallback(const(void)* a, const(void)* b, void* userData)
    {
      auto _dlg = cast(CompareDataFunc*)userData;

      int _retval = (*_dlg)(a, b);
      return _retval;
    }

    GSequenceIter* _cretval;
    auto _cmpFunc = cast(void*)&cmpFunc;
    _cretval = g_sequence_insert_sorted(cast(GSequence*)cPtr, data, &_cmpFuncCallback, _cmpFunc);
    auto _retval = _cretval ? new SequenceIter(cast(GSequenceIter*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Like [GLib.Sequence.insertSorted], but uses
   * a #GSequenceIterCompareFunc instead of a #GCompareDataFunc as
   * the compare function.
   * iter_cmp is called with two iterators pointing into seq.
   * It should return 0 if the iterators are equal, a negative
   * value if the first iterator comes before the second, and a
   * positive value if the second iterator comes before the first.
   * Note that when adding a large amount of data to a #GSequence,
   * it is more efficient to do unsorted insertions and then call
   * [GLib.Sequence.sort] or [GLib.Sequence.sortIter].
   * Params:
   *   data = data for the new item
   *   iterCmp = the function used to compare iterators in the sequence
   * Returns: a #GSequenceIter pointing to the new item
   */
  SequenceIter insertSortedIter(void* data, SequenceIterCompareFunc iterCmp)
  {
    extern(C) int _iterCmpCallback(GSequenceIter* a, GSequenceIter* b, void* data)
    {
      auto _dlg = cast(SequenceIterCompareFunc*)data;

      int _retval = (*_dlg)(a ? new SequenceIter(cast(void*)a, false) : null, b ? new SequenceIter(cast(void*)b, false) : null);
      return _retval;
    }

    GSequenceIter* _cretval;
    auto _iterCmp = cast(void*)&iterCmp;
    _cretval = g_sequence_insert_sorted_iter(cast(GSequence*)cPtr, data, &_iterCmpCallback, _iterCmp);
    auto _retval = _cretval ? new SequenceIter(cast(GSequenceIter*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns %TRUE if the sequence contains zero items.
   * This function is functionally identical to checking the result of
   * [GLib.Sequence.getLength] being equal to zero. However this function is
   * implemented in O$(LPAREN)1$(RPAREN) running time.
   * Returns: %TRUE if the sequence is empty, otherwise %FALSE.
   */
  bool isEmpty()
  {
    bool _retval;
    _retval = g_sequence_is_empty(cast(GSequence*)cPtr);
    return _retval;
  }

  /**
   * Returns an iterator pointing to the position of the first item found
   * equal to data according to cmp_func and cmp_data. If more than one
   * item is equal, it is not guaranteed that it is the first which is
   * returned. In that case, you can use [GLib.SequenceIter.next] and
   * [GLib.SequenceIter.prev] to get others.
   * cmp_func is called with two items of the seq, and cmp_data.
   * It should return 0 if the items are equal, a negative value if
   * the first item comes before the second, and a positive value if
   * the second item comes before the first.
   * This function will fail if the data contained in the sequence is
   * unsorted.
   * Params:
   *   data = data to look up
   *   cmpFunc = the function used to compare items in the sequence
   * Returns: an #GSequenceIter pointing to the position of the
   *   first item found equal to data according to cmp_func and
   *   cmp_data, or %NULL if no such item exists
   */
  SequenceIter lookup(void* data, CompareDataFunc cmpFunc)
  {
    extern(C) int _cmpFuncCallback(const(void)* a, const(void)* b, void* userData)
    {
      auto _dlg = cast(CompareDataFunc*)userData;

      int _retval = (*_dlg)(a, b);
      return _retval;
    }

    GSequenceIter* _cretval;
    auto _cmpFunc = cast(void*)&cmpFunc;
    _cretval = g_sequence_lookup(cast(GSequence*)cPtr, data, &_cmpFuncCallback, _cmpFunc);
    auto _retval = _cretval ? new SequenceIter(cast(GSequenceIter*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Like [GLib.Sequence.lookup], but uses a #GSequenceIterCompareFunc
   * instead of a #GCompareDataFunc as the compare function.
   * iter_cmp is called with two iterators pointing into seq.
   * It should return 0 if the iterators are equal, a negative value
   * if the first iterator comes before the second, and a positive
   * value if the second iterator comes before the first.
   * This function will fail if the data contained in the sequence is
   * unsorted.
   * Params:
   *   data = data to look up
   *   iterCmp = the function used to compare iterators in the sequence
   * Returns: an #GSequenceIter pointing to the position of
   *   the first item found equal to data according to iter_cmp
   *   and cmp_data, or %NULL if no such item exists
   */
  SequenceIter lookupIter(void* data, SequenceIterCompareFunc iterCmp)
  {
    extern(C) int _iterCmpCallback(GSequenceIter* a, GSequenceIter* b, void* data)
    {
      auto _dlg = cast(SequenceIterCompareFunc*)data;

      int _retval = (*_dlg)(a ? new SequenceIter(cast(void*)a, false) : null, b ? new SequenceIter(cast(void*)b, false) : null);
      return _retval;
    }

    GSequenceIter* _cretval;
    auto _iterCmp = cast(void*)&iterCmp;
    _cretval = g_sequence_lookup_iter(cast(GSequence*)cPtr, data, &_iterCmpCallback, _iterCmp);
    auto _retval = _cretval ? new SequenceIter(cast(GSequenceIter*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Adds a new item to the front of seq
   * Params:
   *   data = the data for the new item
   * Returns: an iterator pointing to the new item
   */
  SequenceIter prepend(void* data)
  {
    GSequenceIter* _cretval;
    _cretval = g_sequence_prepend(cast(GSequence*)cPtr, data);
    auto _retval = _cretval ? new SequenceIter(cast(GSequenceIter*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns an iterator pointing to the position where data would
   * be inserted according to cmp_func and cmp_data.
   * cmp_func is called with two items of the seq, and cmp_data.
   * It should return 0 if the items are equal, a negative value if
   * the first item comes before the second, and a positive value if
   * the second item comes before the first.
   * If you are simply searching for an existing element of the sequence,
   * consider using [GLib.Sequence.lookup].
   * This function will fail if the data contained in the sequence is
   * unsorted.
   * Params:
   *   data = data for the new item
   *   cmpFunc = the function used to compare items in the sequence
   * Returns: an #GSequenceIter pointing to the position where data
   *   would have been inserted according to cmp_func and cmp_data
   */
  SequenceIter search(void* data, CompareDataFunc cmpFunc)
  {
    extern(C) int _cmpFuncCallback(const(void)* a, const(void)* b, void* userData)
    {
      auto _dlg = cast(CompareDataFunc*)userData;

      int _retval = (*_dlg)(a, b);
      return _retval;
    }

    GSequenceIter* _cretval;
    auto _cmpFunc = cast(void*)&cmpFunc;
    _cretval = g_sequence_search(cast(GSequence*)cPtr, data, &_cmpFuncCallback, _cmpFunc);
    auto _retval = _cretval ? new SequenceIter(cast(GSequenceIter*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Like [GLib.Sequence.search], but uses a #GSequenceIterCompareFunc
   * instead of a #GCompareDataFunc as the compare function.
   * iter_cmp is called with two iterators pointing into seq.
   * It should return 0 if the iterators are equal, a negative value
   * if the first iterator comes before the second, and a positive
   * value if the second iterator comes before the first.
   * If you are simply searching for an existing element of the sequence,
   * consider using [GLib.Sequence.lookupIter].
   * This function will fail if the data contained in the sequence is
   * unsorted.
   * Params:
   *   data = data for the new item
   *   iterCmp = the function used to compare iterators in the sequence
   * Returns: a #GSequenceIter pointing to the position in seq
   *   where data would have been inserted according to iter_cmp
   *   and cmp_data
   */
  SequenceIter searchIter(void* data, SequenceIterCompareFunc iterCmp)
  {
    extern(C) int _iterCmpCallback(GSequenceIter* a, GSequenceIter* b, void* data)
    {
      auto _dlg = cast(SequenceIterCompareFunc*)data;

      int _retval = (*_dlg)(a ? new SequenceIter(cast(void*)a, false) : null, b ? new SequenceIter(cast(void*)b, false) : null);
      return _retval;
    }

    GSequenceIter* _cretval;
    auto _iterCmp = cast(void*)&iterCmp;
    _cretval = g_sequence_search_iter(cast(GSequence*)cPtr, data, &_iterCmpCallback, _iterCmp);
    auto _retval = _cretval ? new SequenceIter(cast(GSequenceIter*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Sorts seq using cmp_func.
   * cmp_func is passed two items of seq and should
   * return 0 if they are equal, a negative value if the
   * first comes before the second, and a positive value
   * if the second comes before the first.
   * Params:
   *   cmpFunc = the function used to sort the sequence
   */
  void sort(CompareDataFunc cmpFunc)
  {
    extern(C) int _cmpFuncCallback(const(void)* a, const(void)* b, void* userData)
    {
      auto _dlg = cast(CompareDataFunc*)userData;

      int _retval = (*_dlg)(a, b);
      return _retval;
    }

    auto _cmpFunc = cast(void*)&cmpFunc;
    g_sequence_sort(cast(GSequence*)cPtr, &_cmpFuncCallback, _cmpFunc);
  }

  /**
   * Like [GLib.Sequence.sort], but uses a #GSequenceIterCompareFunc instead
   * of a #GCompareDataFunc as the compare function
   * cmp_func is called with two iterators pointing into seq. It should
   * return 0 if the iterators are equal, a negative value if the first
   * iterator comes before the second, and a positive value if the second
   * iterator comes before the first.
   * Params:
   *   cmpFunc = the function used to compare iterators in the sequence
   */
  void sortIter(SequenceIterCompareFunc cmpFunc)
  {
    extern(C) int _cmpFuncCallback(GSequenceIter* a, GSequenceIter* b, void* data)
    {
      auto _dlg = cast(SequenceIterCompareFunc*)data;

      int _retval = (*_dlg)(a ? new SequenceIter(cast(void*)a, false) : null, b ? new SequenceIter(cast(void*)b, false) : null);
      return _retval;
    }

    auto _cmpFunc = cast(void*)&cmpFunc;
    g_sequence_sort_iter(cast(GSequence*)cPtr, &_cmpFuncCallback, _cmpFunc);
  }

  /**
   * Calls func for each item in the range $(LPAREN)begin, end$(RPAREN) passing
   * user_data to the function. func must not modify the sequence
   * itself.
   * Params:
   *   begin = a #GSequenceIter
   *   end = a #GSequenceIter
   *   func = a #GFunc
   */
  static void foreachRange(SequenceIter begin, SequenceIter end, Func func)
  {
    extern(C) void _funcCallback(void* data, void* userData)
    {
      auto _dlg = cast(Func*)userData;

      (*_dlg)(data);
    }

    auto _func = cast(void*)&func;
    g_sequence_foreach_range(begin ? cast(GSequenceIter*)begin.cPtr : null, end ? cast(GSequenceIter*)end.cPtr : null, &_funcCallback, _func);
  }

  /**
   * Returns the data that iter points to.
   * Params:
   *   iter = a #GSequenceIter
   * Returns: the data that iter points to
   */
  static void* get(SequenceIter iter)
  {
    void* _retval;
    _retval = g_sequence_get(iter ? cast(GSequenceIter*)iter.cPtr : null);
    return _retval;
  }

  /**
   * Inserts a new item just before the item pointed to by iter.
   * Params:
   *   iter = a #GSequenceIter
   *   data = the data for the new item
   * Returns: an iterator pointing to the new item
   */
  static SequenceIter insertBefore(SequenceIter iter, void* data)
  {
    GSequenceIter* _cretval;
    _cretval = g_sequence_insert_before(iter ? cast(GSequenceIter*)iter.cPtr : null, data);
    auto _retval = _cretval ? new SequenceIter(cast(GSequenceIter*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Moves the item pointed to by src to the position indicated by dest.
   * After calling this function dest will point to the position immediately
   * after src. It is allowed for src and dest to point into different
   * sequences.
   * Params:
   *   src = a #GSequenceIter pointing to the item to move
   *   dest = a #GSequenceIter pointing to the position to which
   *     the item is moved
   */
  static void move(SequenceIter src, SequenceIter dest)
  {
    g_sequence_move(src ? cast(GSequenceIter*)src.cPtr : null, dest ? cast(GSequenceIter*)dest.cPtr : null);
  }

  /**
   * Inserts the $(LPAREN)begin, end$(RPAREN) range at the destination pointed to by dest.
   * The begin and end iters must point into the same sequence. It is
   * allowed for dest to point to a different sequence than the one pointed
   * into by begin and end.
   * If dest is %NULL, the range indicated by begin and end is
   * removed from the sequence. If dest points to a place within
   * the $(LPAREN)begin, end$(RPAREN) range, the range does not move.
   * Params:
   *   dest = a #GSequenceIter
   *   begin = a #GSequenceIter
   *   end = a #GSequenceIter
   */
  static void moveRange(SequenceIter dest, SequenceIter begin, SequenceIter end)
  {
    g_sequence_move_range(dest ? cast(GSequenceIter*)dest.cPtr : null, begin ? cast(GSequenceIter*)begin.cPtr : null, end ? cast(GSequenceIter*)end.cPtr : null);
  }

  /**
   * Finds an iterator somewhere in the range $(LPAREN)begin, end$(RPAREN). This
   * iterator will be close to the middle of the range, but is not
   * guaranteed to be exactly in the middle.
   * The begin and end iterators must both point to the same sequence
   * and begin must come before or be equal to end in the sequence.
   * Params:
   *   begin = a #GSequenceIter
   *   end = a #GSequenceIter
   * Returns: a #GSequenceIter pointing somewhere in the
   *   $(LPAREN)begin, end$(RPAREN) range
   */
  static SequenceIter rangeGetMidpoint(SequenceIter begin, SequenceIter end)
  {
    GSequenceIter* _cretval;
    _cretval = g_sequence_range_get_midpoint(begin ? cast(GSequenceIter*)begin.cPtr : null, end ? cast(GSequenceIter*)end.cPtr : null);
    auto _retval = _cretval ? new SequenceIter(cast(GSequenceIter*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Removes the item pointed to by iter. It is an error to pass the
   * end iterator to this function.
   * If the sequence has a data destroy function associated with it, this
   * function is called on the data for the removed item.
   * Params:
   *   iter = a #GSequenceIter
   */
  static void remove(SequenceIter iter)
  {
    g_sequence_remove(iter ? cast(GSequenceIter*)iter.cPtr : null);
  }

  /**
   * Removes all items in the $(LPAREN)begin, end$(RPAREN) range.
   * If the sequence has a data destroy function associated with it, this
   * function is called on the data for the removed items.
   * Params:
   *   begin = a #GSequenceIter
   *   end = a #GSequenceIter
   */
  static void removeRange(SequenceIter begin, SequenceIter end)
  {
    g_sequence_remove_range(begin ? cast(GSequenceIter*)begin.cPtr : null, end ? cast(GSequenceIter*)end.cPtr : null);
  }

  /**
   * Changes the data for the item pointed to by iter to be data. If
   * the sequence has a data destroy function associated with it, that
   * function is called on the existing data that iter pointed to.
   * Params:
   *   iter = a #GSequenceIter
   *   data = new data for the item
   */
  static void set(SequenceIter iter, void* data)
  {
    g_sequence_set(iter ? cast(GSequenceIter*)iter.cPtr : null, data);
  }

  /**
   * Moves the data pointed to by iter to a new position as indicated by
   * cmp_func. This
   * function should be called for items in a sequence already sorted according
   * to cmp_func whenever some aspect of an item changes so that cmp_func
   * may return different values for that item.
   * cmp_func is called with two items of the seq, and cmp_data.
   * It should return 0 if the items are equal, a negative value if
   * the first item comes before the second, and a positive value if
   * the second item comes before the first.
   * Params:
   *   iter = A #GSequenceIter
   *   cmpFunc = the function used to compare items in the sequence
   */
  static void sortChanged(SequenceIter iter, CompareDataFunc cmpFunc)
  {
    extern(C) int _cmpFuncCallback(const(void)* a, const(void)* b, void* userData)
    {
      auto _dlg = cast(CompareDataFunc*)userData;

      int _retval = (*_dlg)(a, b);
      return _retval;
    }

    auto _cmpFunc = cast(void*)&cmpFunc;
    g_sequence_sort_changed(iter ? cast(GSequenceIter*)iter.cPtr : null, &_cmpFuncCallback, _cmpFunc);
  }

  /**
   * Like [GLib.Sequence.sortChanged], but uses
   * a #GSequenceIterCompareFunc instead of a #GCompareDataFunc as
   * the compare function.
   * iter_cmp is called with two iterators pointing into the #GSequence that
   * iter points into. It should
   * return 0 if the iterators are equal, a negative value if the first
   * iterator comes before the second, and a positive value if the second
   * iterator comes before the first.
   * Params:
   *   iter = a #GSequenceIter
   *   iterCmp = the function used to compare iterators in the sequence
   */
  static void sortChangedIter(SequenceIter iter, SequenceIterCompareFunc iterCmp)
  {
    extern(C) int _iterCmpCallback(GSequenceIter* a, GSequenceIter* b, void* data)
    {
      auto _dlg = cast(SequenceIterCompareFunc*)data;

      int _retval = (*_dlg)(a ? new SequenceIter(cast(void*)a, false) : null, b ? new SequenceIter(cast(void*)b, false) : null);
      return _retval;
    }

    auto _iterCmp = cast(void*)&iterCmp;
    g_sequence_sort_changed_iter(iter ? cast(GSequenceIter*)iter.cPtr : null, &_iterCmpCallback, _iterCmp);
  }

  /**
   * Swaps the items pointed to by a and b. It is allowed for a and b
   * to point into difference sequences.
   * Params:
   *   a = a #GSequenceIter
   *   b = a #GSequenceIter
   */
  static void swap(SequenceIter a, SequenceIter b)
  {
    g_sequence_swap(a ? cast(GSequenceIter*)a.cPtr : null, b ? cast(GSequenceIter*)b.cPtr : null);
  }
}
