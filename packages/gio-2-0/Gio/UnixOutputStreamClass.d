module Gio.UnixOutputStreamClass;

import Gid.gid;
import Gio.OutputStreamClass;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

class UnixOutputStreamClass
{
  GUnixOutputStreamClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.UnixOutputStreamClass");

    cInstance = *cast(GUnixOutputStreamClass*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property OutputStreamClass parentClass()
  {
    return new OutputStreamClass(cast(GOutputStreamClass*)&(cast(GUnixOutputStreamClass*)cPtr).parentClass);
  }
}
