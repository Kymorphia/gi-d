module Gio.SimpleActionGroupClass;

import GLib.c.functions;
import Gid.Gid;
import Gio.c.functions;
import Gio.c.types;

class SimpleActionGroupClass
{
  GSimpleActionGroupClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.SimpleActionGroupClass");

    cInstance = *cast(GSimpleActionGroupClass*)ptr;

    if (ownedRef)
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GSimpleActionGroupClass))
  {
    return cast(T*)&cInstance;
  }
}
