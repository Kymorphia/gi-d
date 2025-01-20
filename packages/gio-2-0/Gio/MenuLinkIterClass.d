module Gio.MenuLinkIterClass;

import GObject.ObjectClass;
import Gid.gid;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

class MenuLinkIterClass
{
  GMenuLinkIterClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.MenuLinkIterClass");

    cInstance = *cast(GMenuLinkIterClass*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property ObjectClass parentClass()
  {
    return new ObjectClass(cast(GObjectClass*)&(cast(GMenuLinkIterClass*)cPtr).parentClass);
  }

  alias GetNextFuncType = extern(C) bool function(GMenuLinkIter* iter, const(char*)* outLink, GMenuModel** value);

  @property GetNextFuncType getNext()
  {
    return (cast(GMenuLinkIterClass*)cPtr).getNext;
  }
}
