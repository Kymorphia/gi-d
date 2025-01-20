module Gtk.EditableT;

public import Gtk.EditableIfaceProxy;
public import GObject.DClosure;
public import GObject.ObjectClass;
public import GObject.ObjectG;
public import GObject.ParamSpec;
public import GObject.Value;
public import Gid.gid;
public import Gtk.Types;
public import Gtk.c.functions;
public import Gtk.c.types;

/**
 * `GtkEditable` is an interface for text editing widgets.
 * Typical examples of editable widgets are [Gtk.Entry] and
 * [Gtk.SpinButton]. It contains functions for generically manipulating
 * an editable widget, a large number of action signals used for key bindings,
 * and several signals that an application can connect to modify the behavior
 * of a widget.
 * As an example of the latter usage, by connecting the following handler to
 * signal@Gtk.Editable::insert-text, an application can convert all entry
 * into a widget into uppercase.
 * ## Forcing entry to uppercase.
 * ```c
 * #include <ctype.h>
 * void
 * insert_text_handler $(LPAREN)GtkEditable *editable,
 * const char  *text,
 * int          length,
 * int         *position,
 * gpointer     data$(RPAREN)
 * {
 * char *result \= g_utf8_strup $(LPAREN)text, length$(RPAREN);
 * g_signal_handlers_block_by_func $(LPAREN)editable,
 * $(LPAREN)gpointer$(RPAREN) insert_text_handler, data$(RPAREN);
 * gtk_editable_insert_text $(LPAREN)editable, result, length, position$(RPAREN);
 * g_signal_handlers_unblock_by_func $(LPAREN)editable,
 * $(LPAREN)gpointer$(RPAREN) insert_text_handler, data$(RPAREN);
 * g_signal_stop_emission_by_name $(LPAREN)editable, "insert_text"$(RPAREN);
 * g_free $(LPAREN)result$(RPAREN);
 * }
 * ```
 * ## Implementing GtkEditable
 * The most likely scenario for implementing `GtkEditable` on your own widget
 * is that you will embed a `GtkText` inside a complex widget, and want to
 * delegate the editable functionality to that text widget. `GtkEditable`
 * provides some utility functions to make this easy.
 * In your class_init function, call [Gtk.Editable.installProperties],
 * passing the first available property ID:
 * ```c
 * static void
 * my_class_init $(LPAREN)MyClass *class$(RPAREN)
 * {
 * ...
 * g_object_class_install_properties $(LPAREN)object_class, NUM_PROPERTIES, props$(RPAREN);
 * gtk_editable_install_properties $(LPAREN)object_clas, NUM_PROPERTIES$(RPAREN);
 * ...
 * }
 * ```
 * In your interface_init function for the `GtkEditable` interface, provide
 * an implementation for the get_delegate vfunc that returns your text widget:
 * ```c
 * GtkEditable *
 * get_editable_delegate $(LPAREN)GtkEditable *editable$(RPAREN)
 * {
 * return GTK_EDITABLE $(LPAREN)MY_WIDGET $(LPAREN)editable$(RPAREN)->text_widget$(RPAREN);
 * }
 * static void
 * my_editable_init $(LPAREN)GtkEditableInterface *iface$(RPAREN)
 * {
 * iface->get_delegate \= get_editable_delegate;
 * }
 * ```
 * You don't need to provide any other vfuncs. The default implementations
 * work by forwarding to the delegate that the GtkEditableInterface.get_delegate$(LPAREN)$(RPAREN)
 * vfunc returns.
 * In your instance_init function, create your text widget, and then call
 * [Gtk.Editable.initDelegate]:
 * ```c
 * static void
 * my_widget_init $(LPAREN)MyWidget *self$(RPAREN)
 * {
 * ...
 * self->text_widget \= gtk_text_new $(LPAREN)$(RPAREN);
 * gtk_editable_init_delegate $(LPAREN)GTK_EDITABLE $(LPAREN)self$(RPAREN)$(RPAREN);
 * ...
 * }
 * ```
 * In your dispose function, call [Gtk.Editable.finishDelegate] before
 * destroying your text widget:
 * ```c
 * static void
 * my_widget_dispose $(LPAREN)GObject *object$(RPAREN)
 * {
 * ...
 * gtk_editable_finish_delegate $(LPAREN)GTK_EDITABLE $(LPAREN)self$(RPAREN)$(RPAREN);
 * g_clear_pointer $(LPAREN)&self->text_widget, gtk_widget_unparent$(RPAREN);
 * ...
 * }
 * ```
 * Finally, use [Gtk.Editable.delegateSetProperty] in your `set_property`
 * function $(LPAREN)and similar for `get_property`$(RPAREN), to set the editable properties:
 * ```c
 * ...
 * if $(LPAREN)gtk_editable_delegate_set_property $(LPAREN)object, prop_id, value, pspec$(RPAREN)$(RPAREN)
 * return;
 * switch $(LPAREN)prop_id$(RPAREN)
 * ...
 * ```
 * It is important to note that if you create a `GtkEditable` that uses
 * a delegate, the low level signal@Gtk.Editable::insert-text and
 * signal@Gtk.Editable::delete-text signals will be propagated from the
 * "wrapper" editable to the delegate, but they will not be propagated from
 * the delegate to the "wrapper" editable, as they would cause an infinite
 * recursion. If you wish to connect to the signal@Gtk.Editable::insert-text
 * and signal@Gtk.Editable::delete-text signals, you will need to connect
 * to them on the delegate obtained via [Gtk.Editable.getDelegate].
 */
