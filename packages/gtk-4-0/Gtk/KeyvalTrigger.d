module Gtk.KeyvalTrigger;

import Gdk.Types;
import Gid.gid;
import Gtk.ShortcutTrigger;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * A `GtkShortcutTrigger` that triggers when a specific keyval and modifiers are pressed.
 */
class KeyvalTrigger : ShortcutTrigger
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
    return gtk_keyval_trigger_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a `GtkShortcutTrigger` that will trigger whenever
   * the key with the given keyval and modifiers is pressed.
   * Params:
   *   keyval = The keyval to trigger for
   *   modifiers = the modifiers that need to be present
   * Returns: A new `GtkShortcutTrigger`
   */
  this(uint keyval, ModifierType modifiers)
  {
    GtkShortcutTrigger* _cretval;
    _cretval = gtk_keyval_trigger_new(keyval, modifiers);
    this(_cretval, true);
  }

  /**
   * Gets the keyval that must be pressed to succeed
   * triggering self.
   * Returns: the keyval
   */
  uint getKeyval()
  {
    uint _retval;
    _retval = gtk_keyval_trigger_get_keyval(cast(GtkKeyvalTrigger*)cPtr);
    return _retval;
  }

  /**
   * Gets the modifiers that must be present to succeed
   * triggering self.
   * Returns: the modifiers
   */
  ModifierType getModifiers()
  {
    GdkModifierType _cretval;
    _cretval = gtk_keyval_trigger_get_modifiers(cast(GtkKeyvalTrigger*)cPtr);
    ModifierType _retval = cast(ModifierType)_cretval;
    return _retval;
  }
}
