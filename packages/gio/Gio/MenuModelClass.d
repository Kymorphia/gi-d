module Gio.MenuModelClass;

import GLib.Types;
import GLib.Variant;
import GLib.VariantType;
import GLib.c.functions;
import GObject.ObjectClass;
import GObject.Types;
import Gid.Gid;
import Gio.MenuAttributeIter;
import Gio.MenuLinkIter;
import Gio.MenuModel;
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
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GMenuModelClass))
  {
    return cast(T*)&cInstance;
  }

  @property ObjectClass parentClass()
  {
    return new ObjectClass(cast(GObjectClass*)&cPtr!GMenuModelClass.parentClass);
  }

  alias IsMutableFuncType = extern(C) bool function(GMenuModel* model);

  @property IsMutableFuncType isMutable()
  {
    return cPtr!GMenuModelClass.isMutable;
  }

  alias GetNItemsFuncType = extern(C) int function(GMenuModel* model);

  @property GetNItemsFuncType getNItems()
  {
    return cPtr!GMenuModelClass.getNItems;
  }

  alias GetItemAttributesFuncType = extern(C) void function(GMenuModel* model, int itemIndex, GHashTable** attributes);

  @property GetItemAttributesFuncType getItemAttributes()
  {
    return cPtr!GMenuModelClass.getItemAttributes;
  }

  alias IterateItemAttributesFuncType = extern(C) GMenuAttributeIter* function(GMenuModel* model, int itemIndex);

  @property IterateItemAttributesFuncType iterateItemAttributes()
  {
    return cPtr!GMenuModelClass.iterateItemAttributes;
  }

  alias GetItemAttributeValueFuncType = extern(C) GVariant* function(GMenuModel* model, int itemIndex, const(char)* attribute, const(GVariantType)* expectedType);

  @property GetItemAttributeValueFuncType getItemAttributeValue()
  {
    return cPtr!GMenuModelClass.getItemAttributeValue;
  }

  alias GetItemLinksFuncType = extern(C) void function(GMenuModel* model, int itemIndex, GHashTable** links);

  @property GetItemLinksFuncType getItemLinks()
  {
    return cPtr!GMenuModelClass.getItemLinks;
  }

  alias IterateItemLinksFuncType = extern(C) GMenuLinkIter* function(GMenuModel* model, int itemIndex);

  @property IterateItemLinksFuncType iterateItemLinks()
  {
    return cPtr!GMenuModelClass.iterateItemLinks;
  }

  alias GetItemLinkFuncType = extern(C) GMenuModel* function(GMenuModel* model, int itemIndex, const(char)* link);

  @property GetItemLinkFuncType getItemLink()
  {
    return cPtr!GMenuModelClass.getItemLink;
  }
}
