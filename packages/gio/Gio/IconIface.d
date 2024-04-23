module Gio.IconIface;

import GLib.PtrArray;
import GLib.Types;
import GLib.Variant;
import GLib.c.functions;
import GObject.TypeInterface;
import GObject.Types;
import Gid.Gid;
import Gio.Icon;
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
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GIconIface))
  {
    return cast(T*)&cInstance;
  }

  @property TypeInterface gIface()
  {
    return new TypeInterface(cast(GTypeInterface*)&cPtr!GIconIface.gIface);
  }

  alias HashFuncType = extern(C) uint function(GIcon* icon);

  @property HashFuncType hash()
  {
    return cPtr!GIconIface.hash;
  }

  alias EqualFuncType = extern(C) bool function(GIcon* icon1, GIcon* icon2);

  @property EqualFuncType equal()
  {
    return cPtr!GIconIface.equal;
  }

  alias ToTokensFuncType = extern(C) bool function(GIcon* icon, GPtrArray* tokens, int* outVersion);

  @property ToTokensFuncType toTokens()
  {
    return cPtr!GIconIface.toTokens;
  }

  alias SerializeFuncType = extern(C) GVariant* function(GIcon* icon);

  @property SerializeFuncType serialize()
  {
    return cPtr!GIconIface.serialize;
  }
}
