module Gio.DataOutputStreamClass;

import GLib.c.functions;
import Gid.Gid;
import Gio.FilterOutputStreamClass;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

class DataOutputStreamClass
{
  GDataOutputStreamClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.DataOutputStreamClass");

    cInstance = *cast(GDataOutputStreamClass*)ptr;

    if (ownedRef)
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GDataOutputStreamClass))
  {
    return cast(T*)&cInstance;
  }

  @property FilterOutputStreamClass parentClass()
  {
    return new FilterOutputStreamClass(cast(GFilterOutputStreamClass*)&cPtr!GDataOutputStreamClass.parentClass);
  }
}
