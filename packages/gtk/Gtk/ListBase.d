module Gtk.ListBase;

import Gid.gid;
import Gtk.Accessible;
import Gtk.AccessibleT;
import Gtk.Buildable;
import Gtk.BuildableT;
import Gtk.ConstraintTarget;
import Gtk.ConstraintTargetT;
import Gtk.Orientable;
import Gtk.OrientableT;
import Gtk.Scrollable;
import Gtk.ScrollableT;
import Gtk.Types;
import Gtk.Widget;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkListBase` is the abstract base class for GTK's list widgets.
 */
class ListBase : Widget, Orientable, Scrollable
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
    return gtk_list_base_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin OrientableT!();
  mixin ScrollableT!();
}
