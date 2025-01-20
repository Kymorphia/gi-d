module Gio.SimpleAsyncResult;

import GLib.ErrorG;
import GObject.ObjectG;
import Gid.gid;
import Gio.AsyncResult;
import Gio.AsyncResultT;
import Gio.Cancellable;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * As of GLib 2.46, `GSimpleAsyncResult` is deprecated in favor of
 * [Gio.Task], which provides a simpler API.
 * `GSimpleAsyncResult` implements [Gio.AsyncResult].
 * `GSimpleAsyncResult` handles [Gio.AsyncReadyCallback]s, error
 * reporting, operation cancellation and the final state of an operation,
 * completely transparent to the application. Results can be returned
 * as a pointer e.g. for functions that return data that is collected
 * asynchronously, a boolean value for checking the success or failure
 * of an operation, or a `gssize` for operations which return the number
 * of bytes modified by the operation; all of the simple return cases
 * are covered.
 * Most of the time, an application will not need to know of the details
 * of this API; it is handled transparently, and any necessary operations
 * are handled by [Gio.AsyncResult]’s interface. However, if implementing
 * a new GIO module, for writing language bindings, or for complex
 * applications that need better control of how asynchronous operations
 * are completed, it is important to understand this functionality.
 * `GSimpleAsyncResult`s are tagged with the calling function to ensure
 * that asynchronous functions and their finishing functions are used
 * together correctly.
 * To create a new `GSimpleAsyncResult`, call [Gio.SimpleAsyncResult.new_].
 * If the result needs to be created for a `GError`, use
 * [Gio.SimpleAsyncResult.newFromError] or
 * [Gio.SimpleAsyncResult.newTakeError]. If a `GError` is not available
 * $(LPAREN)e.g. the asynchronous operation doesn’t take a `GError` argument$(RPAREN),
 * but the result still needs to be created for an error condition, use
 * [Gio.SimpleAsyncResult.newError] $(LPAREN)or
 * [Gio.SimpleAsyncResult.setErrorVa] if your application or binding
 * requires passing a variable argument list directly$(RPAREN), and the error can then
 * be propagated through the use of
 * [Gio.SimpleAsyncResult.propagateError].
 * An asynchronous operation can be made to ignore a cancellation event by
 * calling [Gio.SimpleAsyncResult.setHandleCancellation] with a
 * `GSimpleAsyncResult` for the operation and `FALSE`. This is useful for
 * operations that are dangerous to cancel, such as close $(LPAREN)which would
 * cause a leak if cancelled before being run$(RPAREN).
 * `GSimpleAsyncResult` can integrate into GLib’s event loop,
 * [GLib.MainLoop], or it can use [GLib.Thread]s.
 * [Gio.SimpleAsyncResult.complete] will finish an I/O task directly
 * from the point where it is called.
 * [Gio.SimpleAsyncResult.completeInIdle] will finish it from an idle
 * handler in the  thread-default main context $(LPAREN)see
 * [GLib.MainContext.pushThreadDefault]$(RPAREN) where the `GSimpleAsyncResult`
 * was created. [Gio.SimpleAsyncResult.runInThread] will run the job in
 * a separate thread and then use
 * [Gio.SimpleAsyncResult.completeInIdle] to deliver the result.
 * To set the results of an asynchronous function,
 * [Gio.SimpleAsyncResult.setOpResGpointer],
 * [Gio.SimpleAsyncResult.setOpResGboolean], and
 * [Gio.SimpleAsyncResult.setOpResGssize]
 * are provided, setting the operation's result to a `gpointer`, `gboolean`, or
 * `gssize`, respectively.
 * Likewise, to get the result of an asynchronous function,
 * [Gio.SimpleAsyncResult.getOpResGpointer],
 * [Gio.SimpleAsyncResult.getOpResGboolean], and
 * [Gio.SimpleAsyncResult.getOpResGssize] are
 * provided, getting the operation’s result as a `gpointer`, `gboolean`, and
 * `gssize`, respectively.
 * For the details of the requirements implementations must respect, see
 * [Gio.AsyncResult].  A typical implementation of an asynchronous
 * operation using `GSimpleAsyncResult` looks something like this:
 * ```c
 * static void
 * baked_cb $(LPAREN)Cake    *cake,
 * gpointer user_data$(RPAREN)
 * {
 * // In this example, this callback is not given a reference to the cake,
 * // so the GSimpleAsyncResult has to take a reference to it.
 * GSimpleAsyncResult *result \= user_data;
 * if $(LPAREN)cake \=\= NULL$(RPAREN)
 * g_simple_async_result_set_error $(LPAREN)result,
 * BAKER_ERRORS,
 * BAKER_ERROR_NO_FLOUR,
 * "Go to the supermarket"$(RPAREN);
 * else
 * g_simple_async_result_set_op_res_gpointer $(LPAREN)result,
 * g_object_ref $(LPAREN)cake$(RPAREN),
 * g_object_unref$(RPAREN);
 * // In this example, we assume that baked_cb is called as a callback from
 * // the mainloop, so it's safe to complete the operation synchronously here.
 * // If, however, _baker_prepare_cake $(LPAREN)$(RPAREN) might call its callback without
 * // first returning to the mainloop — inadvisable, but some APIs do so —
 * // we would need to use [Gio.SimpleAsyncResult.completeInIdle].
 * g_simple_async_result_complete $(LPAREN)result$(RPAREN);
 * g_object_unref $(LPAREN)result$(RPAREN);
 * }
 * void
 * baker_bake_cake_async $(LPAREN)Baker              *self,
 * guint               radius,
 * GAsyncReadyCallback callback,
 * gpointer            user_data$(RPAREN)
 * {
 * GSimpleAsyncResult *simple;
 * Cake               *cake;
 * if $(LPAREN)radius < 3$(RPAREN)
 * {
 * g_simple_async_report_error_in_idle $(LPAREN)G_OBJECT $(LPAREN)self$(RPAREN),
 * callback,
 * user_data,
 * BAKER_ERRORS,
 * BAKER_ERROR_TOO_SMALL,
 * "%ucm radius cakes are silly",
 * radius$(RPAREN);
 * return;
 * }
 * simple \= g_simple_async_result_new $(LPAREN)G_OBJECT $(LPAREN)self$(RPAREN),
 * callback,
 * user_data,
 * baker_bake_cake_async$(RPAREN);
 * cake \= _baker_get_cached_cake $(LPAREN)self, radius$(RPAREN);
 * if $(LPAREN)cake !\= NULL$(RPAREN)
 * {
 * g_simple_async_result_set_op_res_gpointer $(LPAREN)simple,
 * g_object_ref $(LPAREN)cake$(RPAREN),
 * g_object_unref$(RPAREN);
 * g_simple_async_result_complete_in_idle $(LPAREN)simple$(RPAREN);
 * g_object_unref $(LPAREN)simple$(RPAREN);
 * // Drop the reference returned by _baker_get_cached_cake$(LPAREN)$(RPAREN);
 * // the GSimpleAsyncResult has taken its own reference.
 * g_object_unref $(LPAREN)cake$(RPAREN);
 * return;
 * }
 * _baker_prepare_cake $(LPAREN)self, radius, baked_cb, simple$(RPAREN);
 * }
 * Cake *
 * baker_bake_cake_finish $(LPAREN)Baker        *self,
 * GAsyncResult *result,
 * GError      **error$(RPAREN)
 * {
 * GSimpleAsyncResult *simple;
 * Cake               *cake;
 * g_return_val_if_fail $(LPAREN)g_simple_async_result_is_valid $(LPAREN)result,
 * G_OBJECT $(LPAREN)self$(RPAREN),
 * baker_bake_cake_async$(RPAREN),
 * NULL$(RPAREN);
 * simple \= $(LPAREN)GSimpleAsyncResult *$(RPAREN) result;
 * if $(LPAREN)g_simple_async_result_propagate_error $(LPAREN)simple, error$(RPAREN)$(RPAREN)
 * return NULL;
 * cake \= CAKE $(LPAREN)g_simple_async_result_get_op_res_gpointer $(LPAREN)simple$(RPAREN)$(RPAREN);
 * return g_object_ref $(LPAREN)cake$(RPAREN);
 * }
 * ```
 */
