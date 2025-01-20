module Gtk.StackSidebar;

import GObject.ObjectG;
import Gid.gid;
import Gtk.Accessible;
import Gtk.AccessibleT;
import Gtk.Buildable;
import Gtk.BuildableT;
import Gtk.ConstraintTarget;
import Gtk.ConstraintTargetT;
import Gtk.Stack;
import Gtk.Types;
import Gtk.Widget;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * A `GtkStackSidebar` uses a sidebar to switch between `GtkStack` pages.
 * In order to use a `GtkStackSidebar`, you simply use a `GtkStack` to
 * organize your UI flow, and add the sidebar to your sidebar area. You
 * can use [Gtk.StackSidebar.setStack] to connect the `GtkStackSidebar`
 * to the `GtkStack`.
 * # CSS nodes
 * `GtkStackSidebar` has a single CSS node with name stacksidebar and
 * style class .sidebar.
 * When circumstances require it, `GtkStackSidebar` adds the
 * .needs-attention style class to the widgets representing the stack
 * pages.
 */
class StackSidebar : Widget
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return gtk_stack_sidebar_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new `GtkStackSidebar`.
   * Returns: the new `GtkStackSidebar`
   */
  this()
  {
    GtkWidget* _cretval;
    _cretval = gtk_stack_sidebar_new();
    this(_cretval, false);
  }

  /**
   * Retrieves the stack.
   * Returns: the associated `GtkStack` or
   *   %NULL if none has been set explicitly
   */
  Stack getStack()
  {
    GtkStack* _cretval;
    _cretval = gtk_stack_sidebar_get_stack(cast(GtkStackSidebar*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Stack(cast(GtkStack*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Set the `GtkStack` associated with this `GtkStackSidebar`.
   * The sidebar widget will automatically update according to
   * the order and items within the given `GtkStack`.
   * Params:
   *   stack = a `GtkStack`
   */
  void setStack(Stack stack)
  {
    gtk_stack_sidebar_set_stack(cast(GtkStackSidebar*)cPtr, stack ? cast(GtkStack*)stack.cPtr(false) : null);
  }
}
