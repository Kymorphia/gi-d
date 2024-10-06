module Gtk.ActionableInterface;

import Gid.gid;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * The interface vtable for `GtkActionable`.
 */
class ActionableInterface
{
  GtkActionableInterface cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gtk.ActionableInterface");

    cInstance = *cast(GtkActionableInterface*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  alias GetActionNameFuncType = extern(C) const(char)* function(GtkActionable* actionable);

  @property GetActionNameFuncType getActionName()
  {
    return (cast(GtkActionableInterface*)cPtr).getActionName;
  }

  alias SetActionNameFuncType = extern(C) void function(GtkActionable* actionable, const(char)* actionName);

  @property SetActionNameFuncType setActionName()
  {
    return (cast(GtkActionableInterface*)cPtr).setActionName;
  }

  alias GetActionTargetValueFuncType = extern(C) GVariant* function(GtkActionable* actionable);

  @property GetActionTargetValueFuncType getActionTargetValue()
  {
    return (cast(GtkActionableInterface*)cPtr).getActionTargetValue;
  }

  alias SetActionTargetValueFuncType = extern(C) void function(GtkActionable* actionable, GVariant* targetValue);

  @property SetActionTargetValueFuncType setActionTargetValue()
  {
    return (cast(GtkActionableInterface*)cPtr).setActionTargetValue;
  }
}
