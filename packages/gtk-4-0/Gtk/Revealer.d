module Gtk.Revealer;

import GObject.ObjectG;
import Gid.gid;
import Gtk.Accessible;
import Gtk.AccessibleT;
import Gtk.Buildable;
import Gtk.BuildableT;
import Gtk.ConstraintTarget;
import Gtk.ConstraintTargetT;
import Gtk.Types;
import Gtk.Widget;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * A `GtkRevealer` animates the transition of its child from invisible to visible.
 * The style of transition can be controlled with
 * [Gtk.Revealer.setTransitionType].
 * These animations respect the property@Gtk.Settings:gtk-enable-animations
 * setting.
 * # CSS nodes
 * `GtkRevealer` has a single CSS node with name revealer.
 * When styling `GtkRevealer` using CSS, remember that it only hides its contents,
 * not itself. That means applied margin, padding and borders will be visible even
 * when the property@Gtk.Revealer:reveal-child property is set to %FALSE.
 * # Accessibility
 * `GtkRevealer` uses the %GTK_ACCESSIBLE_ROLE_GROUP role.
 * The child of `GtkRevealer`, if set, is always available in the accessibility
 * tree, regardless of the state of the revealer widget.
 */
class Revealer : Widget
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return gtk_revealer_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new `GtkRevealer`.
   * Returns: a newly created `GtkRevealer`
   */
  this()
  {
    GtkWidget* _cretval;
    _cretval = gtk_revealer_new();
    this(_cretval, false);
  }

  /**
   * Gets the child widget of revealer.
   * Returns: the child widget of revealer
   */
  Widget getChild()
  {
    GtkWidget* _cretval;
    _cretval = gtk_revealer_get_child(cast(GtkRevealer*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Widget(cast(GtkWidget*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns whether the child is fully revealed.
   * In other words, this returns whether the transition
   * to the revealed state is completed.
   * Returns: %TRUE if the child is fully revealed
   */
  bool getChildRevealed()
  {
    bool _retval;
    _retval = gtk_revealer_get_child_revealed(cast(GtkRevealer*)cPtr);
    return _retval;
  }

  /**
   * Returns whether the child is currently revealed.
   * This function returns %TRUE as soon as the transition
   * is to the revealed state is started. To learn whether
   * the child is fully revealed $(LPAREN)ie the transition is completed$(RPAREN),
   * use [Gtk.Revealer.getChildRevealed].
   * Returns: %TRUE if the child is revealed.
   */
  bool getRevealChild()
  {
    bool _retval;
    _retval = gtk_revealer_get_reveal_child(cast(GtkRevealer*)cPtr);
    return _retval;
  }

  /**
   * Returns the amount of time $(LPAREN)in milliseconds$(RPAREN) that
   * transitions will take.
   * Returns: the transition duration
   */
  uint getTransitionDuration()
  {
    uint _retval;
    _retval = gtk_revealer_get_transition_duration(cast(GtkRevealer*)cPtr);
    return _retval;
  }

  /**
   * Gets the type of animation that will be used
   * for transitions in revealer.
   * Returns: the current transition type of revealer
   */
  RevealerTransitionType getTransitionType()
  {
    GtkRevealerTransitionType _cretval;
    _cretval = gtk_revealer_get_transition_type(cast(GtkRevealer*)cPtr);
    RevealerTransitionType _retval = cast(RevealerTransitionType)_cretval;
    return _retval;
  }

  /**
   * Sets the child widget of revealer.
   * Params:
   *   child = the child widget
   */
  void setChild(Widget child)
  {
    gtk_revealer_set_child(cast(GtkRevealer*)cPtr, child ? cast(GtkWidget*)child.cPtr(false) : null);
  }

  /**
   * Tells the `GtkRevealer` to reveal or conceal its child.
   * The transition will be animated with the current
   * transition type of revealer.
   * Params:
   *   revealChild = %TRUE to reveal the child
   */
  void setRevealChild(bool revealChild)
  {
    gtk_revealer_set_reveal_child(cast(GtkRevealer*)cPtr, revealChild);
  }

  /**
   * Sets the duration that transitions will take.
   * Params:
   *   duration = the new duration, in milliseconds
   */
  void setTransitionDuration(uint duration)
  {
    gtk_revealer_set_transition_duration(cast(GtkRevealer*)cPtr, duration);
  }

  /**
   * Sets the type of animation that will be used for
   * transitions in revealer.
   * Available types include various kinds of fades and slides.
   * Params:
   *   transition = the new transition type
   */
  void setTransitionType(RevealerTransitionType transition)
  {
    gtk_revealer_set_transition_type(cast(GtkRevealer*)cPtr, transition);
  }
}
