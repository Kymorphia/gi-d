module Gio.ZlibCompressorClass;

import GObject.ObjectClass;
import Gid.gid;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

class ZlibCompressorClass
{
  GZlibCompressorClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.ZlibCompressorClass");

    cInstance = *cast(GZlibCompressorClass*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property ObjectClass parentClass()
  {
    return new ObjectClass(cast(GObjectClass*)&(cast(GZlibCompressorClass*)cPtr).parentClass);
  }
}
