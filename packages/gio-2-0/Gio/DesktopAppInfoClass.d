module Gio.DesktopAppInfoClass;

import GObject.ObjectClass;
import Gid.gid;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

class DesktopAppInfoClass
{
  GDesktopAppInfoClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.DesktopAppInfoClass");

    cInstance = *cast(GDesktopAppInfoClass*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property ObjectClass parentClass()
  {
    return new ObjectClass(cast(GObjectClass*)&(cast(GDesktopAppInfoClass*)cPtr).parentClass);
  }
}
