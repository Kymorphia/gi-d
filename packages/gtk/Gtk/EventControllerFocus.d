module Gtk.EventControllerFocus;

import GObject.DClosure;
import GObject.Types;
import Gid.gid;
import Gtk.EventController;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkEventControllerFocus` is an event controller to keep track of
 * keyboard focus.
 * The event controller offers [Gtk.EventControllerFocus.enter]
 * and [Gtk.EventControllerFocus.leave] signals, as well as
 * property@Gtk.EventControllerFocus:is-focus and
 * property@Gtk.EventControllerFocus:contains-focus properties
 * which are updated to reflect focus changes inside the widget hierarchy
 * that is rooted at the controllers widget.
 */
class EventControllerFocus : EventController
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return gtk_event_controller_focus_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new event controller that will handle focus events.
   * Returns: a new `GtkEventControllerFocus`
   */
  this()
  {
    GtkEventController* _cretval;
    _cretval = gtk_event_controller_focus_new();
    this(_cretval, true);
  }

  /**
   * Returns %TRUE if focus is within self or one of its children.
   * Returns: %TRUE if focus is within self or one of its children
   */
  bool containsFocus()
  {
    bool _retval;
    _retval = gtk_event_controller_focus_contains_focus(cast(GtkEventControllerFocus*)cPtr);
    return _retval;
  }

  /**
   * Returns %TRUE if focus is within self, but not one of its children.
   * Returns: %TRUE if focus is within self, but not one of its children
   */
  bool isFocus()
  {
    bool _retval;
    _retval = gtk_event_controller_focus_is_focus(cast(GtkEventControllerFocus*)cPtr);
    return _retval;
  }

  /**
   * Emitted whenever the focus enters into the widget or one
   * of its descendents.
   * Note that this means you may not get an ::enter signal
   * even though the widget becomes the focus location, in
   * certain cases $(LPAREN)such as when the focus moves from a descendent
   * of the widget to the widget itself$(RPAREN). If you are interested
   * in these cases, you can monitor the
   * propertyGtk.EventControllerFocus:is-focus
   * property for changes.
   *   eventControllerFocus = the instance the signal is connected to
   */
  alias EnterCallback = void delegate(EventControllerFocus eventControllerFocus);

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
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto eventControllerFocus = getVal!EventControllerFocus(_paramVals);
      _dgClosure.dlg(eventControllerFocus);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("enter", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * Emitted whenever the focus leaves the widget hierarchy
   * that is rooted at the widget that the controller is attached to.
   * Note that this means you may not get a ::leave signal
   * even though the focus moves away from the widget, in
   * certain cases $(LPAREN)such as when the focus moves from the widget
   * to a descendent$(RPAREN). If you are interested in these cases, you
   * can monitor the propertyGtk.EventControllerFocus:is-focus
   * property for changes.
   *   eventControllerFocus = the instance the signal is connected to
   */
  alias LeaveCallback = void delegate(EventControllerFocus eventControllerFocus);

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
      auto eventControllerFocus = getVal!EventControllerFocus(_paramVals);
      _dgClosure.dlg(eventControllerFocus);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("leave", closure, (flags & ConnectFlags.After) != 0);
  }
}
