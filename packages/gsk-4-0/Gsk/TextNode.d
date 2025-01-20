module Gsk.TextNode;

import GObject.ObjectG;
import Gdk.RGBA;
import Gid.gid;
import Graphene.Point;
import Gsk.RenderNode;
import Gsk.Types;
import Gsk.c.functions;
import Gsk.c.types;
import Pango.Font;
import Pango.GlyphInfo;
import Pango.GlyphString;

/**
 * A render node drawing a set of glyphs.
 */
class TextNode : RenderNode
{

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gsk.TextNode");

    super(cast(GskRenderNode*)ptr, ownedRef);
  }

  /**
   * Creates a render node that renders the given glyphs.
   * Note that color may not be used if the font contains
   * color glyphs.
   * Params:
   *   font = the `PangoFont` containing the glyphs
   *   glyphs = the `PangoGlyphString` to render
   *   color = the foreground color to render with
   *   offset = offset of the baseline
   * Returns: a new `GskRenderNode`
   */
  this(Font font, GlyphString glyphs, RGBA color, Point offset)
  {
    GskRenderNode* _cretval;
    _cretval = gsk_text_node_new(font ? cast(PangoFont*)font.cPtr(false) : null, glyphs ? cast(PangoGlyphString*)glyphs.cPtr(false) : null, color ? cast(GdkRGBA*)color.cPtr(false) : null, offset ? cast(graphene_point_t*)offset.cPtr(false) : null);
    this(_cretval, true);
  }

  /**
   * Retrieves the color used by the text node.
   * Returns: the text color
   */
  RGBA getColor()
  {
    const(GdkRGBA)* _cretval;
    _cretval = gsk_text_node_get_color(cast(GskRenderNode*)cPtr);
    auto _retval = _cretval ? new RGBA(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns the font used by the text node.
   * Returns: the font
   */
  Font getFont()
  {
    PangoFont* _cretval;
    _cretval = gsk_text_node_get_font(cast(GskRenderNode*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Font(cast(PangoFont*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Retrieves the glyph information in the node.
   * Returns: the glyph information
   */
  GlyphInfo[] getGlyphs()
  {
    const(PangoGlyphInfo)* _cretval;
    uint _cretlength;
    _cretval = gsk_text_node_get_glyphs(cast(GskRenderNode*)cPtr, &_cretlength);
    GlyphInfo[] _retval;

    if (_cretval)
    {
      _retval = new GlyphInfo[_cretlength];
      foreach (i; 0 .. _cretlength)
        _retval[i] = new GlyphInfo(cast(void*)&_cretval[i], false);
    }
    return _retval;
  }

  /**
   * Retrieves the number of glyphs in the text node.
   * Returns: the number of glyphs
   */
  uint getNumGlyphs()
  {
    uint _retval;
    _retval = gsk_text_node_get_num_glyphs(cast(GskRenderNode*)cPtr);
    return _retval;
  }

  /**
   * Retrieves the offset applied to the text.
   * Returns: a point with the horizontal and vertical offsets
   */
  Point getOffset()
  {
    const(graphene_point_t)* _cretval;
    _cretval = gsk_text_node_get_offset(cast(GskRenderNode*)cPtr);
    auto _retval = _cretval ? new Point(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Checks whether the text node has color glyphs.
   * Returns: %TRUE if the text node has color glyphs
   */
  bool hasColorGlyphs()
  {
    bool _retval;
    _retval = gsk_text_node_has_color_glyphs(cast(GskRenderNode*)cPtr);
    return _retval;
  }
}
