module Gio.Task;

import GLib.ErrorG;
import GLib.MainContext;
import GLib.Types;
import GObject.ObjectG;
import GObject.Value;
import Gid.gid;
import Gio.AsyncResult;
import Gio.AsyncResultT;
import Gio.Cancellable;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * A `GTask` represents and manages a cancellable ‘task’.
 * ## Asynchronous operations
 * The most common usage of `GTask` is as a [Gio.AsyncResult], to
 * manage data during an asynchronous operation. You call
 * [Gio.Task.new_] in the ‘start’ method, followed by
 * [Gio.Task.setTaskData] and the like if you need to keep some
 * additional data associated with the task, and then pass the
 * task object around through your asynchronous operation.
 * Eventually, you will call a method such as
 * [Gio.Task.returnPointer] or [Gio.Task.returnError], which
 * will save the value you give it and then invoke the task’s callback
 * function in the thread-default main context $(LPAREN)see
 * [GLib.MainContext.pushThreadDefault]$(RPAREN)
 * where it was created $(LPAREN)waiting until the next iteration of the main
 * loop first, if necessary$(RPAREN). The caller will pass the `GTask` back to
 * the operation’s finish function $(LPAREN)as a [Gio.AsyncResult]$(RPAREN), and you can
 * use [Gio.Task.propagatePointer] or the like to extract the
 * return value.
 * Using `GTask` requires the thread-default [GLib.MainContext] from when
 * the `GTask` was constructed to be running at least until the task has
 * completed and its data has been freed.
 * If a `GTask` has been constructed and its callback set, it is an error to
 * not call `g_task_return_*$(LPAREN)$(RPAREN)` on it. GLib will warn at runtime if this happens
 * $(LPAREN)since 2.76$(RPAREN).
 * Here is an example for using `GTask` as a [Gio.AsyncResult]:
 * ```c
 * typedef struct {
 * CakeFrostingType frosting;
 * char *message;
 * } DecorationData;
 * static void
 * decoration_data_free $(LPAREN)DecorationData *decoration$(RPAREN)
 * {
 * g_free $(LPAREN)decoration->message$(RPAREN);
 * g_slice_free $(LPAREN)DecorationData, decoration$(RPAREN);
 * }
 * static void
 * baked_cb $(LPAREN)Cake     *cake,
 * gpointer  user_data$(RPAREN)
 * {
 * GTask *task \= user_data;
 * DecorationData *decoration \= g_task_get_task_data $(LPAREN)task$(RPAREN);
 * GError *error \= NULL;
 * if $(LPAREN)cake \=\= NULL$(RPAREN)
 * {
 * g_task_return_new_error $(LPAREN)task, BAKER_ERROR, BAKER_ERROR_NO_FLOUR,
 * "Go to the supermarket"$(RPAREN);
 * g_object_unref $(LPAREN)task$(RPAREN);
 * return;
 * }
 * if $(LPAREN)!cake_decorate $(LPAREN)cake, decoration->frosting, decoration->message, &error$(RPAREN)$(RPAREN)
 * {
 * g_object_unref $(LPAREN)cake$(RPAREN);
 * // [Gio.Task.returnError] takes ownership of error
 * g_task_return_error $(LPAREN)task, error$(RPAREN);
 * g_object_unref $(LPAREN)task$(RPAREN);
 * return;
 * }
 * g_task_return_pointer $(LPAREN)task, cake, g_object_unref$(RPAREN);
 * g_object_unref $(LPAREN)task$(RPAREN);
 * }
 * void
 * baker_bake_cake_async $(LPAREN)Baker               *self,
 * guint                radius,
 * CakeFlavor           flavor,
 * CakeFrostingType     frosting,
 * const char          *message,
 * GCancellable        *cancellable,
 * GAsyncReadyCallback  callback,
 * gpointer             user_data$(RPAREN)
 * {
 * GTask *task;
 * DecorationData *decoration;
 * Cake  *cake;
 * task \= g_task_new $(LPAREN)self, cancellable, callback, user_data$(RPAREN);
 * if $(LPAREN)radius < 3$(RPAREN)
 * {
 * g_task_return_new_error $(LPAREN)task, BAKER_ERROR, BAKER_ERROR_TOO_SMALL,
 * "%ucm radius cakes are silly",
 * radius$(RPAREN);
 * g_object_unref $(LPAREN)task$(RPAREN);
 * return;
 * }
 * cake \= _baker_get_cached_cake $(LPAREN)self, radius, flavor, frosting, message$(RPAREN);
 * if $(LPAREN)cake !\= NULL$(RPAREN)
 * {
 * // _baker_get_cached_cake$(LPAREN)$(RPAREN) returns a reffed cake
 * g_task_return_pointer $(LPAREN)task, cake, g_object_unref$(RPAREN);
 * g_object_unref $(LPAREN)task$(RPAREN);
 * return;
 * }
 * decoration \= g_slice_new $(LPAREN)DecorationData$(RPAREN);
 * decoration->frosting \= frosting;
 * decoration->message \= g_strdup $(LPAREN)message$(RPAREN);
 * g_task_set_task_data $(LPAREN)task, decoration, $(LPAREN)GDestroyNotify$(RPAREN) decoration_data_free$(RPAREN);
 * _baker_begin_cake $(LPAREN)self, radius, flavor, cancellable, baked_cb, task$(RPAREN);
 * }
 * Cake *
 * baker_bake_cake_finish $(LPAREN)Baker         *self,
 * GAsyncResult  *result,
 * GError       **error$(RPAREN)
 * {
 * g_return_val_if_fail $(LPAREN)g_task_is_valid $(LPAREN)result, self$(RPAREN), NULL$(RPAREN);
 * return g_task_propagate_pointer $(LPAREN)G_TASK $(LPAREN)result$(RPAREN), error$(RPAREN);
 * }
 * ```
 * ## Chained asynchronous operations
 * `GTask` also tries to simplify asynchronous operations that
 * internally chain together several smaller asynchronous
 * operations. [Gio.Task.getCancellable], [Gio.Task.getContext],
 * and [Gio.Task.getPriority] allow you to get back the task’s
 * [Gio.Cancellable], [GLib.MainContext], and
 * [I/O priority](iface.AsyncResult.html#io-priority)
 * when starting a new subtask, so you don’t have to keep track
 * of them yourself. [Gio.Task.attachSource] simplifies the case
 * of waiting for a source to fire $(LPAREN)automatically using the correct
 * [GLib.MainContext] and priority$(RPAREN).
 * Here is an example for chained asynchronous operations:
 * ```c
 * typedef struct {
 * Cake *cake;
 * CakeFrostingType frosting;
 * char *message;
 * } BakingData;
 * static void
 * decoration_data_free $(LPAREN)BakingData *bd$(RPAREN)
 * {
 * if $(LPAREN)bd->cake$(RPAREN)
 * g_object_unref $(LPAREN)bd->cake$(RPAREN);
 * g_free $(LPAREN)bd->message$(RPAREN);
 * g_slice_free $(LPAREN)BakingData, bd$(RPAREN);
 * }
 * static void
 * decorated_cb $(LPAREN)Cake         *cake,
 * GAsyncResult *result,
 * gpointer      user_data$(RPAREN)
 * {
 * GTask *task \= user_data;
 * GError *error \= NULL;
 * if $(LPAREN)!cake_decorate_finish $(LPAREN)cake, result, &error$(RPAREN)$(RPAREN)
 * {
 * g_object_unref $(LPAREN)cake$(RPAREN);
 * g_task_return_error $(LPAREN)task, error$(RPAREN);
 * g_object_unref $(LPAREN)task$(RPAREN);
 * return;
 * }
 * // baking_data_free$(LPAREN)$(RPAREN) will drop its ref on the cake, so we have to
 * // take another here to give to the caller.
 * g_task_return_pointer $(LPAREN)task, g_object_ref $(LPAREN)cake$(RPAREN), g_object_unref$(RPAREN);
 * g_object_unref $(LPAREN)task$(RPAREN);
 * }
 * static gboolean
 * decorator_ready $(LPAREN)gpointer user_data$(RPAREN)
 * {
 * GTask *task \= user_data;
 * BakingData *bd \= g_task_get_task_data $(LPAREN)task$(RPAREN);
 * cake_decorate_async $(LPAREN)bd->cake, bd->frosting, bd->message,
 * g_task_get_cancellable $(LPAREN)task$(RPAREN),
 * decorated_cb, task$(RPAREN);
 * return G_SOURCE_REMOVE;
 * }
 * static void
 * baked_cb $(LPAREN)Cake     *cake,
 * gpointer  user_data$(RPAREN)
 * {
 * GTask *task \= user_data;
 * BakingData *bd \= g_task_get_task_data $(LPAREN)task$(RPAREN);
 * GError *error \= NULL;
 * if $(LPAREN)cake \=\= NULL$(RPAREN)
 * {
 * g_task_return_new_error $(LPAREN)task, BAKER_ERROR, BAKER_ERROR_NO_FLOUR,
 * "Go to the supermarket"$(RPAREN);
 * g_object_unref $(LPAREN)task$(RPAREN);
 * return;
 * }
 * bd->cake \= cake;
 * // Bail out now if the user has already cancelled
 * if $(LPAREN)g_task_return_error_if_cancelled $(LPAREN)task$(RPAREN)$(RPAREN)
 * {
 * g_object_unref $(LPAREN)task$(RPAREN);
 * return;
 * }
 * if $(LPAREN)cake_decorator_available $(LPAREN)cake$(RPAREN)$(RPAREN)
 * decorator_ready $(LPAREN)task$(RPAREN);
 * else
 * {
 * GSource *source;
 * source \= cake_decorator_wait_source_new $(LPAREN)cake$(RPAREN);
 * // Attach @source to @task’s GMainContext and have it call
 * // decorator_ready$(LPAREN)$(RPAREN) when it is ready.
 * g_task_attach_source $(LPAREN)task, source, decorator_ready$(RPAREN);
 * g_source_unref $(LPAREN)source$(RPAREN);
 * }
 * }
 * void
 * baker_bake_cake_async $(LPAREN)Baker               *self,
 * guint                radius,
 * CakeFlavor           flavor,
 * CakeFrostingType     frosting,
 * const char          *message,
 * gint                 priority,
 * GCancellable        *cancellable,
 * GAsyncReadyCallback  callback,
 * gpointer             user_data$(RPAREN)
 * {
 * GTask *task;
 * BakingData *bd;
 * task \= g_task_new $(LPAREN)self, cancellable, callback, user_data$(RPAREN);
 * g_task_set_priority $(LPAREN)task, priority$(RPAREN);
 * bd \= g_slice_new0 $(LPAREN)BakingData$(RPAREN);
 * bd->frosting \= frosting;
 * bd->message \= g_strdup $(LPAREN)message$(RPAREN);
 * g_task_set_task_data $(LPAREN)task, bd, $(LPAREN)GDestroyNotify$(RPAREN) baking_data_free$(RPAREN);
 * _baker_begin_cake $(LPAREN)self, radius, flavor, cancellable, baked_cb, task$(RPAREN);
 * }
 * Cake *
 * baker_bake_cake_finish $(LPAREN)Baker         *self,
 * GAsyncResult  *result,
 * GError       **error$(RPAREN)
 * {
 * g_return_val_if_fail $(LPAREN)g_task_is_valid $(LPAREN)result, self$(RPAREN), NULL$(RPAREN);
 * return g_task_propagate_pointer $(LPAREN)G_TASK $(LPAREN)result$(RPAREN), error$(RPAREN);
 * }
 * ```
 * ## Asynchronous operations from synchronous ones
 * You can use [Gio.Task.runInThread] to turn a synchronous
 * operation into an asynchronous one, by running it in a thread.
 * When it completes, the result will be dispatched to the thread-default main
 * context $(LPAREN)see [GLib.MainContext.pushThreadDefault]$(RPAREN) where the `GTask`
 * was created.
 * Running a task in a thread:
 * ```c
 * typedef struct {
 * guint radius;
 * CakeFlavor flavor;
 * CakeFrostingType frosting;
 * char *message;
 * } CakeData;
 * static void
 * cake_data_free $(LPAREN)CakeData *cake_data$(RPAREN)
 * {
 * g_free $(LPAREN)cake_data->message$(RPAREN);
 * g_slice_free $(LPAREN)CakeData, cake_data$(RPAREN);
 * }
 * static void
 * bake_cake_thread $(LPAREN)GTask         *task,
 * gpointer       source_object,
 * gpointer       task_data,
 * GCancellable  *cancellable$(RPAREN)
 * {
 * Baker *self \= source_object;
 * CakeData *cake_data \= task_data;
 * Cake *cake;
 * GError *error \= NULL;
 * cake \= bake_cake $(LPAREN)baker, cake_data->radius, cake_data->flavor,
 * cake_data->frosting, cake_data->message,
 * cancellable, &error$(RPAREN);
 * if $(LPAREN)cake$(RPAREN)
 * g_task_return_pointer $(LPAREN)task, cake, g_object_unref$(RPAREN);
 * else
 * g_task_return_error $(LPAREN)task, error$(RPAREN);
 * }
 * void
 * baker_bake_cake_async $(LPAREN)Baker               *self,
 * guint                radius,
 * CakeFlavor           flavor,
 * CakeFrostingType     frosting,
 * const char          *message,
 * GCancellable        *cancellable,
 * GAsyncReadyCallback  callback,
 * gpointer             user_data$(RPAREN)
 * {
 * CakeData *cake_data;
 * GTask *task;
 * cake_data \= g_slice_new $(LPAREN)CakeData$(RPAREN);
 * cake_data->radius \= radius;
 * cake_data->flavor \= flavor;
 * cake_data->frosting \= frosting;
 * cake_data->message \= g_strdup $(LPAREN)message$(RPAREN);
 * task \= g_task_new $(LPAREN)self, cancellable, callback, user_data$(RPAREN);
 * g_task_set_task_data $(LPAREN)task, cake_data, $(LPAREN)GDestroyNotify$(RPAREN) cake_data_free$(RPAREN);
 * g_task_run_in_thread $(LPAREN)task, bake_cake_thread$(RPAREN);
 * g_object_unref $(LPAREN)task$(RPAREN);
 * }
 * Cake *
 * baker_bake_cake_finish $(LPAREN)Baker         *self,
 * GAsyncResult  *result,
 * GError       **error$(RPAREN)
 * {
 * g_return_val_if_fail $(LPAREN)g_task_is_valid $(LPAREN)result, self$(RPAREN), NULL$(RPAREN);
 * return g_task_propagate_pointer $(LPAREN)G_TASK $(LPAREN)result$(RPAREN), error$(RPAREN);
 * }
 * ```
 * ## Adding cancellability to uncancellable tasks
 * Finally, [Gio.Task.runInThread] and
 * [Gio.Task.runInThreadSync] can be used to turn an uncancellable
 * operation into a cancellable one. If you call
 * [Gio.Task.setReturnOnCancel], passing `TRUE`, then if the task’s
 * [Gio.Cancellable] is cancelled, it will return control back to the
 * caller immediately, while allowing the task thread to continue running in the
 * background $(LPAREN)and simply discarding its result when it finally does finish$(RPAREN).
 * Provided that the task thread is careful about how it uses
 * locks and other externally-visible resources, this allows you
 * to make ‘GLib-friendly’ asynchronous and cancellable
 * synchronous variants of blocking APIs.
 * Cancelling a task:
 * ```c
 * static void
 * bake_cake_thread $(LPAREN)GTask         *task,
 * gpointer       source_object,
 * gpointer       task_data,
 * GCancellable  *cancellable$(RPAREN)
 * {
 * Baker *self \= source_object;
 * CakeData *cake_data \= task_data;
 * Cake *cake;
 * GError *error \= NULL;
 * cake \= bake_cake $(LPAREN)baker, cake_data->radius, cake_data->flavor,
 * cake_data->frosting, cake_data->message,
 * &error$(RPAREN);
 * if $(LPAREN)error$(RPAREN)
 * {
 * g_task_return_error $(LPAREN)task, error$(RPAREN);
 * return;
 * }
 * // If the task has already been cancelled, then we don’t want to add
 * // the cake to the cake cache. Likewise, we don’t  want to have the
 * // task get cancelled in the middle of updating the cache.
 * // [Gio.Task.setReturnOnCancel] will return %TRUE here if it managed
 * // to disable return-on-cancel, or %FALSE if the task was cancelled
 * // before it could.
 * if $(LPAREN)g_task_set_return_on_cancel $(LPAREN)task, FALSE$(RPAREN)$(RPAREN)
 * {
 * // If the caller cancels at this point, their
 * // GAsyncReadyCallback won’t be invoked until we return,
 * // so we don’t have to worry that this code will run at
 * // the same time as that code does. But if there were
 * // other functions that might look at the cake cache,
 * // then we’d probably need a GMutex here as well.
 * baker_add_cake_to_cache $(LPAREN)baker, cake$(RPAREN);
 * g_task_return_pointer $(LPAREN)task, cake, g_object_unref$(RPAREN);
 * }
 * }
 * void
 * baker_bake_cake_async $(LPAREN)Baker               *self,
 * guint                radius,
 * CakeFlavor           flavor,
 * CakeFrostingType     frosting,
 * const char          *message,
 * GCancellable        *cancellable,
 * GAsyncReadyCallback  callback,
 * gpointer             user_data$(RPAREN)
 * {
 * CakeData *cake_data;
 * GTask *task;
 * cake_data \= g_slice_new $(LPAREN)CakeData$(RPAREN);
 * ...
 * task \= g_task_new $(LPAREN)self, cancellable, callback, user_data$(RPAREN);
 * g_task_set_task_data $(LPAREN)task, cake_data, $(LPAREN)GDestroyNotify$(RPAREN) cake_data_free$(RPAREN);
 * g_task_set_return_on_cancel $(LPAREN)task, TRUE$(RPAREN);
 * g_task_run_in_thread $(LPAREN)task, bake_cake_thread$(RPAREN);
 * }
 * Cake *
 * baker_bake_cake_sync $(LPAREN)Baker               *self,
 * guint                radius,
 * CakeFlavor           flavor,
 * CakeFrostingType     frosting,
 * const char          *message,
 * GCancellable        *cancellable,
 * GError             **error$(RPAREN)
 * {
 * CakeData *cake_data;
 * GTask *task;
 * Cake *cake;
 * cake_data \= g_slice_new $(LPAREN)CakeData$(RPAREN);
 * ...
 * task \= g_task_new $(LPAREN)self, cancellable, NULL, NULL$(RPAREN);
 * g_task_set_task_data $(LPAREN)task, cake_data, $(LPAREN)GDestroyNotify$(RPAREN) cake_data_free$(RPAREN);
 * g_task_set_return_on_cancel $(LPAREN)task, TRUE$(RPAREN);
 * g_task_run_in_thread_sync $(LPAREN)task, bake_cake_thread$(RPAREN);
 * cake \= g_task_propagate_pointer $(LPAREN)task, error$(RPAREN);
 * g_object_unref $(LPAREN)task$(RPAREN);
 * return cake;
 * }
 * ```
 * ## Porting from [Gio.SimpleAsyncResult]
 * `GTask`’s API attempts to be simpler than [Gio.SimpleAsyncResult]’s
 * in several ways:
 * - You can save task-specific data with [Gio.Task.setTaskData], and
 * retrieve it later with [Gio.Task.getTaskData]. This replaces the
 * abuse of [Gio.SimpleAsyncResult.setOpResGpointer] for the same
 * purpose with [Gio.SimpleAsyncResult].
 * - In addition to the task data, `GTask` also keeps track of the
 * [priority](iface.AsyncResult.html#io-priority), [Gio.Cancellable],
 * and [GLib.MainContext] associated with the task, so tasks that
 * consist of a chain of simpler asynchronous operations will have easy access
 * to those values when starting each sub-task.
 * - [Gio.Task.returnErrorIfCancelled] provides simplified
 * handling for cancellation. In addition, cancellation
 * overrides any other `GTask` return value by default, like
 * [Gio.SimpleAsyncResult] does when
 * [Gio.SimpleAsyncResult.setCheckCancellable] is called.
 * $(LPAREN)You can use [Gio.Task.setCheckCancellable] to turn off that
 * behavior.$(RPAREN) On the other hand, [Gio.Task.runInThread]
 * guarantees that it will always run your
 * `task_func`, even if the task’s [Gio.Cancellable]
 * is already cancelled before the task gets a chance to run;
 * you can start your `task_func` with a
 * [Gio.Task.returnErrorIfCancelled] check if you need the
 * old behavior.
 * - The ‘return’ methods $(LPAREN)eg, [Gio.Task.returnPointer]$(RPAREN)
 * automatically cause the task to be ‘completed’ as well, and
 * there is no need to worry about the ‘complete’ vs ‘complete in idle’
 * distinction. $(LPAREN)`GTask` automatically figures out
 * whether the task’s callback can be invoked directly, or
 * if it needs to be sent to another [GLib.MainContext], or delayed
 * until the next iteration of the current [GLib.MainContext].$(RPAREN)
 * - The ‘finish’ functions for `GTask` based operations are generally
 * much simpler than [Gio.SimpleAsyncResult] ones, normally consisting
 * of only a single call to [Gio.Task.propagatePointer] or the like.
 * Since [Gio.Task.propagatePointer] ‘steals’ the return value from
 * the `GTask`, it is not necessary to juggle pointers around to
 * prevent it from being freed twice.
 * - With [Gio.SimpleAsyncResult], it was common to call
 * [Gio.SimpleAsyncResult.propagateError] from the
 * `_finish$(LPAREN)$(RPAREN)` wrapper function, and have
 * virtual method implementations only deal with successful
 * returns. This behavior is deprecated, because it makes it
 * difficult for a subclass to chain to a parent class’s async
 * methods. Instead, the wrapper function should just be a
 * simple wrapper, and the virtual method should call an
 * appropriate `g_task_propagate_` function.
 * Note that wrapper methods can now use
 * [Gio.AsyncResult.legacyPropagateError] to do old-style
 * [Gio.SimpleAsyncResult] error-returning behavior, and
 * [Gio.AsyncResult.isTagged] to check if a result is tagged as
 * having come from the `_async$(LPAREN)$(RPAREN)` wrapper
 * function $(LPAREN)for ‘short-circuit’ results, such as when passing
 * `0` to [Gio.InputStream.readAsync]$(RPAREN).
 * ## Thread-safety considerations
 * Due to some infelicities in the API design, there is a
 * thread-safety concern that users of `GTask` have to be aware of:
 * If the `main` thread drops its last reference to the source object
 * or the task data before the task is finalized, then the finalizers
 * of these objects may be called on the worker thread.
 * This is a problem if the finalizers use non-threadsafe API, and
 * can lead to hard-to-debug crashes. Possible workarounds include:
 * - Clear task data in a signal handler for `notify::completed`
 * - Keep iterating a main context in the main thread and defer
 * dropping the reference to the source object to that main
 * context when the task is finalized
 */
class Task : ObjectG, AsyncResult
{

  this()
  {
  }

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_task_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin AsyncResultT!GTask;

  /**
   * Creates a #GTask acting on source_object, which will eventually be
   * used to invoke callback in the current
   * [thread-default main context][g-main-context-push-thread-default].
   * Call this in the "start" method of your asynchronous method, and
   * pass the #GTask around throughout the asynchronous operation. You
   * can use [Gio.Task.setTaskData] to attach task-specific data to the
   * object, which you can retrieve later via [Gio.Task.getTaskData].
   * By default, if cancellable is cancelled, then the return value of
   * the task will always be %G_IO_ERROR_CANCELLED, even if the task had
   * already completed before the cancellation. This allows for
   * simplified handling in cases where cancellation may imply that
   * other objects that the task depends on have been destroyed. If you
   * do not want this behavior, you can use
   * [Gio.Task.setCheckCancellable] to change it.
   * Params:
   *   sourceObject = the #GObject that owns
   *     this task, or %NULL.
   *   cancellable = optional #GCancellable object, %NULL to ignore.
   *   callback = a #GAsyncReadyCallback.
   * Returns: a #GTask.
   */
  this(ObjectG sourceObject, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(AsyncReadyCallback*)data;

      (*_dlg)(sourceObject ? ObjectG.getDObject!ObjectG(cast(void*)sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(cast(void*)res, false) : null);
    }

    GTask* _cretval;
    auto _callback = freezeDelegate(cast(void*)&callback);
    _cretval = g_task_new(sourceObject ? cast(ObjectC*)sourceObject.cPtr(false) : null, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_callbackCallback, _callback);
    this(_cretval, true);
  }

  /**
   * Checks that result is a #GTask, and that source_object is its
   * source object $(LPAREN)or that source_object is %NULL and result has no
   * source object$(RPAREN). This can be used in g_return_if_fail$(LPAREN)$(RPAREN) checks.
   * Params:
   *   result = A #GAsyncResult
   *   sourceObject = the source object
   *     expected to be associated with the task
   * Returns: %TRUE if result and source_object are valid, %FALSE
   *   if not
   */
  static bool isValid(AsyncResult result, ObjectG sourceObject)
  {
    bool _retval;
    _retval = g_task_is_valid(result ? cast(GAsyncResult*)(cast(ObjectG)result).cPtr(false) : null, sourceObject ? cast(ObjectC*)sourceObject.cPtr(false) : null);
    return _retval;
  }

  /**
   * Creates a #GTask and then immediately calls [Gio.Task.returnError]
   * on it. Use this in the wrapper function of an asynchronous method
   * when you want to avoid even calling the virtual method. You can
   * then use [Gio.AsyncResult.isTagged] in the finish method wrapper to
   * check if the result there is tagged as having been created by the
   * wrapper method, and deal with it appropriately if so.
   * See also [Gio.Task.reportNewError].
   * Params:
   *   sourceObject = the #GObject that owns
   *     this task, or %NULL.
   *   callback = a #GAsyncReadyCallback.
   *   sourceTag = an opaque pointer indicating the source of this task
   *   error = error to report
   */
  static void reportError(ObjectG sourceObject, AsyncReadyCallback callback, void* sourceTag, ErrorG error)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(AsyncReadyCallback*)data;

      (*_dlg)(sourceObject ? ObjectG.getDObject!ObjectG(cast(void*)sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(cast(void*)res, false) : null);
    }

    auto _callback = freezeDelegate(cast(void*)&callback);
    g_task_report_error(sourceObject ? cast(ObjectC*)sourceObject.cPtr(false) : null, &_callbackCallback, _callback, sourceTag, error ? cast(GError*)error.cPtr : null);
  }

  /**
   * Gets task's #GCancellable
   * Returns: task's #GCancellable
   */
  Cancellable getCancellable()
  {
    GCancellable* _cretval;
    _cretval = g_task_get_cancellable(cast(GTask*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Cancellable(cast(GCancellable*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets task's check-cancellable flag. See
   * [Gio.Task.setCheckCancellable] for more details.
   * Returns:
   */
  bool getCheckCancellable()
  {
    bool _retval;
    _retval = g_task_get_check_cancellable(cast(GTask*)cPtr);
    return _retval;
  }

  /**
   * Gets the value of #GTask:completed. This changes from %FALSE to %TRUE after
   * the task’s callback is invoked, and will return %FALSE if called from inside
   * the callback.
   * Returns: %TRUE if the task has completed, %FALSE otherwise.
   */
  bool getCompleted()
  {
    bool _retval;
    _retval = g_task_get_completed(cast(GTask*)cPtr);
    return _retval;
  }

  /**
   * Gets the #GMainContext that task will return its result in $(LPAREN)that
   * is, the context that was the
   * [thread-default main context][g-main-context-push-thread-default]
   * at the point when task was created$(RPAREN).
   * This will always return a non-%NULL value, even if the task's
   * context is the default #GMainContext.
   * Returns: task's #GMainContext
   */
  MainContext getContext()
  {
    GMainContext* _cretval;
    _cretval = g_task_get_context(cast(GTask*)cPtr);
    auto _retval = _cretval ? new MainContext(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets task’s name. See [Gio.Task.setName].
   * Returns: task’s name, or %NULL
   */
  string getName()
  {
    const(char)* _cretval;
    _cretval = g_task_get_name(cast(GTask*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Gets task's priority
   * Returns: task's priority
   */
  int getPriority()
  {
    int _retval;
    _retval = g_task_get_priority(cast(GTask*)cPtr);
    return _retval;
  }

  /**
   * Gets task's return-on-cancel flag. See
   * [Gio.Task.setReturnOnCancel] for more details.
   * Returns:
   */
  bool getReturnOnCancel()
  {
    bool _retval;
    _retval = g_task_get_return_on_cancel(cast(GTask*)cPtr);
    return _retval;
  }

  /**
   * Gets the source object from task. Like
   * [Gio.AsyncResult.getSourceObject], but does not ref the object.
   * Returns: task's source object, or %NULL
   */
  ObjectG getSourceObject()
  {
    ObjectC* _cretval;
    _cretval = g_task_get_source_object(cast(GTask*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!ObjectG(cast(ObjectC*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets task's source tag. See [Gio.Task.setSourceTag].
   * Returns: task's source tag
   */
  void* getSourceTag()
  {
    void* _retval;
    _retval = g_task_get_source_tag(cast(GTask*)cPtr);
    return _retval;
  }

  /**
   * Gets task's `task_data`.
   * Returns: task's `task_data`.
   */
  void* getTaskData()
  {
    void* _retval;
    _retval = g_task_get_task_data(cast(GTask*)cPtr);
    return _retval;
  }

  /**
   * Tests if task resulted in an error.
   * Returns: %TRUE if the task resulted in an error, %FALSE otherwise.
   */
  bool hadError()
  {
    bool _retval;
    _retval = g_task_had_error(cast(GTask*)cPtr);
    return _retval;
  }

  /**
   * Gets the result of task as a #gboolean.
   * If the task resulted in an error, or was cancelled, then this will
   * instead return %FALSE and set error.
   * Since this method transfers ownership of the return value $(LPAREN)or
   * error$(RPAREN) to the caller, you may only call it once.
   * Returns: the task result, or %FALSE on error
   */
  bool propagateBoolean()
  {
    bool _retval;
    GError *_err;
    _retval = g_task_propagate_boolean(cast(GTask*)cPtr, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Gets the result of task as an integer $(LPAREN)#gssize$(RPAREN).
   * If the task resulted in an error, or was cancelled, then this will
   * instead return -1 and set error.
   * Since this method transfers ownership of the return value $(LPAREN)or
   * error$(RPAREN) to the caller, you may only call it once.
   * Returns: the task result, or -1 on error
   */
  ptrdiff_t propagateInt()
  {
    ptrdiff_t _retval;
    GError *_err;
    _retval = g_task_propagate_int(cast(GTask*)cPtr, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Gets the result of task as a pointer, and transfers ownership
   * of that value to the caller.
   * If the task resulted in an error, or was cancelled, then this will
   * instead return %NULL and set error.
   * Since this method transfers ownership of the return value $(LPAREN)or
   * error$(RPAREN) to the caller, you may only call it once.
   * Returns: the task result, or %NULL on error
   */
  void* propagatePointer()
  {
    void* _retval;
    GError *_err;
    _retval = g_task_propagate_pointer(cast(GTask*)cPtr, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Gets the result of task as a #GValue, and transfers ownership of
   * that value to the caller. As with [Gio.Task.returnValue], this is
   * a generic low-level method; [Gio.Task.propagatePointer] and the like
   * will usually be more useful for C code.
   * If the task resulted in an error, or was cancelled, then this will
   * instead set error and return %FALSE.
   * Since this method transfers ownership of the return value $(LPAREN)or
   * error$(RPAREN) to the caller, you may only call it once.
   * Params:
   *   value = return location for the #GValue
   * Returns: %TRUE if task succeeded, %FALSE on error.
   */
  bool propagateValue(out Value value)
  {
    bool _retval;
    GValue _value;
    GError *_err;
    _retval = g_task_propagate_value(cast(GTask*)cPtr, &_value, &_err);
    if (_err)
      throw new ErrorG(_err);
    value = new Value(cast(void*)&_value, false);
    return _retval;
  }

  /**
   * Sets task's result to result and completes the task $(LPAREN)see
   * [Gio.Task.returnPointer] for more discussion of exactly what this
   * means$(RPAREN).
   * Params:
   *   result = the #gboolean result of a task function.
   */
  void returnBoolean(bool result)
  {
    g_task_return_boolean(cast(GTask*)cPtr, result);
  }

  /**
   * Sets task's result to error $(LPAREN)which task assumes ownership of$(RPAREN)
   * and completes the task $(LPAREN)see [Gio.Task.returnPointer] for more
   * discussion of exactly what this means$(RPAREN).
   * Note that since the task takes ownership of error, and since the
   * task may be completed before returning from [Gio.Task.returnError],
   * you cannot assume that error is still valid after calling this.
   * Call [GLib.ErrorG.copy] on the error if you need to keep a local copy
   * as well.
   * See also [Gio.Task.returnNewError],
   * [Gio.Task.returnNewErrorLiteral].
   * Params:
   *   error = the #GError result of a task function.
   */
  void returnError(ErrorG error)
  {
    g_task_return_error(cast(GTask*)cPtr, error ? cast(GError*)error.cPtr : null);
  }

  /**
   * Checks if task's #GCancellable has been cancelled, and if so, sets
   * task's error accordingly and completes the task $(LPAREN)see
   * [Gio.Task.returnPointer] for more discussion of exactly what this
   * means$(RPAREN).
   * Returns: %TRUE if task has been cancelled, %FALSE if not
   */
  bool returnErrorIfCancelled()
  {
    bool _retval;
    _retval = g_task_return_error_if_cancelled(cast(GTask*)cPtr);
    return _retval;
  }

  /**
   * Sets task's result to result and completes the task $(LPAREN)see
   * [Gio.Task.returnPointer] for more discussion of exactly what this
   * means$(RPAREN).
   * Params:
   *   result = the integer $(LPAREN)#gssize$(RPAREN) result of a task function.
   */
  void returnInt(ptrdiff_t result)
  {
    g_task_return_int(cast(GTask*)cPtr, result);
  }

  /**
   * Sets task’s result to a new [GLib.ErrorG] created from domain, code,
   * message and completes the task.
   * See [Gio.Task.returnPointer] for more discussion of exactly what
   * ‘completing the task’ means.
   * See also [Gio.Task.returnNewError].
   * Params:
   *   domain = a #GQuark.
   *   code = an error code.
   *   message = an error message
   */
  void returnNewErrorLiteral(Quark domain, int code, string message)
  {
    const(char)* _message = message.toCString(false);
    g_task_return_new_error_literal(cast(GTask*)cPtr, domain, code, _message);
  }

  /**
   * Sets task's result to result and completes the task. If result
   * is not %NULL, then result_destroy will be used to free result if
   * the caller does not take ownership of it with
   * [Gio.Task.propagatePointer].
   * "Completes the task" means that for an ordinary asynchronous task
   * it will either invoke the task's callback, or else queue that
   * callback to be invoked in the proper #GMainContext, or in the next
   * iteration of the current #GMainContext. For a task run via
   * [Gio.Task.runInThread] or [Gio.Task.runInThreadSync], calling this
   * method will save result to be returned to the caller later, but
   * the task will not actually be completed until the #GTaskThreadFunc
   * exits.
   * Note that since the task may be completed before returning from
   * [Gio.Task.returnPointer], you cannot assume that result is still
   * valid after calling this, unless you are still holding another
   * reference on it.
   * Params:
   *   result = the pointer result of a task
   *     function
   *   resultDestroy = a #GDestroyNotify function.
   */
  void returnPointer(void* result, DestroyNotify resultDestroy)
  {
    extern(C) void _resultDestroyCallback(void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(DestroyNotify*)data;

      (*_dlg)();
    }
    g_task_return_pointer(cast(GTask*)cPtr, result, &_resultDestroyCallback);
  }

  /**
   * Sets task's result to result $(LPAREN)by copying it$(RPAREN) and completes the task.
   * If result is %NULL then a #GValue of type %G_TYPE_POINTER
   * with a value of %NULL will be used for the result.
   * This is a very generic low-level method intended primarily for use
   * by language bindings; for C code, [Gio.Task.returnPointer] and the
   * like will normally be much easier to use.
   * Params:
   *   result = the #GValue result of
   *     a task function
   */
  void returnValue(Value result)
  {
    g_task_return_value(cast(GTask*)cPtr, result ? cast(GValue*)result.cPtr(false) : null);
  }

  /**
   * Runs task_func in another thread. When task_func returns, task's
   * #GAsyncReadyCallback will be invoked in task's #GMainContext.
   * This takes a ref on task until the task completes.
   * See #GTaskThreadFunc for more details about how task_func is handled.
   * Although GLib currently rate-limits the tasks queued via
   * [Gio.Task.runInThread], you should not assume that it will always
   * do this. If you have a very large number of tasks to run $(LPAREN)several tens of
   * tasks$(RPAREN), but don't want them to all run at once, you should only queue a
   * limited number of them $(LPAREN)around ten$(RPAREN) at a time.
   * Be aware that if your task depends on other tasks to complete, use of this
   * function could lead to a livelock if the other tasks also use this function
   * and enough of them $(LPAREN)around 10$(RPAREN) execute in a dependency chain, as that will
   * exhaust the thread pool. If this situation is possible, consider using a
   * separate worker thread or thread pool explicitly, rather than using
   * [Gio.Task.runInThread].
   * Params:
   *   taskFunc = a #GTaskThreadFunc
   */
  void runInThread(TaskThreadFunc taskFunc)
  {
    extern(C) void _taskFuncCallback(GTask* task, ObjectC* sourceObject, void* taskData, GCancellable* cancellable)
    {
      ptrThawGC(taskData);
      auto _dlg = cast(TaskThreadFunc*)taskData;

      (*_dlg)(task ? ObjectG.getDObject!Task(cast(void*)task, false) : null, sourceObject ? ObjectG.getDObject!ObjectG(cast(void*)sourceObject, false) : null, cancellable ? ObjectG.getDObject!Cancellable(cast(void*)cancellable, false) : null);
    }
    g_task_run_in_thread(cast(GTask*)cPtr, &_taskFuncCallback);
  }

  /**
   * Runs task_func in another thread, and waits for it to return or be
   * cancelled. You can use [Gio.Task.propagatePointer], etc, afterward
   * to get the result of task_func.
   * See #GTaskThreadFunc for more details about how task_func is handled.
   * Normally this is used with tasks created with a %NULL
   * `callback`, but note that even if the task does
   * have a callback, it will not be invoked when task_func returns.
   * #GTask:completed will be set to %TRUE just before this function returns.
   * Although GLib currently rate-limits the tasks queued via
   * [Gio.Task.runInThreadSync], you should not assume that it will
   * always do this. If you have a very large number of tasks to run,
   * but don't want them to all run at once, you should only queue a
   * limited number of them at a time.
   * Params:
   *   taskFunc = a #GTaskThreadFunc
   */
  void runInThreadSync(TaskThreadFunc taskFunc)
  {
    extern(C) void _taskFuncCallback(GTask* task, ObjectC* sourceObject, void* taskData, GCancellable* cancellable)
    {
      ptrThawGC(taskData);
      auto _dlg = cast(TaskThreadFunc*)taskData;

      (*_dlg)(task ? ObjectG.getDObject!Task(cast(void*)task, false) : null, sourceObject ? ObjectG.getDObject!ObjectG(cast(void*)sourceObject, false) : null, cancellable ? ObjectG.getDObject!Cancellable(cast(void*)cancellable, false) : null);
    }
    g_task_run_in_thread_sync(cast(GTask*)cPtr, &_taskFuncCallback);
  }

  /**
   * Sets or clears task's check-cancellable flag. If this is %TRUE
   * $(LPAREN)the default$(RPAREN), then [Gio.Task.propagatePointer], etc, and
   * [Gio.Task.hadError] will check the task's #GCancellable first, and
   * if it has been cancelled, then they will consider the task to have
   * returned an "Operation was cancelled" error
   * $(LPAREN)%G_IO_ERROR_CANCELLED$(RPAREN), regardless of any other error or return
   * value the task may have had.
   * If check_cancellable is %FALSE, then the #GTask will not check the
   * cancellable itself, and it is up to task's owner to do this $(LPAREN)eg,
   * via [Gio.Task.returnErrorIfCancelled]$(RPAREN).
   * If you are using [Gio.Task.setReturnOnCancel] as well, then
   * you must leave check-cancellable set %TRUE.
   * Params:
   *   checkCancellable = whether #GTask will check the state of
   *     its #GCancellable for you.
   */
  void setCheckCancellable(bool checkCancellable)
  {
    g_task_set_check_cancellable(cast(GTask*)cPtr, checkCancellable);
  }

  /**
   * Sets task’s name, used in debugging and profiling. The name defaults to
   * %NULL.
   * The task name should describe in a human readable way what the task does.
   * For example, ‘Open file’ or ‘Connect to network host’. It is used to set the
   * name of the #GSource used for idle completion of the task.
   * This function may only be called before the task is first used in a thread
   * other than the one it was constructed in. It is called automatically by
   * [Gio.Task.setSourceTag] if not called already.
   * Params:
   *   name = a human readable name for the task, or %NULL to unset it
   */
  void setName(string name)
  {
    const(char)* _name = name.toCString(false);
    g_task_set_name(cast(GTask*)cPtr, _name);
  }

  /**
   * Sets task's priority. If you do not call this, it will default to
   * %G_PRIORITY_DEFAULT.
   * This will affect the priority of #GSources created with
   * [Gio.Task.attachSource] and the scheduling of tasks run in threads,
   * and can also be explicitly retrieved later via
   * [Gio.Task.getPriority].
   * Params:
   *   priority = the [priority](iface.AsyncResult.html#io-priority) of the request
   */
  void setPriority(int priority)
  {
    g_task_set_priority(cast(GTask*)cPtr, priority);
  }

  /**
   * Sets or clears task's return-on-cancel flag. This is only
   * meaningful for tasks run via [Gio.Task.runInThread] or
   * [Gio.Task.runInThreadSync].
   * If return_on_cancel is %TRUE, then cancelling task's
   * #GCancellable will immediately cause it to return, as though the
   * task's #GTaskThreadFunc had called
   * [Gio.Task.returnErrorIfCancelled] and then returned.
   * This allows you to create a cancellable wrapper around an
   * uninterruptible function. The #GTaskThreadFunc just needs to be
   * careful that it does not modify any externally-visible state after
   * it has been cancelled. To do that, the thread should call
   * [Gio.Task.setReturnOnCancel] again to (atomically) set
   * return-on-cancel %FALSE before making externally-visible changes;
   * if the task gets cancelled before the return-on-cancel flag could
   * be changed, [Gio.Task.setReturnOnCancel] will indicate this by
   * returning %FALSE.
   * You can disable and re-enable this flag multiple times if you wish.
   * If the task's #GCancellable is cancelled while return-on-cancel is
   * %FALSE, then calling [Gio.Task.setReturnOnCancel] to set it %TRUE
   * again will cause the task to be cancelled at that point.
   * If the task's #GCancellable is already cancelled before you call
   * [Gio.Task.runInThread]/[Gio.Task.runInThreadSync], then the
   * #GTaskThreadFunc will still be run $(LPAREN)for consistency$(RPAREN), but the task
   * will also be completed right away.
   * Params:
   *   returnOnCancel = whether the task returns automatically when
   *     it is cancelled.
   * Returns: %TRUE if task's return-on-cancel flag was changed to
   *   match return_on_cancel. %FALSE if task has already been
   *   cancelled.
   */
  bool setReturnOnCancel(bool returnOnCancel)
  {
    bool _retval;
    _retval = g_task_set_return_on_cancel(cast(GTask*)cPtr, returnOnCancel);
    return _retval;
  }

  /**
   * Sets task's source tag.
   * You can use this to tag a task return
   * value with a particular pointer $(LPAREN)usually a pointer to the function
   * doing the tagging$(RPAREN) and then later check it using
   * [Gio.Task.getSourceTag] [](or Gio.AsyncResult.isTagged) in the
   * task's "finish" function, to figure out if the response came from a
   * particular place.
   * A macro wrapper around this function will automatically set the
   * task’s name to the string form of source_tag if it’s not already
   * set, for convenience.
   * Params:
   *   sourceTag = an opaque pointer indicating the source of this task
   */
  void setSourceTag(void* sourceTag)
  {
    g_task_set_source_tag(cast(GTask*)cPtr, sourceTag);
  }

  /**
   * Sets task’s name, used in debugging and profiling.
   * This is a variant of [Gio.Task.setName] that avoids copying name.
   * Params:
   *   name = a human readable name for the task. Must be a string literal
   */
  void setStaticName(string name)
  {
    const(char)* _name = name.toCString(false);
    g_task_set_static_name(cast(GTask*)cPtr, _name);
  }

  /**
   * Sets task's task data $(LPAREN)freeing the existing task data, if any$(RPAREN).
   * Params:
   *   taskData = task-specific data
   *   taskDataDestroy = #GDestroyNotify for task_data
   */
  void setTaskData(void* taskData, DestroyNotify taskDataDestroy)
  {
    extern(C) void _taskDataDestroyCallback(void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(DestroyNotify*)data;

      (*_dlg)();
    }
    g_task_set_task_data(cast(GTask*)cPtr, taskData, &_taskDataDestroyCallback);
  }
}
