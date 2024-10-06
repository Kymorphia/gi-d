module Pango.RendererClass;

import Gid.gid;
import Pango.Types;
import Pango.c.functions;
import Pango.c.types;

/**
 * Class structure for `PangoRenderer`.
 * The following vfuncs take user space coordinates in Pango units
 * and have default implementations:
 * - draw_glyphs
 * - draw_rectangle
 * - draw_error_underline
 * - draw_shape
 * - draw_glyph_item
 * The default draw_shape implementation draws nothing.
 * The following vfuncs take device space coordinates as doubles
 * and must be implemented:
 * - draw_trapezoid
 * - draw_glyph
 */
class RendererClass
{
  PangoRendererClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Pango.RendererClass");

    cInstance = *cast(PangoRendererClass*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  alias DrawGlyphsFuncType = extern(C) void function(PangoRenderer* renderer, PangoFont* font, PangoGlyphString* glyphs, int x, int y);

  @property DrawGlyphsFuncType drawGlyphs()
  {
    return (cast(PangoRendererClass*)cPtr).drawGlyphs;
  }

  alias DrawRectangleFuncType = extern(C) void function(PangoRenderer* renderer, PangoRenderPart part, int x, int y, int width, int height);

  @property DrawRectangleFuncType drawRectangle()
  {
    return (cast(PangoRendererClass*)cPtr).drawRectangle;
  }

  alias DrawErrorUnderlineFuncType = extern(C) void function(PangoRenderer* renderer, int x, int y, int width, int height);

  @property DrawErrorUnderlineFuncType drawErrorUnderline()
  {
    return (cast(PangoRendererClass*)cPtr).drawErrorUnderline;
  }

  alias DrawShapeFuncType = extern(C) void function(PangoRenderer* renderer, PangoAttrShape* attr, int x, int y);

  @property DrawShapeFuncType drawShape()
  {
    return (cast(PangoRendererClass*)cPtr).drawShape;
  }

  alias DrawTrapezoidFuncType = extern(C) void function(PangoRenderer* renderer, PangoRenderPart part, double y1, double x11, double x21, double y2, double x12, double x22);

  @property DrawTrapezoidFuncType drawTrapezoid()
  {
    return (cast(PangoRendererClass*)cPtr).drawTrapezoid;
  }

  alias DrawGlyphFuncType = extern(C) void function(PangoRenderer* renderer, PangoFont* font, PangoGlyph glyph, double x, double y);

  @property DrawGlyphFuncType drawGlyph()
  {
    return (cast(PangoRendererClass*)cPtr).drawGlyph;
  }

  alias PartChangedFuncType = extern(C) void function(PangoRenderer* renderer, PangoRenderPart part);

  @property PartChangedFuncType partChanged()
  {
    return (cast(PangoRendererClass*)cPtr).partChanged;
  }

  alias BeginFuncType = extern(C) void function(PangoRenderer* renderer);

  @property BeginFuncType begin()
  {
    return (cast(PangoRendererClass*)cPtr).begin;
  }

  alias EndFuncType = extern(C) void function(PangoRenderer* renderer);

  @property EndFuncType end()
  {
    return (cast(PangoRendererClass*)cPtr).end;
  }

  alias PrepareRunFuncType = extern(C) void function(PangoRenderer* renderer, PangoLayoutRun* run);

  @property PrepareRunFuncType prepareRun()
  {
    return (cast(PangoRendererClass*)cPtr).prepareRun;
  }

  alias DrawGlyphItemFuncType = extern(C) void function(PangoRenderer* renderer, const(char)* text, PangoGlyphItem* glyphItem, int x, int y);

  @property DrawGlyphItemFuncType drawGlyphItem()
  {
    return (cast(PangoRendererClass*)cPtr).drawGlyphItem;
  }
}
