module Gio.FilterOutputStreamClass;

import Gid.gid;
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
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property OutputStreamClass parentClass()
  {
    return new OutputStreamClass(cast(GOutputStreamClass*)&(cast(GFilterOutputStreamClass*)cPtr).parentClass);
  }
}