template EditableT()
{




  /**
   * Retrieves the accessible platform state from the editable delegate.
   * This is an helper function to retrieve the accessible state for
   * `GtkEditable` interface implementations using a delegate pattern.
   * You should call this function in your editable widget implementation
   * of the vfuncGtk.Accessible.get_platform_state virtual function, for
   * instance:
   * ```c
   * static void
   * accessible_interface_init $(LPAREN)GtkAccessibleInterface *iface$(RPAREN)
   * {
   * iface->get_platform_state \= your_editable_get_accessible_platform_state;
   * }
   * static gboolean
   * your_editable_get_accessible_platform_state $(LPAREN)GtkAccessible *accessible,
   * GtkAccessiblePlatformState state$(RPAREN)
   * {
   * return gtk_editable_delegate_get_accessible_platform_state $(LPAREN)GTK_EDITABLE $(LPAREN)accessible$(RPAREN), state$(RPAREN);
   * }
   * ```
   * Params:
   *   state = what kind of accessible state to retrieve
   * Returns:
   */
  override bool delegateGetAccessiblePlatformState(AccessiblePlatformState state)
  {
    bool _retval;
    _retval = gtk_editable_delegate_get_accessible_platform_state(cast(GtkEditable*)cPtr, state);
    return _retval;
  }

  /**
   * Deletes the currently selected text of the editable.
   * This call doesn’t do anything if there is no selected text.
   */
  override void deleteSelection()
  {
    gtk_editable_delete_selection(cast(GtkEditable*)cPtr);
  }

  /**
   * Deletes a sequence of characters.
   * The characters that are deleted are those characters at positions
   * from start_pos up to, but not including end_pos. If end_pos is
   * negative, then the characters deleted are those from start_pos to
   * the end of the text.
   * Note that the positions are specified in characters, not bytes.
   * Params:
   *   startPos = start position
   *   endPos = end position
   */
  override void deleteText(int startPos, int endPos)
  {
    gtk_editable_delete_text(cast(GtkEditable*)cPtr, startPos, endPos);
  }

  /**
   * Undoes the setup done by [Gtk.Editable.initDelegate].
   * This is a helper function that should be called from dispose,
   * before removing the delegate object.
   */
  override void finishDelegate()
  {
    gtk_editable_finish_delegate(cast(GtkEditable*)cPtr);
  }

  /**
   * Gets the alignment of the editable.
   * Returns: the alignment
   */
  override float getAlignment()
  {
    float _retval;
    _retval = gtk_editable_get_alignment(cast(GtkEditable*)cPtr);
    return _retval;
  }

  /**
   * Retrieves a sequence of characters.
   * The characters that are retrieved are those characters at positions
   * from start_pos up to, but not including end_pos. If end_pos is negative,
   * then the characters retrieved are those characters from start_pos to
   * the end of the text.
   * Note that positions are specified in characters, not bytes.
   * Params:
   *   startPos = start of text
   *   endPos = end of text
   * Returns: a pointer to the contents of the widget as a
   *   string. This string is allocated by the `GtkEditable` implementation
   *   and should be freed by the caller.
   */
  override string getChars(int startPos, int endPos)
  {
    char* _cretval;
    _cretval = gtk_editable_get_chars(cast(GtkEditable*)cPtr, startPos, endPos);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * Gets the `GtkEditable` that editable is delegating its
   * implementation to.
   * Typically, the delegate is a [Gtk.Text] widget.
   * Returns: the delegate `GtkEditable`
   */
  override Editable getDelegate()
  {
    GtkEditable* _cretval;
    _cretval = gtk_editable_get_delegate(cast(GtkEditable*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Editable(cast(GtkEditable*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Retrieves whether editable is editable.
   * Returns: %TRUE if editable is editable.
   */
  override bool getEditable()
  {
    bool _retval;
    _retval = gtk_editable_get_editable(cast(GtkEditable*)cPtr);
    return _retval;
  }

  /**
   * Gets if undo/redo actions are enabled for editable
   * Returns: %TRUE if undo is enabled
   */
  override bool getEnableUndo()
  {
    bool _retval;
    _retval = gtk_editable_get_enable_undo(cast(GtkEditable*)cPtr);
    return _retval;
  }

  /**
   * Retrieves the desired maximum width of editable, in characters.
   * Returns: the maximum width of the entry, in characters
   */
  override int getMaxWidthChars()
  {
    int _retval;
    _retval = gtk_editable_get_max_width_chars(cast(GtkEditable*)cPtr);
    return _retval;
  }

  /**
   * Retrieves the current position of the cursor relative
   * to the start of the content of the editable.
   * Note that this position is in characters, not in bytes.
   * Returns: the cursor position
   */
  override int getPosition()
  {
    int _retval;
    _retval = gtk_editable_get_position(cast(GtkEditable*)cPtr);
    return _retval;
  }

  /**
   * Retrieves the selection bound of the editable.
   * start_pos will be filled with the start of the selection and
   * end_pos with end. If no text was selected both will be identical
   * and %FALSE will be returned.
   * Note that positions are specified in characters, not bytes.
   * Params:
   *   startPos = location to store the starting position
   *   endPos = location to store the end position
   * Returns: %TRUE if there is a non-empty selection, %FALSE otherwise
   */
  override bool getSelectionBounds(out int startPos, out int endPos)
  {
    bool _retval;
    _retval = gtk_editable_get_selection_bounds(cast(GtkEditable*)cPtr, cast(int*)&startPos, cast(int*)&endPos);
    return _retval;
  }

  /**
   * Retrieves the contents of editable.
   * The returned string is owned by GTK and must not be modified or freed.
   * Returns: a pointer to the contents of the editable
   */
  override string getText()
  {
    const(char)* _cretval;
    _cretval = gtk_editable_get_text(cast(GtkEditable*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Gets the number of characters of space reserved
   * for the contents of the editable.
   * Returns: number of chars to request space for, or negative if unset
   */
  override int getWidthChars()
  {
    int _retval;
    _retval = gtk_editable_get_width_chars(cast(GtkEditable*)cPtr);
    return _retval;
  }

  /**
   * Sets up a delegate for `GtkEditable`.
   * This is assuming that the get_delegate vfunc in the `GtkEditable`
   * interface has been set up for the editable's type.
   * This is a helper function that should be called in instance init,
   * after creating the delegate object.
   */
  override void initDelegate()
  {
    gtk_editable_init_delegate(cast(GtkEditable*)cPtr);
  }

  /**
   * Inserts length bytes of text into the contents of the
   * widget, at position position.
   * Note that the position is in characters, not in bytes.
   * The function updates position to point after the newly
   * inserted text.
   * Params:
   *   text = the text to insert
   *   length = the length of the text in bytes, or -1
   *   position = location of the position text will be inserted at
   */
  override void insertText(string text, int length, ref int position)
  {
    const(char)* _text = text.toCString(false);
    gtk_editable_insert_text(cast(GtkEditable*)cPtr, _text, length, cast(int*)&position);
  }

  /**
   * Selects a region of text.
   * The characters that are selected are those characters at positions
   * from start_pos up to, but not including end_pos. If end_pos is
   * negative, then the characters selected are those characters from
   * start_pos to  the end of the text.
   * Note that positions are specified in characters, not bytes.
   * Params:
   *   startPos = start of region
   *   endPos = end of region
   */
  override void selectRegion(int startPos, int endPos)
  {
    gtk_editable_select_region(cast(GtkEditable*)cPtr, startPos, endPos);
  }

  /**
   * Sets the alignment for the contents of the editable.
   * This controls the horizontal positioning of the contents when
   * the displayed text is shorter than the width of the editable.
   * Params:
   *   xalign = The horizontal alignment, from 0 $(LPAREN)left$(RPAREN) to 1 $(LPAREN)right$(RPAREN).
   *     Reversed for RTL layouts
   */
  override void setAlignment(float xalign)
  {
    gtk_editable_set_alignment(cast(GtkEditable*)cPtr, xalign);
  }

  /**
   * Determines if the user can edit the text in the editable widget.
   * Params:
   *   isEditable = %TRUE if the user is allowed to edit the text
   *     in the widget
   */
  override void setEditable(bool isEditable)
  {
    gtk_editable_set_editable(cast(GtkEditable*)cPtr, isEditable);
  }

  /**
   * If enabled, changes to editable will be saved for undo/redo
   * actions.
   * This results in an additional copy of text changes and are not
   * stored in secure memory. As such, undo is forcefully disabled
   * when [Gtk.Text.visibility] is set to %FALSE.
   * Params:
   *   enableUndo = if undo/redo should be enabled
   */
  override void setEnableUndo(bool enableUndo)
  {
    gtk_editable_set_enable_undo(cast(GtkEditable*)cPtr, enableUndo);
  }

  /**
   * Sets the desired maximum width in characters of editable.
   * Params:
   *   nChars = the new desired maximum width, in characters
   */
  override void setMaxWidthChars(int nChars)
  {
    gtk_editable_set_max_width_chars(cast(GtkEditable*)cPtr, nChars);
  }

  /**
   * Sets the cursor position in the editable to the given value.
   * The cursor is displayed before the character with the given $(LPAREN)base 0$(RPAREN)
   * index in the contents of the editable. The value must be less than
   * or equal to the number of characters in the editable. A value of -1
   * indicates that the position should be set after the last character
   * of the editable. Note that position is in characters, not in bytes.
   * Params:
   *   position = the position of the cursor
   */
  override void setPosition(int position)
  {
    gtk_editable_set_position(cast(GtkEditable*)cPtr, position);
  }

  /**
   * Sets the text in the editable to the given value.
   * This is replacing the current contents.
   * Params:
   *   text = the text to set
   */
  override void setText(string text)
  {
    const(char)* _text = text.toCString(false);
    gtk_editable_set_text(cast(GtkEditable*)cPtr, _text);
  }

  /**
   * Changes the size request of the editable to be about the
   * right size for n_chars characters.
   * Note that it changes the size request, the size can still
   * be affected by how you pack the widget into containers.
   * If n_chars is -1, the size reverts to the default size.
   * Params:
   *   nChars = width in chars
   */
  override void setWidthChars(int nChars)
  {
    gtk_editable_set_width_chars(cast(GtkEditable*)cPtr, nChars);
  }

  /**
   * Emitted at the end of a single user-visible operation on the
   * contents.
   * E.g., a paste operation that replaces the contents of the
   * selection will cause only one signal emission $(LPAREN)even though it
   * is implemented by first deleting the selection, then inserting
   * the new content, and may cause multiple ::notify::text signals
   * to be emitted$(RPAREN).
   *   editable = the instance the signal is connected to
   */
  alias ChangedCallback = void delegate(Editable editable);

  /**
   * Connect to Changed signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectChanged(ChangedCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto editable = getVal!Editable(_paramVals);
      _dgClosure.dlg(editable);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("changed", closure, after);
  }

  /**
   * Emitted when text is deleted from the widget by the user.
   * The default handler for this signal will normally be responsible for
   * deleting the text, so by connecting to this signal and then stopping
   * the signal with [GObject.Global.signalStopEmission], it is possible to modify the
   * range of deleted text, or prevent it from being deleted entirely.
   * The start_pos and end_pos parameters are interpreted as for
   * [Gtk.Editable.deleteText].
   * Params
   *   startPos = the starting position
   *   endPos = the end position
   *   editable = the instance the signal is connected to
   */
  alias DeleteTextCallback = void delegate(int startPos, int endPos, Editable editable);

  /**
   * Connect to DeleteText signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectDeleteText(DeleteTextCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 3, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto editable = getVal!Editable(_paramVals);
      auto startPos = getVal!int(&_paramVals[1]);
      auto endPos = getVal!int(&_paramVals[2]);
      _dgClosure.dlg(startPos, endPos, editable);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("delete-text", closure, after);
  }
}
