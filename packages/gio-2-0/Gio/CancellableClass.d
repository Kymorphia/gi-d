module Gio.CancellableClass;

import GObject.ObjectClass;
import Gid.gid;
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
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property ObjectClass parentClass()
  {
    return new ObjectClass(cast(GObjectClass*)&(cast(GCancellableClass*)cPtr).parentClass);
  }

  alias CancelledFuncType = extern(C) void function(GCancellable* cancellable);

  @property CancelledFuncType cancelled()
  {
    return (cast(GCancellableClass*)cPtr).cancelled;
  }
}
