module Gtk.Expander;

import GObject.DClosure;
import GObject.ObjectG;
import Gid.gid;
import Gtk.Accessible;
import Gtk.AccessibleT;
import Gtk.Buildable;
import Gtk.BuildableT;
import Gtk.ConstraintTarget;
import Gtk.ConstraintTargetT;
import Gtk.Types;
import Gtk.Widget;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkExpander` allows the user to reveal its child by clicking
 * on an expander triangle.
 * ![An example GtkExpander](expander.png)
 * This is similar to the triangles used in a `GtkTreeView`.
 * Normally you use an expander as you would use a frame; you create
 * the child widget and use [Gtk.Expander.setChild] to add it
 * to the expander. When the expander is toggled, it will take care of
 * showing and hiding the child automatically.
 * # Special Usage
 * There are situations in which you may prefer to show and hide the
 * expanded widget yourself, such as when you want to actually create
 * the widget at expansion time. In this case, create a `GtkExpander`
 * but do not add a child to it. The expander widget has an
 * [Gtk.Expander.expanded] property which can be used to
 * monitor its expansion state. You should watch this property with
 * a signal connection as follows:
 * ```c
 * static void
 * expander_callback $(LPAREN)GObject    *object,
 * GParamSpec *param_spec,
 * gpointer    user_data$(RPAREN)
 * {
 * GtkExpander *expander;
 * expander \= GTK_EXPANDER $(LPAREN)object$(RPAREN);
 * if $(LPAREN)gtk_expander_get_expanded $(LPAREN)expander$(RPAREN)$(RPAREN)
 * {
 * // Show or create widgets
 * }
 * else
 * {
 * // Hide or destroy widgets
 * }
 * }
 * static void
 * create_expander $(LPAREN)void$(RPAREN)
 * {
 * GtkWidget *expander \= gtk_expander_new_with_mnemonic $(LPAREN)"_More Options"$(RPAREN);
 * g_signal_connect $(LPAREN)expander, "notify::expanded",
 * G_CALLBACK $(LPAREN)expander_callback$(RPAREN), NULL$(RPAREN);
 * // ...
 * }
 * ```
 * # GtkExpander as GtkBuildable
 * The `GtkExpander` implementation of the `GtkBuildable` interface supports
 * placing a child in the label position by specifying “label” as the
 * “type” attribute of a `<child>` element. A normal content child can be
 * specified without specifying a `<child>` type attribute.
 * An example of a UI definition fragment with GtkExpander:
 * ```xml
 * <object class\="GtkExpander">
 * <child type\="label">
 * <object class\="GtkLabel" id\="expander-label"/>
 * </child>
 * <child>
 * <object class\="GtkEntry" id\="expander-content"/>
 * </child>
 * </object>
 * ```
 * # CSS nodes
 * ```
 * expander-widget
 * ╰── box
 * ├── title
 * │   ├── expander
 * │   ╰── <label widget>
 * ╰── <child>
 * ```
 * `GtkExpander` has a main node `expander-widget`, and subnode `box` containing
 * the title and child widget. The box subnode `title` contains node `expander`,
 * i.e. the expand/collapse arrow; then the label widget if any. The arrow of an
 * expander that is showing its child gets the `:checked` pseudoclass set on it.
 * # Accessibility
 * `GtkExpander` uses the %GTK_ACCESSIBLE_ROLE_BUTTON role.
 */
class Expander : Widget
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
    return gtk_expander_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new expander using label as the text of the label.
   * Params:
   *   label = the text of the label
   * Returns: a new `GtkExpander` widget.
   */
  this(string label)
  {
    GtkWidget* _cretval;
    const(char)* _label = label.toCString(false);
    _cretval = gtk_expander_new(_label);
    this(_cretval, false);
  }

  /**
   * Creates a new expander using label as the text of the label.
   * If characters in label are preceded by an underscore, they are
   * underlined. If you need a literal underscore character in a label,
   * use “__” $(LPAREN)two underscores$(RPAREN). The first underlined character represents
   * a keyboard accelerator called a mnemonic.
   * Pressing Alt and that key activates the button.
   * Params:
   *   label = the text of the label with an underscore
   *     in front of the mnemonic character
   * Returns: a new `GtkExpander` widget.
   */
  static Expander newWithMnemonic(string label)
  {
    GtkWidget* _cretval;
    const(char)* _label = label.toCString(false);
    _cretval = gtk_expander_new_with_mnemonic(_label);
    auto _retval = _cretval ? ObjectG.getDObject!Expander(cast(GtkWidget*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the child widget of expander.
   * Returns: the child widget of expander
   */
  Widget getChild()
  {
    GtkWidget* _cretval;
    _cretval = gtk_expander_get_child(cast(GtkExpander*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Widget(cast(GtkWidget*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Queries a `GtkExpander` and returns its current state.
   * Returns %TRUE if the child widget is revealed.
   * Returns: the current state of the expander
   */
  bool getExpanded()
  {
    bool _retval;
    _retval = gtk_expander_get_expanded(cast(GtkExpander*)cPtr);
    return _retval;
  }

  /**
   * Fetches the text from a label widget.
   * This is including any embedded underlines indicating mnemonics and
   * Pango markup, as set by [Gtk.Expander.setLabel]. If the label
   * text has not been set the return value will be %NULL. This will be the
   * case if you create an empty button with [Gtk.Button.new_] to use as a
   * container.
   * Returns: The text of the label widget. This string is owned
   *   by the widget and must not be modified or freed.
   */
  string getLabel()
  {
    const(char)* _cretval;
    _cretval = gtk_expander_get_label(cast(GtkExpander*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Retrieves the label widget for the frame.
   * Returns: the label widget
   */
  Widget getLabelWidget()
  {
    GtkWidget* _cretval;
    _cretval = gtk_expander_get_label_widget(cast(GtkExpander*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Widget(cast(GtkWidget*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns whether the expander will resize the toplevel widget
   * containing the expander upon resizing and collapsing.
   * Returns: the “resize toplevel” setting.
   */
  bool getResizeToplevel()
  {
    bool _retval;
    _retval = gtk_expander_get_resize_toplevel(cast(GtkExpander*)cPtr);
    return _retval;
  }

  /**
   * Returns whether the label’s text is interpreted as Pango markup.
   * Returns: %TRUE if the label’s text will be parsed for markup
   */
  bool getUseMarkup()
  {
    bool _retval;
    _retval = gtk_expander_get_use_markup(cast(GtkExpander*)cPtr);
    return _retval;
  }

  /**
   * Returns whether an underline in the text indicates a mnemonic.
   * Returns: %TRUE if an embedded underline in the expander
   *   label indicates the mnemonic accelerator keys
   */
  bool getUseUnderline()
  {
    bool _retval;
    _retval = gtk_expander_get_use_underline(cast(GtkExpander*)cPtr);
    return _retval;
  }

  /**
   * Sets the child widget of expander.
   * Params:
   *   child = the child widget
   */
  void setChild(Widget child)
  {
    gtk_expander_set_child(cast(GtkExpander*)cPtr, child ? cast(GtkWidget*)child.cPtr(false) : null);
  }

  /**
   * Sets the state of the expander.
   * Set to %TRUE, if you want the child widget to be revealed,
   * and %FALSE if you want the child widget to be hidden.
   * Params:
   *   expanded = whether the child widget is revealed
   */
  void setExpanded(bool expanded)
  {
    gtk_expander_set_expanded(cast(GtkExpander*)cPtr, expanded);
  }

  /**
   * Sets the text of the label of the expander to label.
   * This will also clear any previously set labels.
   * Params:
   *   label = a string
   */
  void setLabel(string label)
  {
    const(char)* _label = label.toCString(false);
    gtk_expander_set_label(cast(GtkExpander*)cPtr, _label);
  }

  /**
   * Set the label widget for the expander.
   * This is the widget that will appear embedded alongside
   * the expander arrow.
   * Params:
   *   labelWidget = the new label widget
   */
  void setLabelWidget(Widget labelWidget)
  {
    gtk_expander_set_label_widget(cast(GtkExpander*)cPtr, labelWidget ? cast(GtkWidget*)labelWidget.cPtr(false) : null);
  }

  /**
   * Sets whether the expander will resize the toplevel widget
   * containing the expander upon resizing and collapsing.
   * Params:
   *   resizeToplevel = whether to resize the toplevel
   */
  void setResizeToplevel(bool resizeToplevel)
  {
    gtk_expander_set_resize_toplevel(cast(GtkExpander*)cPtr, resizeToplevel);
  }

  /**
   * Sets whether the text of the label contains Pango markup.
   * Params:
   *   useMarkup = %TRUE if the label’s text should be parsed for markup
   */
  void setUseMarkup(bool useMarkup)
  {
    gtk_expander_set_use_markup(cast(GtkExpander*)cPtr, useMarkup);
  }

  /**
   * If true, an underline in the text indicates a mnemonic.
   * Params:
   *   useUnderline = %TRUE if underlines in the text indicate mnemonics
   */
  void setUseUnderline(bool useUnderline)
  {
    gtk_expander_set_use_underline(cast(GtkExpander*)cPtr, useUnderline);
  }

  /**
   * Activates the `GtkExpander`.
   *   expander = the instance the signal is connected to
   */
  alias ActivateCallback = void delegate(Expander expander);

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
      auto expander = getVal!Expander(_paramVals);
      _dgClosure.dlg(expander);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("activate", closure, after);
  }
}
