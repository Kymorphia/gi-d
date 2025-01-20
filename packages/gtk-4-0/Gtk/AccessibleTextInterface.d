module Gtk.AccessibleTextInterface;

import Gid.gid;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * The interface vtable for accessible objects containing text.
 */
class AccessibleTextInterface
{
  GtkAccessibleTextInterface cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gtk.AccessibleTextInterface");

    cInstance = *cast(GtkAccessibleTextInterface*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  alias GetContentsFuncType = extern(C) GBytes* function(GtkAccessibleText* self, uint start, uint end);

  @property GetContentsFuncType getContents()
  {
    return (cast(GtkAccessibleTextInterface*)cPtr).getContents;
  }

  alias GetContentsAtFuncType = extern(C) GBytes* function(GtkAccessibleText* self, uint offset, GtkAccessibleTextGranularity granularity, uint* start, uint* end);

  @property GetContentsAtFuncType getContentsAt()
  {
    return (cast(GtkAccessibleTextInterface*)cPtr).getContentsAt;
  }

  alias GetCaretPositionFuncType = extern(C) uint function(GtkAccessibleText* self);

  @property GetCaretPositionFuncType getCaretPosition()
  {
    return (cast(GtkAccessibleTextInterface*)cPtr).getCaretPosition;
  }

  alias GetSelectionFuncType = extern(C) bool function(GtkAccessibleText* self, size_t* nRanges, GtkAccessibleTextRange** ranges);

  @property GetSelectionFuncType getSelection()
  {
    return (cast(GtkAccessibleTextInterface*)cPtr).getSelection;
  }

  alias GetAttributesFuncType = extern(C) bool function(GtkAccessibleText* self, uint offset, size_t* nRanges, GtkAccessibleTextRange** ranges, char*** attributeNames, char*** attributeValues);

  @property GetAttributesFuncType getAttributes()
  {
    return (cast(GtkAccessibleTextInterface*)cPtr).getAttributes;
  }

  alias GetDefaultAttributesFuncType = extern(C) void function(GtkAccessibleText* self, char*** attributeNames, char*** attributeValues);

  @property GetDefaultAttributesFuncType getDefaultAttributes()
  {
    return (cast(GtkAccessibleTextInterface*)cPtr).getDefaultAttributes;
  }
}
