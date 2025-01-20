module Gtk.ShortcutsGroup;

import Gid.gid;
import Gtk.Accessible;
import Gtk.AccessibleT;
import Gtk.Box;
import Gtk.Buildable;
import Gtk.BuildableT;
import Gtk.ConstraintTarget;
import Gtk.ConstraintTargetT;
import Gtk.Orientable;
import Gtk.OrientableT;
import Gtk.ShortcutsShortcut;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * A `GtkShortcutsGroup` represents a group of related keyboard shortcuts
 * or gestures.
 * The group has a title. It may optionally be associated with a view
 * of the application, which can be used to show only relevant shortcuts
 * depending on the application context.
 * This widget is only meant to be used with [Gtk.ShortcutsWindow].
 * The recommended way to construct a `GtkShortcutsGroup` is with
 * [Gtk.Builder], by using the `<child>` tag to populate a
 * `GtkShortcutsGroup` with one or more [Gtk.ShortcutsShortcut]
 * instances.
 * If you need to add a shortcut programmatically, use
 * [Gtk.ShortcutsGroup.addShortcut].
 */
class ShortcutsGroup : Box
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
    return gtk_shortcuts_group_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Adds a shortcut to the shortcuts group.
   * This is the programmatic equivalent to using [Gtk.Builder] and a
   * `<child>` tag to add the child. Adding children with other API is not
   * appropriate as `GtkShortcutsGroup` manages its children internally.
   * Params:
   *   shortcut = the `GtkShortcutsShortcut` to add
   */
  void addShortcut(ShortcutsShortcut shortcut)
  {
    gtk_shortcuts_group_add_shortcut(cast(GtkShortcutsGroup*)cPtr, shortcut ? cast(GtkShortcutsShortcut*)shortcut.cPtr(false) : null);
  }
}
