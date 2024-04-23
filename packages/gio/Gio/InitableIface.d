module Gio.InitableIface;

import GLib.c.functions;
import GObject.TypeInterface;
import GObject.Types;
import Gid.Gid;
import Gio.Cancellable;
import Gio.Initable;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * Provides an interface for initializing object such that initialization
 * may fail.
 */
class InitableIface
{
  GInitableIface cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.InitableIface");

    cInstance = *cast(GInitableIface*)ptr;

    if (ownedRef)
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GInitableIface))
  {
    return cast(T*)&cInstance;
  }

  @property TypeInterface gIface()
  {
    return new TypeInterface(cast(GTypeInterface*)&cPtr!GInitableIface.gIface);
  }

  alias InitFuncType = extern(C) bool function(GInitable* initable, GCancellable* cancellable, GError** _err);

  @property InitFuncType init_()
  {
    return cPtr!GInitableIface.init_;
  }
}
