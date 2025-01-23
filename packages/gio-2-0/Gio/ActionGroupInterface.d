module Gio.ActionGroupInterface;

import GObject.TypeInterface;
import Gid.gid;
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
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property TypeInterface gIface()
  {
    return new TypeInterface(cast(GTypeInterface*)&(cast(GActionGroupInterface*)cPtr).gIface);
  }

  alias HasActionFuncType = extern(C) bool function(GActionGroup* actionGroup, const(char)* actionName);

  @property HasActionFuncType hasAction()
  {
    return (cast(GActionGroupInterface*)cPtr).hasAction;
  }

  alias ListActionsFuncType = extern(C) char** function(GActionGroup* actionGroup);

  @property ListActionsFuncType listActions()
  {
    return (cast(GActionGroupInterface*)cPtr).listActions;
  }

  alias GetActionEnabledFuncType = extern(C) bool function(GActionGroup* actionGroup, const(char)* actionName);

  @property GetActionEnabledFuncType getActionEnabled()
  {
    return (cast(GActionGroupInterface*)cPtr).getActionEnabled;
  }

  alias GetActionParameterTypeFuncType = extern(C) const(GVariantType)* function(GActionGroup* actionGroup, const(char)* actionName);

  @property GetActionParameterTypeFuncType getActionParameterType()
  {
    return (cast(GActionGroupInterface*)cPtr).getActionParameterType;
  }

  alias GetActionStateTypeFuncType = extern(C) const(GVariantType)* function(GActionGroup* actionGroup, const(char)* actionName);

  @property GetActionStateTypeFuncType getActionStateType()
  {
    return (cast(GActionGroupInterface*)cPtr).getActionStateType;
  }

  alias GetActionStateHintFuncType = extern(C) VariantC* function(GActionGroup* actionGroup, const(char)* actionName);

  @property GetActionStateHintFuncType getActionStateHint()
  {
    return (cast(GActionGroupInterface*)cPtr).getActionStateHint;
  }

  alias GetActionStateFuncType = extern(C) VariantC* function(GActionGroup* actionGroup, const(char)* actionName);

  @property GetActionStateFuncType getActionState()
  {
    return (cast(GActionGroupInterface*)cPtr).getActionState;
  }

  alias ChangeActionStateFuncType = extern(C) void function(GActionGroup* actionGroup, const(char)* actionName, VariantC* value);

  @property ChangeActionStateFuncType changeActionState()
  {
    return (cast(GActionGroupInterface*)cPtr).changeActionState;
  }

  alias ActivateActionFuncType = extern(C) void function(GActionGroup* actionGroup, const(char)* actionName, VariantC* parameter);

  @property ActivateActionFuncType activateAction()
  {
    return (cast(GActionGroupInterface*)cPtr).activateAction;
  }

  alias ActionAddedFuncType = extern(C) void function(GActionGroup* actionGroup, const(char)* actionName);

  @property ActionAddedFuncType actionAdded()
  {
    return (cast(GActionGroupInterface*)cPtr).actionAdded;
  }

  alias ActionRemovedFuncType = extern(C) void function(GActionGroup* actionGroup, const(char)* actionName);

  @property ActionRemovedFuncType actionRemoved()
  {
    return (cast(GActionGroupInterface*)cPtr).actionRemoved;
  }

  alias ActionEnabledChangedFuncType = extern(C) void function(GActionGroup* actionGroup, const(char)* actionName, bool enabled);

  @property ActionEnabledChangedFuncType actionEnabledChanged()
  {
    return (cast(GActionGroupInterface*)cPtr).actionEnabledChanged;
  }

  alias ActionStateChangedFuncType = extern(C) void function(GActionGroup* actionGroup, const(char)* actionName, VariantC* state);

  @property ActionStateChangedFuncType actionStateChanged()
  {
    return (cast(GActionGroupInterface*)cPtr).actionStateChanged;
  }

  alias QueryActionFuncType = extern(C) bool function(GActionGroup* actionGroup, const(char)* actionName, bool* enabled, const(GVariantType*)* parameterType, const(GVariantType*)* stateType, VariantC** stateHint, VariantC** state);

  @property QueryActionFuncType queryAction()
  {
    return (cast(GActionGroupInterface*)cPtr).queryAction;
  }
}
