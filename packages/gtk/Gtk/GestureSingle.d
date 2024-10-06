module Gtk.GestureSingle;

import Gdk.EventSequence;
import Gid.gid;
import Gtk.Gesture;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkGestureSingle` is a `GtkGestures` subclass optimized for singe-touch
 * and mouse gestures.
 * Under interaction, these gestures stick to the first interacting sequence,
 * which is accessible through [Gtk.GestureSingle.getCurrentSequence]
 * while the gesture is being interacted with.
 * By default gestures react to both %GDK_BUTTON_PRIMARY and touch events.
 * [Gtk.GestureSingle.setTouchOnly] can be used to change the
 * touch behavior. Callers may also specify a different mouse button number
 * to interact with through [Gtk.GestureSingle.setButton], or react
 * to any mouse button by setting it to 0. While the gesture is active, the
 * button being currently pressed can be known through
 * [Gtk.GestureSingle.getCurrentButton].
 */
class GestureSingle : Gesture
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
    return gtk_gesture_single_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Returns the button number gesture listens for.
   * If this is 0, the gesture reacts to any button press.
   * Returns: The button number, or 0 for any button
   */
  uint getButton()
  {
    uint _retval;
    _retval = gtk_gesture_single_get_button(cast(GtkGestureSingle*)cPtr);
    return _retval;
  }

  /**
   * Returns the button number currently interacting
   * with gesture, or 0 if there is none.
   * Returns: The current button number
   */
  uint getCurrentButton()
  {
    uint _retval;
    _retval = gtk_gesture_single_get_current_button(cast(GtkGestureSingle*)cPtr);
    return _retval;
  }

  /**
   * Returns the event sequence currently interacting with gesture.
   * This is only meaningful if [Gtk.Gesture.isActive]
   * returns %TRUE.
   * Returns: the current sequence
   */
  EventSequence getCurrentSequence()
  {
    GdkEventSequence* _cretval;
    _cretval = gtk_gesture_single_get_current_sequence(cast(GtkGestureSingle*)cPtr);
    auto _retval = _cretval ? new EventSequence(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Gets whether a gesture is exclusive.
   * For more information, see [Gtk.GestureSingle.setExclusive].
   * Returns: Whether the gesture is exclusive
   */
  bool getExclusive()
  {
    bool _retval;
    _retval = gtk_gesture_single_get_exclusive(cast(GtkGestureSingle*)cPtr);
    return _retval;
  }

  /**
   * Returns %TRUE if the gesture is only triggered by touch events.
   * Returns: %TRUE if the gesture only handles touch events
   */
  bool getTouchOnly()
  {
    bool _retval;
    _retval = gtk_gesture_single_get_touch_only(cast(GtkGestureSingle*)cPtr);
    return _retval;
  }

  /**
   * Sets the button number gesture listens to.
   * If non-0, every button press from a different button
   * number will be ignored. Touch events implicitly match
   * with button 1.
   * Params:
   *   button = button number to listen to, or 0 for any button
   */
  void setButton(uint button)
  {
    gtk_gesture_single_set_button(cast(GtkGestureSingle*)cPtr, button);
  }

  /**
   * Sets whether gesture is exclusive.
   * An exclusive gesture will only handle pointer and "pointer emulated"
   * touch events, so at any given time, there is only one sequence able
   * to interact with those.
   * Params:
   *   exclusive = %TRUE to make gesture exclusive
   */
  void setExclusive(bool exclusive)
  {
    gtk_gesture_single_set_exclusive(cast(GtkGestureSingle*)cPtr, exclusive);
  }

  /**
   * Sets whether to handle only touch events.
   * If touch_only is %TRUE, gesture will only handle events of type
   * %GDK_TOUCH_BEGIN, %GDK_TOUCH_UPDATE or %GDK_TOUCH_END. If %FALSE,
   * mouse events will be handled too.
   * Params:
   *   touchOnly = whether gesture handles only touch events
   */
  void setTouchOnly(bool touchOnly)
  {
    gtk_gesture_single_set_touch_only(cast(GtkGestureSingle*)cPtr, touchOnly);
  }
}
