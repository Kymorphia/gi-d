module Gdk.Cursor;

import GObject.ObjectG;
import Gdk.Texture;
import Gdk.Types;
import Gdk.c.functions;
import Gdk.c.types;
import Gid.gid;

/**
 * `GdkCursor` is used to create and destroy cursors.
 * Cursors are immutable objects, so once you created them, there is no way
 * to modify them later. You should create a new cursor when you want to change
 * something about it.
 * Cursors by themselves are not very interesting: they must be bound to a
 * window for users to see them. This is done with [Gdk.Surface.setCursor]
 * or [Gdk.Surface.setDeviceCursor]. Applications will typically
 * use higher-level GTK functions such as [[Gtk.Widget.setCursor]](../gtk4/method.Widget.set_cursor.html)
 * instead.
 * Cursors are not bound to a given [Gdk.Display], so they can be shared.
 * However, the appearance of cursors may vary when used on different
 * platforms.
 * ## Named and texture cursors
 * There are multiple ways to create cursors. The platform's own cursors
 * can be created with [Gdk.Cursor.newFromName]. That function lists
 * the commonly available names that are shared with the CSS specification.
 * Other names may be available, depending on the platform in use. On some
 * platforms, what images are used for named cursors may be influenced by
 * the cursor theme.
 * Another option to create a cursor is to use [Gdk.Cursor.newFromTexture]
 * and provide an image to use for the cursor.
 * To ease work with unsupported cursors, a fallback cursor can be provided.
 * If a [Gdk.Surface] cannot use a cursor because of the reasons mentioned
 * above, it will try the fallback cursor. Fallback cursors can themselves have
 * fallback cursors again, so it is possible to provide a chain of progressively
 * easier to support cursors. If none of the provided cursors can be supported,
 * the default cursor will be the ultimate fallback.
 */
