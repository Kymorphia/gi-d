module PangoCairo.FontMap;

public import PangoCairo.FontMapIfaceProxy;
import GObject.ObjectG;
import Gid.gid;
import Pango.FontMap : DPangoFontMap = FontMap;
import PangoCairo.Types;
import PangoCairo.c.functions;
import PangoCairo.c.types;
import cairo.Types;

/**
 * `PangoCairoFontMap` is an interface exported by font maps for
 * use with Cairo.
 * The actual type of the font map will depend on the particular
 * font technology Cairo was compiled to use.
 */
interface FontMap
{

  static GType getType()
  {
    return pango_cairo_font_map_get_type();
  }

  /**
   * Gets a default `PangoCairoFontMap` to use with Cairo.
   * Note that the type of the returned object will depend on the
   * particular font backend Cairo was compiled to use; you generally
   * should only use the `PangoFontMap` and `PangoCairoFontMap`
   * interfaces on the returned object.
   * The default Cairo fontmap can be changed by using
   * [PangoCairo.FontMap.setDefault]. This can be used to
   * change the Cairo font backend that the default fontmap uses
   * for example.
   * Note that since Pango 1.32.6, the default fontmap is per-thread.
   * Each thread gets its own default fontmap. In this way, PangoCairo
   * can be used safely from multiple threads.
   * Returns: the default PangoCairo fontmap
   *   for the current thread. This object is owned by Pango and must
   *   not be freed.
   */
  static DPangoFontMap getDefault()
  {
    PangoFontMap* _cretval;
    _cretval = pango_cairo_font_map_get_default();
    auto _retval = _cretval ? ObjectG.getDObject!DPangoFontMap(cast(PangoFontMap*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Creates a new `PangoCairoFontMap` object.
   * A fontmap is used to cache information about available fonts,
   * and holds certain global parameters such as the resolution.
   * In most cases, you can use `funcPangoCairo.font_map_get_default]
   * instead.
   * Note that the type of the returned object will depend
   * on the particular font backend Cairo was compiled to use;
   * You generally should only use the `PangoFontMap` and
   * `PangoCairoFontMap` interfaces on the returned object.
   * You can override the type of backend returned by using an
   * environment variable %PANGOCAIRO_BACKEND. Supported types,
   * based on your build, are fc $(LPAREN)fontconfig$(RPAREN), win32, and coretext.
   * If requested type is not available, NULL is returned. Ie.
   * this is only useful for testing, when at least two backends
   * are compiled in.
   * Returns: the newly allocated `PangoFontMap`,
   *   which should be freed with [GObject.ObjectG.unref].
   */
  static DPangoFontMap new_()
  {
    PangoFontMap* _cretval;
    _cretval = pango_cairo_font_map_new();
    auto _retval = _cretval ? ObjectG.getDObject!DPangoFontMap(cast(PangoFontMap*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Creates a new `PangoCairoFontMap` object of the type suitable
   * to be used with cairo font backend of type fonttype.
   * In most cases one should simply use [PangoCairo.FontMap.new_], or
   * in fact in most of those cases, just use [PangoCairo.FontMap.getDefault].
   * Params:
   *   fonttype = desired #cairo_font_type_t
   * Returns: the newly allocated
   *   `PangoFontMap` of suitable type which should be freed with
   *   [GObject.ObjectG.unref], or %NULL if the requested cairo font backend
   *   is not supported / compiled in.
   */
  static DPangoFontMap newForFontType(FontType fonttype)
  {
    PangoFontMap* _cretval;
    _cretval = pango_cairo_font_map_new_for_font_type(fonttype);
    auto _retval = _cretval ? ObjectG.getDObject!DPangoFontMap(cast(PangoFontMap*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Gets the type of Cairo font backend that fontmap uses.
   * Returns: the `cairo_font_type_t` cairo font backend type
   */
  FontType getFontType();

  /**
   * Gets the resolution for the fontmap.
   * See [PangoCairo.FontMap.setResolution].
   * Returns: the resolution in "dots per inch"
   */
  double getResolution();

  /**
   * Sets a default `PangoCairoFontMap` to use with Cairo.
   * This can be used to change the Cairo font backend that the
   * default fontmap uses for example. The old default font map
   * is unreffed and the new font map referenced.
   * Note that since Pango 1.32.6, the default fontmap is per-thread.
   * This function only changes the default fontmap for
   * the current thread. Default fontmaps of existing threads
   * are not changed. Default fontmaps of any new threads will
   * still be created using [PangoCairo.FontMap.new_].
   * A value of %NULL for fontmap will cause the current default
   * font map to be released and a new default font map to be created
   * on demand, using [PangoCairo.FontMap.new_].
   */
  void setDefault();

  /**
   * Sets the resolution for the fontmap.
   * This is a scale factor between
   * points specified in a `PangoFontDescription` and Cairo units. The
   * default value is 96, meaning that a 10 point font will be 13
   * units high. $(LPAREN)10 * 96. / 72. \= 13.3$(RPAREN).
   * Params:
   *   dpi = the resolution in "dots per inch". $(LPAREN)Physical inches aren't actually
   *     involved; the terminology is conventional.$(RPAREN)
   */
  void setResolution(double dpi);
}
