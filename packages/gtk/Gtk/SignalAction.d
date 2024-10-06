module Gtk.SignalAction;

import Gid.gid;
import Gtk.ShortcutAction;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * A `GtkShortcut`Action that emits a signal.
 * Signals that are used in this way are referred to as keybinding signals,
 * and they are expected to be defined with the %G_SIGNAL_ACTION flag.
 */
class SignalAction : ShortcutAction
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
    return gtk_signal_action_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates an action that when activated, emits the given action signal
   * on the provided widget.
   * It will also unpack the args into arguments passed to the signal.
   * Params:
   *   signalName = name of the signal to emit
   * Returns: a new `GtkShortcutAction`
   */
  this(string signalName)
  {
    GtkShortcutAction* _cretval;
    const(char)* _signalName = signalName.toCString(false);
    _cretval = gtk_signal_action_new(_signalName);
    this(_cretval, true);
  }

  /**
   * Returns the name of the signal that will be emitted.
   * Returns: the name of the signal to emit
   */
  string getSignalName()
  {
    const(char)* _cretval;
    _cretval = gtk_signal_action_get_signal_name(cast(GtkSignalAction*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }
}
