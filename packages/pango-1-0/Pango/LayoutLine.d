module Pango.LayoutLine;

import GLib.Boxed;
import GObject.ObjectG;
import Gid.gid;
import Pango.Layout;
import Pango.Types;
import Pango.c.functions;
import Pango.c.types;

/**
 * A `PangoLayoutLine` represents one of the lines resulting from laying
 * out a paragraph via `PangoLayout`.
 * `PangoLayoutLine` structures are obtained by calling
 * [Pango.Layout.getLine] and are only valid until the text,
 * attributes, or settings of the parent `PangoLayout` are modified.
 */
class LayoutLine : Boxed
{

  this()
  {
    super(safeMalloc(PangoLayoutLine.sizeof), true);
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
    return pango_layout_line_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  @property Layout layout()
  {
    return ObjectG.getDObject!Layout((cast(PangoLayoutLine*)cPtr).layout, false);
  }

  @property int startIndex()
  {
    return (cast(PangoLayoutLine*)cPtr).startIndex;
  }

  @property void startIndex(int propval)
  {
    (cast(PangoLayoutLine*)cPtr).startIndex = propval;
  }

  @property int length()
  {
    return (cast(PangoLayoutLine*)cPtr).length;
  }

  @property void length(int propval)
  {
    (cast(PangoLayoutLine*)cPtr).length = propval;
  }

  @property uint isParagraphStart()
  {
    return (cast(PangoLayoutLine*)cPtr).isParagraphStart;
  }

  @property void isParagraphStart(uint propval)
  {
    (cast(PangoLayoutLine*)cPtr).isParagraphStart = propval;
  }

  @property uint resolvedDir()
  {
    return (cast(PangoLayoutLine*)cPtr).resolvedDir;
  }

  @property void resolvedDir(uint propval)
  {
    (cast(PangoLayoutLine*)cPtr).resolvedDir = propval;
  }

  /**
   * Computes the logical and ink extents of a layout line.
   * See [Pango.Font.getGlyphExtents] for details
   * about the interpretation of the rectangles.
   * Params:
   *   inkRect = rectangle used to store the extents of
   *     the glyph string as drawn
   *   logicalRect = rectangle used to store the logical
   *     extents of the glyph string
   */
  void getExtents(out Rectangle inkRect, out Rectangle logicalRect)
  {
    pango_layout_line_get_extents(cast(PangoLayoutLine*)cPtr, &inkRect, &logicalRect);
  }

  /**
   * Computes the height of the line, as the maximum of the heights
   * of fonts used in this line.
   * Note that the actual baseline-to-baseline distance between lines
   * of text is influenced by other factors, such as
   * [Pango.Layout.setSpacing] and
   * [Pango.Layout.setLineSpacing].
   * Params:
   *   height = return location for the line height
   */
  void getHeight(out int height)
  {
    pango_layout_line_get_height(cast(PangoLayoutLine*)cPtr, cast(int*)&height);
  }

  /**
   * Returns the length of the line, in bytes.
   * Returns: the length of the line
   */
  int getLength()
  {
    int _retval;
    _retval = pango_layout_line_get_length(cast(PangoLayoutLine*)cPtr);
    return _retval;
  }

  /**
   * Computes the logical and ink extents of layout_line in device units.
   * This function just calls [Pango.LayoutLine.getExtents] followed by
   * two funcextents_to_pixels calls, rounding ink_rect and logical_rect
   * such that the rounded rectangles fully contain the unrounded one $(LPAREN)that is,
   * passes them as first argument to funcextents_to_pixels$(RPAREN).
   * Params:
   *   inkRect = rectangle used to store the extents of
   *     the glyph string as drawn
   *   logicalRect = rectangle used to store the logical
   *     extents of the glyph string
   */
  void getPixelExtents(out Rectangle inkRect, out Rectangle logicalRect)
  {
    pango_layout_line_get_pixel_extents(cast(PangoLayoutLine*)cPtr, &inkRect, &logicalRect);
  }

  /**
   * Returns the resolved direction of the line.
   * Returns: the resolved direction of the line
   */
  Direction getResolvedDirection()
  {
    PangoDirection _cretval;
    _cretval = pango_layout_line_get_resolved_direction(cast(PangoLayoutLine*)cPtr);
    Direction _retval = cast(Direction)_cretval;
    return _retval;
  }

  /**
   * Returns the start index of the line, as byte index
   * into the text of the layout.
   * Returns: the start index of the line
   */
  int getStartIndex()
  {
    int _retval;
    _retval = pango_layout_line_get_start_index(cast(PangoLayoutLine*)cPtr);
    return _retval;
  }

  /**
   * Gets a list of visual ranges corresponding to a given logical range.
   * This list is not necessarily minimal - there may be consecutive
   * ranges which are adjacent. The ranges will be sorted from left to
   * right. The ranges are with respect to the left edge of the entire
   * layout, not with respect to the line.
   * Params:
   *   startIndex = Start byte index of the logical range. If this value
   *     is less than the start index for the line, then the first range
   *     will extend all the way to the leading edge of the layout. Otherwise,
   *     it will start at the leading edge of the first character.
   *   endIndex = Ending byte index of the logical range. If this value is
   *     greater than the end index for the line, then the last range will
   *     extend all the way to the trailing edge of the layout. Otherwise,
   *     it will end at the trailing edge of the last character.
   *   ranges = location to
   *     store a pointer to an array of ranges. The array will be of length
   *     `2*n_ranges`, with each range starting at `$(LPAREN)*ranges$(RPAREN)[2*n]` and of
   *     width `$(LPAREN)*ranges$(RPAREN)[2*n + 1] - (*ranges)[2*n]`. This array must be freed
   *     with [GLib.Global.gfree]. The coordinates are relative to the layout and are in
   *     Pango units.
   */
  void getXRanges(int startIndex, int endIndex, out int[] ranges)
  {
    int _nRanges;
    int* _ranges;
    pango_layout_line_get_x_ranges(cast(PangoLayoutLine*)cPtr, startIndex, endIndex, &_ranges, &_nRanges);
    ranges = _ranges[0 .. _nRanges];
    safeFree(cast(void*)_ranges);
  }

  /**
   * Converts an index within a line to a X position.
   * Params:
   *   index = byte offset of a grapheme within the layout
   *   trailing = an integer indicating the edge of the grapheme to retrieve
   *     the position of. If > 0, the trailing edge of the grapheme,
   *     if 0, the leading of the grapheme
   *   xPos = location to store the x_offset $(LPAREN)in Pango units$(RPAREN)
   */
  void indexToX(int index, bool trailing, out int xPos)
  {
    pango_layout_line_index_to_x(cast(PangoLayoutLine*)cPtr, index, trailing, cast(int*)&xPos);
  }

  /**
   * Converts from x offset to the byte index of the corresponding character
   * within the text of the layout.
   * If x_pos is outside the line, index_ and trailing will point to the very
   * first or very last position in the line. This determination is based on the
   * resolved direction of the paragraph; for example, if the resolved direction
   * is right-to-left, then an X position to the right of the line $(LPAREN)after it$(RPAREN)
   * results in 0 being stored in index_ and trailing. An X position to the
   * left of the line results in index_ pointing to the $(LPAREN)logical$(RPAREN) last grapheme
   * in the line and trailing being set to the number of characters in that
   * grapheme. The reverse is true for a left-to-right line.
   * Params:
   *   xPos = the X offset $(LPAREN)in Pango units$(RPAREN) from the left edge of the line.
   *   index = location to store calculated byte index for the grapheme
   *     in which the user clicked
   *   trailing = location to store an integer indicating where in the
   *     grapheme the user clicked. It will either be zero, or the number of
   *     characters in the grapheme. 0 represents the leading edge of the grapheme.
   * Returns: %FALSE if x_pos was outside the line, %TRUE if inside
   */
  bool xToIndex(int xPos, out int index, out int trailing)
  {
    bool _retval;
    _retval = pango_layout_line_x_to_index(cast(PangoLayoutLine*)cPtr, xPos, cast(int*)&index, cast(int*)&trailing);
    return _retval;
  }
}
