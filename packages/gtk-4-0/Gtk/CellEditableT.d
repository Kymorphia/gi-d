module Gtk.CellEditableT;

public import Gtk.CellEditableIfaceProxy;
public import GObject.DClosure;
public import Gdk.Event;
public import Gid.gid;
public import Gtk.Types;
public import Gtk.c.functions;
public import Gtk.c.types;

/**
 * Interface for widgets that can be used for editing cells
 * The `GtkCellEditable` interface must be implemented for widgets to be usable
 * to edit the contents of a `GtkTreeView` cell. It provides a way to specify how
 * temporary widgets should be configured for editing, get the new value, etc.

 * Deprecated: List views use widgets for displaying their
 *   contents. See [Gtk.Editable] for editable text widgets
 */
template CellEditableT()
{

  /**
   * Emits the `GtkCellEditable::editing-done` signal.
   */
  override void editingDone()
  {
    gtk_cell_editable_editing_done(cast(GtkCellEditable*)cPtr);
  }

  /**
   * Emits the `GtkCellEditable::remove-widget` signal.
   */
  override void removeWidget()
  {
    gtk_cell_editable_remove_widget(cast(GtkCellEditable*)cPtr);
  }

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
  override void startEditing(Event event)
  {
    gtk_cell_editable_start_editing(cast(GtkCellEditable*)cPtr, event ? cast(GdkEvent*)event.cPtr(false) : null);
  }

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
  ulong connectEditingDone(EditingDoneCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto cellEditable = getVal!CellEditable(_paramVals);
      _dgClosure.dlg(cellEditable);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("editing-done", closure, after);
  }

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
  ulong connectRemoveWidget(RemoveWidgetCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto cellEditable = getVal!CellEditable(_paramVals);
      _dgClosure.dlg(cellEditable);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("remove-widget", closure, after);
  }
}
