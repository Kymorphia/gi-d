module Gtk.CheckButtonClass;

import Gid.gid;
import Gtk.Types;
import Gtk.WidgetClass;
import Gtk.c.functions;
import Gtk.c.types;

class CheckButtonClass
{
  GtkCheckButtonClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gtk.CheckButtonClass");

    cInstance = *cast(GtkCheckButtonClass*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property WidgetClass parentClass()
  {
    return new WidgetClass(cast(GtkWidgetClass*)&(cast(GtkCheckButtonClass*)cPtr).parentClass);
  }

  alias ToggledFuncType = extern(C) void function(GtkCheckButton* checkButton);

  @property ToggledFuncType toggled()
  {
    return (cast(GtkCheckButtonClass*)cPtr).toggled;
  }

  alias ActivateFuncType = extern(C) void function(GtkCheckButton* checkButton);

  @property ActivateFuncType activate()
  {
    return (cast(GtkCheckButtonClass*)cPtr).activate;
  }
}
