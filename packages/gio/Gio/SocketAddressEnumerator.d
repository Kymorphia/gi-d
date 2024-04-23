module Gio.SocketAddressEnumerator;

import GLib.ErrorG;
import GObject.ObjectG;
import GObject.Types;
import Gid.Gid;
import Gio.AsyncResult;
import Gio.Cancellable;
import Gio.SocketAddress;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * #GSocketAddressEnumerator is an enumerator type for #GSocketAddress
 * instances. It is returned by enumeration functions such as
 * g_socket_connectable_enumerate(), which returns a #GSocketAddressEnumerator
 * to list each #GSocketAddress which could be used to connect to that
 * #GSocketConnectable.
 *
 * Enumeration is typically a blocking operation, so the asynchronous methods
 * g_socket_address_enumerator_next_async() and
 * g_socket_address_enumerator_next_finish() should be used where possible.
 *
 * Each #GSocketAddressEnumerator can only be enumerated once. Once
 * g_socket_address_enumerator_next() has returned %NULL, further
 * enumeration with that #GSocketAddressEnumerator is not possible, and it can
 * be unreffed.
 */
class SocketAddressEnumerator : ObjectG
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_socket_address_enumerator_get_type();
  }

  /**
   * a #GSocketAddress (owned by the caller), or %NULL on
   * error (in which case *@error will be set) or if there are no
   * more addresses.
   */
  SocketAddress next(Cancellable cancellable)
  {
    GSocketAddress* _cretval;
    GError *_err;
    _cretval = g_socket_address_enumerator_next(cPtr!GSocketAddressEnumerator, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    SocketAddress _retval = ObjectG.getDObject!SocketAddress(cast(GSocketAddress*)_cretval, true);
    return _retval;
  }

  /**
   * Asynchronously retrieves the next #GSocketAddress from @enumerator
   * and then calls @callback, which must call
   * g_socket_address_enumerator_next_finish() to get the result.
   *
   * It is an error to call this multiple times before the previous callback has finished.
   */
  void nextAsync(Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    ptrFreezeGC(cast(void*)&callback);
    g_socket_address_enumerator_next_async(cPtr!GSocketAddressEnumerator, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * a #GSocketAddress (owned by the caller), or %NULL on
   * error (in which case *@error will be set) or if there are no
   * more addresses.
   */
  SocketAddress nextFinish(AsyncResult result)
  {
    GSocketAddress* _cretval;
    GError *_err;
    _cretval = g_socket_address_enumerator_next_finish(cPtr!GSocketAddressEnumerator, result ? (cast(ObjectG)result).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    SocketAddress _retval = ObjectG.getDObject!SocketAddress(cast(GSocketAddress*)_cretval, true);
    return _retval;
  }
}
