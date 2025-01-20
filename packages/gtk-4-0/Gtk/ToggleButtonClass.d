module Gtk.ToggleButtonClass;

import Gid.gid;
import Gtk.ButtonClass;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

class ToggleButtonClass
{
  GtkToggleButtonClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gtk.ToggleButtonClass");

    cInstance = *cast(GtkToggleButtonClass*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property ButtonClass parentClass()
  {
    return new ButtonClass(cast(GtkButtonClass*)&(cast(GtkToggleButtonClass*)cPtr).parentClass);
  }

  alias ToggledFuncType = extern(C) void function(GtkToggleButton* toggleButton);

  @property ToggledFuncType toggled()
  {
    return (cast(GtkToggleButtonClass*)cPtr).toggled;
  }
}
