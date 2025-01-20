module Gtk.ShortcutTrigger;

import GLib.String;
import GObject.ObjectG;
import Gdk.Display;
import Gdk.Event;
import Gdk.Types;
import Gid.gid;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkShortcutTrigger` tracks how a `GtkShortcut` should be activated.
 * To find out if a `GtkShortcutTrigger` triggers, you can call
 * [Gtk.ShortcutTrigger.trigger] on a `GdkEvent`.
 * `GtkShortcutTriggers` contain functions that allow easy presentation
 * to end users as well as being printed for debugging.
 * All `GtkShortcutTriggers` are immutable, you can only specify their
 * properties during construction. If you want to change a trigger, you
 * have to replace it with a new one.
 */
class ShortcutTrigger : ObjectG
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
    return gtk_shortcut_trigger_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Tries to parse the given string into a trigger.
   * On success, the parsed trigger is returned.
   * When parsing failed, %NULL is returned.
   * The accepted strings are:
   * - `never`, for `GtkNeverTrigger`
   * - a string parsed by [Gtk.Global.acceleratorParse], for a `GtkKeyvalTrigger`, e.g. `<Control>C`
   * - underscore, followed by a single character, for `GtkMnemonicTrigger`, e.g. `_l`
   * - two valid trigger strings, separated by a `|` character, for a
   * `GtkAlternativeTrigger`: `<Control>q|<Control>w`
   * Note that you will have to escape the `<` and `>` characters when specifying
   * triggers in XML files, such as GtkBuilder ui files. Use `&lt;` instead of
   * `<` and `&gt;` instead of `>`.
   * Params:
   *   string_ = the string to parse
   * Returns: a new `GtkShortcutTrigger`
   */
  static ShortcutTrigger parseString(string string_)
  {
    GtkShortcutTrigger* _cretval;
    const(char)* _string_ = string_.toCString(false);
    _cretval = gtk_shortcut_trigger_parse_string(_string_);
    auto _retval = _cretval ? ObjectG.getDObject!ShortcutTrigger(cast(GtkShortcutTrigger*)_cretval, true) : null;
    return _retval;
  }

  /**
   * The types of trigger1 and trigger2 are `gconstpointer` only to allow
   * use of this function as a `GCompareFunc`.
   * They must each be a `GtkShortcutTrigger`.
   * Params:
   *   trigger2 = a `GtkShortcutTrigger`
   * Returns: An integer less than, equal to, or greater than zero if
   *   trigger1 is found, respectively, to be less than, to match,
   *   or be greater than trigger2.
   */
  int compare(ShortcutTrigger trigger2)
  {
    int _retval;
    _retval = gtk_shortcut_trigger_compare(cast(GtkShortcutTrigger*)cPtr, trigger2 ? cast(GtkShortcutTrigger*)trigger2.cPtr(false) : null);
    return _retval;
  }

  /**
   * Checks if trigger1 and trigger2 trigger under the same conditions.
   * The types of one and two are `gconstpointer` only to allow use of this
   * function with `GHashTable`. They must each be a `GtkShortcutTrigger`.
   * Params:
   *   trigger2 = a `GtkShortcutTrigger`
   * Returns: %TRUE if trigger1 and trigger2 are equal
   */
  bool equal(ShortcutTrigger trigger2)
  {
    bool _retval;
    _retval = gtk_shortcut_trigger_equal(cast(GtkShortcutTrigger*)cPtr, trigger2 ? cast(GtkShortcutTrigger*)trigger2.cPtr(false) : null);
    return _retval;
  }

  /**
   * Generates a hash value for a `GtkShortcutTrigger`.
   * The output of this function is guaranteed to be the same for a given
   * value only per-process. It may change between different processor
   * architectures or even different versions of GTK. Do not use this
   * function as a basis for building protocols or file formats.
   * The types of trigger is `gconstpointer` only to allow use of this
   * function with `GHashTable`. They must each be a `GtkShortcutTrigger`.
   * Returns: a hash value corresponding to trigger
   */
  uint hash()
  {
    uint _retval;
    _retval = gtk_shortcut_trigger_hash(cast(GtkShortcutTrigger*)cPtr);
    return _retval;
  }

  /**
   * Prints the given trigger into a string for the developer.
   * This is meant for debugging and logging.
   * The form of the representation may change at any time
   * and is not guaranteed to stay identical.
   * Params:
   *   string_ = a `GString` to print into
   */
  void print(String string_)
  {
    gtk_shortcut_trigger_print(cast(GtkShortcutTrigger*)cPtr, string_ ? cast(GString*)string_.cPtr(false) : null);
  }

  /**
   * Prints the given trigger into a string.
   * This function is returning a translated string for presentation
   * to end users for example in menu items or in help texts.
   * The display in use may influence the resulting string in
   * various forms, such as resolving hardware keycodes or by
   * causing display-specific modifier names.
   * The form of the representation may change at any time and is
   * not guaranteed to stay identical.
   * Params:
   *   display = `GdkDisplay` to print for
   *   string_ = a `GString` to print into
   * Returns: %TRUE if something was printed or %FALSE if the
   *   trigger did not have a textual representation suitable
   *   for end users.
   */
  bool printLabel(Display display, String string_)
  {
    bool _retval;
    _retval = gtk_shortcut_trigger_print_label(cast(GtkShortcutTrigger*)cPtr, display ? cast(GdkDisplay*)display.cPtr(false) : null, string_ ? cast(GString*)string_.cPtr(false) : null);
    return _retval;
  }

  /**
   * Gets textual representation for the given trigger.
   * This function is returning a translated string for
   * presentation to end users for example in menu items
   * or in help texts.
   * The display in use may influence the resulting string in
   * various forms, such as resolving hardware keycodes or by
   * causing display-specific modifier names.
   * The form of the representation may change at any time and is
   * not guaranteed to stay identical.
   * Params:
   *   display = `GdkDisplay` to print for
   * Returns: a new string
   */
  string toLabel(Display display)
  {
    char* _cretval;
    _cretval = gtk_shortcut_trigger_to_label(cast(GtkShortcutTrigger*)cPtr, display ? cast(GdkDisplay*)display.cPtr(false) : null);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * Prints the given trigger into a human-readable string.
   * This is a small wrapper around [Gtk.ShortcutTrigger.print]
   * to help when debugging.
   * Returns: a new string
   */
  string toString_()
  {
    char* _cretval;
    _cretval = gtk_shortcut_trigger_to_string(cast(GtkShortcutTrigger*)cPtr);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * Checks if the given event triggers self.
   * Params:
   *   event = the event to check
   *   enableMnemonics = %TRUE if mnemonics should trigger. Usually the
   *     value of this property is determined by checking that the passed
   *     in event is a Key event and has the right modifiers set.
   * Returns: Whether the event triggered the shortcut
   */
  KeyMatch trigger(Event event, bool enableMnemonics)
  {
    GdkKeyMatch _cretval;
    _cretval = gtk_shortcut_trigger_trigger(cast(GtkShortcutTrigger*)cPtr, event ? cast(GdkEvent*)event.cPtr(false) : null, enableMnemonics);
    KeyMatch _retval = cast(KeyMatch)_cretval;
    return _retval;
  }
}
