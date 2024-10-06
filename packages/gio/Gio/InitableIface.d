module Gio.InitableIface;

import GObject.TypeInterface;
import Gid.gid;
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
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property TypeInterface gIface()
  {
    return new TypeInterface(cast(GTypeInterface*)&(cast(GInitableIface*)cPtr).gIface);
  }

  alias InitFuncType = extern(C) bool function(GInitable* initable, GCancellable* cancellable, GError** _err);

  @property InitFuncType init_()
  {
    return (cast(GInitableIface*)cPtr).init_;
  }
}
