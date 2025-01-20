module Gtk.TextBufferClass;

import GObject.ObjectClass;
import Gid.gid;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * The class structure for `GtkTextBuffer`.
 */
class TextBufferClass
{
  GtkTextBufferClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gtk.TextBufferClass");

    cInstance = *cast(GtkTextBufferClass*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property ObjectClass parentClass()
  {
    return new ObjectClass(cast(GObjectClass*)&(cast(GtkTextBufferClass*)cPtr).parentClass);
  }

  alias InsertTextFuncType = extern(C) void function(GtkTextBuffer* buffer, GtkTextIter* pos, const(char)* newText, int newTextLength);

  @property InsertTextFuncType insertText()
  {
    return (cast(GtkTextBufferClass*)cPtr).insertText;
  }

  alias InsertPaintableFuncType = extern(C) void function(GtkTextBuffer* buffer, GtkTextIter* iter, GdkPaintable* paintable);

  @property InsertPaintableFuncType insertPaintable()
  {
    return (cast(GtkTextBufferClass*)cPtr).insertPaintable;
  }

  alias InsertChildAnchorFuncType = extern(C) void function(GtkTextBuffer* buffer, GtkTextIter* iter, GtkTextChildAnchor* anchor);

  @property InsertChildAnchorFuncType insertChildAnchor()
  {
    return (cast(GtkTextBufferClass*)cPtr).insertChildAnchor;
  }

  alias DeleteRangeFuncType = extern(C) void function(GtkTextBuffer* buffer, GtkTextIter* start, GtkTextIter* end);

  @property DeleteRangeFuncType deleteRange()
  {
    return (cast(GtkTextBufferClass*)cPtr).deleteRange;
  }

  alias ChangedFuncType = extern(C) void function(GtkTextBuffer* buffer);

  @property ChangedFuncType changed()
  {
    return (cast(GtkTextBufferClass*)cPtr).changed;
  }

  alias ModifiedChangedFuncType = extern(C) void function(GtkTextBuffer* buffer);

  @property ModifiedChangedFuncType modifiedChanged()
  {
    return (cast(GtkTextBufferClass*)cPtr).modifiedChanged;
  }

  alias MarkSetFuncType = extern(C) void function(GtkTextBuffer* buffer, const(GtkTextIter)* location, GtkTextMark* mark);

  @property MarkSetFuncType markSet()
  {
    return (cast(GtkTextBufferClass*)cPtr).markSet;
  }

  alias MarkDeletedFuncType = extern(C) void function(GtkTextBuffer* buffer, GtkTextMark* mark);

  @property MarkDeletedFuncType markDeleted()
  {
    return (cast(GtkTextBufferClass*)cPtr).markDeleted;
  }

  alias ApplyTagFuncType = extern(C) void function(GtkTextBuffer* buffer, GtkTextTag* tag, const(GtkTextIter)* start, const(GtkTextIter)* end);

  @property ApplyTagFuncType applyTag()
  {
    return (cast(GtkTextBufferClass*)cPtr).applyTag;
  }

  alias RemoveTagFuncType = extern(C) void function(GtkTextBuffer* buffer, GtkTextTag* tag, const(GtkTextIter)* start, const(GtkTextIter)* end);

  @property RemoveTagFuncType removeTag()
  {
    return (cast(GtkTextBufferClass*)cPtr).removeTag;
  }

  alias BeginUserActionFuncType = extern(C) void function(GtkTextBuffer* buffer);

  @property BeginUserActionFuncType beginUserAction()
  {
    return (cast(GtkTextBufferClass*)cPtr).beginUserAction;
  }

  alias EndUserActionFuncType = extern(C) void function(GtkTextBuffer* buffer);

  @property EndUserActionFuncType endUserAction()
  {
    return (cast(GtkTextBufferClass*)cPtr).endUserAction;
  }

  alias PasteDoneFuncType = extern(C) void function(GtkTextBuffer* buffer, GdkClipboard* clipboard);

  @property PasteDoneFuncType pasteDone()
  {
    return (cast(GtkTextBufferClass*)cPtr).pasteDone;
  }

  alias UndoFuncType = extern(C) void function(GtkTextBuffer* buffer);

  @property UndoFuncType undo()
  {
    return (cast(GtkTextBufferClass*)cPtr).undo;
  }

  alias RedoFuncType = extern(C) void function(GtkTextBuffer* buffer);

  @property RedoFuncType redo()
  {
    return (cast(GtkTextBufferClass*)cPtr).redo;
  }
}