class SimpleAsyncResult : ObjectG, AsyncResult
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
    return g_simple_async_result_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin AsyncResultT!();

  /**
   * Creates a #GSimpleAsyncResult.
   * The common convention is to create the #GSimpleAsyncResult in the
   * function that starts the asynchronous operation and use that same
   * function as the source_tag.
   * If your operation supports cancellation with #GCancellable $(LPAREN)which it
   * probably should$(RPAREN) then you should provide the user's cancellable to
   * [Gio.SimpleAsyncResult.setCheckCancellable] immediately after
   * this function returns.
   * Params:
   *   sourceObject = a #GObject, or %NULL.
   *   callback = a #GAsyncReadyCallback.
   *   sourceTag = the asynchronous function.
   * Returns: a #GSimpleAsyncResult.

   * Deprecated: Use [Gio.Task.new_] instead.
   */
  this(ObjectG sourceObject, AsyncReadyCallback callback, void* sourceTag)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(AsyncReadyCallback*)data;

      (*_dlg)(sourceObject ? ObjectG.getDObject!ObjectG(cast(void*)sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(cast(void*)res, false) : null);
    }

    GSimpleAsyncResult* _cretval;
    auto _callback = freezeDelegate(cast(void*)&callback);
    _cretval = g_simple_async_result_new(sourceObject ? cast(ObjectC*)sourceObject.cPtr(false) : null, &_callbackCallback, _callback, sourceTag);
    this(_cretval, true);
  }

  /**
   * Creates a #GSimpleAsyncResult from an error condition.
   * Params:
   *   sourceObject = a #GObject, or %NULL.
   *   callback = a #GAsyncReadyCallback.
   *   error = a #GError
   * Returns: a #GSimpleAsyncResult.

   * Deprecated: Use [Gio.Task.new_] and [Gio.Task.returnError] instead.
   */
  static SimpleAsyncResult newFromError(ObjectG sourceObject, AsyncReadyCallback callback, ErrorG error)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(AsyncReadyCallback*)data;

      (*_dlg)(sourceObject ? ObjectG.getDObject!ObjectG(cast(void*)sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(cast(void*)res, false) : null);
    }

    GSimpleAsyncResult* _cretval;
    auto _callback = freezeDelegate(cast(void*)&callback);
    _cretval = g_simple_async_result_new_from_error(sourceObject ? cast(ObjectC*)sourceObject.cPtr(false) : null, &_callbackCallback, _callback, error ? cast(GError*)error.cPtr : null);
    auto _retval = _cretval ? ObjectG.getDObject!SimpleAsyncResult(cast(GSimpleAsyncResult*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Ensures that the data passed to the _finish function of an async
   * operation is consistent.  Three checks are performed.
   * First, result is checked to ensure that it is really a
   * #GSimpleAsyncResult.  Second, source is checked to ensure that it
   * matches the source object of result.  Third, source_tag is
   * checked to ensure that it is equal to the source_tag argument given
   * to [Gio.SimpleAsyncResult.new_] $(LPAREN)which, by convention, is a pointer
   * to the _async function corresponding to the _finish function from
   * which this function is called$(RPAREN).  $(LPAREN)Alternatively, if either
   * source_tag or result's source tag is %NULL, then the source tag
   * check is skipped.$(RPAREN)
   * Params:
   *   result = the #GAsyncResult passed to the _finish function.
   *   source = the #GObject passed to the _finish function.
   *   sourceTag = the asynchronous function.
   * Returns: #TRUE if all checks passed or #FALSE if any failed.

   * Deprecated: Use #GTask and [Gio.Task.isValid] instead.
   */
  static bool isValid(AsyncResult result, ObjectG source, void* sourceTag)
  {
    bool _retval;
    _retval = g_simple_async_result_is_valid(result ? cast(GAsyncResult*)(cast(ObjectG)result).cPtr(false) : null, source ? cast(ObjectC*)source.cPtr(false) : null, sourceTag);
    return _retval;
  }

  /**
   * Completes an asynchronous I/O job immediately. Must be called in
   * the thread where the asynchronous result was to be delivered, as it
   * invokes the callback directly. If you are in a different thread use
   * [Gio.SimpleAsyncResult.completeInIdle].
   * Calling this function takes a reference to simple for as long as
   * is needed to complete the call.

   * Deprecated: Use #GTask instead.
   */
  void complete()
  {
    g_simple_async_result_complete(cast(GSimpleAsyncResult*)cPtr);
  }

  /**
   * Completes an asynchronous function in an idle handler in the
   * [thread-default main context][g-main-context-push-thread-default]
   * of the thread that simple was initially created in
   * $(LPAREN)and re-pushes that context around the invocation of the callback$(RPAREN).
   * Calling this function takes a reference to simple for as long as
   * is needed to complete the call.

   * Deprecated: Use #GTask instead.
   */
  void completeInIdle()
  {
    g_simple_async_result_complete_in_idle(cast(GSimpleAsyncResult*)cPtr);
  }

  /**
   * Gets the operation result boolean from within the asynchronous result.
   * Returns: %TRUE if the operation's result was %TRUE, %FALSE
   *   if the operation's result was %FALSE.

   * Deprecated: Use #GTask and [Gio.Task.propagateBoolean] instead.
   */
  bool getOpResGboolean()
  {
    bool _retval;
    _retval = g_simple_async_result_get_op_res_gboolean(cast(GSimpleAsyncResult*)cPtr);
    return _retval;
  }

  /**
   * Gets a gssize from the asynchronous result.
   * Returns: a gssize returned from the asynchronous function.

   * Deprecated: Use #GTask and [Gio.Task.propagateInt] instead.
   */
  ptrdiff_t getOpResGssize()
  {
    ptrdiff_t _retval;
    _retval = g_simple_async_result_get_op_res_gssize(cast(GSimpleAsyncResult*)cPtr);
    return _retval;
  }

  /**
   * Propagates an error from within the simple asynchronous result to
   * a given destination.
   * If the #GCancellable given to a prior call to
   * [Gio.SimpleAsyncResult.setCheckCancellable] is cancelled then this
   * function will return %TRUE with dest set appropriately.
   * Returns: %TRUE if the error was propagated to dest. %FALSE otherwise.

   * Deprecated: Use #GTask instead.
   */
  bool propagateError()
  {
    bool _retval;
    GError *_err;
    _retval = g_simple_async_result_propagate_error(cast(GSimpleAsyncResult*)cPtr, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Sets a #GCancellable to check before dispatching results.
   * This function has one very specific purpose: the provided cancellable
   * is checked at the time of [Gio.SimpleAsyncResult.propagateError] If
   * it is cancelled, these functions will return an "Operation was
   * cancelled" error $(LPAREN)%G_IO_ERROR_CANCELLED$(RPAREN).
   * Implementors of cancellable asynchronous functions should use this in
   * order to provide a guarantee to their callers that cancelling an
   * async operation will reliably result in an error being returned for
   * that operation $(LPAREN)even if a positive result for the operation has
   * already been sent as an idle to the main context to be dispatched$(RPAREN).
   * The checking described above is done regardless of any call to the
   * unrelated [Gio.SimpleAsyncResult.setHandleCancellation] function.
   * Params:
   *   checkCancellable = a #GCancellable to check, or %NULL to unset

   * Deprecated: Use #GTask instead.
   */
  void setCheckCancellable(Cancellable checkCancellable)
  {
    g_simple_async_result_set_check_cancellable(cast(GSimpleAsyncResult*)cPtr, checkCancellable ? cast(GCancellable*)checkCancellable.cPtr(false) : null);
  }

  /**
   * Sets the result from a #GError.
   * Params:
   *   error = #GError.

   * Deprecated: Use #GTask and [Gio.Task.returnError] instead.
   */
  void setFromError(ErrorG error)
  {
    g_simple_async_result_set_from_error(cast(GSimpleAsyncResult*)cPtr, error ? cast(GError*)error.cPtr : null);
  }

  /**
   * Sets whether to handle cancellation within the asynchronous operation.
   * This function has nothing to do with
   * [Gio.SimpleAsyncResult.setCheckCancellable].  It only refers to the
   * #GCancellable passed to [Gio.SimpleAsyncResult.runInThread].
   * Params:
   *   handleCancellation = a #gboolean.
   */
  void setHandleCancellation(bool handleCancellation)
  {
    g_simple_async_result_set_handle_cancellation(cast(GSimpleAsyncResult*)cPtr, handleCancellation);
  }

  /**
   * Sets the operation result to a boolean within the asynchronous result.
   * Params:
   *   opRes = a #gboolean.

   * Deprecated: Use #GTask and [Gio.Task.returnBoolean] instead.
   */
  void setOpResGboolean(bool opRes)
  {
    g_simple_async_result_set_op_res_gboolean(cast(GSimpleAsyncResult*)cPtr, opRes);
  }

  /**
   * Sets the operation result within the asynchronous result to
   * the given op_res.
   * Params:
   *   opRes = a #gssize.

   * Deprecated: Use #GTask and [Gio.Task.returnInt] instead.
   */
  void setOpResGssize(ptrdiff_t opRes)
  {
    g_simple_async_result_set_op_res_gssize(cast(GSimpleAsyncResult*)cPtr, opRes);
  }
}
