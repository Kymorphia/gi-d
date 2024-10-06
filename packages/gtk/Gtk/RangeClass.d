module Gtk.RangeClass;

import Gid.gid;
import Gtk.Types;
import Gtk.WidgetClass;
import Gtk.c.functions;
import Gtk.c.types;

class RangeClass
{
  GtkRangeClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gtk.RangeClass");

    cInstance = *cast(GtkRangeClass*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property WidgetClass parentClass()
  {
    return new WidgetClass(cast(GtkWidgetClass*)&(cast(GtkRangeClass*)cPtr).parentClass);
  }

  alias ValueChangedFuncType = extern(C) void function(GtkRange* range);

  @property ValueChangedFuncType valueChanged()
  {
    return (cast(GtkRangeClass*)cPtr).valueChanged;
  }

  alias AdjustBoundsFuncType = extern(C) void function(GtkRange* range, double newValue);

  @property AdjustBoundsFuncType adjustBounds()
  {
    return (cast(GtkRangeClass*)cPtr).adjustBounds;
  }

  alias MoveSliderFuncType = extern(C) void function(GtkRange* range, GtkScrollType scroll);

  @property MoveSliderFuncType moveSlider()
  {
    return (cast(GtkRangeClass*)cPtr).moveSlider;
  }

  alias GetRangeBorderFuncType = extern(C) void function(GtkRange* range, GtkBorder* border);

  @property GetRangeBorderFuncType getRangeBorder()
  {
    return (cast(GtkRangeClass*)cPtr).getRangeBorder;
  }

  alias ChangeValueFuncType = extern(C) bool function(GtkRange* range, GtkScrollType scroll, double newValue);

  @property ChangeValueFuncType changeValue()
  {
    return (cast(GtkRangeClass*)cPtr).changeValue;
  }
}
