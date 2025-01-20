module Gtk.NativeDialogClass;

import Gid.gid;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * Class structure for `GtkNativeDialog`.
 */
class NativeDialogClass
{
  GtkNativeDialogClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gtk.NativeDialogClass");

    cInstance = *cast(GtkNativeDialogClass*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  alias ResponseFuncType = extern(C) void function(GtkNativeDialog* self, int responseId);

  @property ResponseFuncType response()
  {
    return (cast(GtkNativeDialogClass*)cPtr).response;
  }

  alias ShowFuncType = extern(C) void function(GtkNativeDialog* self);

  @property ShowFuncType show()
  {
    return (cast(GtkNativeDialogClass*)cPtr).show;
  }

  alias HideFuncType = extern(C) void function(GtkNativeDialog* self);

  @property HideFuncType hide()
  {
    return (cast(GtkNativeDialogClass*)cPtr).hide;
  }
}
