module Gtk.AccessibleText;

public import Gtk.AccessibleTextIfaceProxy;
import Gid.gid;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * An interface for accessible objects containing formatted text.
 * The `GtkAccessibleText` interfaces is meant to be implemented by accessible
 * objects that have text formatted with attributes, or non-trivial text contents.
 * You should use the enum@Gtk.AccessibleProperty.LABEL or the
 * enum@Gtk.AccessibleProperty.DESCRIPTION properties for accessible
 * objects containing simple, unformatted text.
 */
interface AccessibleText
{

  static GType getType()
  {
    return gtk_accessible_text_get_type();
  }

  /**
   * Updates the position of the caret.
   * Implementations of the `GtkAccessibleText` interface should call this
   * function every time the caret has moved, in order to notify assistive
   * technologies.
   */
  void updateCaretPosition();

  /**
   * Notifies assistive technologies of a change in contents.
   * Implementations of the `GtkAccessibleText` interface should call this
   * function every time their contents change as the result of an operation,
   * like an insertion or a removal.
   * Note: If the change is a deletion, this function must be called *before*
   * removing the contents, if it is an insertion, it must be called *after*
   * inserting the new contents.
   * Params:
   *   change = the type of change in the contents
   *   start = the starting offset of the change, in characters
   *   end = the end offset of the change, in characters
   */
  void updateContents(AccessibleTextContentChange change, uint start, uint end);

  /**
   * Updates the boundary of the selection.
   * Implementations of the `GtkAccessibleText` interface should call this
   * function every time the selection has moved, in order to notify assistive
   * technologies.
   */
  void updateSelectionBound();
}
