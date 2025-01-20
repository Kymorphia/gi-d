module Pango.LayoutIter;

import GLib.Boxed;
import GObject.ObjectG;
import Gid.gid;
import Pango.Layout;
import Pango.LayoutLine;
import Pango.Types;
import Pango.c.functions;
import Pango.c.types;

/**
 * A `PangoLayoutIter` can be used to iterate over the visual
 * extents of a `PangoLayout`.
 * To obtain a `PangoLayoutIter`, use [Pango.Layout.getIter].
 * The `PangoLayoutIter` structure is opaque, and has no user-visible fields.
 */
class LayoutIter : Boxed
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
    return pango_layout_iter_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Determines whether iter is on the last line of the layout.
   * Returns: %TRUE if iter is on the last line
   */
  bool atLastLine()
  {
    bool _retval;
    _retval = pango_layout_iter_at_last_line(cast(PangoLayoutIter*)cPtr);
    return _retval;
  }

  /**
   * Copies a `PangoLayoutIter`.
   * Returns: the newly allocated `PangoLayoutIter`
   */
  LayoutIter copy()
  {
    PangoLayoutIter* _cretval;
    _cretval = pango_layout_iter_copy(cast(PangoLayoutIter*)cPtr);
    auto _retval = _cretval ? new LayoutIter(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Gets the Y position of the current line's baseline, in layout
   * coordinates.
   * Layout coordinates have the origin at the top left of the entire layout.
   * Returns: baseline of current line
   */
  int getBaseline()
  {
    int _retval;
    _retval = pango_layout_iter_get_baseline(cast(PangoLayoutIter*)cPtr);
    return _retval;
  }

  /**
   * Gets the extents of the current character, in layout coordinates.
   * Layout coordinates have the origin at the top left of the entire layout.
   * Only logical extents can sensibly be obtained for characters;
   * ink extents make sense only down to the level of clusters.
   * Params:
   *   logicalRect = rectangle to fill with
   *     logical extents
   */
  void getCharExtents(out Rectangle logicalRect)
  {
    pango_layout_iter_get_char_extents(cast(PangoLayoutIter*)cPtr, &logicalRect);
  }

  /**
   * Gets the extents of the current cluster, in layout coordinates.
   * Layout coordinates have the origin at the top left of the entire layout.
   * Params:
   *   inkRect = rectangle to fill with ink extents
   *   logicalRect = rectangle to fill with logical extents
   */
  void getClusterExtents(out Rectangle inkRect, out Rectangle logicalRect)
  {
    pango_layout_iter_get_cluster_extents(cast(PangoLayoutIter*)cPtr, &inkRect, &logicalRect);
  }

  /**
   * Gets the current byte index.
   * Note that iterating forward by char moves in visual order,
   * not logical order, so indexes may not be sequential. Also,
   * the index may be equal to the length of the text in the
   * layout, if on the %NULL run $(LPAREN)see [Pango.LayoutIter.getRun]$(RPAREN).
   * Returns: current byte index
   */
  int getIndex()
  {
    int _retval;
    _retval = pango_layout_iter_get_index(cast(PangoLayoutIter*)cPtr);
    return _retval;
  }

  /**
   * Gets the layout associated with a `PangoLayoutIter`.
   * Returns: the layout associated with iter
   */
  Layout getLayout()
  {
    PangoLayout* _cretval;
    _cretval = pango_layout_iter_get_layout(cast(PangoLayoutIter*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Layout(cast(PangoLayout*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Obtains the extents of the `PangoLayout` being iterated over.
   * Params:
   *   inkRect = rectangle to fill with ink extents
   *   logicalRect = rectangle to fill with logical extents
   */
  void getLayoutExtents(out Rectangle inkRect, out Rectangle logicalRect)
  {
    pango_layout_iter_get_layout_extents(cast(PangoLayoutIter*)cPtr, &inkRect, &logicalRect);
  }

  /**
   * Gets the current line.
   * Use the faster [Pango.LayoutIter.getLineReadonly] if
   * you do not plan to modify the contents of the line $(LPAREN)glyphs,
   * glyph widths, etc.$(RPAREN).
   * Returns: the current line
   */
  LayoutLine getLine()
  {
    PangoLayoutLine* _cretval;
    _cretval = pango_layout_iter_get_line(cast(PangoLayoutIter*)cPtr);
    auto _retval = _cretval ? new LayoutLine(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Obtains the extents of the current line.
   * Extents are in layout coordinates $(LPAREN)origin is the top-left corner
   * of the entire `PangoLayout`$(RPAREN). Thus the extents returned by this
   * function will be the same width/height but not at the same x/y
   * as the extents returned from [Pango.LayoutLine.getExtents].
   * Params:
   *   inkRect = rectangle to fill with ink extents
   *   logicalRect = rectangle to fill with logical extents
   */
  void getLineExtents(out Rectangle inkRect, out Rectangle logicalRect)
  {
    pango_layout_iter_get_line_extents(cast(PangoLayoutIter*)cPtr, &inkRect, &logicalRect);
  }

  /**
   * Gets the current line for read-only access.
   * This is a faster alternative to [Pango.LayoutIter.getLine],
   * but the user is not expected to modify the contents of the line
   * $(LPAREN)glyphs, glyph widths, etc.$(RPAREN).
   * Returns: the current line, that should not be
   *   modified
   */
  LayoutLine getLineReadonly()
  {
    PangoLayoutLine* _cretval;
    _cretval = pango_layout_iter_get_line_readonly(cast(PangoLayoutIter*)cPtr);
    auto _retval = _cretval ? new LayoutLine(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Divides the vertical space in the `PangoLayout` being iterated over
   * between the lines in the layout, and returns the space belonging to
   * the current line.
   * A line's range includes the line's logical extents. plus half of the
   * spacing above and below the line, if [Pango.Layout.setSpacing]
   * has been called to set layout spacing. The Y positions are in layout
   * coordinates $(LPAREN)origin at top left of the entire layout$(RPAREN).
   * Note: Since 1.44, Pango uses line heights for placing lines, and there
   * may be gaps between the ranges returned by this function.
   * Params:
   *   y0 = start of line
   *   y1 = end of line
   */
  void getLineYrange(out int y0, out int y1)
  {
    pango_layout_iter_get_line_yrange(cast(PangoLayoutIter*)cPtr, cast(int*)&y0, cast(int*)&y1);
  }

  /**
   * Gets the current run.
   * When iterating by run, at the end of each line, there's a position
   * with a %NULL run, so this function can return %NULL. The %NULL run
   * at the end of each line ensures that all lines have at least one run,
   * even lines consisting of only a newline.
   * Use the faster [Pango.LayoutIter.getRunReadonly] if you do not
   * plan to modify the contents of the run $(LPAREN)glyphs, glyph widths, etc.$(RPAREN).
   * Returns: the current run
   */
  LayoutRun getRun()
  {
    PangoLayoutRun* _cretval;
    _cretval = pango_layout_iter_get_run(cast(PangoLayoutIter*)cPtr);
    auto _retval = _cretval ? new LayoutRun(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the Y position of the current run's baseline, in layout
   * coordinates.
   * Layout coordinates have the origin at the top left of the entire layout.
   * The run baseline can be different from the line baseline, for
   * example due to superscript or subscript positioning.
   * Returns:
   */
  int getRunBaseline()
  {
    int _retval;
    _retval = pango_layout_iter_get_run_baseline(cast(PangoLayoutIter*)cPtr);
    return _retval;
  }

  /**
   * Gets the extents of the current run in layout coordinates.
   * Layout coordinates have the origin at the top left of the entire layout.
   * Params:
   *   inkRect = rectangle to fill with ink extents
   *   logicalRect = rectangle to fill with logical extents
   */
  void getRunExtents(out Rectangle inkRect, out Rectangle logicalRect)
  {
    pango_layout_iter_get_run_extents(cast(PangoLayoutIter*)cPtr, &inkRect, &logicalRect);
  }

  /**
   * Gets the current run for read-only access.
   * When iterating by run, at the end of each line, there's a position
   * with a %NULL run, so this function can return %NULL. The %NULL run
   * at the end of each line ensures that all lines have at least one run,
   * even lines consisting of only a newline.
   * This is a faster alternative to [Pango.LayoutIter.getRun],
   * but the user is not expected to modify the contents of the run $(LPAREN)glyphs,
   * glyph widths, etc.$(RPAREN).
   * Returns: the current run, that
   *   should not be modified
   */
  LayoutRun getRunReadonly()
  {
    PangoLayoutRun* _cretval;
    _cretval = pango_layout_iter_get_run_readonly(cast(PangoLayoutIter*)cPtr);
    auto _retval = _cretval ? new LayoutRun(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Moves iter forward to the next character in visual order.
   * If iter was already at the end of the layout, returns %FALSE.
   * Returns: whether motion was possible
   */
  bool nextChar()
  {
    bool _retval;
    _retval = pango_layout_iter_next_char(cast(PangoLayoutIter*)cPtr);
    return _retval;
  }

  /**
   * Moves iter forward to the next cluster in visual order.
   * If iter was already at the end of the layout, returns %FALSE.
   * Returns: whether motion was possible
   */
  bool nextCluster()
  {
    bool _retval;
    _retval = pango_layout_iter_next_cluster(cast(PangoLayoutIter*)cPtr);
    return _retval;
  }

  /**
   * Moves iter forward to the start of the next line.
   * If iter is already on the last line, returns %FALSE.
   * Returns: whether motion was possible
   */
  bool nextLine()
  {
    bool _retval;
    _retval = pango_layout_iter_next_line(cast(PangoLayoutIter*)cPtr);
    return _retval;
  }

  /**
   * Moves iter forward to the next run in visual order.
   * If iter was already at the end of the layout, returns %FALSE.
   * Returns: whether motion was possible
   */
  bool nextRun()
  {
    bool _retval;
    _retval = pango_layout_iter_next_run(cast(PangoLayoutIter*)cPtr);
    return _retval;
  }
}
