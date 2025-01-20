module Gio.DataInputStreamClass;

import Gid.gid;
import Gio.BufferedInputStreamClass;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

class DataInputStreamClass
{
  GDataInputStreamClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.DataInputStreamClass");

    cInstance = *cast(GDataInputStreamClass*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property BufferedInputStreamClass parentClass()
  {
    return new BufferedInputStreamClass(cast(GBufferedInputStreamClass*)&(cast(GDataInputStreamClass*)cPtr).parentClass);
  }
}
