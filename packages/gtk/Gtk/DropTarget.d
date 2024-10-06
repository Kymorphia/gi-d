module Gtk.DropTarget;

import GObject.DClosure;
import GObject.ObjectG;
import GObject.Types;
import GObject.Value;
import Gdk.ContentFormats;
import Gdk.Drop;
import Gdk.Types;
import Gid.gid;
import Gtk.EventController;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkDropTarget` is an event controller to receive Drag-and-Drop operations.
 * The most basic way to use a `GtkDropTarget` to receive drops on a
 * widget is to create it via [Gtk.DropTarget.new_], passing in the
 * `GType` of the data you want to receive and connect to the
 * [Gtk.DropTarget.drop] signal to receive the data:
 * ```c
 * static gboolean
 * on_drop $(LPAREN)GtkDropTarget *target,
 * const GValue  *value,
 * double         x,
 * double         y,
 * gpointer       data$(RPAREN)
 * {
 * MyWidget *self \= data;
 * // Call the appropriate setter depending on the type of data
 * // that we received
 * if $(LPAREN)G_VALUE_HOLDS $(LPAREN)value, G_TYPE_FILE$(RPAREN)$(RPAREN)
 * my_widget_set_file $(LPAREN)self, g_value_get_object $(LPAREN)value$(RPAREN)$(RPAREN);
 * else if $(LPAREN)G_VALUE_HOLDS $(LPAREN)value, GDK_TYPE_PIXBUF$(RPAREN)$(RPAREN)
 * my_widget_set_pixbuf $(LPAREN)self, g_value_get_object $(LPAREN)value$(RPAREN)$(RPAREN);
 * else
 * return FALSE;
 * return TRUE;
 * }
 * static void
 * my_widget_init $(LPAREN)MyWidget *self$(RPAREN)
 * {
 * GtkDropTarget *target \=
 * gtk_drop_target_new $(LPAREN)G_TYPE_INVALID, GDK_ACTION_COPY$(RPAREN);
 * // This widget accepts two types of drop types: GFile objects
 * // and GdkPixbuf objects
 * gtk_drop_target_set_gtypes $(LPAREN)target, $(LPAREN)GType [2]$(RPAREN) {
 * G_TYPE_FILE,
 * GDK_TYPE_PIXBUF,
 * }, 2$(RPAREN);
 * g_signal_connect $(LPAREN)target, "drop", G_CALLBACK $(LPAREN)on_drop$(RPAREN), self$(RPAREN);
 * gtk_widget_add_controller $(LPAREN)GTK_WIDGET $(LPAREN)self$(RPAREN), GTK_EVENT_CONTROLLER $(LPAREN)target$(RPAREN)$(RPAREN);
 * }
 * ```
 * `GtkDropTarget` supports more options, such as:
 * * rejecting potential drops via the [Gtk.DropTarget.accept] signal
 * and the [Gtk.DropTarget.reject] function to let other drop
 * targets handle the drop
 * * tracking an ongoing drag operation before the drop via the
 * [Gtk.DropTarget.enter], [Gtk.DropTarget.motion] and
 * [Gtk.DropTarget.leave] signals
 * * configuring how to receive data by setting the
 * [Gtk.DropTarget.preload] property and listening for its
 * availability via the [Gtk.DropTarget.value] property
 * However, `GtkDropTarget` is ultimately modeled in a synchronous way
 * and only supports data transferred via `GType`. If you want full control
 * over an ongoing drop, the [Gtk.DropTargetAsync] object gives you
 * this ability.
 * While a pointer is dragged over the drop target's widget and the drop
 * has not been rejected, that widget will receive the
 * %GTK_STATE_FLAG_DROP_ACTIVE state, which can be used to style the widget.
 * If you are not interested in receiving the drop, but just want to update
 * UI state during a Drag-and-Drop operation $(LPAREN)e.g. switching tabs$(RPAREN), you can
 * use [Gtk.DropControllerMotion].
 */
class DropTarget : EventController
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
    return gtk_drop_target_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new `GtkDropTarget` object.
   * If the drop target should support more than 1 type, pass
   * %G_TYPE_INVALID for type and then call
   * [Gtk.DropTarget.setGtypes].
   * Params:
   *   type = The supported type or %G_TYPE_INVALID
   *   actions = the supported actions
   * Returns: the new `GtkDropTarget`
   */
  this(GType type, DragAction actions)
  {
    GtkDropTarget* _cretval;
    _cretval = gtk_drop_target_new(type, actions);
    this(_cretval, true);
  }

  /**
   * Gets the actions that this drop target supports.
   * Returns: the actions that this drop target supports
   */
  DragAction getActions()
  {
    GdkDragAction _cretval;
    _cretval = gtk_drop_target_get_actions(cast(GtkDropTarget*)cPtr);
    DragAction _retval = cast(DragAction)_cretval;
    return _retval;
  }

  /**
   * Gets the currently handled drop operation.
   * If no drop operation is going on, %NULL is returned.
   * Returns: The current drop
   */
  Drop getCurrentDrop()
  {
    GdkDrop* _cretval;
    _cretval = gtk_drop_target_get_current_drop(cast(GtkDropTarget*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Drop(cast(GdkDrop*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the currently handled drop operation.
   * If no drop operation is going on, %NULL is returned.
   * Returns: The current drop

   * Deprecated: Use [Gtk.DropTarget.getCurrentDrop] instead
   */
  Drop getDrop()
  {
    GdkDrop* _cretval;
    _cretval = gtk_drop_target_get_drop(cast(GtkDropTarget*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Drop(cast(GdkDrop*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the data formats that this drop target accepts.
   * If the result is %NULL, all formats are expected to be supported.
   * Returns: the supported data formats
   */
  ContentFormats getFormats()
  {
    GdkContentFormats* _cretval;
    _cretval = gtk_drop_target_get_formats(cast(GtkDropTarget*)cPtr);
    auto _retval = _cretval ? new ContentFormats(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the list of supported `GType`s that can be dropped on the target.
   * If no types have been set, `NULL` will be returned.
   * Returns: the `G_TYPE_INVALID`-terminated array of types included in
   *   formats
   */
  GType[] getGtypes()
  {
    const(GType)* _cretval;
    size_t _cretlength;
    _cretval = gtk_drop_target_get_gtypes(cast(GtkDropTarget*)cPtr, &_cretlength);
    GType[] _retval;

    if (_cretval)
    {
      _retval = cast(GType[] )_cretval[0 .. _cretlength];
    }
    return _retval;
  }

  /**
   * Gets whether data should be preloaded on hover.
   * Returns: %TRUE if drop data should be preloaded
   */
  bool getPreload()
  {
    bool _retval;
    _retval = gtk_drop_target_get_preload(cast(GtkDropTarget*)cPtr);
    return _retval;
  }

  /**
   * Gets the current drop data, as a `GValue`.
   * Returns: The current drop data
   */
  Value getValue()
  {
    const(GValue)* _cretval;
    _cretval = gtk_drop_target_get_value(cast(GtkDropTarget*)cPtr);
    auto _retval = _cretval ? new Value(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Rejects the ongoing drop operation.
   * If no drop operation is ongoing, i.e when propertyGtk.DropTarget:current-drop
   * is %NULL, this function does nothing.
   * This function should be used when delaying the decision
   * on whether to accept a drag or not until after reading
   * the data.
   */
  void reject()
  {
    gtk_drop_target_reject(cast(GtkDropTarget*)cPtr);
  }

  /**
   * Sets the actions that this drop target supports.
   * Params:
   *   actions = the supported actions
   */
  void setActions(DragAction actions)
  {
    gtk_drop_target_set_actions(cast(GtkDropTarget*)cPtr, actions);
  }

  /**
   * Sets the supported `GType`s for this drop target.
   * Params:
   *   types = all supported `GType`s
   *     that can be dropped on the target
   */
  void setGtypes(GType[] types)
  {
    size_t _nTypes;
    if (types)
      _nTypes = cast(size_t)types.length;

    auto _types = cast(GType*)types.ptr;
    gtk_drop_target_set_gtypes(cast(GtkDropTarget*)cPtr, _types, _nTypes);
  }

  /**
   * Sets whether data should be preloaded on hover.
   * Params:
   *   preload = %TRUE to preload drop data
   */
  void setPreload(bool preload)
  {
    gtk_drop_target_set_preload(cast(GtkDropTarget*)cPtr, preload);
  }

  /**
   * Emitted on the drop site when a drop operation is about to begin.
   * If the drop is not accepted, %FALSE will be returned and the drop target
   * will ignore the drop. If %TRUE is returned, the drop is accepted for now
   * but may be rejected later via a call to [Gtk.DropTarget.reject]
   * or ultimately by returning %FALSE from a [Gtk.DropTarget.drop]
   * handler.
   * The default handler for this signal decides whether to accept the drop
   * based on the formats provided by the drop.
   * If the decision whether the drop will be accepted or rejected depends
   * on the data, this function should return %TRUE, the
   * [Gtk.DropTarget.preload] property should be set and the value
   * should be inspected via the ::notify:value signal, calling
   * [Gtk.DropTarget.reject] if required.
   * Params
   *   drop = the `GdkDrop`
   *   dropTarget = the instance the signal is connected to
   * Returns: %TRUE if drop is accepted
   */
  alias AcceptCallback = bool delegate(Drop drop, DropTarget dropTarget);

  /**
   * Connect to Accept signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectAccept(AcceptCallback dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      bool _retval;
      auto dropTarget = getVal!DropTarget(_paramVals);
      auto drop = getVal!Drop(&_paramVals[1]);
      _retval = _dgClosure.dlg(drop, dropTarget);
      setVal!bool(_returnValue, _retval);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("accept", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * Emitted on the drop site when the user drops the data onto the widget.
   * The signal handler must determine whether the pointer position is in
   * a drop zone or not. If it is not in a drop zone, it returns %FALSE
   * and no further processing is necessary.
   * Otherwise, the handler returns %TRUE. In this case, this handler will
   * accept the drop. The handler is responsible for using the given value
   * and performing the drop operation.
   * Params
   *   value = the `GValue` being dropped
   *   x = the x coordinate of the current pointer position
   *   y = the y coordinate of the current pointer position
   *   dropTarget = the instance the signal is connected to
   * Returns: whether the drop was accepted at the given pointer position
   */
  alias DropCallback = bool delegate(Value value, double x, double y, DropTarget dropTarget);

  /**
   * Connect to Drop signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectDrop(DropCallback dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 4, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      bool _retval;
      auto dropTarget = getVal!DropTarget(_paramVals);
      auto value = getVal!Value(&_paramVals[1]);
      auto x = getVal!double(&_paramVals[2]);
      auto y = getVal!double(&_paramVals[3]);
      _retval = _dgClosure.dlg(value, x, y, dropTarget);
      setVal!bool(_returnValue, _retval);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("drop", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * Emitted on the drop site when the pointer enters the widget.
   * It can be used to set up custom highlighting.
   * Params
   *   x = the x coordinate of the current pointer position
   *   y = the y coordinate of the current pointer position
   *   dropTarget = the instance the signal is connected to
   * Returns: Preferred action for this drag operation or 0 if
   *   dropping is not supported at the current x,y location.
   */
  alias EnterCallback = DragAction delegate(double x, double y, DropTarget dropTarget);

  /**
   * Connect to Enter signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectEnter(EnterCallback dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 3, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto dropTarget = getVal!DropTarget(_paramVals);
      auto x = getVal!double(&_paramVals[1]);
      auto y = getVal!double(&_paramVals[2]);
      auto _dretval = _dgClosure.dlg(x, y, dropTarget);
      GdkDragAction _retval = cast(GdkDragAction)_dretval;
      setVal!DragAction(_returnValue, _retval);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("enter", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * Emitted on the drop site when the pointer leaves the widget.
   * Its main purpose it to undo things done in
   * [Gtk.DropTarget.enter].
   *   dropTarget = the instance the signal is connected to
   */
  alias LeaveCallback = void delegate(DropTarget dropTarget);

  /**
   * Connect to Leave signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectLeave(LeaveCallback dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto dropTarget = getVal!DropTarget(_paramVals);
      _dgClosure.dlg(dropTarget);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("leave", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * Emitted while the pointer is moving over the drop target.
   * Params
   *   x = the x coordinate of the current pointer position
   *   y = the y coordinate of the current pointer position
   *   dropTarget = the instance the signal is connected to
   * Returns: Preferred action for this drag operation or 0 if
   *   dropping is not supported at the current x,y location.
   */
  alias MotionCallback = DragAction delegate(double x, double y, DropTarget dropTarget);

  /**
   * Connect to Motion signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectMotion(MotionCallback dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 3, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto dropTarget = getVal!DropTarget(_paramVals);
      auto x = getVal!double(&_paramVals[1]);
      auto y = getVal!double(&_paramVals[2]);
      auto _dretval = _dgClosure.dlg(x, y, dropTarget);
      GdkDragAction _retval = cast(GdkDragAction)_dretval;
      setVal!DragAction(_returnValue, _retval);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("motion", closure, (flags & ConnectFlags.After) != 0);
  }
}
