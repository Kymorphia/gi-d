module Gtk.ActivateAction;

import GObject.ObjectG;
import Gid.gid;
import Gtk.ShortcutAction;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * A `GtkShortcutAction` that calls [Gtk.Widget.activate].
 */
class ActivateAction : ShortcutAction
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
    return gtk_activate_action_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Gets the activate action.
   * This is an action that calls [Gtk.Widget.activate]
   * on the given widget upon activation.
   * Returns: The activate action
   */
  static ActivateAction get()
  {
    GtkShortcutAction* _cretval;
    _cretval = gtk_activate_action_get();
    auto _retval = _cretval ? ObjectG.getDObject!ActivateAction(cast(GtkShortcutAction*)_cretval, false) : null;
    return _retval;
  }
}
