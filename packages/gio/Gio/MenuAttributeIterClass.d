module Gio.MenuAttributeIterClass;

import GLib.Types;
import GLib.Variant;
import GLib.c.functions;
import GObject.ObjectClass;
import GObject.Types;
import Gid.Gid;
import Gio.MenuAttributeIter;
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
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GMenuAttributeIterClass))
  {
    return cast(T*)&cInstance;
  }

  @property ObjectClass parentClass()
  {
    return new ObjectClass(cast(GObjectClass*)&cPtr!GMenuAttributeIterClass.parentClass);
  }

  alias GetNextFuncType = extern(C) bool function(GMenuAttributeIter* iter, const(char*)* outName, GVariant** value);

  @property GetNextFuncType getNext()
  {
    return cPtr!GMenuAttributeIterClass.getNext;
  }
}
