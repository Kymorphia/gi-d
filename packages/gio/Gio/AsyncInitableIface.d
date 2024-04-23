module Gio.AsyncInitableIface;

import GLib.c.functions;
import GObject.TypeInterface;
import GObject.Types;
import Gid.Gid;
import Gio.AsyncInitable;
import Gio.AsyncResult;
import Gio.Cancellable;
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
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GAsyncInitableIface))
  {
    return cast(T*)&cInstance;
  }

  @property TypeInterface gIface()
  {
    return new TypeInterface(cast(GTypeInterface*)&cPtr!GAsyncInitableIface.gIface);
  }

  alias InitAsyncFuncType = extern(C) void function(GAsyncInitable* initable, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property InitAsyncFuncType initAsync()
  {
    return cPtr!GAsyncInitableIface.initAsync;
  }

  alias InitFinishFuncType = extern(C) bool function(GAsyncInitable* initable, GAsyncResult* res, GError** _err);

  @property InitFinishFuncType initFinish()
  {
    return cPtr!GAsyncInitableIface.initFinish;
  }
}
