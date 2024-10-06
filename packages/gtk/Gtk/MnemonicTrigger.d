module Gtk.MnemonicTrigger;

import Gid.gid;
import Gtk.ShortcutTrigger;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * A `GtkShortcutTrigger` that triggers when a specific mnemonic is pressed.
 * Mnemonics require a *mnemonic modifier* $(LPAREN)typically <kbd>Alt</kbd>$(RPAREN) to be
 * pressed together with the mnemonic key.
 */
class MnemonicTrigger : ShortcutTrigger
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
    return gtk_mnemonic_trigger_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a `GtkShortcutTrigger` that will trigger whenever the key with
   * the given keyval is pressed and mnemonics have been activated.
   * Mnemonics are activated by calling code when a key event with the right
   * modifiers is detected.
   * Params:
   *   keyval = The keyval to trigger for
   * Returns: A new `GtkShortcutTrigger`
   */
  this(uint keyval)
  {
    GtkShortcutTrigger* _cretval;
    _cretval = gtk_mnemonic_trigger_new(keyval);
    this(_cretval, true);
  }

  /**
   * Gets the keyval that must be pressed to succeed triggering self.
   * Returns: the keyval
   */
  uint getKeyval()
  {
    uint _retval;
    _retval = gtk_mnemonic_trigger_get_keyval(cast(GtkMnemonicTrigger*)cPtr);
    return _retval;
  }
}
