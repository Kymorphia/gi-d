module Pango.Renderer;

import GObject.ObjectG;
import Gid.gid;
import Pango.Color;
import Pango.Font;
import Pango.GlyphItem;
import Pango.GlyphString;
import Pango.Layout;
import Pango.LayoutLine;
import Pango.Matrix;
import Pango.Types;
import Pango.c.functions;
import Pango.c.types;

/**
 * `PangoRenderer` is a base class for objects that can render text
 * provided as `PangoGlyphString` or `PangoLayout`.
 * By subclassing `PangoRenderer` and overriding operations such as
 * @draw_glyphs and @draw_rectangle, renderers for particular font
 * backends and destinations can be created.
 */
class Renderer : ObjectG
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
    return pango_renderer_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Does initial setup before rendering operations on renderer.
   * [Pango.Renderer.deactivate] should be called when done drawing.
   * Calls such as [Pango.Renderer.drawLayout] automatically
   * activate the layout before drawing on it.
   * Calls to [Pango.Renderer.activate] and
   * [Pango.Renderer.deactivate] can be nested and the
   * renderer will only be initialized and deinitialized once.
   */
  void activate()
  {
    pango_renderer_activate(cast(PangoRenderer*)cPtr);
  }

  /**
   * Cleans up after rendering operations on renderer.
   * See docs for [Pango.Renderer.activate].
   */
  void deactivate()
  {
    pango_renderer_deactivate(cast(PangoRenderer*)cPtr);
  }

  /**
   * Draw a squiggly line that approximately covers the given rectangle
   * in the style of an underline used to indicate a spelling error.
   * The width of the underline is rounded to an integer number
   * of up/down segments and the resulting rectangle is centered
   * in the original rectangle.
   * This should be called while renderer is already active.
   * Use [Pango.Renderer.activate] to activate a renderer.
   * Params:
   *   x = X coordinate of underline, in Pango units in user coordinate system
   *   y = Y coordinate of underline, in Pango units in user coordinate system
   *   width = width of underline, in Pango units in user coordinate system
   *   height = height of underline, in Pango units in user coordinate system
   */
  void drawErrorUnderline(int x, int y, int width, int height)
  {
    pango_renderer_draw_error_underline(cast(PangoRenderer*)cPtr, x, y, width, height);
  }

  /**
   * Draws a single glyph with coordinates in device space.
   * Params:
   *   font = a `PangoFont`
   *   glyph = the glyph index of a single glyph
   *   x = X coordinate of left edge of baseline of glyph
   *   y = Y coordinate of left edge of baseline of glyph
   */
  void drawGlyph(Font font, Glyph glyph, double x, double y)
  {
    pango_renderer_draw_glyph(cast(PangoRenderer*)cPtr, font ? cast(PangoFont*)font.cPtr(false) : null, glyph, x, y);
  }

  /**
   * Draws the glyphs in glyph_item with the specified `PangoRenderer`,
   * embedding the text associated with the glyphs in the output if the
   * output format supports it.
   * This is useful for rendering text in PDF.
   * Note that this method does not handle attributes in glyph_item.
   * If you want colors, shapes and lines handled automatically according
   * to those attributes, you need to use [Pango.Renderer.drawLayoutLine]
   * or [Pango.Renderer.drawLayout].
   * Note that text is the start of the text for layout, which is then
   * indexed by `glyph_item->item->offset`.
   * If text is %NULL, this simply calls [Pango.Renderer.drawGlyphs].
   * The default implementation of this method simply falls back to
   * [Pango.Renderer.drawGlyphs].
   * Params:
   *   text = the UTF-8 text that glyph_item refers to
   *   glyphItem = a `PangoGlyphItem`
   *   x = X position of left edge of baseline, in user space coordinates
   *     in Pango units
   *   y = Y position of left edge of baseline, in user space coordinates
   *     in Pango units
   */
  void drawGlyphItem(string text, GlyphItem glyphItem, int x, int y)
  {
    const(char)* _text = text.toCString(false);
    pango_renderer_draw_glyph_item(cast(PangoRenderer*)cPtr, _text, glyphItem ? cast(PangoGlyphItem*)glyphItem.cPtr(false) : null, x, y);
  }

  /**
   * Draws the glyphs in glyphs with the specified `PangoRenderer`.
   * Params:
   *   font = a `PangoFont`
   *   glyphs = a `PangoGlyphString`
   *   x = X position of left edge of baseline, in user space coordinates
   *     in Pango units.
   *   y = Y position of left edge of baseline, in user space coordinates
   *     in Pango units.
   */
  void drawGlyphs(Font font, GlyphString glyphs, int x, int y)
  {
    pango_renderer_draw_glyphs(cast(PangoRenderer*)cPtr, font ? cast(PangoFont*)font.cPtr(false) : null, glyphs ? cast(PangoGlyphString*)glyphs.cPtr(false) : null, x, y);
  }

  /**
   * Draws layout with the specified `PangoRenderer`.
   * This is equivalent to drawing the lines of the layout, at their
   * respective positions relative to x, y.
   * Params:
   *   layout = a `PangoLayout`
   *   x = X position of left edge of baseline, in user space coordinates
   *     in Pango units.
   *   y = Y position of left edge of baseline, in user space coordinates
   *     in Pango units.
   */
  void drawLayout(Layout layout, int x, int y)
  {
    pango_renderer_draw_layout(cast(PangoRenderer*)cPtr, layout ? cast(PangoLayout*)layout.cPtr(false) : null, x, y);
  }

  /**
   * Draws line with the specified `PangoRenderer`.
   * This draws the glyph items that make up the line, as well as
   * shapes, backgrounds and lines that are specified by the attributes
   * of those items.
   * Params:
   *   line = a `PangoLayoutLine`
   *   x = X position of left edge of baseline, in user space coordinates
   *     in Pango units.
   *   y = Y position of left edge of baseline, in user space coordinates
   *     in Pango units.
   */
  void drawLayoutLine(LayoutLine line, int x, int y)
  {
    pango_renderer_draw_layout_line(cast(PangoRenderer*)cPtr, line ? cast(PangoLayoutLine*)line.cPtr(false) : null, x, y);
  }

  /**
   * Draws an axis-aligned rectangle in user space coordinates with the
   * specified `PangoRenderer`.
   * This should be called while renderer is already active.
   * Use [Pango.Renderer.activate] to activate a renderer.
   * Params:
   *   part = type of object this rectangle is part of
   *   x = X position at which to draw rectangle, in user space coordinates
   *     in Pango units
   *   y = Y position at which to draw rectangle, in user space coordinates
   *     in Pango units
   *   width = width of rectangle in Pango units
   *   height = height of rectangle in Pango units
   */
  void drawRectangle(RenderPart part, int x, int y, int width, int height)
  {
    pango_renderer_draw_rectangle(cast(PangoRenderer*)cPtr, part, x, y, width, height);
  }

  /**
   * Draws a trapezoid with the parallel sides aligned with the X axis
   * using the given `PangoRenderer`; coordinates are in device space.
   * Params:
   *   part = type of object this trapezoid is part of
   *   y1 = Y coordinate of top of trapezoid
   *   x11 = X coordinate of left end of top of trapezoid
   *   x21 = X coordinate of right end of top of trapezoid
   *   y2 = Y coordinate of bottom of trapezoid
   *   x12 = X coordinate of left end of bottom of trapezoid
   *   x22 = X coordinate of right end of bottom of trapezoid
   */
  void drawTrapezoid(RenderPart part, double y1, double x11, double x21, double y2, double x12, double x22)
  {
    pango_renderer_draw_trapezoid(cast(PangoRenderer*)cPtr, part, y1, x11, x21, y2, x12, x22);
  }

  /**
   * Gets the current alpha for the specified part.
   * Params:
   *   part = the part to get the alpha for
   * Returns: the alpha for the specified part,
   *   or 0 if it hasn't been set and should be
   *   inherited from the environment.
   */
  ushort getAlpha(RenderPart part)
  {
    ushort _retval;
    _retval = pango_renderer_get_alpha(cast(PangoRenderer*)cPtr, part);
    return _retval;
  }

  /**
   * Gets the current rendering color for the specified part.
   * Params:
   *   part = the part to get the color for
   * Returns: the color for the
   *   specified part, or %NULL if it hasn't been set and should be
   *   inherited from the environment.
   */
  Color getColor(RenderPart part)
  {
    PangoColor* _cretval;
    _cretval = pango_renderer_get_color(cast(PangoRenderer*)cPtr, part);
    auto _retval = _cretval ? new Color(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the layout currently being rendered using renderer.
   * Calling this function only makes sense from inside a subclass's
   * methods, like in its draw_shape vfunc, for example.
   * The returned layout should not be modified while still being
   * rendered.
   * Returns: the layout, or %NULL if
   *   no layout is being rendered using renderer at this time.
   */
  Layout getLayout()
  {
    PangoLayout* _cretval;
    _cretval = pango_renderer_get_layout(cast(PangoRenderer*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Layout(cast(PangoLayout*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the layout line currently being rendered using renderer.
   * Calling this function only makes sense from inside a subclass's
   * methods, like in its draw_shape vfunc, for example.
   * The returned layout line should not be modified while still being
   * rendered.
   * Returns: the layout line, or %NULL
   *   if no layout line is being rendered using renderer at this time.
   */
  LayoutLine getLayoutLine()
  {
    PangoLayoutLine* _cretval;
    _cretval = pango_renderer_get_layout_line(cast(PangoRenderer*)cPtr);
    auto _retval = _cretval ? new LayoutLine(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the transformation matrix that will be applied when
   * rendering.
   * See [Pango.Renderer.setMatrix].
   * Returns: the matrix, or %NULL if no matrix has
   *   been set $(LPAREN)which is the same as the identity matrix$(RPAREN). The returned
   *   matrix is owned by Pango and must not be modified or freed.
   */
  Matrix getMatrix()
  {
    const(PangoMatrix)* _cretval;
    _cretval = pango_renderer_get_matrix(cast(PangoRenderer*)cPtr);
    auto _retval = _cretval ? new Matrix(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Informs Pango that the way that the rendering is done
   * for part has changed.
   * This should be called if the rendering changes in a way that would
   * prevent multiple pieces being joined together into one drawing call.
   * For instance, if a subclass of `PangoRenderer` was to add a stipple
   * option for drawing underlines, it needs to call
   * ```
   * pango_renderer_part_changed $(LPAREN)render, PANGO_RENDER_PART_UNDERLINE$(RPAREN);
   * ```
   * When the stipple changes or underlines with different stipples
   * might be joined together. Pango automatically calls this for
   * changes to colors. $(LPAREN)See [Pango.Renderer.setColor]$(RPAREN)
   * Params:
   *   part = the part for which rendering has changed.
   */
  void partChanged(RenderPart part)
  {
    pango_renderer_part_changed(cast(PangoRenderer*)cPtr, part);
  }

  /**
   * Sets the alpha for part of the rendering.
   * Note that the alpha may only be used if a color is
   * specified for part as well.
   * Params:
   *   part = the part to set the alpha for
   *   alpha = an alpha value between 1 and 65536, or 0 to unset the alpha
   */
  void setAlpha(RenderPart part, ushort alpha)
  {
    pango_renderer_set_alpha(cast(PangoRenderer*)cPtr, part, alpha);
  }

  /**
   * Sets the color for part of the rendering.
   * Also see [Pango.Renderer.setAlpha].
   * Params:
   *   part = the part to change the color of
   *   color = the new color or %NULL to unset the current color
   */
  void setColor(RenderPart part, Color color)
  {
    pango_renderer_set_color(cast(PangoRenderer*)cPtr, part, color ? cast(PangoColor*)color.cPtr(false) : null);
  }

  /**
   * Sets the transformation matrix that will be applied when rendering.
   * Params:
   *   matrix = a `PangoMatrix`, or %NULL to unset any existing matrix
   *     $(LPAREN)No matrix set is the same as setting the identity matrix.$(RPAREN)
   */
  void setMatrix(Matrix matrix)
  {
    pango_renderer_set_matrix(cast(PangoRenderer*)cPtr, matrix ? cast(PangoMatrix*)matrix.cPtr(false) : null);
  }
}
