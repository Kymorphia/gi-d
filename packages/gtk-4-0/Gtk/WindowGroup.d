module Gtk.WindowGroup;

import GLib.List;
import GObject.ObjectG;
import Gid.gid;
import Gtk.Types;
import Gtk.Window;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkWindowGroup` makes group of windows behave like separate applications.
 * It achieves this by limiting the effect of GTK grabs and modality
 * to windows in the same group.
 * A window can be a member in at most one window group at a time.
 * Windows that have not been explicitly assigned to a group are
 * implicitly treated like windows of the default window group.
 * `GtkWindowGroup` objects are referenced by each window in the group,
 * so once you have added all windows to a `GtkWindowGroup`, you can drop
 * the initial reference to the window group with [GObject.ObjectG.unref]. If the
 * windows in the window group are subsequently destroyed, then they will
 * be removed from the window group and drop their references on the window
 * group; when all window have been removed, the window group will be
 * freed.
 */
class WindowGroup : ObjectG
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return gtk_window_group_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new `GtkWindowGroup` object.
   * Modality of windows only affects windows
   * within the same `GtkWindowGroup`.
   * Returns: a new `GtkWindowGroup`.
   */
  this()
  {
    GtkWindowGroup* _cretval;
    _cretval = gtk_window_group_new();
    this(_cretval, true);
  }

  /**
   * Adds a window to a `GtkWindowGroup`.
   * Params:
   *   window = the `GtkWindow` to add
   */
  void addWindow(Window window)
  {
    gtk_window_group_add_window(cast(GtkWindowGroup*)cPtr, window ? cast(GtkWindow*)window.cPtr(false) : null);
  }

  /**
   * Returns a list of the `GtkWindows` that belong to window_group.
   * Returns: A
   *   newly-allocated list of windows inside the group.
   */
  List!(Window, GtkWindow) listWindows()
  {
    GList* _cretval;
    _cretval = gtk_window_group_list_windows(cast(GtkWindowGroup*)cPtr);
    List!(Window, GtkWindow) _retval = new List!(Window, GtkWindow)(cast(GList*)_cretval, GidOwnership.Container);
    return _retval;
  }

  /**
   * Removes a window from a `GtkWindowGroup`.
   * Params:
   *   window = the `GtkWindow` to remove
   */
  void removeWindow(Window window)
  {
    gtk_window_group_remove_window(cast(GtkWindowGroup*)cPtr, window ? cast(GtkWindow*)window.cPtr(false) : null);
  }
}
