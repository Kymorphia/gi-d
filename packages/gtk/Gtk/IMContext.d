module Gtk.IMContext;

import GObject.DClosure;
import GObject.ObjectG;
import GObject.Types;
import Gdk.Device;
import Gdk.Event;
import Gdk.Rectangle;
import Gdk.Surface;
import Gdk.Types;
import Gid.gid;
import Gtk.Types;
import Gtk.Widget;
import Gtk.c.functions;
import Gtk.c.types;
import Pango.AttrList;

/**
 * `GtkIMContext` defines the interface for GTK input methods.
 * `GtkIMContext` is used by GTK text input widgets like `GtkText`
 * to map from key events to Unicode character strings.
 * An input method may consume multiple key events in sequence before finally
 * outputting the composed result. This is called *preediting*, and an input
 * method may provide feedback about this process by displaying the intermediate
 * composition states as preedit text. To do so, the `GtkIMContext` will emit
 * signal@Gtk.IMContext::preedit-start, signal@Gtk.IMContext::preedit-changed
 * and signal@Gtk.IMContext::preedit-end signals.
 * For instance, the built-in GTK input method [Gtk.IMContextSimple]
 * implements the input of arbitrary Unicode code points by holding down the
 * <kbd>Control</kbd> and <kbd>Shift</kbd> keys and then typing <kbd>u</kbd>
 * followed by the hexadecimal digits of the code point. When releasing the
 * <kbd>Control</kbd> and <kbd>Shift</kbd> keys, preediting ends and the
 * character is inserted as text. For example,
 * Ctrl+Shift+u 2 0 A C
 * results in the € sign.
 * Additional input methods can be made available for use by GTK widgets as
 * loadable modules. An input method module is a small shared library which
 * provides a `GIOExtension` for the extension point named "gtk-im-module".
 * To connect a widget to the users preferred input method, you should use
 * [Gtk.IMMulticontext].
 */
