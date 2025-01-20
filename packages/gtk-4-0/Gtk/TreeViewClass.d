module Gtk.TreeViewClass;

import Gid.gid;
import Gtk.Types;
import Gtk.WidgetClass;
import Gtk.c.functions;
import Gtk.c.types;

class TreeViewClass
{
  GtkTreeViewClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gtk.TreeViewClass");

    cInstance = *cast(GtkTreeViewClass*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property WidgetClass parentClass()
  {
    return new WidgetClass(cast(GtkWidgetClass*)&(cast(GtkTreeViewClass*)cPtr).parentClass);
  }

  alias RowActivatedFuncType = extern(C) void function(GtkTreeView* treeView, GtkTreePath* path, GtkTreeViewColumn* column);

  @property RowActivatedFuncType rowActivated()
  {
    return (cast(GtkTreeViewClass*)cPtr).rowActivated;
  }

  alias TestExpandRowFuncType = extern(C) bool function(GtkTreeView* treeView, GtkTreeIter* iter, GtkTreePath* path);

  @property TestExpandRowFuncType testExpandRow()
  {
    return (cast(GtkTreeViewClass*)cPtr).testExpandRow;
  }

  alias TestCollapseRowFuncType = extern(C) bool function(GtkTreeView* treeView, GtkTreeIter* iter, GtkTreePath* path);

  @property TestCollapseRowFuncType testCollapseRow()
  {
    return (cast(GtkTreeViewClass*)cPtr).testCollapseRow;
  }

  alias RowExpandedFuncType = extern(C) void function(GtkTreeView* treeView, GtkTreeIter* iter, GtkTreePath* path);

  @property RowExpandedFuncType rowExpanded()
  {
    return (cast(GtkTreeViewClass*)cPtr).rowExpanded;
  }

  alias RowCollapsedFuncType = extern(C) void function(GtkTreeView* treeView, GtkTreeIter* iter, GtkTreePath* path);

  @property RowCollapsedFuncType rowCollapsed()
  {
    return (cast(GtkTreeViewClass*)cPtr).rowCollapsed;
  }

  alias ColumnsChangedFuncType = extern(C) void function(GtkTreeView* treeView);

  @property ColumnsChangedFuncType columnsChanged()
  {
    return (cast(GtkTreeViewClass*)cPtr).columnsChanged;
  }

  alias CursorChangedFuncType = extern(C) void function(GtkTreeView* treeView);

  @property CursorChangedFuncType cursorChanged()
  {
    return (cast(GtkTreeViewClass*)cPtr).cursorChanged;
  }

  alias MoveCursorFuncType = extern(C) bool function(GtkTreeView* treeView, GtkMovementStep step, int count, bool extend, bool modify);

  @property MoveCursorFuncType moveCursor()
  {
    return (cast(GtkTreeViewClass*)cPtr).moveCursor;
  }

  alias SelectAllFuncType = extern(C) bool function(GtkTreeView* treeView);

  @property SelectAllFuncType selectAll()
  {
    return (cast(GtkTreeViewClass*)cPtr).selectAll;
  }

  alias UnselectAllFuncType = extern(C) bool function(GtkTreeView* treeView);

  @property UnselectAllFuncType unselectAll()
  {
    return (cast(GtkTreeViewClass*)cPtr).unselectAll;
  }

  alias SelectCursorRowFuncType = extern(C) bool function(GtkTreeView* treeView, bool startEditing);

  @property SelectCursorRowFuncType selectCursorRow()
  {
    return (cast(GtkTreeViewClass*)cPtr).selectCursorRow;
  }

  alias ToggleCursorRowFuncType = extern(C) bool function(GtkTreeView* treeView);

  @property ToggleCursorRowFuncType toggleCursorRow()
  {
    return (cast(GtkTreeViewClass*)cPtr).toggleCursorRow;
  }

  alias ExpandCollapseCursorRowFuncType = extern(C) bool function(GtkTreeView* treeView, bool logical, bool expand, bool openAll);

  @property ExpandCollapseCursorRowFuncType expandCollapseCursorRow()
  {
    return (cast(GtkTreeViewClass*)cPtr).expandCollapseCursorRow;
  }

  alias SelectCursorParentFuncType = extern(C) bool function(GtkTreeView* treeView);

  @property SelectCursorParentFuncType selectCursorParent()
  {
    return (cast(GtkTreeViewClass*)cPtr).selectCursorParent;
  }

  alias StartInteractiveSearchFuncType = extern(C) bool function(GtkTreeView* treeView);

  @property StartInteractiveSearchFuncType startInteractiveSearch()
  {
    return (cast(GtkTreeViewClass*)cPtr).startInteractiveSearch;
  }
}
