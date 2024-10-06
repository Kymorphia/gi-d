module Gtk.ScaleButtonClass;

import Gid.gid;
import Gtk.Types;
import Gtk.WidgetClass;
import Gtk.c.functions;
import Gtk.c.types;

class ScaleButtonClass
{
  GtkScaleButtonClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gtk.ScaleButtonClass");

    cInstance = *cast(GtkScaleButtonClass*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property WidgetClass parentClass()
  {
    return new WidgetClass(cast(GtkWidgetClass*)&(cast(GtkScaleButtonClass*)cPtr).parentClass);
  }

  alias ValueChangedFuncType = extern(C) void function(GtkScaleButton* button, double value);

  @property ValueChangedFuncType valueChanged()
  {
    return (cast(GtkScaleButtonClass*)cPtr).valueChanged;
  }
}
