module Gtk.DialogClass;

import Gid.gid;
import Gtk.Types;
import Gtk.WindowClass;
import Gtk.c.functions;
import Gtk.c.types;

class DialogClass
{
  GtkDialogClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gtk.DialogClass");

    cInstance = *cast(GtkDialogClass*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property WindowClass parentClass()
  {
    return new WindowClass(cast(GtkWindowClass*)&(cast(GtkDialogClass*)cPtr).parentClass);
  }

  alias ResponseFuncType = extern(C) void function(GtkDialog* dialog, int responseId);

  @property ResponseFuncType response()
  {
    return (cast(GtkDialogClass*)cPtr).response;
  }

  alias CloseFuncType = extern(C) void function(GtkDialog* dialog);

  @property CloseFuncType close()
  {
    return (cast(GtkDialogClass*)cPtr).close;
  }
}
