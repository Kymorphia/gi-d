module Gio.NetworkMonitorInterface;

import GObject.TypeInterface;
import Gid.gid;
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
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property TypeInterface gIface()
  {
    return new TypeInterface(cast(GTypeInterface*)&(cast(GNetworkMonitorInterface*)cPtr).gIface);
  }

  alias NetworkChangedFuncType = extern(C) void function(GNetworkMonitor* monitor, bool networkAvailable);

  @property NetworkChangedFuncType networkChanged()
  {
    return (cast(GNetworkMonitorInterface*)cPtr).networkChanged;
  }

  alias CanReachFuncType = extern(C) bool function(GNetworkMonitor* monitor, GSocketConnectable* connectable, GCancellable* cancellable, GError** _err);

  @property CanReachFuncType canReach()
  {
    return (cast(GNetworkMonitorInterface*)cPtr).canReach;
  }

  alias CanReachAsyncFuncType = extern(C) void function(GNetworkMonitor* monitor, GSocketConnectable* connectable, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property CanReachAsyncFuncType canReachAsync()
  {
    return (cast(GNetworkMonitorInterface*)cPtr).canReachAsync;
  }

  alias CanReachFinishFuncType = extern(C) bool function(GNetworkMonitor* monitor, GAsyncResult* result, GError** _err);

  @property CanReachFinishFuncType canReachFinish()
  {
    return (cast(GNetworkMonitorInterface*)cPtr).canReachFinish;
  }
}
