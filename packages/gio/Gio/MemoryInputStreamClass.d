module Gio.MemoryInputStreamClass;

import GLib.c.functions;
import Gid.Gid;
import Gio.InputStreamClass;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

class MemoryInputStreamClass
{
  GMemoryInputStreamClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.MemoryInputStreamClass");

    cInstance = *cast(GMemoryInputStreamClass*)ptr;

    if (ownedRef)
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GMemoryInputStreamClass))
  {
    return cast(T*)&cInstance;
  }

  @property InputStreamClass parentClass()
  {
    return new InputStreamClass(cast(GInputStreamClass*)&cPtr!GMemoryInputStreamClass.parentClass);
  }
}
