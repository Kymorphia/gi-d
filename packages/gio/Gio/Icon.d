module Gio.Icon;

import GLib.ErrorG;
import GLib.Types;
import GLib.Variant;
import GObject.ObjectG;
import Gid.Gid;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * #GIcon is a very minimal interface for icons. It provides functions
 * for checking the equality of two icons, hashing of icons and
 * serializing an icon to and from strings.
 *
 * #GIcon does not provide the actual pixmap for the icon as this is out
 * of GIO's scope, however implementations of #GIcon may contain the name
 * of an icon (see #GThemedIcon), or the path to an icon (see #GLoadableIcon).
 *
 * To obtain a hash of a #GIcon, see g_icon_hash().
 *
 * To check if two #GIcons are equal, see g_icon_equal().
 *
 * For serializing a #GIcon, use g_icon_serialize() and
 * g_icon_deserialize().
 *
 * If you want to consume #GIcon (for example, in a toolkit) you must
 * be prepared to handle at least the three following cases:
 * #GLoadableIcon, #GThemedIcon and #GEmblemedIcon.  It may also make
 * sense to have fast-paths for other cases (like handling #GdkPixbuf
 * directly, for example) but all compliant #GIcon implementations
 * outside of GIO must implement #GLoadableIcon.
 *
 * If your application or library provides one or more #GIcon
 * implementations you need to ensure that your new implementation also
 * implements #GLoadableIcon.  Additionally, you must provide an
 * implementation of g_icon_serialize() that gives a result that is
 * understood by g_icon_deserialize(), yielding one of the built-in icon
 * types.
 */
interface Icon
{

  static GType getType()
  {
    return g_icon_get_type();
  }

  /**
   * a #GIcon, or %NULL when deserialization fails.
   */
  static Icon deserialize(Variant value);

  /**
   * An object implementing the #GIcon
   * interface or %NULL if @error is set.
   */
  static Icon newForString(string str);

  /**
   * %TRUE if @icon1 is equal to @icon2. %FALSE otherwise.
   */
  bool equal(Icon icon2);

  /**
   * a #guint containing a hash for the @icon, suitable for
   * use in a #GHashTable or similar data structure.
   */
  uint hash();

  /**
   * a #GVariant, or %NULL when serialization fails. The #GVariant will not be floating.
   */
  Variant serialize();

  /**
   * An allocated NUL-terminated UTF8 string or
   * %NULL if @icon can't be serialized. Use g_free() to free.
   */
  string toString_();
}
