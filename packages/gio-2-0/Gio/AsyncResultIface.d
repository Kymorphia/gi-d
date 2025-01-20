module Gio.AsyncResultIface;

import GObject.TypeInterface;
import Gid.gid;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * Interface definition for #GAsyncResult.
 */
class AsyncResultIface
{
  GAsyncResultIface cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.AsyncResultIface");

    cInstance = *cast(GAsyncResultIface*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property TypeInterface gIface()
  {
    return new TypeInterface(cast(GTypeInterface*)&(cast(GAsyncResultIface*)cPtr).gIface);
  }

  alias GetUserDataFuncType = extern(C) void* function(GAsyncResult* res);

  @property GetUserDataFuncType getUserData()
  {
    return (cast(GAsyncResultIface*)cPtr).getUserData;
  }

  alias GetSourceObjectFuncType = extern(C) ObjectC* function(GAsyncResult* res);

  @property GetSourceObjectFuncType getSourceObject()
  {
    return (cast(GAsyncResultIface*)cPtr).getSourceObject;
  }

  alias IsTaggedFuncType = extern(C) bool function(GAsyncResult* res, void* sourceTag);

  @property IsTaggedFuncType isTagged()
  {
    return (cast(GAsyncResultIface*)cPtr).isTagged;
  }
}
