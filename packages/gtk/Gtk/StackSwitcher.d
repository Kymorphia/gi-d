module Gtk.StackSwitcher;

import GObject.ObjectG;
import Gid.gid;
import Gtk.Accessible;
import Gtk.AccessibleT;
import Gtk.Buildable;
import Gtk.BuildableT;
import Gtk.ConstraintTarget;
import Gtk.ConstraintTargetT;
import Gtk.Orientable;
import Gtk.OrientableT;
import Gtk.Stack;
import Gtk.Types;
import Gtk.Widget;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * The `GtkStackSwitcher` shows a row of buttons to switch between `GtkStack`
 * pages.
 * ![An example GtkStackSwitcher](stackswitcher.png)
 * It acts as a controller for the associated `GtkStack`.
 * All the content for the buttons comes from the properties of the stacks
 * [Gtk.StackPage] objects; the button visibility in a `GtkStackSwitcher`
 * widget is controlled by the visibility of the child in the `GtkStack`.
 * It is possible to associate multiple `GtkStackSwitcher` widgets
 * with the same `GtkStack` widget.
 * # CSS nodes
 * `GtkStackSwitcher` has a single CSS node named stackswitcher and
 * style class .stack-switcher.
 * When circumstances require it, `GtkStackSwitcher` adds the
 * .needs-attention style class to the widgets representing the
 * stack pages.
 * # Accessibility
 * `GtkStackSwitcher` uses the %GTK_ACCESSIBLE_ROLE_TAB_LIST role
 * and uses the %GTK_ACCESSIBLE_ROLE_TAB for its buttons.
 * # Orientable
 * Since GTK 4.4, `GtkStackSwitcher` implements `GtkOrientable` allowing
 * the stack switcher to be made vertical with
 * `[Gtk.Orientable.setOrientation]`.
 */
class StackSwitcher : Widget, Orientable
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return gtk_stack_switcher_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin OrientableT!GtkStackSwitcher;

  /**
   * Create a new `GtkStackSwitcher`.
   * Returns: a new `GtkStackSwitcher`.
   */
  this()
  {
    GtkWidget* _cretval;
    _cretval = gtk_stack_switcher_new();
    this(_cretval, false);
  }

  /**
   * Retrieves the stack.
   * Returns: the stack
   */
  Stack getStack()
  {
    GtkStack* _cretval;
    _cretval = gtk_stack_switcher_get_stack(cast(GtkStackSwitcher*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Stack(cast(GtkStack*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Sets the stack to control.
   * Params:
   *   stack = a `GtkStack`
   */
  void setStack(Stack stack)
  {
    gtk_stack_switcher_set_stack(cast(GtkStackSwitcher*)cPtr, stack ? cast(GtkStack*)stack.cPtr(false) : null);
  }
}
