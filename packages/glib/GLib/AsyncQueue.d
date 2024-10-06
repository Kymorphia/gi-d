module GLib.AsyncQueue;

import GLib.TimeVal;
import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.gid;

/**
 * An opaque data structure which represents an asynchronous queue.
 * It should only be accessed through the `g_async_queue_*` functions.
 */
class AsyncQueue
{
  GAsyncQueue* cInstancePtr;
  bool owned;

  this(void* ptr, bool owned = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for GLib.AsyncQueue");

    cInstancePtr = cast(GAsyncQueue*)ptr;

    this.owned = owned;
  }

  ~this()
  {
    if (owned)
      g_async_queue_unref(cInstancePtr);
  }

  void* cPtr()
  {
    return cast(void*)cInstancePtr;
  }

  /**
   * Returns the length of the queue.
   * Actually this function returns the number of data items in
   * the queue minus the number of waiting threads, so a negative
   * value means waiting threads, and a positive value means available
   * entries in the queue. A return value of 0 could mean n entries
   * in the queue and n threads waiting. This can happen due to locking
   * of the queue or due to scheduling.
   * Returns: the length of the queue
   */
  int length()
  {
    int _retval;
    _retval = g_async_queue_length(cast(GAsyncQueue*)cPtr);
    return _retval;
  }

  /**
   * Returns the length of the queue.
   * Actually this function returns the number of data items in
   * the queue minus the number of waiting threads, so a negative
   * value means waiting threads, and a positive value means available
   * entries in the queue. A return value of 0 could mean n entries
   * in the queue and n threads waiting. This can happen due to locking
   * of the queue or due to scheduling.
   * This function must be called while holding the queue's lock.
   * Returns: the length of the queue.
   */
  int lengthUnlocked()
  {
    int _retval;
    _retval = g_async_queue_length_unlocked(cast(GAsyncQueue*)cPtr);
    return _retval;
  }

  /**
   * Acquires the queue's lock. If another thread is already
   * holding the lock, this call will block until the lock
   * becomes available.
   * Call [GLib.AsyncQueue.unlock] to drop the lock again.
   * While holding the lock, you can only call the
   * g_async_queue_*_unlocked$(LPAREN)$(RPAREN) functions on queue. Otherwise,
   * deadlock may occur.
   */
  void lock()
  {
    g_async_queue_lock(cast(GAsyncQueue*)cPtr);
  }

  /**
   * Pops data from the queue. If queue is empty, this function
   * blocks until data becomes available.
   * Returns: data from the queue
   */
  void* pop()
  {
    void* _retval;
    _retval = g_async_queue_pop(cast(GAsyncQueue*)cPtr);
    return _retval;
  }

  /**
   * Pops data from the queue. If queue is empty, this function
   * blocks until data becomes available.
   * This function must be called while holding the queue's lock.
   * Returns: data from the queue.
   */
  void* popUnlocked()
  {
    void* _retval;
    _retval = g_async_queue_pop_unlocked(cast(GAsyncQueue*)cPtr);
    return _retval;
  }

  /**
   * Pushes the data into the queue.
   * The data parameter must not be %NULL.
   * Params:
   *   data = data to push onto the queue
   */
  void push(void* data)
  {
    g_async_queue_push(cast(GAsyncQueue*)cPtr, data);
  }

  /**
   * Pushes the item into the queue. item must not be %NULL.
   * In contrast to [GLib.AsyncQueue.push], this function
   * pushes the new item ahead of the items already in the queue,
   * so that it will be the next one to be popped off the queue.
   * Params:
   *   item = data to push into the queue
   */
  void pushFront(void* item)
  {
    g_async_queue_push_front(cast(GAsyncQueue*)cPtr, item);
  }

  /**
   * Pushes the item into the queue. item must not be %NULL.
   * In contrast to [GLib.AsyncQueue.pushUnlocked], this function
   * pushes the new item ahead of the items already in the queue,
   * so that it will be the next one to be popped off the queue.
   * This function must be called while holding the queue's lock.
   * Params:
   *   item = data to push into the queue
   */
  void pushFrontUnlocked(void* item)
  {
    g_async_queue_push_front_unlocked(cast(GAsyncQueue*)cPtr, item);
  }

  /**
   * Inserts data into queue using func to determine the new
   * position.
   * This function requires that the queue is sorted before pushing on
   * new elements, see [GLib.AsyncQueue.sort].
   * This function will lock queue before it sorts the queue and unlock
   * it when it is finished.
   * For an example of func see [GLib.AsyncQueue.sort].
   * Params:
   *   data = the data to push into the queue
   *   func = the #GCompareDataFunc is used to sort queue
   */
  void pushSorted(void* data, CompareDataFunc func)
  {
    static CompareDataFunc _static_func;

    extern(C) int _funcCallback(const(void)* a, const(void)* b, void* userData)
    {
      int _retval = _static_func(a, b);
      return _retval;
    }

    _static_func = func;
    auto _func = freezeDelegate(cast(void*)&func);
    g_async_queue_push_sorted(cast(GAsyncQueue*)cPtr, data, &_funcCallback, _func);
    _static_func = null;
  }

