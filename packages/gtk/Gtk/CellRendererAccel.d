module Gtk.CellRendererAccel;

import GObject.DClosure;
import GObject.Types;
import Gdk.Types;
import Gid.gid;
import Gtk.CellRendererText;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * Renders a keyboard accelerator in a cell
 * `GtkCellRendererAccel` displays a keyboard accelerator $(LPAREN)i.e. a key
 * combination like `Control + a`$(RPAREN). If the cell renderer is editable,
 * the accelerator can be changed by simply typing the new combination.

 * Deprecated: Applications editing keyboard accelerators should
 *   provide their own implementation according to platform design
 *   guidelines
 */
class CellRendererAccel : CellRendererText
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return gtk_cell_renderer_accel_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new `GtkCellRendererAccel`.
   * Returns: the new cell renderer
   */
  this()
  {
    GtkCellRenderer* _cretval;
    _cretval = gtk_cell_renderer_accel_new();
    this(_cretval, false);
  }

  /**
   * Gets emitted when the user has removed the accelerator.
   * Params
   *   pathString = the path identifying the row of the edited cell
   *   cellRendererAccel = the instance the signal is connected to
   */
  alias AccelClearedCallback = void delegate(string pathString, CellRendererAccel cellRendererAccel);

  /**
   * Connect to AccelCleared signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectAccelCleared(AccelClearedCallback dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto cellRendererAccel = getVal!CellRendererAccel(_paramVals);
      auto pathString = getVal!string(&_paramVals[1]);
      _dgClosure.dlg(pathString, cellRendererAccel);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("accel-cleared", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * Gets emitted when the user has selected a new accelerator.
   * Params
   *   pathString = the path identifying the row of the edited cell
   *   accelKey = the new accelerator keyval
   *   accelMods = the new accelerator modifier mask
   *   hardwareKeycode = the keycode of the new accelerator
   *   cellRendererAccel = the instance the signal is connected to
   */
  alias AccelEditedCallback = void delegate(string pathString, uint accelKey, ModifierType accelMods, uint hardwareKeycode, CellRendererAccel cellRendererAccel);

  /**
   * Connect to AccelEdited signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectAccelEdited(AccelEditedCallback dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 5, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto cellRendererAccel = getVal!CellRendererAccel(_paramVals);
      auto pathString = getVal!string(&_paramVals[1]);
      auto accelKey = getVal!uint(&_paramVals[2]);
      auto accelMods = getVal!ModifierType(&_paramVals[3]);
      auto hardwareKeycode = getVal!uint(&_paramVals[4]);
      _dgClosure.dlg(pathString, accelKey, accelMods, hardwareKeycode, cellRendererAccel);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("accel-edited", closure, (flags & ConnectFlags.After) != 0);
  }
}
