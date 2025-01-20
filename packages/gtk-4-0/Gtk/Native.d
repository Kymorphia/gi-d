module Gtk.Native;

public import Gtk.NativeIfaceProxy;
import GObject.ObjectG;
import Gdk.Surface;
import Gid.gid;
import Gsk.Renderer;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * `GtkNative` is the interface implemented by all widgets that have
 * their own `GdkSurface`.
 * The obvious example of a `GtkNative` is `GtkWindow`.
 * Every widget that is not itself a `GtkNative` is contained in one,
 * and you can get it with [Gtk.Widget.getNative].
 * To get the surface of a `GtkNative`, use [Gtk.Native.getSurface].
 * It is also possible to find the `GtkNative` to which a surface
 * belongs, with [Gtk.Native.getForSurface].
 * In addition to a [Gdk.Surface], a `GtkNative` also provides
 * a [Gsk.Renderer] for rendering on that surface. To get the
 * renderer, use [Gtk.Native.getRenderer].
 */
interface Native
{

  static GType getType()
  {
    return gtk_native_get_type();
  }

  /**
   * Finds the `GtkNative` associated with the surface.
   * Params:
   *   surface = a `GdkSurface`
   * Returns: the `GtkNative` that is associated with surface
   */
  static Native getForSurface(Surface surface)
  {
    GtkNative* _cretval;
    _cretval = gtk_native_get_for_surface(surface ? cast(GdkSurface*)surface.cPtr(false) : null);
    auto _retval = _cretval ? ObjectG.getDObject!Native(cast(GtkNative*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns the renderer that is used for this `GtkNative`.
   * Returns: the renderer for self
   */
  Renderer getRenderer();

  /**
   * Returns the surface of this `GtkNative`.
   * Returns: the surface of self
   */
  Surface getSurface();

  /**
   * Retrieves the surface transform of self.
   * This is the translation from self's surface coordinates into
   * self's widget coordinates.
   * Params:
   *   x = return location for the x coordinate
   *   y = return location for the y coordinate
   */
  void getSurfaceTransform(out double x, out double y);

  /**
   * Realizes a `GtkNative`.
   * This should only be used by subclasses.
   */
  void realize();

  /**
   * Unrealizes a `GtkNative`.
   * This should only be used by subclasses.
   */
  void unrealize();
}
