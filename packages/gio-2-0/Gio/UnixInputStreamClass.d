module Gio.UnixInputStreamClass;

import Gid.gid;
import Gio.InputStreamClass;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

class UnixInputStreamClass
{
  GUnixInputStreamClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.UnixInputStreamClass");

    cInstance = *cast(GUnixInputStreamClass*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property InputStreamClass parentClass()
  {
    return new InputStreamClass(cast(GInputStreamClass*)&(cast(GUnixInputStreamClass*)cPtr).parentClass);
  }
}
