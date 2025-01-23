module Gtk.ShortcutAction;

import GLib.String;
import GLib.VariantG;
import GObject.ObjectG;
import Gid.gid;
import Gtk.Types;
import Gtk.Widget;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkShortcutAction` encodes an action that can be triggered by a
 * keyboard shortcut.
 * `GtkShortcutActions` contain functions that allow easy presentation
 * to end users as well as being printed for debugging.
 * All `GtkShortcutActions` are immutable, you can only specify their
 * properties during construction. If you want to change a action, you
 * have to replace it with a new one. If you need to pass arguments to
 * an action, these are specified by the higher-level `GtkShortcut` object.
 * To activate a `GtkShortcutAction` manually, [Gtk.ShortcutAction.activate]
 * can be called.
 * GTK provides various actions:
 * - [Gtk.MnemonicAction]: a shortcut action that calls
 * [Gtk.Widget.mnemonicActivate]
 * - [Gtk.CallbackAction]: a shortcut action that invokes
 * a given callback
 * - [Gtk.SignalAction]: a shortcut action that emits a
 * given signal
 * - [Gtk.ActivateAction]: a shortcut action that calls
 * [Gtk.Widget.activate]
 * - [Gtk.NamedAction]: a shortcut action that calls
 * [Gtk.Widget.activateAction]
 * - [Gtk.NothingAction]: a shortcut action that does nothing
 */
class ShortcutAction : ObjectG
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
    return gtk_shortcut_action_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Tries to parse the given string into an action.
   * On success, the parsed action is returned. When parsing
   * failed, %NULL is returned.
   * The accepted strings are:
   * - `nothing`, for `GtkNothingAction`
   * - `activate`, for `GtkActivateAction`
   * - `mnemonic-activate`, for `GtkMnemonicAction`
   * - `action$(LPAREN)NAME$(RPAREN)`, for a `GtkNamedAction` for the action named `NAME`
   * - `signal$(LPAREN)NAME$(RPAREN)`, for a `GtkSignalAction` for the signal `NAME`
   * Params:
   *   string_ = the string to parse
   * Returns: a new `GtkShortcutAction`
   */
  static ShortcutAction parseString(string string_)
  {
    GtkShortcutAction* _cretval;
    const(char)* _string_ = string_.toCString(false);
    _cretval = gtk_shortcut_action_parse_string(_string_);
    auto _retval = _cretval ? ObjectG.getDObject!ShortcutAction(cast(GtkShortcutAction*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Activates the action on the widget with the given args.
   * Note that some actions ignore the passed in flags, widget or args.
   * Activation of an action can fail for various reasons. If the action
   * is not supported by the widget, if the args don't match the action
   * or if the activation otherwise had no effect, %FALSE will be returned.
   * Params:
   *   flags = flags to activate with
   *   widget = Target of the activation
   *   args = arguments to pass
   * Returns: %TRUE if this action was activated successfully
   */
  bool activate(ShortcutActionFlags flags, Widget widget, VariantG args)
  {
    bool _retval;
    _retval = gtk_shortcut_action_activate(cast(GtkShortcutAction*)cPtr, flags, widget ? cast(GtkWidget*)widget.cPtr(false) : null, args ? cast(VariantC*)args.cPtr(false) : null);
    return _retval;
  }

  /**
   * Prints the given action into a string for the developer.
   * This is meant for debugging and logging.
   * The form of the representation may change at any time and is
   * not guaranteed to stay identical.
   * Params:
   *   string_ = a `GString` to print into
   */
  void print(String string_)
  {
    gtk_shortcut_action_print(cast(GtkShortcutAction*)cPtr, string_ ? cast(GString*)string_.cPtr(false) : null);
  }

  /**
   * Prints the given action into a human-readable string.
   * This is a small wrapper around [Gtk.ShortcutAction.print]
   * to help when debugging.
   * Returns: a new string
   */
  string toString_()
  {
    char* _cretval;
    _cretval = gtk_shortcut_action_to_string(cast(GtkShortcutAction*)cPtr);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }
}
