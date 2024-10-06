module Gtk.CheckButton;

import GObject.DClosure;
import GObject.ObjectG;
import GObject.Types;
import Gid.gid;
import Gtk.Accessible;
import Gtk.AccessibleT;
import Gtk.Actionable;
import Gtk.ActionableT;
import Gtk.Buildable;
import Gtk.BuildableT;
import Gtk.ConstraintTarget;
import Gtk.ConstraintTargetT;
import Gtk.Types;
import Gtk.Widget;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * A `GtkCheckButton` places a label next to an indicator.
 * ![Example GtkCheckButtons](check-button.png)
 * A `GtkCheckButton` is created by calling either [Gtk.CheckButton.new_]
 * or [Gtk.CheckButton.newWithLabel].
 * The state of a `GtkCheckButton` can be set specifically using
 * [Gtk.CheckButton.setActive], and retrieved using
 * [Gtk.CheckButton.getActive].
 * # Inconsistent state
 * In addition to "on" and "off", check buttons can be an
 * "in between" state that is neither on nor off. This can be used
 * e.g. when the user has selected a range of elements $(LPAREN)such as some
 * text or spreadsheet cells$(RPAREN) that are affected by a check button,
 * and the current values in that range are inconsistent.
 * To set a `GtkCheckButton` to inconsistent state, use
 * [Gtk.CheckButton.setInconsistent].
 * # Grouping
 * Check buttons can be grouped together, to form mutually exclusive
 * groups - only one of the buttons can be toggled at a time, and toggling
 * another one will switch the currently toggled one off.
 * Grouped check buttons use a different indicator, and are commonly referred
 * to as *radio buttons*.
 * ![Example GtkCheckButtons](radio-button.png)
 * To add a `GtkCheckButton` to a group, use [Gtk.CheckButton.setGroup].
 * When the code must keep track of the state of a group of radio buttons, it
 * is recommended to keep track of such state through a stateful
 * `GAction` with a target for each button. Using the `toggled` signals to keep
 * track of the group changes and state is discouraged.
 * # CSS nodes
 * ```
 * checkbutton[.text-button]
 * ├── check
 * ╰── [label]
 * ```
 * A `GtkCheckButton` has a main node with name checkbutton. If the
 * [Gtk.CheckButton.label] or [Gtk.CheckButton.child]
 * properties are set, it contains a child widget. The indicator node
 * is named check when no group is set, and radio if the checkbutton
 * is grouped together with other checkbuttons.
 * # Accessibility
 * `GtkCheckButton` uses the %GTK_ACCESSIBLE_ROLE_CHECKBOX role.
 */
