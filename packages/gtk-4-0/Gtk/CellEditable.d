module Gtk.CellEditable;

public import Gtk.CellEditableIfaceProxy;
import GObject.DClosure;
import Gdk.Event;
import Gid.gid;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * Interface for widgets that can be used for editing cells
 * The `GtkCellEditable` interface must be implemented for widgets to be usable
 * to edit the contents of a `GtkTreeView` cell. It provides a way to specify how
 * temporary widgets should be configured for editing, get the new value, etc.

 * Deprecated: List views use widgets for displaying their
 *   contents. See [Gtk.Editable] for editable text widgets
 */
interface CellEditable
{

  static GType getType()
  {
    return gtk_cell_editable_get_type();
  }

  /**
   * Emits the `GtkCellEditable::editing-done` signal.
   */
  void editingDone();

  /**
   * Emits the `GtkCellEditable::remove-widget` signal.
   */
  void removeWidget();

  /**
   * Begins editing on a cell_editable.
   * The `GtkCellRenderer` for the cell creates and returns a `GtkCellEditable` from
   * [Gtk.CellRenderer.startEditing], configured for the `GtkCellRenderer` type.
   * [Gtk.CellEditable.startEditing] can then set up cell_editable suitably for
   * editing a cell, e.g. making the Esc key emit `GtkCellEditable::editing-done`.
   * Note that the cell_editable is created on-demand for the current edit; its
   * lifetime is temporary and does not persist across other edits and/or cells.
   * Params:
   *   event = The `GdkEvent` that began the editing process, or
   *     %NULL if editing was initiated programmatically
   */
  void startEditing(Event event);

  /**
   * This signal is a sign for the cell renderer to update its
   * value from the cell_editable.
   * Implementations of `GtkCellEditable` are responsible for
   * emitting this signal when they are done editing, e.g.
   * `GtkEntry` emits this signal when the user presses Enter. Typical things to
   * do in a handler for ::editing-done are to capture the edited value,
   * disconnect the cell_editable from signals on the `GtkCellRenderer`, etc.
   * [Gtk.CellEditable.editingDone] is a convenience method
   * for emitting `GtkCellEditable::editing-done`.
   *   cellEditable = the instance the signal is connected to
   */
  alias EditingDoneCallback = void delegate(CellEditable cellEditable);

  /**
   * Connect to EditingDone signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectEditingDone(EditingDoneCallback dlg, Flag!"After" after = No.After);

  /**
   * This signal is meant to indicate that the cell is finished
   * editing, and the cell_editable widget is being removed and may
   * subsequently be destroyed.
   * Implementations of `GtkCellEditable` are responsible for
   * emitting this signal when they are done editing. It must
   * be emitted after the `GtkCellEditable::editing-done` signal,
   * to give the cell renderer a chance to update the cell's value
   * before the widget is removed.
   * [Gtk.CellEditable.removeWidget] is a convenience method
   * for emitting `GtkCellEditable::remove-widget`.
   *   cellEditable = the instance the signal is connected to
   */
  alias RemoveWidgetCallback = void delegate(CellEditable cellEditable);

  /**
   * Connect to RemoveWidget signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectRemoveWidget(RemoveWidgetCallback dlg, Flag!"After" after = No.After);
}
