module Pango.Context;

import GObject.ObjectG;
import Gid.gid;
import Pango.Font;
import Pango.FontDescription;
import Pango.FontFamily;
import Pango.FontMap;
import Pango.FontMetrics;
import Pango.Fontset;
import Pango.Matrix;
import Pango.PgLanguage;
import Pango.Types;
import Pango.c.functions;
import Pango.c.types;

/**
 * A `PangoContext` stores global information used to control the
 * itemization process.
 * The information stored by `PangoContext` includes the fontmap used
 * to look up fonts, and default values such as the default language,
 * default gravity, or default font.
 * To obtain a `PangoContext`, use [Pango.FontMap.createContext].
 */
class Context : ObjectG
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return pango_context_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new `PangoContext` initialized to default values.
   * This function is not particularly useful as it should always
   * be followed by a [Pango.Context.setFontMap] call, and the
   * function [Pango.FontMap.createContext] does these two steps
   * together and hence users are recommended to use that.
   * If you are using Pango as part of a higher-level system,
   * that system may have it's own way of create a `PangoContext`.
   * For instance, the GTK toolkit has, among others,
   * `[Gtk.Widget.getPangoContext]`. Use those instead.
   * Returns: the newly allocated `PangoContext`, which should
   *   be freed with [GObject.ObjectG.unref].
   */
  this()
  {
    PangoContext* _cretval;
    _cretval = pango_context_new();
    this(_cretval, true);
  }

  /**
   * Forces a change in the context, which will cause any `PangoLayout`
   * using this context to re-layout.
   * This function is only useful when implementing a new backend
   * for Pango, something applications won't do. Backends should
   * call this function if they have attached extra data to the context
   * and such data is changed.
   */
  void changed()
  {
    pango_context_changed(cast(PangoContext*)cPtr);
  }

  /**
   * Retrieves the base direction for the context.
   * See [Pango.Context.setBaseDir].
   * Returns: the base direction for the context.
   */
  Direction getBaseDir()
  {
    PangoDirection _cretval;
    _cretval = pango_context_get_base_dir(cast(PangoContext*)cPtr);
    Direction _retval = cast(Direction)_cretval;
    return _retval;
  }

  /**
   * Retrieves the base gravity for the context.
   * See [Pango.Context.setBaseGravity].
   * Returns: the base gravity for the context.
   */
  Gravity getBaseGravity()
  {
    PangoGravity _cretval;
    _cretval = pango_context_get_base_gravity(cast(PangoContext*)cPtr);
    Gravity _retval = cast(Gravity)_cretval;
    return _retval;
  }

  /**
   * Retrieve the default font description for the context.
   * Returns: a pointer to the context's default font
   *   description. This value must not be modified or freed.
   */
  FontDescription getFontDescription()
  {
    PangoFontDescription* _cretval;
    _cretval = pango_context_get_font_description(cast(PangoContext*)cPtr);
    auto _retval = _cretval ? new FontDescription(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the `PangoFontMap` used to look up fonts for this context.
   * Returns: the font map for the.
   *   `PangoContext` This value is owned by Pango and should not be
   *   unreferenced.
   */
  FontMap getFontMap()
  {
    PangoFontMap* _cretval;
    _cretval = pango_context_get_font_map(cast(PangoContext*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!FontMap(cast(PangoFontMap*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Retrieves the gravity for the context.
   * This is similar to [Pango.Context.getBaseGravity],
   * except for when the base gravity is %PANGO_GRAVITY_AUTO for
   * which funcPango.Gravity.get_for_matrix is used to return the
   * gravity from the current context matrix.
   * Returns: the resolved gravity for the context.
   */
  Gravity getGravity()
  {
    PangoGravity _cretval;
    _cretval = pango_context_get_gravity(cast(PangoContext*)cPtr);
    Gravity _retval = cast(Gravity)_cretval;
    return _retval;
  }

  /**
   * Retrieves the gravity hint for the context.
   * See [Pango.Context.setGravityHint] for details.
   * Returns: the gravity hint for the context.
   */
  GravityHint getGravityHint()
  {
    PangoGravityHint _cretval;
    _cretval = pango_context_get_gravity_hint(cast(PangoContext*)cPtr);
    GravityHint _retval = cast(GravityHint)_cretval;
    return _retval;
  }

  /**
   * Retrieves the global language tag for the context.
   * Returns: the global language tag.
   */
  PgLanguage getLanguage()
  {
    PangoLanguage* _cretval;
    _cretval = pango_context_get_language(cast(PangoContext*)cPtr);
    auto _retval = _cretval ? new PgLanguage(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the transformation matrix that will be applied when
   * rendering with this context.
   * See [Pango.Context.setMatrix].
   * Returns: the matrix, or %NULL if no
   *   matrix has been set $(LPAREN)which is the same as the identity matrix$(RPAREN).
   *   The returned matrix is owned by Pango and must not be modified
   *   or freed.
   */
  Matrix getMatrix()
  {
    const(PangoMatrix)* _cretval;
    _cretval = pango_context_get_matrix(cast(PangoContext*)cPtr);
    auto _retval = _cretval ? new Matrix(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Get overall metric information for a particular font description.
   * Since the metrics may be substantially different for different scripts,
   * a language tag can be provided to indicate that the metrics should be
   * retrieved that correspond to the script$(LPAREN)s$(RPAREN) used by that language.
   * The `PangoFontDescription` is interpreted in the same way as by funcitemize,
   * and the family name may be a comma separated list of names. If characters
   * from multiple of these families would be used to render the string, then
   * the returned fonts would be a composite of the metrics for the fonts loaded
   * for the individual families.
   * Params:
   *   desc = a `PangoFontDescription` structure. %NULL means that the
   *     font description from the context will be used.
   *   language = language tag used to determine which script to get
   *     the metrics for. %NULL means that the language tag from the context
   *     will be used. If no language tag is set on the context, metrics
   *     for the default language $(LPAREN)as determined by [Pango.PgLanguage.getDefault]
   *     will be returned.
   * Returns: a `PangoFontMetrics` object. The caller must call
   *   [Pango.FontMetrics.unref] when finished using the object.
   */
  FontMetrics getMetrics(FontDescription desc, PgLanguage language)
  {
    PangoFontMetrics* _cretval;
    _cretval = pango_context_get_metrics(cast(PangoContext*)cPtr, desc ? cast(PangoFontDescription*)desc.cPtr(false) : null, language ? cast(PangoLanguage*)language.cPtr(false) : null);
    auto _retval = _cretval ? new FontMetrics(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Returns whether font rendering with this context should
   * round glyph positions and widths.
   * Returns:
   */
  bool getRoundGlyphPositions()
  {
    bool _retval;
    _retval = pango_context_get_round_glyph_positions(cast(PangoContext*)cPtr);
    return _retval;
  }

  /**
   * Returns the current serial number of context.
   * The serial number is initialized to an small number larger than zero
   * when a new context is created and is increased whenever the context
   * is changed using any of the setter functions, or the `PangoFontMap` it
   * uses to find fonts has changed. The serial may wrap, but will never
   * have the value 0. Since it can wrap, never compare it with "less than",
   * always use "not equals".
   * This can be used to automatically detect changes to a `PangoContext`,
   * and is only useful when implementing objects that need update when their
   * `PangoContext` changes, like `PangoLayout`.
   * Returns: The current serial number of context.
   */
  uint getSerial()
  {
    uint _retval;
    _retval = pango_context_get_serial(cast(PangoContext*)cPtr);
    return _retval;
  }

  /**
   * List all families for a context.
   * Params:
   *   families = location
   *     to store a pointer to an array of `PangoFontFamily`. This array should
   *     be freed with [GLib.Global.gfree].
   */
  void listFamilies(out FontFamily[] families)
  {
    int _nFamilies;
    PangoFontFamily** _families;
    pango_context_list_families(cast(PangoContext*)cPtr, &_families, &_nFamilies);
    families.length = _nFamilies;
    foreach (i; 0 .. _nFamilies)
      families[i] = ObjectG.getDObject!FontFamily(_families[i], false);
    safeFree(cast(void*)_families);
  }

  /**
   * Loads the font in one of the fontmaps in the context
   * that is the closest match for desc.
   * Params:
   *   desc = a `PangoFontDescription` describing the font to load
   * Returns: the newly allocated `PangoFont`
   *   that was loaded, or %NULL if no font matched.
   */
  Font loadFont(FontDescription desc)
  {
    PangoFont* _cretval;
    _cretval = pango_context_load_font(cast(PangoContext*)cPtr, desc ? cast(PangoFontDescription*)desc.cPtr(false) : null);
    auto _retval = _cretval ? ObjectG.getDObject!Font(cast(PangoFont*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Load a set of fonts in the context that can be used to render
   * a font matching desc.
   * Params:
   *   desc = a `PangoFontDescription` describing the fonts to load
   *   language = a `PangoLanguage` the fonts will be used for
   * Returns: the newly allocated
   *   `PangoFontset` loaded, or %NULL if no font matched.
   */
  Fontset loadFontset(FontDescription desc, PgLanguage language)
  {
    PangoFontset* _cretval;
    _cretval = pango_context_load_fontset(cast(PangoContext*)cPtr, desc ? cast(PangoFontDescription*)desc.cPtr(false) : null, language ? cast(PangoLanguage*)language.cPtr(false) : null);
    auto _retval = _cretval ? ObjectG.getDObject!Fontset(cast(PangoFontset*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Sets the base direction for the context.
   * The base direction is used in applying the Unicode bidirectional
   * algorithm; if the direction is %PANGO_DIRECTION_LTR or
   * %PANGO_DIRECTION_RTL, then the value will be used as the paragraph
   * direction in the Unicode bidirectional algorithm. A value of
   * %PANGO_DIRECTION_WEAK_LTR or %PANGO_DIRECTION_WEAK_RTL is used only
   * for paragraphs that do not contain any strong characters themselves.
   * Params:
   *   direction = the new base direction
   */
  void setBaseDir(Direction direction)
  {
    pango_context_set_base_dir(cast(PangoContext*)cPtr, direction);
  }

  /**
   * Sets the base gravity for the context.
   * The base gravity is used in laying vertical text out.
   * Params:
   *   gravity = the new base gravity
   */
  void setBaseGravity(Gravity gravity)
  {
    pango_context_set_base_gravity(cast(PangoContext*)cPtr, gravity);
  }

  /**
   * Set the default font description for the context
   * Params:
   *   desc = the new pango font description
   */
  void setFontDescription(FontDescription desc)
  {
    pango_context_set_font_description(cast(PangoContext*)cPtr, desc ? cast(PangoFontDescription*)desc.cPtr(false) : null);
  }

  /**
   * Sets the font map to be searched when fonts are looked-up
   * in this context.
   * This is only for internal use by Pango backends, a `PangoContext`
   * obtained via one of the recommended methods should already have a
   * suitable font map.
   * Params:
   *   fontMap = the `PangoFontMap` to set.
   */
  void setFontMap(FontMap fontMap)
  {
    pango_context_set_font_map(cast(PangoContext*)cPtr, fontMap ? cast(PangoFontMap*)fontMap.cPtr(false) : null);
  }

  /**
   * Sets the gravity hint for the context.
   * The gravity hint is used in laying vertical text out, and
   * is only relevant if gravity of the context as returned by
   * [Pango.Context.getGravity] is set to %PANGO_GRAVITY_EAST
   * or %PANGO_GRAVITY_WEST.
   * Params:
   *   hint = the new gravity hint
   */
  void setGravityHint(GravityHint hint)
  {
    pango_context_set_gravity_hint(cast(PangoContext*)cPtr, hint);
  }

  /**
   * Sets the global language tag for the context.
   * The default language for the locale of the running process
   * can be found using [Pango.PgLanguage.getDefault].
   * Params:
   *   language = the new language tag.
   */
  void setLanguage(PgLanguage language)
  {
    pango_context_set_language(cast(PangoContext*)cPtr, language ? cast(PangoLanguage*)language.cPtr(false) : null);
  }

  /**
   * Sets the transformation matrix that will be applied when rendering
   * with this context.
   * Note that reported metrics are in the user space coordinates before
   * the application of the matrix, not device-space coordinates after the
   * application of the matrix. So, they don't scale with the matrix, though
   * they may change slightly for different matrices, depending on how the
   * text is fit to the pixel grid.
   * Params:
   *   matrix = a `PangoMatrix`, or %NULL to unset any existing
   *     matrix. $(LPAREN)No matrix set is the same as setting the identity matrix.$(RPAREN)
   */
  void setMatrix(Matrix matrix)
  {
    pango_context_set_matrix(cast(PangoContext*)cPtr, matrix ? cast(PangoMatrix*)matrix.cPtr(false) : null);
  }

  /**
   * Sets whether font rendering with this context should
   * round glyph positions and widths to integral positions,
   * in device units.
   * This is useful when the renderer can't handle subpixel
   * positioning of glyphs.
   * The default value is to round glyph positions, to remain
   * compatible with previous Pango behavior.
   * Params:
   *   roundPositions = whether to round glyph positions
   */
  void setRoundGlyphPositions(bool roundPositions)
  {
    pango_context_set_round_glyph_positions(cast(PangoContext*)cPtr, roundPositions);
  }
}