  /**
   * Inserts data into queue using func to determine the new
   * position.
   * The sort function func is passed two elements of the queue.
   * It should return 0 if they are equal, a negative value if the
   * first element should be higher in the queue or a positive value
   * if the first element should be lower in the queue than the second
   * element.
   * This function requires that the queue is sorted before pushing on
   * new elements, see [GLib.AsyncQueue.sort].
   * This function must be called while holding the queue's lock.
   * For an example of func see [GLib.AsyncQueue.sort].
   * Params:
   *   data = the data to push into the queue
   *   func = the #GCompareDataFunc is used to sort queue
   */
  void pushSortedUnlocked(void* data, CompareDataFunc func)
  {
    static CompareDataFunc _static_func;

    extern(C) int _funcCallback(const(void)* a, const(void)* b, void* userData)
    {
      int _retval = _static_func(a, b);
      return _retval;
    }

    _static_func = func;
    auto _func = freezeDelegate(cast(void*)&func);
    g_async_queue_push_sorted_unlocked(cast(GAsyncQueue*)cPtr, data, &_funcCallback, _func);
    _static_func = null;
  }

  /**
   * Pushes the data into the queue.
   * The data parameter must not be %NULL.
   * This function must be called while holding the queue's lock.
   * Params:
   *   data = data to push onto the queue
   */
  void pushUnlocked(void* data)
  {
    g_async_queue_push_unlocked(cast(GAsyncQueue*)cPtr, data);
  }

  /**
   * Increases the reference count of the asynchronous queue by 1.

   * Deprecated: Reference counting is done atomically.
   *   so [GLib.AsyncQueue.ref_] can be used regardless of the queue's
   *   lock.
   */
  void refUnlocked()
  {
    g_async_queue_ref_unlocked(cast(GAsyncQueue*)cPtr);
  }

  /**
   * Remove an item from the queue.
   * Params:
   *   item = the data to remove from the queue
   * Returns: %TRUE if the item was removed
   */
  bool remove(void* item)
  {
    bool _retval;
    _retval = g_async_queue_remove(cast(GAsyncQueue*)cPtr, item);
    return _retval;
  }

  /**
   * Remove an item from the queue.
   * This function must be called while holding the queue's lock.
   * Params:
   *   item = the data to remove from the queue
   * Returns: %TRUE if the item was removed
   */
  bool removeUnlocked(void* item)
  {
    bool _retval;
    _retval = g_async_queue_remove_unlocked(cast(GAsyncQueue*)cPtr, item);
    return _retval;
  }

  /**
   * Sorts queue using func.
   * The sort function func is passed two elements of the queue.
   * It should return 0 if they are equal, a negative value if the
   * first element should be higher in the queue or a positive value
   * if the first element should be lower in the queue than the second
   * element.
   * This function will lock queue before it sorts the queue and unlock
   * it when it is finished.
   * If you were sorting a list of priority numbers to make sure the
   * lowest priority would be at the top of the queue, you could use:
   * |[<!-- language\="C" -->
   * gint32 id1;
   * gint32 id2;
   * id1 \= GPOINTER_TO_INT $(LPAREN)element1$(RPAREN);
   * id2 \= GPOINTER_TO_INT $(LPAREN)element2$(RPAREN);
   * return $(LPAREN)id1 > id2 ? +1 : id1 \=\= id2 ? 0 : -1$(RPAREN);
   * ]|
   * Params:
   *   func = the #GCompareDataFunc is used to sort queue
   */
  void sort(CompareDataFunc func)
  {
    static CompareDataFunc _static_func;

    extern(C) int _funcCallback(const(void)* a, const(void)* b, void* userData)
    {
      int _retval = _static_func(a, b);
      return _retval;
    }

    _static_func = func;
    auto _func = freezeDelegate(cast(void*)&func);
    g_async_queue_sort(cast(GAsyncQueue*)cPtr, &_funcCallback, _func);
    _static_func = null;
  }

  /**
   * Sorts queue using func.
   * The sort function func is passed two elements of the queue.
   * It should return 0 if they are equal, a negative value if the
   * first element should be higher in the queue or a positive value
   * if the first element should be lower in the queue than the second
   * element.
   * This function must be called while holding the queue's lock.
   * Params:
   *   func = the #GCompareDataFunc is used to sort queue
   */
  void sortUnlocked(CompareDataFunc func)
  {
    static CompareDataFunc _static_func;

    extern(C) int _funcCallback(const(void)* a, const(void)* b, void* userData)
    {
      int _retval = _static_func(a, b);
      return _retval;
    }

    _static_func = func;
    auto _func = freezeDelegate(cast(void*)&func);
    g_async_queue_sort_unlocked(cast(GAsyncQueue*)cPtr, &_funcCallback, _func);
    _static_func = null;
  }

