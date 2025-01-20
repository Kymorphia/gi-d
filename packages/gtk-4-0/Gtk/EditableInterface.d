module Gtk.EditableInterface;

import GObject.TypeInterface;
import Gid.gid;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

class EditableInterface
{
  GtkEditableInterface cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gtk.EditableInterface");

    cInstance = *cast(GtkEditableInterface*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property TypeInterface baseIface()
  {
    return new TypeInterface(cast(GTypeInterface*)&(cast(GtkEditableInterface*)cPtr).baseIface);
  }

  alias InsertTextFuncType = extern(C) void function(GtkEditable* editable, const(char)* text, int length, int* position);

  @property InsertTextFuncType insertText()
  {
    return (cast(GtkEditableInterface*)cPtr).insertText;
  }

  alias DeleteTextFuncType = extern(C) void function(GtkEditable* editable, int startPos, int endPos);

  @property DeleteTextFuncType deleteText()
  {
    return (cast(GtkEditableInterface*)cPtr).deleteText;
  }

  alias ChangedFuncType = extern(C) void function(GtkEditable* editable);

  @property ChangedFuncType changed()
  {
    return (cast(GtkEditableInterface*)cPtr).changed;
  }

  alias GetTextFuncType = extern(C) const(char)* function(GtkEditable* editable);

  @property GetTextFuncType getText()
  {
    return (cast(GtkEditableInterface*)cPtr).getText;
  }

  alias DoInsertTextFuncType = extern(C) void function(GtkEditable* editable, const(char)* text, int length, int* position);

  @property DoInsertTextFuncType doInsertText()
  {
    return (cast(GtkEditableInterface*)cPtr).doInsertText;
  }

  alias DoDeleteTextFuncType = extern(C) void function(GtkEditable* editable, int startPos, int endPos);

  @property DoDeleteTextFuncType doDeleteText()
  {
    return (cast(GtkEditableInterface*)cPtr).doDeleteText;
  }

  alias GetSelectionBoundsFuncType = extern(C) bool function(GtkEditable* editable, int* startPos, int* endPos);

  @property GetSelectionBoundsFuncType getSelectionBounds()
  {
    return (cast(GtkEditableInterface*)cPtr).getSelectionBounds;
  }

  alias SetSelectionBoundsFuncType = extern(C) void function(GtkEditable* editable, int startPos, int endPos);

  @property SetSelectionBoundsFuncType setSelectionBounds()
  {
    return (cast(GtkEditableInterface*)cPtr).setSelectionBounds;
  }

  alias GetDelegateFuncType = extern(C) GtkEditable* function(GtkEditable* editable);

  @property GetDelegateFuncType getDelegate()
  {
    return (cast(GtkEditableInterface*)cPtr).getDelegate;
  }
}
