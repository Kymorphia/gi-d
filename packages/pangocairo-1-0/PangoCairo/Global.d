module PangoCairo.Global;

import GObject.ObjectG;
import Gid.gid;
import Pango.AttrShape;
import Pango.Context;
import Pango.Font;
import Pango.GlyphItem;
import Pango.GlyphString;
import Pango.Layout;
import Pango.LayoutLine;
import PangoCairo.Types;
import PangoCairo.c.functions;
import PangoCairo.c.types;
import cairo.Context : DcairoContext = Context;
import cairo.FontOptions;


/**
 * Retrieves any font rendering options previously set with
 * funcPangoCairo.context_set_font_options.
 * This function does not report options that are derived from
 * the target surface by funcupdate_context.
 * Params:
 *   context = a `PangoContext`, from a pangocairo font map
 * Returns: the font options previously set on the
 *   context, or %NULL if no options have been set. This value is
 *   owned by the context and must not be modified or freed.
 */
FontOptions contextGetFontOptions(Context context)
{
  const(cairo_font_options_t)* _cretval;
  _cretval = pango_cairo_context_get_font_options(context ? cast(PangoContext*)context.cPtr(false) : null);
  auto _retval = _cretval ? new FontOptions(cast(void*)_cretval, false) : null;
  return _retval;
}

/**
 * Gets the resolution for the context.
 * See funcPangoCairo.context_set_resolution
 * Params:
 *   context = a `PangoContext`, from a pangocairo font map
 * Returns: the resolution in "dots per inch". A negative value will
 *   be returned if no resolution has previously been set.
 */
double contextGetResolution(Context context)
{
  double _retval;
  _retval = pango_cairo_context_get_resolution(context ? cast(PangoContext*)context.cPtr(false) : null);
  return _retval;
}

/**
 * Sets the font options used when rendering text with this context.
 * These options override any options that funcupdate_context
 * derives from the target surface.
 * Params:
 *   context = a `PangoContext`, from a pangocairo font map
 *   options = a `cairo_font_options_t`, or %NULL to unset
 *     any previously set options. A copy is made.
 */
void contextSetFontOptions(Context context, FontOptions options)
{
  pango_cairo_context_set_font_options(context ? cast(PangoContext*)context.cPtr(false) : null, options ? cast(cairo_font_options_t*)options.cPtr(false) : null);
}

/**
 * Sets the resolution for the context.
 * This is a scale factor between points specified in a `PangoFontDescription`
 * and Cairo units. The default value is 96, meaning that a 10 point font will
 * be 13 units high. $(LPAREN)10 * 96. / 72. \= 13.3$(RPAREN).
 * Params:
 *   context = a `PangoContext`, from a pangocairo font map
 *   dpi = the resolution in "dots per inch". $(LPAREN)Physical inches aren't actually
 *     involved; the terminology is conventional.$(RPAREN) A 0 or negative value
 *     means to use the resolution from the font map.
 */
void contextSetResolution(Context context, double dpi)
{
  pango_cairo_context_set_resolution(context ? cast(PangoContext*)context.cPtr(false) : null, dpi);
}

/**
 * Sets callback function for context to use for rendering attributes
 * of type %PANGO_ATTR_SHAPE.
 * See `PangoCairoShapeRendererFunc` for details.
 * Params:
 *   context = a `PangoContext`, from a pangocairo font map
 *   func = Callback function for rendering attributes of
 *     type %PANGO_ATTR_SHAPE, or %NULL to disable shape rendering.
 */
void contextSetShapeRenderer(Context context, ShapeRendererFunc func)
{
  extern(C) void _funcCallback(cairo_t* cr, PangoAttrShape* attr, bool doPath, void* data)
  {
    auto _dlg = cast(ShapeRendererFunc*)data;

    (*_dlg)(cr ? new DcairoContext(cast(void*)cr, false) : null, attr ? new AttrShape(cast(void*)attr, false) : null, doPath);
  }

  auto _func = freezeDelegate(cast(void*)&func);
  pango_cairo_context_set_shape_renderer(context ? cast(PangoContext*)context.cPtr(false) : null, &_funcCallback, _func, &thawDelegate);
}

/**
 * Creates a context object set up to match the current transformation
 * and target surface of the Cairo context.
 * This context can then be
 * used to create a layout using [Pango.Layout.new_].
 * This function is a convenience function that creates a context using
 * the default font map, then updates it to cr. If you just need to
 * create a layout for use with cr and do not need to access `PangoContext`
 * directly, you can use funccreate_layout instead.
 * Params:
 *   cr = a Cairo context
 * Returns: the newly created `PangoContext`
 */
