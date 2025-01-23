module Gio.ActionInterface;

import GObject.TypeInterface;
import Gid.gid;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * The virtual function table for #GAction.
 */
class ActionInterface
{
  GActionInterface cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.ActionInterface");

    cInstance = *cast(GActionInterface*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property TypeInterface gIface()
  {
    return new TypeInterface(cast(GTypeInterface*)&(cast(GActionInterface*)cPtr).gIface);
  }

  alias GetNameFuncType = extern(C) const(char)* function(GAction* action);

  @property GetNameFuncType getName()
  {
    return (cast(GActionInterface*)cPtr).getName;
  }

  alias GetParameterTypeFuncType = extern(C) const(GVariantType)* function(GAction* action);

  @property GetParameterTypeFuncType getParameterType()
  {
    return (cast(GActionInterface*)cPtr).getParameterType;
  }

  alias GetStateTypeFuncType = extern(C) const(GVariantType)* function(GAction* action);

  @property GetStateTypeFuncType getStateType()
  {
    return (cast(GActionInterface*)cPtr).getStateType;
  }

  alias GetStateHintFuncType = extern(C) VariantC* function(GAction* action);

  @property GetStateHintFuncType getStateHint()
  {
    return (cast(GActionInterface*)cPtr).getStateHint;
  }

  alias GetEnabledFuncType = extern(C) bool function(GAction* action);

  @property GetEnabledFuncType getEnabled()
  {
    return (cast(GActionInterface*)cPtr).getEnabled;
  }

  alias GetStateFuncType = extern(C) VariantC* function(GAction* action);

  @property GetStateFuncType getState()
  {
    return (cast(GActionInterface*)cPtr).getState;
  }

  alias ChangeStateFuncType = extern(C) void function(GAction* action, VariantC* value);

  @property ChangeStateFuncType changeState()
  {
    return (cast(GActionInterface*)cPtr).changeState;
  }

  alias ActivateFuncType = extern(C) void function(GAction* action, VariantC* parameter);

  @property ActivateFuncType activate()
  {
    return (cast(GActionInterface*)cPtr).activate;
  }
}
