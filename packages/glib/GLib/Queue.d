module GLib.Queue;

import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.Gid;

/**
 * Contains the public fields of a
 * [Queue][glib-Double-ended-Queues].
 */
class Queue
{
  GQueue cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for GLib.Queue");

    cInstance = *cast(GQueue*)ptr;

    if (ownedRef)
      g_free(ptr);
  }

  ~this()
  {
    g_queue_free(&cInstance);
  }

  T* cPtr(T)()
  if (is(T == GQueue))
  {
    return cast(T*)&cInstance;
  }

  @property uint length()
  {
    return cPtr!GQueue.length;
  }

  @property void length(uint propval)
  {
    cPtr!GQueue.length = propval;
  }

  /**
   * Removes all the elements in @queue. If queue elements contain
   * dynamically-allocated memory, they should be freed first.
   */
  void clear()
  {
    g_queue_clear(cPtr!GQueue);
  }

  /**
   * Convenience method, which frees all the memory used by a #GQueue,
   * and calls the provided @free_func on each item in the #GQueue.
   */
  void clearFull(DestroyNotify freeFunc)
  {
    static DestroyNotify _static_freeFunc;

    extern(C) void _freeFuncCallback(void* data)
    {
      _static_freeFunc();
    }

    _static_freeFunc = freeFunc;
    g_queue_clear_full(cPtr!GQueue, &_freeFuncCallback);
    _static_freeFunc = null;
  }

  /**
   * Convenience method, which frees all the memory used by a #GQueue,
   * and calls the specified destroy function on every element's data.
   *
   * @free_func should not modify the queue (eg, by removing the freed
   * element from it).
   */
  void freeFull(DestroyNotify freeFunc)
  {
    static DestroyNotify _static_freeFunc;

    extern(C) void _freeFuncCallback(void* data)
    {
      _static_freeFunc();
    }

    _static_freeFunc = freeFunc;
    g_queue_free_full(cPtr!GQueue, &_freeFuncCallback);
    _static_freeFunc = null;
  }

  /**
   * the number of items in @queue
   */
  uint getLength()
  {
    uint _retval;
    _retval = g_queue_get_length(cPtr!GQueue);
    return _retval;
  }

  /**
   * the position of the first element in @queue which
   * contains @data, or -1 if no element in @queue contains @data
   */
  int index(const(void)* data)
  {
    int _retval;
    _retval = g_queue_index(cPtr!GQueue, data);
    return _retval;
  }

  /**
   * A statically-allocated #GQueue must be initialized with this function
   * before it can be used. Alternatively you can initialize it with
   * %G_QUEUE_INIT. It is not necessary to initialize queues created with
   * g_queue_new().
   */
  void init_()
  {
    g_queue_init(cPtr!GQueue);
  }

  /**
   * %TRUE if the queue is empty
   */
  bool isEmpty()
  {
    bool _retval;
    _retval = g_queue_is_empty(cPtr!GQueue);
    return _retval;
  }

  /**
   * the data of the first element in the queue, or %NULL
   * if the queue is empty
   */
  void* peekHead()
  {
    void* _retval;
    _retval = g_queue_peek_head(cPtr!GQueue);
    return _retval;
  }

  /**
   * the data for the @n'th element of @queue,
   * or %NULL if @n is off the end of @queue
   */
  void* peekNth(uint n)
  {
    void* _retval;
    _retval = g_queue_peek_nth(cPtr!GQueue, n);
    return _retval;
  }

  /**
   * the data of the last element in the queue, or %NULL
   * if the queue is empty
   */
  void* peekTail()
  {
    void* _retval;
    _retval = g_queue_peek_tail(cPtr!GQueue);
    return _retval;
  }

  /**
   * the data of the first element in the queue, or %NULL
   * if the queue is empty
   */
  void* popHead()
  {
    void* _retval;
    _retval = g_queue_pop_head(cPtr!GQueue);
    return _retval;
  }

  /**
   * the element's data, or %NULL if @n is off the end of @queue
   */
  void* popNth(uint n)
  {
    void* _retval;
    _retval = g_queue_pop_nth(cPtr!GQueue, n);
    return _retval;
  }

  /**
   * the data of the last element in the queue, or %NULL
   * if the queue is empty
   */
  void* popTail()
  {
    void* _retval;
    _retval = g_queue_pop_tail(cPtr!GQueue);
    return _retval;
  }

  /**
   * Adds a new element at the head of the queue.
   */
  void pushHead(void* data)
  {
    g_queue_push_head(cPtr!GQueue, data);
  }

  /**
   * Inserts a new element into @queue at the given position.
   */
  void pushNth(void* data, int n)
  {
    g_queue_push_nth(cPtr!GQueue, data, n);
  }

  /**
   * Adds a new element at the tail of the queue.
   */
  void pushTail(void* data)
  {
    g_queue_push_tail(cPtr!GQueue, data);
  }

  /**
   * %TRUE if @data was found and removed from @queue
   */
  bool remove(const(void)* data)
  {
    bool _retval;
    _retval = g_queue_remove(cPtr!GQueue, data);
    return _retval;
  }

  /**
   * the number of elements removed from @queue
   */
  uint removeAll(const(void)* data)
  {
    uint _retval;
    _retval = g_queue_remove_all(cPtr!GQueue, data);
    return _retval;
  }

  /**
   * Reverses the order of the items in @queue.
   */
  void reverse()
  {
    g_queue_reverse(cPtr!GQueue);
  }
}
