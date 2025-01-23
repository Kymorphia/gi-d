module Gio.IconIface;

import GObject.TypeInterface;
import Gid.gid;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * GIconIface is used to implement GIcon types for various
 * different systems. See #GThemedIcon and #GLoadableIcon for
 * examples of how to implement this interface.
 */
class IconIface
{
  GIconIface cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.IconIface");

    cInstance = *cast(GIconIface*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property TypeInterface gIface()
  {
    return new TypeInterface(cast(GTypeInterface*)&(cast(GIconIface*)cPtr).gIface);
  }

  alias HashFuncType = extern(C) uint function(GIcon* icon);

  @property HashFuncType hash()
  {
    return (cast(GIconIface*)cPtr).hash;
  }

  alias EqualFuncType = extern(C) bool function(GIcon* icon1, GIcon* icon2);

  @property EqualFuncType equal()
  {
    return (cast(GIconIface*)cPtr).equal;
  }

  alias ToTokensFuncType = extern(C) bool function(GIcon* icon, GPtrArray* tokens, int* outVersion);

  @property ToTokensFuncType toTokens()
  {
    return (cast(GIconIface*)cPtr).toTokens;
  }

  alias SerializeFuncType = extern(C) VariantC* function(GIcon* icon);

  @property SerializeFuncType serialize()
  {
    return (cast(GIconIface*)cPtr).serialize;
  }
}
