module Gio.SocketAddressEnumeratorClass;

import GLib.c.functions;
import Gid.Gid;
import Gio.AsyncResult;
import Gio.Cancellable;
import Gio.SocketAddress;
import Gio.SocketAddressEnumerator;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * Class structure for #GSocketAddressEnumerator.
 */
class SocketAddressEnumeratorClass
{
  GSocketAddressEnumeratorClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.SocketAddressEnumeratorClass");

    cInstance = *cast(GSocketAddressEnumeratorClass*)ptr;

    if (ownedRef)
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GSocketAddressEnumeratorClass))
  {
    return cast(T*)&cInstance;
  }

  alias NextFuncType = extern(C) GSocketAddress* function(GSocketAddressEnumerator* enumerator, GCancellable* cancellable, GError** _err);

  @property NextFuncType next()
  {
    return cPtr!GSocketAddressEnumeratorClass.next;
  }

  alias NextAsyncFuncType = extern(C) void function(GSocketAddressEnumerator* enumerator, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property NextAsyncFuncType nextAsync()
  {
    return cPtr!GSocketAddressEnumeratorClass.nextAsync;
  }

  alias NextFinishFuncType = extern(C) GSocketAddress* function(GSocketAddressEnumerator* enumerator, GAsyncResult* result, GError** _err);

  @property NextFinishFuncType nextFinish()
  {
    return cPtr!GSocketAddressEnumeratorClass.nextFinish;
  }
}
