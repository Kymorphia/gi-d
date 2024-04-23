module Gio.SocketConnectionClass;

import GLib.c.functions;
import Gid.Gid;
import Gio.IOStreamClass;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

class SocketConnectionClass
{
  GSocketConnectionClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.SocketConnectionClass");

    cInstance = *cast(GSocketConnectionClass*)ptr;

    if (ownedRef)
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GSocketConnectionClass))
  {
    return cast(T*)&cInstance;
  }

  @property IOStreamClass parentClass()
  {
    return new IOStreamClass(cast(GIOStreamClass*)&cPtr!GSocketConnectionClass.parentClass);
  }
}
