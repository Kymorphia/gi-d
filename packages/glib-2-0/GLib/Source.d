module GLib.Source;

import GLib.Boxed;
import GLib.MainContext;
import GLib.TimeVal;
import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.gid;

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

  void* cPtr(bool makeCopy = false)
  {
    return makeCopy ? copy_ : cInstancePtr;
  }

  static GType getType()
  {
    return g_source_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new #GSource structure. The size is specified to
   * allow creating structures derived from #GSource that contain
   * additional data. The size passed in must be at least
   * `sizeof $(LPAREN)GSource$(RPAREN)`.
   * The source will not initially be associated with any #GMainContext
   * and must be added to one with [GLib.Source.attach] before it will be
   * executed.
   * Params:
   *   sourceFuncs = structure containing functions that implement
   *     the sources behavior.
   *   structSize = size of the #GSource structure to create.
   * Returns: the newly-created #GSource.
   */
  this(SourceFuncs sourceFuncs, uint structSize)
  {
    GSource* _cretval;
    _cretval = g_source_new(&sourceFuncs, structSize);
    this(_cretval, true);
  }

  /**
   * Adds child_source to source as a "polled" source; when source is
   * added to a #GMainContext, child_source will be automatically added
   * with the same priority, when child_source is triggered, it will
   * cause source to dispatch $(LPAREN)in addition to calling its own
   * callback$(RPAREN), and when source is destroyed, it will destroy
   * child_source as well. $(LPAREN)source will also still be dispatched if
   * its own prepare/check functions indicate that it is ready.$(RPAREN)
   * If you don't need child_source to do anything on its own when it
   * triggers, you can call [GObject.Global.sourceSetDummyCallback] on it to set a
   * callback that does nothing $(LPAREN)except return %TRUE if appropriate$(RPAREN).
   * source will hold a reference on child_source while child_source
   * is attached to it.
   * This API is only intended to be used by implementations of #GSource.
   * Do not call this API on a #GSource that you did not create.
   * Params:
   *   childSource = a second #GSource that source should "poll"
   */
  void addChildSource(Source childSource)
  {
    g_source_add_child_source(cast(GSource*)cPtr, childSource ? cast(GSource*)childSource.cPtr(false) : null);
  }

  /**
   * Adds a file descriptor to the set of file descriptors polled for
   * this source. This is usually combined with [GLib.Source.new_] to add an
   * event source. The event source's check function will typically test
   * the revents field in the #GPollFD struct and return %TRUE if events need
   * to be processed.
   * This API is only intended to be used by implementations of #GSource.
   * Do not call this API on a #GSource that you did not create.
   * Using this API forces the linear scanning of event sources on each
   * main loop iteration.  Newly-written event sources should try to use
   * [GLib.Source.addUnixFd] instead of this API.
   * Params:
   *   fd = a #GPollFD structure holding information about a file
   *     descriptor to watch.
   */
  void addPoll(PollFD fd)
  {
    g_source_add_poll(cast(GSource*)cPtr, &fd);
  }

  /**
   * Monitors fd for the IO events in events.
   * The tag returned by this function can be used to remove or modify the
   * monitoring of the fd using [GLib.Source.removeUnixFd] or
   * [GLib.Source.modifyUnixFd].
   * It is not necessary to remove the fd before destroying the source; it
   * will be cleaned up automatically.
   * This API is only intended to be used by implementations of #GSource.
   * Do not call this API on a #GSource that you did not create.
   * As the name suggests, this function is not available on Windows.
   * Params:
   *   fd = the fd to monitor
   *   events = an event mask
   * Returns: an opaque tag
   */
  void* addUnixFd(int fd, IOCondition events)
  {
    void* _retval;
    _retval = g_source_add_unix_fd(cast(GSource*)cPtr, fd, events);
    return _retval;
  }

  /**
   * Adds a #GSource to a context so that it will be executed within
   * that context. Remove it by calling [GLib.Source.destroy].
   * This function is safe to call from any thread, regardless of which thread
   * the context is running in.
   * Params:
   *   context = a #GMainContext $(LPAREN)if %NULL, the global-default
   *     main context will be used$(RPAREN)
   * Returns: the ID $(LPAREN)greater than 0$(RPAREN) for the source within the
   *   #GMainContext.
   */
  uint attach(MainContext context)
  {
    uint _retval;
    _retval = g_source_attach(cast(GSource*)cPtr, context ? cast(GMainContext*)context.cPtr(false) : null);
    return _retval;
  }

  /**
   * Removes a source from its #GMainContext, if any, and mark it as
   * destroyed.  The source cannot be subsequently added to another
   * context. It is safe to call this on sources which have already been
   * removed from their context.
   * This does not unref the #GSource: if you still hold a reference, use
   * [GLib.Source.unref] to drop it.
   * This function is safe to call from any thread, regardless of which thread
   * the #GMainContext is running in.
   * If the source is currently attached to a #GMainContext, destroying it
   * will effectively unset the callback similar to calling [GLib.Source.setCallback].
   * This can mean, that the data's #GDestroyNotify gets called right away.
   */
  void destroy()
  {
    g_source_destroy(cast(GSource*)cPtr);
  }

  /**
   * Checks whether a source is allowed to be called recursively.
   * see [GLib.Source.setCanRecurse].
   * Returns: whether recursion is allowed.
   */
  bool getCanRecurse()
  {
    bool _retval;
    _retval = g_source_get_can_recurse(cast(GSource*)cPtr);
    return _retval;
  }

  /**
   * Gets the #GMainContext with which the source is associated.
   * You can call this on a source that has been destroyed, provided
   * that the #GMainContext it was attached to still exists $(LPAREN)in which
   * case it will return that #GMainContext$(RPAREN). In particular, you can
   * always call this function on the source returned from
   * [GLib.DGLibGlobal.mainCurrentSource]. But calling this function on a source
   * whose #GMainContext has been destroyed is an error.
   * Returns: the #GMainContext with which the
   *   source is associated, or %NULL if the context has not
   *   yet been added to a source.
   */
  MainContext getContext()
  {
    GMainContext* _cretval;
    _cretval = g_source_get_context(cast(GSource*)cPtr);
    auto _retval = _cretval ? new MainContext(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * This function ignores source and is otherwise the same as
   * [GLib.DGLibGlobal.getCurrentTime].
   * Params:
   *   timeval = #GTimeVal structure in which to store current time.

   * Deprecated: use [GLib.Source.getTime] instead
   */
  void getCurrentTime(TimeVal timeval)
  {
    g_source_get_current_time(cast(GSource*)cPtr, timeval ? cast(GTimeVal*)timeval.cPtr : null);
  }

  /**
   * Returns the numeric ID for a particular source. The ID of a source
   * is a positive integer which is unique within a particular main loop
   * context. The reverse
   * mapping from ID to source is done by [GLib.MainContext.findSourceById].
   * You can only call this function while the source is associated to a
   * #GMainContext instance; calling this function before [GLib.Source.attach]
   * or after [GLib.Source.destroy] yields undefined behavior. The ID returned
   * is unique within the #GMainContext instance passed to [GLib.Source.attach].
   * Returns: the ID $(LPAREN)greater than 0$(RPAREN) for the source
   */
  uint getId()
  {
    uint _retval;
    _retval = g_source_get_id(cast(GSource*)cPtr);
    return _retval;
  }

  /**
   * Gets a name for the source, used in debugging and profiling.  The
   * name may be #NULL if it has never been set with [GLib.Source.setName].
   * Returns: the name of the source
   */
  string getName()
  {
    const(char)* _cretval;
    _cretval = g_source_get_name(cast(GSource*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Gets the priority of a source.
   * Returns: the priority of the source
   */
  int getPriority()
  {
    int _retval;
    _retval = g_source_get_priority(cast(GSource*)cPtr);
    return _retval;
  }

  /**
   * Gets the "ready time" of source, as set by
   * [GLib.Source.setReadyTime].
   * Any time before or equal to the current monotonic time $(LPAREN)including 0$(RPAREN)
   * is an indication that the source will fire immediately.
   * Returns: the monotonic ready time, -1 for "never"
   */
  long getReadyTime()
  {
    long _retval;
    _retval = g_source_get_ready_time(cast(GSource*)cPtr);
    return _retval;
  }

  /**
   * Gets the time to be used when checking this source. The advantage of
   * calling this function over calling [GLib.DGLibGlobal.getMonotonicTime] directly is
   * that when checking multiple sources, GLib can cache a single value
   * instead of having to repeatedly get the system monotonic time.
   * The time here is the system monotonic time, if available, or some
   * other reasonable alternative otherwise.  See [GLib.DGLibGlobal.getMonotonicTime].
   * Returns: the monotonic time in microseconds
   */
  long getTime()
  {
    long _retval;
    _retval = g_source_get_time(cast(GSource*)cPtr);
    return _retval;
  }

  /**
   * Returns whether source has been destroyed.
   * This is important when you operate upon your objects
   * from within idle handlers, but may have freed the object
   * before the dispatch of your idle handler.
   * |[<!-- language\="C" -->
   * static gboolean
   * idle_callback $(LPAREN)gpointer data$(RPAREN)
   * {
   * SomeWidget *self \= data;
   * g_mutex_lock $(LPAREN)&self->idle_id_mutex$(RPAREN);
   * // do stuff with self
   * self->idle_id \= 0;
   * g_mutex_unlock $(LPAREN)&self->idle_id_mutex$(RPAREN);
   * return G_SOURCE_REMOVE;
   * }
   * static void
   * some_widget_do_stuff_later $(LPAREN)SomeWidget *self$(RPAREN)
   * {
   * g_mutex_lock $(LPAREN)&self->idle_id_mutex$(RPAREN);
   * self->idle_id \= g_idle_add $(LPAREN)idle_callback, self$(RPAREN);
   * g_mutex_unlock $(LPAREN)&self->idle_id_mutex$(RPAREN);
   * }
   * static void
   * some_widget_init $(LPAREN)SomeWidget *self$(RPAREN)
   * {
   * g_mutex_init $(LPAREN)&self->idle_id_mutex$(RPAREN);
   * // ...
   * }
   * static void
   * some_widget_finalize $(LPAREN)GObject *object$(RPAREN)
   * {
   * SomeWidget *self \= SOME_WIDGET $(LPAREN)object$(RPAREN);
   * if $(LPAREN)self->idle_id$(RPAREN)
   * g_source_remove $(LPAREN)self->idle_id$(RPAREN);
   * g_mutex_clear $(LPAREN)&self->idle_id_mutex$(RPAREN);
   * G_OBJECT_CLASS $(LPAREN)parent_class$(RPAREN)->finalize $(LPAREN)object$(RPAREN);
   * }
   * ]|
   * This will fail in a multi-threaded application if the
   * widget is destroyed before the idle handler fires due
   * to the use after free in the callback. A solution, to
   * this particular problem, is to check to if the source
   * has already been destroy within the callback.
   * |[<!-- language\="C" -->
   * static gboolean
   * idle_callback $(LPAREN)gpointer data$(RPAREN)
   * {
   * SomeWidget *self \= data;
   * g_mutex_lock $(LPAREN)&self->idle_id_mutex$(RPAREN);
   * if $(LPAREN)!g_source_is_destroyed $(LPAREN)g_main_current_source $(LPAREN)$(RPAREN)$(RPAREN)$(RPAREN)
   * {
   * // do stuff with self
   * }
   * g_mutex_unlock $(LPAREN)&self->idle_id_mutex$(RPAREN);
   * return FALSE;
   * }
   * ]|
   * Calls to this function from a thread other than the one acquired by the
   * #GMainContext the #GSource is attached to are typically redundant, as the
   * source could be destroyed immediately after this function returns. However,
   * once a source is destroyed it cannot be un-destroyed, so this function can be
   * used for opportunistic checks from any thread.
   * Returns: %TRUE if the source has been destroyed
   */
  bool isDestroyed()
  {
    bool _retval;
    _retval = g_source_is_destroyed(cast(GSource*)cPtr);
    return _retval;
  }

  /**
   * Updates the event mask to watch for the fd identified by tag.
   * tag is the tag returned from [GLib.Source.addUnixFd].
   * If you want to remove a fd, don't set its event mask to zero.
   * Instead, call [GLib.Source.removeUnixFd].
   * This API is only intended to be used by implementations of #GSource.
   * Do not call this API on a #GSource that you did not create.
   * As the name suggests, this function is not available on Windows.
   * Params:
   *   tag = the tag from [GLib.Source.addUnixFd]
   *   newEvents = the new event mask to watch
   */
  void modifyUnixFd(void* tag, IOCondition newEvents)
  {
    g_source_modify_unix_fd(cast(GSource*)cPtr, tag, newEvents);
  }

  /**
   * Queries the events reported for the fd corresponding to tag on
   * source during the last poll.
   * The return value of this function is only defined when the function
   * is called from the check or dispatch functions for source.
   * This API is only intended to be used by implementations of #GSource.
   * Do not call this API on a #GSource that you did not create.
   * As the name suggests, this function is not available on Windows.
   * Params:
   *   tag = the tag from [GLib.Source.addUnixFd]
   * Returns: the conditions reported on the fd
   */
  IOCondition queryUnixFd(void* tag)
  {
    GIOCondition _cretval;
    _cretval = g_source_query_unix_fd(cast(GSource*)cPtr, tag);
    IOCondition _retval = cast(IOCondition)_cretval;
    return _retval;
  }

  /**
   * Detaches child_source from source and destroys it.
   * This API is only intended to be used by implementations of #GSource.
   * Do not call this API on a #GSource that you did not create.
   * Params:
   *   childSource = a #GSource previously passed to
   *     [GLib.Source.addChildSource].
   */
  void removeChildSource(Source childSource)
  {
    g_source_remove_child_source(cast(GSource*)cPtr, childSource ? cast(GSource*)childSource.cPtr(false) : null);
  }

  /**
   * Removes a file descriptor from the set of file descriptors polled for
   * this source.
   * This API is only intended to be used by implementations of #GSource.
   * Do not call this API on a #GSource that you did not create.
   * Params:
   *   fd = a #GPollFD structure previously passed to [GLib.Source.addPoll].
   */
  void removePoll(PollFD fd)
  {
    g_source_remove_poll(cast(GSource*)cPtr, &fd);
  }

  /**
   * Reverses the effect of a previous call to [GLib.Source.addUnixFd].
   * You only need to call this if you want to remove an fd from being
   * watched while keeping the same source around.  In the normal case you
   * will just want to destroy the source.
   * This API is only intended to be used by implementations of #GSource.
   * Do not call this API on a #GSource that you did not create.
   * As the name suggests, this function is not available on Windows.
   * Params:
   *   tag = the tag from [GLib.Source.addUnixFd]
   */
  void removeUnixFd(void* tag)
  {
    g_source_remove_unix_fd(cast(GSource*)cPtr, tag);
  }

  /**
   * Sets the callback function for a source. The callback for a source is
   * called from the source's dispatch function.
   * The exact type of func depends on the type of source; ie. you
   * should not count on func being called with data as its first
   * parameter. Cast func with G_SOURCE_FUNC$(LPAREN)$(RPAREN) to avoid warnings about
   * incompatible function types.
   * See [memory management of sources][mainloop-memory-management] for details
   * on how to handle memory management of data.
   * Typically, you won't use this function. Instead use functions specific
   * to the type of source you are using, such as [GLib.DGLibGlobal.idleAdd] or [GLib.DGLibGlobal.timeoutAdd].
   * It is safe to call this function multiple times on a source which has already
   * been attached to a context. The changes will take effect for the next time
   * the source is dispatched after this call returns.
   * Note that [GLib.Source.destroy] for a currently attached source has the effect
   * of also unsetting the callback.
   * Params:
   *   func = a callback function
   */
  void setCallback(SourceFunc func)
  {
    extern(C) bool _funcCallback(void* userData)
    {
      auto _dlg = cast(SourceFunc*)userData;

      bool _retval = (*_dlg)();
      return _retval;
    }

    auto _func = freezeDelegate(cast(void*)&func);
    g_source_set_callback(cast(GSource*)cPtr, &_funcCallback, _func, &thawDelegate);
  }

  /**
   * Sets the callback function storing the data as a refcounted callback
   * "object". This is used internally. Note that calling
   * [GLib.Source.setCallbackIndirect] assumes
   * an initial reference count on callback_data, and thus
   * callback_funcs->unref will eventually be called once more
   * than callback_funcs->ref.
   * It is safe to call this function multiple times on a source which has already
   * been attached to a context. The changes will take effect for the next time
   * the source is dispatched after this call returns.
   * Params:
   *   callbackData = pointer to callback data "object"
   *   callbackFuncs = functions for reference counting callback_data
   *     and getting the callback and data
   */
  void setCallbackIndirect(void* callbackData, SourceCallbackFuncs callbackFuncs)
  {
    g_source_set_callback_indirect(cast(GSource*)cPtr, callbackData, &callbackFuncs);
  }

  /**
   * Sets whether a source can be called recursively. If can_recurse is
   * %TRUE, then while the source is being dispatched then this source
   * will be processed normally. Otherwise, all processing of this
   * source is blocked until the dispatch function returns.
   * Params:
   *   canRecurse = whether recursion is allowed for this source
   */
  void setCanRecurse(bool canRecurse)
  {
    g_source_set_can_recurse(cast(GSource*)cPtr, canRecurse);
  }

  /**
   * Sets the source functions $(LPAREN)can be used to override
   * default implementations$(RPAREN) of an unattached source.
   * Params:
   *   funcs = the new #GSourceFuncs
   */
  void setFuncs(SourceFuncs funcs)
  {
    g_source_set_funcs(cast(GSource*)cPtr, &funcs);
  }

  /**
   * Sets a name for the source, used in debugging and profiling.
   * The name defaults to #NULL.
   * The source name should describe in a human-readable way
   * what the source does. For example, "X11 event queue"
   * or "GTK repaint idle handler" or whatever it is.
   * It is permitted to call this function multiple times, but is not
   * recommended due to the potential performance impact.  For example,
   * one could change the name in the "check" function of a #GSourceFuncs
   * to include details like the event type in the source name.
   * Use caution if changing the name while another thread may be
   * accessing it with [GLib.Source.getName]; that function does not copy
   * the value, and changing the value will free it while the other thread
   * may be attempting to use it.
   * Also see [GLib.Source.setStaticName].
   * Params:
   *   name = debug name for the source
   */
  void setName(string name)
  {
    const(char)* _name = name.toCString(false);
    g_source_set_name(cast(GSource*)cPtr, _name);
  }

  /**
   * Sets the priority of a source. While the main loop is being run, a
   * source will be dispatched if it is ready to be dispatched and no
   * sources at a higher $(LPAREN)numerically smaller$(RPAREN) priority are ready to be
   * dispatched.
   * A child source always has the same priority as its parent.  It is not
   * permitted to change the priority of a source once it has been added
   * as a child of another source.
   * Params:
   *   priority = the new priority.
   */
  void setPriority(int priority)
  {
    g_source_set_priority(cast(GSource*)cPtr, priority);
  }

  /**
   * Sets a #GSource to be dispatched when the given monotonic time is
   * reached $(LPAREN)or passed$(RPAREN).  If the monotonic time is in the past $(LPAREN)as it
   * always will be if ready_time is 0$(RPAREN) then the source will be
   * dispatched immediately.
   * If ready_time is -1 then the source is never woken up on the basis
   * of the passage of time.
   * Dispatching the source does not reset the ready time.  You should do
   * so yourself, from the source dispatch function.
   * Note that if you have a pair of sources where the ready time of one
   * suggests that it will be delivered first but the priority for the
   * other suggests that it would be delivered first, and the ready time
   * for both sources is reached during the same main context iteration,
   * then the order of dispatch is undefined.
   * It is a no-op to call this function on a #GSource which has already been
   * destroyed with [GLib.Source.destroy].
   * This API is only intended to be used by implementations of #GSource.
   * Do not call this API on a #GSource that you did not create.
   * Params:
   *   readyTime = the monotonic time at which the source will be ready,
   *     0 for "immediately", -1 for "never"
   */
  void setReadyTime(long readyTime)
  {
    g_source_set_ready_time(cast(GSource*)cPtr, readyTime);
  }

  /**
   * A variant of [GLib.Source.setName] that does not
   * duplicate the name, and can only be used with
   * string literals.
   * Params:
   *   name = debug name for the source
   */
  void setStaticName(string name)
  {
    const(char)* _name = name.toCString(false);
    g_source_set_static_name(cast(GSource*)cPtr, _name);
  }

  /**
   * Removes the source with the given ID from the default main context. You must
   * use [GLib.Source.destroy] for sources added to a non-default main context.
   * The ID of a #GSource is given by [GLib.Source.getId], or will be
   * returned by the functions [GLib.Source.attach], [GLib.DGLibGlobal.idleAdd],
   * [GLib.DGLibGlobal.idleAddFull], [GLib.DGLibGlobal.timeoutAdd], [GLib.DGLibGlobal.timeoutAddFull],
   * [GLib.DGLibGlobal.childWatchAdd], [GLib.DGLibGlobal.childWatchAddFull], [GLib.DGLibGlobal.ioAddWatch], and
   * [GLib.DGLibGlobal.ioAddWatchFull].
   * It is a programmer error to attempt to remove a non-existent source.
   * More specifically: source IDs can be reissued after a source has been
   * destroyed and therefore it is never valid to use this function with a
   * source ID which may have already been removed.  An example is when
   * scheduling an idle to run in another thread with [GLib.DGLibGlobal.idleAdd]: the
   * idle may already have run and been removed by the time this function
   * is called on its $(LPAREN)now invalid$(RPAREN) source ID.  This source ID may have
   * been reissued, leading to the operation being performed against the
   * wrong source.
   * Params:
   *   tag = the ID of the source to remove.
   * Returns: %TRUE if the source was found and removed.
   */
  static bool remove(uint tag)
  {
    bool _retval;
    _retval = g_source_remove(tag);
    return _retval;
  }

  /**
   * Removes a source from the default main loop context given the
   * source functions and user data. If multiple sources exist with the
   * same source functions and user data, only one will be destroyed.
   * Params:
   *   funcs = The source_funcs passed to [GLib.Source.new_]
   *   userData = the user data for the callback
   * Returns: %TRUE if a source was found and removed.
   */
  static bool removeByFuncsUserData(SourceFuncs funcs, void* userData)
  {
    bool _retval;
    _retval = g_source_remove_by_funcs_user_data(&funcs, userData);
    return _retval;
  }

  /**
   * Removes a source from the default main loop context given the user
   * data for the callback. If multiple sources exist with the same user
   * data, only one will be destroyed.
   * Params:
   *   userData = the user_data for the callback.
   * Returns: %TRUE if a source was found and removed.
   */
  static bool removeByUserData(void* userData)
  {
    bool _retval;
    _retval = g_source_remove_by_user_data(userData);
    return _retval;
  }

  /**
   * Sets the name of a source using its ID.
   * This is a convenience utility to set source names from the return
   * value of [GLib.DGLibGlobal.idleAdd], [GLib.DGLibGlobal.timeoutAdd], etc.
   * It is a programmer error to attempt to set the name of a non-existent
   * source.
   * More specifically: source IDs can be reissued after a source has been
   * destroyed and therefore it is never valid to use this function with a
   * source ID which may have already been removed.  An example is when
   * scheduling an idle to run in another thread with [GLib.DGLibGlobal.idleAdd]: the
   * idle may already have run and been removed by the time this function
   * is called on its $(LPAREN)now invalid$(RPAREN) source ID.  This source ID may have
   * been reissued, leading to the operation being performed against the
   * wrong source.
   * Params:
   *   tag = a #GSource ID
   *   name = debug name for the source
   */
  static void setNameById(uint tag, string name)
  {
    const(char)* _name = name.toCString(false);
    g_source_set_name_by_id(tag, _name);
  }
}
