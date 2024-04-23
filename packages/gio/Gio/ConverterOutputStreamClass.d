module Gio.ConverterOutputStreamClass;

import GLib.c.functions;
import Gid.Gid;
import Gio.FilterOutputStreamClass;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

class ConverterOutputStreamClass
{
  GConverterOutputStreamClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.ConverterOutputStreamClass");

    cInstance = *cast(GConverterOutputStreamClass*)ptr;

    if (ownedRef)
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GConverterOutputStreamClass))
  {
    return cast(T*)&cInstance;
  }

  @property FilterOutputStreamClass parentClass()
  {
    return new FilterOutputStreamClass(cast(GFilterOutputStreamClass*)&cPtr!GConverterOutputStreamClass.parentClass);
  }
}
