module Gio.AsyncInitableIface;

import GObject.TypeInterface;
import Gid.gid;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * Provides an interface for asynchronous initializing object such that
 * initialization may fail.
 */
class AsyncInitableIface
{
  GAsyncInitableIface cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.AsyncInitableIface");

    cInstance = *cast(GAsyncInitableIface*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property TypeInterface gIface()
  {
    return new TypeInterface(cast(GTypeInterface*)&(cast(GAsyncInitableIface*)cPtr).gIface);
  }

  alias InitAsyncFuncType = extern(C) void function(GAsyncInitable* initable, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property InitAsyncFuncType initAsync()
  {
    return (cast(GAsyncInitableIface*)cPtr).initAsync;
  }

  alias InitFinishFuncType = extern(C) bool function(GAsyncInitable* initable, GAsyncResult* res, GError** _err);

  @property InitFinishFuncType initFinish()
  {
    return (cast(GAsyncInitableIface*)cPtr).initFinish;
  }
}
