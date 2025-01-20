module Pango.GlyphString;

import GLib.Boxed;
import Gid.gid;
import Pango.Analysis;
import Pango.Font;
import Pango.Types;
import Pango.c.functions;
import Pango.c.types;

/**
 * A `PangoGlyphString` is used to store strings of glyphs with geometry
 * and visual attribute information.
 * The storage for the glyph information is owned by the structure
 * which simplifies memory management.
 */
class GlyphString : Boxed
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
    return pango_glyph_string_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  @property int numGlyphs()
  {
    return (cast(PangoGlyphString*)cPtr).numGlyphs;
  }

  @property void numGlyphs(int propval)
  {
    (cast(PangoGlyphString*)cPtr).numGlyphs = propval;
  }

  /**
   * Create a new `PangoGlyphString`.
   * Returns: the newly allocated `PangoGlyphString`, which
   *   should be freed with [Pango.GlyphString.free].
   */
  this()
  {
    PangoGlyphString* _cretval;
    _cretval = pango_glyph_string_new();
    this(_cretval, true);
  }

  /**
   * Copy a glyph string and associated storage.
   * Returns: the newly allocated `PangoGlyphString`
   */
  GlyphString copy()
  {
    PangoGlyphString* _cretval;
    _cretval = pango_glyph_string_copy(cast(PangoGlyphString*)cPtr);
    auto _retval = _cretval ? new GlyphString(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Compute the logical and ink extents of a glyph string.
   * See the documentation for [Pango.Font.getGlyphExtents] for details
   * about the interpretation of the rectangles.
   * Examples of logical $(LPAREN)red$(RPAREN) and ink $(LPAREN)green$(RPAREN) rects:
   * ![](rects1.png) ![](rects2.png)
   * Params:
   *   font = a `PangoFont`
   *   inkRect = rectangle used to store the extents of the glyph string as drawn
   *   logicalRect = rectangle used to store the logical extents of the glyph string
   */
  void extents(Font font, out Rectangle inkRect, out Rectangle logicalRect)
  {
    pango_glyph_string_extents(cast(PangoGlyphString*)cPtr, font ? cast(PangoFont*)font.cPtr(false) : null, &inkRect, &logicalRect);
  }

  /**
   * Computes the extents of a sub-portion of a glyph string.
   * The extents are relative to the start of the glyph string range
   * $(LPAREN)the origin of their coordinate system is at the start of the range,
   * not at the start of the entire glyph string$(RPAREN).
   * Params:
   *   start = start index
   *   end = end index $(LPAREN)the range is the set of bytes with
   *     indices such that start <\= index < end$(RPAREN)
   *   font = a `PangoFont`
   *   inkRect = rectangle used to
   *     store the extents of the glyph string range as drawn
   *   logicalRect = rectangle used to
   *     store the logical extents of the glyph string range
   */
  void extentsRange(int start, int end, Font font, out Rectangle inkRect, out Rectangle logicalRect)
  {
    pango_glyph_string_extents_range(cast(PangoGlyphString*)cPtr, start, end, font ? cast(PangoFont*)font.cPtr(false) : null, &inkRect, &logicalRect);
  }

  /**
   * Computes the logical width of the glyph string.
   * This can also be computed using [Pango.GlyphString.extents].
   * However, since this only computes the width, it's much faster. This
   * is in fact only a convenience function that computes the sum of
   * geometry.width for each glyph in the glyphs.
   * Returns: the logical width of the glyph string.
   */
  int getWidth()
  {
    int _retval;
    _retval = pango_glyph_string_get_width(cast(PangoGlyphString*)cPtr);
    return _retval;
  }

  /**
   * Converts from character position to x position.
   * The X position is measured from the left edge of the run.
   * Character positions are obtained using font metrics for ligatures
   * where available, and computed by dividing up each cluster
   * into equal portions, otherwise.
   * <picture>
   * <source srcset\="glyphstring-positions-dark.png" media\="$(LPAREN)prefers-color-scheme: dark$(RPAREN)">
   * <img alt\="Glyph positions" src\="glyphstring-positions-light.png">
   * </picture>
   * Params:
   *   text = the text for the run
   *   length = the number of bytes $(LPAREN)not characters$(RPAREN) in text.
   *   analysis = the analysis information return from funcitemize
   *   index = the byte index within text
   *   trailing = whether we should compute the result for the beginning $(LPAREN)%FALSE$(RPAREN)
   *     or end $(LPAREN)%TRUE$(RPAREN) of the character.
   *   xPos = location to store result
   */
  void indexToX(string text, int length, Analysis analysis, int index, bool trailing, out int xPos)
  {
    const(char)* _text = text.toCString(false);
    pango_glyph_string_index_to_x(cast(PangoGlyphString*)cPtr, _text, length, analysis ? cast(PangoAnalysis*)analysis.cPtr : null, index, trailing, cast(int*)&xPos);
  }

  /**
   * Converts from character position to x position.
   * This variant of [Pango.GlyphString.indexToX] additionally
   * accepts a `PangoLogAttr` array. The grapheme boundary information
   * in it can be used to disambiguate positioning inside some complex
   * clusters.
   * Params:
   *   text = the text for the run
   *   length = the number of bytes $(LPAREN)not characters$(RPAREN) in text.
   *   analysis = the analysis information return from funcitemize
   *   attrs = `PangoLogAttr` array for text
   *   index = the byte index within text
   *   trailing = whether we should compute the result for the beginning $(LPAREN)%FALSE$(RPAREN)
   *     or end $(LPAREN)%TRUE$(RPAREN) of the character.
   *   xPos = location to store result
   */
  void indexToXFull(string text, int length, Analysis analysis, LogAttr attrs, int index, bool trailing, out int xPos)
  {
    const(char)* _text = text.toCString(false);
    pango_glyph_string_index_to_x_full(cast(PangoGlyphString*)cPtr, _text, length, analysis ? cast(PangoAnalysis*)analysis.cPtr : null, &attrs, index, trailing, cast(int*)&xPos);
  }

  /**
   * Resize a glyph string to the given length.
   * Params:
   *   newLen = the new length of the string
   */
  void setSize(int newLen)
  {
    pango_glyph_string_set_size(cast(PangoGlyphString*)cPtr, newLen);
  }

  /**
   * Convert from x offset to character position.
   * Character positions are computed by dividing up each cluster into
   * equal portions. In scripts where positioning within a cluster is
   * not allowed $(LPAREN)such as Thai$(RPAREN), the returned value may not be a valid
   * cursor position; the caller must combine the result with the logical
   * attributes for the text to compute the valid cursor position.
   * Params:
   *   text = the text for the run
   *   length = the number of bytes $(LPAREN)not characters$(RPAREN) in text.
   *   analysis = the analysis information return from funcitemize
   *   xPos = the x offset $(LPAREN)in Pango units$(RPAREN)
   *   index = location to store calculated byte index within text
   *   trailing = location to store a boolean indicating whether the
   *     user clicked on the leading or trailing edge of the character
   */
  void xToIndex(string text, int length, Analysis analysis, int xPos, out int index, out int trailing)
  {
    const(char)* _text = text.toCString(false);
    pango_glyph_string_x_to_index(cast(PangoGlyphString*)cPtr, _text, length, analysis ? cast(PangoAnalysis*)analysis.cPtr : null, xPos, cast(int*)&index, cast(int*)&trailing);
  }
}