Context createContext(DcairoContext cr)
{
  PangoContext* _cretval;
  _cretval = pango_cairo_create_context(cr ? cast(cairo_t*)cr.cPtr(false) : null);
  auto _retval = _cretval ? ObjectG.getDObject!Context(cast(PangoContext*)_cretval, true) : null;
  return _retval;
}

/**
 * Creates a layout object set up to match the current transformation
 * and target surface of the Cairo context.
 * This layout can then be used for text measurement with functions
 * like [Pango.Layout.getSize] or drawing with functions like
 * funcshow_layout. If you change the transformation or target
 * surface for cr, you need to call funcupdate_layout.
 * This function is the most convenient way to use Cairo with Pango,
 * however it is slightly inefficient since it creates a separate
 * `PangoContext` object for each layout. This might matter in an
 * application that was laying out large amounts of text.
 * Params:
 *   cr = a Cairo context
 * Returns: the newly created `PangoLayout`
 */
Layout createLayout(DcairoContext cr)
{
  PangoLayout* _cretval;
  _cretval = pango_cairo_create_layout(cr ? cast(cairo_t*)cr.cPtr(false) : null);
  auto _retval = _cretval ? ObjectG.getDObject!Layout(cast(PangoLayout*)_cretval, true) : null;
  return _retval;
}

/**
 * Add a squiggly line to the current path in the specified cairo context that
 * approximately covers the given rectangle in the style of an underline used
 * to indicate a spelling error.
 * The width of the underline is rounded to an integer number of up/down
 * segments and the resulting rectangle is centered in the original rectangle.
 * Params:
 *   cr = a Cairo context
 *   x = The X coordinate of one corner of the rectangle
 *   y = The Y coordinate of one corner of the rectangle
 *   width = Non-negative width of the rectangle
 *   height = Non-negative height of the rectangle
 */
void errorUnderlinePath(DcairoContext cr, double x, double y, double width, double height)
{
  pango_cairo_error_underline_path(cr ? cast(cairo_t*)cr.cPtr(false) : null, x, y, width, height);
}

/**
 * Adds the glyphs in glyphs to the current path in the specified
 * cairo context.
 * The origin of the glyphs $(LPAREN)the left edge of the baseline$(RPAREN)
 * will be at the current point of the cairo context.
 * Params:
 *   cr = a Cairo context
 *   font = a `PangoFont` from a `PangoCairoFontMap`
 *   glyphs = a `PangoGlyphString`
 */
void glyphStringPath(DcairoContext cr, Font font, GlyphString glyphs)
{
  pango_cairo_glyph_string_path(cr ? cast(cairo_t*)cr.cPtr(false) : null, font ? cast(PangoFont*)font.cPtr(false) : null, glyphs ? cast(PangoGlyphString*)glyphs.cPtr(false) : null);
}

/**
 * Adds the text in `PangoLayoutLine` to the current path in the
 * specified cairo context.
 * The origin of the glyphs $(LPAREN)the left edge of the line$(RPAREN) will be
 * at the current point of the cairo context.
 * Params:
 *   cr = a Cairo context
 *   line = a `PangoLayoutLine`
 */
void layoutLinePath(DcairoContext cr, LayoutLine line)
{
  pango_cairo_layout_line_path(cr ? cast(cairo_t*)cr.cPtr(false) : null, line ? cast(PangoLayoutLine*)line.cPtr(false) : null);
}

/**
 * Adds the text in a `PangoLayout` to the current path in the
 * specified cairo context.
 * The top-left corner of the `PangoLayout` will be at the
 * current point of the cairo context.
 * Params:
 *   cr = a Cairo context
 *   layout = a Pango layout
 */
void layoutPath(DcairoContext cr, Layout layout)
{
  pango_cairo_layout_path(cr ? cast(cairo_t*)cr.cPtr(false) : null, layout ? cast(PangoLayout*)layout.cPtr(false) : null);
}

/**
 * Draw a squiggly line in the specified cairo context that approximately
 * covers the given rectangle in the style of an underline used to indicate a
 * spelling error.
 * The width of the underline is rounded to an integer
 * number of up/down segments and the resulting rectangle is centered in the
 * original rectangle.
 * Params:
 *   cr = a Cairo context
 *   x = The X coordinate of one corner of the rectangle
 *   y = The Y coordinate of one corner of the rectangle
 *   width = Non-negative width of the rectangle
 *   height = Non-negative height of the rectangle
 */
