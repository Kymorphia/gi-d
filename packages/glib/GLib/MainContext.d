module GLib.MainContext;

import GLib.Boxed;
import GLib.Cond;
import GLib.Mutex;
import GLib.Source;
import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.Gid;

/**
 * The `GMainContext` struct is an opaque data
 * type representing a set of sources to be handled in a main loop.
 */
class MainContext : Boxed
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  T* cPtr(T)(bool makeCopy = false)
  if (is(T == GMainContext))
  {
    return makeCopy ? copy_!T : cast(T*)cInstancePtr;
  }

  static GType getType()
  {
    return g_main_context_get_type();
  }

  /**
   * the new #GMainContext
   */
  this()
  {
    GMainContext* _cretval;
    _cretval = g_main_context_new();
    this(_cretval, true);
  }

  /**
   * the new #GMainContext
   */
  static MainContext newWithFlags(MainContextFlags flags)
  {
    GMainContext* _cretval;
    _cretval = g_main_context_new_with_flags(flags);
    MainContext _retval = new MainContext(cast(GMainContext*)_cretval, true);
    return _retval;
  }

  /**
   * %TRUE if the operation succeeded, and
   * this thread is now the owner of @context.
   */
  bool acquire()
  {
    bool _retval;
    _retval = g_main_context_acquire(cPtr!GMainContext);
    return _retval;
  }

  /**
   * Adds a file descriptor to the set of file descriptors polled for
   * this context. This will very seldom be used directly. Instead
   * a typical event source will use g_source_add_unix_fd() instead.
   */
  void addPoll(PollFD fd, int priority)
  {
    g_main_context_add_poll(cPtr!GMainContext, &fd, priority);
  }

  /**
   * %TRUE if some sources are ready to be dispatched.
   */
  bool check(int maxPriority, PollFD[] fds)
  {
    bool _retval;
    auto _fds = cast(GPollFD*)fds.ptr;
    _retval = g_main_context_check(cPtr!GMainContext, maxPriority, _fds, fds ? cast(int)fds.length : 0);
    return _retval;
  }

  /**
   * Dispatches all pending sources.
   *
   * You must have successfully acquired the context with
   * g_main_context_acquire() before you may call this function.
   *
   * Since 2.76 @context can be %NULL to use the global-default
   * main context.
   */
  void dispatch()
  {
    g_main_context_dispatch(cPtr!GMainContext);
  }

  /**
   * the source, if one was found, otherwise %NULL
   */
  Source findSourceByFuncsUserData(SourceFuncs funcs, void* userData)
  {
    GSource* _cretval;
    _cretval = g_main_context_find_source_by_funcs_user_data(cPtr!GMainContext, &funcs, userData);
    Source _retval = new Source(cast(GSource*)_cretval, false);
    return _retval;
  }

  /**
   * the #GSource
   */
  Source findSourceById(uint sourceId)
  {
    GSource* _cretval;
    _cretval = g_main_context_find_source_by_id(cPtr!GMainContext, sourceId);
    Source _retval = new Source(cast(GSource*)_cretval, false);
    return _retval;
  }

  /**
   * the source, if one was found, otherwise %NULL
   */
  Source findSourceByUserData(void* userData)
  {
    GSource* _cretval;
    _cretval = g_main_context_find_source_by_user_data(cPtr!GMainContext, userData);
    Source _retval = new Source(cast(GSource*)_cretval, false);
    return _retval;
  }

  /**
   * Invokes a function in such a way that @context is owned during the
   * invocation of @function.
   *
   * This function is the same as g_main_context_invoke() except that it
   * lets you specify the priority in case @function ends up being
   * scheduled as an idle and also lets you give a #GDestroyNotify for @data.
   *
   * @notify should not assume that it is called from any particular
   * thread or with any particular context acquired.
   */
  void invokeFull(int priority, SourceFunc function_)
  {
    extern(C) bool _function_Callback(void* userData)
    {
      bool _retval = (*(cast(SourceFunc*)userData))();
      return _retval;
    }

    ptrFreezeGC(cast(void*)&function_);
    g_main_context_invoke_full(cPtr!GMainContext, priority, &_function_Callback, cast(void*)&function_, &ptrThawDestroyNotify);
  }

  /**
   * %TRUE if current thread is owner of @context.
   */
  bool isOwner()
  {
    bool _retval;
    _retval = g_main_context_is_owner(cPtr!GMainContext);
    return _retval;
  }

  /**
   * %TRUE if events were dispatched.
   */
  bool iteration(bool mayBlock)
  {
    bool _retval;
    _retval = g_main_context_iteration(cPtr!GMainContext, mayBlock);
    return _retval;
  }

  /**
   * %TRUE if events are pending.
   */
  bool pending()
  {
    bool _retval;
    _retval = g_main_context_pending(cPtr!GMainContext);
    return _retval;
  }

  /**
   * Pops @context off the thread-default context stack (verifying that
   * it was on the top of the stack).
   */
  void popThreadDefault()
  {
    g_main_context_pop_thread_default(cPtr!GMainContext);
  }

  /**
   * %TRUE if some source is ready to be dispatched
   * prior to polling.
   */
  bool prepare(out int priority)
  {
    bool _retval;
    _retval = g_main_context_prepare(cPtr!GMainContext, cast(int*)&priority);
    return _retval;
  }

  /**
   * Acquires @context and sets it as the thread-default context for the
   * current thread. This will cause certain asynchronous operations
   * (such as most [gio][gio]-based I/O) which are
   * started in this thread to run under @context and deliver their
   * results to its main loop, rather than running under the global
   * default main context in the main thread. Note that calling this function
   * changes the context returned by g_main_context_get_thread_default(),
   * not the one returned by g_main_context_default(), so it does not affect
   * the context used by functions like g_idle_add().
   *
   * Normally you would call this function shortly after creating a new
   * thread, passing it a #GMainContext which will be run by a
   * #GMainLoop in that thread, to set a new default context for all
   * async operations in that thread. In this case you may not need to
   * ever call g_main_context_pop_thread_default(), assuming you want the
   * new #GMainContext to be the default for the whole lifecycle of the
   * thread.
   *
   * If you don't have control over how the new thread was created (e.g.
   * in the new thread isn't newly created, or if the thread life
   * cycle is managed by a #GThreadPool), it is always suggested to wrap
   * the logic that needs to use the new #GMainContext inside a
   * g_main_context_push_thread_default() / g_main_context_pop_thread_default()
   * pair, otherwise threads that are re-used will end up never explicitly
   * releasing the #GMainContext reference they hold.
   *
   * In some cases you may want to schedule a single operation in a
   * non-default context, or temporarily use a non-default context in
   * the main thread. In that case, you can wrap the call to the
   * asynchronous operation inside a
   * g_main_context_push_thread_default() /
   * g_main_context_pop_thread_default() pair, but it is up to you to
   * ensure that no other asynchronous operations accidentally get
   * started while the non-default context is active.
   *
   * Beware that libraries that predate this function may not correctly
   * handle being used from a thread with a thread-default context. Eg,
   * see g_file_supports_thread_contexts().
   */
  void pushThreadDefault()
  {
    g_main_context_push_thread_default(cPtr!GMainContext);
  }

  /**
   * the number of records actually stored in @fds,
   * or, if more than @n_fds records need to be stored, the number
   * of records that need to be stored.
   */
  int query(int maxPriority, out int timeout, ref PollFD[] fds)
  {
    int _retval;
    _retval = g_main_context_query(cPtr!GMainContext, maxPriority, cast(int*)&timeout, fds.ptr, fds ? cast(int)fds.length : 0);
    return _retval;
  }

  /**
   * Releases ownership of a context previously acquired by this thread
   * with g_main_context_acquire(). If the context was acquired multiple
   * times, the ownership will be released only when g_main_context_release()
   * is called as many times as it was acquired.
   *
   * You must have successfully acquired the context with
   * g_main_context_acquire() before you may call this function.
   */
  void release()
  {
    g_main_context_release(cPtr!GMainContext);
  }

  /**
   * Removes file descriptor from the set of file descriptors to be
   * polled for a particular context.
   */
  void removePoll(PollFD fd)
  {
    g_main_context_remove_poll(cPtr!GMainContext, &fd);
  }

  /**
   * %TRUE if the operation succeeded, and
   * this thread is now the owner of @context.
   */
  bool wait(Cond cond, Mutex mutex)
  {
    bool _retval;
    _retval = g_main_context_wait(cPtr!GMainContext, cond ? cond.cPtr!GCond : null, mutex ? mutex.cPtr!GMutex : null);
    return _retval;
  }

  /**
   * If @context is currently blocking in g_main_context_iteration()
   * waiting for a source to become ready, cause it to stop blocking
   * and return.  Otherwise, cause the next invocation of
   * g_main_context_iteration() to return without blocking.
   *
   * This API is useful for low-level control over #GMainContext; for
   * example, integrating it with main loop implementations such as
   * #GMainLoop.
   *
   * Another related use for this function is when implementing a main
   * loop with a termination condition, computed from multiple threads:
   *
   * |[<!-- language="C" -->
   * #define NUM_TASKS 10
   * static gint tasks_remaining = NUM_TASKS;  // (atomic)
   * ...
   *
   * while (g_atomic_int_get (&tasks_remaining) != 0)
   * g_main_context_iteration (NULL, TRUE);
   * ]|
   *
   * Then in a thread:
   * |[<!-- language="C" -->
   * perform_work();
   *
   * if (g_atomic_int_dec_and_test (&tasks_remaining))
   * g_main_context_wakeup (NULL);
   * ]|
   */
  void wakeup()
  {
    g_main_context_wakeup(cPtr!GMainContext);
  }

  /**
   * the global-default main context.
   */
  static MainContext default_()
  {
    GMainContext* _cretval;
    _cretval = g_main_context_default();
    MainContext _retval = new MainContext(cast(GMainContext*)_cretval, false);
    return _retval;
  }

  /**
   * the thread-default #GMainContext, or
   * %NULL if the thread-default context is the global-default main context.
   */
  static MainContext getThreadDefault()
  {
    GMainContext* _cretval;
    _cretval = g_main_context_get_thread_default();
    MainContext _retval = new MainContext(cast(GMainContext*)_cretval, false);
    return _retval;
  }

  /**
   * the thread-default #GMainContext. Unref
   * with g_main_context_unref() when you are done with it.
   */
  static MainContext refThreadDefault()
  {
    GMainContext* _cretval;
    _cretval = g_main_context_ref_thread_default();
    MainContext _retval = new MainContext(cast(GMainContext*)_cretval, true);
    return _retval;
  }
}
