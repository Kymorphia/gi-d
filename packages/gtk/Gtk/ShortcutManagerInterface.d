module Gtk.ShortcutManagerInterface;

import Gid.gid;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * The list of functions that can be implemented for the `GtkShortcutManager`
 * interface.
 * Note that no function is mandatory to implement, the default implementation
 * will work fine.
 */
class ShortcutManagerInterface
{
  GtkShortcutManagerInterface cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gtk.ShortcutManagerInterface");

    cInstance = *cast(GtkShortcutManagerInterface*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  alias AddControllerFuncType = extern(C) void function(GtkShortcutManager* self, GtkShortcutController* controller);

  @property AddControllerFuncType addController()
  {
    return (cast(GtkShortcutManagerInterface*)cPtr).addController;
  }

  alias RemoveControllerFuncType = extern(C) void function(GtkShortcutManager* self, GtkShortcutController* controller);

  @property RemoveControllerFuncType removeController()
  {
    return (cast(GtkShortcutManagerInterface*)cPtr).removeController;
  }
}
