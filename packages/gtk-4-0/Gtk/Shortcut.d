module Gtk.Shortcut;

import GLib.VariantG;
import GObject.ObjectG;
import Gid.gid;
import Gtk.ShortcutAction;
import Gtk.ShortcutTrigger;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * A `GtkShortcut` describes a keyboard shortcut.
 * It contains a description of how to trigger the shortcut via a
 * [Gtk.ShortcutTrigger] and a way to activate the shortcut
 * on a widget via a [Gtk.ShortcutAction].
 * The actual work is usually done via [Gtk.ShortcutController],
 * which decides if and when to activate a shortcut. Using that controller
 * directly however is rarely necessary as various higher level
 * convenience APIs exist on `GtkWidget`s that make it easier to use
 * shortcuts in GTK.
 * `GtkShortcut` does provide functionality to make it easy for users
 * to work with shortcuts, either by providing informational strings
 * for display purposes or by allowing shortcuts to be configured.
 */
class Shortcut : ObjectG
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
    return gtk_shortcut_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new `GtkShortcut` that is triggered by
   * trigger and then activates action.
   * Params:
   *   trigger = The trigger that will trigger the shortcut
   *   action = The action that will be activated upon
   *     triggering
   * Returns: a new `GtkShortcut`
   */
  this(ShortcutTrigger trigger, ShortcutAction action)
  {
    GtkShortcut* _cretval;
    _cretval = gtk_shortcut_new(trigger ? cast(GtkShortcutTrigger*)trigger.cPtr(true) : null, action ? cast(GtkShortcutAction*)action.cPtr(true) : null);
    this(_cretval, true);
  }

  /**
   * Gets the action that is activated by this shortcut.
   * Returns: the action
   */
  ShortcutAction getAction()
  {
    GtkShortcutAction* _cretval;
    _cretval = gtk_shortcut_get_action(cast(GtkShortcut*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!ShortcutAction(cast(GtkShortcutAction*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the arguments that are passed when activating the shortcut.
   * Returns: the arguments
   */
  VariantG getArguments()
  {
    VariantC* _cretval;
    _cretval = gtk_shortcut_get_arguments(cast(GtkShortcut*)cPtr);
    auto _retval = _cretval ? new VariantG(cast(VariantC*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the trigger used to trigger self.
   * Returns: the trigger used
   */
  ShortcutTrigger getTrigger()
  {
    GtkShortcutTrigger* _cretval;
    _cretval = gtk_shortcut_get_trigger(cast(GtkShortcut*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!ShortcutTrigger(cast(GtkShortcutTrigger*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Sets the new action for self to be action.
   * Params:
   *   action = The new action.
   *     If the action is %NULL, the nothing action will be used.
   */
  void setAction(ShortcutAction action)
  {
    gtk_shortcut_set_action(cast(GtkShortcut*)cPtr, action ? cast(GtkShortcutAction*)action.cPtr(true) : null);
  }

  /**
   * Sets the arguments to pass when activating the shortcut.
   * Params:
   *   args = arguments to pass when activating self
   */
  void setArguments(VariantG args)
  {
    gtk_shortcut_set_arguments(cast(GtkShortcut*)cPtr, args ? cast(VariantC*)args.cPtr(false) : null);
  }

  /**
   * Sets the new trigger for self to be trigger.
   * Params:
   *   trigger = The new trigger.
   *     If the trigger is %NULL, the never trigger will be used.
   */
  void setTrigger(ShortcutTrigger trigger)
  {
    gtk_shortcut_set_trigger(cast(GtkShortcut*)cPtr, trigger ? cast(GtkShortcutTrigger*)trigger.cPtr(true) : null);
  }
}
