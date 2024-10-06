module Gtk.PrintOperationClass;

import GObject.ObjectClass;
import Gid.gid;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

class PrintOperationClass
{
  GtkPrintOperationClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gtk.PrintOperationClass");

    cInstance = *cast(GtkPrintOperationClass*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property ObjectClass parentClass()
  {
    return new ObjectClass(cast(GObjectClass*)&(cast(GtkPrintOperationClass*)cPtr).parentClass);
  }

  alias DoneFuncType = extern(C) void function(GtkPrintOperation* operation, GtkPrintOperationResult result);

  @property DoneFuncType done()
  {
    return (cast(GtkPrintOperationClass*)cPtr).done;
  }

  alias BeginPrintFuncType = extern(C) void function(GtkPrintOperation* operation, GtkPrintContext* context);

  @property BeginPrintFuncType beginPrint()
  {
    return (cast(GtkPrintOperationClass*)cPtr).beginPrint;
  }

  alias PaginateFuncType = extern(C) bool function(GtkPrintOperation* operation, GtkPrintContext* context);

  @property PaginateFuncType paginate()
  {
    return (cast(GtkPrintOperationClass*)cPtr).paginate;
  }

  alias RequestPageSetupFuncType = extern(C) void function(GtkPrintOperation* operation, GtkPrintContext* context, int pageNr, GtkPageSetup* setup);

  @property RequestPageSetupFuncType requestPageSetup()
  {
    return (cast(GtkPrintOperationClass*)cPtr).requestPageSetup;
  }

  alias DrawPageFuncType = extern(C) void function(GtkPrintOperation* operation, GtkPrintContext* context, int pageNr);

  @property DrawPageFuncType drawPage()
  {
    return (cast(GtkPrintOperationClass*)cPtr).drawPage;
  }

  alias EndPrintFuncType = extern(C) void function(GtkPrintOperation* operation, GtkPrintContext* context);

  @property EndPrintFuncType endPrint()
  {
    return (cast(GtkPrintOperationClass*)cPtr).endPrint;
  }

  alias StatusChangedFuncType = extern(C) void function(GtkPrintOperation* operation);

  @property StatusChangedFuncType statusChanged()
  {
    return (cast(GtkPrintOperationClass*)cPtr).statusChanged;
  }

  alias CustomWidgetApplyFuncType = extern(C) void function(GtkPrintOperation* operation, GtkWidget* widget);

  @property CustomWidgetApplyFuncType customWidgetApply()
  {
    return (cast(GtkPrintOperationClass*)cPtr).customWidgetApply;
  }

  alias PreviewFuncType = extern(C) bool function(GtkPrintOperation* operation, GtkPrintOperationPreview* preview, GtkPrintContext* context, GtkWindow* parent);

  @property PreviewFuncType preview()
  {
    return (cast(GtkPrintOperationClass*)cPtr).preview;
  }

  alias UpdateCustomWidgetFuncType = extern(C) void function(GtkPrintOperation* operation, GtkWidget* widget, GtkPageSetup* setup, GtkPrintSettings* settings);

  @property UpdateCustomWidgetFuncType updateCustomWidget()
  {
    return (cast(GtkPrintOperationClass*)cPtr).updateCustomWidget;
  }
}
