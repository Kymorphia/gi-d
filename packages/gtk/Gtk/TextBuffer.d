module Gtk.TextBuffer;

import GObject.DClosure;
import GObject.ObjectG;
import Gdk.Clipboard;
import Gdk.ContentProvider;
import Gdk.Paintable;
import Gdk.PaintableT;
import Gid.gid;
import Gtk.TextChildAnchor;
import Gtk.TextIter;
import Gtk.TextMark;
import Gtk.TextTag;
import Gtk.TextTagTable;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * Stores text and attributes for display in a `GtkTextView`.
 * You may wish to begin by reading the
 * [text widget conceptual overview](section-text-widget.html),
 * which gives an overview of all the objects and data types
 * related to the text widget and how they work together.
 * GtkTextBuffer can support undoing changes to the buffer
 * content, see [Gtk.TextBuffer.setEnableUndo].
 */
class TextBuffer : ObjectG
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
    return gtk_text_buffer_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new text buffer.
   * Params:
   *   table = a tag table, or %NULL to create a new one
   * Returns: a new text buffer
   */
  this(TextTagTable table)
  {
    GtkTextBuffer* _cretval;
    _cretval = gtk_text_buffer_new(table ? cast(GtkTextTagTable*)table.cPtr(false) : null);
    this(_cretval, true);
  }

  /**
   * Adds the mark at position where.
   * The mark must not be added to another buffer, and if its name
   * is not %NULL then there must not be another mark in the buffer
   * with the same name.
   * Emits the signalGtk.TextBuffer::mark-set signal as notification
   * of the mark's initial placement.
   * Params:
   *   mark = the mark to add
   *   where = location to place mark
   */
  void addMark(TextMark mark, TextIter where)
  {
    gtk_text_buffer_add_mark(cast(GtkTextBuffer*)cPtr, mark ? cast(GtkTextMark*)mark.cPtr(false) : null, where ? cast(GtkTextIter*)where.cPtr(false) : null);
  }

  /**
   * Adds clipboard to the list of clipboards in which the selection
   * contents of buffer are available.
   * In most cases, clipboard will be the `GdkClipboard` returned by
   * [Gtk.Widget.getPrimaryClipboard] for a view of buffer.
   * Params:
   *   clipboard = a `GdkClipboard`
   */
  void addSelectionClipboard(Clipboard clipboard)
  {
    gtk_text_buffer_add_selection_clipboard(cast(GtkTextBuffer*)cPtr, clipboard ? cast(GdkClipboard*)clipboard.cPtr(false) : null);
  }

  /**
   * Emits the “apply-tag” signal on buffer.
   * The default handler for the signal applies
   * tag to the given range. start and end do
   * not have to be in order.
   * Params:
   *   tag = a `GtkTextTag`
   *   start = one bound of range to be tagged
   *   end = other bound of range to be tagged
   */
  void applyTag(TextTag tag, TextIter start, TextIter end)
  {
    gtk_text_buffer_apply_tag(cast(GtkTextBuffer*)cPtr, tag ? cast(GtkTextTag*)tag.cPtr(false) : null, start ? cast(GtkTextIter*)start.cPtr(false) : null, end ? cast(GtkTextIter*)end.cPtr(false) : null);
  }

  /**
   * Emits the “apply-tag” signal on buffer.
   * Calls [Gtk.TextTagTable.lookup] on the buffer’s
   * tag table to get a `GtkTextTag`, then calls
   * [Gtk.TextBuffer.applyTag].
   * Params:
   *   name = name of a named `GtkTextTag`
   *   start = one bound of range to be tagged
   *   end = other bound of range to be tagged
   */
  void applyTagByName(string name, TextIter start, TextIter end)
  {
    const(char)* _name = name.toCString(false);
    gtk_text_buffer_apply_tag_by_name(cast(GtkTextBuffer*)cPtr, _name, start ? cast(GtkTextIter*)start.cPtr(false) : null, end ? cast(GtkTextIter*)end.cPtr(false) : null);
  }

  /**
   * Performs the appropriate action as if the user hit the delete
   * key with the cursor at the position specified by iter.
   * In the normal case a single character will be deleted, but when
   * combining accents are involved, more than one character can
   * be deleted, and when precomposed character and accent combinations
   * are involved, less than one character will be deleted.
   * Because the buffer is modified, all outstanding iterators become
   * invalid after calling this function; however, the iter will be
   * re-initialized to point to the location where text was deleted.
   * Params:
   *   iter = a position in buffer
   *   interactive = whether the deletion is caused by user interaction
   *   defaultEditable = whether the buffer is editable by default
   * Returns: %TRUE if the buffer was modified
   */
  bool backspace(TextIter iter, bool interactive, bool defaultEditable)
  {
    bool _retval;
    _retval = gtk_text_buffer_backspace(cast(GtkTextBuffer*)cPtr, iter ? cast(GtkTextIter*)iter.cPtr(false) : null, interactive, defaultEditable);
    return _retval;
  }

  /**
   * Denotes the beginning of an action that may not be undone.
   * This will cause any previous operations in the undo/redo queue
   * to be cleared.
   * This should be paired with a call to
   * [Gtk.TextBuffer.endIrreversibleAction] after the irreversible
   * action has completed.
   * You may nest calls to [Gtk.TextBuffer.beginIrreversibleAction]
   * and [Gtk.TextBuffer.endIrreversibleAction] pairs.
   */
  void beginIrreversibleAction()
  {
    gtk_text_buffer_begin_irreversible_action(cast(GtkTextBuffer*)cPtr);
  }

  /**
   * Called to indicate that the buffer operations between here and a
   * call to [Gtk.TextBuffer.endUserAction] are part of a single
   * user-visible operation.
   * The operations between [Gtk.TextBuffer.beginUserAction] and
   * [Gtk.TextBuffer.endUserAction] can then be grouped when creating
   * an undo stack. `GtkTextBuffer` maintains a count of calls to
   * [Gtk.TextBuffer.beginUserAction] that have not been closed with
   * a call to [Gtk.TextBuffer.endUserAction], and emits the
   * “begin-user-action” and “end-user-action” signals only for the
   * outermost pair of calls. This allows you to build user actions
   * from other user actions.
   * The “interactive” buffer mutation functions, such as
   * [Gtk.TextBuffer.insertInteractive], automatically call
   * begin/end user action around the buffer operations they perform,
   * so there's no need to add extra calls if you user action consists
   * solely of a single call to one of those functions.
   */
  void beginUserAction()
  {
    gtk_text_buffer_begin_user_action(cast(GtkTextBuffer*)cPtr);
  }

  /**
   * Copies the currently-selected text to a clipboard.
   * Params:
   *   clipboard = the `GdkClipboard` object to copy to
   */
  void copyClipboard(Clipboard clipboard)
  {
    gtk_text_buffer_copy_clipboard(cast(GtkTextBuffer*)cPtr, clipboard ? cast(GdkClipboard*)clipboard.cPtr(false) : null);
  }

  /**
   * Creates and inserts a child anchor.
   * This is a convenience function which simply creates a child anchor
   * with [Gtk.TextChildAnchor.new_] and inserts it into the buffer
   * with [Gtk.TextBuffer.insertChildAnchor].
   * The new anchor is owned by the buffer; no reference count is
   * returned to the caller of this function.
   * Params:
   *   iter = location in the buffer
   * Returns: the created child anchor
   */
  TextChildAnchor createChildAnchor(TextIter iter)
  {
    GtkTextChildAnchor* _cretval;
    _cretval = gtk_text_buffer_create_child_anchor(cast(GtkTextBuffer*)cPtr, iter ? cast(GtkTextIter*)iter.cPtr(false) : null);
    auto _retval = _cretval ? ObjectG.getDObject!TextChildAnchor(cast(GtkTextChildAnchor*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Creates a mark at position where.
   * If mark_name is %NULL, the mark is anonymous; otherwise, the mark
   * can be retrieved by name using [Gtk.TextBuffer.getMark].
   * If a mark has left gravity, and text is inserted at the mark’s
   * current location, the mark will be moved to the left of the
   * newly-inserted text. If the mark has right gravity
   * $(LPAREN)left_gravity \= %FALSE$(RPAREN), the mark will end up on the right of
   * newly-inserted text. The standard left-to-right cursor is a mark
   * with right gravity $(LPAREN)when you type, the cursor stays on the right
   * side of the text you’re typing$(RPAREN).
   * The caller of this function does not own a
   * reference to the returned `GtkTextMark`, so you can ignore the
   * return value if you like. Marks are owned by the buffer and go
   * away when the buffer does.
   * Emits the signalGtk.TextBuffer::mark-set signal as notification
   * of the mark's initial placement.
   * Params:
   *   markName = name for mark
   *   where = location to place mark
   *   leftGravity = whether the mark has left gravity
   * Returns: the new `GtkTextMark` object
   */
  TextMark createMark(string markName, TextIter where, bool leftGravity)
  {
    GtkTextMark* _cretval;
    const(char)* _markName = markName.toCString(false);
    _cretval = gtk_text_buffer_create_mark(cast(GtkTextBuffer*)cPtr, _markName, where ? cast(GtkTextIter*)where.cPtr(false) : null, leftGravity);
    auto _retval = _cretval ? ObjectG.getDObject!TextMark(cast(GtkTextMark*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Copies the currently-selected text to a clipboard,
   * then deletes said text if it’s editable.
   * Params:
   *   clipboard = the `GdkClipboard` object to cut to
   *   defaultEditable = default editability of the buffer
   */
  void cutClipboard(Clipboard clipboard, bool defaultEditable)
  {
    gtk_text_buffer_cut_clipboard(cast(GtkTextBuffer*)cPtr, clipboard ? cast(GdkClipboard*)clipboard.cPtr(false) : null, defaultEditable);
  }

  /**
   * Deletes text between start and end.
   * The order of start and end is not actually relevant;
   * [Gtk.TextBuffer.delete_] will reorder them.
   * This function actually emits the “delete-range” signal, and
   * the default handler of that signal deletes the text. Because the
   * buffer is modified, all outstanding iterators become invalid after
   * calling this function; however, the start and end will be
   * re-initialized to point to the location where text was deleted.
   * Params:
   *   start = a position in buffer
   *   end = another position in buffer
   */
  void delete_(TextIter start, TextIter end)
  {
    gtk_text_buffer_delete(cast(GtkTextBuffer*)cPtr, start ? cast(GtkTextIter*)start.cPtr(false) : null, end ? cast(GtkTextIter*)end.cPtr(false) : null);
  }

  /**
   * Deletes all editable text in the given range.
   * Calls [Gtk.TextBuffer.delete_] for each editable
   * sub-range of [start,end$(RPAREN). start and end are revalidated
   * to point to the location of the last deleted range, or left
   * untouched if no text was deleted.
   * Params:
   *   startIter = start of range to delete
   *   endIter = end of range
   *   defaultEditable = whether the buffer is editable by default
   * Returns: whether some text was actually deleted
   */
  bool deleteInteractive(TextIter startIter, TextIter endIter, bool defaultEditable)
  {
    bool _retval;
    _retval = gtk_text_buffer_delete_interactive(cast(GtkTextBuffer*)cPtr, startIter ? cast(GtkTextIter*)startIter.cPtr(false) : null, endIter ? cast(GtkTextIter*)endIter.cPtr(false) : null, defaultEditable);
    return _retval;
  }

  /**
   * Deletes mark, so that it’s no longer located anywhere in the
   * buffer.
   * Removes the reference the buffer holds to the mark, so if
   * you haven’t called [GObject.ObjectG.ref_] on the mark, it will be freed.
   * Even if the mark isn’t freed, most operations on mark become
   * invalid, until it gets added to a buffer again with
   * [Gtk.TextBuffer.addMark]. Use [Gtk.TextMark.getDeleted]
   * to find out if a mark has been removed from its buffer.
   * The signalGtk.TextBuffer::mark-deleted signal will be emitted as
   * notification after the mark is deleted.
   * Params:
   *   mark = a `GtkTextMark` in buffer
   */
  void deleteMark(TextMark mark)
  {
    gtk_text_buffer_delete_mark(cast(GtkTextBuffer*)cPtr, mark ? cast(GtkTextMark*)mark.cPtr(false) : null);
  }

  /**
   * Deletes the mark named name; the mark must exist.
   * See [Gtk.TextBuffer.deleteMark] for details.
   * Params:
   *   name = name of a mark in buffer
   */
  void deleteMarkByName(string name)
  {
    const(char)* _name = name.toCString(false);
    gtk_text_buffer_delete_mark_by_name(cast(GtkTextBuffer*)cPtr, _name);
  }

  /**
   * Deletes the range between the “insert” and “selection_bound” marks,
   * that is, the currently-selected text.
   * If interactive is %TRUE, the editability of the selection will be
   * considered $(LPAREN)users can’t delete uneditable text$(RPAREN).
   * Params:
   *   interactive = whether the deletion is caused by user interaction
   *   defaultEditable = whether the buffer is editable by default
   * Returns: whether there was a non-empty selection to delete
   */
  bool deleteSelection(bool interactive, bool defaultEditable)
  {
    bool _retval;
    _retval = gtk_text_buffer_delete_selection(cast(GtkTextBuffer*)cPtr, interactive, defaultEditable);
    return _retval;
  }

  /**
   * Denotes the end of an action that may not be undone.
   * This will cause any previous operations in the undo/redo
   * queue to be cleared.
   * This should be called after completing modifications to the
   * text buffer after [Gtk.TextBuffer.beginIrreversibleAction]
   * was called.
   * You may nest calls to [Gtk.TextBuffer.beginIrreversibleAction]
   * and [Gtk.TextBuffer.endIrreversibleAction] pairs.
   */
  void endIrreversibleAction()
  {
    gtk_text_buffer_end_irreversible_action(cast(GtkTextBuffer*)cPtr);
  }

  /**
   * Ends a user-visible operation.
   * Should be paired with a call to
   * [Gtk.TextBuffer.beginUserAction].
   * See that function for a full explanation.
   */
  void endUserAction()
  {
    gtk_text_buffer_end_user_action(cast(GtkTextBuffer*)cPtr);
  }

  /**
   * Retrieves the first and last iterators in the buffer, i.e. the
   * entire buffer lies within the range [start,end$(RPAREN).
   * Params:
   *   start = iterator to initialize with first position in the buffer
   *   end = iterator to initialize with the end iterator
   */
  void getBounds(out TextIter start, out TextIter end)
  {
    GtkTextIter _start;
    GtkTextIter _end;
    gtk_text_buffer_get_bounds(cast(GtkTextBuffer*)cPtr, &_start, &_end);
    start = new TextIter(cast(void*)&_start, false);
    end = new TextIter(cast(void*)&_end, false);
  }

  /**
   * Gets whether there is a redoable action in the history.
   * Returns: %TRUE if there is a redoable action
   */
  bool getCanRedo()
  {
    bool _retval;
    _retval = gtk_text_buffer_get_can_redo(cast(GtkTextBuffer*)cPtr);
    return _retval;
  }

  /**
   * Gets whether there is an undoable action in the history.
   * Returns: %TRUE if there is an undoable action
   */
  bool getCanUndo()
  {
    bool _retval;
    _retval = gtk_text_buffer_get_can_undo(cast(GtkTextBuffer*)cPtr);
    return _retval;
  }

  /**
   * Gets the number of characters in the buffer.
   * Note that characters and bytes are not the same, you can’t e.g.
   * expect the contents of the buffer in string form to be this
   * many bytes long.
   * The character count is cached, so this function is very fast.
   * Returns: number of characters in the buffer
   */
  int getCharCount()
  {
    int _retval;
    _retval = gtk_text_buffer_get_char_count(cast(GtkTextBuffer*)cPtr);
    return _retval;
  }

  /**
   * Gets whether the buffer is saving modifications to the buffer
   * to allow for undo and redo actions.
   * See [Gtk.TextBuffer.beginIrreversibleAction] and
   * [Gtk.TextBuffer.endIrreversibleAction] to create
   * changes to the buffer that cannot be undone.
   * Returns: %TRUE if undoing and redoing changes to the buffer is allowed.
   */
  bool getEnableUndo()
  {
    bool _retval;
    _retval = gtk_text_buffer_get_enable_undo(cast(GtkTextBuffer*)cPtr);
    return _retval;
  }

  /**
   * Initializes iter with the “end iterator,” one past the last valid
   * character in the text buffer.
   * If dereferenced with [Gtk.TextIter.getChar], the end
   * iterator has a character value of 0.
   * The entire buffer lies in the range from the first position in
   * the buffer $(LPAREN)call [Gtk.TextBuffer.getStartIter] to get
   * character position 0$(RPAREN) to the end iterator.
   * Params:
   *   iter = iterator to initialize
   */
  void getEndIter(out TextIter iter)
  {
    GtkTextIter _iter;
    gtk_text_buffer_get_end_iter(cast(GtkTextBuffer*)cPtr, &_iter);
    iter = new TextIter(cast(void*)&_iter, false);
  }

  /**
   * Indicates whether the buffer has some text currently selected.
   * Returns: %TRUE if the there is text selected
   */
  bool getHasSelection()
  {
    bool _retval;
    _retval = gtk_text_buffer_get_has_selection(cast(GtkTextBuffer*)cPtr);
    return _retval;
  }

  /**
   * Returns the mark that represents the cursor $(LPAREN)insertion point$(RPAREN).
   * Equivalent to calling [Gtk.TextBuffer.getMark]
   * to get the mark named “insert”, but very slightly more
   * efficient, and involves less typing.
   * Returns: insertion point mark
   */
  TextMark getInsert()
  {
    GtkTextMark* _cretval;
    _cretval = gtk_text_buffer_get_insert(cast(GtkTextBuffer*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!TextMark(cast(GtkTextMark*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Obtains the location of anchor within buffer.
   * Params:
   *   iter = an iterator to be initialized
   *   anchor = a child anchor that appears in buffer
   */
  void getIterAtChildAnchor(out TextIter iter, TextChildAnchor anchor)
  {
    GtkTextIter _iter;
    gtk_text_buffer_get_iter_at_child_anchor(cast(GtkTextBuffer*)cPtr, &_iter, anchor ? cast(GtkTextChildAnchor*)anchor.cPtr(false) : null);
    iter = new TextIter(cast(void*)&_iter, false);
  }

  /**
   * Initializes iter to the start of the given line.
   * If line_number is greater than or equal to the number of lines
   * in the buffer, the end iterator is returned.
   * Params:
   *   iter = iterator to initialize
   *   lineNumber = line number counting from 0
   * Returns: whether the exact position has been found
   */
  bool getIterAtLine(out TextIter iter, int lineNumber)
  {
    bool _retval;
    GtkTextIter _iter;
    _retval = gtk_text_buffer_get_iter_at_line(cast(GtkTextBuffer*)cPtr, &_iter, lineNumber);
    iter = new TextIter(cast(void*)&_iter, false);
    return _retval;
  }

  /**
   * Obtains an iterator pointing to byte_index within the given line.
   * byte_index must be the start of a UTF-8 character. Note bytes, not
   * characters; UTF-8 may encode one character as multiple bytes.
   * If line_number is greater than or equal to the number of lines in the buffer,
   * the end iterator is returned. And if byte_index is off the
   * end of the line, the iterator at the end of the line is returned.
   * Params:
   *   iter = iterator to initialize
   *   lineNumber = line number counting from 0
   *   byteIndex = byte index from start of line
   * Returns: whether the exact position has been found
   */
  bool getIterAtLineIndex(out TextIter iter, int lineNumber, int byteIndex)
  {
    bool _retval;
    GtkTextIter _iter;
    _retval = gtk_text_buffer_get_iter_at_line_index(cast(GtkTextBuffer*)cPtr, &_iter, lineNumber, byteIndex);
    iter = new TextIter(cast(void*)&_iter, false);
    return _retval;
  }

  /**
   * Obtains an iterator pointing to char_offset within the given line.
   * Note characters, not bytes; UTF-8 may encode one character as multiple
   * bytes.
   * If line_number is greater than or equal to the number of lines in the buffer,
   * the end iterator is returned. And if char_offset is off the
   * end of the line, the iterator at the end of the line is returned.
   * Params:
   *   iter = iterator to initialize
   *   lineNumber = line number counting from 0
   *   charOffset = char offset from start of line
   * Returns: whether the exact position has been found
   */
  bool getIterAtLineOffset(out TextIter iter, int lineNumber, int charOffset)
  {
    bool _retval;
    GtkTextIter _iter;
    _retval = gtk_text_buffer_get_iter_at_line_offset(cast(GtkTextBuffer*)cPtr, &_iter, lineNumber, charOffset);
    iter = new TextIter(cast(void*)&_iter, false);
    return _retval;
  }

  /**
   * Initializes iter with the current position of mark.
   * Params:
   *   iter = iterator to initialize
   *   mark = a `GtkTextMark` in buffer
   */
  void getIterAtMark(out TextIter iter, TextMark mark)
  {
    GtkTextIter _iter;
    gtk_text_buffer_get_iter_at_mark(cast(GtkTextBuffer*)cPtr, &_iter, mark ? cast(GtkTextMark*)mark.cPtr(false) : null);
    iter = new TextIter(cast(void*)&_iter, false);
  }

  /**
   * Initializes iter to a position char_offset chars from the start
   * of the entire buffer.
   * If char_offset is -1 or greater than the number
   * of characters in the buffer, iter is initialized to the end iterator,
   * the iterator one past the last valid character in the buffer.
   * Params:
   *   iter = iterator to initialize
   *   charOffset = char offset from start of buffer, counting from 0, or -1
   */
  void getIterAtOffset(out TextIter iter, int charOffset)
  {
    GtkTextIter _iter;
    gtk_text_buffer_get_iter_at_offset(cast(GtkTextBuffer*)cPtr, &_iter, charOffset);
    iter = new TextIter(cast(void*)&_iter, false);
  }

  /**
   * Obtains the number of lines in the buffer.
   * This value is cached, so the function is very fast.
   * Returns: number of lines in the buffer
   */
  int getLineCount()
  {
    int _retval;
    _retval = gtk_text_buffer_get_line_count(cast(GtkTextBuffer*)cPtr);
    return _retval;
  }

  /**
   * Returns the mark named name in buffer buffer, or %NULL if no such
   * mark exists in the buffer.
   * Params:
   *   name = a mark name
   * Returns: a `GtkTextMark`
   */
  TextMark getMark(string name)
  {
    GtkTextMark* _cretval;
    const(char)* _name = name.toCString(false);
    _cretval = gtk_text_buffer_get_mark(cast(GtkTextBuffer*)cPtr, _name);
    auto _retval = _cretval ? ObjectG.getDObject!TextMark(cast(GtkTextMark*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the maximum number of undo levels to perform.
   * If 0, unlimited undo actions may be performed. Note that this may
   * have a memory usage impact as it requires storing an additional
   * copy of the inserted or removed text within the text buffer.
   * Returns: The max number of undo levels allowed $(LPAREN)0 indicates unlimited$(RPAREN).
   */
  uint getMaxUndoLevels()
  {
    uint _retval;
    _retval = gtk_text_buffer_get_max_undo_levels(cast(GtkTextBuffer*)cPtr);
    return _retval;
  }

  /**
   * Indicates whether the buffer has been modified since the last call
   * to [Gtk.TextBuffer.setModified] set the modification flag to
   * %FALSE.
   * Used for example to enable a “save” function in a text editor.
   * Returns: %TRUE if the buffer has been modified
   */
  bool getModified()
  {
    bool _retval;
    _retval = gtk_text_buffer_get_modified(cast(GtkTextBuffer*)cPtr);
    return _retval;
  }

  /**
   * Returns the mark that represents the selection bound.
   * Equivalent to calling [Gtk.TextBuffer.getMark]
   * to get the mark named “selection_bound”, but very slightly
   * more efficient, and involves less typing.
   * The currently-selected text in buffer is the region between the
   * “selection_bound” and “insert” marks. If “selection_bound” and
   * “insert” are in the same place, then there is no current selection.
   * [Gtk.TextBuffer.getSelectionBounds] is another convenient
   * function for handling the selection, if you just want to know whether
   * there’s a selection and what its bounds are.
   * Returns: selection bound mark
   */
  TextMark getSelectionBound()
  {
    GtkTextMark* _cretval;
    _cretval = gtk_text_buffer_get_selection_bound(cast(GtkTextBuffer*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!TextMark(cast(GtkTextMark*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns %TRUE if some text is selected; places the bounds
   * of the selection in start and end.
   * If the selection has length 0, then start and end are filled
   * in with the same value. start and end will be in ascending order.
   * If start and end are %NULL, then they are not filled in, but the
   * return value still indicates whether text is selected.
   * Params:
   *   start = iterator to initialize with selection start
   *   end = iterator to initialize with selection end
   * Returns: whether the selection has nonzero length
   */
  bool getSelectionBounds(out TextIter start, out TextIter end)
  {
    bool _retval;
    GtkTextIter _start;
    GtkTextIter _end;
    _retval = gtk_text_buffer_get_selection_bounds(cast(GtkTextBuffer*)cPtr, &_start, &_end);
    start = new TextIter(cast(void*)&_start, false);
    end = new TextIter(cast(void*)&_end, false);
    return _retval;
  }

  /**
   * Get a content provider for this buffer.
   * It can be used to make the content of buffer available
   * in a `GdkClipboard`, see [Gdk.Clipboard.setContent].
   * Returns: a new `GdkContentProvider`.
   */
  ContentProvider getSelectionContent()
  {
    GdkContentProvider* _cretval;
    _cretval = gtk_text_buffer_get_selection_content(cast(GtkTextBuffer*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!ContentProvider(cast(GdkContentProvider*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Returns the text in the range [start,end$(RPAREN).
   * Excludes undisplayed text $(LPAREN)text marked with tags that set the
   * invisibility attribute$(RPAREN) if include_hidden_chars is %FALSE.
   * The returned string includes a 0xFFFC character whenever the
   * buffer contains embedded images, so byte and character indexes
   * into the returned string do correspond to byte and character
   * indexes into the buffer. Contrast with [Gtk.TextBuffer.getText].
   * Note that 0xFFFC can occur in normal text as well, so it is not a
   * reliable indicator that a paintable or widget is in the buffer.
   * Params:
   *   start = start of a range
   *   end = end of a range
   *   includeHiddenChars = whether to include invisible text
   * Returns: an allocated UTF-8 string
   */
  string getSlice(TextIter start, TextIter end, bool includeHiddenChars)
  {
    char* _cretval;
    _cretval = gtk_text_buffer_get_slice(cast(GtkTextBuffer*)cPtr, start ? cast(GtkTextIter*)start.cPtr(false) : null, end ? cast(GtkTextIter*)end.cPtr(false) : null, includeHiddenChars);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * Initialized iter with the first position in the text buffer.
   * This is the same as using [Gtk.TextBuffer.getIterAtOffset]
   * to get the iter at character offset 0.
   * Params:
   *   iter = iterator to initialize
   */
  void getStartIter(out TextIter iter)
  {
    GtkTextIter _iter;
    gtk_text_buffer_get_start_iter(cast(GtkTextBuffer*)cPtr, &_iter);
    iter = new TextIter(cast(void*)&_iter, false);
  }

  /**
   * Get the `GtkTextTagTable` associated with this buffer.
   * Returns: the buffer’s tag table
   */
  TextTagTable getTagTable()
  {
    GtkTextTagTable* _cretval;
    _cretval = gtk_text_buffer_get_tag_table(cast(GtkTextBuffer*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!TextTagTable(cast(GtkTextTagTable*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns the text in the range [start,end$(RPAREN).
   * Excludes undisplayed text $(LPAREN)text marked with tags that set the
   * invisibility attribute$(RPAREN) if include_hidden_chars is %FALSE.
   * Does not include characters representing embedded images, so
   * byte and character indexes into the returned string do not
   * correspond to byte and character indexes into the buffer.
   * Contrast with [Gtk.TextBuffer.getSlice].
   * Params:
   *   start = start of a range
   *   end = end of a range
   *   includeHiddenChars = whether to include invisible text
   * Returns: an allocated UTF-8 string
   */
  string getText(TextIter start, TextIter end, bool includeHiddenChars)
  {
    char* _cretval;
    _cretval = gtk_text_buffer_get_text(cast(GtkTextBuffer*)cPtr, start ? cast(GtkTextIter*)start.cPtr(false) : null, end ? cast(GtkTextIter*)end.cPtr(false) : null, includeHiddenChars);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * Inserts len bytes of text at position iter.
   * If len is -1, text must be nul-terminated and will be inserted in its
   * entirety. Emits the “insert-text” signal; insertion actually occurs
   * in the default handler for the signal. iter is invalidated when
   * insertion occurs $(LPAREN)because the buffer contents change$(RPAREN), but the
   * default signal handler revalidates it to point to the end of the
   * inserted text.
   * Params:
   *   iter = a position in the buffer
   *   text = text in UTF-8 format
   *   len = length of text in bytes, or -1
   */
  void insert(TextIter iter, string text, int len)
  {
    const(char)* _text = text.toCString(false);
    gtk_text_buffer_insert(cast(GtkTextBuffer*)cPtr, iter ? cast(GtkTextIter*)iter.cPtr(false) : null, _text, len);
  }

  /**
   * Inserts text in buffer.
   * Simply calls [Gtk.TextBuffer.insert],
   * using the current cursor position as the insertion point.
   * Params:
   *   text = text in UTF-8 format
   *   len = length of text, in bytes
   */
  void insertAtCursor(string text, int len)
  {
    const(char)* _text = text.toCString(false);
    gtk_text_buffer_insert_at_cursor(cast(GtkTextBuffer*)cPtr, _text, len);
  }

  /**
   * Inserts a child widget anchor into the text buffer at iter.
   * The anchor will be counted as one character in character counts, and
   * when obtaining the buffer contents as a string, will be represented
   * by the Unicode “object replacement character” 0xFFFC. Note that the
   * “slice” variants for obtaining portions of the buffer as a string
   * include this character for child anchors, but the “text” variants do
   * not. E.g. see [Gtk.TextBuffer.getSlice] and
   * [Gtk.TextBuffer.getText].
   * Consider [Gtk.TextBuffer.createChildAnchor] as a more
   * convenient alternative to this function. The buffer will add a
   * reference to the anchor, so you can unref it after insertion.
   * Params:
   *   iter = location to insert the anchor
   *   anchor = a `GtkTextChildAnchor`
   */
  void insertChildAnchor(TextIter iter, TextChildAnchor anchor)
  {
    gtk_text_buffer_insert_child_anchor(cast(GtkTextBuffer*)cPtr, iter ? cast(GtkTextIter*)iter.cPtr(false) : null, anchor ? cast(GtkTextChildAnchor*)anchor.cPtr(false) : null);
  }

  /**
   * Inserts text in buffer.
   * Like [Gtk.TextBuffer.insert], but the insertion will not occur
   * if iter is at a non-editable location in the buffer. Usually you
   * want to prevent insertions at ineditable locations if the insertion
   * results from a user action $(LPAREN)is interactive$(RPAREN).
   * default_editable indicates the editability of text that doesn't
   * have a tag affecting editability applied to it. Typically the
   * result of [Gtk.TextView.getEditable] is appropriate here.
   * Params:
   *   iter = a position in buffer
   *   text = some UTF-8 text
   *   len = length of text in bytes, or -1
   *   defaultEditable = default editability of buffer
   * Returns: whether text was actually inserted
   */
  bool insertInteractive(TextIter iter, string text, int len, bool defaultEditable)
  {
    bool _retval;
    const(char)* _text = text.toCString(false);
    _retval = gtk_text_buffer_insert_interactive(cast(GtkTextBuffer*)cPtr, iter ? cast(GtkTextIter*)iter.cPtr(false) : null, _text, len, defaultEditable);
    return _retval;
  }

  /**
   * Inserts text in buffer.
   * Calls [Gtk.TextBuffer.insertInteractive]
   * at the cursor position.
   * default_editable indicates the editability of text that doesn't
   * have a tag affecting editability applied to it. Typically the
   * result of [Gtk.TextView.getEditable] is appropriate here.
   * Params:
   *   text = text in UTF-8 format
   *   len = length of text in bytes, or -1
   *   defaultEditable = default editability of buffer
   * Returns: whether text was actually inserted
   */
  bool insertInteractiveAtCursor(string text, int len, bool defaultEditable)
  {
    bool _retval;
    const(char)* _text = text.toCString(false);
    _retval = gtk_text_buffer_insert_interactive_at_cursor(cast(GtkTextBuffer*)cPtr, _text, len, defaultEditable);
    return _retval;
  }

  /**
   * Inserts the text in markup at position iter.
   * markup will be inserted in its entirety and must be nul-terminated
   * and valid UTF-8. Emits the signalGtk.TextBuffer::insert-text signal,
   * possibly multiple times; insertion actually occurs in the default handler
   * for the signal. iter will point to the end of the inserted text on return.
   * Params:
   *   iter = location to insert the markup
   *   markup = a nul-terminated UTF-8 string containing Pango markup
   *   len = length of markup in bytes, or -1
   */
  void insertMarkup(TextIter iter, string markup, int len)
  {
    const(char)* _markup = markup.toCString(false);
    gtk_text_buffer_insert_markup(cast(GtkTextBuffer*)cPtr, iter ? cast(GtkTextIter*)iter.cPtr(false) : null, _markup, len);
  }

  /**
   * Inserts an image into the text buffer at iter.
   * The image will be counted as one character in character counts,
   * and when obtaining the buffer contents as a string, will be
   * represented by the Unicode “object replacement character” 0xFFFC.
   * Note that the “slice” variants for obtaining portions of the buffer
   * as a string include this character for paintable, but the “text”
   * variants do not. e.g. see [Gtk.TextBuffer.getSlice] and
   * [Gtk.TextBuffer.getText].
   * Params:
   *   iter = location to insert the paintable
   *   paintable = a `GdkPaintable`
   */
  void insertPaintable(TextIter iter, Paintable paintable)
  {
    gtk_text_buffer_insert_paintable(cast(GtkTextBuffer*)cPtr, iter ? cast(GtkTextIter*)iter.cPtr(false) : null, paintable ? cast(GdkPaintable*)(cast(ObjectG)paintable).cPtr(false) : null);
  }

  /**
   * Copies text, tags, and paintables between start and end
   * and inserts the copy at iter.
   * The order of start and end doesn’t matter.
   * Used instead of simply getting/inserting text because it preserves
   * images and tags. If start and end are in a different buffer from
   * buffer, the two buffers must share the same tag table.
   * Implemented via emissions of the ::insert-text and ::apply-tag signals,
   * so expect those.
   * Params:
   *   iter = a position in buffer
   *   start = a position in a `GtkTextBuffer`
   *   end = another position in the same buffer as start
   */
  void insertRange(TextIter iter, TextIter start, TextIter end)
  {
    gtk_text_buffer_insert_range(cast(GtkTextBuffer*)cPtr, iter ? cast(GtkTextIter*)iter.cPtr(false) : null, start ? cast(GtkTextIter*)start.cPtr(false) : null, end ? cast(GtkTextIter*)end.cPtr(false) : null);
  }

  /**
   * Copies text, tags, and paintables between start and end
   * and inserts the copy at iter.
   * Same as [Gtk.TextBuffer.insertRange], but does nothing
   * if the insertion point isn’t editable. The default_editable
   * parameter indicates whether the text is editable at iter if
   * no tags enclosing iter affect editability. Typically the result
   * of [Gtk.TextView.getEditable] is appropriate here.
   * Params:
   *   iter = a position in buffer
   *   start = a position in a `GtkTextBuffer`
   *   end = another position in the same buffer as start
   *   defaultEditable = default editability of the buffer
   * Returns: whether an insertion was possible at iter
   */
  bool insertRangeInteractive(TextIter iter, TextIter start, TextIter end, bool defaultEditable)
  {
    bool _retval;
    _retval = gtk_text_buffer_insert_range_interactive(cast(GtkTextBuffer*)cPtr, iter ? cast(GtkTextIter*)iter.cPtr(false) : null, start ? cast(GtkTextIter*)start.cPtr(false) : null, end ? cast(GtkTextIter*)end.cPtr(false) : null, defaultEditable);
    return _retval;
  }

  /**
   * Moves mark to the new location where.
   * Emits the signalGtk.TextBuffer::mark-set signal
   * as notification of the move.
   * Params:
   *   mark = a `GtkTextMark`
   *   where = new location for mark in buffer
   */
  void moveMark(TextMark mark, TextIter where)
  {
    gtk_text_buffer_move_mark(cast(GtkTextBuffer*)cPtr, mark ? cast(GtkTextMark*)mark.cPtr(false) : null, where ? cast(GtkTextIter*)where.cPtr(false) : null);
  }

  /**
   * Moves the mark named name $(LPAREN)which must exist$(RPAREN) to location where.
   * See [Gtk.TextBuffer.moveMark] for details.
   * Params:
   *   name = name of a mark
   *   where = new location for mark
   */
  void moveMarkByName(string name, TextIter where)
  {
    const(char)* _name = name.toCString(false);
    gtk_text_buffer_move_mark_by_name(cast(GtkTextBuffer*)cPtr, _name, where ? cast(GtkTextIter*)where.cPtr(false) : null);
  }

  /**
   * Pastes the contents of a clipboard.
   * If override_location is %NULL, the pasted text will be inserted
   * at the cursor position, or the buffer selection will be replaced
   * if the selection is non-empty.
   * Note: pasting is asynchronous, that is, we’ll ask for the paste data
   * and return, and at some point later after the main loop runs, the paste
   * data will be inserted.
   * Params:
   *   clipboard = the `GdkClipboard` to paste from
   *   overrideLocation = location to insert pasted text
   *   defaultEditable = whether the buffer is editable by default
   */
  void pasteClipboard(Clipboard clipboard, TextIter overrideLocation, bool defaultEditable)
  {
    gtk_text_buffer_paste_clipboard(cast(GtkTextBuffer*)cPtr, clipboard ? cast(GdkClipboard*)clipboard.cPtr(false) : null, overrideLocation ? cast(GtkTextIter*)overrideLocation.cPtr(false) : null, defaultEditable);
  }

  /**
   * This function moves the “insert” and “selection_bound” marks
   * simultaneously.
   * If you move them to the same place in two steps with
   * [Gtk.TextBuffer.moveMark], you will temporarily select a
   * region in between their old and new locations, which can be pretty
   * inefficient since the temporarily-selected region will force stuff
   * to be recalculated. This function moves them as a unit, which can
   * be optimized.
   * Params:
   *   where = where to put the cursor
   */
  void placeCursor(TextIter where)
  {
    gtk_text_buffer_place_cursor(cast(GtkTextBuffer*)cPtr, where ? cast(GtkTextIter*)where.cPtr(false) : null);
  }

  /**
   * Redoes the next redoable action on the buffer, if there is one.
   */
  void redo()
  {
    gtk_text_buffer_redo(cast(GtkTextBuffer*)cPtr);
  }

  /**
   * Removes all tags in the range between start and end.
   * Be careful with this function; it could remove tags added in code
   * unrelated to the code you’re currently writing. That is, using this
   * function is probably a bad idea if you have two or more unrelated
   * code sections that add tags.
   * Params:
   *   start = one bound of range to be untagged
   *   end = other bound of range to be untagged
   */
  void removeAllTags(TextIter start, TextIter end)
  {
    gtk_text_buffer_remove_all_tags(cast(GtkTextBuffer*)cPtr, start ? cast(GtkTextIter*)start.cPtr(false) : null, end ? cast(GtkTextIter*)end.cPtr(false) : null);
  }

  /**
   * Removes a `GdkClipboard` added with
   * [Gtk.TextBuffer.addSelectionClipboard]
   * Params:
   *   clipboard = a `GdkClipboard` added to buffer by
   *     [Gtk.TextBuffer.addSelectionClipboard]
   */
  void removeSelectionClipboard(Clipboard clipboard)
  {
    gtk_text_buffer_remove_selection_clipboard(cast(GtkTextBuffer*)cPtr, clipboard ? cast(GdkClipboard*)clipboard.cPtr(false) : null);
  }

  /**
   * Emits the “remove-tag” signal.
   * The default handler for the signal removes all occurrences
   * of tag from the given range. start and end don’t have
   * to be in order.
   * Params:
   *   tag = a `GtkTextTag`
   *   start = one bound of range to be untagged
   *   end = other bound of range to be untagged
   */
  void removeTag(TextTag tag, TextIter start, TextIter end)
  {
    gtk_text_buffer_remove_tag(cast(GtkTextBuffer*)cPtr, tag ? cast(GtkTextTag*)tag.cPtr(false) : null, start ? cast(GtkTextIter*)start.cPtr(false) : null, end ? cast(GtkTextIter*)end.cPtr(false) : null);
  }

  /**
   * Emits the “remove-tag” signal.
   * Calls [Gtk.TextTagTable.lookup] on the buffer’s
   * tag table to get a `GtkTextTag`, then calls
   * [Gtk.TextBuffer.removeTag].
   * Params:
   *   name = name of a `GtkTextTag`
   *   start = one bound of range to be untagged
   *   end = other bound of range to be untagged
   */
  void removeTagByName(string name, TextIter start, TextIter end)
  {
    const(char)* _name = name.toCString(false);
    gtk_text_buffer_remove_tag_by_name(cast(GtkTextBuffer*)cPtr, _name, start ? cast(GtkTextIter*)start.cPtr(false) : null, end ? cast(GtkTextIter*)end.cPtr(false) : null);
  }

  /**
   * This function moves the “insert” and “selection_bound” marks
   * simultaneously.
   * If you move them in two steps with
   * [Gtk.TextBuffer.moveMark], you will temporarily select a
   * region in between their old and new locations, which can be pretty
   * inefficient since the temporarily-selected region will force stuff
   * to be recalculated. This function moves them as a unit, which can
   * be optimized.
   * Params:
   *   ins = where to put the “insert” mark
   *   bound = where to put the “selection_bound” mark
   */
  void selectRange(TextIter ins, TextIter bound)
  {
    gtk_text_buffer_select_range(cast(GtkTextBuffer*)cPtr, ins ? cast(GtkTextIter*)ins.cPtr(false) : null, bound ? cast(GtkTextIter*)bound.cPtr(false) : null);
  }

  /**
   * Sets whether or not to enable undoable actions in the text buffer.
   * Undoable actions in this context are changes to the text content of
   * the buffer. Changes to tags and marks are not tracked.
   * If enabled, the user will be able to undo the last number of actions
   * up to [Gtk.TextBuffer.getMaxUndoLevels].
   * See [Gtk.TextBuffer.beginIrreversibleAction] and
   * [Gtk.TextBuffer.endIrreversibleAction] to create
   * changes to the buffer that cannot be undone.
   * Params:
   *   enableUndo = %TRUE to enable undo
   */
  void setEnableUndo(bool enableUndo)
  {
    gtk_text_buffer_set_enable_undo(cast(GtkTextBuffer*)cPtr, enableUndo);
  }

  /**
   * Sets the maximum number of undo levels to perform.
   * If 0, unlimited undo actions may be performed. Note that this may
   * have a memory usage impact as it requires storing an additional
   * copy of the inserted or removed text within the text buffer.
   * Params:
   *   maxUndoLevels = the maximum number of undo actions to perform
   */
  void setMaxUndoLevels(uint maxUndoLevels)
  {
    gtk_text_buffer_set_max_undo_levels(cast(GtkTextBuffer*)cPtr, maxUndoLevels);
  }

  /**
   * Used to keep track of whether the buffer has been
   * modified since the last time it was saved.
   * Whenever the buffer is saved to disk, call
   * `gtk_text_buffer_set_modified $(LPAREN)buffer, FALSE$(RPAREN)`.
   * When the buffer is modified, it will automatically
   * toggle on the modified bit again. When the modified
   * bit flips, the buffer emits the
   * signalGtk.TextBuffer::modified-changed signal.
   * Params:
   *   setting = modification flag setting
   */
  void setModified(bool setting)
  {
    gtk_text_buffer_set_modified(cast(GtkTextBuffer*)cPtr, setting);
  }

  /**
   * Deletes current contents of buffer, and inserts text instead. This is
   * automatically marked as an irreversible action in the undo stack. If you
   * wish to mark this action as part of a larger undo operation, call
   * [Gtk.TextBuffer.delete_] and [Gtk.TextBuffer.insert] directly instead.
   * If len is -1, text must be nul-terminated.
   * text must be valid UTF-8.
   * Params:
   *   text = UTF-8 text to insert
   *   len = length of text in bytes
   */
  void setText(string text, int len)
  {
    const(char)* _text = text.toCString(false);
    gtk_text_buffer_set_text(cast(GtkTextBuffer*)cPtr, _text, len);
  }

  /**
   * Undoes the last undoable action on the buffer, if there is one.
   */
  void undo()
  {
    gtk_text_buffer_undo(cast(GtkTextBuffer*)cPtr);
  }

  /**
   * Emitted to apply a tag to a range of text in a `GtkTextBuffer`.
   * Applying actually occurs in the default handler.
   * Note that if your handler runs before the default handler
   * it must not invalidate the start and end iters $(LPAREN)or has to
   * revalidate them$(RPAREN).
   * See also:
   * [Gtk.TextBuffer.applyTag],
   * [Gtk.TextBuffer.insertWithTags],
   * [Gtk.TextBuffer.insertRange].
   * Params
   *   tag = the applied tag
   *   start = the start of the range the tag is applied to
   *   end = the end of the range the tag is applied to
   *   textBuffer = the instance the signal is connected to
   */
  alias ApplyTagCallback = void delegate(TextTag tag, TextIter start, TextIter end, TextBuffer textBuffer);

  /**
   * Connect to ApplyTag signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectApplyTag(ApplyTagCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 4, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto textBuffer = getVal!TextBuffer(_paramVals);
      auto tag = getVal!TextTag(&_paramVals[1]);
      auto start = getVal!TextIter(&_paramVals[2]);
      auto end = getVal!TextIter(&_paramVals[3]);
      _dgClosure.dlg(tag, start, end, textBuffer);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("apply-tag", closure, after);
  }

  /**
   * Emitted at the beginning of a single user-visible
   * operation on a `GtkTextBuffer`.
   * See also:
   * [Gtk.TextBuffer.beginUserAction],
   * [Gtk.TextBuffer.insertInteractive],
   * [Gtk.TextBuffer.insertRangeInteractive],
   * [Gtk.TextBuffer.deleteInteractive],
   * [Gtk.TextBuffer.backspace],
   * [Gtk.TextBuffer.deleteSelection].
   *   textBuffer = the instance the signal is connected to
   */
  alias BeginUserActionCallback = void delegate(TextBuffer textBuffer);

  /**
   * Connect to BeginUserAction signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectBeginUserAction(BeginUserActionCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto textBuffer = getVal!TextBuffer(_paramVals);
      _dgClosure.dlg(textBuffer);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("begin-user-action", closure, after);
  }

  /**
   * Emitted when the content of a `GtkTextBuffer` has changed.
   *   textBuffer = the instance the signal is connected to
   */
  alias ChangedCallback = void delegate(TextBuffer textBuffer);

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
      auto textBuffer = getVal!TextBuffer(_paramVals);
      _dgClosure.dlg(textBuffer);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("changed", closure, after);
  }

  /**
   * Emitted to delete a range from a `GtkTextBuffer`.
   * Note that if your handler runs before the default handler
   * it must not invalidate the start and end iters $(LPAREN)or has
   * to revalidate them$(RPAREN). The default signal handler revalidates
   * the start and end iters to both point to the location
   * where text was deleted. Handlers which run after the default
   * handler $(LPAREN)see g_signal_connect_after$(LPAREN)$(RPAREN)$(RPAREN) do not have access to
   * the deleted text.
   * See also: [Gtk.TextBuffer.delete_].
   * Params
   *   start = the start of the range to be deleted
   *   end = the end of the range to be deleted
   *   textBuffer = the instance the signal is connected to
   */
  alias DeleteRangeCallback = void delegate(TextIter start, TextIter end, TextBuffer textBuffer);

  /**
   * Connect to DeleteRange signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectDeleteRange(DeleteRangeCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 3, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto textBuffer = getVal!TextBuffer(_paramVals);
      auto start = getVal!TextIter(&_paramVals[1]);
      auto end = getVal!TextIter(&_paramVals[2]);
      _dgClosure.dlg(start, end, textBuffer);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("delete-range", closure, after);
  }

  /**
   * Emitted at the end of a single user-visible
   * operation on the `GtkTextBuffer`.
   * See also:
   * [Gtk.TextBuffer.endUserAction],
   * [Gtk.TextBuffer.insertInteractive],
   * [Gtk.TextBuffer.insertRangeInteractive],
   * [Gtk.TextBuffer.deleteInteractive],
   * [Gtk.TextBuffer.backspace],
   * [Gtk.TextBuffer.deleteSelection],
   * [Gtk.TextBuffer.backspace].
   *   textBuffer = the instance the signal is connected to
   */
  alias EndUserActionCallback = void delegate(TextBuffer textBuffer);

  /**
   * Connect to EndUserAction signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectEndUserAction(EndUserActionCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto textBuffer = getVal!TextBuffer(_paramVals);
      _dgClosure.dlg(textBuffer);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("end-user-action", closure, after);
  }

  /**
   * Emitted to insert a `GtkTextChildAnchor` in a `GtkTextBuffer`.
   * Insertion actually occurs in the default handler.
   * Note that if your handler runs before the default handler
   * it must not invalidate the location iter $(LPAREN)or has to
   * revalidate it$(RPAREN). The default signal handler revalidates
   * it to be placed after the inserted anchor.
   * See also: [Gtk.TextBuffer.insertChildAnchor].
   * Params
   *   location = position to insert anchor in textbuffer
   *   anchor = the `GtkTextChildAnchor` to be inserted
   *   textBuffer = the instance the signal is connected to
   */
  alias InsertChildAnchorCallback = void delegate(TextIter location, TextChildAnchor anchor, TextBuffer textBuffer);

  /**
   * Connect to InsertChildAnchor signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectInsertChildAnchor(InsertChildAnchorCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 3, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto textBuffer = getVal!TextBuffer(_paramVals);
      auto location = getVal!TextIter(&_paramVals[1]);
      auto anchor = getVal!TextChildAnchor(&_paramVals[2]);
      _dgClosure.dlg(location, anchor, textBuffer);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("insert-child-anchor", closure, after);
  }

  /**
   * Emitted to insert a `GdkPaintable` in a `GtkTextBuffer`.
   * Insertion actually occurs in the default handler.
   * Note that if your handler runs before the default handler
   * it must not invalidate the location iter $(LPAREN)or has to
   * revalidate it$(RPAREN). The default signal handler revalidates
   * it to be placed after the inserted paintable.
   * See also: [Gtk.TextBuffer.insertPaintable].
   * Params
   *   location = position to insert paintable in textbuffer
   *   paintable = the `GdkPaintable` to be inserted
   *   textBuffer = the instance the signal is connected to
   */
  alias InsertPaintableCallback = void delegate(TextIter location, Paintable paintable, TextBuffer textBuffer);

  /**
   * Connect to InsertPaintable signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectInsertPaintable(InsertPaintableCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 3, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto textBuffer = getVal!TextBuffer(_paramVals);
      auto location = getVal!TextIter(&_paramVals[1]);
      auto paintable = getVal!Paintable(&_paramVals[2]);
      _dgClosure.dlg(location, paintable, textBuffer);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("insert-paintable", closure, after);
  }

  /**
   * Emitted to insert text in a `GtkTextBuffer`.
   * Insertion actually occurs in the default handler.
   * Note that if your handler runs before the default handler
   * it must not invalidate the location iter $(LPAREN)or has to
   * revalidate it$(RPAREN). The default signal handler revalidates
   * it to point to the end of the inserted text.
   * See also: [Gtk.TextBuffer.insert],
   * [Gtk.TextBuffer.insertRange].
   * Params
   *   location = position to insert text in textbuffer
   *   text = the UTF-8 text to be inserted
   *   len = length of the inserted text in bytes
   *   textBuffer = the instance the signal is connected to
   */
  alias InsertTextCallback = void delegate(TextIter location, string text, int len, TextBuffer textBuffer);

  /**
   * Connect to InsertText signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectInsertText(InsertTextCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 4, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto textBuffer = getVal!TextBuffer(_paramVals);
      auto location = getVal!TextIter(&_paramVals[1]);
      auto text = getVal!string(&_paramVals[2]);
      auto len = getVal!int(&_paramVals[3]);
      _dgClosure.dlg(location, text, len, textBuffer);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("insert-text", closure, after);
  }

  /**
   * Emitted as notification after a `GtkTextMark` is deleted.
   * See also: [Gtk.TextBuffer.deleteMark].
   * Params
   *   mark = The mark that was deleted
   *   textBuffer = the instance the signal is connected to
   */
  alias MarkDeletedCallback = void delegate(TextMark mark, TextBuffer textBuffer);

  /**
   * Connect to MarkDeleted signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectMarkDeleted(MarkDeletedCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto textBuffer = getVal!TextBuffer(_paramVals);
      auto mark = getVal!TextMark(&_paramVals[1]);
      _dgClosure.dlg(mark, textBuffer);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("mark-deleted", closure, after);
  }

  /**
   * Emitted as notification after a `GtkTextMark` is set.
   * See also:
   * [Gtk.TextBuffer.createMark],
   * [Gtk.TextBuffer.moveMark].
   * Params
   *   location = The location of mark in textbuffer
   *   mark = The mark that is set
   *   textBuffer = the instance the signal is connected to
   */
  alias MarkSetCallback = void delegate(TextIter location, TextMark mark, TextBuffer textBuffer);

  /**
   * Connect to MarkSet signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectMarkSet(MarkSetCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 3, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto textBuffer = getVal!TextBuffer(_paramVals);
      auto location = getVal!TextIter(&_paramVals[1]);
      auto mark = getVal!TextMark(&_paramVals[2]);
      _dgClosure.dlg(location, mark, textBuffer);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("mark-set", closure, after);
  }

  /**
   * Emitted when the modified bit of a `GtkTextBuffer` flips.
   * See also: [Gtk.TextBuffer.setModified].
   *   textBuffer = the instance the signal is connected to
   */
  alias ModifiedChangedCallback = void delegate(TextBuffer textBuffer);

  /**
   * Connect to ModifiedChanged signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectModifiedChanged(ModifiedChangedCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto textBuffer = getVal!TextBuffer(_paramVals);
      _dgClosure.dlg(textBuffer);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("modified-changed", closure, after);
  }

  /**
   * Emitted after paste operation has been completed.
   * This is useful to properly scroll the view to the end
   * of the pasted text. See [Gtk.TextBuffer.pasteClipboard]
   * for more details.
   * Params
   *   clipboard = the `GdkClipboard` pasted from
   *   textBuffer = the instance the signal is connected to
   */
  alias PasteDoneCallback = void delegate(Clipboard clipboard, TextBuffer textBuffer);

  /**
   * Connect to PasteDone signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectPasteDone(PasteDoneCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto textBuffer = getVal!TextBuffer(_paramVals);
      auto clipboard = getVal!Clipboard(&_paramVals[1]);
      _dgClosure.dlg(clipboard, textBuffer);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("paste-done", closure, after);
  }

  /**
   * Emitted when a request has been made to redo the
   * previously undone operation.
   *   textBuffer = the instance the signal is connected to
   */
  alias RedoCallback = void delegate(TextBuffer textBuffer);

  /**
   * Connect to Redo signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectRedo(RedoCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto textBuffer = getVal!TextBuffer(_paramVals);
      _dgClosure.dlg(textBuffer);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("redo", closure, after);
  }

  /**
   * Emitted to remove all occurrences of tag from a range
   * of text in a `GtkTextBuffer`.
   * Removal actually occurs in the default handler.
   * Note that if your handler runs before the default handler
   * it must not invalidate the start and end iters $(LPAREN)or has
   * to revalidate them$(RPAREN).
   * See also: [Gtk.TextBuffer.removeTag].
   * Params
   *   tag = the tag to be removed
   *   start = the start of the range the tag is removed from
   *   end = the end of the range the tag is removed from
   *   textBuffer = the instance the signal is connected to
   */
  alias RemoveTagCallback = void delegate(TextTag tag, TextIter start, TextIter end, TextBuffer textBuffer);

  /**
   * Connect to RemoveTag signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectRemoveTag(RemoveTagCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 4, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto textBuffer = getVal!TextBuffer(_paramVals);
      auto tag = getVal!TextTag(&_paramVals[1]);
      auto start = getVal!TextIter(&_paramVals[2]);
      auto end = getVal!TextIter(&_paramVals[3]);
      _dgClosure.dlg(tag, start, end, textBuffer);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("remove-tag", closure, after);
  }

  /**
   * Emitted when a request has been made to undo the
   * previous operation or set of operations that have
   * been grouped together.
   *   textBuffer = the instance the signal is connected to
   */
  alias UndoCallback = void delegate(TextBuffer textBuffer);

  /**
   * Connect to Undo signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectUndo(UndoCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto textBuffer = getVal!TextBuffer(_paramVals);
      _dgClosure.dlg(textBuffer);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("undo", closure, after);
  }
}
