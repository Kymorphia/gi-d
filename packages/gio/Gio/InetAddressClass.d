module Gio.InetAddressClass;

import GObject.ObjectClass;
import Gid.gid;
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
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property ObjectClass parentClass()
  {
    return new ObjectClass(cast(GObjectClass*)&(cast(GInetAddressClass*)cPtr).parentClass);
  }

  alias ToStringFuncType = extern(C) char* function(GInetAddress* address);

  @property ToStringFuncType toString_()
  {
    return (cast(GInetAddressClass*)cPtr).toString_;
  }

  alias ToBytesFuncType = extern(C) const(ubyte)* function(GInetAddress* address);

  @property ToBytesFuncType toBytes()
  {
    return (cast(GInetAddressClass*)cPtr).toBytes;
  }
}