void showErrorUnderline(DcairoContext cr, double x, double y, double width, double height)
{
  pango_cairo_show_error_underline(cr ? cast(cairo_t*)cr.cPtr(false) : null, x, y, width, height);
}

/**
 * Draws the glyphs in glyph_item in the specified cairo context,
 * embedding the text associated with the glyphs in the output if the
 * output format supports it $(LPAREN)PDF for example$(RPAREN), otherwise it acts
 * similar to funcshow_glyph_string.
 * The origin of the glyphs $(LPAREN)the left edge of the baseline$(RPAREN) will
 * be drawn at the current point of the cairo context.
 * Note that text is the start of the text for layout, which is then
 * indexed by `glyph_item->item->offset`.
 * Params:
 *   cr = a Cairo context
 *   text = the UTF-8 text that glyph_item refers to
 *   glyphItem = a `PangoGlyphItem`
 */
void showGlyphItem(DcairoContext cr, string text, GlyphItem glyphItem)
{
  const(char)* _text = text.toCString(false);
  pango_cairo_show_glyph_item(cr ? cast(cairo_t*)cr.cPtr(false) : null, _text, glyphItem ? cast(PangoGlyphItem*)glyphItem.cPtr(false) : null);
}

/**
 * Draws the glyphs in glyphs in the specified cairo context.
 * The origin of the glyphs $(LPAREN)the left edge of the baseline$(RPAREN) will
 * be drawn at the current point of the cairo context.
 * Params:
 *   cr = a Cairo context
 *   font = a `PangoFont` from a `PangoCairoFontMap`
 *   glyphs = a `PangoGlyphString`
 */
void showGlyphString(DcairoContext cr, Font font, GlyphString glyphs)
{
  pango_cairo_show_glyph_string(cr ? cast(cairo_t*)cr.cPtr(false) : null, font ? cast(PangoFont*)font.cPtr(false) : null, glyphs ? cast(PangoGlyphString*)glyphs.cPtr(false) : null);
}

/**
 * Draws a `PangoLayout` in the specified cairo context.
 * The top-left corner of the `PangoLayout` will be drawn
 * at the current point of the cairo context.
 * Params:
 *   cr = a Cairo context
 *   layout = a Pango layout
 */
void showLayout(DcairoContext cr, Layout layout)
{
  pango_cairo_show_layout(cr ? cast(cairo_t*)cr.cPtr(false) : null, layout ? cast(PangoLayout*)layout.cPtr(false) : null);
}

/**
 * Draws a `PangoLayoutLine` in the specified cairo context.
 * The origin of the glyphs $(LPAREN)the left edge of the line$(RPAREN) will
 * be drawn at the current point of the cairo context.
 * Params:
 *   cr = a Cairo context
 *   line = a `PangoLayoutLine`
 */
void showLayoutLine(DcairoContext cr, LayoutLine line)
{
  pango_cairo_show_layout_line(cr ? cast(cairo_t*)cr.cPtr(false) : null, line ? cast(PangoLayoutLine*)line.cPtr(false) : null);
}

/**
 * Updates a `PangoContext` previously created for use with Cairo to
 * match the current transformation and target surface of a Cairo
 * context.
 * If any layouts have been created for the context, it's necessary
 * to call [Pango.Layout.contextChanged] on those layouts.
 * Params:
 *   cr = a Cairo context
 *   context = a `PangoContext`, from a pangocairo font map
 */
void updateContext(DcairoContext cr, Context context)
{
  pango_cairo_update_context(cr ? cast(cairo_t*)cr.cPtr(false) : null, context ? cast(PangoContext*)context.cPtr(false) : null);
}

/**
 * Updates the private `PangoContext` of a `PangoLayout` created with
 * funccreate_layout to match the current transformation and target
 * surface of a Cairo context.
 * Params:
 *   cr = a Cairo context
 *   layout = a `PangoLayout`, from funccreate_layout
 */
void updateLayout(DcairoContext cr, Layout layout)
{
  pango_cairo_update_layout(cr ? cast(cairo_t*)cr.cPtr(false) : null, layout ? cast(PangoLayout*)layout.cPtr(false) : null);
}
