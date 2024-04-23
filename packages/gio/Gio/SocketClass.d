module Gio.SocketClass;

import GLib.c.functions;
import GObject.ObjectClass;
import GObject.Types;
import Gid.Gid;
import Gio.c.functions;
import Gio.c.types;

class SocketClass
{
  GSocketClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.SocketClass");

    cInstance = *cast(GSocketClass*)ptr;

    if (ownedRef)
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GSocketClass))
  {
    return cast(T*)&cInstance;
  }

  @property ObjectClass parentClass()
  {
    return new ObjectClass(cast(GObjectClass*)&cPtr!GSocketClass.parentClass);
  }
}
