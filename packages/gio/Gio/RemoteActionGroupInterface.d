module Gio.RemoteActionGroupInterface;

import GLib.Types;
import GLib.Variant;
import GLib.c.functions;
import GObject.TypeInterface;
import GObject.Types;
import Gid.Gid;
import Gio.RemoteActionGroup;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * The virtual function table for #GRemoteActionGroup.
 */
class RemoteActionGroupInterface
{
  GRemoteActionGroupInterface cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.RemoteActionGroupInterface");

    cInstance = *cast(GRemoteActionGroupInterface*)ptr;

    if (ownedRef)
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GRemoteActionGroupInterface))
  {
    return cast(T*)&cInstance;
  }

  @property TypeInterface gIface()
  {
    return new TypeInterface(cast(GTypeInterface*)&cPtr!GRemoteActionGroupInterface.gIface);
  }

  alias ActivateActionFullFuncType = extern(C) void function(GRemoteActionGroup* remote, const(char)* actionName, GVariant* parameter, GVariant* platformData);

  @property ActivateActionFullFuncType activateActionFull()
  {
    return cPtr!GRemoteActionGroupInterface.activateActionFull;
  }

  alias ChangeActionStateFullFuncType = extern(C) void function(GRemoteActionGroup* remote, const(char)* actionName, GVariant* value, GVariant* platformData);

  @property ChangeActionStateFullFuncType changeActionStateFull()
  {
    return cPtr!GRemoteActionGroupInterface.changeActionStateFull;
  }
}
