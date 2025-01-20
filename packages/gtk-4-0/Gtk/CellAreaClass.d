module Gtk.CellAreaClass;

import GObject.ParamSpec;
import Gid.gid;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

class CellAreaClass
{
  GtkCellAreaClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gtk.CellAreaClass");

    cInstance = *cast(GtkCellAreaClass*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  alias AddFuncType = extern(C) void function(GtkCellArea* area, GtkCellRenderer* renderer);

  @property AddFuncType add()
  {
    return (cast(GtkCellAreaClass*)cPtr).add;
  }

  alias RemoveFuncType = extern(C) void function(GtkCellArea* area, GtkCellRenderer* renderer);

  @property RemoveFuncType remove()
  {
    return (cast(GtkCellAreaClass*)cPtr).remove;
  }

  alias ForeachFuncType = extern(C) void function(GtkCellArea* area, GtkCellCallback callback, void* callbackData);

  @property ForeachFuncType foreach_()
  {
    return (cast(GtkCellAreaClass*)cPtr).foreach_;
  }

  alias ForeachAllocFuncType = extern(C) void function(GtkCellArea* area, GtkCellAreaContext* context, GtkWidget* widget, const(GdkRectangle)* cellArea, const(GdkRectangle)* backgroundArea, GtkCellAllocCallback callback, void* callbackData);

  @property ForeachAllocFuncType foreachAlloc()
  {
    return (cast(GtkCellAreaClass*)cPtr).foreachAlloc;
  }

  alias EventFuncType = extern(C) int function(GtkCellArea* area, GtkCellAreaContext* context, GtkWidget* widget, GdkEvent* event, const(GdkRectangle)* cellArea, GtkCellRendererState flags);

  @property EventFuncType event()
  {
    return (cast(GtkCellAreaClass*)cPtr).event;
  }

  alias SnapshotFuncType = extern(C) void function(GtkCellArea* area, GtkCellAreaContext* context, GtkWidget* widget, GtkSnapshot* snapshot, const(GdkRectangle)* backgroundArea, const(GdkRectangle)* cellArea, GtkCellRendererState flags, bool paintFocus);

  @property SnapshotFuncType snapshot()
  {
    return (cast(GtkCellAreaClass*)cPtr).snapshot;
  }

  alias ApplyAttributesFuncType = extern(C) void function(GtkCellArea* area, GtkTreeModel* treeModel, GtkTreeIter* iter, bool isExpander, bool isExpanded);

  @property ApplyAttributesFuncType applyAttributes()
  {
    return (cast(GtkCellAreaClass*)cPtr).applyAttributes;
  }

  alias CreateContextFuncType = extern(C) GtkCellAreaContext* function(GtkCellArea* area);

  @property CreateContextFuncType createContext()
  {
    return (cast(GtkCellAreaClass*)cPtr).createContext;
  }

  alias CopyContextFuncType = extern(C) GtkCellAreaContext* function(GtkCellArea* area, GtkCellAreaContext* context);

  @property CopyContextFuncType copyContext()
  {
    return (cast(GtkCellAreaClass*)cPtr).copyContext;
  }

  alias GetRequestModeFuncType = extern(C) GtkSizeRequestMode function(GtkCellArea* area);

  @property GetRequestModeFuncType getRequestMode()
  {
    return (cast(GtkCellAreaClass*)cPtr).getRequestMode;
  }

  alias GetPreferredWidthFuncType = extern(C) void function(GtkCellArea* area, GtkCellAreaContext* context, GtkWidget* widget, int* minimumWidth, int* naturalWidth);

  @property GetPreferredWidthFuncType getPreferredWidth()
  {
    return (cast(GtkCellAreaClass*)cPtr).getPreferredWidth;
  }

  alias GetPreferredHeightForWidthFuncType = extern(C) void function(GtkCellArea* area, GtkCellAreaContext* context, GtkWidget* widget, int width, int* minimumHeight, int* naturalHeight);

  @property GetPreferredHeightForWidthFuncType getPreferredHeightForWidth()
  {
    return (cast(GtkCellAreaClass*)cPtr).getPreferredHeightForWidth;
  }

  alias GetPreferredHeightFuncType = extern(C) void function(GtkCellArea* area, GtkCellAreaContext* context, GtkWidget* widget, int* minimumHeight, int* naturalHeight);

  @property GetPreferredHeightFuncType getPreferredHeight()
  {
    return (cast(GtkCellAreaClass*)cPtr).getPreferredHeight;
  }

  alias GetPreferredWidthForHeightFuncType = extern(C) void function(GtkCellArea* area, GtkCellAreaContext* context, GtkWidget* widget, int height, int* minimumWidth, int* naturalWidth);

  @property GetPreferredWidthForHeightFuncType getPreferredWidthForHeight()
  {
    return (cast(GtkCellAreaClass*)cPtr).getPreferredWidthForHeight;
  }

  alias SetCellPropertyFuncType = extern(C) void function(GtkCellArea* area, GtkCellRenderer* renderer, uint propertyId, const(GValue)* value, GParamSpec* pspec);

  @property SetCellPropertyFuncType setCellProperty()
  {
    return (cast(GtkCellAreaClass*)cPtr).setCellProperty;
  }

  alias GetCellPropertyFuncType = extern(C) void function(GtkCellArea* area, GtkCellRenderer* renderer, uint propertyId, GValue* value, GParamSpec* pspec);

  @property GetCellPropertyFuncType getCellProperty()
  {
    return (cast(GtkCellAreaClass*)cPtr).getCellProperty;
  }

  alias FocusFuncType = extern(C) bool function(GtkCellArea* area, GtkDirectionType direction);

  @property FocusFuncType focus()
  {
    return (cast(GtkCellAreaClass*)cPtr).focus;
  }

  alias IsActivatableFuncType = extern(C) bool function(GtkCellArea* area);

  @property IsActivatableFuncType isActivatable()
  {
    return (cast(GtkCellAreaClass*)cPtr).isActivatable;
  }

  alias ActivateFuncType = extern(C) bool function(GtkCellArea* area, GtkCellAreaContext* context, GtkWidget* widget, const(GdkRectangle)* cellArea, GtkCellRendererState flags, bool editOnly);

  @property ActivateFuncType activate()
  {
    return (cast(GtkCellAreaClass*)cPtr).activate;
  }

  /**
   * Finds a cell property of a cell area class by name.
   * Params:
   *   propertyName = the name of the child property to find
   * Returns: the `GParamSpec` of the child property
   */
  ParamSpec findCellProperty(string propertyName)
  {
    GParamSpec* _cretval;
    const(char)* _propertyName = propertyName.toCString(false);
    _cretval = gtk_cell_area_class_find_cell_property(cast(GtkCellAreaClass*)cPtr, _propertyName);
    auto _retval = _cretval ? new ParamSpec(cast(GParamSpec*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Installs a cell property on a cell area class.
   * Params:
   *   propertyId = the id for the property
   *   pspec = the `GParamSpec` for the property
   */
  void installCellProperty(uint propertyId, ParamSpec pspec)
  {
    gtk_cell_area_class_install_cell_property(cast(GtkCellAreaClass*)cPtr, propertyId, pspec ? cast(GParamSpec*)pspec.cPtr(false) : null);
  }

  /**
   * Returns all cell properties of a cell area class.
   * Returns: a newly
   *   allocated %NULL-terminated array of `GParamSpec`*.  The array
   *   must be freed with [GLib.Global.gfree].
   */
  ParamSpec[] listCellProperties()
  {
    GParamSpec** _cretval;
    uint _cretlength;
    _cretval = gtk_cell_area_class_list_cell_properties(cast(GtkCellAreaClass*)cPtr, &_cretlength);
    ParamSpec[] _retval;

    if (_cretval)
    {
      _retval = new ParamSpec[_cretlength];
      foreach (i; 0 .. _cretlength)
        _retval[i] = new ParamSpec(cast(void*)_cretval[i], false);
    }
    return _retval;
  }
}
