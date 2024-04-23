module Gio.ActionMapT;

public import GObject.ObjectG;
public import Gid.Gid;
public import Gio.Action;
public import Gio.ActionEntry;
public import Gio.Types;
public import Gio.c.functions;
public import Gio.c.types;

/**
 * The GActionMap interface is implemented by #GActionGroup
 * implementations that operate by containing a number of
 * named #GAction instances, such as #GSimpleActionGroup.
 *
 * One useful application of this interface is to map the
 * names of actions from various action groups to unique,
 * prefixed names (e.g. by prepending "app." or "win.").
 * This is the motivation for the 'Map' part of the interface
 * name.
 */
template ActionMapT(TStruct)
{

  /**
   * Adds an action to the @action_map.
   *
   * If the action map already contains an action with the same name
   * as @action then the old action is dropped from the action map.
   *
   * The action map takes its own reference on @action.
   */
  override void addAction(Action action)
  {
    g_action_map_add_action(cPtr!GActionMap, action ? (cast(ObjectG)action).cPtr!GAction : null);
  }

  /**
   * A convenience function for creating multiple #GSimpleAction instances
   * and adding them to a #GActionMap.
   *
   * Each action is constructed as per one #GActionEntry.
   *
   * |[<!-- language="C" -->
   * static void
   * activate_quit (GSimpleAction *simple,
   * GVariant      *parameter,
   * gpointer       user_data)
   * {
   * exit (0);
   * }
   *
   * static void
   * activate_print_string (GSimpleAction *simple,
   * GVariant      *parameter,
   * gpointer       user_data)
   * {
   * g_print ("%s\n", g_variant_get_string (parameter, NULL));
   * }
   *
   * static GActionGroup *
   * create_action_group (void)
   * {
   * const GActionEntry entries[] = {
   * { "quit",         activate_quit              },
   * { "print-string", activate_print_string, "s" }
   * };
   * GSimpleActionGroup *group;
   *
   * group = g_simple_action_group_new ();
   * g_action_map_add_action_entries (G_ACTION_MAP (group), entries, G_N_ELEMENTS (entries), NULL);
   *
   * return G_ACTION_GROUP (group);
   * }
   * ]|
   */
  override void addActionEntries(ActionEntry[] entries, void* userData)
  {
    GActionEntry[] _tmpentries;
    foreach (obj; entries)
      _tmpentries ~= obj.cInstance;
    const(GActionEntry)* _entries = _tmpentries.ptr;
    g_action_map_add_action_entries(cPtr!GActionMap, _entries, entries ? cast(int)entries.length : 0, userData);
  }

  /**
   * a #GAction, or %NULL
   */
  override Action lookupAction(string actionName)
  {
    GAction* _cretval;
    const(char)* _actionName = actionName.toCString(false);
    _cretval = g_action_map_lookup_action(cPtr!GActionMap, _actionName);
    Action _retval = ObjectG.getDObject!Action(cast(GAction*)_cretval, false);
    return _retval;
  }

  /**
   * Removes the named action from the action map.
   *
   * If no action of this name is in the map then nothing happens.
   */
  override void removeAction(string actionName)
  {
    const(char)* _actionName = actionName.toCString(false);
    g_action_map_remove_action(cPtr!GActionMap, _actionName);
  }

  /**
   * Remove actions from a #GActionMap. This is meant as the reverse of
   * g_action_map_add_action_entries().
   *
   *
   * |[<!-- language="C" -->
   * static const GActionEntry entries[] = {
   * { "quit",         activate_quit              },
   * { "print-string", activate_print_string, "s" }
   * };
   *
   * void
   * add_actions (GActionMap *map)
   * {
   * g_action_map_add_action_entries (map, entries, G_N_ELEMENTS (entries), NULL);
   * }
   *
   * void
   * remove_actions (GActionMap *map)
   * {
   * g_action_map_remove_action_entries (map, entries, G_N_ELEMENTS (entries));
   * }
   * ]|
   */
  override void removeActionEntries(ActionEntry[] entries)
  {
    GActionEntry[] _tmpentries;
    foreach (obj; entries)
      _tmpentries ~= obj.cInstance;
    const(GActionEntry)* _entries = _tmpentries.ptr;
    g_action_map_remove_action_entries(cPtr!GActionMap, _entries, entries ? cast(int)entries.length : 0);
  }
}
