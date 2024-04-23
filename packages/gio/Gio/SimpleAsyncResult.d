module Gio.SimpleAsyncResult;

import GLib.ErrorG;
import GLib.Types;
import GObject.ObjectG;
import GObject.Types;
import Gid.Gid;
import Gio.AsyncResult;
import Gio.AsyncResultT;
import Gio.Cancellable;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * As of GLib 2.46, #GSimpleAsyncResult is deprecated in favor of
 * #GTask, which provides a simpler API.
 *
 * #GSimpleAsyncResult implements #GAsyncResult.
 *
 * GSimpleAsyncResult handles #GAsyncReadyCallbacks, error
 * reporting, operation cancellation and the final state of an operation,
 * completely transparent to the application. Results can be returned
 * as a pointer e.g. for functions that return data that is collected
 * asynchronously, a boolean value for checking the success or failure
 * of an operation, or a #gssize for operations which return the number
 * of bytes modified by the operation; all of the simple return cases
 * are covered.
 *
 * Most of the time, an application will not need to know of the details
 * of this API; it is handled transparently, and any necessary operations
 * are handled by #GAsyncResult's interface. However, if implementing a
 * new GIO module, for writing language bindings, or for complex
 * applications that need better control of how asynchronous operations
 * are completed, it is important to understand this functionality.
 *
 * GSimpleAsyncResults are tagged with the calling function to ensure
 * that asynchronous functions and their finishing functions are used
 * together correctly.
 *
 * To create a new #GSimpleAsyncResult, call g_simple_async_result_new().
 * If the result needs to be created for a #GError, use
 * g_simple_async_result_new_from_error() or
 * g_simple_async_result_new_take_error(). If a #GError is not available
 * (e.g. the asynchronous operation's doesn't take a #GError argument),
 * but the result still needs to be created for an error condition, use
 * g_simple_async_result_new_error() (or g_simple_async_result_set_error_va()
 * if your application or binding requires passing a variable argument list
 * directly), and the error can then be propagated through the use of
 * g_simple_async_result_propagate_error().
 *
 * An asynchronous operation can be made to ignore a cancellation event by
 * calling g_simple_async_result_set_handle_cancellation() with a
 * #GSimpleAsyncResult for the operation and %FALSE. This is useful for
 * operations that are dangerous to cancel, such as close (which would
 * cause a leak if cancelled before being run).
 *
 * GSimpleAsyncResult can integrate into GLib's event loop, #GMainLoop,
 * or it can use #GThreads.
 * g_simple_async_result_complete() will finish an I/O task directly
 * from the point where it is called. g_simple_async_result_complete_in_idle()
 * will finish it from an idle handler in the
 * [thread-default main context][g-main-context-push-thread-default]
 * where the #GSimpleAsyncResult was created.
 * g_simple_async_result_run_in_thread() will run the job in a
 * separate thread and then use
 * g_simple_async_result_complete_in_idle() to deliver the result.
 *
 * To set the results of an asynchronous function,
 * g_simple_async_result_set_op_res_gpointer(),
 * g_simple_async_result_set_op_res_gboolean(), and
 * g_simple_async_result_set_op_res_gssize()
 * are provided, setting the operation's result to a gpointer, gboolean, or
 * gssize, respectively.
 *
 * Likewise, to get the result of an asynchronous function,
 * g_simple_async_result_get_op_res_gpointer(),
 * g_simple_async_result_get_op_res_gboolean(), and
 * g_simple_async_result_get_op_res_gssize() are
 * provided, getting the operation's result as a gpointer, gboolean, and
 * gssize, respectively.
 *
 * For the details of the requirements implementations must respect, see
 * #GAsyncResult.  A typical implementation of an asynchronous operation
 * using GSimpleAsyncResult looks something like this:
 *
 * |[<!-- language="C" -->
 * static void
 * baked_cb (Cake    *cake,
 * gpointer user_data)
 * {
 * // In this example, this callback is not given a reference to the cake,
 * // so the GSimpleAsyncResult has to take a reference to it.
 * GSimpleAsyncResult *result = user_data;
 *
 * if (cake == NULL)
 * g_simple_async_result_set_error (result,
 * BAKER_ERRORS,
 * BAKER_ERROR_NO_FLOUR,
 * "Go to the supermarket");
 * else
 * g_simple_async_result_set_op_res_gpointer (result,
 * g_object_ref (cake),
 * g_object_unref);
 *
 *
 * // In this example, we assume that baked_cb is called as a callback from
 * // the mainloop, so it's safe to complete the operation synchronously here.
 * // If, however, _baker_prepare_cake () might call its callback without
 * // first returning to the mainloop — inadvisable, but some APIs do so —
 * // we would need to use g_simple_async_result_complete_in_idle().
 * g_simple_async_result_complete (result);
 * g_object_unref (result);
 * }
 *
 * void
 * baker_bake_cake_async (Baker              *self,
 * guint               radius,
 * GAsyncReadyCallback callback,
 * gpointer            user_data)
 * {
 * GSimpleAsyncResult *simple;
 * Cake               *cake;
 *
 * if (radius < 3)
 * {
 * g_simple_async_report_error_in_idle (G_OBJECT (self),
 * callback,
 * user_data,
 * BAKER_ERRORS,
 * BAKER_ERROR_TOO_SMALL,
 * "%ucm radius cakes are silly",
 * radius);
 * return;
 * }
 *
 * simple = g_simple_async_result_new (G_OBJECT (self),
 * callback,
 * user_data,
 * baker_bake_cake_async);
 * cake = _baker_get_cached_cake (self, radius);
 *
 * if (cake != NULL)
 * {
 * g_simple_async_result_set_op_res_gpointer (simple,
 * g_object_ref (cake),
 * g_object_unref);
 * g_simple_async_result_complete_in_idle (simple);
 * g_object_unref (simple);
 * // Drop the reference returned by _baker_get_cached_cake();
 * // the GSimpleAsyncResult has taken its own reference.
 * g_object_unref (cake);
 * return;
 * }
 *
 * _baker_prepare_cake (self, radius, baked_cb, simple);
 * }
 *
 * Cake *
 * baker_bake_cake_finish (Baker        *self,
 * GAsyncResult *result,
 * GError      **error)
 * {
 * GSimpleAsyncResult *simple;
 * Cake               *cake;
 *
 * g_return_val_if_fail (g_simple_async_result_is_valid (result,
 * G_OBJECT (self),
 * baker_bake_cake_async),
 * NULL);
 *
 * simple = (GSimpleAsyncResult *) result;
 *
 * if (g_simple_async_result_propagate_error (simple, error))
 * return NULL;
 *
 * cake = CAKE (g_simple_async_result_get_op_res_gpointer (simple));
 * return g_object_ref (cake);
 * }
 * ]|
 */
class SimpleAsyncResult : ObjectG, AsyncResult
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_simple_async_result_get_type();
  }

  mixin AsyncResultT!GSimpleAsyncResult;

  /**
   * a #GSimpleAsyncResult.
   */
  this(ObjectG sourceObject, AsyncReadyCallback callback, void* sourceTag)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    GSimpleAsyncResult* _cretval;
    ptrFreezeGC(cast(void*)&callback);
    _cretval = g_simple_async_result_new(sourceObject ? sourceObject.cPtr!ObjectC : null, &_callbackCallback, cast(void*)&callback, sourceTag);
    this(_cretval, true);
  }

  /**
   * a #GSimpleAsyncResult.
   */
  static SimpleAsyncResult newFromError(ObjectG sourceObject, AsyncReadyCallback callback, ErrorG error)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    GSimpleAsyncResult* _cretval;
    ptrFreezeGC(cast(void*)&callback);
    _cretval = g_simple_async_result_new_from_error(sourceObject ? sourceObject.cPtr!ObjectC : null, &_callbackCallback, cast(void*)&callback, error ? error.cPtr!GError : null);
    SimpleAsyncResult _retval = ObjectG.getDObject!SimpleAsyncResult(cast(GSimpleAsyncResult*)_cretval, true);
    return _retval;
  }

  /**
   * #TRUE if all checks passed or #FALSE if any failed.
   */
  static bool isValid(AsyncResult result, ObjectG source, void* sourceTag)
  {
    bool _retval;
    _retval = g_simple_async_result_is_valid(result ? (cast(ObjectG)result).cPtr!GAsyncResult : null, source ? source.cPtr!ObjectC : null, sourceTag);
    return _retval;
  }

  /**
   * Completes an asynchronous I/O job immediately. Must be called in
   * the thread where the asynchronous result was to be delivered, as it
   * invokes the callback directly. If you are in a different thread use
   * g_simple_async_result_complete_in_idle().
   *
   * Calling this function takes a reference to @simple for as long as
   * is needed to complete the call.
   */
  void complete()
  {
    g_simple_async_result_complete(cPtr!GSimpleAsyncResult);
  }

  /**
   * Completes an asynchronous function in an idle handler in the
   * [thread-default main context][g-main-context-push-thread-default]
   * of the thread that @simple was initially created in
   * (and re-pushes that context around the invocation of the callback).
   *
   * Calling this function takes a reference to @simple for as long as
   * is needed to complete the call.
   */
  void completeInIdle()
  {
    g_simple_async_result_complete_in_idle(cPtr!GSimpleAsyncResult);
  }

  /**
   * %TRUE if the operation's result was %TRUE, %FALSE
   * if the operation's result was %FALSE.
   */
  bool getOpResGboolean()
  {
    bool _retval;
    _retval = g_simple_async_result_get_op_res_gboolean(cPtr!GSimpleAsyncResult);
    return _retval;
  }

  /**
   * a gssize returned from the asynchronous function.
   */
  ptrdiff_t getOpResGssize()
  {
    ptrdiff_t _retval;
    _retval = g_simple_async_result_get_op_res_gssize(cPtr!GSimpleAsyncResult);
    return _retval;
  }

  /**
   * %TRUE if the error was propagated to @dest. %FALSE otherwise.
   */
  bool propagateError()
  {
    bool _retval;
    GError *_err;
    _retval = g_simple_async_result_propagate_error(cPtr!GSimpleAsyncResult, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Sets a #GCancellable to check before dispatching results.
   *
   * This function has one very specific purpose: the provided cancellable
   * is checked at the time of g_simple_async_result_propagate_error() If
   * it is cancelled, these functions will return an "Operation was
   * cancelled" error (%G_IO_ERROR_CANCELLED).
   *
   * Implementors of cancellable asynchronous functions should use this in
   * order to provide a guarantee to their callers that cancelling an
   * async operation will reliably result in an error being returned for
   * that operation (even if a positive result for the operation has
   * already been sent as an idle to the main context to be dispatched).
   *
   * The checking described above is done regardless of any call to the
   * unrelated g_simple_async_result_set_handle_cancellation() function.
   */
  void setCheckCancellable(Cancellable checkCancellable)
  {
    g_simple_async_result_set_check_cancellable(cPtr!GSimpleAsyncResult, checkCancellable ? checkCancellable.cPtr!GCancellable : null);
  }

  /**
   * Sets the result from a #GError.
   */
  void setFromError(ErrorG error)
  {
    g_simple_async_result_set_from_error(cPtr!GSimpleAsyncResult, error ? error.cPtr!GError : null);
  }

  /**
   * Sets whether to handle cancellation within the asynchronous operation.
   *
   * This function has nothing to do with
   * g_simple_async_result_set_check_cancellable().  It only refers to the
   * #GCancellable passed to g_simple_async_result_run_in_thread().
   */
  void setHandleCancellation(bool handleCancellation)
  {
    g_simple_async_result_set_handle_cancellation(cPtr!GSimpleAsyncResult, handleCancellation);
  }

  /**
   * Sets the operation result to a boolean within the asynchronous result.
   */
  void setOpResGboolean(bool opRes)
  {
    g_simple_async_result_set_op_res_gboolean(cPtr!GSimpleAsyncResult, opRes);
  }

  /**
   * Sets the operation result within the asynchronous result to
   * the given @op_res.
   */
  void setOpResGssize(ptrdiff_t opRes)
  {
    g_simple_async_result_set_op_res_gssize(cPtr!GSimpleAsyncResult, opRes);
  }
}
