module Gio.MenuLinkIterClass;

import GLib.c.functions;
import GObject.ObjectClass;
import GObject.Types;
import Gid.Gid;
import Gio.MenuLinkIter;
import Gio.MenuModel;
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
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GMenuLinkIterClass))
  {
    return cast(T*)&cInstance;
  }

  @property ObjectClass parentClass()
  {
    return new ObjectClass(cast(GObjectClass*)&cPtr!GMenuLinkIterClass.parentClass);
  }

  alias GetNextFuncType = extern(C) bool function(GMenuLinkIter* iter, const(char*)* outLink, GMenuModel** value);

  @property GetNextFuncType getNext()
  {
    return cPtr!GMenuLinkIterClass.getNext;
  }
}
