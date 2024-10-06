module Gdk.RGBA;

import GLib.Boxed;
import Gdk.Types;
import Gdk.c.functions;
import Gdk.c.types;
import Gid.gid;

/**
 * A `GdkRGBA` is used to represent a color, in a way that is compatible
 * with cairo’s notion of color.
 * `GdkRGBA` is a convenient way to pass colors around. It’s based on
 * cairo’s way to deal with colors and mirrors its behavior. All values
 * are in the range from 0.0 to 1.0 inclusive. So the color
 * $(LPAREN)0.0, 0.0, 0.0, 0.0$(RPAREN) represents transparent black and
 * $(LPAREN)1.0, 1.0, 1.0, 1.0$(RPAREN) is opaque white. Other values will
 * be clamped to this range when drawing.
 */
class RGBA : Boxed
{

  this()
  {
    super(safeMalloc(GdkRGBA.sizeof), true);
  }

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  void* cPtr(bool makeCopy = false)
  {
    return makeCopy ? copy_ : cInstancePtr;
  }

  static GType getType()
  {
    return gdk_rgba_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  @property float red()
  {
    return (cast(GdkRGBA*)cPtr).red;
  }

  @property void red(float propval)
  {
    (cast(GdkRGBA*)cPtr).red = propval;
  }

  @property float green()
  {
    return (cast(GdkRGBA*)cPtr).green;
  }

  @property void green(float propval)
  {
    (cast(GdkRGBA*)cPtr).green = propval;
  }

  @property float blue()
  {
    return (cast(GdkRGBA*)cPtr).blue;
  }

  @property void blue(float propval)
  {
    (cast(GdkRGBA*)cPtr).blue = propval;
  }

  @property float alpha()
  {
    return (cast(GdkRGBA*)cPtr).alpha;
  }

  @property void alpha(float propval)
  {
    (cast(GdkRGBA*)cPtr).alpha = propval;
  }

  /**
   * Makes a copy of a `GdkRGBA`.
   * The result must be freed through [Gdk.RGBA.free].
   * Returns: A newly allocated `GdkRGBA`, with the same contents as rgba
   */
  RGBA copy()
  {
    GdkRGBA* _cretval;
    _cretval = gdk_rgba_copy(cast(GdkRGBA*)cPtr);
    auto _retval = _cretval ? new RGBA(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Compares two `GdkRGBA` colors.
   * Params:
   *   p2 = another `GdkRGBA`
   * Returns: %TRUE if the two colors compare equal
   */
  bool equal(RGBA p2)
  {
    bool _retval;
    _retval = gdk_rgba_equal(cast(GdkRGBA*)cPtr, p2 ? cast(GdkRGBA*)p2.cPtr(false) : null);
    return _retval;
  }

  /**
   * A hash function suitable for using for a hash
   * table that stores `GdkRGBA`s.
   * Returns: The hash value for p
   */
  uint hash()
  {
    uint _retval;
    _retval = gdk_rgba_hash(cast(GdkRGBA*)cPtr);
    return _retval;
  }

  /**
   * Checks if an rgba value is transparent.
   * That is, drawing with the value would not produce any change.
   * Returns: %TRUE if the rgba is clear
   */
  bool isClear()
  {
    bool _retval;
    _retval = gdk_rgba_is_clear(cast(GdkRGBA*)cPtr);
    return _retval;
  }

  /**
   * Checks if an rgba value is opaque.
   * That is, drawing with the value will not retain any results
   * from previous contents.
   * Returns: %TRUE if the rgba is opaque
   */
  bool isOpaque()
  {
    bool _retval;
    _retval = gdk_rgba_is_opaque(cast(GdkRGBA*)cPtr);
    return _retval;
  }

  /**
   * Parses a textual representation of a color.
   * The string can be either one of:
   * - A standard name $(LPAREN)Taken from the CSS specification$(RPAREN).
   * - A hexadecimal value in the form “\#rgb”, “\#rrggbb”,
   * “\#rrrgggbbb” or ”\#rrrrggggbbbb”
   * - A hexadecimal value in the form “\#rgba”, “\#rrggbbaa”,
   * or ”\#rrrrggggbbbbaaaa”
   * - A RGB color in the form “rgb$(LPAREN)r,g,b$(RPAREN)” $(LPAREN)In this case the color
   * will have full opacity$(RPAREN)
   * - A RGBA color in the form “rgba$(LPAREN)r,g,b,a$(RPAREN)”
   * - A HSL color in the form "hsl$(LPAREN)hue, saturation, lightness$(RPAREN)"
   * - A HSLA color in the form "hsla$(LPAREN)hue, saturation, lightness, alpha$(RPAREN)"
   * Where “r”, “g”, “b” and “a” are respectively the red, green,
   * blue and alpha color values. In the last two cases, “r”, “g”,
   * and “b” are either integers in the range 0 to 255 or percentage
   * values in the range 0% to 100%, and a is a floating point value
   * in the range 0 to 1.
   * Params:
   *   spec = the string specifying the color
   * Returns: %TRUE if the parsing succeeded
   */
  bool parse(string spec)
  {
    bool _retval;
    const(char)* _spec = spec.toCString(false);
    _retval = gdk_rgba_parse(cast(GdkRGBA*)cPtr, _spec);
    return _retval;
  }

  /**
   * Returns a textual specification of rgba in the form
   * `rgb$(LPAREN)r,g,b$(RPAREN)` or `rgba$(LPAREN)r,g,b,a$(RPAREN)`, where “r”, “g”, “b” and
   * “a” represent the red, green, blue and alpha values
   * respectively. “r”, “g”, and “b” are represented as integers
   * in the range 0 to 255, and “a” is represented as a floating
   * point value in the range 0 to 1.
   * These string forms are string forms that are supported by
   * the CSS3 colors module, and can be parsed by [Gdk.RGBA.parse].
   * Note that this string representation may lose some precision,
   * since “r”, “g” and “b” are represented as 8-bit integers. If
   * this is a concern, you should use a different representation.
   * Returns: A newly allocated text string
   */
  string toString_()
  {
    char* _cretval;
    _cretval = gdk_rgba_to_string(cast(GdkRGBA*)cPtr);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }
}
