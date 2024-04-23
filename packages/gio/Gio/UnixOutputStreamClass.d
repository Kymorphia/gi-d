module Gio.UnixOutputStreamClass;

import GLib.c.functions;
import Gid.Gid;
import Gio.OutputStreamClass;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

class UnixOutputStreamClass
{
  GUnixOutputStreamClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.UnixOutputStreamClass");

    cInstance = *cast(GUnixOutputStreamClass*)ptr;

    if (ownedRef)
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GUnixOutputStreamClass))
  {
    return cast(T*)&cInstance;
  }

  @property OutputStreamClass parentClass()
  {
    return new OutputStreamClass(cast(GOutputStreamClass*)&cPtr!GUnixOutputStreamClass.parentClass);
  }
}
