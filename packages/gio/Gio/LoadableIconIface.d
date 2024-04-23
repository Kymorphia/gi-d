module Gio.LoadableIconIface;

import GLib.c.functions;
import GObject.TypeInterface;
import GObject.Types;
import Gid.Gid;
import Gio.AsyncResult;
import Gio.Cancellable;
import Gio.InputStream;
import Gio.LoadableIcon;
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
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GLoadableIconIface))
  {
    return cast(T*)&cInstance;
  }

  @property TypeInterface gIface()
  {
    return new TypeInterface(cast(GTypeInterface*)&cPtr!GLoadableIconIface.gIface);
  }

  alias LoadFuncType = extern(C) GInputStream* function(GLoadableIcon* icon, int size, char** type, GCancellable* cancellable, GError** _err);

  @property LoadFuncType load()
  {
    return cPtr!GLoadableIconIface.load;
  }

  alias LoadAsyncFuncType = extern(C) void function(GLoadableIcon* icon, int size, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property LoadAsyncFuncType loadAsync()
  {
    return cPtr!GLoadableIconIface.loadAsync;
  }

  alias LoadFinishFuncType = extern(C) GInputStream* function(GLoadableIcon* icon, GAsyncResult* res, char** type, GError** _err);

  @property LoadFinishFuncType loadFinish()
  {
    return cPtr!GLoadableIconIface.loadFinish;
  }
}