class CheckButton : Widget, Actionable
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return gtk_check_button_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin ActionableT!GtkCheckButton;

  /**
   * Creates a new `GtkCheckButton`.
   * Returns: a new `GtkCheckButton`
   */
  this()
  {
    GtkWidget* _cretval;
    _cretval = gtk_check_button_new();
    this(_cretval, false);
  }

  /**
   * Creates a new `GtkCheckButton` with the given text.
   * Params:
   *   label = the text for the check button.
   * Returns: a new `GtkCheckButton`
   */
  static CheckButton newWithLabel(string label)
  {
    GtkWidget* _cretval;
    const(char)* _label = label.toCString(false);
    _cretval = gtk_check_button_new_with_label(_label);
    auto _retval = _cretval ? ObjectG.getDObject!CheckButton(cast(GtkWidget*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Creates a new `GtkCheckButton` with the given text and a mnemonic.
   * Params:
   *   label = The text of the button, with an underscore
   *     in front of the mnemonic character
   * Returns: a new `GtkCheckButton`
   */
  static CheckButton newWithMnemonic(string label)
  {
    GtkWidget* _cretval;
    const(char)* _label = label.toCString(false);
    _cretval = gtk_check_button_new_with_mnemonic(_label);
    auto _retval = _cretval ? ObjectG.getDObject!CheckButton(cast(GtkWidget*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns whether the check button is active.
   * Returns: whether the check button is active
   */
  bool getActive()
  {
    bool _retval;
    _retval = gtk_check_button_get_active(cast(GtkCheckButton*)cPtr);
    return _retval;
  }

  /**
   * Gets the child widget of button or `NULL` if propertyCheckButton:label is set.
   * Returns: the child widget of button
   */
  Widget getChild()
  {
    GtkWidget* _cretval;
    _cretval = gtk_check_button_get_child(cast(GtkCheckButton*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Widget(cast(GtkWidget*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns whether the check button is in an inconsistent state.
   * Returns: %TRUE if check_button is currently in an inconsistent state
   */
  bool getInconsistent()
  {
    bool _retval;
    _retval = gtk_check_button_get_inconsistent(cast(GtkCheckButton*)cPtr);
    return _retval;
  }

  /**
   * Returns the label of the check button or `NULL` if propertyCheckButton:child is set.
   * Returns: The label self shows next
   *   to the indicator. If no label is shown, %NULL will be returned.
   */
  string getLabel()
  {
    const(char)* _cretval;
    _cretval = gtk_check_button_get_label(cast(GtkCheckButton*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Returns whether underlines in the label indicate mnemonics.
   * Returns: The value of the propertyGtk.CheckButton:use-underline property.
   *   See [Gtk.CheckButton.setUseUnderline] for details on how to set
   *   a new value.
   */
  bool getUseUnderline()
  {
    bool _retval;
    _retval = gtk_check_button_get_use_underline(cast(GtkCheckButton*)cPtr);
    return _retval;
  }

  /**
   * Changes the check buttons active state.
   * Params:
   *   setting = the new value to set
   */
  void setActive(bool setting)
  {
    gtk_check_button_set_active(cast(GtkCheckButton*)cPtr, setting);
  }

  /**
   * Sets the child widget of button.
   * Note that by using this API, you take full responsibility for setting
   * up the proper accessibility label and description information for button.
   * Most likely, you'll either set the accessibility label or description
   * for button explicitly, or you'll set a labelled-by or described-by
   * relations from child to button.
   * Params:
   *   child = the child widget
   */
  void setChild(Widget child)
  {
    gtk_check_button_set_child(cast(GtkCheckButton*)cPtr, child ? cast(GtkWidget*)child.cPtr(false) : null);
  }

  /**
   * Adds self to the group of group.
   * In a group of multiple check buttons, only one button can be active
   * at a time. The behavior of a checkbutton in a group is also commonly
   * known as a *radio button*.
   * Setting the group of a check button also changes the css name of the
   * indicator widget's CSS node to 'radio'.
   * Setting up groups in a cycle leads to undefined behavior.
   * Note that the same effect can be achieved via the [Gtk.Actionable]
   * API, by using the same action with parameter type and state type 's'
   * for all buttons in the group, and giving each button its own target
   * value.
   * Params:
   *   group = another `GtkCheckButton` to
   *     form a group with
   */
  void setGroup(CheckButton group)
  {
    gtk_check_button_set_group(cast(GtkCheckButton*)cPtr, group ? cast(GtkCheckButton*)group.cPtr(false) : null);
  }

  /**
   * Sets the `GtkCheckButton` to inconsistent state.
   * You should turn off the inconsistent state again if the user checks
   * the check button. This has to be done manually.
   * Params:
   *   inconsistent = %TRUE if state is inconsistent
   */
  void setInconsistent(bool inconsistent)
  {
    gtk_check_button_set_inconsistent(cast(GtkCheckButton*)cPtr, inconsistent);
  }

  /**
   * Sets the text of self.
   * If propertyGtk.CheckButton:use-underline is %TRUE, an underscore
   * in label is interpreted as mnemonic indicator, see
   * [Gtk.CheckButton.setUseUnderline] for details on this behavior.
   * Params:
   *   label = The text shown next to the indicator, or %NULL
   *     to show no text
   */
  void setLabel(string label)
  {
    const(char)* _label = label.toCString(false);
    gtk_check_button_set_label(cast(GtkCheckButton*)cPtr, _label);
  }

  /**
   * Sets whether underlines in the label indicate mnemonics.
   * If setting is %TRUE, an underscore character in self's label
   * indicates a mnemonic accelerator key. This behavior is similar
   * to propertyGtk.Label:use-underline.
   * Params:
   *   setting = the new value to set
   */
  void setUseUnderline(bool setting)
  {
    gtk_check_button_set_use_underline(cast(GtkCheckButton*)cPtr, setting);
  }

  /**
   * Emitted to when the check button is activated.
   * The `::activate` signal on `GtkCheckButton` is an action signal and
   * emitting it causes the button to animate press then release.
   * Applications should never connect to this signal, but use the
   * [Gtk.CheckButton.toggled] signal.
   * The default bindings for this signal are all forms of the
   * <kbd>␣</kbd> and <kbd>Enter</kbd> keys.
   *   checkButton = the instance the signal is connected to
   */
  alias ActivateCallback = void delegate(CheckButton checkButton);

  /**
   * Connect to Activate signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectActivate(ActivateCallback dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto checkButton = getVal!CheckButton(_paramVals);
      _dgClosure.dlg(checkButton);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("activate", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * Emitted when the buttons's [Gtk.CheckButton.active]
   * property changes.
   *   checkButton = the instance the signal is connected to
   */
  alias ToggledCallback = void delegate(CheckButton checkButton);

  /**
   * Connect to Toggled signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectToggled(ToggledCallback dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto checkButton = getVal!CheckButton(_paramVals);
      _dgClosure.dlg(checkButton);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("toggled", closure, (flags & ConnectFlags.After) != 0);
  }
}
