module Gio.DataInputStreamClass;

import GLib.c.functions;
import Gid.Gid;
import Gio.BufferedInputStreamClass;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

class DataInputStreamClass
{
  GDataInputStreamClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.DataInputStreamClass");

    cInstance = *cast(GDataInputStreamClass*)ptr;

    if (ownedRef)
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GDataInputStreamClass))
  {
    return cast(T*)&cInstance;
  }

  @property BufferedInputStreamClass parentClass()
  {
    return new BufferedInputStreamClass(cast(GBufferedInputStreamClass*)&cPtr!GDataInputStreamClass.parentClass);
  }
}
