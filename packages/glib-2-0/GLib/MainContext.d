module GLib.MainContext;

import GLib.Boxed;
import GLib.Cond;
import GLib.Mutex;
import GLib.Source;
import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.gid;

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

  void* cPtr(bool makeCopy = false)
  {
    return makeCopy ? copy_ : cInstancePtr;
  }

  static GType getType()
  {
    return g_main_context_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new #GMainContext structure.
   * Returns: the new #GMainContext
   */
  this()
  {
    GMainContext* _cretval;
    _cretval = g_main_context_new();
    this(_cretval, true);
  }

  /**
   * Creates a new #GMainContext structure.
   * Params:
   *   flags = a bitwise-OR combination of #GMainContextFlags flags that can only be
   *     set at creation time.
   * Returns: the new #GMainContext
   */
  static MainContext newWithFlags(MainContextFlags flags)
  {
    GMainContext* _cretval;
    _cretval = g_main_context_new_with_flags(flags);
    auto _retval = _cretval ? new MainContext(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Tries to become the owner of the specified context.
   * If some other thread is the owner of the context,
   * returns %FALSE immediately. Ownership is properly
   * recursive: the owner can require ownership again
   * and will release ownership when [GLib.MainContext.release]
   * is called as many times as [GLib.MainContext.acquire].
   * You must be the owner of a context before you
   * can call [GLib.MainContext.prepare], [GLib.MainContext.query],
   * [GLib.MainContext.check], [GLib.MainContext.dispatch], [GLib.MainContext.release].
   * Since 2.76 context can be %NULL to use the global-default
   * main context.
   * Returns: %TRUE if the operation succeeded, and
   *   this thread is now the owner of context.
   */
  bool acquire()
  {
    bool _retval;
    _retval = g_main_context_acquire(cast(GMainContext*)cPtr);
    return _retval;
  }

  /**
   * Adds a file descriptor to the set of file descriptors polled for
   * this context. This will very seldom be used directly. Instead
   * a typical event source will use [GLib.Source.addUnixFd] instead.
   * Params:
   *   fd = a #GPollFD structure holding information about a file
   *     descriptor to watch.
   *   priority = the priority for this file descriptor which should be
   *     the same as the priority used for [GLib.Source.attach] to ensure that the
   *     file descriptor is polled whenever the results may be needed.
   */
  void addPoll(PollFD fd, int priority)
  {
    g_main_context_add_poll(cast(GMainContext*)cPtr, &fd, priority);
  }

  /**
   * Passes the results of polling back to the main loop. You should be
   * careful to pass fds and its length n_fds as received from
   * [GLib.MainContext.query], as this functions relies on assumptions
   * on how fds is filled.
   * You must have successfully acquired the context with
   * [GLib.MainContext.acquire] before you may call this function.
   * Since 2.76 context can be %NULL to use the global-default
   * main context.
   * Params:
   *   maxPriority = the maximum numerical priority of sources to check
   *   fds = array of #GPollFD's that was passed to
   *     the last call to [GLib.MainContext.query]
   * Returns: %TRUE if some sources are ready to be dispatched.
   */
  bool check(int maxPriority, PollFD[] fds)
  {
    bool _retval;
    int _nFds;
    if (fds)
      _nFds = cast(int)fds.length;

    auto _fds = cast(GPollFD*)fds.ptr;
    _retval = g_main_context_check(cast(GMainContext*)cPtr, maxPriority, _fds, _nFds);
    return _retval;
  }

  /**
   * Dispatches all pending sources.
   * You must have successfully acquired the context with
   * [GLib.MainContext.acquire] before you may call this function.
   * Since 2.76 context can be %NULL to use the global-default
   * main context.
   */
  void dispatch()
  {
    g_main_context_dispatch(cast(GMainContext*)cPtr);
  }

  /**
   * Finds a source with the given source functions and user data.  If
   * multiple sources exist with the same source function and user data,
   * the first one found will be returned.
   * Params:
   *   funcs = the source_funcs passed to [GLib.Source.new_].
   *   userData = the user data from the callback.
   * Returns: the source, if one was found, otherwise %NULL
   */
  Source findSourceByFuncsUserData(SourceFuncs funcs, void* userData)
  {
    GSource* _cretval;
    _cretval = g_main_context_find_source_by_funcs_user_data(cast(GMainContext*)cPtr, &funcs, userData);
    auto _retval = _cretval ? new Source(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Finds a #GSource given a pair of context and ID.
   * It is a programmer error to attempt to look up a non-existent source.
   * More specifically: source IDs can be reissued after a source has been
   * destroyed and therefore it is never valid to use this function with a
   * source ID which may have already been removed.  An example is when
   * scheduling an idle to run in another thread with [GLib.Global.idleAdd]: the
   * idle may already have run and been removed by the time this function
   * is called on its $(LPAREN)now invalid$(RPAREN) source ID.  This source ID may have
   * been reissued, leading to the operation being performed against the
   * wrong source.
   * Params:
   *   sourceId = the source ID, as returned by [GLib.Source.getId].
   * Returns: the #GSource
   */
  Source findSourceById(uint sourceId)
  {
    GSource* _cretval;
    _cretval = g_main_context_find_source_by_id(cast(GMainContext*)cPtr, sourceId);
    auto _retval = _cretval ? new Source(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Finds a source with the given user data for the callback.  If
   * multiple sources exist with the same user data, the first
   * one found will be returned.
   * Params:
   *   userData = the user_data for the callback.
   * Returns: the source, if one was found, otherwise %NULL
   */
  Source findSourceByUserData(void* userData)
  {
    GSource* _cretval;
    _cretval = g_main_context_find_source_by_user_data(cast(GMainContext*)cPtr, userData);
    auto _retval = _cretval ? new Source(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Invokes a function in such a way that context is owned during the
   * invocation of function.
   * This function is the same as [GLib.MainContext.invoke] except that it
   * lets you specify the priority in case function ends up being
   * scheduled as an idle and also lets you give a #GDestroyNotify for data.
   * notify should not assume that it is called from any particular
   * thread or with any particular context acquired.
   * Params:
   *   priority = the priority at which to run function
   *   function_ = function to call
   */
  void invokeFull(int priority, SourceFunc function_)
  {
    extern(C) bool _function_Callback(void* userData)
    {
      auto _dlg = cast(SourceFunc*)userData;

      bool _retval = (*_dlg)();
      return _retval;
    }

    auto _function_ = freezeDelegate(cast(void*)&function_);
    g_main_context_invoke_full(cast(GMainContext*)cPtr, priority, &_function_Callback, _function_, &thawDelegate);
  }

  /**
   * Determines whether this thread holds the $(LPAREN)recursive$(RPAREN)
   * ownership of this #GMainContext. This is useful to
   * know before waiting on another thread that may be
   * blocking to get ownership of context.
   * Returns: %TRUE if current thread is owner of context.
   */
  bool isOwner()
  {
    bool _retval;
    _retval = g_main_context_is_owner(cast(GMainContext*)cPtr);
    return _retval;
  }

  /**
   * Runs a single iteration for the given main loop. This involves
   * checking to see if any event sources are ready to be processed,
   * then if no events sources are ready and may_block is %TRUE, waiting
   * for a source to become ready, then dispatching the highest priority
   * events sources that are ready. Otherwise, if may_block is %FALSE
   * sources are not waited to become ready, only those highest priority
   * events sources will be dispatched $(LPAREN)if any$(RPAREN), that are ready at this
   * given moment without further waiting.
   * Note that even when may_block is %TRUE, it is still possible for
   * [GLib.MainContext.iteration] to return %FALSE, since the wait may
   * be interrupted for other reasons than an event source becoming ready.
   * Params:
   *   mayBlock = whether the call may block.
   * Returns: %TRUE if events were dispatched.
   */
  bool iteration(bool mayBlock)
  {
    bool _retval;
    _retval = g_main_context_iteration(cast(GMainContext*)cPtr, mayBlock);
    return _retval;
  }

  /**
   * Checks if any sources have pending events for the given context.
   * Returns: %TRUE if events are pending.
   */
  bool pending()
  {
    bool _retval;
    _retval = g_main_context_pending(cast(GMainContext*)cPtr);
    return _retval;
  }

  /**
   * Pops context off the thread-default context stack $(LPAREN)verifying that
   * it was on the top of the stack$(RPAREN).
   */
  void popThreadDefault()
  {
    g_main_context_pop_thread_default(cast(GMainContext*)cPtr);
  }

  /**
   * Prepares to poll sources within a main loop. The resulting information
   * for polling is determined by calling g_main_context_query $(LPAREN)$(RPAREN).
   * You must have successfully acquired the context with
   * [GLib.MainContext.acquire] before you may call this function.
   * Params:
   *   priority = location to store priority of highest priority
   *     source already ready.
   * Returns: %TRUE if some source is ready to be dispatched
   *   prior to polling.
   */
  bool prepare(out int priority)
  {
    bool _retval;
    _retval = g_main_context_prepare(cast(GMainContext*)cPtr, cast(int*)&priority);
    return _retval;
  }

  /**
   * Acquires context and sets it as the thread-default context for the
   * current thread. This will cause certain asynchronous operations
   * $(LPAREN)such as most [gio][gio]-based I/O$(RPAREN) which are
   * started in this thread to run under context and deliver their
   * results to its main loop, rather than running under the global
   * default main context in the main thread. Note that calling this function
   * changes the context returned by [GLib.MainContext.getThreadDefault],
   * not the one returned by [GLib.MainContext.default_], so it does not affect
   * the context used by functions like [GLib.Global.idleAdd].
   * Normally you would call this function shortly after creating a new
   * thread, passing it a #GMainContext which will be run by a
   * #GMainLoop in that thread, to set a new default context for all
   * async operations in that thread. In this case you may not need to
   * ever call [GLib.MainContext.popThreadDefault], assuming you want the
   * new #GMainContext to be the default for the whole lifecycle of the
   * thread.
   * If you don't have control over how the new thread was created $(LPAREN)e.g.
   * in the new thread isn't newly created, or if the thread life
   * cycle is managed by a #GThreadPool$(RPAREN), it is always suggested to wrap
   * the logic that needs to use the new #GMainContext inside a
   * [GLib.MainContext.pushThreadDefault] / [GLib.MainContext.popThreadDefault]
   * pair, otherwise threads that are re-used will end up never explicitly
   * releasing the #GMainContext reference they hold.
   * In some cases you may want to schedule a single operation in a
   * non-default context, or temporarily use a non-default context in
   * the main thread. In that case, you can wrap the call to the
   * asynchronous operation inside a
   * [GLib.MainContext.pushThreadDefault] /
   * [GLib.MainContext.popThreadDefault] pair, but it is up to you to
   * ensure that no other asynchronous operations accidentally get
   * started while the non-default context is active.
   * Beware that libraries that predate this function may not correctly
   * handle being used from a thread with a thread-default context. Eg,
   * see [Gio.File.supportsThreadContexts].
   */
  void pushThreadDefault()
  {
    g_main_context_push_thread_default(cast(GMainContext*)cPtr);
  }

  /**
   * Determines information necessary to poll this main loop. You should
   * be careful to pass the resulting fds array and its length n_fds
   * as is when calling [GLib.MainContext.check], as this function relies
   * on assumptions made when the array is filled.
   * You must have successfully acquired the context with
   * [GLib.MainContext.acquire] before you may call this function.
   * Params:
   *   maxPriority = maximum priority source to check
   *   timeout = location to store timeout to be used in polling
   *   fds = location to
   *     store #GPollFD records that need to be polled.
   * Returns: the number of records actually stored in fds,
   *   or, if more than n_fds records need to be stored, the number
   *   of records that need to be stored.
   */
  int query(int maxPriority, out int timeout, ref PollFD[] fds)
  {
    int _retval;
    int _nFds;
    _retval = g_main_context_query(cast(GMainContext*)cPtr, maxPriority, cast(int*)&timeout, fds.ptr, _nFds);
    return _retval;
  }

  /**
   * Releases ownership of a context previously acquired by this thread
   * with [GLib.MainContext.acquire]. If the context was acquired multiple
   * times, the ownership will be released only when [GLib.MainContext.release]
   * is called as many times as it was acquired.
   * You must have successfully acquired the context with
   * [GLib.MainContext.acquire] before you may call this function.
   */
  void release()
  {
    g_main_context_release(cast(GMainContext*)cPtr);
  }

  /**
   * Removes file descriptor from the set of file descriptors to be
   * polled for a particular context.
   * Params:
   *   fd = a #GPollFD descriptor previously added with [GLib.MainContext.addPoll]
   */
  void removePoll(PollFD fd)
  {
    g_main_context_remove_poll(cast(GMainContext*)cPtr, &fd);
  }

  /**
   * Tries to become the owner of the specified context,
   * as with [GLib.MainContext.acquire]. But if another thread
   * is the owner, atomically drop mutex and wait on cond until
   * that owner releases ownership or until cond is signaled, then
   * try again $(LPAREN)once$(RPAREN) to become the owner.
   * Params:
   *   cond = a condition variable
   *   mutex = a mutex, currently held
   * Returns: %TRUE if the operation succeeded, and
   *   this thread is now the owner of context.

   * Deprecated: Use [GLib.MainContext.isOwner] and separate locking instead.
   */
  bool wait(Cond cond, Mutex mutex)
  {
    bool _retval;
    _retval = g_main_context_wait(cast(GMainContext*)cPtr, cond ? cast(GCond*)cond.cPtr : null, mutex ? cast(GMutex*)mutex.cPtr : null);
    return _retval;
  }

  /**
   * If context is currently blocking in [GLib.MainContext.iteration]
   * waiting for a source to become ready, cause it to stop blocking
   * and return.  Otherwise, cause the next invocation of
   * [GLib.MainContext.iteration] to return without blocking.
   * This API is useful for low-level control over #GMainContext; for
   * example, integrating it with main loop implementations such as
   * #GMainLoop.
   * Another related use for this function is when implementing a main
   * loop with a termination condition, computed from multiple threads:
   * |[<!-- language\="C" -->
   * #define NUM_TASKS 10
   * static gint tasks_remaining \= NUM_TASKS;  // $(LPAREN)atomic$(RPAREN)
   * ...
   * while $(LPAREN)g_atomic_int_get $(LPAREN)&tasks_remaining$(RPAREN) !\= 0$(RPAREN)
   * g_main_context_iteration $(LPAREN)NULL, TRUE$(RPAREN);
   * ]|
   * Then in a thread:
   * |[<!-- language\="C" -->
   * perform_work$(LPAREN)$(RPAREN);
   * if $(LPAREN)g_atomic_int_dec_and_test $(LPAREN)&tasks_remaining$(RPAREN)$(RPAREN)
   * g_main_context_wakeup $(LPAREN)NULL$(RPAREN);
   * ]|
   */
  void wakeup()
  {
    g_main_context_wakeup(cast(GMainContext*)cPtr);
  }

  /**
   * Returns the global-default main context. This is the main context
   * used for main loop functions when a main loop is not explicitly
   * specified, and corresponds to the "main" main loop. See also
   * [GLib.MainContext.getThreadDefault].
   * Returns: the global-default main context.
   */
  static MainContext default_()
  {
    GMainContext* _cretval;
    _cretval = g_main_context_default();
    auto _retval = _cretval ? new MainContext(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the thread-default #GMainContext for this thread. Asynchronous
   * operations that want to be able to be run in contexts other than
   * the default one should call this method or
   * [GLib.MainContext.refThreadDefault] to get a #GMainContext to add
   * their #GSources to. $(LPAREN)Note that even in single-threaded
   * programs applications may sometimes want to temporarily push a
   * non-default context, so it is not safe to assume that this will
   * always return %NULL if you are running in the default thread.$(RPAREN)
   * If you need to hold a reference on the context, use
   * [GLib.MainContext.refThreadDefault] instead.
   * Returns: the thread-default #GMainContext, or
   *   %NULL if the thread-default context is the global-default main context.
   */
  static MainContext getThreadDefault()
  {
    GMainContext* _cretval;
    _cretval = g_main_context_get_thread_default();
    auto _retval = _cretval ? new MainContext(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the thread-default #GMainContext for this thread, as with
   * [GLib.MainContext.getThreadDefault], but also adds a reference to
   * it with [GLib.MainContext.ref_]. In addition, unlike
   * [GLib.MainContext.getThreadDefault], if the thread-default context
   * is the global-default context, this will return that #GMainContext
   * $(LPAREN)with a ref added to it$(RPAREN) rather than returning %NULL.
   * Returns: the thread-default #GMainContext. Unref
   *   with [GLib.MainContext.unref] when you are done with it.
   */
  static MainContext refThreadDefault()
  {
    GMainContext* _cretval;
    _cretval = g_main_context_ref_thread_default();
    auto _retval = _cretval ? new MainContext(cast(void*)_cretval, true) : null;
    return _retval;
  }
}
