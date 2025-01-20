module Gtk.EntryClass;

import Gid.gid;
import Gtk.Types;
import Gtk.WidgetClass;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * Class structure for `GtkEntry`. All virtual functions have a default
 * implementation. Derived classes may set the virtual function pointers for the
 * signal handlers to %NULL, but must keep @get_text_area_size and
 * @get_frame_size non-%NULL; either use the default implementation, or provide
 * a custom one.
 */
class EntryClass
{
  GtkEntryClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gtk.EntryClass");

    cInstance = *cast(GtkEntryClass*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property WidgetClass parentClass()
  {
    return new WidgetClass(cast(GtkWidgetClass*)&(cast(GtkEntryClass*)cPtr).parentClass);
  }

  alias ActivateFuncType = extern(C) void function(GtkEntry* entry);

  @property ActivateFuncType activate()
  {
    return (cast(GtkEntryClass*)cPtr).activate;
  }
}
