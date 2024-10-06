module Gtk.EntryBuffer;

import GObject.DClosure;
import GObject.ObjectG;
import GObject.Types;
import Gid.gid;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * A `GtkEntryBuffer` hold the text displayed in a `GtkText` widget.
 * A single `GtkEntryBuffer` object can be shared by multiple widgets
 * which will then share the same text content, but not the cursor
 * position, visibility attributes, icon etc.
 * `GtkEntryBuffer` may be derived from. Such a derived class might allow
 * text to be stored in an alternate location, such as non-pageable memory,
 * useful in the case of important passwords. Or a derived class could
 * integrate with an application’s concept of undo/redo.
 */
class EntryBuffer : ObjectG
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
    return gtk_entry_buffer_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Create a new `GtkEntryBuffer` object.
   * Optionally, specify initial text to set in the buffer.
   * Params:
   *   initialChars = initial buffer text
   *   nInitialChars = number of characters in initial_chars, or -1
   * Returns: A new `GtkEntryBuffer` object.
   */
  this(string initialChars, int nInitialChars)
  {
    GtkEntryBuffer* _cretval;
    const(char)* _initialChars = initialChars.toCString(false);
    _cretval = gtk_entry_buffer_new(_initialChars, nInitialChars);
    this(_cretval, true);
  }

  /**
   * Deletes a sequence of characters from the buffer.
   * n_chars characters are deleted starting at position.
   * If n_chars is negative, then all characters until the
   * end of the text are deleted.
   * If position or n_chars are out of bounds, then they
   * are coerced to sane values.
   * Note that the positions are specified in characters,
   * not bytes.
   * Params:
   *   position = position at which to delete text
   *   nChars = number of characters to delete
   * Returns: The number of characters deleted.
   */
  uint deleteText(uint position, int nChars)
  {
    uint _retval;
    _retval = gtk_entry_buffer_delete_text(cast(GtkEntryBuffer*)cPtr, position, nChars);
    return _retval;
  }

  /**
   * Used when subclassing `GtkEntryBuffer`.
   * Params:
   *   position = position at which text was deleted
   *   nChars = number of characters deleted
   */
  void emitDeletedText(uint position, uint nChars)
  {
    gtk_entry_buffer_emit_deleted_text(cast(GtkEntryBuffer*)cPtr, position, nChars);
  }

  /**
   * Used when subclassing `GtkEntryBuffer`.
   * Params:
   *   position = position at which text was inserted
   *   chars = text that was inserted
   *   nChars = number of characters inserted
   */
  void emitInsertedText(uint position, string chars, uint nChars)
  {
    const(char)* _chars = chars.toCString(false);
    gtk_entry_buffer_emit_inserted_text(cast(GtkEntryBuffer*)cPtr, position, _chars, nChars);
  }

  /**
   * Retrieves the length in bytes of the buffer.
   * See [Gtk.EntryBuffer.getLength].
   * Returns: The byte length of the buffer.
   */
  size_t getBytes()
  {
    size_t _retval;
    _retval = gtk_entry_buffer_get_bytes(cast(GtkEntryBuffer*)cPtr);
    return _retval;
  }

  /**
   * Retrieves the length in characters of the buffer.
   * Returns: The number of characters in the buffer.
   */
  uint getLength()
  {
    uint _retval;
    _retval = gtk_entry_buffer_get_length(cast(GtkEntryBuffer*)cPtr);
    return _retval;
  }

  /**
   * Retrieves the maximum allowed length of the text in buffer.
   * Returns: the maximum allowed number of characters
   *   in `GtkEntryBuffer`, or 0 if there is no maximum.
   */
  int getMaxLength()
  {
    int _retval;
    _retval = gtk_entry_buffer_get_max_length(cast(GtkEntryBuffer*)cPtr);
    return _retval;
  }

  /**
   * Retrieves the contents of the buffer.
   * The memory pointer returned by this call will not change
   * unless this object emits a signal, or is finalized.
   * Returns: a pointer to the contents of the widget as a
   *   string. This string points to internally allocated storage
   *   in the buffer and must not be freed, modified or stored.
   */
  string getText()
  {
    const(char)* _cretval;
    _cretval = gtk_entry_buffer_get_text(cast(GtkEntryBuffer*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Inserts n_chars characters of chars into the contents of the
   * buffer, at position position.
   * If n_chars is negative, then characters from chars will be inserted
   * until a null-terminator is found. If position or n_chars are out of
   * bounds, or the maximum buffer text length is exceeded, then they are
   * coerced to sane values.
   * Note that the position and length are in characters, not in bytes.
   * Params:
   *   position = the position at which to insert text.
   *   chars = the text to insert into the buffer.
   *   nChars = the length of the text in characters, or -1
   * Returns: The number of characters actually inserted.
   */
  uint insertText(uint position, string chars, int nChars)
  {
    uint _retval;
    const(char)* _chars = chars.toCString(false);
    _retval = gtk_entry_buffer_insert_text(cast(GtkEntryBuffer*)cPtr, position, _chars, nChars);
    return _retval;
  }

  /**
   * Sets the maximum allowed length of the contents of the buffer.
   * If the current contents are longer than the given length, then
   * they will be truncated to fit.
   * Params:
   *   maxLength = the maximum length of the entry buffer, or 0 for no maximum.
   *     $(LPAREN)other than the maximum length of entries.$(RPAREN) The value passed in will
   *     be clamped to the range 0-65536.
   */
  void setMaxLength(int maxLength)
  {
    gtk_entry_buffer_set_max_length(cast(GtkEntryBuffer*)cPtr, maxLength);
  }

  /**
   * Sets the text in the buffer.
   * This is roughly equivalent to calling
   * [Gtk.EntryBuffer.deleteText] and
   * [Gtk.EntryBuffer.insertText].
   * Note that n_chars is in characters, not in bytes.
   * Params:
   *   chars = the new text
   *   nChars = the number of characters in text, or -1
   */
  void setText(string chars, int nChars)
  {
    const(char)* _chars = chars.toCString(false);
    gtk_entry_buffer_set_text(cast(GtkEntryBuffer*)cPtr, _chars, nChars);
  }

  /**
   * The text is altered in the default handler for this signal.
   * If you want access to the text after the text has been modified,
   * use %G_CONNECT_AFTER.
   * Params
   *   position = the position the text was deleted at.
   *   nChars = The number of characters that were deleted.
   *   entryBuffer = the instance the signal is connected to
   */
  alias DeletedTextCallback = void delegate(uint position, uint nChars, EntryBuffer entryBuffer);

  /**
   * Connect to DeletedText signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectDeletedText(DeletedTextCallback dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 3, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto entryBuffer = getVal!EntryBuffer(_paramVals);
      auto position = getVal!uint(&_paramVals[1]);
      auto nChars = getVal!uint(&_paramVals[2]);
      _dgClosure.dlg(position, nChars, entryBuffer);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("deleted-text", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * This signal is emitted after text is inserted into the buffer.
   * Params
   *   position = the position the text was inserted at.
   *   chars = The text that was inserted.
   *   nChars = The number of characters that were inserted.
   *   entryBuffer = the instance the signal is connected to
   */
  alias InsertedTextCallback = void delegate(uint position, string chars, uint nChars, EntryBuffer entryBuffer);

  /**
   * Connect to InsertedText signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectInsertedText(InsertedTextCallback dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 4, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto entryBuffer = getVal!EntryBuffer(_paramVals);
      auto position = getVal!uint(&_paramVals[1]);
      auto chars = getVal!string(&_paramVals[2]);
      auto nChars = getVal!uint(&_paramVals[3]);
      _dgClosure.dlg(position, chars, nChars, entryBuffer);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("inserted-text", closure, (flags & ConnectFlags.After) != 0);
  }
}
