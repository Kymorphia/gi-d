module Gtk.IMContextClass;

import Gid.gid;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

class IMContextClass
{
  GtkIMContextClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gtk.IMContextClass");

    cInstance = *cast(GtkIMContextClass*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  alias PreeditStartFuncType = extern(C) void function(GtkIMContext* context);

  @property PreeditStartFuncType preeditStart()
  {
    return (cast(GtkIMContextClass*)cPtr).preeditStart;
  }

  alias PreeditEndFuncType = extern(C) void function(GtkIMContext* context);

  @property PreeditEndFuncType preeditEnd()
  {
    return (cast(GtkIMContextClass*)cPtr).preeditEnd;
  }

  alias PreeditChangedFuncType = extern(C) void function(GtkIMContext* context);

  @property PreeditChangedFuncType preeditChanged()
  {
    return (cast(GtkIMContextClass*)cPtr).preeditChanged;
  }

  alias CommitFuncType = extern(C) void function(GtkIMContext* context, const(char)* str);

  @property CommitFuncType commit()
  {
    return (cast(GtkIMContextClass*)cPtr).commit;
  }

  alias RetrieveSurroundingFuncType = extern(C) bool function(GtkIMContext* context);

  @property RetrieveSurroundingFuncType retrieveSurrounding()
  {
    return (cast(GtkIMContextClass*)cPtr).retrieveSurrounding;
  }

  alias DeleteSurroundingFuncType = extern(C) bool function(GtkIMContext* context, int offset, int nChars);

  @property DeleteSurroundingFuncType deleteSurrounding()
  {
    return (cast(GtkIMContextClass*)cPtr).deleteSurrounding;
  }

  alias SetClientWidgetFuncType = extern(C) void function(GtkIMContext* context, GtkWidget* widget);

  @property SetClientWidgetFuncType setClientWidget()
  {
    return (cast(GtkIMContextClass*)cPtr).setClientWidget;
  }

  alias GetPreeditStringFuncType = extern(C) void function(GtkIMContext* context, char** str, PangoAttrList** attrs, int* cursorPos);

  @property GetPreeditStringFuncType getPreeditString()
  {
    return (cast(GtkIMContextClass*)cPtr).getPreeditString;
  }

  alias FilterKeypressFuncType = extern(C) bool function(GtkIMContext* context, GdkEvent* event);

  @property FilterKeypressFuncType filterKeypress()
  {
    return (cast(GtkIMContextClass*)cPtr).filterKeypress;
  }

  alias FocusInFuncType = extern(C) void function(GtkIMContext* context);

  @property FocusInFuncType focusIn()
  {
    return (cast(GtkIMContextClass*)cPtr).focusIn;
  }

  alias FocusOutFuncType = extern(C) void function(GtkIMContext* context);

  @property FocusOutFuncType focusOut()
  {
    return (cast(GtkIMContextClass*)cPtr).focusOut;
  }

  alias ResetFuncType = extern(C) void function(GtkIMContext* context);

  @property ResetFuncType reset()
  {
    return (cast(GtkIMContextClass*)cPtr).reset;
  }

  alias SetCursorLocationFuncType = extern(C) void function(GtkIMContext* context, GdkRectangle* area);

  @property SetCursorLocationFuncType setCursorLocation()
  {
    return (cast(GtkIMContextClass*)cPtr).setCursorLocation;
  }

  alias SetUsePreeditFuncType = extern(C) void function(GtkIMContext* context, bool usePreedit);

  @property SetUsePreeditFuncType setUsePreedit()
  {
    return (cast(GtkIMContextClass*)cPtr).setUsePreedit;
  }

  alias SetSurroundingFuncType = extern(C) void function(GtkIMContext* context, const(char)* text, int len, int cursorIndex);

  @property SetSurroundingFuncType setSurrounding()
  {
    return (cast(GtkIMContextClass*)cPtr).setSurrounding;
  }

  alias GetSurroundingFuncType = extern(C) bool function(GtkIMContext* context, char** text, int* cursorIndex);

  @property GetSurroundingFuncType getSurrounding()
  {
    return (cast(GtkIMContextClass*)cPtr).getSurrounding;
  }

  alias SetSurroundingWithSelectionFuncType = extern(C) void function(GtkIMContext* context, const(char)* text, int len, int cursorIndex, int anchorIndex);

  @property SetSurroundingWithSelectionFuncType setSurroundingWithSelection()
  {
    return (cast(GtkIMContextClass*)cPtr).setSurroundingWithSelection;
  }

  alias GetSurroundingWithSelectionFuncType = extern(C) bool function(GtkIMContext* context, char** text, int* cursorIndex, int* anchorIndex);

  @property GetSurroundingWithSelectionFuncType getSurroundingWithSelection()
  {
    return (cast(GtkIMContextClass*)cPtr).getSurroundingWithSelection;
  }

  alias ActivateOskFuncType = extern(C) void function(GtkIMContext* context);

  @property ActivateOskFuncType activateOsk()
  {
    return (cast(GtkIMContextClass*)cPtr).activateOsk;
  }

  alias ActivateOskWithEventFuncType = extern(C) bool function(GtkIMContext* context, GdkEvent* event);

  @property ActivateOskWithEventFuncType activateOskWithEvent()
  {
    return (cast(GtkIMContextClass*)cPtr).activateOskWithEvent;
  }
}
