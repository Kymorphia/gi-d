module Gtk.PrintOperationPreviewIface;

import GObject.TypeInterface;
import Gid.gid;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

class PrintOperationPreviewIface
{
  GtkPrintOperationPreviewIface cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gtk.PrintOperationPreviewIface");

    cInstance = *cast(GtkPrintOperationPreviewIface*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property TypeInterface gIface()
  {
    return new TypeInterface(cast(GTypeInterface*)&(cast(GtkPrintOperationPreviewIface*)cPtr).gIface);
  }

  alias ReadyFuncType = extern(C) void function(GtkPrintOperationPreview* preview, GtkPrintContext* context);

  @property ReadyFuncType ready()
  {
    return (cast(GtkPrintOperationPreviewIface*)cPtr).ready;
  }

  alias GotPageSizeFuncType = extern(C) void function(GtkPrintOperationPreview* preview, GtkPrintContext* context, GtkPageSetup* pageSetup);

  @property GotPageSizeFuncType gotPageSize()
  {
    return (cast(GtkPrintOperationPreviewIface*)cPtr).gotPageSize;
  }

  alias RenderPageFuncType = extern(C) void function(GtkPrintOperationPreview* preview, int pageNr);

  @property RenderPageFuncType renderPage()
  {
    return (cast(GtkPrintOperationPreviewIface*)cPtr).renderPage;
  }

  alias IsSelectedFuncType = extern(C) bool function(GtkPrintOperationPreview* preview, int pageNr);

  @property IsSelectedFuncType isSelected()
  {
    return (cast(GtkPrintOperationPreviewIface*)cPtr).isSelected;
  }

  alias EndPreviewFuncType = extern(C) void function(GtkPrintOperationPreview* preview);

  @property EndPreviewFuncType endPreview()
  {
    return (cast(GtkPrintOperationPreviewIface*)cPtr).endPreview;
  }
}
