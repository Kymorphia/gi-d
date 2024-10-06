module Gio.AsyncInitableT;

public import GLib.ErrorG;
public import GObject.ObjectG;
public import GObject.Parameter;
public import GObject.Types;
public import Gid.gid;
public import Gio.AsyncResult;
public import Gio.AsyncResultT;
public import Gio.Cancellable;
public import Gio.Types;
public import Gio.c.functions;
public import Gio.c.types;

/**
 * `GAsyncInitable` is an interface for asynchronously initializable objects.
 * This is the asynchronous version of [Gio.Initable]; it behaves the same
 * in all ways except that initialization is asynchronous. For more details
 * see the descriptions on `GInitable`.
 * A class may implement both the `GInitable` and `GAsyncInitable` interfaces.
 * Users of objects implementing this are not intended to use the interface
 * method directly; instead it will be used automatically in various ways.
 * For C applications you generally just call [Gio.AsyncInitable.newAsync]
 * directly, or indirectly via a foo_thing_new_async$(LPAREN)$(RPAREN) wrapper. This will call
 * [Gio.AsyncInitable.initAsync] under the covers, calling back with `NULL`
 * and a set `GError` on failure.
 * A typical implementation might look something like this:
 * ```c
 * enum {
 * NOT_INITIALIZED,
 * INITIALIZING,
 * INITIALIZED
 * };
 * static void
 * _foo_ready_cb $(LPAREN)Foo *self$(RPAREN)
 * {
 * GList *l;
 * self->priv->state \= INITIALIZED;
 * for $(LPAREN)l \= self->priv->init_results; l !\= NULL; l \= l->next$(RPAREN)
 * {
 * GTask *task \= l->data;
 * if $(LPAREN)self->priv->success$(RPAREN)
 * g_task_return_boolean $(LPAREN)task, TRUE$(RPAREN);
 * else
 * g_task_return_new_error $(LPAREN)task, ...$(RPAREN);
 * g_object_unref $(LPAREN)task$(RPAREN);
 * }
 * g_list_free $(LPAREN)self->priv->init_results$(RPAREN);
 * self->priv->init_results \= NULL;
 * }
 * static void
 * foo_init_async $(LPAREN)GAsyncInitable       *initable,
 * int                   io_priority,
 * GCancellable         *cancellable,
 * GAsyncReadyCallback   callback,
 * gpointer              user_data$(RPAREN)
 * {
 * Foo *self \= FOO $(LPAREN)initable$(RPAREN);
 * GTask *task;
 * task \= g_task_new $(LPAREN)initable, cancellable, callback, user_data$(RPAREN);
 * g_task_set_name $(LPAREN)task, G_STRFUNC$(RPAREN);
 * switch $(LPAREN)self->priv->state$(RPAREN)
 * {
 * case NOT_INITIALIZED:
 * _foo_get_ready $(LPAREN)self$(RPAREN);
 * self->priv->init_results \= g_list_append $(LPAREN)self->priv->init_results,
 * task$(RPAREN);
 * self->priv->state \= INITIALIZING;
 * break;
 * case INITIALIZING:
 * self->priv->init_results \= g_list_append $(LPAREN)self->priv->init_results,
 * task$(RPAREN);
 * break;
 * case INITIALIZED:
 * if $(LPAREN)!self->priv->success$(RPAREN)
 * g_task_return_new_error $(LPAREN)task, ...$(RPAREN);
 * else
 * g_task_return_boolean $(LPAREN)task, TRUE$(RPAREN);
 * g_object_unref $(LPAREN)task$(RPAREN);
 * break;
 * }
 * }
 * static gboolean
 * foo_init_finish $(LPAREN)GAsyncInitable       *initable,
 * GAsyncResult         *result,
 * GError              **error$(RPAREN)
 * {
 * g_return_val_if_fail $(LPAREN)g_task_is_valid $(LPAREN)result, initable$(RPAREN), FALSE$(RPAREN);
 * return g_task_propagate_boolean $(LPAREN)G_TASK $(LPAREN)result$(RPAREN), error$(RPAREN);
 * }
 * static void
 * foo_async_initable_iface_init $(LPAREN)gpointer g_iface,
 * gpointer data$(RPAREN)
 * {
 * GAsyncInitableIface *iface \= g_iface;
 * iface->init_async \= foo_init_async;
 * iface->init_finish \= foo_init_finish;
 * }
 * ```
 */
