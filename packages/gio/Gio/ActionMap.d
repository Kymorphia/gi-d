module Gio.ActionMap;

import GObject.ObjectG;
import Gid.Gid;
import Gio.Action;
import Gio.ActionEntry;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

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
interface ActionMap
{

  static GType getType()
  {
    return g_action_map_get_type();
  }

  /**
   * Adds an action to the @action_map.
   *
   * If the action map already contains an action with the same name
   * as @action then the old action is dropped from the action map.
   *
   * The action map takes its own reference on @action.
   */
  void addAction(Action action);

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
  void addActionEntries(ActionEntry[] entries, void* userData);

  /**
   * a #GAction, or %NULL
   */
  Action lookupAction(string actionName);

  /**
   * Removes the named action from the action map.
   *
   * If no action of this name is in the map then nothing happens.
   */
  void removeAction(string actionName);

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
  void removeActionEntries(ActionEntry[] entries);
}
