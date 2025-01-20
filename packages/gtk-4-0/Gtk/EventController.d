module Gtk.EventController;

import GObject.ObjectG;
import Gdk.Device;
import Gdk.Event;
import Gdk.Types;
import Gid.gid;
import Gtk.Types;
import Gtk.Widget;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkEventController` is the base class for event controllers.
 * These are ancillary objects associated to widgets, which react
 * to `GdkEvents`, and possibly trigger actions as a consequence.
 * Event controllers are added to a widget with
 * [Gtk.Widget.addController]. It is rarely necessary to
 * explicitly remove a controller with [Gtk.Widget.removeController].
 * See the chapter on [input handling](input-handling.html) for
 * an overview of the basic concepts, such as the capture and bubble
 * phases of event propagation.
 */
class EventController : ObjectG
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
    return gtk_event_controller_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Returns the event that is currently being handled by the controller.
   * At other times, %NULL is returned.
   * Returns: the event that is currently
   *   handled by controller
   */
  Event getCurrentEvent()
  {
    GdkEvent* _cretval;
    _cretval = gtk_event_controller_get_current_event(cast(GtkEventController*)cPtr);
    auto _retval = _cretval ? new Event(cast(GdkEvent*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns the device of the event that is currently being
   * handled by the controller.
   * At other times, %NULL is returned.
   * Returns: device of the event is
   *   currently handled by controller
   */
  Device getCurrentEventDevice()
  {
    GdkDevice* _cretval;
    _cretval = gtk_event_controller_get_current_event_device(cast(GtkEventController*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Device(cast(GdkDevice*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns the modifier state of the event that is currently being
   * handled by the controller.
   * At other times, 0 is returned.
   * Returns: modifier state of the event is currently handled by controller
   */
  ModifierType getCurrentEventState()
  {
    GdkModifierType _cretval;
    _cretval = gtk_event_controller_get_current_event_state(cast(GtkEventController*)cPtr);
    ModifierType _retval = cast(ModifierType)_cretval;
    return _retval;
  }

  /**
   * Returns the timestamp of the event that is currently being
   * handled by the controller.
   * At other times, 0 is returned.
   * Returns: timestamp of the event is currently handled by controller
   */
  uint getCurrentEventTime()
  {
    uint _retval;
    _retval = gtk_event_controller_get_current_event_time(cast(GtkEventController*)cPtr);
    return _retval;
  }

  /**
   * Gets the name of controller.
   * Returns: The controller name
   */
  string getName()
  {
    const(char)* _cretval;
    _cretval = gtk_event_controller_get_name(cast(GtkEventController*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Gets the propagation limit of the event controller.
   * Returns: the propagation limit
   */
  PropagationLimit getPropagationLimit()
  {
    GtkPropagationLimit _cretval;
    _cretval = gtk_event_controller_get_propagation_limit(cast(GtkEventController*)cPtr);
    PropagationLimit _retval = cast(PropagationLimit)_cretval;
    return _retval;
  }

  /**
   * Gets the propagation phase at which controller handles events.
   * Returns: the propagation phase
   */
  PropagationPhase getPropagationPhase()
  {
    GtkPropagationPhase _cretval;
    _cretval = gtk_event_controller_get_propagation_phase(cast(GtkEventController*)cPtr);
    PropagationPhase _retval = cast(PropagationPhase)_cretval;
    return _retval;
  }

  /**
   * Returns the `GtkWidget` this controller relates to.
   * Returns: a `GtkWidget`
   */
  Widget getWidget()
  {
    GtkWidget* _cretval;
    _cretval = gtk_event_controller_get_widget(cast(GtkEventController*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Widget(cast(GtkWidget*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Resets the controller to a clean state.
   */
  void reset()
  {
    gtk_event_controller_reset(cast(GtkEventController*)cPtr);
  }

  /**
   * Sets a name on the controller that can be used for debugging.
   * Params:
   *   name = a name for controller
   */
  void setName(string name)
  {
    const(char)* _name = name.toCString(false);
    gtk_event_controller_set_name(cast(GtkEventController*)cPtr, _name);
  }

  /**
   * Sets the event propagation limit on the event controller.
   * If the limit is set to %GTK_LIMIT_SAME_NATIVE, the controller
   * won't handle events that are targeted at widgets on a different
   * surface, such as popovers.
   * Params:
   *   limit = the propagation limit
   */
  void setPropagationLimit(PropagationLimit limit)
  {
    gtk_event_controller_set_propagation_limit(cast(GtkEventController*)cPtr, limit);
  }

  /**
   * Sets the propagation phase at which a controller handles events.
   * If phase is %GTK_PHASE_NONE, no automatic event handling will be
   * performed, but other additional gesture maintenance will.
   * Params:
   *   phase = a propagation phase
   */
  void setPropagationPhase(PropagationPhase phase)
  {
    gtk_event_controller_set_propagation_phase(cast(GtkEventController*)cPtr, phase);
  }

  /**
   * Sets a name on the controller that can be used for debugging.
   * Params:
   *   name = a name for controller, must be a static string
   */
  void setStaticName(string name)
  {
    const(char)* _name = name.toCString(false);
    gtk_event_controller_set_static_name(cast(GtkEventController*)cPtr, _name);
  }
}
