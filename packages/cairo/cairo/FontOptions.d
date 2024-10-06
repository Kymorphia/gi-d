module cairo.FontOptions;

import GLib.Boxed;
import Gid.gid;
import cairo.Types;
import cairo.c.functions;
import cairo.c.types;

/**
 * An opaque structure holding all options that are used when
 * rendering fonts.
 * Individual features of a #cairo_font_options_t can be set or
 * accessed using functions named
 * <function>cairo_font_options_set_<emphasis>feature_name</emphasis>$(LPAREN)$(RPAREN)</function> and
 * <function>cairo_font_options_get_<emphasis>feature_name</emphasis>$(LPAREN)$(RPAREN)</function>, like
 * [cairo.FontOptions.setAntialias] and
 * [cairo.FontOptions.getAntialias].
 * New features may be added to a #cairo_font_options_t in the
 * future.  For this reason, [cairo.FontOptions.copy],
 * [cairo.FontOptions.equal], [cairo.FontOptions.merge], and
 * [cairo.FontOptions.hash] should be used to copy, check
 * for equality, merge, or compute a hash value of
 * #cairo_font_options_t objects.
 */
class FontOptions : Boxed
{

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
    return cairo_gobject_font_options_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Allocates a new font options object copying the option values from
   * original.
   * Returns: a newly allocated #cairo_font_options_t. Free with
   *   [cairo.FontOptions.destroy]. This function always returns a
   *   valid pointer; if memory cannot be allocated, then a special
   *   error object is returned where all operations on the object do nothing.
   *   You can check for this with [cairo.FontOptions.status].
   */
  FontOptions copy()
  {
    cairo_font_options_t* _cretval;
    _cretval = cairo_font_options_copy(cast(cairo_font_options_t*)cPtr);
    auto _retval = _cretval ? new FontOptions(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Compares two font options objects for equality.
   * Params:
   *   other = another #cairo_font_options_t
   * Returns: %TRUE if all fields of the two font options objects match.
   *   Note that this function will return %FALSE if either object is in
   *   error.
   */
  Bool equal(FontOptions other)
  {
    Bool _retval;
    _retval = cairo_font_options_equal(cast(cairo_font_options_t*)cPtr, other ? cast(cairo_font_options_t*)other.cPtr(false) : null);
    return _retval;
  }

  /**
   * Gets the antialiasing mode for the font options object.
   * Returns: the antialiasing mode
   */
  Antialias getAntialias()
  {
    cairo_antialias_t _cretval;
    _cretval = cairo_font_options_get_antialias(cast(cairo_font_options_t*)cPtr);
    Antialias _retval = cast(Antialias)_cretval;
    return _retval;
  }

  /**
   * Gets the color mode for the font options object.
   * See the documentation for #cairo_color_mode_t for full details.
   * Returns: the color mode for the font options object
   */
  ColorMode getColorMode()
  {
    cairo_color_mode_t _cretval;
    _cretval = cairo_font_options_get_color_mode(cast(cairo_font_options_t*)cPtr);
    ColorMode _retval = cast(ColorMode)_cretval;
    return _retval;
  }

  /**
   * Gets the current OpenType color font palette for the font options object.
   * Returns: the palette index
   */
  uint getColorPalette()
  {
    uint _retval;
    _retval = cairo_font_options_get_color_palette(cast(cairo_font_options_t*)cPtr);
    return _retval;
  }

  /**
   * Gets the custom palette color for the color index for the font options object.
   * Params:
   *   index = the index of the color to get
   *   red = return location for red component of color
   *   green = return location for green component of color
   *   blue = return location for blue component of color
   *   alpha = return location for alpha component of color
   * Returns: `CAIRO_STATUS_SUCCESS` if a custom palette color is
   *   returned, `CAIRO_STATUS_INVALID_INDEX` if no custom color exists
   *   for the color index.
   */
  Status getCustomPaletteColor(uint index, out double red, out double green, out double blue, out double alpha)
  {
    cairo_status_t _cretval;
    _cretval = cairo_font_options_get_custom_palette_color(cast(cairo_font_options_t*)cPtr, index, cast(double*)&red, cast(double*)&green, cast(double*)&blue, cast(double*)&alpha);
    Status _retval = cast(Status)_cretval;
    return _retval;
  }

  /**
   * Gets the metrics hinting mode for the font options object.
   * See the documentation for #cairo_hint_metrics_t for full details.
   * Returns: the metrics hinting mode for the font options object
   */
  HintMetrics getHintMetrics()
  {
    cairo_hint_metrics_t _cretval;
    _cretval = cairo_font_options_get_hint_metrics(cast(cairo_font_options_t*)cPtr);
    HintMetrics _retval = cast(HintMetrics)_cretval;
    return _retval;
  }

  /**
   * Gets the hint style for font outlines for the font options object.
   * See the documentation for #cairo_hint_style_t for full details.
   * Returns: the hint style for the font options object
   */
  HintStyle getHintStyle()
  {
    cairo_hint_style_t _cretval;
    _cretval = cairo_font_options_get_hint_style(cast(cairo_font_options_t*)cPtr);
    HintStyle _retval = cast(HintStyle)_cretval;
    return _retval;
  }

  /**
   * Gets the subpixel order for the font options object.
   * See the documentation for #cairo_subpixel_order_t for full details.
   * Returns: the subpixel order for the font options object
   */
  SubpixelOrder getSubpixelOrder()
  {
    cairo_subpixel_order_t _cretval;
    _cretval = cairo_font_options_get_subpixel_order(cast(cairo_font_options_t*)cPtr);
    SubpixelOrder _retval = cast(SubpixelOrder)_cretval;
    return _retval;
  }

  /**
   * Gets the OpenType font variations for the font options object.
   * See [cairo.FontOptions.setVariations] for details about the
   * string format.
   * Returns: the font variations for the font options object. The
   *   returned string belongs to the options and must not be modified.
   *   It is valid until either the font options object is destroyed or
   *   the font variations in this object is modified with
   *   [cairo.FontOptions.setVariations].
   */
  string getVariations()
  {
    const(char)* _cretval;
    _cretval = cairo_font_options_get_variations(cast(cairo_font_options_t*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Compute a hash for the font options object; this value will
   * be useful when storing an object containing a #cairo_font_options_t
   * in a hash table.
   * Returns: the hash value for the font options object.
   *   The return value can be cast to a 32-bit type if a
   *   32-bit hash value is needed.
   */
  ulong hash()
  {
    ulong _retval;
    _retval = cairo_font_options_hash(cast(cairo_font_options_t*)cPtr);
    return _retval;
  }

  /**
   * Merges non-default options from other into options, replacing
   * existing values. This operation can be thought of as somewhat
   * similar to compositing other onto options with the operation
   * of %CAIRO_OPERATOR_OVER.
   * Params:
   *   other = another #cairo_font_options_t
   */
  void merge(FontOptions other)
  {
    cairo_font_options_merge(cast(cairo_font_options_t*)cPtr, other ? cast(cairo_font_options_t*)other.cPtr(false) : null);
  }

  /**
   * Sets the antialiasing mode for the font options object. This
   * specifies the type of antialiasing to do when rendering text.
   * Params:
   *   antialias = the new antialiasing mode
   */
  void setAntialias(Antialias antialias)
  {
    cairo_font_options_set_antialias(cast(cairo_font_options_t*)cPtr, antialias);
  }

  /**
   * Sets the color mode for the font options object. This controls
   * whether color fonts are to be rendered in color or as outlines.
   * See the documentation for #cairo_color_mode_t for full details.
   * Params:
   *   colorMode = the new color mode
   */
  void setColorMode(ColorMode colorMode)
  {
    cairo_font_options_set_color_mode(cast(cairo_font_options_t*)cPtr, colorMode);
  }

  /**
   * Sets the OpenType font color palette for the font options
   * object. OpenType color fonts with a CPAL table may contain multiple
   * palettes. The default color palette index is %CAIRO_COLOR_PALETTE_DEFAULT.
   * If palette_index is invalid, the default palette is used.
   * Individual colors within the palette may be overriden with
   * [cairo.FontOptions.setCustomPaletteColor].
   * Params:
   *   paletteIndex = the palette index in the CPAL table
   */
  void setColorPalette(uint paletteIndex)
  {
    cairo_font_options_set_color_palette(cast(cairo_font_options_t*)cPtr, paletteIndex);
  }

  /**
   * Sets a custom palette color for the font options object. This
   * overrides the palette color at the specified color index. This override is
   * independent of the selected palette index and will remain in place
   * even if [cairo.FontOptions.setColorPalette] is called to change
   * the palette index.
   * It is only possible to override color indexes already in the font
   * palette.
   * Params:
   *   index = the index of the color to set
   *   red = red component of color
   *   green = green component of color
   *   blue = blue component of color
   *   alpha = alpha component of color
   */
  void setCustomPaletteColor(uint index, double red, double green, double blue, double alpha)
  {
    cairo_font_options_set_custom_palette_color(cast(cairo_font_options_t*)cPtr, index, red, green, blue, alpha);
  }

  /**
   * Sets the metrics hinting mode for the font options object. This
   * controls whether metrics are quantized to integer values in
   * device units.
   * See the documentation for #cairo_hint_metrics_t for full details.
   * Params:
   *   hintMetrics = the new metrics hinting mode
   */
  void setHintMetrics(HintMetrics hintMetrics)
  {
    cairo_font_options_set_hint_metrics(cast(cairo_font_options_t*)cPtr, hintMetrics);
  }

  /**
   * Sets the hint style for font outlines for the font options object.
   * This controls whether to fit font outlines to the pixel grid,
   * and if so, whether to optimize for fidelity or contrast.
   * See the documentation for #cairo_hint_style_t for full details.
   * Params:
   *   hintStyle = the new hint style
   */
  void setHintStyle(HintStyle hintStyle)
  {
    cairo_font_options_set_hint_style(cast(cairo_font_options_t*)cPtr, hintStyle);
  }

  /**
   * Sets the subpixel order for the font options object. The subpixel
   * order specifies the order of color elements within each pixel on
   * the display device when rendering with an antialiasing mode of
   * %CAIRO_ANTIALIAS_SUBPIXEL. See the documentation for
   * #cairo_subpixel_order_t for full details.
   * Params:
   *   subpixelOrder = the new subpixel order
   */
  void setSubpixelOrder(SubpixelOrder subpixelOrder)
  {
    cairo_font_options_set_subpixel_order(cast(cairo_font_options_t*)cPtr, subpixelOrder);
  }

  /**
   * Sets the OpenType font variations for the font options object.
   * Font variations are specified as a string with a format that
   * is similar to the CSS font-variation-settings. The string contains
   * a comma-separated list of axis assignments, which each assignment
   * consists of a 4-character axis name and a value, separated by
   * whitespace and optional equals sign.
   * Examples:
   * wght\=200,wdth\=140.5
   * wght 200 , wdth 140.5
   * Params:
   *   variations = the new font variations, or %NULL
   */
  void setVariations(string variations)
  {
    const(char)* _variations = variations.toCString(false);
    cairo_font_options_set_variations(cast(cairo_font_options_t*)cPtr, _variations);
  }

  /**
   * Checks whether an error has previously occurred for this
   * font options object
   * Returns: %CAIRO_STATUS_SUCCESS, %CAIRO_STATUS_NO_MEMORY, or
   *   %CAIRO_STATUS_NULL_POINTER.
   */
  Status status()
  {
    cairo_status_t _cretval;
    _cretval = cairo_font_options_status(cast(cairo_font_options_t*)cPtr);
    Status _retval = cast(Status)_cretval;
    return _retval;
  }
}
