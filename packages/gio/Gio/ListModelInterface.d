module Gio.ListModelInterface;

import GObject.TypeInterface;
import Gid.gid;
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
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property TypeInterface gIface()
  {
    return new TypeInterface(cast(GTypeInterface*)&(cast(GListModelInterface*)cPtr).gIface);
  }

  alias GetItemTypeFuncType = extern(C) GType function(GListModel* list);

  @property GetItemTypeFuncType getItemType()
  {
    return (cast(GListModelInterface*)cPtr).getItemType;
  }

  alias GetNItemsFuncType = extern(C) uint function(GListModel* list);

  @property GetNItemsFuncType getNItems()
  {
    return (cast(GListModelInterface*)cPtr).getNItems;
  }

  alias GetItemFuncType = extern(C) ObjectC* function(GListModel* list, uint position);

  @property GetItemFuncType getItem()
  {
    return (cast(GListModelInterface*)cPtr).getItem;
  }
}
