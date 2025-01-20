module Gtk.AdjustmentClass;

import GObject.InitiallyUnownedClass;
import Gid.gid;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

class AdjustmentClass
{
  GtkAdjustmentClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gtk.AdjustmentClass");

    cInstance = *cast(GtkAdjustmentClass*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property InitiallyUnownedClass parentClass()
  {
    return new InitiallyUnownedClass(cast(GInitiallyUnownedClass*)&(cast(GtkAdjustmentClass*)cPtr).parentClass);
  }

  alias ChangedFuncType = extern(C) void function(GtkAdjustment* adjustment);

  @property ChangedFuncType changed()
  {
    return (cast(GtkAdjustmentClass*)cPtr).changed;
  }

  alias ValueChangedFuncType = extern(C) void function(GtkAdjustment* adjustment);

  @property ValueChangedFuncType valueChanged()
  {
    return (cast(GtkAdjustmentClass*)cPtr).valueChanged;
  }
}
