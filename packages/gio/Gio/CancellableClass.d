module Gio.CancellableClass;

import GLib.c.functions;
import GObject.ObjectClass;
import GObject.Types;
import Gid.Gid;
import Gio.Cancellable;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

class CancellableClass
{
  GCancellableClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.CancellableClass");

    cInstance = *cast(GCancellableClass*)ptr;

    if (ownedRef)
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GCancellableClass))
  {
    return cast(T*)&cInstance;
  }

  @property ObjectClass parentClass()
  {
    return new ObjectClass(cast(GObjectClass*)&cPtr!GCancellableClass.parentClass);
  }

  alias CancelledFuncType = extern(C) void function(GCancellable* cancellable);

  @property CancelledFuncType cancelled()
  {
    return cPtr!GCancellableClass.cancelled;
  }
}
