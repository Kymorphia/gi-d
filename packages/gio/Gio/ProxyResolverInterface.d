module Gio.ProxyResolverInterface;

import GLib.c.functions;
import GObject.TypeInterface;
import GObject.Types;
import Gid.Gid;
import Gio.AsyncResult;
import Gio.Cancellable;
import Gio.ProxyResolver;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * The virtual function table for #GProxyResolver.
 */
class ProxyResolverInterface
{
  GProxyResolverInterface cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.ProxyResolverInterface");

    cInstance = *cast(GProxyResolverInterface*)ptr;

    if (ownedRef)
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GProxyResolverInterface))
  {
    return cast(T*)&cInstance;
  }

  @property TypeInterface gIface()
  {
    return new TypeInterface(cast(GTypeInterface*)&cPtr!GProxyResolverInterface.gIface);
  }

  alias IsSupportedFuncType = extern(C) bool function(GProxyResolver* resolver);

  @property IsSupportedFuncType isSupported()
  {
    return cPtr!GProxyResolverInterface.isSupported;
  }

  alias LookupFuncType = extern(C) char** function(GProxyResolver* resolver, const(char)* uri, GCancellable* cancellable, GError** _err);

  @property LookupFuncType lookup()
  {
    return cPtr!GProxyResolverInterface.lookup;
  }

  alias LookupAsyncFuncType = extern(C) void function(GProxyResolver* resolver, const(char)* uri, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property LookupAsyncFuncType lookupAsync()
  {
    return cPtr!GProxyResolverInterface.lookupAsync;
  }

  alias LookupFinishFuncType = extern(C) char** function(GProxyResolver* resolver, GAsyncResult* result, GError** _err);

  @property LookupFinishFuncType lookupFinish()
  {
    return cPtr!GProxyResolverInterface.lookupFinish;
  }
}
