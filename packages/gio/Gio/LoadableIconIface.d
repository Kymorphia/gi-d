module Gio.LoadableIconIface;

import GObject.TypeInterface;
import Gid.gid;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * Interface for icons that can be loaded as a stream.
 */
class LoadableIconIface
{
  GLoadableIconIface cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.LoadableIconIface");

    cInstance = *cast(GLoadableIconIface*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property TypeInterface gIface()
  {
    return new TypeInterface(cast(GTypeInterface*)&(cast(GLoadableIconIface*)cPtr).gIface);
  }

  alias LoadFuncType = extern(C) GInputStream* function(GLoadableIcon* icon, int size, char** type, GCancellable* cancellable, GError** _err);

  @property LoadFuncType load()
  {
    return (cast(GLoadableIconIface*)cPtr).load;
  }

  alias LoadAsyncFuncType = extern(C) void function(GLoadableIcon* icon, int size, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property LoadAsyncFuncType loadAsync()
  {
    return (cast(GLoadableIconIface*)cPtr).loadAsync;
  }

  alias LoadFinishFuncType = extern(C) GInputStream* function(GLoadableIcon* icon, GAsyncResult* res, char** type, GError** _err);

  @property LoadFinishFuncType loadFinish()
  {
    return (cast(GLoadableIconIface*)cPtr).loadFinish;
  }
}
