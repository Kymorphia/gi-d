module Gio.ProxyInterface;

import GLib.c.functions;
import GObject.TypeInterface;
import GObject.Types;
import Gid.Gid;
import Gio.AsyncResult;
import Gio.Cancellable;
import Gio.IOStream;
import Gio.Proxy;
import Gio.ProxyAddress;
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
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GProxyInterface))
  {
    return cast(T*)&cInstance;
  }

  @property TypeInterface gIface()
  {
    return new TypeInterface(cast(GTypeInterface*)&cPtr!GProxyInterface.gIface);
  }

  alias ConnectFuncType = extern(C) GIOStream* function(GProxy* proxy, GIOStream* connection, GProxyAddress* proxyAddress, GCancellable* cancellable, GError** _err);

  @property ConnectFuncType connect()
  {
    return cPtr!GProxyInterface.connect;
  }

  alias ConnectAsyncFuncType = extern(C) void function(GProxy* proxy, GIOStream* connection, GProxyAddress* proxyAddress, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property ConnectAsyncFuncType connectAsync()
  {
    return cPtr!GProxyInterface.connectAsync;
  }

  alias ConnectFinishFuncType = extern(C) GIOStream* function(GProxy* proxy, GAsyncResult* result, GError** _err);

  @property ConnectFinishFuncType connectFinish()
  {
    return cPtr!GProxyInterface.connectFinish;
  }

  alias SupportsHostnameFuncType = extern(C) bool function(GProxy* proxy);

  @property SupportsHostnameFuncType supportsHostname()
  {
    return cPtr!GProxyInterface.supportsHostname;
  }
}
