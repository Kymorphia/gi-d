module Gio.ConverterInputStreamClass;

import GLib.c.functions;
import Gid.Gid;
import Gio.FilterInputStreamClass;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

class ConverterInputStreamClass
{
  GConverterInputStreamClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.ConverterInputStreamClass");

    cInstance = *cast(GConverterInputStreamClass*)ptr;

    if (ownedRef)
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GConverterInputStreamClass))
  {
    return cast(T*)&cInstance;
  }

  @property FilterInputStreamClass parentClass()
  {
    return new FilterInputStreamClass(cast(GFilterInputStreamClass*)&cPtr!GConverterInputStreamClass.parentClass);
  }
}
