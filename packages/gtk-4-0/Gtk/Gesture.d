module Gtk.Gesture;

import GLib.List;
import GObject.DClosure;
import GObject.ObjectG;
import Gdk.Device;
import Gdk.Event;
import Gdk.EventSequence;
import Gdk.Rectangle;
import Gid.gid;
import Gtk.EventController;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkGesture` is the base class for gesture recognition.
 * Although `GtkGesture` is quite generalized to serve as a base for
 * multi-touch gestures, it is suitable to implement single-touch and
 * pointer-based gestures $(LPAREN)using the special %NULL `GdkEventSequence`
 * value for these$(RPAREN).
 * The number of touches that a `GtkGesture` need to be recognized is
 * controlled by the property@Gtk.Gesture:n-points property, if a
 * gesture is keeping track of less or more than that number of sequences,
 * it won't check whether the gesture is recognized.
 * As soon as the gesture has the expected number of touches, it will check
 * regularly if it is recognized, the criteria to consider a gesture as
 * "recognized" is left to `GtkGesture` subclasses.
 * A recognized gesture will then emit the following signals:
 * - [Gtk.Gesture.begin] when the gesture is recognized.
 * - [Gtk.Gesture.update], whenever an input event is processed.
 * - [Gtk.Gesture.end] when the gesture is no longer recognized.
 * ## Event propagation
 * In order to receive events, a gesture needs to set a propagation phase
 * through [Gtk.EventController.setPropagationPhase].
 * In the capture phase, events are propagated from the toplevel down
 * to the target widget, and gestures that are attached to containers
 * above the widget get a chance to interact with the event before it
 * reaches the target.
 * In the bubble phase, events are propagated up from the target widget
 * to the toplevel, and gestures that are attached to containers above
 * the widget get a chance to interact with events that have not been
 * handled yet.
 * ## States of a sequence
 * Whenever input interaction happens, a single event may trigger a cascade
 * of `GtkGesture`s, both across the parents of the widget receiving the
 * event and in parallel within an individual widget. It is a responsibility
 * of the widgets using those gestures to set the state of touch sequences
 * accordingly in order to enable cooperation of gestures around the
 * `GdkEventSequence`s triggering those.
 * Within a widget, gestures can be grouped through [Gtk.Gesture.group].
 * Grouped gestures synchronize the state of sequences, so calling
 * [Gtk.Gesture.setState] on one will effectively propagate
 * the state throughout the group.
 * By default, all sequences start out in the %GTK_EVENT_SEQUENCE_NONE state,
 * sequences in this state trigger the gesture event handler, but event
 * propagation will continue unstopped by gestures.
 * If a sequence enters into the %GTK_EVENT_SEQUENCE_DENIED state, the gesture
 * group will effectively ignore the sequence, letting events go unstopped
 * through the gesture, but the "slot" will still remain occupied while
 * the touch is active.
 * If a sequence enters in the %GTK_EVENT_SEQUENCE_CLAIMED state, the gesture
 * group will grab all interaction on the sequence, by:
 * - Setting the same sequence to %GTK_EVENT_SEQUENCE_DENIED on every other
 * gesture group within the widget, and every gesture on parent widgets
 * in the propagation chain.
 * - Emitting [Gtk.Gesture.cancel] on every gesture in widgets
 * underneath in the propagation chain.
 * - Stopping event propagation after the gesture group handles the event.
 * Note: if a sequence is set early to %GTK_EVENT_SEQUENCE_CLAIMED on
 * %GDK_TOUCH_BEGIN/%GDK_BUTTON_PRESS $(LPAREN)so those events are captured before
 * reaching the event widget, this implies %GTK_PHASE_CAPTURE$(RPAREN), one similar
 * event will be emulated if the sequence changes to %GTK_EVENT_SEQUENCE_DENIED.
 * This way event coherence is preserved before event propagation is unstopped
 * again.
 * Sequence states can't be changed freely.
 * See [Gtk.Gesture.setState] to know about the possible
 * lifetimes of a `GdkEventSequence`.
 * ## Touchpad gestures
 * On the platforms that support it, `GtkGesture` will handle transparently
 * touchpad gesture events. The only precautions users of `GtkGesture` should
 * do to enable this support are:
 * - If the gesture has %GTK_PHASE_NONE, ensuring events of type
 * %GDK_TOUCHPAD_SWIPE and %GDK_TOUCHPAD_PINCH are handled by the `GtkGesture`
 */
class Gesture : EventController
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
    return gtk_gesture_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * If there are touch sequences being currently handled by gesture,
   * returns %TRUE and fills in rect with the bounding box containing
   * all active touches.
   * Otherwise, %FALSE will be returned.
   * Note: This function will yield unexpected results on touchpad
   * gestures. Since there is no correlation between physical and
   * pixel distances, these will look as if constrained in an
   * infinitely small area, rect width and height will thus be 0
   * regardless of the number of touchpoints.
   * Params:
   *   rect = bounding box containing all active touches.
   * Returns: %TRUE if there are active touches, %FALSE otherwise
   */
  bool getBoundingBox(out Rectangle rect)
  {
    bool _retval;
    GdkRectangle _rect;
    _retval = gtk_gesture_get_bounding_box(cast(GtkGesture*)cPtr, &_rect);
    rect = new Rectangle(cast(void*)&_rect, false);
    return _retval;
  }

  /**
   * If there are touch sequences being currently handled by gesture,
   * returns %TRUE and fills in x and y with the center of the bounding
   * box containing all active touches.
   * Otherwise, %FALSE will be returned.
   * Params:
   *   x = X coordinate for the bounding box center
   *   y = Y coordinate for the bounding box center
   * Returns: %FALSE if no active touches are present, %TRUE otherwise
   */
  bool getBoundingBoxCenter(out double x, out double y)
  {
    bool _retval;
    _retval = gtk_gesture_get_bounding_box_center(cast(GtkGesture*)cPtr, cast(double*)&x, cast(double*)&y);
    return _retval;
  }

  /**
   * Returns the logical `GdkDevice` that is currently operating
   * on gesture.
   * This returns %NULL if the gesture is not being interacted.
   * Returns: a `GdkDevice`
   */
  Device getDevice()
  {
    GdkDevice* _cretval;
    _cretval = gtk_gesture_get_device(cast(GtkGesture*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Device(cast(GdkDevice*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns all gestures in the group of gesture
   * Returns: The list
   *   of `GtkGesture`s, free with [GLib.List.free]
   */
  List!(Gesture) getGroup()
  {
    GList* _cretval;
    _cretval = gtk_gesture_get_group(cast(GtkGesture*)cPtr);
    List!(Gesture) _retval = new List!(Gesture)(cast(GList*)_cretval, GidOwnership.Container);
    return _retval;
  }

  /**
   * Returns the last event that was processed for sequence.
   * Note that the returned pointer is only valid as long as the
   * sequence is still interpreted by the gesture. If in doubt,
   * you should make a copy of the event.
   * Params:
   *   sequence = a `GdkEventSequence`
   * Returns: The last event from sequence
   */
  Event getLastEvent(EventSequence sequence)
  {
    GdkEvent* _cretval;
    _cretval = gtk_gesture_get_last_event(cast(GtkGesture*)cPtr, sequence ? cast(GdkEventSequence*)sequence.cPtr(false) : null);
    auto _retval = _cretval ? new Event(cast(GdkEvent*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns the `GdkEventSequence` that was last updated on gesture.
   * Returns: The last updated sequence
   */
  EventSequence getLastUpdatedSequence()
  {
    GdkEventSequence* _cretval;
    _cretval = gtk_gesture_get_last_updated_sequence(cast(GtkGesture*)cPtr);
    auto _retval = _cretval ? new EventSequence(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * If sequence is currently being interpreted by gesture,
   * returns %TRUE and fills in x and y with the last coordinates
   * stored for that event sequence.
   * The coordinates are always relative to the widget allocation.
   * Params:
   *   sequence = a `GdkEventSequence`, or %NULL for pointer events
   *   x = return location for X axis of the sequence coordinates
   *   y = return location for Y axis of the sequence coordinates
   * Returns: %TRUE if sequence is currently interpreted
   */
  bool getPoint(EventSequence sequence, out double x, out double y)
  {
    bool _retval;
    _retval = gtk_gesture_get_point(cast(GtkGesture*)cPtr, sequence ? cast(GdkEventSequence*)sequence.cPtr(false) : null, cast(double*)&x, cast(double*)&y);
    return _retval;
  }

  /**
   * Returns the sequence state, as seen by gesture.
   * Params:
   *   sequence = a `GdkEventSequence`
   * Returns: The sequence state in gesture
   */
  EventSequenceState getSequenceState(EventSequence sequence)
  {
    GtkEventSequenceState _cretval;
    _cretval = gtk_gesture_get_sequence_state(cast(GtkGesture*)cPtr, sequence ? cast(GdkEventSequence*)sequence.cPtr(false) : null);
    EventSequenceState _retval = cast(EventSequenceState)_cretval;
    return _retval;
  }

  /**
   * Returns the list of `GdkEventSequences` currently being interpreted
   * by gesture.
   * Returns: A list
   *   of `GdkEventSequence`, the list elements are owned by GTK and must
   *   not be freed or modified, the list itself must be deleted
   *   through [GLib.List.free]
   */
  List!(EventSequence) getSequences()
  {
    GList* _cretval;
    _cretval = gtk_gesture_get_sequences(cast(GtkGesture*)cPtr);
    List!(EventSequence) _retval = new List!(EventSequence)(cast(GList*)_cretval, GidOwnership.Container);
    return _retval;
  }

  /**
   * Adds gesture to the same group than group_gesture.
   * Gestures are by default isolated in their own groups.
   * Both gestures must have been added to the same widget before
   * they can be grouped.
   * When gestures are grouped, the state of `GdkEventSequences`
   * is kept in sync for all of those, so calling
   * [Gtk.Gesture.setSequenceState], on one will transfer
   * the same value to the others.
   * Groups also perform an "implicit grabbing" of sequences, if a
   * `GdkEventSequence` state is set to %GTK_EVENT_SEQUENCE_CLAIMED
   * on one group, every other gesture group attached to the same
   * `GtkWidget` will switch the state for that sequence to
   * %GTK_EVENT_SEQUENCE_DENIED.
   * Params:
   *   gesture = a `GtkGesture`
   */
  void group(Gesture gesture)
  {
    gtk_gesture_group(cast(GtkGesture*)cPtr, gesture ? cast(GtkGesture*)gesture.cPtr(false) : null);
  }

  /**
   * Returns %TRUE if gesture is currently handling events
   * corresponding to sequence.
   * Params:
   *   sequence = a `GdkEventSequence`
   * Returns: %TRUE if gesture is handling sequence, %FALSE otherwise
   */
  bool handlesSequence(EventSequence sequence)
  {
    bool _retval;
    _retval = gtk_gesture_handles_sequence(cast(GtkGesture*)cPtr, sequence ? cast(GdkEventSequence*)sequence.cPtr(false) : null);
    return _retval;
  }

  /**
   * Returns %TRUE if the gesture is currently active.
   * A gesture is active while there are touch sequences
   * interacting with it.
   * Returns: %TRUE if gesture is active
   */
  bool isActive()
  {
    bool _retval;
    _retval = gtk_gesture_is_active(cast(GtkGesture*)cPtr);
    return _retval;
  }

  /**
   * Returns %TRUE if both gestures pertain to the same group.
   * Params:
   *   other = another `GtkGesture`
   * Returns: whether the gestures are grouped
   */
  bool isGroupedWith(Gesture other)
  {
    bool _retval;
    _retval = gtk_gesture_is_grouped_with(cast(GtkGesture*)cPtr, other ? cast(GtkGesture*)other.cPtr(false) : null);
    return _retval;
  }

  /**
   * Returns %TRUE if the gesture is currently recognized.
   * A gesture is recognized if there are as many interacting
   * touch sequences as required by gesture.
   * Returns: %TRUE if gesture is recognized
   */
  bool isRecognized()
  {
    bool _retval;
    _retval = gtk_gesture_is_recognized(cast(GtkGesture*)cPtr);
    return _retval;
  }

  /**
   * Sets the state of sequence in gesture.
   * Sequences start in state %GTK_EVENT_SEQUENCE_NONE, and whenever
   * they change state, they can never go back to that state. Likewise,
   * sequences in state %GTK_EVENT_SEQUENCE_DENIED cannot turn back to
   * a not denied state. With these rules, the lifetime of an event
   * sequence is constrained to the next four:
   * * None
   * * None → Denied
   * * None → Claimed
   * * None → Claimed → Denied
   * Note: Due to event handling ordering, it may be unsafe to set the
   * state on another gesture within a [Gtk.Gesture.begin] signal
   * handler, as the callback might be executed before the other gesture
   * knows about the sequence. A safe way to perform this could be:
   * ```c
   * static void
   * first_gesture_begin_cb $(LPAREN)GtkGesture       *first_gesture,
   * GdkEventSequence *sequence,
   * gpointer          user_data$(RPAREN)
   * {
   * gtk_gesture_set_sequence_state $(LPAREN)first_gesture, sequence, GTK_EVENT_SEQUENCE_CLAIMED$(RPAREN);
   * gtk_gesture_set_sequence_state $(LPAREN)second_gesture, sequence, GTK_EVENT_SEQUENCE_DENIED$(RPAREN);
   * }
   * static void
   * second_gesture_begin_cb $(LPAREN)GtkGesture       *second_gesture,
   * GdkEventSequence *sequence,
   * gpointer          user_data$(RPAREN)
   * {
   * if $(LPAREN)gtk_gesture_get_sequence_state $(LPAREN)first_gesture, sequence$(RPAREN) \=\= GTK_EVENT_SEQUENCE_CLAIMED$(RPAREN)
   * gtk_gesture_set_sequence_state $(LPAREN)second_gesture, sequence, GTK_EVENT_SEQUENCE_DENIED$(RPAREN);
   * }
   * ```
   * If both gestures are in the same group, just set the state on
   * the gesture emitting the event, the sequence will be already
   * be initialized to the group's global state when the second
   * gesture processes the event.
   * Params:
   *   sequence = a `GdkEventSequence`
   *   state = the sequence state
   * Returns: %TRUE if sequence is handled by gesture,
   *   and the state is changed successfully

   * Deprecated: Use [Gtk.Gesture.setState]
   */
  bool setSequenceState(EventSequence sequence, EventSequenceState state)
  {
    bool _retval;
    _retval = gtk_gesture_set_sequence_state(cast(GtkGesture*)cPtr, sequence ? cast(GdkEventSequence*)sequence.cPtr(false) : null, state);
    return _retval;
  }

  /**
   * Sets the state of all sequences that gesture is currently
   * interacting with.
   * Sequences start in state %GTK_EVENT_SEQUENCE_NONE, and whenever
   * they change state, they can never go back to that state. Likewise,
   * sequences in state %GTK_EVENT_SEQUENCE_DENIED cannot turn back to
   * a not denied state. With these rules, the lifetime of an event
   * sequence is constrained to the next four:
   * * None
   * * None → Denied
   * * None → Claimed
   * * None → Claimed → Denied
   * Note: Due to event handling ordering, it may be unsafe to set the
   * state on another gesture within a [Gtk.Gesture.begin] signal
   * handler, as the callback might be executed before the other gesture
   * knows about the sequence. A safe way to perform this could be:
   * ```c
   * static void
   * first_gesture_begin_cb $(LPAREN)GtkGesture       *first_gesture,
   * GdkEventSequence *sequence,
   * gpointer          user_data$(RPAREN)
   * {
   * gtk_gesture_set_state $(LPAREN)first_gesture, GTK_EVENT_SEQUENCE_CLAIMED$(RPAREN);
   * gtk_gesture_set_state $(LPAREN)second_gesture, GTK_EVENT_SEQUENCE_DENIED$(RPAREN);
   * }
   * static void
   * second_gesture_begin_cb $(LPAREN)GtkGesture       *second_gesture,
   * GdkEventSequence *sequence,
   * gpointer          user_data$(RPAREN)
   * {
   * if $(LPAREN)gtk_gesture_get_sequence_state $(LPAREN)first_gesture, sequence$(RPAREN) \=\= GTK_EVENT_SEQUENCE_CLAIMED$(RPAREN)
   * gtk_gesture_set_state $(LPAREN)second_gesture, GTK_EVENT_SEQUENCE_DENIED$(RPAREN);
   * }
   * ```
   * If both gestures are in the same group, just set the state on
   * the gesture emitting the event, the sequence will be already
   * be initialized to the group's global state when the second
   * gesture processes the event.
   * Params:
   *   state = the sequence state
   * Returns: %TRUE if the state of at least one sequence
   *   was changed successfully
   */
  bool setState(EventSequenceState state)
  {
    bool _retval;
    _retval = gtk_gesture_set_state(cast(GtkGesture*)cPtr, state);
    return _retval;
  }

  /**
   * Separates gesture into an isolated group.
   */
  void ungroup()
  {
    gtk_gesture_ungroup(cast(GtkGesture*)cPtr);
  }

  /**
   * Emitted when the gesture is recognized.
   * This means the number of touch sequences matches
   * propertyGtk.Gesture:n-points.
   * Note: These conditions may also happen when an extra touch
   * $(LPAREN)eg. a third touch on a 2-touches gesture$(RPAREN) is lifted, in that
   * situation sequence won't pertain to the current set of active
   * touches, so don't rely on this being true.
   * Params
   *   sequence = the `GdkEventSequence` that made the gesture
   *     to be recognized
   *   gesture = the instance the signal is connected to
   */
  alias BeginCallback = void delegate(EventSequence sequence, Gesture gesture);

  /**
   * Connect to Begin signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectBegin(BeginCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto gesture = getVal!Gesture(_paramVals);
      auto sequence = getVal!EventSequence(&_paramVals[1]);
      _dgClosure.dlg(sequence, gesture);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("begin", closure, after);
  }

  /**
   * Emitted whenever a sequence is cancelled.
   * This usually happens on active touches when
   * [Gtk.EventController.reset] is called on gesture
   * $(LPAREN)manually, due to grabs...$(RPAREN), or the individual sequence
   * was claimed by parent widgets' controllers $(LPAREN)see
   * [Gtk.Gesture.setSequenceState]$(RPAREN).
   * gesture must forget everything about sequence as in
   * response to this signal.
   * Params
   *   sequence = the `GdkEventSequence` that was cancelled
   *   gesture = the instance the signal is connected to
   */
  alias CancelCallback = void delegate(EventSequence sequence, Gesture gesture);

  /**
   * Connect to Cancel signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectCancel(CancelCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto gesture = getVal!Gesture(_paramVals);
      auto sequence = getVal!EventSequence(&_paramVals[1]);
      _dgClosure.dlg(sequence, gesture);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("cancel", closure, after);
  }

  /**
   * Emitted when gesture either stopped recognizing the event
   * sequences as something to be handled, or the number of touch
   * sequences became higher or lower than propertyGtk.Gesture:n-points.
   * Note: sequence might not pertain to the group of sequences that
   * were previously triggering recognition on gesture $(LPAREN)ie. a just
   * pressed touch sequence that exceeds propertyGtk.Gesture:n-points$(RPAREN).
   * This situation may be detected by checking through
   * [Gtk.Gesture.handlesSequence].
   * Params
   *   sequence = the `GdkEventSequence` that made gesture
   *     recognition to finish
   *   gesture = the instance the signal is connected to
   */
  alias EndCallback = void delegate(EventSequence sequence, Gesture gesture);

  /**
   * Connect to End signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectEnd(EndCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto gesture = getVal!Gesture(_paramVals);
      auto sequence = getVal!EventSequence(&_paramVals[1]);
      _dgClosure.dlg(sequence, gesture);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("end", closure, after);
  }

  /**
   * Emitted whenever a sequence state changes.
   * See [Gtk.Gesture.setSequenceState] to know
   * more about the expectable sequence lifetimes.
   * Params
   *   sequence = the `GdkEventSequence` that was cancelled
   *   state = the new sequence state
   *   gesture = the instance the signal is connected to
   */
  alias SequenceStateChangedCallback = void delegate(EventSequence sequence, EventSequenceState state, Gesture gesture);

  /**
   * Connect to SequenceStateChanged signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectSequenceStateChanged(SequenceStateChangedCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 3, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto gesture = getVal!Gesture(_paramVals);
      auto sequence = getVal!EventSequence(&_paramVals[1]);
      auto state = getVal!EventSequenceState(&_paramVals[2]);
      _dgClosure.dlg(sequence, state, gesture);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("sequence-state-changed", closure, after);
  }

  /**
   * Emitted whenever an event is handled while the gesture is recognized.
   * sequence is guaranteed to pertain to the set of active touches.
   * Params
   *   sequence = the `GdkEventSequence` that was updated
   *   gesture = the instance the signal is connected to
   */
  alias UpdateCallback = void delegate(EventSequence sequence, Gesture gesture);

  /**
   * Connect to Update signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectUpdate(UpdateCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto gesture = getVal!Gesture(_paramVals);
      auto sequence = getVal!EventSequence(&_paramVals[1]);
      _dgClosure.dlg(sequence, gesture);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("update", closure, after);
  }
}
