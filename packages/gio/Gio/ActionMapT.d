module Gio.ActionMapT;

public import GObject.ObjectG;
public import Gid.gid;
public import Gio.Action;
public import Gio.ActionEntry;
public import Gio.ActionT;
public import Gio.Types;
public import Gio.c.functions;
public import Gio.c.types;

/**
 * `GActionMap` is an interface for action containers.
 * The `GActionMap` interface is implemented by [Gio.ActionGroup]
 * implementations that operate by containing a number of named
 * [Gio.Action] instances, such as [Gio.SimpleActionGroup].
 * One useful application of this interface is to map the
 * names of actions from various action groups to unique,
 * prefixed names $(LPAREN)e.g. by prepending "app." or "win."$(RPAREN).
 * This is the motivation for the 'Map' part of the interface
 * name.
 */
template ActionMapT(TStruct)
{

  /**
   * Adds an action to the action_map.
   * If the action map already contains an action with the same name
   * as action then the old action is dropped from the action map.
   * The action map takes its own reference on action.
   * Params:
   *   action = a #GAction
   */
  override void addAction(Action action)
  {
    g_action_map_add_action(cast(GActionMap*)cPtr, action ? cast(GAction*)(cast(ObjectG)action).cPtr(false) : null);
  }

  /**
   * A convenience function for creating multiple #GSimpleAction instances
   * and adding them to a #GActionMap.
   * Each action is constructed as per one #GActionEntry.
   * |[<!-- language\="C" -->
   * static void
   * activate_quit $(LPAREN)GSimpleAction *simple,
   * GVariant      *parameter,
   * gpointer       user_data$(RPAREN)
   * {
   * exit $(LPAREN)0$(RPAREN);
   * }
   * static void
   * activate_print_string $(LPAREN)GSimpleAction *simple,
   * GVariant      *parameter,
   * gpointer       user_data$(RPAREN)
   * {
   * g_print $(LPAREN)"%s\n", g_variant_get_string $(LPAREN)parameter, NULL$(RPAREN)$(RPAREN);
   * }
   * static GActionGroup *
   * create_action_group $(LPAREN)void$(RPAREN)
   * {
   * const GActionEntry entries[] \= {
   * { "quit",         activate_quit              },
   * { "print-string", activate_print_string, "s" }
   * };
   * GSimpleActionGroup *group;
   * group \= g_simple_action_group_new $(LPAREN)$(RPAREN);
   * g_action_map_add_action_entries $(LPAREN)G_ACTION_MAP $(LPAREN)group$(RPAREN), entries, G_N_ELEMENTS $(LPAREN)entries$(RPAREN), NULL$(RPAREN);
   * return G_ACTION_GROUP $(LPAREN)group$(RPAREN);
   * }
   * ]|
   * Params:
   *   entries = a pointer to
   *     the first item in an array of #GActionEntry structs
   *   userData = the user data for signal connections
   */
  override void addActionEntries(ActionEntry[] entries, void* userData)
  {
    int _nEntries;
    if (entries)
      _nEntries = cast(int)entries.length;

    GActionEntry[] _tmpentries;
    foreach (obj; entries)
      _tmpentries ~= obj.cInstance;
    const(GActionEntry)* _entries = _tmpentries.ptr;
    g_action_map_add_action_entries(cast(GActionMap*)cPtr, _entries, _nEntries, userData);
  }

  /**
   * Looks up the action with the name action_name in action_map.
   * If no such action exists, returns %NULL.
   * Params:
   *   actionName = the name of an action
   * Returns: a #GAction, or %NULL
   */
  override Action lookupAction(string actionName)
  {
    GAction* _cretval;
    const(char)* _actionName = actionName.toCString(false);
    _cretval = g_action_map_lookup_action(cast(GActionMap*)cPtr, _actionName);
    auto _retval = _cretval ? ObjectG.getDObject!Action(cast(GAction*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Removes the named action from the action map.
   * If no action of this name is in the map then nothing happens.
   * Params:
   *   actionName = the name of the action
   */
  override void removeAction(string actionName)
  {
    const(char)* _actionName = actionName.toCString(false);
    g_action_map_remove_action(cast(GActionMap*)cPtr, _actionName);
  }

  /**
   * Remove actions from a #GActionMap. This is meant as the reverse of
   * [Gio.ActionMap.addActionEntries].
   * |[<!-- language\="C" -->
   * static const GActionEntry entries[] \= {
   * { "quit",         activate_quit              },
   * { "print-string", activate_print_string, "s" }
   * };
   * void
   * add_actions $(LPAREN)GActionMap *map$(RPAREN)
   * {
   * g_action_map_add_action_entries $(LPAREN)map, entries, G_N_ELEMENTS $(LPAREN)entries$(RPAREN), NULL$(RPAREN);
   * }
   * void
   * remove_actions $(LPAREN)GActionMap *map$(RPAREN)
   * {
   * g_action_map_remove_action_entries $(LPAREN)map, entries, G_N_ELEMENTS $(LPAREN)entries$(RPAREN)$(RPAREN);
   * }
   * ]|
   * Params:
   *   entries = a pointer to
   *     the first item in an array of #GActionEntry structs
   */
  override void removeActionEntries(ActionEntry[] entries)
  {
    int _nEntries;
    if (entries)
      _nEntries = cast(int)entries.length;

    GActionEntry[] _tmpentries;
    foreach (obj; entries)
      _tmpentries ~= obj.cInstance;
    const(GActionEntry)* _entries = _tmpentries.ptr;
    g_action_map_remove_action_entries(cast(GActionMap*)cPtr, _entries, _nEntries);
  }
}
