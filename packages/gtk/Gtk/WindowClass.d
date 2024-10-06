module Gtk.WindowClass;

import Gid.gid;
import Gtk.Types;
import Gtk.WidgetClass;
import Gtk.c.functions;
import Gtk.c.types;

class WindowClass
{
  GtkWindowClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gtk.WindowClass");

    cInstance = *cast(GtkWindowClass*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property WidgetClass parentClass()
  {
    return new WidgetClass(cast(GtkWidgetClass*)&(cast(GtkWindowClass*)cPtr).parentClass);
  }

  alias ActivateFocusFuncType = extern(C) void function(GtkWindow* window);

  @property ActivateFocusFuncType activateFocus()
  {
    return (cast(GtkWindowClass*)cPtr).activateFocus;
  }

  alias ActivateDefaultFuncType = extern(C) void function(GtkWindow* window);

  @property ActivateDefaultFuncType activateDefault()
  {
    return (cast(GtkWindowClass*)cPtr).activateDefault;
  }

  alias KeysChangedFuncType = extern(C) void function(GtkWindow* window);

  @property KeysChangedFuncType keysChanged()
  {
    return (cast(GtkWindowClass*)cPtr).keysChanged;
  }

  alias EnableDebuggingFuncType = extern(C) bool function(GtkWindow* window, bool toggle);

  @property EnableDebuggingFuncType enableDebugging()
  {
    return (cast(GtkWindowClass*)cPtr).enableDebugging;
  }

  alias CloseRequestFuncType = extern(C) bool function(GtkWindow* window);

  @property CloseRequestFuncType closeRequest()
  {
    return (cast(GtkWindowClass*)cPtr).closeRequest;
  }
}
