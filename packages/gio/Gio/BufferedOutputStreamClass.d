module Gio.BufferedOutputStreamClass;

import Gid.gid;
import Gio.FilterOutputStreamClass;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

class BufferedOutputStreamClass
{
  GBufferedOutputStreamClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.BufferedOutputStreamClass");

    cInstance = *cast(GBufferedOutputStreamClass*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property FilterOutputStreamClass parentClass()
  {
    return new FilterOutputStreamClass(cast(GFilterOutputStreamClass*)&(cast(GBufferedOutputStreamClass*)cPtr).parentClass);
  }
}
