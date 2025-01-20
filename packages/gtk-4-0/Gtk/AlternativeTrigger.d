module Gtk.AlternativeTrigger;

import GObject.ObjectG;
import Gid.gid;
import Gtk.ShortcutTrigger;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * A `GtkShortcutTrigger` that combines two triggers.
 * The `GtkAlternativeTrigger` triggers when either of two trigger.
 * This can be cascaded to combine more than two triggers.
 */
class AlternativeTrigger : ShortcutTrigger
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
    return gtk_alternative_trigger_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a `GtkShortcutTrigger` that will trigger whenever
   * either of the two given triggers gets triggered.
   * Note that nesting is allowed, so if you want more than two
   * alternative, create a new alternative trigger for each option.
   * Params:
   *   first = The first trigger that may trigger
   *   second = The second trigger that may trigger
   * Returns: a new `GtkShortcutTrigger`
   */
  this(ShortcutTrigger first, ShortcutTrigger second)
  {
    GtkShortcutTrigger* _cretval;
    _cretval = gtk_alternative_trigger_new(first ? cast(GtkShortcutTrigger*)first.cPtr(true) : null, second ? cast(GtkShortcutTrigger*)second.cPtr(true) : null);
    this(_cretval, true);
  }

  /**
   * Gets the first of the two alternative triggers that may
   * trigger self.
   * [Gtk.AlternativeTrigger.getSecond] will return
   * the other one.
   * Returns: the first alternative trigger
   */
  ShortcutTrigger getFirst()
  {
    GtkShortcutTrigger* _cretval;
    _cretval = gtk_alternative_trigger_get_first(cast(GtkAlternativeTrigger*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!ShortcutTrigger(cast(GtkShortcutTrigger*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the second of the two alternative triggers that may
   * trigger self.
   * [Gtk.AlternativeTrigger.getFirst] will return
   * the other one.
   * Returns: the second alternative trigger
   */
  ShortcutTrigger getSecond()
  {
    GtkShortcutTrigger* _cretval;
    _cretval = gtk_alternative_trigger_get_second(cast(GtkAlternativeTrigger*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!ShortcutTrigger(cast(GtkShortcutTrigger*)_cretval, false) : null;
    return _retval;
  }
}
