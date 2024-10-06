module Gio.SocketAddressEnumeratorClass;

import Gid.gid;
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
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  alias NextFuncType = extern(C) GSocketAddress* function(GSocketAddressEnumerator* enumerator, GCancellable* cancellable, GError** _err);

  @property NextFuncType next()
  {
    return (cast(GSocketAddressEnumeratorClass*)cPtr).next;
  }

  alias NextAsyncFuncType = extern(C) void function(GSocketAddressEnumerator* enumerator, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property NextAsyncFuncType nextAsync()
  {
    return (cast(GSocketAddressEnumeratorClass*)cPtr).nextAsync;
  }

  alias NextFinishFuncType = extern(C) GSocketAddress* function(GSocketAddressEnumerator* enumerator, GAsyncResult* result, GError** _err);

  @property NextFinishFuncType nextFinish()
  {
    return (cast(GSocketAddressEnumeratorClass*)cPtr).nextFinish;
  }
}
