module Gio.InetAddressClass;

import GLib.c.functions;
import GObject.ObjectClass;
import GObject.Types;
import Gid.Gid;
import Gio.InetAddress;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

class InetAddressClass
{
  GInetAddressClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.InetAddressClass");

    cInstance = *cast(GInetAddressClass*)ptr;

    if (ownedRef)
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GInetAddressClass))
  {
    return cast(T*)&cInstance;
  }

  @property ObjectClass parentClass()
  {
    return new ObjectClass(cast(GObjectClass*)&cPtr!GInetAddressClass.parentClass);
  }

  alias ToStringFuncType = extern(C) char* function(GInetAddress* address);

  @property ToStringFuncType toString_()
  {
    return cPtr!GInetAddressClass.toString_;
  }

  alias ToBytesFuncType = extern(C) const(ubyte)* function(GInetAddress* address);

  @property ToBytesFuncType toBytes()
  {
    return cPtr!GInetAddressClass.toBytes;
  }
}
