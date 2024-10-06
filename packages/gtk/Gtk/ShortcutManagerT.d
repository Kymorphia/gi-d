module Gtk.ShortcutManagerT;

public import Gid.gid;
public import Gtk.Types;
public import Gtk.c.functions;
public import Gtk.c.types;

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
template ShortcutManagerT(TStruct)
{
}