template AsyncInitableT(TStruct)
{

  /**
   * Helper function for constructing #GAsyncInitable object. This is
   * similar to [GObject.ObjectG.newv] but also initializes the object asynchronously.
   * When the initialization is finished, callback will be called. You can
   * then call [Gio.AsyncInitable.newFinish] to get the new object and check
   * for any errors.
   * Params:
   *   objectType = a #GType supporting #GAsyncInitable.
   *   nParameters = the number of parameters in parameters
   *   parameters = the parameters to use to construct the object
   *   ioPriority = the [I/O priority][io-priority] of the operation
   *   cancellable = optional #GCancellable object, %NULL to ignore.
   *   callback = a #GAsyncReadyCallback to call when the initialization is
   *     finished

   * Deprecated: Use [GObject.ObjectG.newWithProperties] and
   *   [Gio.AsyncInitable.initAsync] instead. See #GParameter for more information.
   */
  static void newvAsync(GType objectType, uint nParameters, Parameter parameters, int ioPriority, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(AsyncReadyCallback*)data;

      (*_dlg)(sourceObject ? ObjectG.getDObject!ObjectG(cast(void*)sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(cast(void*)res, false) : null);
    }

    auto _callback = freezeDelegate(cast(void*)&callback);
    g_async_initable_newv_async(objectType, nParameters, parameters ? cast(GParameter*)parameters.cPtr : null, ioPriority, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_callbackCallback, _callback);
  }

  /**
   * Starts asynchronous initialization of the object implementing the
   * interface. This must be done before any real use of the object after
   * initial construction. If the object also implements #GInitable you can
   * optionally call [Gio.Initable.init_] instead.
   * This method is intended for language bindings. If writing in C,
   * [Gio.AsyncInitable.newAsync] should typically be used instead.
   * When the initialization is finished, callback will be called. You can
   * then call [Gio.AsyncInitable.initFinish] to get the result of the
   * initialization.
   * Implementations may also support cancellation. If cancellable is not
   * %NULL, then initialization can be cancelled by triggering the cancellable
   * object from another thread. If the operation was cancelled, the error
   * %G_IO_ERROR_CANCELLED will be returned. If cancellable is not %NULL, and
   * the object doesn't support cancellable initialization, the error
   * %G_IO_ERROR_NOT_SUPPORTED will be returned.
   * As with #GInitable, if the object is not initialized, or initialization
   * returns with an error, then all operations on the object except
   * [GObject.ObjectG.ref_] and [GObject.ObjectG.unref] are considered to be invalid, and
   * have undefined behaviour. They will often fail with g_critical$(LPAREN)$(RPAREN) or
   * g_warning$(LPAREN)$(RPAREN), but this must not be relied on.
   * Callers should not assume that a class which implements #GAsyncInitable can
   * be initialized multiple times; for more information, see [Gio.Initable.init_].
   * If a class explicitly supports being initialized multiple times,
   * implementation requires yielding all subsequent calls to init_async$(LPAREN)$(RPAREN) on the
   * results of the first call.
   * For classes that also support the #GInitable interface, the default
   * implementation of this method will run the [Gio.Initable.init_] function
   * in a thread, so if you want to support asynchronous initialization via
   * threads, just implement the #GAsyncInitable interface without overriding
   * any interface methods.
   * Params:
   *   ioPriority = the [I/O priority][io-priority] of the operation
   *   cancellable = optional #GCancellable object, %NULL to ignore.
   *   callback = a #GAsyncReadyCallback to call when the request is satisfied
   */
  override void initAsync(int ioPriority, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(AsyncReadyCallback*)data;

      (*_dlg)(sourceObject ? ObjectG.getDObject!ObjectG(cast(void*)sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(cast(void*)res, false) : null);
    }

    auto _callback = freezeDelegate(cast(void*)&callback);
    g_async_initable_init_async(cast(GAsyncInitable*)cPtr, ioPriority, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_callbackCallback, _callback);
  }

  /**
   * Finishes asynchronous initialization and returns the result.
   * See [Gio.AsyncInitable.initAsync].
   * Params:
   *   res = a #GAsyncResult.
   * Returns: %TRUE if successful. If an error has occurred, this function
   *   will return %FALSE and set error appropriately if present.
   */
  override bool initFinish(AsyncResult res)
  {
    bool _retval;
    GError *_err;
    _retval = g_async_initable_init_finish(cast(GAsyncInitable*)cPtr, res ? cast(GAsyncResult*)(cast(ObjectG)res).cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Finishes the async construction for the various g_async_initable_new
   * calls, returning the created object or %NULL on error.
   * Params:
   *   res = the #GAsyncResult from the callback
   * Returns: a newly created #GObject,
   *   or %NULL on error. Free with [GObject.ObjectG.unref].
   */
  override ObjectG newFinish(AsyncResult res)
  {
    ObjectC* _cretval;
    GError *_err;
    _cretval = g_async_initable_new_finish(cast(GAsyncInitable*)cPtr, res ? cast(GAsyncResult*)(cast(ObjectG)res).cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = _cretval ? ObjectG.getDObject!ObjectG(cast(ObjectC*)_cretval, true) : null;
    return _retval;
  }
}