  /**
   * Pops data from the queue. If the queue is empty, blocks until
   * end_time or until data becomes available.
   * If no data is received before end_time, %NULL is returned.
   * To easily calculate end_time, a combination of [GLib.Global.getRealTime]
   * and [GLib.TimeVal.add] can be used.
   * Params:
   *   endTime = a #GTimeVal, determining the final time
   * Returns: data from the queue or %NULL, when no data is
   *   received before end_time.

   * Deprecated: use [GLib.AsyncQueue.timeoutPop].
   */
  void* timedPop(TimeVal endTime)
  {
    void* _retval;
    _retval = g_async_queue_timed_pop(cast(GAsyncQueue*)cPtr, endTime ? cast(GTimeVal*)endTime.cPtr : null);
    return _retval;
  }

  /**
   * Pops data from the queue. If the queue is empty, blocks until
   * end_time or until data becomes available.
   * If no data is received before end_time, %NULL is returned.
   * To easily calculate end_time, a combination of [GLib.Global.getRealTime]
   * and [GLib.TimeVal.add] can be used.
   * This function must be called while holding the queue's lock.
   * Params:
   *   endTime = a #GTimeVal, determining the final time
   * Returns: data from the queue or %NULL, when no data is
   *   received before end_time.

   * Deprecated: use [GLib.AsyncQueue.timeoutPopUnlocked].
   */
  void* timedPopUnlocked(TimeVal endTime)
  {
    void* _retval;
    _retval = g_async_queue_timed_pop_unlocked(cast(GAsyncQueue*)cPtr, endTime ? cast(GTimeVal*)endTime.cPtr : null);
    return _retval;
  }

  /**
   * Pops data from the queue. If the queue is empty, blocks for
   * timeout microseconds, or until data becomes available.
   * If no data is received before the timeout, %NULL is returned.
   * Params:
   *   timeout = the number of microseconds to wait
   * Returns: data from the queue or %NULL, when no data is
   *   received before the timeout.
   */
  void* timeoutPop(ulong timeout)
  {
    void* _retval;
    _retval = g_async_queue_timeout_pop(cast(GAsyncQueue*)cPtr, timeout);
    return _retval;
  }

  /**
   * Pops data from the queue. If the queue is empty, blocks for
   * timeout microseconds, or until data becomes available.
   * If no data is received before the timeout, %NULL is returned.
   * This function must be called while holding the queue's lock.
   * Params:
   *   timeout = the number of microseconds to wait
   * Returns: data from the queue or %NULL, when no data is
   *   received before the timeout.
   */
  void* timeoutPopUnlocked(ulong timeout)
  {
    void* _retval;
    _retval = g_async_queue_timeout_pop_unlocked(cast(GAsyncQueue*)cPtr, timeout);
    return _retval;
  }

  /**
   * Tries to pop data from the queue. If no data is available,
   * %NULL is returned.
   * Returns: data from the queue or %NULL, when no data is
   *   available immediately.
   */
  void* tryPop()
  {
    void* _retval;
    _retval = g_async_queue_try_pop(cast(GAsyncQueue*)cPtr);
    return _retval;
  }

  /**
   * Tries to pop data from the queue. If no data is available,
   * %NULL is returned.
   * This function must be called while holding the queue's lock.
   * Returns: data from the queue or %NULL, when no data is
   *   available immediately.
   */
  void* tryPopUnlocked()
  {
    void* _retval;
    _retval = g_async_queue_try_pop_unlocked(cast(GAsyncQueue*)cPtr);
    return _retval;
  }

  /**
   * Releases the queue's lock.
   * Calling this function when you have not acquired
   * the with [GLib.AsyncQueue.lock] leads to undefined
   * behaviour.
   */
  void unlock()
  {
    g_async_queue_unlock(cast(GAsyncQueue*)cPtr);
  }

  /**
   * Decreases the reference count of the asynchronous queue by 1
   * and releases the lock. This function must be called while holding
   * the queue's lock. If the reference count went to 0, the queue
   * will be destroyed and the memory allocated will be freed.

   * Deprecated: Reference counting is done atomically.
   *   so [GLib.AsyncQueue.unref] can be used regardless of the queue's
   *   lock.
   */
  void unrefAndUnlock()
  {
    g_async_queue_unref_and_unlock(cast(GAsyncQueue*)cPtr);
  }
}
