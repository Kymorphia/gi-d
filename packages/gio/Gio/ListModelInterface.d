module Gio.ListModelInterface;

import GLib.c.functions;
import GObject.ObjectG;
import GObject.TypeInterface;
import GObject.Types;
import Gid.Gid;
import Gio.ListModel;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * The virtual function table for #GListModel.
 */
class ListModelInterface
{
  GListModelInterface cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.ListModelInterface");

    cInstance = *cast(GListModelInterface*)ptr;

    if (ownedRef)
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GListModelInterface))
  {
    return cast(T*)&cInstance;
  }

  @property TypeInterface gIface()
  {
    return new TypeInterface(cast(GTypeInterface*)&cPtr!GListModelInterface.gIface);
  }

  alias GetItemTypeFuncType = extern(C) GType function(GListModel* list);

  @property GetItemTypeFuncType getItemType()
  {
    return cPtr!GListModelInterface.getItemType;
  }

  alias GetNItemsFuncType = extern(C) uint function(GListModel* list);

  @property GetNItemsFuncType getNItems()
  {
    return cPtr!GListModelInterface.getNItems;
  }

  alias GetItemFuncType = extern(C) ObjectC* function(GListModel* list, uint position);

  @property GetItemFuncType getItem()
  {
    return cPtr!GListModelInterface.getItem;
  }
}
