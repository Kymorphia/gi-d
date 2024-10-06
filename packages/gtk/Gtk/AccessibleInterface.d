module Gtk.AccessibleInterface;

import GObject.TypeInterface;
import Gid.gid;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * The common interface for accessible objects.
 */
class AccessibleInterface
{
  GtkAccessibleInterface cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gtk.AccessibleInterface");

    cInstance = *cast(GtkAccessibleInterface*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property TypeInterface gIface()
  {
    return new TypeInterface(cast(GTypeInterface*)&(cast(GtkAccessibleInterface*)cPtr).gIface);
  }

  alias GetAtContextFuncType = extern(C) GtkATContext* function(GtkAccessible* self);

  @property GetAtContextFuncType getAtContext()
  {
    return (cast(GtkAccessibleInterface*)cPtr).getAtContext;
  }

  alias GetPlatformStateFuncType = extern(C) bool function(GtkAccessible* self, GtkAccessiblePlatformState state);

  @property GetPlatformStateFuncType getPlatformState()
  {
    return (cast(GtkAccessibleInterface*)cPtr).getPlatformState;
  }

  alias GetAccessibleParentFuncType = extern(C) GtkAccessible* function(GtkAccessible* self);

  @property GetAccessibleParentFuncType getAccessibleParent()
  {
    return (cast(GtkAccessibleInterface*)cPtr).getAccessibleParent;
  }

  alias GetFirstAccessibleChildFuncType = extern(C) GtkAccessible* function(GtkAccessible* self);

  @property GetFirstAccessibleChildFuncType getFirstAccessibleChild()
  {
    return (cast(GtkAccessibleInterface*)cPtr).getFirstAccessibleChild;
  }

  alias GetNextAccessibleSiblingFuncType = extern(C) GtkAccessible* function(GtkAccessible* self);

  @property GetNextAccessibleSiblingFuncType getNextAccessibleSibling()
  {
    return (cast(GtkAccessibleInterface*)cPtr).getNextAccessibleSibling;
  }

  alias GetBoundsFuncType = extern(C) bool function(GtkAccessible* self, int* x, int* y, int* width, int* height);

  @property GetBoundsFuncType getBounds()
  {
    return (cast(GtkAccessibleInterface*)cPtr).getBounds;
  }
}
