module Gio.EmblemedIconClass;

import GLib.c.functions;
import GObject.ObjectClass;
import GObject.Types;
import Gid.Gid;
import Gio.c.functions;
import Gio.c.types;

class EmblemedIconClass
{
  GEmblemedIconClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.EmblemedIconClass");

    cInstance = *cast(GEmblemedIconClass*)ptr;

    if (ownedRef)
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GEmblemedIconClass))
  {
    return cast(T*)&cInstance;
  }

  @property ObjectClass parentClass()
  {
    return new ObjectClass(cast(GObjectClass*)&cPtr!GEmblemedIconClass.parentClass);
  }
}
