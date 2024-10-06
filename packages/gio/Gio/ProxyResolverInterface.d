module Gio.ProxyResolverInterface;

import GObject.TypeInterface;
import Gid.gid;
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
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property TypeInterface gIface()
  {
    return new TypeInterface(cast(GTypeInterface*)&(cast(GProxyResolverInterface*)cPtr).gIface);
  }

  alias IsSupportedFuncType = extern(C) bool function(GProxyResolver* resolver);

  @property IsSupportedFuncType isSupported()
  {
    return (cast(GProxyResolverInterface*)cPtr).isSupported;
  }

  alias LookupFuncType = extern(C) char** function(GProxyResolver* resolver, const(char)* uri, GCancellable* cancellable, GError** _err);

  @property LookupFuncType lookup()
  {
    return (cast(GProxyResolverInterface*)cPtr).lookup;
  }

  alias LookupAsyncFuncType = extern(C) void function(GProxyResolver* resolver, const(char)* uri, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property LookupAsyncFuncType lookupAsync()
  {
    return (cast(GProxyResolverInterface*)cPtr).lookupAsync;
  }

  alias LookupFinishFuncType = extern(C) char** function(GProxyResolver* resolver, GAsyncResult* result, GError** _err);

  @property LookupFinishFuncType lookupFinish()
  {
    return (cast(GProxyResolverInterface*)cPtr).lookupFinish;
  }
}
