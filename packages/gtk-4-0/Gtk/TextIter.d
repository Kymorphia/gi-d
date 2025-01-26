module Gtk.TextIter;

import GLib.Boxed;
import GObject.ObjectG;
import Gdk.Paintable;
import Gdk.PaintableT;
import Gid.gid;
import Gtk.TextBuffer;
import Gtk.TextChildAnchor;
import Gtk.TextMark;
import Gtk.TextTag;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;
import Pango.PgLanguage;

/**
 * An iterator for the contents of a `GtkTextBuffer`.
 * You may wish to begin by reading the
 * [text widget conceptual overview](section-text-widget.html),
 * which gives an overview of all the objects and data types
 * related to the text widget and how they work together.
 */
class TextIter : Boxed
{

  this()
  {
    super(safeMalloc(GtkTextIter.sizeof), true);
  }

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  void* cPtr(bool makeCopy = false)
  {
    return makeCopy ? copy_ : cInstancePtr;
  }

  static GType getType()
  {
    return gtk_text_iter_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Assigns the value of other to iter.
   * This function is not useful in applications, because
   * iterators can be assigned with `GtkTextIter i \= j;`.
   * The function is used by language bindings.
   * Params:
   *   other = another `GtkTextIter`
   */
  void assign(TextIter other)
  {
    gtk_text_iter_assign(cast(GtkTextIter*)cPtr, other ? cast(GtkTextIter*)other.cPtr(false) : null);
  }

  /**
   * Moves backward by one character offset.
   * Returns %TRUE if movement was possible; if iter was the first
   * in the buffer $(LPAREN)character offset 0$(RPAREN), this function returns %FALSE
   * for convenience when writing loops.
   * Returns: whether movement was possible
   */
  bool backwardChar()
  {
    bool _retval;
    _retval = gtk_text_iter_backward_char(cast(GtkTextIter*)cPtr);
    return _retval;
  }

  /**
   * Moves count characters backward, if possible.
   * If count would move past the start or end of the buffer, moves
   * to the start or end of the buffer.
   * The return value indicates whether the iterator moved
   * onto a dereferenceable position; if the iterator didn’t move, or
   * moved onto the end iterator, then %FALSE is returned. If count is 0,
   * the function does nothing and returns %FALSE.
   * Params:
   *   count = number of characters to move
   * Returns: whether iter moved and is dereferenceable
   */
  bool backwardChars(int count)
  {
    bool _retval;
    _retval = gtk_text_iter_backward_chars(cast(GtkTextIter*)cPtr, count);
    return _retval;
  }

  /**
   * Like [Gtk.TextIter.forwardCursorPosition], but moves backward.
   * Returns: %TRUE if we moved
   */
  bool backwardCursorPosition()
  {
    bool _retval;
    _retval = gtk_text_iter_backward_cursor_position(cast(GtkTextIter*)cPtr);
    return _retval;
  }

  /**
   * Moves up to count cursor positions.
   * See [Gtk.TextIter.forwardCursorPosition] for details.
   * Params:
   *   count = number of positions to move
   * Returns: %TRUE if we moved and the new position is dereferenceable
   */
  bool backwardCursorPositions(int count)
  {
    bool _retval;
    _retval = gtk_text_iter_backward_cursor_positions(cast(GtkTextIter*)cPtr, count);
    return _retval;
  }

  /**
   * Same as [Gtk.TextIter.forwardFindChar],
   * but goes backward from iter.
   * Params:
   *   pred = function to be called on each character
   *   limit = search limit
   * Returns: whether a match was found
   */
  bool backwardFindChar(TextCharPredicate pred, TextIter limit)
  {
    extern(C) bool _predCallback(dchar ch, void* userData)
    {
      auto _dlg = cast(TextCharPredicate*)userData;

      bool _retval = (*_dlg)(ch);
      return _retval;
    }

    bool _retval;
    auto _pred = cast(void*)&pred;
    _retval = gtk_text_iter_backward_find_char(cast(GtkTextIter*)cPtr, &_predCallback, _pred, limit ? cast(GtkTextIter*)limit.cPtr(false) : null);
    return _retval;
  }

  /**
   * Moves iter to the start of the previous line.
   * Returns %TRUE if iter could be moved; i.e. if iter was at
   * character offset 0, this function returns %FALSE. Therefore,
   * if iter was already on line 0, but not at the start of the line,
   * iter is snapped to the start of the line and the function returns
   * %TRUE. $(LPAREN)Note that this implies that
   * in a loop calling this function, the line number may not change on
   * every iteration, if your first iteration is on line 0.$(RPAREN)
   * Returns: whether iter moved
   */
  bool backwardLine()
  {
    bool _retval;
    _retval = gtk_text_iter_backward_line(cast(GtkTextIter*)cPtr);
    return _retval;
  }

  /**
   * Moves count lines backward, if possible.
   * If count would move past the start or end of the buffer, moves to
   * the start or end of the buffer.
   * The return value indicates whether the iterator moved
   * onto a dereferenceable position; if the iterator didn’t move, or
   * moved onto the end iterator, then %FALSE is returned. If count is 0,
   * the function does nothing and returns %FALSE. If count is negative,
   * moves forward by 0 - count lines.
   * Params:
   *   count = number of lines to move backward
   * Returns: whether iter moved and is dereferenceable
   */
  bool backwardLines(int count)
  {
    bool _retval;
    _retval = gtk_text_iter_backward_lines(cast(GtkTextIter*)cPtr, count);
    return _retval;
  }

  /**
   * Same as [Gtk.TextIter.forwardSearch], but moves backward.
   * match_end will never be set to a `GtkTextIter` located after iter,
   * even if there is a possible match_start before or at iter.
   * Params:
   *   str = search string
   *   flags = bitmask of flags affecting the search
   *   matchStart = return location for start of match
   *   matchEnd = return location for end of match
   *   limit = location of last possible match_start, or %NULL for start of buffer
   * Returns: whether a match was found
   */
  bool backwardSearch(string str, TextSearchFlags flags, out TextIter matchStart, out TextIter matchEnd, TextIter limit)
  {
    bool _retval;
    const(char)* _str = str.toCString(false);
    GtkTextIter _matchStart;
    GtkTextIter _matchEnd;
    _retval = gtk_text_iter_backward_search(cast(GtkTextIter*)cPtr, _str, flags, &_matchStart, &_matchEnd, limit ? cast(GtkTextIter*)limit.cPtr(false) : null);
    matchStart = new TextIter(cast(void*)&_matchStart, false);
    matchEnd = new TextIter(cast(void*)&_matchEnd, false);
    return _retval;
  }

  /**
   * Moves backward to the previous sentence start.
   * If iter is already at the start of a sentence, moves backward
   * to the next one.
   * Sentence boundaries are determined by Pango and should
   * be correct for nearly any language.
   * Returns: %TRUE if iter moved and is not the end iterator
   */
  bool backwardSentenceStart()
  {
    bool _retval;
    _retval = gtk_text_iter_backward_sentence_start(cast(GtkTextIter*)cPtr);
    return _retval;
  }

  /**
   * Calls [Gtk.TextIter.backwardSentenceStart] up to count times.
   * If count is negative, moves forward instead of backward.
   * Params:
   *   count = number of sentences to move
   * Returns: %TRUE if iter moved and is not the end iterator
   */
  bool backwardSentenceStarts(int count)
  {
    bool _retval;
    _retval = gtk_text_iter_backward_sentence_starts(cast(GtkTextIter*)cPtr, count);
    return _retval;
  }

  /**
   * Moves backward to the next toggle $(LPAREN)on or off$(RPAREN) of the
   * tag, or to the next toggle of any tag if
   * tag is %NULL.
   * If no matching tag toggles are found,
   * returns %FALSE, otherwise %TRUE. Does not return toggles
   * located at iter, only toggles before iter. Sets iter
   * to the location of the toggle, or the start of the buffer
   * if no toggle is found.
   * Params:
   *   tag = a `GtkTextTag`
   * Returns: whether we found a tag toggle before iter
   */
  bool backwardToTagToggle(TextTag tag)
  {
    bool _retval;
    _retval = gtk_text_iter_backward_to_tag_toggle(cast(GtkTextIter*)cPtr, tag ? cast(GtkTextTag*)tag.cPtr(false) : null);
    return _retval;
  }

  /**
   * Moves iter backward to the previous visible cursor position.
   * See [Gtk.TextIter.backwardCursorPosition] for details.
   * Returns: %TRUE if we moved and the new position is dereferenceable
   */
  bool backwardVisibleCursorPosition()
  {
    bool _retval;
    _retval = gtk_text_iter_backward_visible_cursor_position(cast(GtkTextIter*)cPtr);
    return _retval;
  }

  /**
   * Moves up to count visible cursor positions.
   * See [Gtk.TextIter.backwardCursorPosition] for details.
   * Params:
   *   count = number of positions to move
   * Returns: %TRUE if we moved and the new position is dereferenceable
   */
  bool backwardVisibleCursorPositions(int count)
  {
    bool _retval;
    _retval = gtk_text_iter_backward_visible_cursor_positions(cast(GtkTextIter*)cPtr, count);
    return _retval;
  }

  /**
   * Moves iter to the start of the previous visible line.
   * Returns %TRUE if
   * iter could be moved; i.e. if iter was at character offset 0, this
   * function returns %FALSE. Therefore if iter was already on line 0,
   * but not at the start of the line, iter is snapped to the start of
   * the line and the function returns %TRUE. $(LPAREN)Note that this implies that
   * in a loop calling this function, the line number may not change on
   * every iteration, if your first iteration is on line 0.$(RPAREN)
   * Returns: whether iter moved
   */
  bool backwardVisibleLine()
  {
    bool _retval;
    _retval = gtk_text_iter_backward_visible_line(cast(GtkTextIter*)cPtr);
    return _retval;
  }

  /**
   * Moves count visible lines backward, if possible.
   * If count would move past the start or end of the buffer, moves to
   * the start or end of the buffer.
   * The return value indicates whether the iterator moved
   * onto a dereferenceable position; if the iterator didn’t move, or
   * moved onto the end iterator, then %FALSE is returned. If count is 0,
   * the function does nothing and returns %FALSE. If count is negative,
   * moves forward by 0 - count lines.
   * Params:
   *   count = number of lines to move backward
   * Returns: whether iter moved and is dereferenceable
   */
  bool backwardVisibleLines(int count)
  {
    bool _retval;
    _retval = gtk_text_iter_backward_visible_lines(cast(GtkTextIter*)cPtr, count);
    return _retval;
  }

  /**
   * Moves backward to the previous visible word start.
   * If iter is currently on a word start, moves backward to the
   * next one after that.
   * Word breaks are determined by Pango and should be correct
   * for nearly any language.
   * Returns: %TRUE if iter moved and is not the end iterator
   */
  bool backwardVisibleWordStart()
  {
    bool _retval;
    _retval = gtk_text_iter_backward_visible_word_start(cast(GtkTextIter*)cPtr);
    return _retval;
  }

  /**
   * Calls [Gtk.TextIter.backwardVisibleWordStart] up to count times.
   * Params:
   *   count = number of times to move
   * Returns: %TRUE if iter moved and is not the end iterator
   */
  bool backwardVisibleWordStarts(int count)
  {
    bool _retval;
    _retval = gtk_text_iter_backward_visible_word_starts(cast(GtkTextIter*)cPtr, count);
    return _retval;
  }

  /**
   * Moves backward to the previous word start.
   * If iter is currently on a word start, moves backward to the
   * next one after that.
   * Word breaks are determined by Pango and should be correct
   * for nearly any language
   * Returns: %TRUE if iter moved and is not the end iterator
   */
  bool backwardWordStart()
  {
    bool _retval;
    _retval = gtk_text_iter_backward_word_start(cast(GtkTextIter*)cPtr);
    return _retval;
  }

  /**
   * Calls [Gtk.TextIter.backwardWordStart] up to count times.
   * Params:
   *   count = number of times to move
   * Returns: %TRUE if iter moved and is not the end iterator
   */
  bool backwardWordStarts(int count)
  {
    bool _retval;
    _retval = gtk_text_iter_backward_word_starts(cast(GtkTextIter*)cPtr, count);
    return _retval;
  }

  /**
   * Considering the default editability of the buffer, and tags that
   * affect editability, determines whether text inserted at iter would
   * be editable.
   * If text inserted at iter would be editable then the
   * user should be allowed to insert text at iter.
   * [Gtk.TextBuffer.insertInteractive] uses this function
   * to decide whether insertions are allowed at a given position.
   * Params:
   *   defaultEditability = %TRUE if text is editable by default
   * Returns: whether text inserted at iter would be editable
   */
  bool canInsert(bool defaultEditability)
  {
    bool _retval;
    _retval = gtk_text_iter_can_insert(cast(GtkTextIter*)cPtr, defaultEditability);
    return _retval;
  }

  /**
   * A qsort$(LPAREN)$(RPAREN)-style function that returns negative if lhs is less than
   * rhs, positive if lhs is greater than rhs, and 0 if they’re equal.
   * Ordering is in character offset order, i.e. the first character
   * in the buffer is less than the second character in the buffer.
   * Params:
   *   rhs = another `GtkTextIter`
   * Returns: -1 if lhs is less than rhs, 1 if lhs is greater, 0 if they are equal
   */
  int compare(TextIter rhs)
  {
    int _retval;
    _retval = gtk_text_iter_compare(cast(GtkTextIter*)cPtr, rhs ? cast(GtkTextIter*)rhs.cPtr(false) : null);
    return _retval;
  }

  /**
   * Creates a dynamically-allocated copy of an iterator.
   * This function is not useful in applications, because
   * iterators can be copied with a simple assignment
   * $(LPAREN)`GtkTextIter i \= j;`$(RPAREN).
   * The function is used by language bindings.
   * Returns: a copy of the iter, free with [Gtk.TextIter.free]
   */
  TextIter copy()
  {
    GtkTextIter* _cretval;
    _cretval = gtk_text_iter_copy(cast(GtkTextIter*)cPtr);
    auto _retval = _cretval ? new TextIter(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Returns whether the character at iter is within an editable region
   * of text.
   * Non-editable text is “locked” and can’t be changed by the
   * user via `GtkTextView`. If no tags applied to this text affect
   * editability, default_setting will be returned.
   * You don’t want to use this function to decide whether text can be
   * inserted at iter, because for insertion you don’t want to know
   * whether the char at iter is inside an editable range, you want to
   * know whether a new character inserted at iter would be inside an
   * editable range. Use [Gtk.TextIter.canInsert] to handle this
   * case.
   * Params:
   *   defaultSetting = %TRUE if text is editable by default
   * Returns: whether iter is inside an editable range
   */
  bool editable(bool defaultSetting)
  {
    bool _retval;
    _retval = gtk_text_iter_editable(cast(GtkTextIter*)cPtr, defaultSetting);
    return _retval;
  }

  /**
   * Returns %TRUE if iter points to the start of the paragraph
   * delimiter characters for a line.
   * Delimiters will be either a newline, a carriage return, a carriage
   * return followed by a newline, or a Unicode paragraph separator
   * character.
   * Note that an iterator pointing to the \n of a \r\n pair will not be
   * counted as the end of a line, the line ends before the \r. The end
   * iterator is considered to be at the end of a line, even though there
   * are no paragraph delimiter chars there.
   * Returns: whether iter is at the end of a line
   */
  bool endsLine()
  {
    bool _retval;
    _retval = gtk_text_iter_ends_line(cast(GtkTextIter*)cPtr);
    return _retval;
  }

  /**
   * Determines whether iter ends a sentence.
   * Sentence boundaries are determined by Pango and should
   * be correct for nearly any language.
   * Returns: %TRUE if iter is at the end of a sentence.
   */
  bool endsSentence()
  {
    bool _retval;
    _retval = gtk_text_iter_ends_sentence(cast(GtkTextIter*)cPtr);
    return _retval;
  }

  /**
   * Returns %TRUE if tag is toggled off at exactly this point.
   * If tag is %NULL, returns %TRUE if any tag is toggled off at this point.
   * Note that if this function returns %TRUE, it means that
   * iter is at the end of the tagged range, but that the character
   * at iter is outside the tagged range. In other words,
   * unlike [Gtk.TextIter.startsTag], if this function
   * returns %TRUE, [Gtk.TextIter.hasTag] will return
   * %FALSE for the same parameters.
   * Params:
   *   tag = a `GtkTextTag`
   * Returns: whether iter is the end of a range tagged with tag
   */
  bool endsTag(TextTag tag)
  {
    bool _retval;
    _retval = gtk_text_iter_ends_tag(cast(GtkTextIter*)cPtr, tag ? cast(GtkTextTag*)tag.cPtr(false) : null);
    return _retval;
  }

  /**
   * Determines whether iter ends a natural-language word.
   * Word breaks are determined by Pango and should be correct
   * for nearly any language.
   * Returns: %TRUE if iter is at the end of a word
   */
  bool endsWord()
  {
    bool _retval;
    _retval = gtk_text_iter_ends_word(cast(GtkTextIter*)cPtr);
    return _retval;
  }

  /**
   * Tests whether two iterators are equal, using the fastest possible
   * mechanism.
   * This function is very fast; you can expect it to perform
   * better than e.g. getting the character offset for each
   * iterator and comparing the offsets yourself. Also, it’s a
   * bit faster than [Gtk.TextIter.compare].
   * Params:
   *   rhs = another `GtkTextIter`
   * Returns: %TRUE if the iterators point to the same place in the buffer
   */
  bool equal(TextIter rhs)
  {
    bool _retval;
    _retval = gtk_text_iter_equal(cast(GtkTextIter*)cPtr, rhs ? cast(GtkTextIter*)rhs.cPtr(false) : null);
    return _retval;
  }

  /**
   * Moves iter forward by one character offset.
   * Note that images embedded in the buffer occupy 1 character slot, so
   * this function may actually move onto an image instead of a character,
   * if you have images in your buffer. If iter is the end iterator or
   * one character before it, iter will now point at the end iterator,
   * and this function returns %FALSE for convenience when writing loops.
   * Returns: whether iter moved and is dereferenceable
   */
  bool forwardChar()
  {
    bool _retval;
    _retval = gtk_text_iter_forward_char(cast(GtkTextIter*)cPtr);
    return _retval;
  }

  /**
   * Moves count characters if possible.
   * If count would move past the start or end of the buffer,
   * moves to the start or end of the buffer.
   * The return value indicates whether the new position of
   * iter is different from its original position, and dereferenceable
   * $(LPAREN)the last iterator in the buffer is not dereferenceable$(RPAREN). If count
   * is 0, the function does nothing and returns %FALSE.
   * Params:
   *   count = number of characters to move, may be negative
   * Returns: whether iter moved and is dereferenceable
   */
  bool forwardChars(int count)
  {
    bool _retval;
    _retval = gtk_text_iter_forward_chars(cast(GtkTextIter*)cPtr, count);
    return _retval;
  }

  /**
   * Moves iter forward by a single cursor position.
   * Cursor positions are $(LPAREN)unsurprisingly$(RPAREN) positions where the
   * cursor can appear. Perhaps surprisingly, there may not be
   * a cursor position between all characters. The most common
   * example for European languages would be a carriage return/newline
   * sequence.
   * For some Unicode characters, the equivalent of say the letter “a”
   * with an accent mark will be represented as two characters, first
   * the letter then a "combining mark" that causes the accent to be
   * rendered; so the cursor can’t go between those two characters.
   * See also the [Pango.LogAttr] struct and the funcPango.break
   * function.
   * Returns: %TRUE if we moved and the new position is dereferenceable
   */
  bool forwardCursorPosition()
  {
    bool _retval;
    _retval = gtk_text_iter_forward_cursor_position(cast(GtkTextIter*)cPtr);
    return _retval;
  }

  /**
   * Moves up to count cursor positions.
   * See [Gtk.TextIter.forwardCursorPosition] for details.
   * Params:
   *   count = number of positions to move
   * Returns: %TRUE if we moved and the new position is dereferenceable
   */
  bool forwardCursorPositions(int count)
  {
    bool _retval;
    _retval = gtk_text_iter_forward_cursor_positions(cast(GtkTextIter*)cPtr, count);
    return _retval;
  }

  /**
   * Advances iter, calling pred on each character.
   * If pred returns %TRUE, returns %TRUE and stops scanning.
   * If pred never returns %TRUE, iter is set to limit if
   * limit is non-%NULL, otherwise to the end iterator.
   * Params:
   *   pred = a function to be called on each character
   *   limit = search limit
   * Returns: whether a match was found
   */
  bool forwardFindChar(TextCharPredicate pred, TextIter limit)
  {
    extern(C) bool _predCallback(dchar ch, void* userData)
    {
      auto _dlg = cast(TextCharPredicate*)userData;

      bool _retval = (*_dlg)(ch);
      return _retval;
    }

    bool _retval;
    auto _pred = cast(void*)&pred;
    _retval = gtk_text_iter_forward_find_char(cast(GtkTextIter*)cPtr, &_predCallback, _pred, limit ? cast(GtkTextIter*)limit.cPtr(false) : null);
    return _retval;
  }

  /**
   * Moves iter to the start of the next line.
   * If the iter is already on the last line of the buffer,
   * moves the iter to the end of the current line. If after
   * the operation, the iter is at the end of the buffer and not
   * dereferenceable, returns %FALSE. Otherwise, returns %TRUE.
   * Returns: whether iter can be dereferenced
   */
  bool forwardLine()
  {
    bool _retval;
    _retval = gtk_text_iter_forward_line(cast(GtkTextIter*)cPtr);
    return _retval;
  }

  /**
   * Moves count lines forward, if possible.
   * If count would move past the start or end of the buffer, moves to
   * the start or end of the buffer.
   * The return value indicates whether the iterator moved
   * onto a dereferenceable position; if the iterator didn’t move, or
   * moved onto the end iterator, then %FALSE is returned. If count is 0,
   * the function does nothing and returns %FALSE. If count is negative,
   * moves backward by 0 - count lines.
   * Params:
   *   count = number of lines to move forward
   * Returns: whether iter moved and is dereferenceable
   */
  bool forwardLines(int count)
  {
    bool _retval;
    _retval = gtk_text_iter_forward_lines(cast(GtkTextIter*)cPtr, count);
    return _retval;
  }

  /**
   * Searches forward for str.
   * Any match is returned by setting match_start to the first character
   * of the match and match_end to the first character after the match.
   * The search will not continue past limit. Note that a search is a
   * linear or O$(LPAREN)n$(RPAREN) operation, so you may wish to use limit to avoid
   * locking up your UI on large buffers.
   * match_start will never be set to a `GtkTextIter` located before iter,
   * even if there is a possible match_end after or at iter.
   * Params:
   *   str = a search string
   *   flags = flags affecting how the search is done
   *   matchStart = return location for start of match
   *   matchEnd = return location for end of match
   *   limit = location of last possible match_end, or %NULL for the end of the buffer
   * Returns: whether a match was found
   */
  bool forwardSearch(string str, TextSearchFlags flags, out TextIter matchStart, out TextIter matchEnd, TextIter limit)
  {
    bool _retval;
    const(char)* _str = str.toCString(false);
    GtkTextIter _matchStart;
    GtkTextIter _matchEnd;
    _retval = gtk_text_iter_forward_search(cast(GtkTextIter*)cPtr, _str, flags, &_matchStart, &_matchEnd, limit ? cast(GtkTextIter*)limit.cPtr(false) : null);
    matchStart = new TextIter(cast(void*)&_matchStart, false);
    matchEnd = new TextIter(cast(void*)&_matchEnd, false);
    return _retval;
  }

  /**
   * Moves forward to the next sentence end.
   * If iter is at the end of a sentence, moves to the next
   * end of sentence.
   * Sentence boundaries are determined by Pango and should
   * be correct for nearly any language.
   * Returns: %TRUE if iter moved and is not the end iterator
   */
  bool forwardSentenceEnd()
  {
    bool _retval;
    _retval = gtk_text_iter_forward_sentence_end(cast(GtkTextIter*)cPtr);
    return _retval;
  }

  /**
   * Calls [Gtk.TextIter.forwardSentenceEnd] count times.
   * If count is negative, moves backward instead of forward.
   * Params:
   *   count = number of sentences to move
   * Returns: %TRUE if iter moved and is not the end iterator
   */
  bool forwardSentenceEnds(int count)
  {
    bool _retval;
    _retval = gtk_text_iter_forward_sentence_ends(cast(GtkTextIter*)cPtr, count);
    return _retval;
  }

  /**
   * Moves iter forward to the “end iterator”, which points
   * one past the last valid character in the buffer.
   * [Gtk.TextIter.getChar] called on the end iterator
   * returns 0, which is convenient for writing loops.
   */
  void forwardToEnd()
  {
    gtk_text_iter_forward_to_end(cast(GtkTextIter*)cPtr);
  }

  /**
   * Moves the iterator to point to the paragraph delimiter characters.
   * The possible characters are either a newline, a carriage return,
   * a carriage return/newline in sequence, or the Unicode paragraph
   * separator character.
   * If the iterator is already at the paragraph delimiter
   * characters, moves to the paragraph delimiter characters for the
   * next line. If iter is on the last line in the buffer, which does
   * not end in paragraph delimiters, moves to the end iterator $(LPAREN)end of
   * the last line$(RPAREN), and returns %FALSE.
   * Returns: %TRUE if we moved and the new location is not the end iterator
   */
  bool forwardToLineEnd()
  {
    bool _retval;
    _retval = gtk_text_iter_forward_to_line_end(cast(GtkTextIter*)cPtr);
    return _retval;
  }

  /**
   * Moves forward to the next toggle $(LPAREN)on or off$(RPAREN) of the
   * tag, or to the next toggle of any tag if
   * tag is %NULL.
   * If no matching tag toggles are found,
   * returns %FALSE, otherwise %TRUE. Does not return toggles
   * located at iter, only toggles after iter. Sets iter to
   * the location of the toggle, or to the end of the buffer
   * if no toggle is found.
   * Params:
   *   tag = a `GtkTextTag`
   * Returns: whether we found a tag toggle after iter
   */
  bool forwardToTagToggle(TextTag tag)
  {
    bool _retval;
    _retval = gtk_text_iter_forward_to_tag_toggle(cast(GtkTextIter*)cPtr, tag ? cast(GtkTextTag*)tag.cPtr(false) : null);
    return _retval;
  }

  /**
   * Moves iter forward to the next visible cursor position.
   * See [Gtk.TextIter.forwardCursorPosition] for details.
   * Returns: %TRUE if we moved and the new position is dereferenceable
   */
  bool forwardVisibleCursorPosition()
  {
    bool _retval;
    _retval = gtk_text_iter_forward_visible_cursor_position(cast(GtkTextIter*)cPtr);
    return _retval;
  }

  /**
   * Moves up to count visible cursor positions.
   * See [Gtk.TextIter.forwardCursorPosition] for details.
   * Params:
   *   count = number of positions to move
   * Returns: %TRUE if we moved and the new position is dereferenceable
   */
  bool forwardVisibleCursorPositions(int count)
  {
    bool _retval;
    _retval = gtk_text_iter_forward_visible_cursor_positions(cast(GtkTextIter*)cPtr, count);
    return _retval;
  }

  /**
   * Moves iter to the start of the next visible line.
   * Returns %TRUE if there
   * was a next line to move to, and %FALSE if iter was simply moved to
   * the end of the buffer and is now not dereferenceable, or if iter was
   * already at the end of the buffer.
   * Returns: whether iter can be dereferenced
   */
  bool forwardVisibleLine()
  {
    bool _retval;
    _retval = gtk_text_iter_forward_visible_line(cast(GtkTextIter*)cPtr);
    return _retval;
  }

  /**
   * Moves count visible lines forward, if possible.
   * If count would move past the start or end of the buffer, moves to
   * the start or end of the buffer.
   * The return value indicates whether the iterator moved
   * onto a dereferenceable position; if the iterator didn’t move, or
   * moved onto the end iterator, then %FALSE is returned. If count is 0,
   * the function does nothing and returns %FALSE. If count is negative,
   * moves backward by 0 - count lines.
   * Params:
   *   count = number of lines to move forward
   * Returns: whether iter moved and is dereferenceable
   */
  bool forwardVisibleLines(int count)
  {
    bool _retval;
    _retval = gtk_text_iter_forward_visible_lines(cast(GtkTextIter*)cPtr, count);
    return _retval;
  }

  /**
   * Moves forward to the next visible word end.
   * If iter is currently on a word end, moves forward to the
   * next one after that.
   * Word breaks are determined by Pango and should be correct
   * for nearly any language
   * Returns: %TRUE if iter moved and is not the end iterator
   */
  bool forwardVisibleWordEnd()
  {
    bool _retval;
    _retval = gtk_text_iter_forward_visible_word_end(cast(GtkTextIter*)cPtr);
    return _retval;
  }

  /**
   * Calls [Gtk.TextIter.forwardVisibleWordEnd] up to count times.
   * Params:
   *   count = number of times to move
   * Returns: %TRUE if iter moved and is not the end iterator
   */
  bool forwardVisibleWordEnds(int count)
  {
    bool _retval;
    _retval = gtk_text_iter_forward_visible_word_ends(cast(GtkTextIter*)cPtr, count);
    return _retval;
  }

  /**
   * Moves forward to the next word end.
   * If iter is currently on a word end, moves forward to the
   * next one after that.
   * Word breaks are determined by Pango and should be correct
   * for nearly any language.
   * Returns: %TRUE if iter moved and is not the end iterator
   */
  bool forwardWordEnd()
  {
    bool _retval;
    _retval = gtk_text_iter_forward_word_end(cast(GtkTextIter*)cPtr);
    return _retval;
  }

  /**
   * Calls [Gtk.TextIter.forwardWordEnd] up to count times.
   * Params:
   *   count = number of times to move
   * Returns: %TRUE if iter moved and is not the end iterator
   */
  bool forwardWordEnds(int count)
  {
    bool _retval;
    _retval = gtk_text_iter_forward_word_ends(cast(GtkTextIter*)cPtr, count);
    return _retval;
  }

  /**
   * Returns the `GtkTextBuffer` this iterator is associated with.
   * Returns: the buffer
   */
  TextBuffer getBuffer()
  {
    GtkTextBuffer* _cretval;
    _cretval = gtk_text_iter_get_buffer(cast(GtkTextIter*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!TextBuffer(cast(GtkTextBuffer*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns the number of bytes in the line containing iter,
   * including the paragraph delimiters.
   * Returns: number of bytes in the line
   */
  int getBytesInLine()
  {
    int _retval;
    _retval = gtk_text_iter_get_bytes_in_line(cast(GtkTextIter*)cPtr);
    return _retval;
  }

  /**
   * The Unicode character at this iterator is returned.
   * Equivalent to operator* on a C++ iterator. If the element at
   * this iterator is a non-character element, such as an image
   * embedded in the buffer, the Unicode “unknown” character 0xFFFC
   * is returned. If invoked on the end iterator, zero is returned;
   * zero is not a valid Unicode character.
   * So you can write a loop which ends when this function returns 0.
   * Returns: a Unicode character, or 0 if iter is not dereferenceable
   */
  dchar getChar()
  {
    dchar _retval;
    _retval = gtk_text_iter_get_char(cast(GtkTextIter*)cPtr);
    return _retval;
  }

  /**
   * Returns the number of characters in the line containing iter,
   * including the paragraph delimiters.
   * Returns: number of characters in the line
   */
  int getCharsInLine()
  {
    int _retval;
    _retval = gtk_text_iter_get_chars_in_line(cast(GtkTextIter*)cPtr);
    return _retval;
  }

  /**
   * If the location at iter contains a child anchor, the
   * anchor is returned.
   * Otherwise, %NULL is returned.
   * Returns: the anchor at iter
   */
  TextChildAnchor getChildAnchor()
  {
    GtkTextChildAnchor* _cretval;
    _cretval = gtk_text_iter_get_child_anchor(cast(GtkTextIter*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!TextChildAnchor(cast(GtkTextChildAnchor*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns the language in effect at iter.
   * If no tags affecting language apply to iter, the return
   * value is identical to that of funcGtk.get_default_language.
   * Returns: language in effect at iter
   */
  PgLanguage getLanguage()
  {
    PangoLanguage* _cretval;
    _cretval = gtk_text_iter_get_language(cast(GtkTextIter*)cPtr);
    auto _retval = _cretval ? new PgLanguage(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Returns the line number containing the iterator.
   * Lines in a `GtkTextBuffer` are numbered beginning
   * with 0 for the first line in the buffer.
   * Returns: a line number
   */
  int getLine()
  {
    int _retval;
    _retval = gtk_text_iter_get_line(cast(GtkTextIter*)cPtr);
    return _retval;
  }

  /**
   * Returns the byte index of the iterator, counting
   * from the start of a newline-terminated line.
   * Remember that `GtkTextBuffer` encodes text in
   * UTF-8, and that characters can require a variable
   * number of bytes to represent.
   * Returns: distance from start of line, in bytes
   */
  int getLineIndex()
  {
    int _retval;
    _retval = gtk_text_iter_get_line_index(cast(GtkTextIter*)cPtr);
    return _retval;
  }

  /**
   * Returns the character offset of the iterator,
   * counting from the start of a newline-terminated line.
   * The first character on the line has offset 0.
   * Returns: offset from start of line
   */
  int getLineOffset()
  {
    int _retval;
    _retval = gtk_text_iter_get_line_offset(cast(GtkTextIter*)cPtr);
    return _retval;
  }

  /**
   * Returns a list of all `GtkTextMark` at this location.
   * Because marks are not iterable $(LPAREN)they don’t take up any "space"
   * in the buffer, they are just marks in between iterable locations$(RPAREN),
   * multiple marks can exist in the same place.
   * The returned list is not in any meaningful order.
   * Returns: list of `GtkTextMark`
   */
  TextMark[] getMarks()
  {
    GSList* _cretval;
    _cretval = gtk_text_iter_get_marks(cast(GtkTextIter*)cPtr);
    auto _retval = gSListToD!(TextMark, GidOwnership.Container)(cast(GSList*)_cretval);
    return _retval;
  }

  /**
   * Returns the character offset of an iterator.
   * Each character in a `GtkTextBuffer` has an offset,
   * starting with 0 for the first character in the buffer.
   * Use [Gtk.TextBuffer.getIterAtOffset] to convert
   * an offset back into an iterator.
   * Returns: a character offset
   */
  int getOffset()
  {
    int _retval;
    _retval = gtk_text_iter_get_offset(cast(GtkTextIter*)cPtr);
    return _retval;
  }

  /**
   * If the element at iter is a paintable, the paintable is returned.
   * Otherwise, %NULL is returned.
   * Returns: the paintable at iter
   */
  Paintable getPaintable()
  {
    GdkPaintable* _cretval;
    _cretval = gtk_text_iter_get_paintable(cast(GtkTextIter*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Paintable(cast(GdkPaintable*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns the text in the given range.
   * A “slice” is an array of characters encoded in UTF-8 format,
   * including the Unicode “unknown” character 0xFFFC for iterable
   * non-character elements in the buffer, such as images.
   * Because images are encoded in the slice, byte and
   * character offsets in the returned array will correspond to byte
   * offsets in the text buffer. Note that 0xFFFC can occur in normal
   * text as well, so it is not a reliable indicator that a paintable or
   * widget is in the buffer.
   * Params:
   *   end = iterator at end of a range
   * Returns: slice of text from the buffer
   */
  string getSlice(TextIter end)
  {
    char* _cretval;
    _cretval = gtk_text_iter_get_slice(cast(GtkTextIter*)cPtr, end ? cast(GtkTextIter*)end.cPtr(false) : null);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * Returns a list of tags that apply to iter, in ascending order of
   * priority.
   * The highest-priority tags are last.
   * The `GtkTextTag`s in the list don’t have a reference added,
   * but you have to free the list itself.
   * Returns: list of
   *   `GtkTextTag`
   */
  TextTag[] getTags()
  {
    GSList* _cretval;
    _cretval = gtk_text_iter_get_tags(cast(GtkTextIter*)cPtr);
    auto _retval = gSListToD!(TextTag, GidOwnership.Container)(cast(GSList*)_cretval);
    return _retval;
  }

  /**
   * Returns text in the given range.
   * If the range
   * contains non-text elements such as images, the character and byte
   * offsets in the returned string will not correspond to character and
   * byte offsets in the buffer. If you want offsets to correspond, see
   * [Gtk.TextIter.getSlice].
   * Params:
   *   end = iterator at end of a range
   * Returns: array of characters from the buffer
   */
  string getText(TextIter end)
  {
    char* _cretval;
    _cretval = gtk_text_iter_get_text(cast(GtkTextIter*)cPtr, end ? cast(GtkTextIter*)end.cPtr(false) : null);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * Returns a list of `GtkTextTag` that are toggled on or off at this
   * point.
   * If toggled_on is %TRUE, the list contains tags that are
   * toggled on. If a tag is toggled on at iter, then some non-empty
   * range of characters following iter has that tag applied to it.  If
   * a tag is toggled off, then some non-empty range following iter
   * does not have the tag applied to it.
   * Params:
   *   toggledOn = %TRUE to get toggled-on tags
   * Returns: tags
   *   toggled at this point
   */
  TextTag[] getToggledTags(bool toggledOn)
  {
    GSList* _cretval;
    _cretval = gtk_text_iter_get_toggled_tags(cast(GtkTextIter*)cPtr, toggledOn);
    auto _retval = gSListToD!(TextTag, GidOwnership.Container)(cast(GSList*)_cretval);
    return _retval;
  }

  /**
   * Returns the number of bytes from the start of the
   * line to the given iter, not counting bytes that
   * are invisible due to tags with the “invisible” flag
   * toggled on.
   * Returns: byte index of iter with respect to the start of the line
   */
  int getVisibleLineIndex()
  {
    int _retval;
    _retval = gtk_text_iter_get_visible_line_index(cast(GtkTextIter*)cPtr);
    return _retval;
  }

  /**
   * Returns the offset in characters from the start of the
   * line to the given iter, not counting characters that
   * are invisible due to tags with the “invisible” flag
   * toggled on.
   * Returns: offset in visible characters from the start of the line
   */
  int getVisibleLineOffset()
  {
    int _retval;
    _retval = gtk_text_iter_get_visible_line_offset(cast(GtkTextIter*)cPtr);
    return _retval;
  }

  /**
   * Returns visible text in the given range.
   * Like [Gtk.TextIter.getSlice], but invisible text
   * is not included. Invisible text is usually invisible because
   * a `GtkTextTag` with the “invisible” attribute turned on has
   * been applied to it.
   * Params:
   *   end = iterator at end of range
   * Returns: slice of text from the buffer
   */
  string getVisibleSlice(TextIter end)
  {
    char* _cretval;
    _cretval = gtk_text_iter_get_visible_slice(cast(GtkTextIter*)cPtr, end ? cast(GtkTextIter*)end.cPtr(false) : null);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * Returns visible text in the given range.
   * Like [Gtk.TextIter.getText], but invisible text
   * is not included. Invisible text is usually invisible because
   * a `GtkTextTag` with the “invisible” attribute turned on has
   * been applied to it.
   * Params:
   *   end = iterator at end of range
   * Returns: string containing visible text in the
   *   range
   */
  string getVisibleText(TextIter end)
  {
    char* _cretval;
    _cretval = gtk_text_iter_get_visible_text(cast(GtkTextIter*)cPtr, end ? cast(GtkTextIter*)end.cPtr(false) : null);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * Returns %TRUE if iter points to a character that is part
   * of a range tagged with tag.
   * See also [Gtk.TextIter.startsTag] and
   * [Gtk.TextIter.endsTag].
   * Params:
   *   tag = a `GtkTextTag`
   * Returns: whether iter is tagged with tag
   */
  bool hasTag(TextTag tag)
  {
    bool _retval;
    _retval = gtk_text_iter_has_tag(cast(GtkTextIter*)cPtr, tag ? cast(GtkTextTag*)tag.cPtr(false) : null);
    return _retval;
  }

  /**
   * Checks whether iter falls in the range [start, end$(RPAREN).
   * start and end must be in ascending order.
   * Params:
   *   start = start of range
   *   end = end of range
   * Returns: %TRUE if iter is in the range
   */
  bool inRange(TextIter start, TextIter end)
  {
    bool _retval;
    _retval = gtk_text_iter_in_range(cast(GtkTextIter*)cPtr, start ? cast(GtkTextIter*)start.cPtr(false) : null, end ? cast(GtkTextIter*)end.cPtr(false) : null);
    return _retval;
  }

  /**
   * Determines whether iter is inside a sentence $(LPAREN)as opposed to in
   * between two sentences, e.g. after a period and before the first
   * letter of the next sentence$(RPAREN).
   * Sentence boundaries are determined by Pango and should be correct
   * for nearly any language.
   * Returns: %TRUE if iter is inside a sentence.
   */
  bool insideSentence()
  {
    bool _retval;
    _retval = gtk_text_iter_inside_sentence(cast(GtkTextIter*)cPtr);
    return _retval;
  }

  /**
   * Determines whether the character pointed by iter is part of a
   * natural-language word $(LPAREN)as opposed to say inside some whitespace$(RPAREN).
   * Word breaks are determined by Pango and should be correct
   * for nearly any language.
   * Note that if [Gtk.TextIter.startsWord] returns %TRUE,
   * then this function returns %TRUE too, since iter points to
   * the first character of the word.
   * Returns: %TRUE if iter is inside a word
   */
  bool insideWord()
  {
    bool _retval;
    _retval = gtk_text_iter_inside_word(cast(GtkTextIter*)cPtr);
    return _retval;
  }

  /**
   * Determine if iter is at a cursor position.
   * See [Gtk.TextIter.forwardCursorPosition] or
   * [Pango.LogAttr] or funcPango.break for details
   * on what a cursor position is.
   * Returns: %TRUE if the cursor can be placed at iter
   */
  bool isCursorPosition()
  {
    bool _retval;
    _retval = gtk_text_iter_is_cursor_position(cast(GtkTextIter*)cPtr);
    return _retval;
  }

  /**
   * Returns %TRUE if iter is the end iterator.
   * This means it is one past the last dereferenceable iterator
   * in the buffer. [Gtk.TextIter.isEnd] is the most efficient
   * way to check whether an iterator is the end iterator.
   * Returns: whether iter is the end iterator
   */
  bool isEnd()
  {
    bool _retval;
    _retval = gtk_text_iter_is_end(cast(GtkTextIter*)cPtr);
    return _retval;
  }

  /**
   * Returns %TRUE if iter is the first iterator in the buffer.
   * Returns: whether iter is the first in the buffer
   */
  bool isStart()
  {
    bool _retval;
    _retval = gtk_text_iter_is_start(cast(GtkTextIter*)cPtr);
    return _retval;
  }

  /**
   * Swaps the value of first and second if second comes before
   * first in the buffer.
   * That is, ensures that first and second are in sequence.
   * Most text buffer functions that take a range call this
   * automatically on your behalf, so there’s no real reason to
   * call it yourself in those cases. There are some exceptions,
   * such as [Gtk.TextIter.inRange], that expect a
   * pre-sorted range.
   * Params:
   *   second = another `GtkTextIter`
   */
  void order(TextIter second)
  {
    gtk_text_iter_order(cast(GtkTextIter*)cPtr, second ? cast(GtkTextIter*)second.cPtr(false) : null);
  }

  /**
   * Moves iterator iter to the start of the line line_number.
   * If line_number is negative or larger than or equal to the number of lines
   * in the buffer, moves iter to the start of the last line in the buffer.
   * Params:
   *   lineNumber = line number $(LPAREN)counted from 0$(RPAREN)
   */
  void setLine(int lineNumber)
  {
    gtk_text_iter_set_line(cast(GtkTextIter*)cPtr, lineNumber);
  }

  /**
   * Same as [Gtk.TextIter.setLineOffset], but works with a
   * byte index. The given byte index must be at
   * the start of a character, it can’t be in the middle of a UTF-8
   * encoded character.
   * Params:
   *   byteOnLine = a byte index relative to the start of iter’s current line
   */
  void setLineIndex(int byteOnLine)
  {
    gtk_text_iter_set_line_index(cast(GtkTextIter*)cPtr, byteOnLine);
  }

  /**
   * Moves iter within a line, to a new character $(LPAREN)not byte$(RPAREN) offset.
   * The given character offset must be less than or equal to the number
   * of characters in the line; if equal, iter moves to the start of the
   * next line. See [Gtk.TextIter.setLineIndex] if you have a byte
   * index rather than a character offset.
   * Params:
   *   charOnLine = a character offset relative to the start of iter’s current line
   */
  void setLineOffset(int charOnLine)
  {
    gtk_text_iter_set_line_offset(cast(GtkTextIter*)cPtr, charOnLine);
  }

  /**
   * Sets iter to point to char_offset.
   * char_offset counts from the start
   * of the entire text buffer, starting with 0.
   * Params:
   *   charOffset = a character number
   */
  void setOffset(int charOffset)
  {
    gtk_text_iter_set_offset(cast(GtkTextIter*)cPtr, charOffset);
  }

  /**
   * Like [Gtk.TextIter.setLineIndex], but the index is in visible
   * bytes, i.e. text with a tag making it invisible is not counted
   * in the index.
   * Params:
   *   byteOnLine = a byte index
   */
  void setVisibleLineIndex(int byteOnLine)
  {
    gtk_text_iter_set_visible_line_index(cast(GtkTextIter*)cPtr, byteOnLine);
  }

  /**
   * Like [Gtk.TextIter.setLineOffset], but the offset is in visible
   * characters, i.e. text with a tag making it invisible is not
   * counted in the offset.
   * Params:
   *   charOnLine = a character offset
   */
  void setVisibleLineOffset(int charOnLine)
  {
    gtk_text_iter_set_visible_line_offset(cast(GtkTextIter*)cPtr, charOnLine);
  }

  /**
   * Returns %TRUE if iter begins a paragraph.
   * This is the case if [Gtk.TextIter.getLineOffset]
   * would return 0. However this function is potentially more
   * efficient than [Gtk.TextIter.getLineOffset], because
   * it doesn’t have to compute the offset, it just has to see
   * whether it’s 0.
   * Returns: whether iter begins a line
   */
  bool startsLine()
  {
    bool _retval;
    _retval = gtk_text_iter_starts_line(cast(GtkTextIter*)cPtr);
    return _retval;
  }

  /**
   * Determines whether iter begins a sentence.
   * Sentence boundaries are determined by Pango and
   * should be correct for nearly any language.
   * Returns: %TRUE if iter is at the start of a sentence.
   */
  bool startsSentence()
  {
    bool _retval;
    _retval = gtk_text_iter_starts_sentence(cast(GtkTextIter*)cPtr);
    return _retval;
  }

  /**
   * Returns %TRUE if tag is toggled on at exactly this point.
   * If tag is %NULL, returns %TRUE if any tag is toggled on at this point.
   * Note that if this function returns %TRUE, it means that
   * iter is at the beginning of the tagged range, and that the
   * character at iter is inside the tagged range. In other
   * words, unlike [Gtk.TextIter.endsTag], if
   * this function returns %TRUE, [Gtk.TextIter.hasTag]
   * will also return %TRUE for the same parameters.
   * Params:
   *   tag = a `GtkTextTag`
   * Returns: whether iter is the start of a range tagged with tag
   */
  bool startsTag(TextTag tag)
  {
    bool _retval;
    _retval = gtk_text_iter_starts_tag(cast(GtkTextIter*)cPtr, tag ? cast(GtkTextTag*)tag.cPtr(false) : null);
    return _retval;
  }

  /**
   * Determines whether iter begins a natural-language word.
   * Word breaks are determined by Pango and should be correct
   * for nearly any language.
   * Returns: %TRUE if iter is at the start of a word
   */
  bool startsWord()
  {
    bool _retval;
    _retval = gtk_text_iter_starts_word(cast(GtkTextIter*)cPtr);
    return _retval;
  }

  /**
   * Gets whether a range with tag applied to it begins
   * or ends at iter.
   * This is equivalent to $(LPAREN)[Gtk.TextIter.startsTag] ||
   * [Gtk.TextIter.endsTag]$(RPAREN)
   * Params:
   *   tag = a `GtkTextTag`
   * Returns: whether tag is toggled on or off at iter
   */
  bool togglesTag(TextTag tag)
  {
    bool _retval;
    _retval = gtk_text_iter_toggles_tag(cast(GtkTextIter*)cPtr, tag ? cast(GtkTextTag*)tag.cPtr(false) : null);
    return _retval;
  }
}
