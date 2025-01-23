module Gio.IconT;

public import Gio.IconIfaceProxy;
public import GLib.ErrorG;
public import GLib.VariantG;
public import GObject.ObjectG;
public import Gid.gid;
public import Gio.Types;
public import Gio.c.functions;
public import Gio.c.types;

/**
 * `GIcon` is a very minimal interface for icons. It provides functions
 * for checking the equality of two icons, hashing of icons and
 * serializing an icon to and from strings.
 * `GIcon` does not provide the actual pixmap for the icon as this is out
 * of GIO's scope, however implementations of `GIcon` may contain the name
 * of an icon $(LPAREN)see [Gio.ThemedIcon]$(RPAREN), or the path to an icon
 * $(LPAREN)see [Gio.LoadableIcon]$(RPAREN).
 * To obtain a hash of a `GIcon`, see [Gio.Icon.hash].
 * To check if two `GIcon`s are equal, see [Gio.Icon.equal].
 * For serializing a `GIcon`, use [Gio.Icon.serialize] and
 * [Gio.Icon.deserialize].
 * If you want to consume `GIcon` $(LPAREN)for example, in a toolkit$(RPAREN) you must
 * be prepared to handle at least the three following cases:
 * [Gio.LoadableIcon], [Gio.ThemedIcon] and [Gio.EmblemedIcon].
 * It may also make sense to have fast-paths for other cases $(LPAREN)like handling
 * [`GdkPixbuf`](https://docs.gtk.org/gdk-pixbuf/class.Pixbuf.html) directly,
 * for example$(RPAREN) but all compliant `GIcon` implementations outside of GIO must
 * implement [Gio.LoadableIcon].
 * If your application or library provides one or more `GIcon`
 * implementations you need to ensure that your new implementation also
 * implements [Gio.LoadableIcon].  Additionally, you must provide an
 * implementation of [Gio.Icon.serialize] that gives a result that is
 * understood by [Gio.Icon.deserialize], yielding one of the built-in
 * icon types.
 */
template IconT()
{



  /**
   * Checks if two icons are equal.
   * Params:
   *   icon2 = pointer to the second #GIcon.
   * Returns: %TRUE if icon1 is equal to icon2. %FALSE otherwise.
   */
  override bool equal(Icon icon2)
  {
    bool _retval;
    _retval = g_icon_equal(cast(GIcon*)cPtr, icon2 ? cast(GIcon*)(cast(ObjectG)icon2).cPtr(false) : null);
    return _retval;
  }

  /**
   * Gets a hash for an icon.
   * Returns: a #guint containing a hash for the icon, suitable for
   *   use in a #GHashTable or similar data structure.
   */
  override uint hash()
  {
    uint _retval;
    _retval = g_icon_hash(cast(GIcon*)cPtr);
    return _retval;
  }

  /**
   * Serializes a #GIcon into a #GVariant. An equivalent #GIcon can be retrieved
   * back by calling [Gio.Icon.deserialize] on the returned value.
   * As serialization will avoid using raw icon data when possible, it only
   * makes sense to transfer the #GVariant between processes on the same machine,
   * $(LPAREN)as opposed to over the network$(RPAREN), and within the same file system namespace.
   * Returns: a #GVariant, or %NULL when serialization fails. The #GVariant will not be floating.
   */
  override VariantG serialize()
  {
    VariantC* _cretval;
    _cretval = g_icon_serialize(cast(GIcon*)cPtr);
    auto _retval = _cretval ? new VariantG(cast(VariantC*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Generates a textual representation of icon that can be used for
   * serialization such as when passing icon to a different process or
   * saving it to persistent storage. Use [Gio.Icon.newForString] to
   * get icon back from the returned string.
   * The encoding of the returned string is proprietary to #GIcon except
   * in the following two cases
   * - If icon is a #GFileIcon, the returned string is a native path
   * $(LPAREN)such as `/path/to/my icon.png`$(RPAREN) without escaping
   * if the #GFile for icon is a native file.  If the file is not
   * native, the returned string is the result of [Gio.File.getUri]
   * $(LPAREN)such as `sftp://path/to/my%20icon.png`$(RPAREN).
   * - If icon is a #GThemedIcon with exactly one name and no fallbacks,
   * the encoding is simply the name $(LPAREN)such as `network-server`$(RPAREN).
   * Returns: An allocated NUL-terminated UTF8 string or
   *   %NULL if icon can't be serialized. Use [GLib.Global.gfree] to free.
   */
  override string toString_()
  {
    char* _cretval;
    _cretval = g_icon_to_string(cast(GIcon*)cPtr);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }
}
