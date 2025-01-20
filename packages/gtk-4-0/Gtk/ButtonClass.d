module Gtk.ButtonClass;

import Gid.gid;
import Gtk.Types;
import Gtk.WidgetClass;
import Gtk.c.functions;
import Gtk.c.types;

class ButtonClass
{
  GtkButtonClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gtk.ButtonClass");

    cInstance = *cast(GtkButtonClass*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property WidgetClass parentClass()
  {
    return new WidgetClass(cast(GtkWidgetClass*)&(cast(GtkButtonClass*)cPtr).parentClass);
  }

  alias ClickedFuncType = extern(C) void function(GtkButton* button);

  @property ClickedFuncType clicked()
  {
    return (cast(GtkButtonClass*)cPtr).clicked;
  }

  alias ActivateFuncType = extern(C) void function(GtkButton* button);

  @property ActivateFuncType activate()
  {
    return (cast(GtkButtonClass*)cPtr).activate;
  }
}
