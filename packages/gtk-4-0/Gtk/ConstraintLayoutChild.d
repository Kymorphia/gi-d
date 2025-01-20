module Gtk.ConstraintLayoutChild;

import Gid.gid;
import Gtk.LayoutChild;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkLayoutChild` subclass for children in a `GtkConstraintLayout`.
 */
class ConstraintLayoutChild : LayoutChild
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
    return gtk_constraint_layout_child_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }
}
