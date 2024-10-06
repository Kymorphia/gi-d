module Gio.ProxyInterface;

import GObject.TypeInterface;
import Gid.gid;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * Provides an interface for handling proxy connection and payload.
 */
class ProxyInterface
{
  GProxyInterface cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.ProxyInterface");

    cInstance = *cast(GProxyInterface*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property TypeInterface gIface()
  {
    return new TypeInterface(cast(GTypeInterface*)&(cast(GProxyInterface*)cPtr).gIface);
  }

  alias ConnectFuncType = extern(C) GIOStream* function(GProxy* proxy, GIOStream* connection, GProxyAddress* proxyAddress, GCancellable* cancellable, GError** _err);

  @property ConnectFuncType connect()
  {
    return (cast(GProxyInterface*)cPtr).connect;
  }

  alias ConnectAsyncFuncType = extern(C) void function(GProxy* proxy, GIOStream* connection, GProxyAddress* proxyAddress, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property ConnectAsyncFuncType connectAsync()
  {
    return (cast(GProxyInterface*)cPtr).connectAsync;
  }

  alias ConnectFinishFuncType = extern(C) GIOStream* function(GProxy* proxy, GAsyncResult* result, GError** _err);

  @property ConnectFinishFuncType connectFinish()
  {
    return (cast(GProxyInterface*)cPtr).connectFinish;
  }

  alias SupportsHostnameFuncType = extern(C) bool function(GProxy* proxy);

  @property SupportsHostnameFuncType supportsHostname()
  {
    return (cast(GProxyInterface*)cPtr).supportsHostname;
  }
}
