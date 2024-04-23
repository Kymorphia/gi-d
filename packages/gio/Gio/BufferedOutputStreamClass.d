module Gio.BufferedOutputStreamClass;

import GLib.c.functions;
import Gid.Gid;
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
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GBufferedOutputStreamClass))
  {
    return cast(T*)&cInstance;
  }

  @property FilterOutputStreamClass parentClass()
  {
    return new FilterOutputStreamClass(cast(GFilterOutputStreamClass*)&cPtr!GBufferedOutputStreamClass.parentClass);
  }
}
