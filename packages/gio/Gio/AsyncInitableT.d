module Gio.AsyncInitableT;

public import GLib.ErrorG;
public import GObject.ObjectG;
public import GObject.Parameter;
public import GObject.Types;
public import Gid.Gid;
public import Gio.AsyncResult;
public import Gio.Cancellable;
public import Gio.Types;
public import Gio.c.functions;
public import Gio.c.types;

/**
 * This is the asynchronous version of #GInitable; it behaves the same
 * in all ways except that initialization is asynchronous. For more details
 * see the descriptions on #GInitable.
 *
 * A class may implement both the #GInitable and #GAsyncInitable interfaces.
 *
 * Users of objects implementing this are not intended to use the interface
 * method directly; instead it will be used automatically in various ways.
 * For C applications you generally just call g_async_initable_new_async()
 * directly, or indirectly via a foo_thing_new_async() wrapper. This will call
 * g_async_initable_init_async() under the cover, calling back with %NULL and
 * a set %GError on failure.
 *
 * A typical implementation might look something like this:
 *
 * |[<!-- language="C" -->
 * enum {
 * NOT_INITIALIZED,
 * INITIALIZING,
 * INITIALIZED
 * };
 *
 * static void
 * _foo_ready_cb (Foo *self)
 * {
 * GList *l;
 *
 * self->priv->state = INITIALIZED;
 *
 * for (l = self->priv->init_results; l != NULL; l = l->next)
 * {
 * GTask *task = l->data;
 *
 * if (self->priv->success)
 * g_task_return_boolean (task, TRUE);
 * else
 * g_task_return_new_error (task, ...);
 * g_object_unref (task);
 * }
 *
 * g_list_free (self->priv->init_results);
 * self->priv->init_results = NULL;
 * }
 *
 * static void
 * foo_init_async (GAsyncInitable       *initable,
 * int                   io_priority,
 * GCancellable         *cancellable,
 * GAsyncReadyCallback   callback,
 * gpointer              user_data)
 * {
 * Foo *self = FOO (initable);
 * GTask *task;
 *
 * task = g_task_new (initable, cancellable, callback, user_data);
 * g_task_set_name (task, G_STRFUNC);
 *
 * switch (self->priv->state)
 * {
 * case NOT_INITIALIZED:
 * _foo_get_ready (self);
 * self->priv->init_results = g_list_append (self->priv->init_results,
 * task);
 * self->priv->state = INITIALIZING;
 * break;
 * case INITIALIZING:
 * self->priv->init_results = g_list_append (self->priv->init_results,
 * task);
 * break;
 * case INITIALIZED:
 * if (!self->priv->success)
 * g_task_return_new_error (task, ...);
 * else
 * g_task_return_boolean (task, TRUE);
 * g_object_unref (task);
 * break;
 * }
 * }
 *
 * static gboolean
 * foo_init_finish (GAsyncInitable       *initable,
 * GAsyncResult         *result,
 * GError              **error)
 * {
 * g_return_val_if_fail (g_task_is_valid (result, initable), FALSE);
 *
 * return g_task_propagate_boolean (G_TASK (result), error);
 * }
 *
 * static void
 * foo_async_initable_iface_init (gpointer g_iface,
 * gpointer data)
 * {
 * GAsyncInitableIface *iface = g_iface;
 *
 * iface->init_async = foo_init_async;
 * iface->init_finish = foo_init_finish;
 * }
 * ]|
 */
template AsyncInitableT(TStruct)
{

  /**
   * Helper function for constructing #GAsyncInitable object. This is
   * similar to g_object_newv() but also initializes the object asynchronously.
   *
   * When the initialization is finished, @callback will be called. You can
   * then call g_async_initable_new_finish() to get the new object and check
   * for any errors.
   */
  static void newvAsync(GType objectType, uint nParameters, Parameter parameters, int ioPriority, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    ptrFreezeGC(cast(void*)&callback);
    g_async_initable_newv_async(objectType, nParameters, parameters ? parameters.cPtr!GParameter : null, ioPriority, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * Starts asynchronous initialization of the object implementing the
   * interface. This must be done before any real use of the object after
   * initial construction. If the object also implements #GInitable you can
   * optionally call g_initable_init() instead.
   *
   * This method is intended for language bindings. If writing in C,
   * g_async_initable_new_async() should typically be used instead.
   *
   * When the initialization is finished, @callback will be called. You can
   * then call g_async_initable_init_finish() to get the result of the
   * initialization.
   *
   * Implementations may also support cancellation. If @cancellable is not
   * %NULL, then initialization can be cancelled by triggering the cancellable
   * object from another thread. If the operation was cancelled, the error
   * %G_IO_ERROR_CANCELLED will be returned. If @cancellable is not %NULL, and
   * the object doesn't support cancellable initialization, the error
   * %G_IO_ERROR_NOT_SUPPORTED will be returned.
   *
   * As with #GInitable, if the object is not initialized, or initialization
   * returns with an error, then all operations on the object except
   * g_object_ref() and g_object_unref() are considered to be invalid, and
   * have undefined behaviour. They will often fail with g_critical() or
   * g_warning(), but this must not be relied on.
   *
   * Callers should not assume that a class which implements #GAsyncInitable can
   * be initialized multiple times; for more information, see g_initable_init().
   * If a class explicitly supports being initialized multiple times,
   * implementation requires yielding all subsequent calls to init_async() on the
   * results of the first call.
   *
   * For classes that also support the #GInitable interface, the default
   * implementation of this method will run the g_initable_init() function
   * in a thread, so if you want to support asynchronous initialization via
   * threads, just implement the #GAsyncInitable interface without overriding
   * any interface methods.
   */
  override void initAsync(int ioPriority, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    ptrFreezeGC(cast(void*)&callback);
    g_async_initable_init_async(cPtr!GAsyncInitable, ioPriority, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * %TRUE if successful. If an error has occurred, this function
   * will return %FALSE and set @error appropriately if present.
   */
  override bool initFinish(AsyncResult res)
  {
    bool _retval;
    GError *_err;
    _retval = g_async_initable_init_finish(cPtr!GAsyncInitable, res ? (cast(ObjectG)res).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * a newly created #GObject,
   * or %NULL on error. Free with g_object_unref().
   */
  override ObjectG newFinish(AsyncResult res)
  {
    ObjectC* _cretval;
    GError *_err;
    _cretval = g_async_initable_new_finish(cPtr!GAsyncInitable, res ? (cast(ObjectG)res).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    ObjectG _retval = ObjectG.getDObject!ObjectG(cast(ObjectC*)_cretval, true);
    return _retval;
  }
}
