module Gio.AsyncResultIface;

import GLib.c.functions;
import GObject.ObjectG;
import GObject.TypeInterface;
import GObject.Types;
import Gid.Gid;
import Gio.AsyncResult;
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
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GAsyncResultIface))
  {
    return cast(T*)&cInstance;
  }

  @property TypeInterface gIface()
  {
    return new TypeInterface(cast(GTypeInterface*)&cPtr!GAsyncResultIface.gIface);
  }

  alias GetUserDataFuncType = extern(C) void* function(GAsyncResult* res);

  @property GetUserDataFuncType getUserData()
  {
    return cPtr!GAsyncResultIface.getUserData;
  }

  alias GetSourceObjectFuncType = extern(C) ObjectC* function(GAsyncResult* res);

  @property GetSourceObjectFuncType getSourceObject()
  {
    return cPtr!GAsyncResultIface.getSourceObject;
  }

  alias IsTaggedFuncType = extern(C) bool function(GAsyncResult* res, void* sourceTag);

  @property IsTaggedFuncType isTagged()
  {
    return cPtr!GAsyncResultIface.isTagged;
  }
}
