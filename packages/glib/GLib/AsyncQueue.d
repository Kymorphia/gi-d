module GLib.AsyncQueue;

import GLib.TimeVal;
import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.Gid;

/**
 * An opaque data structure which represents an asynchronous queue.
 *
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

  T* cPtr(T)()
  if (is(T == GAsyncQueue))
  {
    return cast(T*)cInstancePtr;
  }

  /**
   * the length of the @queue
   */
  int length()
  {
    int _retval;
    _retval = g_async_queue_length(cPtr!GAsyncQueue);
    return _retval;
  }

  /**
   * the length of the @queue.
   */
  int lengthUnlocked()
  {
    int _retval;
    _retval = g_async_queue_length_unlocked(cPtr!GAsyncQueue);
    return _retval;
  }

  /**
   * Acquires the @queue's lock. If another thread is already
   * holding the lock, this call will block until the lock
   * becomes available.
   *
   * Call g_async_queue_unlock() to drop the lock again.
   *
   * While holding the lock, you can only call the
   * g_async_queue_*_unlocked() functions on @queue. Otherwise,
   * deadlock may occur.
   */
  void lock()
  {
    g_async_queue_lock(cPtr!GAsyncQueue);
  }

  /**
   * data from the queue
   */
  void* pop()
  {
    void* _retval;
    _retval = g_async_queue_pop(cPtr!GAsyncQueue);
    return _retval;
  }

  /**
   * data from the queue.
   */
  void* popUnlocked()
  {
    void* _retval;
    _retval = g_async_queue_pop_unlocked(cPtr!GAsyncQueue);
    return _retval;
  }

  /**
   * Pushes the @data into the @queue.
   *
   * The @data parameter must not be %NULL.
   */
  void push(void* data)
  {
    g_async_queue_push(cPtr!GAsyncQueue, data);
  }

  /**
   * Pushes the @item into the @queue. @item must not be %NULL.
   * In contrast to g_async_queue_push(), this function
   * pushes the new item ahead of the items already in the queue,
   * so that it will be the next one to be popped off the queue.
   */
  void pushFront(void* item)
  {
    g_async_queue_push_front(cPtr!GAsyncQueue, item);
  }

  /**
   * Pushes the @item into the @queue. @item must not be %NULL.
   * In contrast to g_async_queue_push_unlocked(), this function
   * pushes the new item ahead of the items already in the queue,
   * so that it will be the next one to be popped off the queue.
   *
   * This function must be called while holding the @queue's lock.
   */
  void pushFrontUnlocked(void* item)
  {
    g_async_queue_push_front_unlocked(cPtr!GAsyncQueue, item);
  }

  /**
   * Pushes the @data into the @queue.
   *
   * The @data parameter must not be %NULL.
   *
   * This function must be called while holding the @queue's lock.
   */
  void pushUnlocked(void* data)
  {
    g_async_queue_push_unlocked(cPtr!GAsyncQueue, data);
  }

  /**
   * Increases the reference count of the asynchronous @queue by 1.
   */
  void refUnlocked()
  {
    g_async_queue_ref_unlocked(cPtr!GAsyncQueue);
  }

  /**
   * %TRUE if the item was removed
   */
  bool remove(void* item)
  {
    bool _retval;
    _retval = g_async_queue_remove(cPtr!GAsyncQueue, item);
    return _retval;
  }

  /**
   * %TRUE if the item was removed
   */
  bool removeUnlocked(void* item)
  {
    bool _retval;
    _retval = g_async_queue_remove_unlocked(cPtr!GAsyncQueue, item);
    return _retval;
  }

  /**
   * data from the queue or %NULL, when no data is
   * received before @end_time.
   */
  void* timedPop(TimeVal endTime)
  {
    void* _retval;
    _retval = g_async_queue_timed_pop(cPtr!GAsyncQueue, endTime ? endTime.cPtr!GTimeVal : null);
    return _retval;
  }

  /**
   * data from the queue or %NULL, when no data is
   * received before @end_time.
   */
  void* timedPopUnlocked(TimeVal endTime)
  {
    void* _retval;
    _retval = g_async_queue_timed_pop_unlocked(cPtr!GAsyncQueue, endTime ? endTime.cPtr!GTimeVal : null);
    return _retval;
  }

  /**
   * data from the queue or %NULL, when no data is
   * received before the timeout.
   */
  void* timeoutPop(ulong timeout)
  {
    void* _retval;
    _retval = g_async_queue_timeout_pop(cPtr!GAsyncQueue, timeout);
    return _retval;
  }

  /**
   * data from the queue or %NULL, when no data is
   * received before the timeout.
   */
  void* timeoutPopUnlocked(ulong timeout)
  {
    void* _retval;
    _retval = g_async_queue_timeout_pop_unlocked(cPtr!GAsyncQueue, timeout);
    return _retval;
  }

  /**
   * data from the queue or %NULL, when no data is
   * available immediately.
   */
  void* tryPop()
  {
    void* _retval;
    _retval = g_async_queue_try_pop(cPtr!GAsyncQueue);
    return _retval;
  }

  /**
   * data from the queue or %NULL, when no data is
   * available immediately.
   */
  void* tryPopUnlocked()
  {
    void* _retval;
    _retval = g_async_queue_try_pop_unlocked(cPtr!GAsyncQueue);
    return _retval;
  }

  /**
   * Releases the queue's lock.
   *
   * Calling this function when you have not acquired
   * the with g_async_queue_lock() leads to undefined
   * behaviour.
   */
  void unlock()
  {
    g_async_queue_unlock(cPtr!GAsyncQueue);
  }

  /**
   * Decreases the reference count of the asynchronous @queue by 1
   * and releases the lock. This function must be called while holding
   * the @queue's lock. If the reference count went to 0, the @queue
   * will be destroyed and the memory allocated will be freed.
   */
  void unrefAndUnlock()
  {
    g_async_queue_unref_and_unlock(cPtr!GAsyncQueue);
  }
}
