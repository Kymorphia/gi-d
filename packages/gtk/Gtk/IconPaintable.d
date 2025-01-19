module Gtk.IconPaintable;

import GObject.ObjectG;
import Gdk.Paintable;
import Gdk.PaintableT;
import Gid.gid;
import Gio.File;
import Gio.FileT;
import Gtk.SymbolicPaintable;
import Gtk.SymbolicPaintableT;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * Contains information found when looking up an icon in `GtkIconTheme`.
 * `GtkIconPaintable` implements `GdkPaintable`.
 */
class IconPaintable : ObjectG, Paintable, SymbolicPaintable
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
    return gtk_icon_paintable_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin PaintableT!();
  mixin SymbolicPaintableT!();

  /**
   * Creates a `GtkIconPaintable` for a file with a given size and scale.
   * The icon can then be rendered by using it as a `GdkPaintable`.
   * Params:
   *   file = a `GFile`
   *   size = desired icon size
   *   scale = the desired scale
   * Returns: a `GtkIconPaintable` containing
   *   for the icon. Unref with [GObject.ObjectG.unref]
   */
  static IconPaintable newForFile(File file, int size, int scale)
  {
    GtkIconPaintable* _cretval;
    _cretval = gtk_icon_paintable_new_for_file(file ? cast(GFile*)(cast(ObjectG)file).cPtr(false) : null, size, scale);
    auto _retval = _cretval ? ObjectG.getDObject!IconPaintable(cast(GtkIconPaintable*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Gets the `GFile` that was used to load the icon.
   * Returns %NULL if the icon was not loaded from a file.
   * Returns: the `GFile` for the icon
   */
  File getFile()
  {
    GFile* _cretval;
    _cretval = gtk_icon_paintable_get_file(cast(GtkIconPaintable*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!File(cast(GFile*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Get the icon name being used for this icon.
   * When an icon looked up in the icon theme was not available, the
   * icon theme may use fallback icons - either those specified to
   * [Gtk.IconTheme.lookupIcon] or the always-available
   * "image-missing". The icon chosen is returned by this function.
   * If the icon was created without an icon theme, this function
   * returns %NULL.
   * Returns: the themed icon-name for the
   *   icon, or %NULL if its not a themed icon.
   */
  string getIconName()
  {
    const(char)* _cretval;
    _cretval = gtk_icon_paintable_get_icon_name(cast(GtkIconPaintable*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Checks if the icon is symbolic or not.
   * This currently uses only the file name and not the file contents
   * for determining this. This behaviour may change in the future.
   * Note that to render a symbolic `GtkIconPaintable` properly $(LPAREN)with
   * recoloring$(RPAREN), you have to set its icon name on a `GtkImage`.
   * Returns: %TRUE if the icon is symbolic, %FALSE otherwise
   */
  bool isSymbolic()
  {
    bool _retval;
    _retval = gtk_icon_paintable_is_symbolic(cast(GtkIconPaintable*)cPtr);
    return _retval;
  }
}
