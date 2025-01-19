module Gtk.Button;

import GObject.DClosure;
import GObject.ObjectG;
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
 * The `GtkButton` widget is generally used to trigger a callback function that is
 * called when the button is pressed.
 * ![An example GtkButton](button.png)
 * The `GtkButton` widget can hold any valid child widget. That is, it can hold
 * almost any other standard `GtkWidget`. The most commonly used child is the
 * `GtkLabel`.
 * # CSS nodes
 * `GtkButton` has a single CSS node with name button. The node will get the
 * style classes .image-button or .text-button, if the content is just an
 * image or label, respectively. It may also receive the .flat style class.
 * When activating a button via the keyboard, the button will temporarily
 * gain the .keyboard-activating style class.
 * Other style classes that are commonly used with `GtkButton` include
 * .suggested-action and .destructive-action. In special cases, buttons
 * can be made round by adding the .circular style class.
 * Button-like widgets like [Gtk.ToggleButton], [Gtk.MenuButton],
 * [Gtk.VolumeButton], [Gtk.LockButton], [Gtk.ColorButton]
 * or [Gtk.FontButton] use style classes such as .toggle, .popup, .scale,
 * .lock, .color on the button node to differentiate themselves from a plain
 * `GtkButton`.
 * # Accessibility
 * `GtkButton` uses the %GTK_ACCESSIBLE_ROLE_BUTTON role.
 */
