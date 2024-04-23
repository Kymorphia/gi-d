module Gio.SimpleActionGroup;

import GObject.ObjectG;
import GObject.Types;
import Gid.Gid;
import Gio.Action;
import Gio.ActionEntry;
import Gio.ActionGroup;
import Gio.ActionGroupT;
import Gio.ActionMap;
import Gio.ActionMapT;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * #GSimpleActionGroup is a hash table filled with #GAction objects,
 * implementing the #GActionGroup and #GActionMap interfaces.
 */
class SimpleActionGroup : ObjectG, ActionGroup, ActionMap
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_simple_action_group_get_type();
  }

  mixin ActionGroupT!GSimpleActionGroup;
  mixin ActionMapT!GSimpleActionGroup;

  /**
   * a new #GSimpleActionGroup
   */
  this()
  {
    GSimpleActionGroup* _cretval;
    _cretval = g_simple_action_group_new();
    this(_cretval, true);
  }

  /**
   * A convenience function for creating multiple #GSimpleAction instances
   * and adding them to the action group.
   */
  void addEntries(ActionEntry[] entries, void* userData)
  {
    GActionEntry[] _tmpentries;
    foreach (obj; entries)
      _tmpentries ~= obj.cInstance;
    const(GActionEntry)* _entries = _tmpentries.ptr;
    g_simple_action_group_add_entries(cPtr!GSimpleActionGroup, _entries, entries ? cast(int)entries.length : 0, userData);
  }

  /**
   * Adds an action to the action group.
   *
   * If the action group already contains an action with the same name as
   * @action then the old action is dropped from the group.
   *
   * The action group takes its own reference on @action.
   */
  void insert(Action action)
  {
    g_simple_action_group_insert(cPtr!GSimpleActionGroup, action ? (cast(ObjectG)action).cPtr!GAction : null);
  }

  /**
   * a #GAction, or %NULL
   */
  Action lookup(string actionName)
  {
    GAction* _cretval;
    const(char)* _actionName = actionName.toCString(false);
    _cretval = g_simple_action_group_lookup(cPtr!GSimpleActionGroup, _actionName);
    Action _retval = ObjectG.getDObject!Action(cast(GAction*)_cretval, false);
    return _retval;
  }

  /**
   * Removes the named action from the action group.
   *
   * If no action of this name is in the group then nothing happens.
   */
  void remove(string actionName)
  {
    const(char)* _actionName = actionName.toCString(false);
    g_simple_action_group_remove(cPtr!GSimpleActionGroup, _actionName);
  }
}
