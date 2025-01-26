module Pango.Font;

import GObject.ObjectG;
import Gid.gid;
import HarfBuzz.Feature;
import Pango.Coverage;
import Pango.FontDescription;
import Pango.FontFace;
import Pango.FontMap;
import Pango.FontMetrics;
import Pango.PgLanguage;
import Pango.Types;
import Pango.c.functions;
import Pango.c.types;

/**
 * A `PangoFont` is used to represent a font in a
 * rendering-system-independent manner.
 */
class Font : ObjectG
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
    return pango_font_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Returns a description of the font, with font size set in points.
   * Use [Pango.Font.describeWithAbsoluteSize] if you want
   * the font size in device units.
   * Returns: a newly-allocated `PangoFontDescription` object.
   */
  FontDescription describe()
  {
    PangoFontDescription* _cretval;
    _cretval = pango_font_describe(cast(PangoFont*)cPtr);
    auto _retval = _cretval ? new FontDescription(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Returns a description of the font, with absolute font size set
   * in device units.
   * Use [Pango.Font.describe] if you want the font size in points.
   * Returns: a newly-allocated `PangoFontDescription` object.
   */
  FontDescription describeWithAbsoluteSize()
  {
    PangoFontDescription* _cretval;
    _cretval = pango_font_describe_with_absolute_size(cast(PangoFont*)cPtr);
    auto _retval = _cretval ? new FontDescription(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Computes the coverage map for a given font and language tag.
   * Params:
   *   language = the language tag
   * Returns: a newly-allocated `PangoCoverage`
   *   object.
   */
  Coverage getCoverage(PgLanguage language)
  {
    PangoCoverage* _cretval;
    _cretval = pango_font_get_coverage(cast(PangoFont*)cPtr, language ? cast(PangoLanguage*)language.cPtr(false) : null);
    auto _retval = _cretval ? ObjectG.getDObject!Coverage(cast(PangoCoverage*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Gets the `PangoFontFace` to which font belongs.
   * Returns: the `PangoFontFace`
   */
  FontFace getFace()
  {
    PangoFontFace* _cretval;
    _cretval = pango_font_get_face(cast(PangoFont*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!FontFace(cast(PangoFontFace*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Obtain the OpenType features that are provided by the font.
   * These are passed to the rendering system, together with features
   * that have been explicitly set via attributes.
   * Note that this does not include OpenType features which the
   * rendering system enables by default.
   * Params:
   *   features = Array to features in
   *   numFeatures = the number of used items in features
   */
  void getFeatures(ref Feature[] features, ref uint numFeatures)
  {
    uint _len;
    hb_feature_t[] _features;
    _features.length = _len;
    pango_font_get_features(cast(PangoFont*)cPtr, _features.ptr, _len, cast(uint*)&numFeatures);
    features.length = _len;
    foreach (i; 0 .. _len)
      features[i] = new Feature(cast(void*)&_features[i], false);
  }

  /**
   * Gets the font map for which the font was created.
   * Note that the font maintains a *weak* reference to
   * the font map, so if all references to font map are
   * dropped, the font map will be finalized even if there
   * are fonts created with the font map that are still alive.
   * In that case this function will return %NULL.
   * It is the responsibility of the user to ensure that the
   * font map is kept alive. In most uses this is not an issue
   * as a `PangoContext` holds a reference to the font map.
   * Returns: the `PangoFontMap`
   *   for the font
   */
  FontMap getFontMap()
  {
    PangoFontMap* _cretval;
    _cretval = pango_font_get_font_map(cast(PangoFont*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!FontMap(cast(PangoFontMap*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the logical and ink extents of a glyph within a font.
   * The coordinate system for each rectangle has its origin at the
   * base line and horizontal origin of the character with increasing
   * coordinates extending to the right and down. The macros PANGO_ASCENT$(LPAREN)$(RPAREN),
   * PANGO_DESCENT$(LPAREN)$(RPAREN), PANGO_LBEARING$(LPAREN)$(RPAREN), and PANGO_RBEARING$(LPAREN)$(RPAREN) can be used to convert
   * from the extents rectangle to more traditional font metrics. The units
   * of the rectangles are in 1/PANGO_SCALE of a device unit.
   * If font is %NULL, this function gracefully sets some sane values in the
   * output variables and returns.
   * Params:
   *   glyph = the glyph index
   *   inkRect = rectangle used to store the extents of the glyph as drawn
   *   logicalRect = rectangle used to store the logical extents of the glyph
   */
  void getGlyphExtents(Glyph glyph, out Rectangle inkRect, out Rectangle logicalRect)
  {
    pango_font_get_glyph_extents(cast(PangoFont*)cPtr, glyph, &inkRect, &logicalRect);
  }

  /**
   * Returns the languages that are supported by font.
   * If the font backend does not provide this information,
   * %NULL is returned. For the fontconfig backend, this
   * corresponds to the FC_LANG member of the FcPattern.
   * The returned array is only valid as long as the font
   * and its fontmap are valid.
   * Returns: an array of `PangoLanguage`
   */
  PgLanguage[] getLanguages()
  {
    PangoLanguage** _cretval;
    _cretval = pango_font_get_languages(cast(PangoFont*)cPtr);
    PgLanguage[] _retval;

    if (_cretval)
    {
      uint _cretlength;
      for (; _cretval[_cretlength] !is null; _cretlength++)
        break;
      _retval = new PgLanguage[_cretlength];
      foreach (i; 0 .. _cretlength)
        _retval[i] = new PgLanguage(cast(void*)_cretval[i], false);
    }
    return _retval;
  }

  /**
   * Gets overall metric information for a font.
   * Since the metrics may be substantially different for different scripts,
   * a language tag can be provided to indicate that the metrics should be
   * retrieved that correspond to the script$(LPAREN)s$(RPAREN) used by that language.
   * If font is %NULL, this function gracefully sets some sane values in the
   * output variables and returns.
   * Params:
   *   language = language tag used to determine which script
   *     to get the metrics for, or %NULL to indicate to get the metrics for
   *     the entire font.
   * Returns: a `PangoFontMetrics` object. The caller must call
   *   [Pango.FontMetrics.unref] when finished using the object.
   */
  FontMetrics getMetrics(PgLanguage language)
  {
    PangoFontMetrics* _cretval;
    _cretval = pango_font_get_metrics(cast(PangoFont*)cPtr, language ? cast(PangoLanguage*)language.cPtr(false) : null);
    auto _retval = _cretval ? new FontMetrics(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Returns whether the font provides a glyph for this character.
   * Params:
   *   wc = a Unicode character
   * Returns: `TRUE` if font can render wc
   */
  bool hasChar(dchar wc)
  {
    bool _retval;
    _retval = pango_font_has_char(cast(PangoFont*)cPtr, wc);
    return _retval;
  }
}
