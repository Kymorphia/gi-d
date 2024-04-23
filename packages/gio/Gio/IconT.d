module Gio.IconT;

public import GLib.ErrorG;
public import GLib.Types;
public import GLib.Variant;
public import GObject.ObjectG;
public import Gid.Gid;
public import Gio.Types;
public import Gio.c.functions;
public import Gio.c.types;

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
template IconT(TStruct)
{

  /**
   * a #GIcon, or %NULL when deserialization fails.
   */
  static Icon deserialize(Variant value)
  {
    GIcon* _cretval;
    _cretval = g_icon_deserialize(value ? value.cPtr!GVariant : null);
    Icon _retval = ObjectG.getDObject!Icon(cast(GIcon*)_cretval, true);
    return _retval;
  }

  /**
   * An object implementing the #GIcon
   * interface or %NULL if @error is set.
   */
  static Icon newForString(string str)
  {
    GIcon* _cretval;
    const(char)* _str = str.toCString(false);
    GError *_err;
    _cretval = g_icon_new_for_string(_str, &_err);
    if (_err)
      throw new ErrorG(_err);
    Icon _retval = ObjectG.getDObject!Icon(cast(GIcon*)_cretval, true);
    return _retval;
  }

  /**
   * %TRUE if @icon1 is equal to @icon2. %FALSE otherwise.
   */
  override bool equal(Icon icon2)
  {
    bool _retval;
    _retval = g_icon_equal(cPtr!GIcon, icon2 ? (cast(ObjectG)icon2).cPtr!GIcon : null);
    return _retval;
  }

  /**
   * a #guint containing a hash for the @icon, suitable for
   * use in a #GHashTable or similar data structure.
   */
  override uint hash()
  {
    uint _retval;
    _retval = g_icon_hash(cPtr!GIcon);
    return _retval;
  }

  /**
   * a #GVariant, or %NULL when serialization fails. The #GVariant will not be floating.
   */
  override Variant serialize()
  {
    GVariant* _cretval;
    _cretval = g_icon_serialize(cPtr!GIcon);
    Variant _retval = new Variant(cast(GVariant*)_cretval, true);
    return _retval;
  }

  /**
   * An allocated NUL-terminated UTF8 string or
   * %NULL if @icon can't be serialized. Use g_free() to free.
   */
  override string toString_()
  {
    char* _cretval;
    _cretval = g_icon_to_string(cPtr!GIcon);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }
}
