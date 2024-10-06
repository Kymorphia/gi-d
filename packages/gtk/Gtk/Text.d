module Gtk.Text;

import GObject.DClosure;
import GObject.ObjectG;
import GObject.Types;
import Gid.gid;
import Gio.MenuModel;
import Graphene.Rect;
import Gtk.Accessible;
import Gtk.AccessibleT;
import Gtk.AccessibleText;
import Gtk.AccessibleTextT;
import Gtk.Buildable;
import Gtk.BuildableT;
import Gtk.ConstraintTarget;
import Gtk.ConstraintTargetT;
import Gtk.Editable;
import Gtk.EditableT;
import Gtk.EntryBuffer;
import Gtk.Types;
import Gtk.Widget;
import Gtk.c.functions;
import Gtk.c.types;
import Pango.AttrList;
import Pango.TabArray;

/**
 * The `GtkText` widget is a single-line text entry widget.
 * `GtkText` is the common implementation of single-line text editing
 * that is shared between [Gtk.Entry], [Gtk.PasswordEntry],
 * [Gtk.SpinButton], and other widgets. In all of these, `GtkText` is
 * used as the delegate for the [Gtk.Editable] implementation.
 * A fairly large set of key bindings are supported by default. If the
 * entered text is longer than the allocation of the widget, the widget
 * will scroll so that the cursor position is visible.
 * When using an entry for passwords and other sensitive information,
 * it can be put into “password mode” using [Gtk.Text.setVisibility].
 * In this mode, entered text is displayed using a “invisible” character.
 * By default, GTK picks the best invisible character that is available
 * in the current font, but it can be changed with
 * [Gtk.Text.setInvisibleChar].
 * If you are looking to add icons or progress display in an entry, look
 * at [Gtk.Entry]. There other alternatives for more specialized use
 * cases, such as [Gtk.SearchEntry].
 * If you need multi-line editable text, look at [Gtk.TextView].
 * # CSS nodes
 * ```
 * text[.read-only]
 * ├── placeholder
 * ├── undershoot.left
 * ├── undershoot.right
 * ├── [selection]
 * ├── [block-cursor]
 * ╰── [window.popup]
 * ```
 * `GtkText` has a main node with the name `text`. Depending on the properties
 * of the widget, the `.read-only` style class may appear.
 * When the entry has a selection, it adds a subnode with the name `selection`.
 * When the entry is in overwrite mode, it adds a subnode with the name
 * `block-cursor` that determines how the block cursor is drawn.
 * The CSS node for a context menu is added as a subnode with the name `popup`.
 * The `undershoot` nodes are used to draw the underflow indication when content
 * is scrolled out of view. These nodes get the `.left` or `.right` style class
 * added depending on where the indication is drawn.
 * When touch is used and touch selection handles are shown, they are using
 * CSS nodes with name `cursor-handle`. They get the `.top` or `.bottom` style
 * class depending on where they are shown in relation to the selection. If
 * there is just a single handle for the text cursor, it gets the style class
 * `.insertion-cursor`.
 * # Accessibility
 * `GtkText` uses the %GTK_ACCESSIBLE_ROLE_NONE role, which causes it to be
 * skipped for accessibility. This is because `GtkText` is expected to be used
 * as a delegate for a `GtkEditable` implementation that will be represented
 * to accessibility.
 */
