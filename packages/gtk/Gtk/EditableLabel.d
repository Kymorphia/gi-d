module Gtk.EditableLabel;

import Gid.gid;
import Gtk.Accessible;
import Gtk.AccessibleT;
import Gtk.Buildable;
import Gtk.BuildableT;
import Gtk.ConstraintTarget;
import Gtk.ConstraintTargetT;
import Gtk.Editable;
import Gtk.EditableT;
import Gtk.Types;
import Gtk.Widget;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * A `GtkEditableLabel` is a label that allows users to
 * edit the text by switching to an “edit mode”.
 * ![An example GtkEditableLabel](editable-label.png)
 * `GtkEditableLabel` does not have API of its own, but it
 * implements the [Gtk.Editable] interface.
 * The default bindings for activating the edit mode is
 * to click or press the Enter key. The default bindings
 * for leaving the edit mode are the Enter key $(LPAREN)to save
 * the results$(RPAREN) or the Escape key $(LPAREN)to cancel the editing$(RPAREN).
 * # CSS nodes
 * ```
 * editablelabel[.editing]
 * ╰── stack
 * ├── label
 * ╰── text
 * ```
 * `GtkEditableLabel` has a main node with the name editablelabel.
 * When the entry is in editing mode, it gets the .editing style
 * class.
 * For all the subnodes added to the text node in various situations,
 * see [Gtk.Text].
 */
class EditableLabel : Widget, Editable
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
    return gtk_editable_label_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin EditableT!GtkEditableLabel;

  /**
   * Creates a new `GtkEditableLabel` widget.
   * Params:
   *   str = the text for the label
   * Returns: the new `GtkEditableLabel`
   */
  this(string str)
  {
    GtkWidget* _cretval;
    const(char)* _str = str.toCString(false);
    _cretval = gtk_editable_label_new(_str);
    this(_cretval, false);
  }

  /**
   * Returns whether the label is currently in “editing mode”.
   * Returns: %TRUE if self is currently in editing mode
   */
  bool getEditing()
  {
    bool _retval;
    _retval = gtk_editable_label_get_editing(cast(GtkEditableLabel*)cPtr);
    return _retval;
  }

  /**
   * Switches the label into “editing mode”.
   */
  void startEditing()
  {
    gtk_editable_label_start_editing(cast(GtkEditableLabel*)cPtr);
  }

  /**
   * Switches the label out of “editing mode”.
   * If commit is %TRUE, the resulting text is kept as the
   * [Gtk.Editable.text] property value, otherwise the
   * resulting text is discarded and the label will keep its
   * previous [Gtk.Editable.text] property value.
   * Params:
   *   commit = whether to set the edited text on the label
   */
  void stopEditing(bool commit)
  {
    gtk_editable_label_stop_editing(cast(GtkEditableLabel*)cPtr, commit);
  }
}
