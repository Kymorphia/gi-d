module Gtk.ShortcutsShortcut;

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
 * A `GtkShortcutsShortcut` represents a single keyboard shortcut or gesture
 * with a short text.
 * This widget is only meant to be used with `GtkShortcutsWindow`.
 */
class ShortcutsShortcut : Widget
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
    return gtk_shortcuts_shortcut_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }
}
