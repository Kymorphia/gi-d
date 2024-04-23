module Gio.TcpWrapperConnectionClass;

import GLib.c.functions;
import Gid.Gid;
import Gio.TcpConnectionClass;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

class TcpWrapperConnectionClass
{
  GTcpWrapperConnectionClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.TcpWrapperConnectionClass");

    cInstance = *cast(GTcpWrapperConnectionClass*)ptr;

    if (ownedRef)
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GTcpWrapperConnectionClass))
  {
    return cast(T*)&cInstance;
  }

  @property TcpConnectionClass parentClass()
  {
    return new TcpConnectionClass(cast(GTcpConnectionClass*)&cPtr!GTcpWrapperConnectionClass.parentClass);
  }
}
