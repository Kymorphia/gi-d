module Gtk.NativeT;

public import Gtk.NativeIfaceProxy;
public import GObject.ObjectG;
public import Gdk.Surface;
public import Gid.gid;
public import Gsk.Renderer;
public import Gtk.Types;
public import Gtk.c.functions;
public import Gtk.c.types;

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
template NativeT()
{


  /**
   * Returns the renderer that is used for this `GtkNative`.
   * Returns: the renderer for self
   */
  override Renderer getRenderer()
  {
    GskRenderer* _cretval;
    _cretval = gtk_native_get_renderer(cast(GtkNative*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Renderer(cast(GskRenderer*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns the surface of this `GtkNative`.
   * Returns: the surface of self
   */
  override Surface getSurface()
  {
    GdkSurface* _cretval;
    _cretval = gtk_native_get_surface(cast(GtkNative*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Surface(cast(GdkSurface*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Retrieves the surface transform of self.
   * This is the translation from self's surface coordinates into
   * self's widget coordinates.
   * Params:
   *   x = return location for the x coordinate
   *   y = return location for the y coordinate
   */
  override void getSurfaceTransform(out double x, out double y)
  {
    gtk_native_get_surface_transform(cast(GtkNative*)cPtr, cast(double*)&x, cast(double*)&y);
  }

  /**
   * Realizes a `GtkNative`.
   * This should only be used by subclasses.
   */
  override void realize()
  {
    gtk_native_realize(cast(GtkNative*)cPtr);
  }

  /**
   * Unrealizes a `GtkNative`.
   * This should only be used by subclasses.
   */
  override void unrealize()
  {
    gtk_native_unrealize(cast(GtkNative*)cPtr);
  }
}
