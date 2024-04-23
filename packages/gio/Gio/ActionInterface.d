module Gio.ActionInterface;

import GLib.Types;
import GLib.Variant;
import GLib.VariantType;
import GLib.c.functions;
import GObject.TypeInterface;
import GObject.Types;
import Gid.Gid;
import Gio.Action;
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
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GActionInterface))
  {
    return cast(T*)&cInstance;
  }

  @property TypeInterface gIface()
  {
    return new TypeInterface(cast(GTypeInterface*)&cPtr!GActionInterface.gIface);
  }

  alias GetNameFuncType = extern(C) const(char)* function(GAction* action);

  @property GetNameFuncType getName()
  {
    return cPtr!GActionInterface.getName;
  }

  alias GetParameterTypeFuncType = extern(C) const(GVariantType)* function(GAction* action);

  @property GetParameterTypeFuncType getParameterType()
  {
    return cPtr!GActionInterface.getParameterType;
  }

  alias GetStateTypeFuncType = extern(C) const(GVariantType)* function(GAction* action);

  @property GetStateTypeFuncType getStateType()
  {
    return cPtr!GActionInterface.getStateType;
  }

  alias GetStateHintFuncType = extern(C) GVariant* function(GAction* action);

  @property GetStateHintFuncType getStateHint()
  {
    return cPtr!GActionInterface.getStateHint;
  }

  alias GetEnabledFuncType = extern(C) bool function(GAction* action);

  @property GetEnabledFuncType getEnabled()
  {
    return cPtr!GActionInterface.getEnabled;
  }

  alias GetStateFuncType = extern(C) GVariant* function(GAction* action);

  @property GetStateFuncType getState()
  {
    return cPtr!GActionInterface.getState;
  }

  alias ChangeStateFuncType = extern(C) void function(GAction* action, GVariant* value);

  @property ChangeStateFuncType changeState()
  {
    return cPtr!GActionInterface.changeState;
  }

  alias ActivateFuncType = extern(C) void function(GAction* action, GVariant* parameter);

  @property ActivateFuncType activate()
  {
    return cPtr!GActionInterface.activate;
  }
}
