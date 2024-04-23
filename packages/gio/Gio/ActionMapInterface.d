module Gio.ActionMapInterface;

import GLib.c.functions;
import GObject.TypeInterface;
import GObject.Types;
import Gid.Gid;
import Gio.Action;
import Gio.ActionMap;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * The virtual function table for #GActionMap.
 */
class ActionMapInterface
{
  GActionMapInterface cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.ActionMapInterface");

    cInstance = *cast(GActionMapInterface*)ptr;

    if (ownedRef)
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GActionMapInterface))
  {
    return cast(T*)&cInstance;
  }

  @property TypeInterface gIface()
  {
    return new TypeInterface(cast(GTypeInterface*)&cPtr!GActionMapInterface.gIface);
  }

  alias LookupActionFuncType = extern(C) GAction* function(GActionMap* actionMap, const(char)* actionName);

  @property LookupActionFuncType lookupAction()
  {
    return cPtr!GActionMapInterface.lookupAction;
  }

  alias AddActionFuncType = extern(C) void function(GActionMap* actionMap, GAction* action);

  @property AddActionFuncType addAction()
  {
    return cPtr!GActionMapInterface.addAction;
  }

  alias RemoveActionFuncType = extern(C) void function(GActionMap* actionMap, const(char)* actionName);

  @property RemoveActionFuncType removeAction()
  {
    return cPtr!GActionMapInterface.removeAction;
  }
}
