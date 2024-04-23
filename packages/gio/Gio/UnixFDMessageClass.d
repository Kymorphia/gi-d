module Gio.UnixFDMessageClass;

import GLib.c.functions;
import Gid.Gid;
import Gio.SocketControlMessageClass;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

class UnixFDMessageClass
{
  GUnixFDMessageClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.UnixFDMessageClass");

    cInstance = *cast(GUnixFDMessageClass*)ptr;

    if (ownedRef)
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GUnixFDMessageClass))
  {
    return cast(T*)&cInstance;
  }

  @property SocketControlMessageClass parentClass()
  {
    return new SocketControlMessageClass(cast(GSocketControlMessageClass*)&cPtr!GUnixFDMessageClass.parentClass);
  }
}
