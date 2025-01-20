module Gtk.NeverTrigger;

import GObject.ObjectG;
import Gid.gid;
import Gtk.ShortcutTrigger;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * A `GtkShortcutTrigger` that never triggers.
 */
class NeverTrigger : ShortcutTrigger
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
    return gtk_never_trigger_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Gets the never trigger.
   * This is a singleton for a trigger that never triggers.
   * Use this trigger instead of %NULL because it implements
   * all virtual functions.
   * Returns: The never trigger
   */
  static NeverTrigger get()
  {
    GtkShortcutTrigger* _cretval;
    _cretval = gtk_never_trigger_get();
    auto _retval = _cretval ? ObjectG.getDObject!NeverTrigger(cast(GtkShortcutTrigger*)_cretval, false) : null;
    return _retval;
  }
}