class IMContext : ObjectG
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
    return gtk_im_context_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Requests the platform to show an on-screen keyboard for user input.
   * This method will return %TRUE if this request was actually performed
   * to the platform, other environmental factors may result in an on-screen
   * keyboard effectively not showing up.
   * Params:
   *   event = a [Gdk.Event]
   * Returns: %TRUE if an on-screen keyboard could be requested to the platform.
   */
  bool activateOsk(Event event)
  {
    bool _retval;
    _retval = gtk_im_context_activate_osk(cast(GtkIMContext*)cPtr, event ? cast(GdkEvent*)event.cPtr(false) : null);
    return _retval;
  }

  /**
   * Asks the widget that the input context is attached to delete
   * characters around the cursor position by emitting the
   * `::delete_surrounding` signal.
   * Note that offset and n_chars are in characters not in bytes
   * which differs from the usage other places in `GtkIMContext`.
   * In order to use this function, you should first call
   * [Gtk.IMContext.getSurrounding] to get the current context,
   * and call this function immediately afterwards to make sure that you
   * know what you are deleting. You should also account for the fact
   * that even if the signal was handled, the input context might not
   * have deleted all the characters that were requested to be deleted.
   * This function is used by an input method that wants to make
   * substitutions in the existing text in response to new input.
   * It is not useful for applications.
   * Params:
   *   offset = offset from cursor position in chars;
   *     a negative value means start before the cursor.
   *   nChars = number of characters to delete.
   * Returns: %TRUE if the signal was handled.
   */
  bool deleteSurrounding(int offset, int nChars)
  {
    bool _retval;
    _retval = gtk_im_context_delete_surrounding(cast(GtkIMContext*)cPtr, offset, nChars);
    return _retval;
  }

  /**
   * Allow an input method to forward key press and release events
   * to another input method without necessarily having a `GdkEvent`
   * available.
   * Params:
   *   press = whether to forward a key press or release event
   *   surface = the surface the event is for
   *   device = the device that the event is for
   *   time = the timestamp for the event
   *   keycode = the keycode for the event
   *   state = modifier state for the event
   *   group = the active keyboard group for the event
   * Returns: %TRUE if the input method handled the key event.
   */
  bool filterKey(bool press, Surface surface, Device device, uint time, uint keycode, ModifierType state, int group)
  {
    bool _retval;
    _retval = gtk_im_context_filter_key(cast(GtkIMContext*)cPtr, press, surface ? cast(GdkSurface*)surface.cPtr(false) : null, device ? cast(GdkDevice*)device.cPtr(false) : null, time, keycode, state, group);
    return _retval;
  }

  /**
   * Allow an input method to internally handle key press and release
   * events.
   * If this function returns %TRUE, then no further processing
   * should be done for this key event.
   * Params:
   *   event = the key event
   * Returns: %TRUE if the input method handled the key event.
   */
  bool filterKeypress(Event event)
  {
    bool _retval;
    _retval = gtk_im_context_filter_keypress(cast(GtkIMContext*)cPtr, event ? cast(GdkEvent*)event.cPtr(false) : null);
    return _retval;
  }

  /**
   * Notify the input method that the widget to which this
   * input context corresponds has gained focus.
   * The input method may, for example, change the displayed
   * feedback to reflect this change.
   */
  void focusIn()
  {
    gtk_im_context_focus_in(cast(GtkIMContext*)cPtr);
  }

  /**
   * Notify the input method that the widget to which this
   * input context corresponds has lost focus.
   * The input method may, for example, change the displayed
   * feedback or reset the contexts state to reflect this change.
   */
  void focusOut()
  {
    gtk_im_context_focus_out(cast(GtkIMContext*)cPtr);
  }

  /**
   * Retrieve the current preedit string for the input context,
   * and a list of attributes to apply to the string.
   * This string should be displayed inserted at the insertion point.
   * Params:
   *   str = location to store the retrieved
   *     string. The string retrieved must be freed with [GLib.Global.gfree].
   *   attrs = location to store the retrieved
   *     attribute list. When you are done with this list, you
   *     must unreference it with [Pango.AttrList.unref].
   *   cursorPos = location to store position of cursor
   *     $(LPAREN)in characters$(RPAREN) within the preedit string.
   */
  void getPreeditString(out string str, out AttrList attrs, out int cursorPos)
  {
    char* _str;
    PangoAttrList* _attrs;
    gtk_im_context_get_preedit_string(cast(GtkIMContext*)cPtr, &_str, &_attrs, cast(int*)&cursorPos);
    str = _str.fromCString(true);
    attrs = new AttrList(cast(void*)_attrs, true);
  }

  /**
   * Retrieves context around the insertion point.
   * Input methods typically want context in order to constrain input text
   * based on existing text; this is important for languages such as Thai
   * where only some sequences of characters are allowed.
   * This function is implemented by emitting the
   * signalGtk.IMContext::retrieve-surrounding signal on the input method;
   * in response to this signal, a widget should provide as much context as
   * is available, up to an entire paragraph, by calling
   * [Gtk.IMContext.setSurrounding].
   * Note that there is no obligation for a widget to respond to the
   * `::retrieve-surrounding` signal, so input methods must be prepared to
   * function without context.
   * Params:
   *   text = location to store a UTF-8 encoded
   *     string of text holding context around the insertion point.
   *     If the function returns %TRUE, then you must free the result
   *     stored in this location with [GLib.Global.gfree].
   *   cursorIndex = location to store byte index of the insertion
   *     cursor within text.
   * Returns: `TRUE` if surrounding text was provided; in this case
   *   you must free the result stored in `text`.

   * Deprecated: Use [Gtk.IMContext.getSurroundingWithSelection] instead.
   */
  bool getSurrounding(out string text, out int cursorIndex)
  {
    bool _retval;
    char* _text;
    _retval = gtk_im_context_get_surrounding(cast(GtkIMContext*)cPtr, &_text, cast(int*)&cursorIndex);
    text = _text.fromCString(true);
    return _retval;
  }

  /**
   * Retrieves context around the insertion point.
   * Input methods typically want context in order to constrain input
   * text based on existing text; this is important for languages such
   * as Thai where only some sequences of characters are allowed.
   * This function is implemented by emitting the
   * signalGtk.IMContext::retrieve-surrounding signal on the input method;
   * in response to this signal, a widget should provide as much context as
   * is available, up to an entire paragraph, by calling
   * [Gtk.IMContext.setSurroundingWithSelection].
   * Note that there is no obligation for a widget to respond to the
   * `::retrieve-surrounding` signal, so input methods must be prepared to
   * function without context.
   * Params:
   *   text = location to store a UTF-8 encoded
   *     string of text holding context around the insertion point.
   *     If the function returns %TRUE, then you must free the result
   *     stored in this location with [GLib.Global.gfree].
   *   cursorIndex = location to store byte index of the insertion
   *     cursor within text.
   *   anchorIndex = location to store byte index of the selection
   *     bound within text
   * Returns: `TRUE` if surrounding text was provided; in this case
   *   you must free the result stored in `text`.
   */
  bool getSurroundingWithSelection(out string text, out int cursorIndex, out int anchorIndex)
  {
    bool _retval;
    char* _text;
    _retval = gtk_im_context_get_surrounding_with_selection(cast(GtkIMContext*)cPtr, &_text, cast(int*)&cursorIndex, cast(int*)&anchorIndex);
    text = _text.fromCString(true);
    return _retval;
  }

  /**
   * Notify the input method that a change such as a change in cursor
   * position has been made.
   * This will typically cause the input method to clear the preedit state.
   */
  void reset()
  {
    gtk_im_context_reset(cast(GtkIMContext*)cPtr);
  }

  /**
   * Set the client widget for the input context.
   * This is the `GtkWidget` holding the input focus. This widget is
   * used in order to correctly position status windows, and may
   * also be used for purposes internal to the input method.
   * Params:
   *   widget = the client widget. This may be %NULL to indicate
   *     that the previous client widget no longer exists.
   */
  void setClientWidget(Widget widget)
  {
    gtk_im_context_set_client_widget(cast(GtkIMContext*)cPtr, widget ? cast(GtkWidget*)widget.cPtr(false) : null);
  }

  /**
   * Notify the input method that a change in cursor
   * position has been made.
   * The location is relative to the client widget.
   * Params:
   *   area = new location
   */
  void setCursorLocation(Rectangle area)
  {
    gtk_im_context_set_cursor_location(cast(GtkIMContext*)cPtr, area ? cast(GdkRectangle*)area.cPtr(false) : null);
  }

  /**
   * Sets surrounding context around the insertion point and preedit
   * string.
   * This function is expected to be called in response to the
   * signalGtk.IMContext::retrieve-surrounding signal, and will
   * likely have no effect if called at other times.
   * Params:
   *   text = text surrounding the insertion point, as UTF-8.
   *     the preedit string should not be included within text
   *   len = the length of text, or -1 if text is nul-terminated
   *   cursorIndex = the byte index of the insertion cursor within text.

   * Deprecated: Use [Gtk.IMContext.setSurroundingWithSelection] instead
   */
  void setSurrounding(string text, int len, int cursorIndex)
  {
    const(char)* _text = text.toCString(false);
    gtk_im_context_set_surrounding(cast(GtkIMContext*)cPtr, _text, len, cursorIndex);
  }

  /**
   * Sets surrounding context around the insertion point and preedit
   * string. This function is expected to be called in response to the
   * signalGtk.IMContext::retrieve_surrounding signal, and will likely
   * have no effect if called at other times.
   * Params:
   *   text = text surrounding the insertion point, as UTF-8.
   *     the preedit string should not be included within text
   *   len = the length of text, or -1 if text is nul-terminated
   *   cursorIndex = the byte index of the insertion cursor within text
   *   anchorIndex = the byte index of the selection bound within text
   */
  void setSurroundingWithSelection(string text, int len, int cursorIndex, int anchorIndex)
  {
    const(char)* _text = text.toCString(false);
    gtk_im_context_set_surrounding_with_selection(cast(GtkIMContext*)cPtr, _text, len, cursorIndex, anchorIndex);
  }

  /**
   * Sets whether the IM context should use the preedit string
   * to display feedback.
   * If use_preedit is %FALSE $(LPAREN)default is %TRUE$(RPAREN), then the IM context
   * may use some other method to display feedback, such as displaying
   * it in a child of the root window.
   * Params:
   *   usePreedit = whether the IM context should use the preedit string.
   */
  void setUsePreedit(bool usePreedit)
  {
    gtk_im_context_set_use_preedit(cast(GtkIMContext*)cPtr, usePreedit);
  }

  /**
   * The ::commit signal is emitted when a complete input sequence
   * has been entered by the user.
   * If the commit comes after a preediting sequence, the
   * ::commit signal is emitted after ::preedit-end.
   * This can be a single character immediately after a key press or
   * the final result of preediting.
   * Params
   *   str = the completed character$(LPAREN)s$(RPAREN) entered by the user
   *   iMContext = the instance the signal is connected to
   */
  alias CommitCallback = void delegate(string str, IMContext iMContext);

  /**
   * Connect to Commit signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectCommit(CommitCallback dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto iMContext = getVal!IMContext(_paramVals);
      auto str = getVal!string(&_paramVals[1]);
      _dgClosure.dlg(str, iMContext);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("commit", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * The ::delete-surrounding signal is emitted when the input method
   * needs to delete all or part of the context surrounding the cursor.
   * Params
   *   offset = the character offset from the cursor position of the text
   *     to be deleted. A negative value indicates a position before
   *     the cursor.
   *   nChars = the number of characters to be deleted
   *   iMContext = the instance the signal is connected to
   * Returns: %TRUE if the signal was handled.
   */
  alias DeleteSurroundingCallback = bool delegate(int offset, int nChars, IMContext iMContext);

  /**
   * Connect to DeleteSurrounding signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectDeleteSurrounding(DeleteSurroundingCallback dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 3, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      bool _retval;
      auto iMContext = getVal!IMContext(_paramVals);
      auto offset = getVal!int(&_paramVals[1]);
      auto nChars = getVal!int(&_paramVals[2]);
      _retval = _dgClosure.dlg(offset, nChars, iMContext);
      setVal!bool(_returnValue, _retval);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("delete-surrounding", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * The ::preedit-changed signal is emitted whenever the preedit sequence
   * currently being entered has changed.
   * It is also emitted at the end of a preedit sequence, in which case
   * [Gtk.IMContext.getPreeditString] returns the empty string.
   *   iMContext = the instance the signal is connected to
   */
  alias PreeditChangedCallback = void delegate(IMContext iMContext);

  /**
   * Connect to PreeditChanged signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectPreeditChanged(PreeditChangedCallback dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto iMContext = getVal!IMContext(_paramVals);
      _dgClosure.dlg(iMContext);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("preedit-changed", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * The ::preedit-end signal is emitted when a preediting sequence
   * has been completed or canceled.
   *   iMContext = the instance the signal is connected to
   */
  alias PreeditEndCallback = void delegate(IMContext iMContext);

  /**
   * Connect to PreeditEnd signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectPreeditEnd(PreeditEndCallback dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto iMContext = getVal!IMContext(_paramVals);
      _dgClosure.dlg(iMContext);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("preedit-end", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * The ::preedit-start signal is emitted when a new preediting sequence
   * starts.
   *   iMContext = the instance the signal is connected to
   */
  alias PreeditStartCallback = void delegate(IMContext iMContext);

  /**
   * Connect to PreeditStart signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectPreeditStart(PreeditStartCallback dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto iMContext = getVal!IMContext(_paramVals);
      _dgClosure.dlg(iMContext);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("preedit-start", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * The ::retrieve-surrounding signal is emitted when the input method
   * requires the context surrounding the cursor.
   * The callback should set the input method surrounding context by
   * calling the [Gtk.IMContext.setSurrounding] method.
   *   iMContext = the instance the signal is connected to
   * Returns: %TRUE if the signal was handled.
   */
  alias RetrieveSurroundingCallback = bool delegate(IMContext iMContext);

  /**
   * Connect to RetrieveSurrounding signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectRetrieveSurrounding(RetrieveSurroundingCallback dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      bool _retval;
      auto iMContext = getVal!IMContext(_paramVals);
      _retval = _dgClosure.dlg(iMContext);
      setVal!bool(_returnValue, _retval);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("retrieve-surrounding", closure, (flags & ConnectFlags.After) != 0);
  }
}