class Text : Widget, AccessibleText, Editable
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return gtk_text_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin AccessibleTextT!GtkText;
  mixin EditableT!GtkText;

  /**
   * Creates a new `GtkText`.
   * Returns: a new `GtkText`.
   */
  this()
  {
    GtkWidget* _cretval;
    _cretval = gtk_text_new();
    this(_cretval, false);
  }

  /**
   * Creates a new `GtkText` with the specified text buffer.
   * Params:
   *   buffer = The buffer to use for the new `GtkText`.
   * Returns: a new `GtkText`
   */
  static Text newWithBuffer(EntryBuffer buffer)
  {
    GtkWidget* _cretval;
    _cretval = gtk_text_new_with_buffer(buffer ? cast(GtkEntryBuffer*)buffer.cPtr(false) : null);
    auto _retval = _cretval ? ObjectG.getDObject!Text(cast(GtkWidget*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Determine the positions of the strong and weak cursors if the
   * insertion point in the layout is at position.
   * The position of each cursor is stored as a zero-width rectangle.
   * The strong cursor location is the location where characters of
   * the directionality equal to the base direction are inserted.
   * The weak cursor location is the location where characters of
   * the directionality opposite to the base direction are inserted.
   * The rectangle positions are in widget coordinates.
   * Params:
   *   position = the character position
   *   strong = location to store the strong cursor position
   *   weak = location to store the weak cursor position
   */
  void computeCursorExtents(size_t position, out Rect strong, out Rect weak)
  {
    graphene_rect_t _strong;
    graphene_rect_t _weak;
    gtk_text_compute_cursor_extents(cast(GtkText*)cPtr, position, &_strong, &_weak);
    strong = new Rect(cast(void*)&_strong, false);
    weak = new Rect(cast(void*)&_weak, false);
  }

  /**
   * Returns whether pressing Enter will activate
   * the default widget for the window containing self.
   * See [Gtk.Text.setActivatesDefault].
   * Returns: %TRUE if the `GtkText` will activate the default widget
   */
  bool getActivatesDefault()
  {
    bool _retval;
    _retval = gtk_text_get_activates_default(cast(GtkText*)cPtr);
    return _retval;
  }

  /**
   * Gets the attribute list that was set on the `GtkText`.
   * See [Gtk.Text.setAttributes].
   * Returns: the attribute list
   */
  AttrList getAttributes()
  {
    PangoAttrList* _cretval;
    _cretval = gtk_text_get_attributes(cast(GtkText*)cPtr);
    auto _retval = _cretval ? new AttrList(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Get the `GtkEntryBuffer` object which holds the text for
   * this widget.
   * Returns: A `GtkEntryBuffer` object.
   */
  EntryBuffer getBuffer()
  {
    GtkEntryBuffer* _cretval;
    _cretval = gtk_text_get_buffer(cast(GtkText*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!EntryBuffer(cast(GtkEntryBuffer*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns whether Emoji completion is enabled for this
   * `GtkText` widget.
   * Returns: %TRUE if Emoji completion is enabled
   */
  bool getEnableEmojiCompletion()
  {
    bool _retval;
    _retval = gtk_text_get_enable_emoji_completion(cast(GtkText*)cPtr);
    return _retval;
  }

  /**
   * Gets the menu model for extra items in the context menu.
   * See [Gtk.Text.setExtraMenu].
   * Returns: the menu model
   */
  MenuModel getExtraMenu()
  {
    GMenuModel* _cretval;
    _cretval = gtk_text_get_extra_menu(cast(GtkText*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!MenuModel(cast(GMenuModel*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the input hints of the `GtkText`.
   * Returns:
   */
  InputHints getInputHints()
  {
    GtkInputHints _cretval;
    _cretval = gtk_text_get_input_hints(cast(GtkText*)cPtr);
    InputHints _retval = cast(InputHints)_cretval;
    return _retval;
  }

  /**
   * Gets the input purpose of the `GtkText`.
   * Returns:
   */
  InputPurpose getInputPurpose()
  {
    GtkInputPurpose _cretval;
    _cretval = gtk_text_get_input_purpose(cast(GtkText*)cPtr);
    InputPurpose _retval = cast(InputPurpose)_cretval;
    return _retval;
  }

  /**
   * Retrieves the character displayed when visibility is set to false.
   * Note that GTK does not compute this value unless it needs it,
   * so the value returned by this function is not very useful unless
   * it has been explicitly set with [Gtk.Text.setInvisibleChar].
   * Returns: the current invisible char, or 0, if text does not
   *   show invisible text at all.
   */
  dchar getInvisibleChar()
  {
    dchar _retval;
    _retval = gtk_text_get_invisible_char(cast(GtkText*)cPtr);
    return _retval;
  }

  /**
   * Retrieves the maximum allowed length of the text in self.
   * See [Gtk.Text.setMaxLength].
   * This is equivalent to getting self's `GtkEntryBuffer` and
   * calling [Gtk.EntryBuffer.getMaxLength] on it.
   * Returns: the maximum allowed number of characters
   *   in `GtkText`, or 0 if there is no maximum.
   */
  int getMaxLength()
  {
    int _retval;
    _retval = gtk_text_get_max_length(cast(GtkText*)cPtr);
    return _retval;
  }

  /**
   * Gets whether text is overwritten when typing in the `GtkText`.
   * See [Gtk.Text.setOverwriteMode].
   * Returns: whether the text is overwritten when typing
   */
  bool getOverwriteMode()
  {
    bool _retval;
    _retval = gtk_text_get_overwrite_mode(cast(GtkText*)cPtr);
    return _retval;
  }

  /**
   * Retrieves the text that will be displayed when
   * self is empty and unfocused
   * If no placeholder text has been set, %NULL will be returned.
   * Returns: the placeholder text
   */
  string getPlaceholderText()
  {
    const(char)* _cretval;
    _cretval = gtk_text_get_placeholder_text(cast(GtkText*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Returns whether the `GtkText` will grow and shrink
   * with the content.
   * Returns: %TRUE if self will propagate the text width
   */
  bool getPropagateTextWidth()
  {
    bool _retval;
    _retval = gtk_text_get_propagate_text_width(cast(GtkText*)cPtr);
    return _retval;
  }

  /**
   * Gets the tabstops that were set on the `GtkText`.
   * See [Gtk.Text.setTabs].
   * Returns: the tabstops
   */
  TabArray getTabs()
  {
    PangoTabArray* _cretval;
    _cretval = gtk_text_get_tabs(cast(GtkText*)cPtr);
    auto _retval = _cretval ? new TabArray(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Retrieves the current length of the text in self.
   * This is equivalent to getting self's `GtkEntryBuffer`
   * and calling [Gtk.EntryBuffer.getLength] on it.
   * Returns: the current number of characters
   *   in `GtkText`, or 0 if there are none.
   */
  ushort getTextLength()
  {
    ushort _retval;
    _retval = gtk_text_get_text_length(cast(GtkText*)cPtr);
    return _retval;
  }

  /**
   * Returns whether the `GtkText` will truncate multi-line text
   * that is pasted into the widget
   * Returns: %TRUE if self will truncate multi-line text
   */
  bool getTruncateMultiline()
  {
    bool _retval;
    _retval = gtk_text_get_truncate_multiline(cast(GtkText*)cPtr);
    return _retval;
  }

  /**
   * Retrieves whether the text in self is visible.
   * Returns: %TRUE if the text is currently visible
   */
  bool getVisibility()
  {
    bool _retval;
    _retval = gtk_text_get_visibility(cast(GtkText*)cPtr);
    return _retval;
  }

  /**
   * Causes self to have keyboard focus.
   * It behaves like [Gtk.Widget.grabFocus],
   * except that it doesn't select the contents of self.
   * You only want to call this on some special entries
   * which the user usually doesn't want to replace all text in,
   * such as search-as-you-type entries.
   * Returns: %TRUE if focus is now inside self
   */
  bool grabFocusWithoutSelecting()
  {
    bool _retval;
    _retval = gtk_text_grab_focus_without_selecting(cast(GtkText*)cPtr);
    return _retval;
  }

  /**
   * If activates is %TRUE, pressing Enter will activate
   * the default widget for the window containing self.
   * This usually means that the dialog containing the `GtkText`
   * will be closed, since the default widget is usually one of
   * the dialog buttons.
   * Params:
   *   activates = %TRUE to activate window’s default widget on Enter keypress
   */
  void setActivatesDefault(bool activates)
  {
    gtk_text_set_activates_default(cast(GtkText*)cPtr, activates);
  }

  /**
   * Sets attributes that are applied to the text.
   * Params:
   *   attrs = a `PangoAttrList`
   */
  void setAttributes(AttrList attrs)
  {
    gtk_text_set_attributes(cast(GtkText*)cPtr, attrs ? cast(PangoAttrList*)attrs.cPtr(false) : null);
  }

  /**
   * Set the `GtkEntryBuffer` object which holds the text for
   * this widget.
   * Params:
   *   buffer = a `GtkEntryBuffer`
   */
  void setBuffer(EntryBuffer buffer)
  {
    gtk_text_set_buffer(cast(GtkText*)cPtr, buffer ? cast(GtkEntryBuffer*)buffer.cPtr(false) : null);
  }

  /**
   * Sets whether Emoji completion is enabled.
   * If it is, typing ':', followed by a recognized keyword,
   * will pop up a window with suggested Emojis matching the
   * keyword.
   * Params:
   *   enableEmojiCompletion = %TRUE to enable Emoji completion
   */
  void setEnableEmojiCompletion(bool enableEmojiCompletion)
  {
    gtk_text_set_enable_emoji_completion(cast(GtkText*)cPtr, enableEmojiCompletion);
  }

  /**
   * Sets a menu model to add when constructing
   * the context menu for self.
   * Params:
   *   model = a `GMenuModel`
   */
  void setExtraMenu(MenuModel model)
  {
    gtk_text_set_extra_menu(cast(GtkText*)cPtr, model ? cast(GMenuModel*)model.cPtr(false) : null);
  }

  /**
   * Sets input hints that allow input methods
   * to fine-tune their behaviour.
   * Params:
   *   hints = the hints
   */
  void setInputHints(InputHints hints)
  {
    gtk_text_set_input_hints(cast(GtkText*)cPtr, hints);
  }

  /**
   * Sets the input purpose of the `GtkText`.
   * This can be used by on-screen keyboards and other
   * input methods to adjust their behaviour.
   * Params:
   *   purpose = the purpose
   */
  void setInputPurpose(InputPurpose purpose)
  {
    gtk_text_set_input_purpose(cast(GtkText*)cPtr, purpose);
  }

  /**
   * Sets the character to use when in “password mode”.
   * By default, GTK picks the best invisible char available in the
   * current font. If you set the invisible char to 0, then the user
   * will get no feedback at all; there will be no text on the screen
   * as they type.
   * Params:
   *   ch = a Unicode character
   */
  void setInvisibleChar(dchar ch)
  {
    gtk_text_set_invisible_char(cast(GtkText*)cPtr, ch);
  }

  /**
   * Sets the maximum allowed length of the contents of the widget.
   * If the current contents are longer than the given length, then
   * they will be truncated to fit.
   * This is equivalent to getting self's `GtkEntryBuffer` and
   * calling [Gtk.EntryBuffer.setMaxLength] on it.
   * Params:
   *   length = the maximum length of the `GtkText`, or 0 for no maximum.
   *     $(LPAREN)other than the maximum length of entries.$(RPAREN) The value passed
   *     in will be clamped to the range 0-65536.
   */
  void setMaxLength(int length)
  {
    gtk_text_set_max_length(cast(GtkText*)cPtr, length);
  }

  /**
   * Sets whether the text is overwritten when typing
   * in the `GtkText`.
   * Params:
   *   overwrite = new value
   */
  void setOverwriteMode(bool overwrite)
  {
    gtk_text_set_overwrite_mode(cast(GtkText*)cPtr, overwrite);
  }

  /**
   * Sets text to be displayed in self when it is empty.
   * This can be used to give a visual hint of the expected
   * contents of the `GtkText`.
   * Params:
   *   text = a string to be displayed when self
   *     is empty and unfocused
   */
  void setPlaceholderText(string text)
  {
    const(char)* _text = text.toCString(false);
    gtk_text_set_placeholder_text(cast(GtkText*)cPtr, _text);
  }

  /**
   * Sets whether the `GtkText` should grow and shrink with the content.
   * Params:
   *   propagateTextWidth = %TRUE to propagate the text width
   */
  void setPropagateTextWidth(bool propagateTextWidth)
  {
    gtk_text_set_propagate_text_width(cast(GtkText*)cPtr, propagateTextWidth);
  }

  /**
   * Sets tabstops that are applied to the text.
   * Params:
   *   tabs = a `PangoTabArray`
   */
  void setTabs(TabArray tabs)
  {
    gtk_text_set_tabs(cast(GtkText*)cPtr, tabs ? cast(PangoTabArray*)tabs.cPtr(false) : null);
  }

  /**
   * Sets whether the `GtkText` should truncate multi-line text
   * that is pasted into the widget.
   * Params:
   *   truncateMultiline = %TRUE to truncate multi-line text
   */
  void setTruncateMultiline(bool truncateMultiline)
  {
    gtk_text_set_truncate_multiline(cast(GtkText*)cPtr, truncateMultiline);
  }

  /**
   * Sets whether the contents of the `GtkText` are visible or not.
   * When visibility is set to %FALSE, characters are displayed
   * as the invisible char, and will also appear that way when
   * the text in the widget is copied to the clipboard.
   * By default, GTK picks the best invisible character available
   * in the current font, but it can be changed with
   * [Gtk.Text.setInvisibleChar].
   * Note that you probably want to set propertyGtk.Text:input-purpose
   * to %GTK_INPUT_PURPOSE_PASSWORD or %GTK_INPUT_PURPOSE_PIN to
   * inform input methods about the purpose of this self,
   * in addition to setting visibility to %FALSE.
   * Params:
   *   visible = %TRUE if the contents of the `GtkText` are displayed
   *     as plaintext
   */
  void setVisibility(bool visible)
  {
    gtk_text_set_visibility(cast(GtkText*)cPtr, visible);
  }

  /**
   * Unsets the invisible char.
   * After calling this, the default invisible
   * char is used again.
   */
  void unsetInvisibleChar()
  {
    gtk_text_unset_invisible_char(cast(GtkText*)cPtr);
  }

  /**
   * Emitted when the user hits the <kbd>Enter</kbd> key.
   * The default bindings for this signal are all forms
   * of the <kbd>Enter</kbd> key.
   *   text = the instance the signal is connected to
   */
  alias ActivateCallback = void delegate(Text text);

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
      auto text = getVal!Text(_paramVals);
      _dgClosure.dlg(text);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("activate", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * Emitted when the user asks for it.
   * This is a [keybinding signal](class.SignalAction.html).
   * The default bindings for this signal are
   * <kbd>Backspace</kbd> and <kbd>Shift</kbd>+<kbd>Backspace</kbd>.
   *   text = the instance the signal is connected to
   */
  alias BackspaceCallback = void delegate(Text text);

  /**
   * Connect to Backspace signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectBackspace(BackspaceCallback dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto text = getVal!Text(_paramVals);
      _dgClosure.dlg(text);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("backspace", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * Emitted to copy the selection to the clipboard.
   * This is a [keybinding signal](class.SignalAction.html).
   * The default bindings for this signal are
   * <kbd>Ctrl</kbd>+<kbd>c</kbd> and
   * <kbd>Ctrl</kbd>+<kbd>Insert</kbd>.
   *   text = the instance the signal is connected to
   */
  alias CopyClipboardCallback = void delegate(Text text);

  /**
   * Connect to CopyClipboard signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectCopyClipboard(CopyClipboardCallback dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto text = getVal!Text(_paramVals);
      _dgClosure.dlg(text);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("copy-clipboard", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * Emitted to cut the selection to the clipboard.
   * This is a [keybinding signal](class.SignalAction.html).
   * The default bindings for this signal are
   * <kbd>Ctrl</kbd>+<kbd>x</kbd> and
   * <kbd>Shift</kbd>+<kbd>Delete</kbd>.
   *   text = the instance the signal is connected to
   */
  alias CutClipboardCallback = void delegate(Text text);

  /**
   * Connect to CutClipboard signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectCutClipboard(CutClipboardCallback dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto text = getVal!Text(_paramVals);
      _dgClosure.dlg(text);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("cut-clipboard", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * Emitted when the user initiates a text deletion.
   * This is a [keybinding signal](class.SignalAction.html).
   * If the type is %GTK_DELETE_CHARS, GTK deletes the selection
   * if there is one, otherwise it deletes the requested number
   * of characters.
   * The default bindings for this signal are <kbd>Delete</kbd>
   * for deleting a character and <kbd>Ctrl</kbd>+<kbd>Delete</kbd>
   * for deleting a word.
   * Params
   *   type = the granularity of the deletion, as a `GtkDeleteType`
   *   count = the number of type units to delete
   *   text = the instance the signal is connected to
   */
  alias DeleteFromCursorCallback = void delegate(DeleteType type, int count, Text text);

  /**
   * Connect to DeleteFromCursor signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectDeleteFromCursor(DeleteFromCursorCallback dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 3, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto text = getVal!Text(_paramVals);
      auto type = getVal!DeleteType(&_paramVals[1]);
      auto count = getVal!int(&_paramVals[2]);
      _dgClosure.dlg(type, count, text);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("delete-from-cursor", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * Emitted when the user initiates the insertion of a
   * fixed string at the cursor.
   * This is a [keybinding signal](class.SignalAction.html).
   * This signal has no default bindings.
   * Params
   *   string_ = the string to insert
   *   text = the instance the signal is connected to
   */
  alias InsertAtCursorCallback = void delegate(string string_, Text text);

  /**
   * Connect to InsertAtCursor signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectInsertAtCursor(InsertAtCursorCallback dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto text = getVal!Text(_paramVals);
      auto string_ = getVal!string(&_paramVals[1]);
      _dgClosure.dlg(string_, text);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("insert-at-cursor", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * Emitted to present the Emoji chooser for the widget.
   * This is a [keybinding signal](class.SignalAction.html).
   * The default bindings for this signal are
   * <kbd>Ctrl</kbd>+<kbd>.</kbd> and
   * <kbd>Ctrl</kbd>+<kbd>;</kbd>
   *   text = the instance the signal is connected to
   */
  alias InsertEmojiCallback = void delegate(Text text);

  /**
   * Connect to InsertEmoji signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectInsertEmoji(InsertEmojiCallback dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto text = getVal!Text(_paramVals);
      _dgClosure.dlg(text);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("insert-emoji", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * Emitted when the user initiates a cursor movement.
   * If the cursor is not visible in self, this signal causes
   * the viewport to be moved instead.
   * This is a [keybinding signal](class.SignalAction.html).
   * Applications should not connect to it, but may emit it with
   * [GObject.Global.signalEmitByName] if they need to control the cursor
   * programmatically.
   * The default bindings for this signal come in two variants,
   * the variant with the <kbd>Shift</kbd> modifier extends the
   * selection, the variant without it does not.
   * There are too many key combinations to list them all here.
   * - <kbd>←</kbd>, <kbd>→</kbd>, <kbd>↑</kbd>, <kbd>↓</kbd>
   * move by individual characters/lines
   * - <kbd>Ctrl</kbd>+<kbd>←</kbd>, etc. move by words/paragraphs
   * - <kbd>Home</kbd> and <kbd>End</kbd> move to the ends of the buffer
   * Params
   *   step = the granularity of the move, as a `GtkMovementStep`
   *   count = the number of step units to move
   *   extend = %TRUE if the move should extend the selection
   *   text = the instance the signal is connected to
   */
  alias MoveCursorCallback = void delegate(MovementStep step, int count, bool extend, Text text);

  /**
   * Connect to MoveCursor signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectMoveCursor(MoveCursorCallback dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 4, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto text = getVal!Text(_paramVals);
      auto step = getVal!MovementStep(&_paramVals[1]);
      auto count = getVal!int(&_paramVals[2]);
      auto extend = getVal!bool(&_paramVals[3]);
      _dgClosure.dlg(step, count, extend, text);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("move-cursor", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * Emitted to paste the contents of the clipboard.
   * This is a [keybinding signal](class.SignalAction.html).
   * The default bindings for this signal are
   * <kbd>Ctrl</kbd>+<kbd>v</kbd> and <kbd>Shift</kbd>+<kbd>Insert</kbd>.
   *   text = the instance the signal is connected to
   */
  alias PasteClipboardCallback = void delegate(Text text);

  /**
   * Connect to PasteClipboard signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectPasteClipboard(PasteClipboardCallback dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto text = getVal!Text(_paramVals);
      _dgClosure.dlg(text);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("paste-clipboard", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * Emitted when the preedit text changes.
   * If an input method is used, the typed text will not immediately
   * be committed to the buffer. So if you are interested in the text,
   * connect to this signal.
   * Params
   *   preedit = the current preedit string
   *   text = the instance the signal is connected to
   */
  alias PreeditChangedCallback = void delegate(string preedit, Text text);

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
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto text = getVal!Text(_paramVals);
      auto preedit = getVal!string(&_paramVals[1]);
      _dgClosure.dlg(preedit, text);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("preedit-changed", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * Emitted to toggle the overwrite mode of the `GtkText`.
   * This is a [keybinding signal](class.SignalAction.html).
   * The default bindings for this signal is <kbd>Insert</kbd>.
   *   text = the instance the signal is connected to
   */
  alias ToggleOverwriteCallback = void delegate(Text text);

  /**
   * Connect to ToggleOverwrite signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectToggleOverwrite(ToggleOverwriteCallback dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto text = getVal!Text(_paramVals);
      _dgClosure.dlg(text);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("toggle-overwrite", closure, (flags & ConnectFlags.After) != 0);
  }
}
