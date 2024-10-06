module Gtk.TextMark;

import GObject.ObjectG;
import Gid.gid;
import Gtk.TextBuffer;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * A `GtkTextMark` is a position in a `GtkTextbuffer` that is preserved
 * across modifications.
 * You may wish to begin by reading the
 * [text widget conceptual overview](section-text-widget.html),
 * which gives an overview of all the objects and data types
 * related to the text widget and how they work together.
 * A `GtkTextMark` is like a bookmark in a text buffer; it preserves
 * a position in the text. You can convert the mark to an iterator using
 * [Gtk.TextBuffer.getIterAtMark]. Unlike iterators, marks remain
 * valid across buffer mutations, because their behavior is defined when
 * text is inserted or deleted. When text containing a mark is deleted,
 * the mark remains in the position originally occupied by the deleted
 * text. When text is inserted at a mark, a mark with “left gravity” will
 * be moved to the beginning of the newly-inserted text, and a mark with
 * “right gravity” will be moved to the end.
 * Note that “left” and “right” here refer to logical direction $(LPAREN)left
 * is the toward the start of the buffer$(RPAREN); in some languages such as
 * Hebrew the logically-leftmost text is not actually on the left when
 * displayed.
 * Marks are reference counted, but the reference count only controls
 * the validity of the memory; marks can be deleted from the buffer at
 * any time with [Gtk.TextBuffer.deleteMark]. Once deleted from
 * the buffer, a mark is essentially useless.
 * Marks optionally have names; these can be convenient to avoid passing
 * the `GtkTextMark` object around.
 * Marks are typically created using the [Gtk.TextBuffer.createMark]
 * function.
 */
class TextMark : ObjectG
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
    return gtk_text_mark_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a text mark.
   * Add it to a buffer using [Gtk.TextBuffer.addMark].
   * If name is %NULL, the mark is anonymous; otherwise, the mark can be
   * retrieved by name using [Gtk.TextBuffer.getMark]. If a mark
   * has left gravity, and text is inserted at the mark’s current location,
   * the mark will be moved to the left of the newly-inserted text. If the
   * mark has right gravity $(LPAREN)left_gravity \= %FALSE$(RPAREN), the mark will end up
   * on the right of newly-inserted text. The standard left-to-right cursor
   * is a mark with right gravity $(LPAREN)when you type, the cursor stays on the
   * right side of the text you’re typing$(RPAREN).
   * Params:
   *   name = mark name
   *   leftGravity = whether the mark should have left gravity
   * Returns: new `GtkTextMark`
   */
  this(string name, bool leftGravity)
  {
    GtkTextMark* _cretval;
    const(char)* _name = name.toCString(false);
    _cretval = gtk_text_mark_new(_name, leftGravity);
    this(_cretval, true);
  }

  /**
   * Gets the buffer this mark is located inside.
   * Returns %NULL if the mark is deleted.
   * Returns: the mark’s `GtkTextBuffer`
   */
  TextBuffer getBuffer()
  {
    GtkTextBuffer* _cretval;
    _cretval = gtk_text_mark_get_buffer(cast(GtkTextMark*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!TextBuffer(cast(GtkTextBuffer*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns %TRUE if the mark has been removed from its buffer.
   * See [Gtk.TextBuffer.addMark] for a way to add it
   * to a buffer again.
   * Returns: whether the mark is deleted
   */
  bool getDeleted()
  {
    bool _retval;
    _retval = gtk_text_mark_get_deleted(cast(GtkTextMark*)cPtr);
    return _retval;
  }

  /**
   * Determines whether the mark has left gravity.
   * Returns: %TRUE if the mark has left gravity, %FALSE otherwise
   */
  bool getLeftGravity()
  {
    bool _retval;
    _retval = gtk_text_mark_get_left_gravity(cast(GtkTextMark*)cPtr);
    return _retval;
  }

  /**
   * Returns the mark name.
   * Returns %NULL for anonymous marks.
   * Returns: mark name
   */
  string getName()
  {
    const(char)* _cretval;
    _cretval = gtk_text_mark_get_name(cast(GtkTextMark*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Returns %TRUE if the mark is visible.
   * A cursor is displayed for visible marks.
   * Returns: %TRUE if visible
   */
  bool getVisible()
  {
    bool _retval;
    _retval = gtk_text_mark_get_visible(cast(GtkTextMark*)cPtr);
    return _retval;
  }

  void setVisible(bool setting)
  {
    gtk_text_mark_set_visible(cast(GtkTextMark*)cPtr, setting);
  }
}
