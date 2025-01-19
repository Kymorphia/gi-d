module Gtk.SymbolicPaintable;

public import Gtk.SymbolicPaintableIfaceProxy;
import Gdk.RGBA;
import Gdk.Snapshot;
import Gid.gid;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkSymbolicPaintable` is an interface that support symbolic colors in
 * paintables.
 * `GdkPaintable`s implementing the interface will have the
 * vfunc@Gtk.SymbolicPaintable.snapshot_symbolic function called and
 * have the colors for drawing symbolic icons passed. At least 4 colors are guaranteed
 * to be passed every time.
 * These 4 colors are the foreground color, and the colors to use for errors, warnings
 * and success information in that order.
 * More colors may be added in the future.
 */
interface SymbolicPaintable
{

  static GType getType()
  {
    return gtk_symbolic_paintable_get_type();
  }

  /**
   * Snapshots the paintable with the given colors.
   * If less than 4 colors are provided, GTK will pad the array with default
   * colors.
   * Params:
   *   snapshot = a `GdkSnapshot` to snapshot to
   *   width = width to snapshot in
   *   height = height to snapshot in
   *   colors = a pointer to an array of colors
   */
  void snapshotSymbolic(Snapshot snapshot, double width, double height, RGBA[] colors);
}
