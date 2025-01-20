module Gtk.TreeModelIface;

import Gid.gid;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

class TreeModelIface
{
  GtkTreeModelIface cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gtk.TreeModelIface");

    cInstance = *cast(GtkTreeModelIface*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  alias RowChangedFuncType = extern(C) void function(GtkTreeModel* treeModel, GtkTreePath* path, GtkTreeIter* iter);

  @property RowChangedFuncType rowChanged()
  {
    return (cast(GtkTreeModelIface*)cPtr).rowChanged;
  }

  alias RowInsertedFuncType = extern(C) void function(GtkTreeModel* treeModel, GtkTreePath* path, GtkTreeIter* iter);

  @property RowInsertedFuncType rowInserted()
  {
    return (cast(GtkTreeModelIface*)cPtr).rowInserted;
  }

  alias RowHasChildToggledFuncType = extern(C) void function(GtkTreeModel* treeModel, GtkTreePath* path, GtkTreeIter* iter);

  @property RowHasChildToggledFuncType rowHasChildToggled()
  {
    return (cast(GtkTreeModelIface*)cPtr).rowHasChildToggled;
  }

  alias RowDeletedFuncType = extern(C) void function(GtkTreeModel* treeModel, GtkTreePath* path);

  @property RowDeletedFuncType rowDeleted()
  {
    return (cast(GtkTreeModelIface*)cPtr).rowDeleted;
  }

  alias RowsReorderedFuncType = extern(C) void function(GtkTreeModel* treeModel, GtkTreePath* path, GtkTreeIter* iter, int* newOrder);

  @property RowsReorderedFuncType rowsReordered()
  {
    return (cast(GtkTreeModelIface*)cPtr).rowsReordered;
  }

  alias GetFlagsFuncType = extern(C) GtkTreeModelFlags function(GtkTreeModel* treeModel);

  @property GetFlagsFuncType getFlags()
  {
    return (cast(GtkTreeModelIface*)cPtr).getFlags;
  }

  alias GetNColumnsFuncType = extern(C) int function(GtkTreeModel* treeModel);

  @property GetNColumnsFuncType getNColumns()
  {
    return (cast(GtkTreeModelIface*)cPtr).getNColumns;
  }

  alias GetColumnTypeFuncType = extern(C) GType function(GtkTreeModel* treeModel, int index);

  @property GetColumnTypeFuncType getColumnType()
  {
    return (cast(GtkTreeModelIface*)cPtr).getColumnType;
  }

  alias GetIterFuncType = extern(C) bool function(GtkTreeModel* treeModel, GtkTreeIter* iter, GtkTreePath* path);

  @property GetIterFuncType getIter()
  {
    return (cast(GtkTreeModelIface*)cPtr).getIter;
  }

  alias GetPathFuncType = extern(C) GtkTreePath* function(GtkTreeModel* treeModel, GtkTreeIter* iter);

  @property GetPathFuncType getPath()
  {
    return (cast(GtkTreeModelIface*)cPtr).getPath;
  }

  alias GetValueFuncType = extern(C) void function(GtkTreeModel* treeModel, GtkTreeIter* iter, int column, GValue* value);

  @property GetValueFuncType getValue()
  {
    return (cast(GtkTreeModelIface*)cPtr).getValue;
  }

  alias IterNextFuncType = extern(C) bool function(GtkTreeModel* treeModel, GtkTreeIter* iter);

  @property IterNextFuncType iterNext()
  {
    return (cast(GtkTreeModelIface*)cPtr).iterNext;
  }

  alias IterPreviousFuncType = extern(C) bool function(GtkTreeModel* treeModel, GtkTreeIter* iter);

  @property IterPreviousFuncType iterPrevious()
  {
    return (cast(GtkTreeModelIface*)cPtr).iterPrevious;
  }

  alias IterChildrenFuncType = extern(C) bool function(GtkTreeModel* treeModel, GtkTreeIter* iter, GtkTreeIter* parent);

  @property IterChildrenFuncType iterChildren()
  {
    return (cast(GtkTreeModelIface*)cPtr).iterChildren;
  }

  alias IterHasChildFuncType = extern(C) bool function(GtkTreeModel* treeModel, GtkTreeIter* iter);

  @property IterHasChildFuncType iterHasChild()
  {
    return (cast(GtkTreeModelIface*)cPtr).iterHasChild;
  }

  alias IterNChildrenFuncType = extern(C) int function(GtkTreeModel* treeModel, GtkTreeIter* iter);

  @property IterNChildrenFuncType iterNChildren()
  {
    return (cast(GtkTreeModelIface*)cPtr).iterNChildren;
  }

  alias IterNthChildFuncType = extern(C) bool function(GtkTreeModel* treeModel, GtkTreeIter* iter, GtkTreeIter* parent, int n);

  @property IterNthChildFuncType iterNthChild()
  {
    return (cast(GtkTreeModelIface*)cPtr).iterNthChild;
  }

  alias IterParentFuncType = extern(C) bool function(GtkTreeModel* treeModel, GtkTreeIter* iter, GtkTreeIter* child);

  @property IterParentFuncType iterParent()
  {
    return (cast(GtkTreeModelIface*)cPtr).iterParent;
  }

  alias RefNodeFuncType = extern(C) void function(GtkTreeModel* treeModel, GtkTreeIter* iter);

  @property RefNodeFuncType refNode()
  {
    return (cast(GtkTreeModelIface*)cPtr).refNode;
  }

  alias UnrefNodeFuncType = extern(C) void function(GtkTreeModel* treeModel, GtkTreeIter* iter);

  @property UnrefNodeFuncType unrefNode()
  {
    return (cast(GtkTreeModelIface*)cPtr).unrefNode;
  }
}
