module Gio.FilterInputStreamClass;

import GLib.c.functions;
import Gid.Gid;
import Gio.InputStreamClass;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

class FilterInputStreamClass
{
  GFilterInputStreamClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.FilterInputStreamClass");

    cInstance = *cast(GFilterInputStreamClass*)ptr;

    if (ownedRef)
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GFilterInputStreamClass))
  {
    return cast(T*)&cInstance;
  }

  @property InputStreamClass parentClass()
  {
    return new InputStreamClass(cast(GInputStreamClass*)&cPtr!GFilterInputStreamClass.parentClass);
  }
}
