module Gtk.InfoBar;

import GObject.DClosure;
import GObject.ObjectG;
import Gid.gid;
import Gtk.Accessible;
import Gtk.AccessibleT;
import Gtk.Buildable;
import Gtk.BuildableT;
import Gtk.Button;
import Gtk.ConstraintTarget;
import Gtk.ConstraintTargetT;
import Gtk.Types;
import Gtk.Widget;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkInfoBar` can be used to show messages to the user without a dialog.
 * ![An example GtkInfoBar](info-bar.png)
 * It is often temporarily shown at the top or bottom of a document.
 * In contrast to [Gtk.Dialog], which has an action area at the
 * bottom, `GtkInfoBar` has an action area at the side.
 * The API of `GtkInfoBar` is very similar to `GtkDialog`, allowing you
 * to add buttons to the action area with [Gtk.InfoBar.addButton]
 * or [Gtk.InfoBar.newWithButtons]. The sensitivity of action widgets
 * can be controlled with [Gtk.InfoBar.setResponseSensitive].
 * To add widgets to the main content area of a `GtkInfoBar`, use
 * [Gtk.InfoBar.addChild].
 * Similar to [Gtk.MessageDialog], the contents of a `GtkInfoBar`
 * can by classified as error message, warning, informational message, etc,
 * by using [Gtk.InfoBar.setMessageType]. GTK may use the message
 * type to determine how the message is displayed.
 * A simple example for using a `GtkInfoBar`:
 * ```c
 * GtkWidget *message_label;
 * GtkWidget *widget;
 * GtkWidget *grid;
 * GtkInfoBar *bar;
 * // set up info bar
 * widget \= gtk_info_bar_new $(LPAREN)$(RPAREN);
 * bar \= GTK_INFO_BAR $(LPAREN)widget$(RPAREN);
 * grid \= gtk_grid_new $(LPAREN)$(RPAREN);
 * message_label \= gtk_label_new $(LPAREN)""$(RPAREN);
 * gtk_info_bar_add_child $(LPAREN)bar, message_label$(RPAREN);
 * gtk_info_bar_add_button $(LPAREN)bar,
 * _$(LPAREN)"_OK"$(RPAREN),
 * GTK_RESPONSE_OK$(RPAREN);
 * g_signal_connect $(LPAREN)bar,
 * "response",
 * G_CALLBACK $(LPAREN)gtk_widget_hide$(RPAREN),
 * NULL$(RPAREN);
 * gtk_grid_attach $(LPAREN)GTK_GRID $(LPAREN)grid$(RPAREN),
 * widget,
 * 0, 2, 1, 1$(RPAREN);
 * // ...
 * // show an error message
 * gtk_label_set_text $(LPAREN)GTK_LABEL $(LPAREN)message_label$(RPAREN), "An error occurred!"$(RPAREN);
 * gtk_info_bar_set_message_type $(LPAREN)bar, GTK_MESSAGE_ERROR$(RPAREN);
 * gtk_widget_show $(LPAREN)bar$(RPAREN);
 * ```
 * # GtkInfoBar as GtkBuildable
 * `GtkInfoBar` supports a custom `<action-widgets>` element, which can contain
 * multiple `<action-widget>` elements. The “response” attribute specifies a
 * numeric response, and the content of the element is the id of widget
 * $(LPAREN)which should be a child of the dialogs @action_area$(RPAREN).
 * `GtkInfoBar` supports adding action widgets by specifying “action” as
 * the “type” attribute of a `<child>` element. The widget will be added
 * either to the action area. The response id has to be associated
 * with the action widget using the `<action-widgets>` element.
 * # CSS nodes
 * `GtkInfoBar` has a single CSS node with name infobar. The node may get
 * one of the style classes .info, .warning, .error or .question, depending
 * on the message type.
 * If the info bar shows a close button, that button will have the .close
 * style class applied.

 * Deprecated: There is no replacement in GTK for an "info bar" widget;
 *   you can use [Gtk.Revealer] with a [Gtk.Box] containing a
 *   [Gtk.Label] and an optional [Gtk.Button], according to
 *   your application's design.
 */
class InfoBar : Widget
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return gtk_info_bar_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new `GtkInfoBar` object.
   * Returns: a new `GtkInfoBar` object
   */
  this()
  {
    GtkWidget* _cretval;
    _cretval = gtk_info_bar_new();
    this(_cretval, false);
  }

  /**
   * Add an activatable widget to the action area of a `GtkInfoBar`.
   * This also connects a signal handler that will emit the
   * [Gtk.InfoBar.response] signal on the message area
   * when the widget is activated. The widget is appended to the
   * end of the message areas action area.
   * Params:
   *   child = an activatable widget
   *   responseId = response ID for child
   */
  void addActionWidget(Widget child, int responseId)
  {
    gtk_info_bar_add_action_widget(cast(GtkInfoBar*)cPtr, child ? cast(GtkWidget*)child.cPtr(false) : null, responseId);
  }

  /**
   * Adds a button with the given text.
   * Clicking the button will emit the [Gtk.InfoBar.response]
   * signal with the given response_id. The button is appended to the
   * end of the info bar's action area. The button widget is returned,
   * but usually you don't need it.
   * Params:
   *   buttonText = text of button
   *   responseId = response ID for the button
   * Returns: the `GtkButton` widget
   *   that was added
   */
  Button addButton(string buttonText, int responseId)
  {
    GtkWidget* _cretval;
    const(char)* _buttonText = buttonText.toCString(false);
    _cretval = gtk_info_bar_add_button(cast(GtkInfoBar*)cPtr, _buttonText, responseId);
    auto _retval = _cretval ? ObjectG.getDObject!Button(cast(GtkWidget*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Adds a widget to the content area of the info bar.
   * Params:
   *   widget = the child to be added
   */
  void addChild(Widget widget)
  {
    gtk_info_bar_add_child(cast(GtkInfoBar*)cPtr, widget ? cast(GtkWidget*)widget.cPtr(false) : null);
  }

  /**
   * Returns the message type of the message area.
   * Returns: the message type of the message area.
   */
  MessageType getMessageType()
  {
    GtkMessageType _cretval;
    _cretval = gtk_info_bar_get_message_type(cast(GtkInfoBar*)cPtr);
    MessageType _retval = cast(MessageType)_cretval;
    return _retval;
  }

  /**
   * Returns whether the info bar is currently revealed.
   * Returns: the current value of the [Gtk.InfoBar.revealed] property
   */
  bool getRevealed()
  {
    bool _retval;
    _retval = gtk_info_bar_get_revealed(cast(GtkInfoBar*)cPtr);
    return _retval;
  }

  /**
   * Returns whether the widget will display a standard close button.
   * Returns: %TRUE if the widget displays standard close button
   */
  bool getShowCloseButton()
  {
    bool _retval;
    _retval = gtk_info_bar_get_show_close_button(cast(GtkInfoBar*)cPtr);
    return _retval;
  }

  /**
   * Removes a widget from the action area of info_bar.
   * The widget must have been put there by a call to
   * [Gtk.InfoBar.addActionWidget] or [Gtk.InfoBar.addButton].
   * Params:
   *   widget = an action widget to remove
   */
  void removeActionWidget(Widget widget)
  {
    gtk_info_bar_remove_action_widget(cast(GtkInfoBar*)cPtr, widget ? cast(GtkWidget*)widget.cPtr(false) : null);
  }

  /**
   * Removes a widget from the content area of the info bar.
   * Params:
   *   widget = a child that has been added to the content area
   */
  void removeChild(Widget widget)
  {
    gtk_info_bar_remove_child(cast(GtkInfoBar*)cPtr, widget ? cast(GtkWidget*)widget.cPtr(false) : null);
  }

  /**
   * Emits the “response” signal with the given response_id.
   * Params:
   *   responseId = a response ID
   */
  void response(int responseId)
  {
    gtk_info_bar_response(cast(GtkInfoBar*)cPtr, responseId);
  }

  /**
   * Sets the last widget in the info bar’s action area with
   * the given response_id as the default widget for the dialog.
   * Pressing “Enter” normally activates the default widget.
   * Note that this function currently requires info_bar to
   * be added to a widget hierarchy.
   * Params:
   *   responseId = a response ID
   */
  void setDefaultResponse(int responseId)
  {
    gtk_info_bar_set_default_response(cast(GtkInfoBar*)cPtr, responseId);
  }

  /**
   * Sets the message type of the message area.
   * GTK uses this type to determine how the message is displayed.
   * Params:
   *   messageType = a `GtkMessageType`
   */
  void setMessageType(MessageType messageType)
  {
    gtk_info_bar_set_message_type(cast(GtkInfoBar*)cPtr, messageType);
  }

  /**
   * Sets the sensitivity of action widgets for response_id.
   * Calls `gtk_widget_set_sensitive $(LPAREN)widget, setting$(RPAREN)` for each
   * widget in the info bars’s action area with the given response_id.
   * A convenient way to sensitize/desensitize buttons.
   * Params:
   *   responseId = a response ID
   *   setting = TRUE for sensitive
   */
  void setResponseSensitive(int responseId, bool setting)
  {
    gtk_info_bar_set_response_sensitive(cast(GtkInfoBar*)cPtr, responseId, setting);
  }

  /**
   * Sets whether the `GtkInfoBar` is revealed.
   * Changing this will make info_bar reveal or conceal
   * itself via a sliding transition.
   * Note: this does not show or hide info_bar in the
   * [Gtk.Widget.visible] sense, so revealing has no effect
   * if [Gtk.Widget.visible] is %FALSE.
   * Params:
   *   revealed = The new value of the property
   */
  void setRevealed(bool revealed)
  {
    gtk_info_bar_set_revealed(cast(GtkInfoBar*)cPtr, revealed);
  }

  /**
   * If true, a standard close button is shown.
   * When clicked it emits the response %GTK_RESPONSE_CLOSE.
   * Params:
   *   setting = %TRUE to include a close button
   */
  void setShowCloseButton(bool setting)
  {
    gtk_info_bar_set_show_close_button(cast(GtkInfoBar*)cPtr, setting);
  }

  /**
   * Gets emitted when the user uses a keybinding to dismiss the info bar.
   * The ::close signal is a [keybinding signal](class.SignalAction.html).
   * The default binding for this signal is the Escape key.
   *   infoBar = the instance the signal is connected to
   */
  alias CloseCallback = void delegate(InfoBar infoBar);

  /**
   * Connect to Close signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectClose(CloseCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto infoBar = getVal!InfoBar(_paramVals);
      _dgClosure.dlg(infoBar);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("close", closure, after);
  }

  /**
   * Emitted when an action widget is clicked.
   * The signal is also emitted when the application programmer
   * calls [Gtk.InfoBar.response]. The response_id depends
   * on which action widget was clicked.
   * Params
   *   responseId = the response ID
   *   infoBar = the instance the signal is connected to
   */
  alias ResponseCallback = void delegate(int responseId, InfoBar infoBar);

  /**
   * Connect to Response signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectResponse(ResponseCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto infoBar = getVal!InfoBar(_paramVals);
      auto responseId = getVal!int(&_paramVals[1]);
      _dgClosure.dlg(responseId, infoBar);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("response", closure, after);
  }
}
