module Gio.MenuAttributeIterClass;

import GObject.ObjectClass;
import Gid.gid;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

class MenuAttributeIterClass
{
  GMenuAttributeIterClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.MenuAttributeIterClass");

    cInstance = *cast(GMenuAttributeIterClass*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property ObjectClass parentClass()
  {
    return new ObjectClass(cast(GObjectClass*)&(cast(GMenuAttributeIterClass*)cPtr).parentClass);
  }

  alias GetNextFuncType = extern(C) bool function(GMenuAttributeIter* iter, const(char*)* outName, GVariant** value);

  @property GetNextFuncType getNext()
  {
    return (cast(GMenuAttributeIterClass*)cPtr).getNext;
  }
}
