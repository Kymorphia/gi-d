module Gio.ActionMap;

public import Gio.ActionMapIfaceProxy;
import GObject.ObjectG;
import Gid.gid;
import Gio.Action;
import Gio.ActionEntry;
import Gio.ActionT;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

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
interface ActionMap
{

  static GType getType()
  {
    return g_action_map_get_type();
  }

  /**
   * Adds an action to the action_map.
   * If the action map already contains an action with the same name
   * as action then the old action is dropped from the action map.
   * The action map takes its own reference on action.
   * Params:
   *   action = a #GAction
   */
  void addAction(Action action);

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
  void addActionEntries(ActionEntry[] entries, void* userData);

  /**
   * Looks up the action with the name action_name in action_map.
   * If no such action exists, returns %NULL.
   * Params:
   *   actionName = the name of an action
   * Returns: a #GAction, or %NULL
   */
  Action lookupAction(string actionName);

  /**
   * Removes the named action from the action map.
   * If no action of this name is in the map then nothing happens.
   * Params:
   *   actionName = the name of the action
   */
  void removeAction(string actionName);

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
  void removeActionEntries(ActionEntry[] entries);
}
