module Gio.ActionGroupInterface;

import GLib.Types;
import GLib.Variant;
import GLib.VariantType;
import GLib.c.functions;
import GObject.TypeInterface;
import GObject.Types;
import Gid.Gid;
import Gio.ActionGroup;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * The virtual function table for #GActionGroup.
 */
class ActionGroupInterface
{
  GActionGroupInterface cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.ActionGroupInterface");

    cInstance = *cast(GActionGroupInterface*)ptr;

    if (ownedRef)
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GActionGroupInterface))
  {
    return cast(T*)&cInstance;
  }

  @property TypeInterface gIface()
  {
    return new TypeInterface(cast(GTypeInterface*)&cPtr!GActionGroupInterface.gIface);
  }

  alias HasActionFuncType = extern(C) bool function(GActionGroup* actionGroup, const(char)* actionName);

  @property HasActionFuncType hasAction()
  {
    return cPtr!GActionGroupInterface.hasAction;
  }

  alias ListActionsFuncType = extern(C) char** function(GActionGroup* actionGroup);

  @property ListActionsFuncType listActions()
  {
    return cPtr!GActionGroupInterface.listActions;
  }

  alias GetActionEnabledFuncType = extern(C) bool function(GActionGroup* actionGroup, const(char)* actionName);

  @property GetActionEnabledFuncType getActionEnabled()
  {
    return cPtr!GActionGroupInterface.getActionEnabled;
  }

  alias GetActionParameterTypeFuncType = extern(C) const(GVariantType)* function(GActionGroup* actionGroup, const(char)* actionName);

  @property GetActionParameterTypeFuncType getActionParameterType()
  {
    return cPtr!GActionGroupInterface.getActionParameterType;
  }

  alias GetActionStateTypeFuncType = extern(C) const(GVariantType)* function(GActionGroup* actionGroup, const(char)* actionName);

  @property GetActionStateTypeFuncType getActionStateType()
  {
    return cPtr!GActionGroupInterface.getActionStateType;
  }

  alias GetActionStateHintFuncType = extern(C) GVariant* function(GActionGroup* actionGroup, const(char)* actionName);

  @property GetActionStateHintFuncType getActionStateHint()
  {
    return cPtr!GActionGroupInterface.getActionStateHint;
  }

  alias GetActionStateFuncType = extern(C) GVariant* function(GActionGroup* actionGroup, const(char)* actionName);

  @property GetActionStateFuncType getActionState()
  {
    return cPtr!GActionGroupInterface.getActionState;
  }

  alias ChangeActionStateFuncType = extern(C) void function(GActionGroup* actionGroup, const(char)* actionName, GVariant* value);

  @property ChangeActionStateFuncType changeActionState()
  {
    return cPtr!GActionGroupInterface.changeActionState;
  }

  alias ActivateActionFuncType = extern(C) void function(GActionGroup* actionGroup, const(char)* actionName, GVariant* parameter);

  @property ActivateActionFuncType activateAction()
  {
    return cPtr!GActionGroupInterface.activateAction;
  }

  alias ActionAddedFuncType = extern(C) void function(GActionGroup* actionGroup, const(char)* actionName);

  @property ActionAddedFuncType actionAdded()
  {
    return cPtr!GActionGroupInterface.actionAdded;
  }

  alias ActionRemovedFuncType = extern(C) void function(GActionGroup* actionGroup, const(char)* actionName);

  @property ActionRemovedFuncType actionRemoved()
  {
    return cPtr!GActionGroupInterface.actionRemoved;
  }

  alias ActionEnabledChangedFuncType = extern(C) void function(GActionGroup* actionGroup, const(char)* actionName, bool enabled);

  @property ActionEnabledChangedFuncType actionEnabledChanged()
  {
    return cPtr!GActionGroupInterface.actionEnabledChanged;
  }

  alias ActionStateChangedFuncType = extern(C) void function(GActionGroup* actionGroup, const(char)* actionName, GVariant* state);

  @property ActionStateChangedFuncType actionStateChanged()
  {
    return cPtr!GActionGroupInterface.actionStateChanged;
  }

  alias QueryActionFuncType = extern(C) bool function(GActionGroup* actionGroup, const(char)* actionName, bool* enabled, const(GVariantType*)* parameterType, const(GVariantType*)* stateType, GVariant** stateHint, GVariant** state);

  @property QueryActionFuncType queryAction()
  {
    return cPtr!GActionGroupInterface.queryAction;
  }
}
