module GLib.ThreadPool;

import GLib.ErrorG;
import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.gid;

/**
 * The `GThreadPool` struct represents a thread pool.
 * A thread pool is useful when you wish to asynchronously fork out the execution of work
 * and continue working in your own thread. If that will happen often, the overhead of starting
 * and destroying a thread each time might be too high. In such cases reusing already started
 * threads seems like a good idea. And it indeed is, but implementing this can be tedious
 * and error-prone.
 * Therefore GLib provides thread pools for your convenience. An added advantage is, that the
 * threads can be shared between the different subsystems of your program, when they are using GLib.
 * To create a new thread pool, you use [GLib.ThreadPool.new_].
 * It is destroyed by [GLib.ThreadPool.free].
 * If you want to execute a certain task within a thread pool, use [GLib.ThreadPool.push].
 * To get the current number of running threads you call [GLib.ThreadPool.getNumThreads].
 * To get the number of still unprocessed tasks you call [GLib.ThreadPool.unprocessed].
 * To control the maximum number of threads for a thread pool, you use
 * [GLib.ThreadPool.getMaxThreads]. and [GLib.ThreadPool.setMaxThreads].
 * Finally you can control the number of unused threads, that are kept alive by GLib for future use.
 * The current number can be fetched with [GLib.ThreadPool.getNumUnusedThreads].
 * The maximum number can be controlled by [GLib.ThreadPool.getMaxUnusedThreads] and
 * [GLib.ThreadPool.setMaxUnusedThreads]. All currently unused threads
 * can be stopped by calling [GLib.ThreadPool.stopUnusedThreads].
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
      safeFree(ptr);
  }

  ~this()
  {
    freePool(&cInstance);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property GFunc func()
  {
    return (cast(GThreadPool*)cPtr).func;
  }

  @property void func(GFunc propval)
  {
    (cast(GThreadPool*)cPtr).func = propval;
  }

  @property bool exclusive()
  {
    return (cast(GThreadPool*)cPtr).exclusive;
  }

  @property void exclusive(bool propval)
  {
    (cast(GThreadPool*)cPtr).exclusive = propval;
  }

  private static void freePool(GThreadPool* pool)
  {
    g_thread_pool_free(pool, true, false); // immediate, wait
  }



  /**
   * Returns the maximal number of threads for pool.
   * Returns: the maximal number of threads
   */
  int getMaxThreads()
  {
    int _retval;
    _retval = g_thread_pool_get_max_threads(cast(GThreadPool*)cPtr);
    return _retval;
  }

  /**
   * Returns the number of threads currently running in pool.
   * Returns: the number of threads currently running
   */
  uint getNumThreads()
  {
    uint _retval;
    _retval = g_thread_pool_get_num_threads(cast(GThreadPool*)cPtr);
    return _retval;
  }

  /**
   * Moves the item to the front of the queue of unprocessed
   * items, so that it will be processed next.
   * Params:
   *   data = an unprocessed item in the pool
   * Returns: %TRUE if the item was found and moved
   */
  bool moveToFront(void* data)
  {
    bool _retval;
    _retval = g_thread_pool_move_to_front(cast(GThreadPool*)cPtr, data);
    return _retval;
  }

  /**
   * Inserts data into the list of tasks to be executed by pool.
   * When the number of currently running threads is lower than the
   * maximal allowed number of threads, a new thread is started $(LPAREN)or
   * reused$(RPAREN) with the properties given to [GLib.ThreadPool.new_].
   * Otherwise, data stays in the queue until a thread in this pool
   * finishes its previous task and processes data.
   * error can be %NULL to ignore errors, or non-%NULL to report
   * errors. An error can only occur when a new thread couldn't be
   * created. In that case data is simply appended to the queue of
   * work to do.
   * Before version 2.32, this function did not return a success status.
   * Params:
   *   data = a new task for pool
   * Returns: %TRUE on success, %FALSE if an error occurred
   */
  bool push(void* data)
  {
    bool _retval;
    GError *_err;
    _retval = g_thread_pool_push(cast(GThreadPool*)cPtr, data, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Sets the maximal allowed number of threads for pool.
   * A value of -1 means that the maximal number of threads
   * is unlimited. If pool is an exclusive thread pool, setting
   * the maximal number of threads to -1 is not allowed.
   * Setting max_threads to 0 means stopping all work for pool.
   * It is effectively frozen until max_threads is set to a non-zero
   * value again.
   * A thread is never terminated while calling func, as supplied by
   * [GLib.ThreadPool.new_]. Instead the maximal number of threads only
   * has effect for the allocation of new threads in [GLib.ThreadPool.push].
   * A new thread is allocated, whenever the number of currently
   * running threads in pool is smaller than the maximal number.
   * error can be %NULL to ignore errors, or non-%NULL to report
   * errors. An error can only occur when a new thread couldn't be
   * created.
   * Before version 2.32, this function did not return a success status.
   * Params:
   *   maxThreads = a new maximal number of threads for pool,
   *     or -1 for unlimited
   * Returns: %TRUE on success, %FALSE if an error occurred
   */
  bool setMaxThreads(int maxThreads)
  {
    bool _retval;
    GError *_err;
    _retval = g_thread_pool_set_max_threads(cast(GThreadPool*)cPtr, maxThreads, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Returns the number of tasks still unprocessed in pool.
   * Returns: the number of unprocessed tasks
   */
  uint unprocessed()
  {
    uint _retval;
    _retval = g_thread_pool_unprocessed(cast(GThreadPool*)cPtr);
    return _retval;
  }

  /**
   * This function will return the maximum interval that a
   * thread will wait in the thread pool for new tasks before
   * being stopped.
   * If this function returns 0, threads waiting in the thread
   * pool for new work are not stopped.
   * Returns: the maximum interval $(LPAREN)milliseconds$(RPAREN) to wait
   *   for new tasks in the thread pool before stopping the
   *   thread
   */
  static uint getMaxIdleTime()
  {
    uint _retval;
    _retval = g_thread_pool_get_max_idle_time();
    return _retval;
  }

  /**
   * Returns the maximal allowed number of unused threads.
   * Returns: the maximal number of unused threads
   */
  static int getMaxUnusedThreads()
  {
    int _retval;
    _retval = g_thread_pool_get_max_unused_threads();
    return _retval;
  }

  /**
   * Returns the number of currently unused threads.
   * Returns: the number of currently unused threads
   */
  static uint getNumUnusedThreads()
  {
    uint _retval;
    _retval = g_thread_pool_get_num_unused_threads();
    return _retval;
  }

  /**
   * This function will set the maximum interval that a thread
   * waiting in the pool for new tasks can be idle for before
   * being stopped. This function is similar to calling
   * [GLib.ThreadPool.stopUnusedThreads] on a regular timeout,
   * except this is done on a per thread basis.
   * By setting interval to 0, idle threads will not be stopped.
   * The default value is 15000 $(LPAREN)15 seconds$(RPAREN).
   * Params:
   *   interval = the maximum interval $(LPAREN)in milliseconds$(RPAREN)
   *     a thread can be idle
   */
  static void setMaxIdleTime(uint interval)
  {
    g_thread_pool_set_max_idle_time(interval);
  }

  /**
   * Sets the maximal number of unused threads to max_threads.
   * If max_threads is -1, no limit is imposed on the number
   * of unused threads.
   * The default value is 2.
   * Params:
   *   maxThreads = maximal number of unused threads
   */
  static void setMaxUnusedThreads(int maxThreads)
  {
    g_thread_pool_set_max_unused_threads(maxThreads);
  }

  /**
   * Stops all currently unused threads. This does not change the
   * maximal number of unused threads. This function can be used to
   * regularly stop all unused threads e.g. from [GLib.Global.timeoutAdd].
   */
  static void stopUnusedThreads()
  {
    g_thread_pool_stop_unused_threads();
  }
}
