module GLib.Source;

import GLib.Boxed;
import GLib.MainContext;
import GLib.TimeVal;
import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.Gid;

/**
 * The `GSource` struct is an opaque data type
 * representing an event source.
 */
class Source : Boxed
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  T* cPtr(T)(bool makeCopy = false)
  if (is(T == GSource))
  {
    return makeCopy ? copy_!T : cast(T*)cInstancePtr;
  }

  static GType getType()
  {
    return g_source_get_type();
  }

  /**
   * the newly-created #GSource.
   */
  this(SourceFuncs sourceFuncs, uint structSize)
  {
    GSource* _cretval;
    _cretval = g_source_new(&sourceFuncs, structSize);
    this(_cretval, true);
  }

  /**
   * Adds @child_source to @source as a "polled" source; when @source is
   * added to a #GMainContext, @child_source will be automatically added
   * with the same priority, when @child_source is triggered, it will
   * cause @source to dispatch (in addition to calling its own
   * callback), and when @source is destroyed, it will destroy
   * @child_source as well. (@source will also still be dispatched if
   * its own prepare/check functions indicate that it is ready.)
   *
   * If you don't need @child_source to do anything on its own when it
   * triggers, you can call g_source_set_dummy_callback() on it to set a
   * callback that does nothing (except return %TRUE if appropriate).
   *
   * @source will hold a reference on @child_source while @child_source
   * is attached to it.
   *
   * This API is only intended to be used by implementations of #GSource.
   * Do not call this API on a #GSource that you did not create.
   */
  void addChildSource(Source childSource)
  {
    g_source_add_child_source(cPtr!GSource, childSource ? childSource.cPtr!GSource : null);
  }

  /**
   * Adds a file descriptor to the set of file descriptors polled for
   * this source. This is usually combined with g_source_new() to add an
   * event source. The event source's check function will typically test
   * the @revents field in the #GPollFD struct and return %TRUE if events need
   * to be processed.
   *
   * This API is only intended to be used by implementations of #GSource.
   * Do not call this API on a #GSource that you did not create.
   *
   * Using this API forces the linear scanning of event sources on each
   * main loop iteration.  Newly-written event sources should try to use
   * g_source_add_unix_fd() instead of this API.
   */
  void addPoll(PollFD fd)
  {
    g_source_add_poll(cPtr!GSource, &fd);
  }

  /**
   * an opaque tag
   */
  void* addUnixFd(int fd, IOCondition events)
  {
    void* _retval;
    _retval = g_source_add_unix_fd(cPtr!GSource, fd, events);
    return _retval;
  }

  /**
   * the ID (greater than 0) for the source within the
   * #GMainContext.
   */
  uint attach(MainContext context)
  {
    uint _retval;
    _retval = g_source_attach(cPtr!GSource, context ? context.cPtr!GMainContext : null);
    return _retval;
  }

  /**
   * Removes a source from its #GMainContext, if any, and mark it as
   * destroyed.  The source cannot be subsequently added to another
   * context. It is safe to call this on sources which have already been
   * removed from their context.
   *
   * This does not unref the #GSource: if you still hold a reference, use
   * g_source_unref() to drop it.
   *
   * This function is safe to call from any thread, regardless of which thread
   * the #GMainContext is running in.
   *
   * If the source is currently attached to a #GMainContext, destroying it
   * will effectively unset the callback similar to calling g_source_set_callback().
   * This can mean, that the data's #GDestroyNotify gets called right away.
   */
  void destroy()
  {
    g_source_destroy(cPtr!GSource);
  }

  /**
   * whether recursion is allowed.
   */
  bool getCanRecurse()
  {
    bool _retval;
    _retval = g_source_get_can_recurse(cPtr!GSource);
    return _retval;
  }

  /**
   * the #GMainContext with which the
   * source is associated, or %NULL if the context has not
   * yet been added to a source.
   */
  MainContext getContext()
  {
    GMainContext* _cretval;
    _cretval = g_source_get_context(cPtr!GSource);
    MainContext _retval = new MainContext(cast(GMainContext*)_cretval, false);
    return _retval;
  }

  /**
   * This function ignores @source and is otherwise the same as
   * g_get_current_time().
   */
  void getCurrentTime(TimeVal timeval)
  {
    g_source_get_current_time(cPtr!GSource, timeval ? timeval.cPtr!GTimeVal : null);
  }

  /**
   * the ID (greater than 0) for the source
   */
  uint getId()
  {
    uint _retval;
    _retval = g_source_get_id(cPtr!GSource);
    return _retval;
  }

  /**
   * the name of the source
   */
  string getName()
  {
    const(char)* _cretval;
    _cretval = g_source_get_name(cPtr!GSource);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * the priority of the source
   */
  int getPriority()
  {
    int _retval;
    _retval = g_source_get_priority(cPtr!GSource);
    return _retval;
  }

  /**
   * the monotonic ready time, -1 for "never"
   */
  long getReadyTime()
  {
    long _retval;
    _retval = g_source_get_ready_time(cPtr!GSource);
    return _retval;
  }

  /**
   * the monotonic time in microseconds
   */
  long getTime()
  {
    long _retval;
    _retval = g_source_get_time(cPtr!GSource);
    return _retval;
  }

  /**
   * %TRUE if the source has been destroyed
   */
  bool isDestroyed()
  {
    bool _retval;
    _retval = g_source_is_destroyed(cPtr!GSource);
    return _retval;
  }

  /**
   * Updates the event mask to watch for the fd identified by @tag.
   *
   * @tag is the tag returned from g_source_add_unix_fd().
   *
   * If you want to remove a fd, don't set its event mask to zero.
   * Instead, call g_source_remove_unix_fd().
   *
   * This API is only intended to be used by implementations of #GSource.
   * Do not call this API on a #GSource that you did not create.
   *
   * As the name suggests, this function is not available on Windows.
   */
  void modifyUnixFd(void* tag, IOCondition newEvents)
  {
    g_source_modify_unix_fd(cPtr!GSource, tag, newEvents);
  }

  /**
   * the conditions reported on the fd
   */
  IOCondition queryUnixFd(void* tag)
  {
    GIOCondition _cretval;
    _cretval = g_source_query_unix_fd(cPtr!GSource, tag);
    IOCondition _retval = cast(IOCondition)_cretval;
    return _retval;
  }

  /**
   * Detaches @child_source from @source and destroys it.
   *
   * This API is only intended to be used by implementations of #GSource.
   * Do not call this API on a #GSource that you did not create.
   */
  void removeChildSource(Source childSource)
  {
    g_source_remove_child_source(cPtr!GSource, childSource ? childSource.cPtr!GSource : null);
  }

  /**
   * Removes a file descriptor from the set of file descriptors polled for
   * this source.
   *
   * This API is only intended to be used by implementations of #GSource.
   * Do not call this API on a #GSource that you did not create.
   */
  void removePoll(PollFD fd)
  {
    g_source_remove_poll(cPtr!GSource, &fd);
  }

  /**
   * Reverses the effect of a previous call to g_source_add_unix_fd().
   *
   * You only need to call this if you want to remove an fd from being
   * watched while keeping the same source around.  In the normal case you
   * will just want to destroy the source.
   *
   * This API is only intended to be used by implementations of #GSource.
   * Do not call this API on a #GSource that you did not create.
   *
   * As the name suggests, this function is not available on Windows.
   */
  void removeUnixFd(void* tag)
  {
    g_source_remove_unix_fd(cPtr!GSource, tag);
  }

  /**
   * Sets the callback function for a source. The callback for a source is
   * called from the source's dispatch function.
   *
   * The exact type of @func depends on the type of source; ie. you
   * should not count on @func being called with @data as its first
   * parameter. Cast @func with G_SOURCE_FUNC() to avoid warnings about
   * incompatible function types.
   *
   * See [memory management of sources][mainloop-memory-management] for details
   * on how to handle memory management of @data.
   *
   * Typically, you won't use this function. Instead use functions specific
   * to the type of source you are using, such as g_idle_add() or g_timeout_add().
   *
   * It is safe to call this function multiple times on a source which has already
   * been attached to a context. The changes will take effect for the next time
   * the source is dispatched after this call returns.
   *
   * Note that g_source_destroy() for a currently attached source has the effect
   * of also unsetting the callback.
   */
  void setCallback(SourceFunc func)
  {
    extern(C) bool _funcCallback(void* userData)
    {
      bool _retval = (*(cast(SourceFunc*)userData))();
      return _retval;
    }

    ptrFreezeGC(cast(void*)&func);
    g_source_set_callback(cPtr!GSource, &_funcCallback, cast(void*)&func, &ptrThawDestroyNotify);
  }

  /**
   * Sets the callback function storing the data as a refcounted callback
   * "object". This is used internally. Note that calling
   * g_source_set_callback_indirect() assumes
   * an initial reference count on @callback_data, and thus
   * @callback_funcs->unref will eventually be called once more
   * than @callback_funcs->ref.
   *
   * It is safe to call this function multiple times on a source which has already
   * been attached to a context. The changes will take effect for the next time
   * the source is dispatched after this call returns.
   */
  void setCallbackIndirect(void* callbackData, SourceCallbackFuncs callbackFuncs)
  {
    g_source_set_callback_indirect(cPtr!GSource, callbackData, &callbackFuncs);
  }

  /**
   * Sets whether a source can be called recursively. If @can_recurse is
   * %TRUE, then while the source is being dispatched then this source
   * will be processed normally. Otherwise, all processing of this
   * source is blocked until the dispatch function returns.
   */
  void setCanRecurse(bool canRecurse)
  {
    g_source_set_can_recurse(cPtr!GSource, canRecurse);
  }

  /**
   * Sets the source functions (can be used to override
   * default implementations) of an unattached source.
   */
  void setFuncs(SourceFuncs funcs)
  {
    g_source_set_funcs(cPtr!GSource, &funcs);
  }

  /**
   * Sets a name for the source, used in debugging and profiling.
   * The name defaults to #NULL.
   *
   * The source name should describe in a human-readable way
   * what the source does. For example, "X11 event queue"
   * or "GTK repaint idle handler" or whatever it is.
   *
   * It is permitted to call this function multiple times, but is not
   * recommended due to the potential performance impact.  For example,
   * one could change the name in the "check" function of a #GSourceFuncs
   * to include details like the event type in the source name.
   *
   * Use caution if changing the name while another thread may be
   * accessing it with g_source_get_name(); that function does not copy
   * the value, and changing the value will free it while the other thread
   * may be attempting to use it.
   *
   * Also see g_source_set_static_name().
   */
  void setName(string name)
  {
    const(char)* _name = name.toCString(false);
    g_source_set_name(cPtr!GSource, _name);
  }

  /**
   * Sets the priority of a source. While the main loop is being run, a
   * source will be dispatched if it is ready to be dispatched and no
   * sources at a higher (numerically smaller) priority are ready to be
   * dispatched.
   *
   * A child source always has the same priority as its parent.  It is not
   * permitted to change the priority of a source once it has been added
   * as a child of another source.
   */
  void setPriority(int priority)
  {
    g_source_set_priority(cPtr!GSource, priority);
  }

  /**
   * Sets a #GSource to be dispatched when the given monotonic time is
   * reached (or passed).  If the monotonic time is in the past (as it
   * always will be if @ready_time is 0) then the source will be
   * dispatched immediately.
   *
   * If @ready_time is -1 then the source is never woken up on the basis
   * of the passage of time.
   *
   * Dispatching the source does not reset the ready time.  You should do
   * so yourself, from the source dispatch function.
   *
   * Note that if you have a pair of sources where the ready time of one
   * suggests that it will be delivered first but the priority for the
   * other suggests that it would be delivered first, and the ready time
   * for both sources is reached during the same main context iteration,
   * then the order of dispatch is undefined.
   *
   * It is a no-op to call this function on a #GSource which has already been
   * destroyed with g_source_destroy().
   *
   * This API is only intended to be used by implementations of #GSource.
   * Do not call this API on a #GSource that you did not create.
   */
  void setReadyTime(long readyTime)
  {
    g_source_set_ready_time(cPtr!GSource, readyTime);
  }

  /**
   * A variant of g_source_set_name() that does not
   * duplicate the @name, and can only be used with
   * string literals.
   */
  void setStaticName(string name)
  {
    const(char)* _name = name.toCString(false);
    g_source_set_static_name(cPtr!GSource, _name);
  }

  /**
   * %TRUE if the source was found and removed.
   */
  static bool remove(uint tag)
  {
    bool _retval;
    _retval = g_source_remove(tag);
    return _retval;
  }

  /**
   * %TRUE if a source was found and removed.
   */
  static bool removeByFuncsUserData(SourceFuncs funcs, void* userData)
  {
    bool _retval;
    _retval = g_source_remove_by_funcs_user_data(&funcs, userData);
    return _retval;
  }

  /**
   * %TRUE if a source was found and removed.
   */
  static bool removeByUserData(void* userData)
  {
    bool _retval;
    _retval = g_source_remove_by_user_data(userData);
    return _retval;
  }

  /**
   * Sets the name of a source using its ID.
   *
   * This is a convenience utility to set source names from the return
   * value of g_idle_add(), g_timeout_add(), etc.
   *
   * It is a programmer error to attempt to set the name of a non-existent
   * source.
   *
   * More specifically: source IDs can be reissued after a source has been
   * destroyed and therefore it is never valid to use this function with a
   * source ID which may have already been removed.  An example is when
   * scheduling an idle to run in another thread with g_idle_add(): the
   * idle may already have run and been removed by the time this function
   * is called on its (now invalid) source ID.  This source ID may have
   * been reissued, leading to the operation being performed against the
   * wrong source.
   */
  static void setNameById(uint tag, string name)
  {
    const(char)* _name = name.toCString(false);
    g_source_set_name_by_id(tag, _name);
  }
}
