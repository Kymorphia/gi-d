module Gio.FilterOutputStreamClass;

import GLib.c.functions;
import Gid.Gid;
import Gio.OutputStreamClass;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

class FilterOutputStreamClass
{
  GFilterOutputStreamClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.FilterOutputStreamClass");

    cInstance = *cast(GFilterOutputStreamClass*)ptr;

    if (ownedRef)
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GFilterOutputStreamClass))
  {
    return cast(T*)&cInstance;
  }

  @property OutputStreamClass parentClass()
  {
    return new OutputStreamClass(cast(GOutputStreamClass*)&cPtr!GFilterOutputStreamClass.parentClass);
  }
}
