module Gio.MemoryOutputStreamClass;

import GLib.c.functions;
import Gid.Gid;
import Gio.OutputStreamClass;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

class MemoryOutputStreamClass
{
  GMemoryOutputStreamClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.MemoryOutputStreamClass");

    cInstance = *cast(GMemoryOutputStreamClass*)ptr;

    if (ownedRef)
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GMemoryOutputStreamClass))
  {
    return cast(T*)&cInstance;
  }

  @property OutputStreamClass parentClass()
  {
    return new OutputStreamClass(cast(GOutputStreamClass*)&cPtr!GMemoryOutputStreamClass.parentClass);
  }
}
