module Pango.Color;

import GLib.Boxed;
import Gid.gid;
import Pango.Types;
import Pango.c.functions;
import Pango.c.types;

/**
 * The `PangoColor` structure is used to
 * represent a color in an uncalibrated RGB color-space.
 */
class Color : Boxed
{

  this()
  {
    super(safeMalloc(PangoColor.sizeof), true);
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
    return pango_color_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  @property ushort red()
  {
    return (cast(PangoColor*)cPtr).red;
  }

  @property void red(ushort propval)
  {
    (cast(PangoColor*)cPtr).red = propval;
  }

  @property ushort green()
  {
    return (cast(PangoColor*)cPtr).green;
  }

  @property void green(ushort propval)
  {
    (cast(PangoColor*)cPtr).green = propval;
  }

  @property ushort blue()
  {
    return (cast(PangoColor*)cPtr).blue;
  }

  @property void blue(ushort propval)
  {
    (cast(PangoColor*)cPtr).blue = propval;
  }

  /**
   * Creates a copy of src.
   * The copy should be freed with [Pango.Color.free].
   * Primarily used by language bindings, not that useful
   * otherwise $(LPAREN)since colors can just be copied by assignment
   * in C$(RPAREN).
   * Returns: the newly allocated `PangoColor`,
   *   which should be freed with [Pango.Color.free]
   */
  Color copy()
  {
    PangoColor* _cretval;
    _cretval = pango_color_copy(cast(PangoColor*)cPtr);
    auto _retval = _cretval ? new Color(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Fill in the fields of a color from a string specification.
   * The string can either one of a large set of standard names.
   * $(LPAREN)Taken from the CSS Color [specification](https://www.w3.org/TR/css-color-4/#named-colors),
   * or it can be a value in the form `#rgb`, `#rrggbb`,
   * `#rrrgggbbb` or `#rrrrggggbbbb`, where `r`, `g` and `b`
   * are hex digits of the red, green, and blue components
   * of the color, respectively. $(LPAREN)White in the four forms is
   * `#fff`, `#ffffff`, `#fffffffff` and `#ffffffffffff`.$(RPAREN)
   * Params:
   *   spec = a string specifying the new color
   * Returns: %TRUE if parsing of the specifier succeeded,
   *   otherwise %FALSE
   */
  bool parse(string spec)
  {
    bool _retval;
    const(char)* _spec = spec.toCString(false);
    _retval = pango_color_parse(cast(PangoColor*)cPtr, _spec);
    return _retval;
  }

  /**
   * Fill in the fields of a color from a string specification.
   * The string can either one of a large set of standard names.
   * $(LPAREN)Taken from the CSS Color [specification](https://www.w3.org/TR/css-color-4/#named-colors),
   * or it can be a hexadecimal value in the form `#rgb`,
   * `#rrggbb`, `#rrrgggbbb` or `#rrrrggggbbbb` where `r`, `g`
   * and `b` are hex digits of the red, green, and blue components
   * of the color, respectively. $(LPAREN)White in the four forms is
   * `#fff`, `#ffffff`, `#fffffffff` and `#ffffffffffff`.$(RPAREN)
   * Additionally, parse strings of the form `#rgba`, `#rrggbbaa`,
   * `#rrrrggggbbbbaaaa`, if alpha is not %NULL, and set alpha
   * to the value specified by the hex digits for `a`. If no alpha
   * component is found in spec, alpha is set to 0xffff $(LPAREN)for a
   * solid color$(RPAREN).
   * Params:
   *   alpha = return location for alpha
   *   spec = a string specifying the new color
   * Returns: %TRUE if parsing of the specifier succeeded,
   *   otherwise %FALSE
   */
  bool parseWithAlpha(out ushort alpha, string spec)
  {
    bool _retval;
    const(char)* _spec = spec.toCString(false);
    _retval = pango_color_parse_with_alpha(cast(PangoColor*)cPtr, cast(ushort*)&alpha, _spec);
    return _retval;
  }

  /**
   * Returns a textual specification of color.
   * The string is in the hexadecimal form `#rrrrggggbbbb`,
   * where `r`, `g` and `b` are hex digits representing the
   * red, green, and blue components respectively.
   * Returns: a newly-allocated text string that must
   *   be freed with [GLib.Global.gfree].
   */
  string toString_()
  {
    char* _cretval;
    _cretval = pango_color_to_string(cast(PangoColor*)cPtr);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }
}
