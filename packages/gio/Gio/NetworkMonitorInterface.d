module Gio.NetworkMonitorInterface;

import GLib.c.functions;
import GObject.TypeInterface;
import GObject.Types;
import Gid.Gid;
import Gio.AsyncResult;
import Gio.Cancellable;
import Gio.NetworkMonitor;
import Gio.SocketConnectable;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * The virtual function table for #GNetworkMonitor.
 */
class NetworkMonitorInterface
{
  GNetworkMonitorInterface cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.NetworkMonitorInterface");

    cInstance = *cast(GNetworkMonitorInterface*)ptr;

    if (ownedRef)
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GNetworkMonitorInterface))
  {
    return cast(T*)&cInstance;
  }

  @property TypeInterface gIface()
  {
    return new TypeInterface(cast(GTypeInterface*)&cPtr!GNetworkMonitorInterface.gIface);
  }

  alias NetworkChangedFuncType = extern(C) void function(GNetworkMonitor* monitor, bool networkAvailable);

  @property NetworkChangedFuncType networkChanged()
  {
    return cPtr!GNetworkMonitorInterface.networkChanged;
  }

  alias CanReachFuncType = extern(C) bool function(GNetworkMonitor* monitor, GSocketConnectable* connectable, GCancellable* cancellable, GError** _err);

  @property CanReachFuncType canReach()
  {
    return cPtr!GNetworkMonitorInterface.canReach;
  }

  alias CanReachAsyncFuncType = extern(C) void function(GNetworkMonitor* monitor, GSocketConnectable* connectable, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property CanReachAsyncFuncType canReachAsync()
  {
    return cPtr!GNetworkMonitorInterface.canReachAsync;
  }

  alias CanReachFinishFuncType = extern(C) bool function(GNetworkMonitor* monitor, GAsyncResult* result, GError** _err);

  @property CanReachFinishFuncType canReachFinish()
  {
    return cPtr!GNetworkMonitorInterface.canReachFinish;
  }
}
