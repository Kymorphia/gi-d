module Gtk.ConstraintTarget;

public import Gtk.ConstraintTargetIfaceProxy;
import Gid.gid;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * The `GtkConstraintTarget` interface is implemented by objects that
 * can be used as source or target in `GtkConstraint`s.
 * Besides `GtkWidget`, it is also implemented by `GtkConstraintGuide`.
 */
interface ConstraintTarget
{

  static GType getType()
  {
    return gtk_constraint_target_get_type();
  }
}
