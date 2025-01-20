module Gtk.MnemonicAction;

import GObject.ObjectG;
import Gid.gid;
import Gtk.ShortcutAction;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * A `GtkShortcutAction` that calls [Gtk.Widget.mnemonicActivate].
 */
class MnemonicAction : ShortcutAction
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
    return gtk_mnemonic_action_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Gets the mnemonic action.
   * This is an action that calls [Gtk.Widget.mnemonicActivate]
   * on the given widget upon activation.
   * Returns: The mnemonic action
   */
  static MnemonicAction get()
  {
    GtkShortcutAction* _cretval;
    _cretval = gtk_mnemonic_action_get();
    auto _retval = _cretval ? ObjectG.getDObject!MnemonicAction(cast(GtkShortcutAction*)_cretval, false) : null;
    return _retval;
  }
}