class Button : Widget, Actionable
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return gtk_button_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin ActionableT!();

  /**
   * Creates a new `GtkButton` widget.
   * To add a child widget to the button, use [Gtk.Button.setChild].
   * Returns: The newly created `GtkButton` widget.
   */
  this()
  {
    GtkWidget* _cretval;
    _cretval = gtk_button_new();
    this(_cretval, false);
  }

  /**
   * Creates a new button containing an icon from the current icon theme.
   * If the icon name isn’t known, a “broken image” icon will be
   * displayed instead. If the current icon theme is changed, the icon
   * will be updated appropriately.
   * Params:
   *   iconName = an icon name
   * Returns: a new `GtkButton` displaying the themed icon
   */
  static Button newFromIconName(string iconName)
  {
    GtkWidget* _cretval;
    const(char)* _iconName = iconName.toCString(false);
    _cretval = gtk_button_new_from_icon_name(_iconName);
    auto _retval = _cretval ? ObjectG.getDObject!Button(cast(GtkWidget*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Creates a `GtkButton` widget with a `GtkLabel` child.
   * Params:
   *   label = The text you want the `GtkLabel` to hold
   * Returns: The newly created `GtkButton` widget
   */
  static Button newWithLabel(string label)
  {
    GtkWidget* _cretval;
    const(char)* _label = label.toCString(false);
    _cretval = gtk_button_new_with_label(_label);
    auto _retval = _cretval ? ObjectG.getDObject!Button(cast(GtkWidget*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Creates a new `GtkButton` containing a label.
   * If characters in label are preceded by an underscore, they are underlined.
   * If you need a literal underscore character in a label, use “__” $(LPAREN)two
   * underscores$(RPAREN). The first underlined character represents a keyboard
   * accelerator called a mnemonic. Pressing <kbd>Alt</kbd> and that key
   * activates the button.
   * Params:
   *   label = The text of the button, with an underscore in front of the
   *     mnemonic character
   * Returns: a new `GtkButton`
   */
  static Button newWithMnemonic(string label)
  {
    GtkWidget* _cretval;
    const(char)* _label = label.toCString(false);
    _cretval = gtk_button_new_with_mnemonic(_label);
    auto _retval = _cretval ? ObjectG.getDObject!Button(cast(GtkWidget*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Retrieves whether the button can be smaller than the natural
   * size of its contents.
   * Returns: true if the button can shrink, and false otherwise
   */
  bool getCanShrink()
  {
    bool _retval;
    _retval = gtk_button_get_can_shrink(cast(GtkButton*)cPtr);
    return _retval;
  }

  /**
   * Gets the child widget of button.
   * Returns: the child widget of button
   */
  Widget getChild()
  {
    GtkWidget* _cretval;
    _cretval = gtk_button_get_child(cast(GtkButton*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Widget(cast(GtkWidget*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns whether the button has a frame.
   * Returns: %TRUE if the button has a frame
   */
  bool getHasFrame()
  {
    bool _retval;
    _retval = gtk_button_get_has_frame(cast(GtkButton*)cPtr);
    return _retval;
  }

  /**
   * Returns the icon name of the button.
   * If the icon name has not been set with [Gtk.Button.setIconName]
   * the return value will be %NULL. This will be the case if you create
   * an empty button with [Gtk.Button.new_] to use as a container.
   * Returns: The icon name set via [Gtk.Button.setIconName]
   */
  string getIconName()
  {
    const(char)* _cretval;
    _cretval = gtk_button_get_icon_name(cast(GtkButton*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Fetches the text from the label of the button.
   * If the label text has not been set with [Gtk.Button.setLabel]
   * the return value will be %NULL. This will be the case if you create
   * an empty button with [Gtk.Button.new_] to use as a container.
   * Returns: The text of the label widget. This string is owned
   *   by the widget and must not be modified or freed.
   */
  string getLabel()
  {
    const(char)* _cretval;
    _cretval = gtk_button_get_label(cast(GtkButton*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * gets whether underlines are interpreted as mnemonics.
   * See [Gtk.Button.setUseUnderline].
   * Returns: %TRUE if an embedded underline in the button label
   *   indicates the mnemonic accelerator keys.
   */
  bool getUseUnderline()
  {
    bool _retval;
    _retval = gtk_button_get_use_underline(cast(GtkButton*)cPtr);
    return _retval;
  }

  /**
   * Sets whether the button size can be smaller than the natural size of
   * its contents.
   * For text buttons, setting can_shrink to true will ellipsize the label.
   * For icons and custom children, this function has no effect.
   * Params:
   *   canShrink = whether the button can shrink
   */
  void setCanShrink(bool canShrink)
  {
    gtk_button_set_can_shrink(cast(GtkButton*)cPtr, canShrink);
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
    gtk_button_set_child(cast(GtkButton*)cPtr, child ? cast(GtkWidget*)child.cPtr(false) : null);
  }

  /**
   * Sets the style of the button.
   * Buttons can have a flat appearance or have a frame drawn around them.
   * Params:
   *   hasFrame = whether the button should have a visible frame
   */
  void setHasFrame(bool hasFrame)
  {
    gtk_button_set_has_frame(cast(GtkButton*)cPtr, hasFrame);
  }

  /**
   * Adds a `GtkImage` with the given icon name as a child.
   * If button already contains a child widget, that child widget will
   * be removed and replaced with the image.
   * Params:
   *   iconName = An icon name
   */
  void setIconName(string iconName)
  {
    const(char)* _iconName = iconName.toCString(false);
    gtk_button_set_icon_name(cast(GtkButton*)cPtr, _iconName);
  }

  /**
   * Sets the text of the label of the button to label.
   * This will also clear any previously set labels.
   * Params:
   *   label = a string
   */
  void setLabel(string label)
  {
    const(char)* _label = label.toCString(false);
    gtk_button_set_label(cast(GtkButton*)cPtr, _label);
  }

  /**
   * Sets whether to use underlines as mnemonics.
   * If true, an underline in the text of the button label indicates
   * the next character should be used for the mnemonic accelerator key.
   * Params:
   *   useUnderline = %TRUE if underlines in the text indicate mnemonics
   */
  void setUseUnderline(bool useUnderline)
  {
    gtk_button_set_use_underline(cast(GtkButton*)cPtr, useUnderline);
  }

  /**
   * Emitted to animate press then release.
   * This is an action signal. Applications should never connect
   * to this signal, but use the [Gtk.Button.clicked] signal.
   * The default bindings for this signal are all forms of the
   * <kbd>␣</kbd> and <kbd>Enter</kbd> keys.
   *   button = the instance the signal is connected to
   */
  alias ActivateCallback = void delegate(Button button);

  /**
   * Connect to Activate signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectActivate(ActivateCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto button = getVal!Button(_paramVals);
      _dgClosure.dlg(button);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("activate", closure, after);
  }

  /**
   * Emitted when the button has been activated $(LPAREN)pressed and released$(RPAREN).
   *   button = the instance the signal is connected to
   */
  alias ClickedCallback = void delegate(Button button);

  /**
   * Connect to Clicked signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectClicked(ClickedCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto button = getVal!Button(_paramVals);
      _dgClosure.dlg(button);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("clicked", closure, after);
  }
}
