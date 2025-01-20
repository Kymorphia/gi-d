module Gtk.CellRendererToggle;

import GObject.DClosure;
import Gid.gid;
import Gtk.CellRenderer;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * Renders a toggle button in a cell
 * `GtkCellRendererToggle` renders a toggle button in a cell. The
 * button is drawn as a radio or a checkbutton, depending on the
 * `GtkCellRendererToggle:radio` property.
 * When activated, it emits the `GtkCellRendererToggle::toggled` signal.

 * Deprecated: List views use widgets to display their contents.
 *   You should use [Gtk.ToggleButton] instead
 */
class CellRendererToggle : CellRenderer
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return gtk_cell_renderer_toggle_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new `GtkCellRendererToggle`. Adjust rendering
   * parameters using object properties. Object properties can be set
   * globally $(LPAREN)with [GObject.ObjectG.set]$(RPAREN). Also, with `GtkTreeViewColumn`, you
   * can bind a property to a value in a `GtkTreeModel`. For example, you
   * can bind the “active” property on the cell renderer to a boolean value
   * in the model, thus causing the check button to reflect the state of
   * the model.
   * Returns: the new cell renderer
   */
  this()
  {
    GtkCellRenderer* _cretval;
    _cretval = gtk_cell_renderer_toggle_new();
    this(_cretval, false);
  }

  /**
   * Returns whether the cell renderer is activatable. See
   * [Gtk.CellRendererToggle.setActivatable].
   * Returns: %TRUE if the cell renderer is activatable.
   */
  bool getActivatable()
  {
    bool _retval;
    _retval = gtk_cell_renderer_toggle_get_activatable(cast(GtkCellRendererToggle*)cPtr);
    return _retval;
  }

  /**
   * Returns whether the cell renderer is active. See
   * [Gtk.CellRendererToggle.setActive].
   * Returns: %TRUE if the cell renderer is active.
   */
  bool getActive()
  {
    bool _retval;
    _retval = gtk_cell_renderer_toggle_get_active(cast(GtkCellRendererToggle*)cPtr);
    return _retval;
  }

  /**
   * Returns whether we’re rendering radio toggles rather than checkboxes.
   * Returns: %TRUE if we’re rendering radio toggles rather than checkboxes
   */
  bool getRadio()
  {
    bool _retval;
    _retval = gtk_cell_renderer_toggle_get_radio(cast(GtkCellRendererToggle*)cPtr);
    return _retval;
  }

  /**
   * Makes the cell renderer activatable.
   * Params:
   *   setting = the value to set.
   */
  void setActivatable(bool setting)
  {
    gtk_cell_renderer_toggle_set_activatable(cast(GtkCellRendererToggle*)cPtr, setting);
  }

  /**
   * Activates or deactivates a cell renderer.
   * Params:
   *   setting = the value to set.
   */
  void setActive(bool setting)
  {
    gtk_cell_renderer_toggle_set_active(cast(GtkCellRendererToggle*)cPtr, setting);
  }

  /**
   * If radio is %TRUE, the cell renderer renders a radio toggle
   * $(LPAREN)i.e. a toggle in a group of mutually-exclusive toggles$(RPAREN).
   * If %FALSE, it renders a check toggle $(LPAREN)a standalone boolean option$(RPAREN).
   * This can be set globally for the cell renderer, or changed just
   * before rendering each cell in the model $(LPAREN)for `GtkTreeView`, you set
   * up a per-row setting using `GtkTreeViewColumn` to associate model
   * columns with cell renderer properties$(RPAREN).
   * Params:
   *   radio = %TRUE to make the toggle look like a radio button
   */
  void setRadio(bool radio)
  {
    gtk_cell_renderer_toggle_set_radio(cast(GtkCellRendererToggle*)cPtr, radio);
  }

  /**
   * The ::toggled signal is emitted when the cell is toggled.
   * It is the responsibility of the application to update the model
   * with the correct value to store at path.  Often this is simply the
   * opposite of the value currently stored at path.
   * Params
   *   path = string representation of `GtkTreePath` describing the
   *     event location
   *   cellRendererToggle = the instance the signal is connected to
   */
  alias ToggledCallback = void delegate(string path, CellRendererToggle cellRendererToggle);

  /**
   * Connect to Toggled signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectToggled(ToggledCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto cellRendererToggle = getVal!CellRendererToggle(_paramVals);
      auto path = getVal!string(&_paramVals[1]);
      _dgClosure.dlg(path, cellRendererToggle);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("toggled", closure, after);
  }
}