class Cursor : ObjectG
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
    return gdk_cursor_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new cursor by looking up name in the current cursor
   * theme.
   * A recommended set of cursor names that will work across different
   * platforms can be found in the CSS specification:
   * | | | | |
   * | --- | --- | ---- | --- |
   * | "none" | ![](default_cursor.png) "default" | ![](help_cursor.png) "help" | ![](pointer_cursor.png) "pointer" |
   * | ![](context_menu_cursor.png) "context-menu" | ![](progress_cursor.png) "progress" | ![](wait_cursor.png) "wait" | ![](cell_cursor.png) "cell" |
   * | ![](crosshair_cursor.png) "crosshair" | ![](text_cursor.png) "text" | ![](vertical_text_cursor.png) "vertical-text" | ![](alias_cursor.png) "alias" |
   * | ![](copy_cursor.png) "copy" | ![](no_drop_cursor.png) "no-drop" | ![](move_cursor.png) "move" | ![](not_allowed_cursor.png) "not-allowed" |
   * | ![](grab_cursor.png) "grab" | ![](grabbing_cursor.png) "grabbing" | ![](all_scroll_cursor.png) "all-scroll" | ![](col_resize_cursor.png) "col-resize" |
   * | ![](row_resize_cursor.png) "row-resize" | ![](n_resize_cursor.png) "n-resize" | ![](e_resize_cursor.png) "e-resize" | ![](s_resize_cursor.png) "s-resize" |
   * | ![](w_resize_cursor.png) "w-resize" | ![](ne_resize_cursor.png) "ne-resize" | ![](nw_resize_cursor.png) "nw-resize" | ![](sw_resize_cursor.png) "sw-resize" |
   * | ![](se_resize_cursor.png) "se-resize" | ![](ew_resize_cursor.png) "ew-resize" | ![](ns_resize_cursor.png) "ns-resize" | ![](nesw_resize_cursor.png) "nesw-resize" |
   * | ![](nwse_resize_cursor.png) "nwse-resize" | ![](zoom_in_cursor.png) "zoom-in" | ![](zoom_out_cursor.png) "zoom-out" | |
   * Params:
   *   name = the name of the cursor
   *   fallback = %NULL or the `GdkCursor` to fall back to when
   *     this one cannot be supported
   * Returns: a new `GdkCursor`, or %NULL if there is no
   *   cursor with the given name
   */
  static Cursor newFromName(string name, Cursor fallback)
  {
    GdkCursor* _cretval;
    const(char)* _name = name.toCString(false);
    _cretval = gdk_cursor_new_from_name(_name, fallback ? cast(GdkCursor*)fallback.cPtr(false) : null);
    auto _retval = _cretval ? ObjectG.getDObject!Cursor(cast(GdkCursor*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Creates a new cursor from a `GdkTexture`.
   * Params:
   *   texture = the texture providing the pixel data
   *   hotspotX = the horizontal offset of the “hotspot” of the cursor
   *   hotspotY = the vertical offset of the “hotspot” of the cursor
   *   fallback = the `GdkCursor` to fall back to when
   *     this one cannot be supported
   * Returns: a new `GdkCursor`
   */
  static Cursor newFromTexture(Texture texture, int hotspotX, int hotspotY, Cursor fallback)
  {
    GdkCursor* _cretval;
    _cretval = gdk_cursor_new_from_texture(texture ? cast(GdkTexture*)texture.cPtr(false) : null, hotspotX, hotspotY, fallback ? cast(GdkCursor*)fallback.cPtr(false) : null);
    auto _retval = _cretval ? ObjectG.getDObject!Cursor(cast(GdkCursor*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Returns the fallback for this cursor.
   * The fallback will be used if this cursor is not available on a given
   * `GdkDisplay`. For named cursors, this can happen when using nonstandard
   * names or when using an incomplete cursor theme. For textured cursors,
   * this can happen when the texture is too large or when the `GdkDisplay`
   * it is used on does not support textured cursors.
   * Returns: the fallback of the cursor or %NULL
   *   to use the default cursor as fallback
   */
  Cursor getFallback()
  {
    GdkCursor* _cretval;
    _cretval = gdk_cursor_get_fallback(cast(GdkCursor*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Cursor(cast(GdkCursor*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns the horizontal offset of the hotspot.
   * The hotspot indicates the pixel that will be directly above the cursor.
   * Note that named cursors may have a nonzero hotspot, but this function
   * will only return the hotspot position for cursors created with
   * [Gdk.Cursor.newFromTexture].
   * Returns: the horizontal offset of the hotspot or 0 for named cursors
   */
  int getHotspotX()
  {
    int _retval;
    _retval = gdk_cursor_get_hotspot_x(cast(GdkCursor*)cPtr);
    return _retval;
  }

  /**
   * Returns the vertical offset of the hotspot.
   * The hotspot indicates the pixel that will be directly above the cursor.
   * Note that named cursors may have a nonzero hotspot, but this function
   * will only return the hotspot position for cursors created with
   * [Gdk.Cursor.newFromTexture].
   * Returns: the vertical offset of the hotspot or 0 for named cursors
   */
  int getHotspotY()
  {
    int _retval;
    _retval = gdk_cursor_get_hotspot_y(cast(GdkCursor*)cPtr);
    return _retval;
  }

  /**
   * Returns the name of the cursor.
   * If the cursor is not a named cursor, %NULL will be returned.
   * Returns: the name of the cursor or %NULL
   *   if it is not a named cursor
   */
  string getName()
  {
    const(char)* _cretval;
    _cretval = gdk_cursor_get_name(cast(GdkCursor*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Returns the texture for the cursor.
   * If the cursor is a named cursor, %NULL will be returned.
   * Returns: the texture for cursor or %NULL
   *   if it is a named cursor
   */
  Texture getTexture()
  {
    GdkTexture* _cretval;
    _cretval = gdk_cursor_get_texture(cast(GdkCursor*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Texture(cast(GdkTexture*)_cretval, false) : null;
    return _retval;
  }
}
