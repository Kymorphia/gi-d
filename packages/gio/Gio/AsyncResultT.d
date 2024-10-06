module Gio.AsyncResultT;

public import GLib.ErrorG;
public import GObject.ObjectG;
public import Gid.gid;
public import Gio.Types;
public import Gio.c.functions;
public import Gio.c.types;

/**
 * `GAsyncResult` provides a base class for implementing asynchronous function results.
 * Asynchronous operations are broken up into two separate operations
 * which are chained together by a `GAsyncReadyCallback`. To begin
 * an asynchronous operation, provide a `GAsyncReadyCallback` to the
 * asynchronous function. This callback will be triggered when the
 * operation has completed, and must be run in a later iteration of
 * the thread-default main context $(LPAREN)see
 * [GLib.MainContext.pushThreadDefault]$(RPAREN) from where the operation was
 * initiated. It will be passed a `GAsyncResult` instance filled with the
 * details of the operation's success or failure, the object the asynchronous
 * function was started for and any error codes returned. The asynchronous
 * callback function is then expected to call the corresponding `_finish$(LPAREN)$(RPAREN)`
 * function, passing the object the function was called for, the
 * `GAsyncResult` instance, and $(LPAREN)optionally$(RPAREN) an @error to grab any
 * error conditions that may have occurred.
 * The `_finish$(LPAREN)$(RPAREN)` function for an operation takes the generic result
 * $(LPAREN)of type `GAsyncResult`$(RPAREN) and returns the specific result that the
 * operation in question yields $(LPAREN)e.g. a [Gio.FileEnumerator] for a
 * "enumerate children" operation$(RPAREN). If the result or error status of the
 * operation is not needed, there is no need to call the `_finish$(LPAREN)$(RPAREN)`
 * function; GIO will take care of cleaning up the result and error
 * information after the `GAsyncReadyCallback` returns. You can pass
 * `NULL` for the `GAsyncReadyCallback` if you don't need to take any
 * action at all after the operation completes. Applications may also
 * take a reference to the `GAsyncResult` and call `_finish$(LPAREN)$(RPAREN)` later;
 * however, the `_finish$(LPAREN)$(RPAREN)` function may be called at most once.
 * Example of a typical asynchronous operation flow:
 * ```c
 * void _theoretical_frobnitz_async $(LPAREN)Theoretical         *t,
 * GCancellable        *c,
 * GAsyncReadyCallback  cb,
 * gpointer             u$(RPAREN);
 * gboolean _theoretical_frobnitz_finish $(LPAREN)Theoretical   *t,
 * GAsyncResult  *res,
 * GError       **e$(RPAREN);
 * static void
 * frobnitz_result_func $(LPAREN)GObject      *source_object,
 * GAsyncResult *res,
 * gpointer      user_data$(RPAREN)
 * {
 * gboolean success \= FALSE;
 * success \= _theoretical_frobnitz_finish $(LPAREN)source_object, res, NULL$(RPAREN);
 * if $(LPAREN)success$(RPAREN)
 * g_printf $(LPAREN)"Hurray!\n"$(RPAREN);
 * else
 * g_printf $(LPAREN)"Uh oh!\n"$(RPAREN);
 * ...
 * }
 * int main $(LPAREN)int argc, void *argv[]$(RPAREN)
 * {
 * ...
 * _theoretical_frobnitz_async $(LPAREN)theoretical_data,
 * NULL,
 * frobnitz_result_func,
 * NULL$(RPAREN);
 * ...
 * }
 * ```
 * The callback for an asynchronous operation is called only once, and is
 * always called, even in the case of a cancelled operation. On cancellation
 * the result is a `G_IO_ERROR_CANCELLED` error.
 * ## I/O Priority
 * Many I/O-related asynchronous operations have a priority parameter,
 * which is used in certain cases to determine the order in which
 * operations are executed. They are not used to determine system-wide
 * I/O scheduling. Priorities are integers, with lower numbers indicating
 * higher priority. It is recommended to choose priorities between
 * `G_PRIORITY_LOW` and `G_PRIORITY_HIGH`, with `G_PRIORITY_DEFAULT`
 * as a default.
 */
template AsyncResultT(TStruct)
{

  /**
   * Gets the source object from a #GAsyncResult.
   * Returns: a new reference to the source
   *   object for the res, or %NULL if there is none.
   */
  override ObjectG getSourceObject()
  {
    ObjectC* _cretval;
    _cretval = g_async_result_get_source_object(cast(GAsyncResult*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!ObjectG(cast(ObjectC*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Gets the user data from a #GAsyncResult.
   * Returns: the user data for res.
   */
  override void* getUserData()
  {
    void* _retval;
    _retval = g_async_result_get_user_data(cast(GAsyncResult*)cPtr);
    return _retval;
  }

  /**
   * Checks if res has the given source_tag $(LPAREN)generally a function
   * pointer indicating the function res was created by$(RPAREN).
   * Params:
   *   sourceTag = an application-defined tag
   * Returns: %TRUE if res has the indicated source_tag, %FALSE if
   *   not.
   */
  override bool isTagged(void* sourceTag)
  {
    bool _retval;
    _retval = g_async_result_is_tagged(cast(GAsyncResult*)cPtr, sourceTag);
    return _retval;
  }

  /**
   * If res is a #GSimpleAsyncResult, this is equivalent to
   * [Gio.SimpleAsyncResult.propagateError]. Otherwise it returns
   * %FALSE.
   * This can be used for legacy error handling in async *_finish$(LPAREN)$(RPAREN)
   * wrapper functions that traditionally handled #GSimpleAsyncResult
   * error returns themselves rather than calling into the virtual method.
   * This should not be used in new code; #GAsyncResult errors that are
   * set by virtual methods should also be extracted by virtual methods,
   * to enable subclasses to chain up correctly.
   * Returns: %TRUE if error is has been filled in with an error from
   *   res, %FALSE if not.
   */
  override bool legacyPropagateError()
  {
    bool _retval;
    GError *_err;
    _retval = g_async_result_legacy_propagate_error(cast(GAsyncResult*)cPtr, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }
}
