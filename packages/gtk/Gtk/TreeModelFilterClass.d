module Gtk.TreeModelFilterClass;

import GObject.ObjectClass;
import Gid.gid;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

class TreeModelFilterClass
{
  GtkTreeModelFilterClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gtk.TreeModelFilterClass");

    cInstance = *cast(GtkTreeModelFilterClass*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property ObjectClass parentClass()
  {
    return new ObjectClass(cast(GObjectClass*)&(cast(GtkTreeModelFilterClass*)cPtr).parentClass);
  }

  alias VisibleFuncType = extern(C) bool function(GtkTreeModelFilter* self, GtkTreeModel* childModel, GtkTreeIter* iter);

  @property VisibleFuncType visible()
  {
    return (cast(GtkTreeModelFilterClass*)cPtr).visible;
  }

  alias ModifyFuncType = extern(C) void function(GtkTreeModelFilter* self, GtkTreeModel* childModel, GtkTreeIter* iter, GValue* value, int column);

  @property ModifyFuncType modify()
  {
    return (cast(GtkTreeModelFilterClass*)cPtr).modify;
  }
}
