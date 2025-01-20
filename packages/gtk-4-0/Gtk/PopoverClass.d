module Gtk.PopoverClass;

import Gid.gid;
import Gtk.Types;
import Gtk.WidgetClass;
import Gtk.c.functions;
import Gtk.c.types;

class PopoverClass
{
  GtkPopoverClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gtk.PopoverClass");

    cInstance = *cast(GtkPopoverClass*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property WidgetClass parentClass()
  {
    return new WidgetClass(cast(GtkWidgetClass*)&(cast(GtkPopoverClass*)cPtr).parentClass);
  }

  alias ClosedFuncType = extern(C) void function(GtkPopover* popover);

  @property ClosedFuncType closed()
  {
    return (cast(GtkPopoverClass*)cPtr).closed;
  }

  alias ActivateDefaultFuncType = extern(C) void function(GtkPopover* popover);

  @property ActivateDefaultFuncType activateDefault()
  {
    return (cast(GtkPopoverClass*)cPtr).activateDefault;
  }
}
