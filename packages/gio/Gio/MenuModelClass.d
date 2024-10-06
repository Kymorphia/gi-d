module Gio.MenuModelClass;

import GObject.ObjectClass;
import Gid.gid;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

class MenuModelClass
{
  GMenuModelClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.MenuModelClass");

    cInstance = *cast(GMenuModelClass*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property ObjectClass parentClass()
  {
    return new ObjectClass(cast(GObjectClass*)&(cast(GMenuModelClass*)cPtr).parentClass);
  }

  alias IsMutableFuncType = extern(C) bool function(GMenuModel* model);

  @property IsMutableFuncType isMutable()
  {
    return (cast(GMenuModelClass*)cPtr).isMutable;
  }

  alias GetNItemsFuncType = extern(C) int function(GMenuModel* model);

  @property GetNItemsFuncType getNItems()
  {
    return (cast(GMenuModelClass*)cPtr).getNItems;
  }

  alias GetItemAttributesFuncType = extern(C) void function(GMenuModel* model, int itemIndex, GHashTable** attributes);

  @property GetItemAttributesFuncType getItemAttributes()
  {
    return (cast(GMenuModelClass*)cPtr).getItemAttributes;
  }

  alias IterateItemAttributesFuncType = extern(C) GMenuAttributeIter* function(GMenuModel* model, int itemIndex);

  @property IterateItemAttributesFuncType iterateItemAttributes()
  {
    return (cast(GMenuModelClass*)cPtr).iterateItemAttributes;
  }

  alias GetItemAttributeValueFuncType = extern(C) GVariant* function(GMenuModel* model, int itemIndex, const(char)* attribute, const(GVariantType)* expectedType);

  @property GetItemAttributeValueFuncType getItemAttributeValue()
  {
    return (cast(GMenuModelClass*)cPtr).getItemAttributeValue;
  }

  alias GetItemLinksFuncType = extern(C) void function(GMenuModel* model, int itemIndex, GHashTable** links);

  @property GetItemLinksFuncType getItemLinks()
  {
    return (cast(GMenuModelClass*)cPtr).getItemLinks;
  }

  alias IterateItemLinksFuncType = extern(C) GMenuLinkIter* function(GMenuModel* model, int itemIndex);

  @property IterateItemLinksFuncType iterateItemLinks()
  {
    return (cast(GMenuModelClass*)cPtr).iterateItemLinks;
  }

  alias GetItemLinkFuncType = extern(C) GMenuModel* function(GMenuModel* model, int itemIndex, const(char)* link);

  @property GetItemLinkFuncType getItemLink()
  {
    return (cast(GMenuModelClass*)cPtr).getItemLink;
  }
}
