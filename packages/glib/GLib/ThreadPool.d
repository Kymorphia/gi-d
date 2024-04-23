module GLib.ThreadPool;

import GLib.ErrorG;
import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.Gid;

/**
 * The #GThreadPool struct represents a thread pool. It has three
 * public read-only members, but the underlying struct is bigger,
 * so you must not copy this struct.
 */
class ThreadPool
{
  GThreadPool cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for GLib.ThreadPool");

    cInstance = *cast(GThreadPool*)ptr;

    if (ownedRef)
      g_free(ptr);
  }

  ~this()
  {
    freePool(&cInstance);
  }

  T* cPtr(T)()
  if (is(T == GThreadPool))
  {
    return cast(T*)&cInstance;
  }

  @property GFunc func()
  {
    return cPtr!GThreadPool.func;
  }

  @property void func(GFunc propval)
  {
    cPtr!GThreadPool.func = propval;
  }

  @property bool exclusive()
  {
    return cPtr!GThreadPool.exclusive;
  }

  @property void exclusive(bool propval)
  {
    cPtr!GThreadPool.exclusive = propval;
  }

  private static void freePool(GThreadPool* pool)
  {
    g_thread_pool_free(pool, true, false); // immediate, wait
  }

  /**
   * the maximal number of threads
   */
  int getMaxThreads()
  {
    int _retval;
    _retval = g_thread_pool_get_max_threads(cPtr!GThreadPool);
    return _retval;
  }

  /**
   * the number of threads currently running
   */
  uint getNumThreads()
  {
    uint _retval;
    _retval = g_thread_pool_get_num_threads(cPtr!GThreadPool);
    return _retval;
  }

  /**
   * %TRUE if the item was found and moved
   */
  bool moveToFront(void* data)
  {
    bool _retval;
    _retval = g_thread_pool_move_to_front(cPtr!GThreadPool, data);
    return _retval;
  }

  /**
   * %TRUE on success, %FALSE if an error occurred
   */
  bool push(void* data)
  {
    bool _retval;
    GError *_err;
    _retval = g_thread_pool_push(cPtr!GThreadPool, data, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * %TRUE on success, %FALSE if an error occurred
   */
  bool setMaxThreads(int maxThreads)
  {
    bool _retval;
    GError *_err;
    _retval = g_thread_pool_set_max_threads(cPtr!GThreadPool, maxThreads, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * the number of unprocessed tasks
   */
  uint unprocessed()
  {
    uint _retval;
    _retval = g_thread_pool_unprocessed(cPtr!GThreadPool);
    return _retval;
  }

  /**
   * the maximum @interval (milliseconds) to wait
   * for new tasks in the thread pool before stopping the
   * thread
   */
  static uint getMaxIdleTime()
  {
    uint _retval;
    _retval = g_thread_pool_get_max_idle_time();
    return _retval;
  }

  /**
   * the maximal number of unused threads
   */
  static int getMaxUnusedThreads()
  {
    int _retval;
    _retval = g_thread_pool_get_max_unused_threads();
    return _retval;
  }

  /**
   * the number of currently unused threads
   */
  static uint getNumUnusedThreads()
  {
    uint _retval;
    _retval = g_thread_pool_get_num_unused_threads();
    return _retval;
  }

  /**
   * This function will set the maximum @interval that a thread
   * waiting in the pool for new tasks can be idle for before
   * being stopped. This function is similar to calling
   * g_thread_pool_stop_unused_threads() on a regular timeout,
   * except this is done on a per thread basis.
   *
   * By setting @interval to 0, idle threads will not be stopped.
   *
   * The default value is 15000 (15 seconds).
   */
  static void setMaxIdleTime(uint interval)
  {
    g_thread_pool_set_max_idle_time(interval);
  }

  /**
   * Sets the maximal number of unused threads to @max_threads.
   * If @max_threads is -1, no limit is imposed on the number
   * of unused threads.
   *
   * The default value is 2.
   */
  static void setMaxUnusedThreads(int maxThreads)
  {
    g_thread_pool_set_max_unused_threads(maxThreads);
  }

  /**
   * Stops all currently unused threads. This does not change the
   * maximal number of unused threads. This function can be used to
   * regularly stop all unused threads e.g. from g_timeout_add().
   */
  static void stopUnusedThreads()
  {
    g_thread_pool_stop_unused_threads();
  }
}
