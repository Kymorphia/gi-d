module Gtk.NamedAction;

import Gid.gid;
import Gtk.ShortcutAction;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * A `GtkShortcutAction` that activates an action by name.
 */
class NamedAction : ShortcutAction
{

  this()
  {
  }

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return gtk_named_action_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates an action that when activated, activates
   * the named action on the widget.
   * It also passes the given arguments to it.
   * See [Gtk.Widget.insertActionGroup] for
   * how to add actions to widgets.
   * Params:
   *   name = the detailed name of the action
   * Returns: a new `GtkShortcutAction`
   */
  this(string name)
  {
    GtkShortcutAction* _cretval;
    const(char)* _name = name.toCString(false);
    _cretval = gtk_named_action_new(_name);
    this(_cretval, true);
  }

  /**
   * Returns the name of the action that will be activated.
   * Returns: the name of the action to activate
   */
  string getActionName()
  {
    const(char)* _cretval;
    _cretval = gtk_named_action_get_action_name(cast(GtkNamedAction*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }
}
