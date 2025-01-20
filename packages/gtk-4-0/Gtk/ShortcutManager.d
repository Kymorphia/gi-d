module Gtk.ShortcutManager;

public import Gtk.ShortcutManagerIfaceProxy;
import Gid.gid;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * The `GtkShortcutManager` interface is used to implement
 * shortcut scopes.
 * This is important for [Gtk.Native] widgets that have their
 * own surface, since the event controllers that are used to implement
 * managed and global scopes are limited to the same native.
 * Examples for widgets implementing `GtkShortcutManager` are
 * [Gtk.Window] and [Gtk.Popover].
 * Every widget that implements `GtkShortcutManager` will be used as a
 * %GTK_SHORTCUT_SCOPE_MANAGED.
 */
interface ShortcutManager
{

  static GType getType()
  {
    return gtk_shortcut_manager_get_type();
  }
}
