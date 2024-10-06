module Gtk.TextChildAnchor;

import GObject.ObjectG;
import Gid.gid;
import Gtk.Types;
import Gtk.Widget;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * A `GtkTextChildAnchor` is a spot in a `GtkTextBuffer` where child widgets can
 * be “anchored”.
 * The anchor can have multiple widgets anchored, to allow for multiple views.
 */
class TextChildAnchor : ObjectG
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return gtk_text_child_anchor_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new `GtkTextChildAnchor`.
   * Usually you would then insert it into a `GtkTextBuffer` with
   * [Gtk.TextBuffer.insertChildAnchor]. To perform the
   * creation and insertion in one step, use the convenience
   * function [Gtk.TextBuffer.createChildAnchor].
   * Returns: a new `GtkTextChildAnchor`
   */
  this()
  {
    GtkTextChildAnchor* _cretval;
    _cretval = gtk_text_child_anchor_new();
    this(_cretval, true);
  }

  /**
   * Creates a new `GtkTextChildAnchor` with the given replacement character.
   * Usually you would then insert it into a `GtkTextBuffer` with
   * [Gtk.TextBuffer.insertChildAnchor].
   * Params:
   *   character =
   * Returns: a new `GtkTextChildAnchor`
   */
  static TextChildAnchor newWithReplacement(string character)
  {
    GtkTextChildAnchor* _cretval;
    const(char)* _character = character.toCString(false);
    _cretval = gtk_text_child_anchor_new_with_replacement(_character);
    auto _retval = _cretval ? ObjectG.getDObject!TextChildAnchor(cast(GtkTextChildAnchor*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Determines whether a child anchor has been deleted from
   * the buffer.
   * Keep in mind that the child anchor will be unreferenced
   * when removed from the buffer, so you need to hold your own
   * reference $(LPAREN)with [GObject.ObjectG.ref_]$(RPAREN) if you plan to use this
   * function — otherwise all deleted child anchors will also
   * be finalized.
   * Returns: %TRUE if the child anchor has been deleted from its buffer
   */
  bool getDeleted()
  {
    bool _retval;
    _retval = gtk_text_child_anchor_get_deleted(cast(GtkTextChildAnchor*)cPtr);
    return _retval;
  }

  /**
   * Gets a list of all widgets anchored at this child anchor.
   * The order in which the widgets are returned is not defined.
   * Returns: an
   *   array of widgets anchored at anchor
   */
  Widget[] getWidgets()
  {
    GtkWidget** _cretval;
    uint _cretlength;
    _cretval = gtk_text_child_anchor_get_widgets(cast(GtkTextChildAnchor*)cPtr, &_cretlength);
    Widget[] _retval;

    if (_cretval)
    {
      _retval = new Widget[_cretlength];
      foreach (i; 0 .. _cretlength)
        _retval[i] = ObjectG.getDObject!Widget(_cretval[i], false);
    }
    return _retval;
  }
}
