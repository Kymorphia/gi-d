module Gio.ActionMapInterface;

import GObject.TypeInterface;
import Gid.gid;
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
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property TypeInterface gIface()
  {
    return new TypeInterface(cast(GTypeInterface*)&(cast(GActionMapInterface*)cPtr).gIface);
  }

  alias LookupActionFuncType = extern(C) GAction* function(GActionMap* actionMap, const(char)* actionName);

  @property LookupActionFuncType lookupAction()
  {
    return (cast(GActionMapInterface*)cPtr).lookupAction;
  }

  alias AddActionFuncType = extern(C) void function(GActionMap* actionMap, GAction* action);

  @property AddActionFuncType addAction()
  {
    return (cast(GActionMapInterface*)cPtr).addAction;
  }

  alias RemoveActionFuncType = extern(C) void function(GActionMap* actionMap, const(char)* actionName);

  @property RemoveActionFuncType removeAction()
  {
    return (cast(GActionMapInterface*)cPtr).removeAction;
  }
}
