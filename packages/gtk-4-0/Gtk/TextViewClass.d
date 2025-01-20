module Gtk.TextViewClass;

import Gid.gid;
import Gtk.Types;
import Gtk.WidgetClass;
import Gtk.c.functions;
import Gtk.c.types;

class TextViewClass
{
  GtkTextViewClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gtk.TextViewClass");

    cInstance = *cast(GtkTextViewClass*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property WidgetClass parentClass()
  {
    return new WidgetClass(cast(GtkWidgetClass*)&(cast(GtkTextViewClass*)cPtr).parentClass);
  }

  alias MoveCursorFuncType = extern(C) void function(GtkTextView* textView, GtkMovementStep step, int count, bool extendSelection);

  @property MoveCursorFuncType moveCursor()
  {
    return (cast(GtkTextViewClass*)cPtr).moveCursor;
  }

  alias SetAnchorFuncType = extern(C) void function(GtkTextView* textView);

  @property SetAnchorFuncType setAnchor()
  {
    return (cast(GtkTextViewClass*)cPtr).setAnchor;
  }

  alias InsertAtCursorFuncType = extern(C) void function(GtkTextView* textView, const(char)* str);

  @property InsertAtCursorFuncType insertAtCursor()
  {
    return (cast(GtkTextViewClass*)cPtr).insertAtCursor;
  }

  alias DeleteFromCursorFuncType = extern(C) void function(GtkTextView* textView, GtkDeleteType type, int count);

  @property DeleteFromCursorFuncType deleteFromCursor()
  {
    return (cast(GtkTextViewClass*)cPtr).deleteFromCursor;
  }

  alias BackspaceFuncType = extern(C) void function(GtkTextView* textView);

  @property BackspaceFuncType backspace()
  {
    return (cast(GtkTextViewClass*)cPtr).backspace;
  }

  alias CutClipboardFuncType = extern(C) void function(GtkTextView* textView);

  @property CutClipboardFuncType cutClipboard()
  {
    return (cast(GtkTextViewClass*)cPtr).cutClipboard;
  }

  alias CopyClipboardFuncType = extern(C) void function(GtkTextView* textView);

  @property CopyClipboardFuncType copyClipboard()
  {
    return (cast(GtkTextViewClass*)cPtr).copyClipboard;
  }

  alias PasteClipboardFuncType = extern(C) void function(GtkTextView* textView);

  @property PasteClipboardFuncType pasteClipboard()
  {
    return (cast(GtkTextViewClass*)cPtr).pasteClipboard;
  }

  alias ToggleOverwriteFuncType = extern(C) void function(GtkTextView* textView);

  @property ToggleOverwriteFuncType toggleOverwrite()
  {
    return (cast(GtkTextViewClass*)cPtr).toggleOverwrite;
  }

  alias SnapshotLayerFuncType = extern(C) void function(GtkTextView* textView, GtkTextViewLayer layer, GtkSnapshot* snapshot);

  @property SnapshotLayerFuncType snapshotLayer()
  {
    return (cast(GtkTextViewClass*)cPtr).snapshotLayer;
  }

  alias ExtendSelectionFuncType = extern(C) bool function(GtkTextView* textView, GtkTextExtendSelection granularity, const(GtkTextIter)* location, GtkTextIter* start, GtkTextIter* end);

  @property ExtendSelectionFuncType extendSelection()
  {
    return (cast(GtkTextViewClass*)cPtr).extendSelection;
  }

  alias InsertEmojiFuncType = extern(C) void function(GtkTextView* textView);

  @property InsertEmojiFuncType insertEmoji()
  {
    return (cast(GtkTextViewClass*)cPtr).insertEmoji;
  }
}
