module Gtk.FlowBoxChildClass;

import Gid.gid;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

class FlowBoxChildClass
{
  GtkFlowBoxChildClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gtk.FlowBoxChildClass");

    cInstance = *cast(GtkFlowBoxChildClass*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  alias ActivateFuncType = extern(C) void function(GtkFlowBoxChild* child);

  @property ActivateFuncType activate()
  {
    return (cast(GtkFlowBoxChildClass*)cPtr).activate;
  }
}
