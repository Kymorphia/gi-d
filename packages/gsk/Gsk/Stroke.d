module Gsk.Stroke;

import GLib.Boxed;
import Gid.gid;
import Gsk.Types;
import Gsk.c.functions;
import Gsk.c.types;
import cairo.Context;

/**
 * A `GskStroke` struct collects the parameters that influence
 * the operation of stroking a path.
 */
class Stroke : Boxed
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
    return gsk_stroke_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new `GskStroke` with the given line_width.
   * Params:
   *   lineWidth = line width of the stroke. Must be > 0
   * Returns: a new `GskStroke`
   */
  this(float lineWidth)
  {
    GskStroke* _cretval;
    _cretval = gsk_stroke_new(lineWidth);
    this(_cretval, true);
  }

  /**
   * Creates a copy of the given other stroke.
   * Returns: a new `GskStroke`. Use [Gsk.Stroke.free] to free it
   */
  Stroke copy()
  {
    GskStroke* _cretval;
    _cretval = gsk_stroke_copy(cast(GskStroke*)cPtr);
    auto _retval = _cretval ? new Stroke(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Gets the dash array in use or `NULL` if dashing is disabled.
   * Returns: The dash array or `NULL` if the dash array is empty.
   */
  float[] getDash()
  {
    const(float)* _cretval;
    size_t _cretlength;
    _cretval = gsk_stroke_get_dash(cast(GskStroke*)cPtr, &_cretlength);
    float[] _retval;

    if (_cretval)
    {
      _retval = cast(float[] )_cretval[0 .. _cretlength];
    }
    return _retval;
  }

  /**
   * Returns the dash_offset of a `GskStroke`.
   * Returns:
   */
  float getDashOffset()
  {
    float _retval;
    _retval = gsk_stroke_get_dash_offset(cast(GskStroke*)cPtr);
    return _retval;
  }

  /**
   * Gets the line cap used.
   * See [Gsk] for details.
   * Returns: The line cap
   */
  LineCap getLineCap()
  {
    GskLineCap _cretval;
    _cretval = gsk_stroke_get_line_cap(cast(GskStroke*)cPtr);
    LineCap _retval = cast(LineCap)_cretval;
    return _retval;
  }

  /**
   * Gets the line join used.
   * See [Gsk] for details.
   * Returns: The line join
   */
  LineJoin getLineJoin()
  {
    GskLineJoin _cretval;
    _cretval = gsk_stroke_get_line_join(cast(GskStroke*)cPtr);
    LineJoin _retval = cast(LineJoin)_cretval;
    return _retval;
  }

  /**
   * Gets the line width used.
   * Returns: The line width
   */
  float getLineWidth()
  {
    float _retval;
    _retval = gsk_stroke_get_line_width(cast(GskStroke*)cPtr);
    return _retval;
  }

  /**
   * Returns the miter limit of a `GskStroke`.
   * Returns:
   */
  float getMiterLimit()
  {
    float _retval;
    _retval = gsk_stroke_get_miter_limit(cast(GskStroke*)cPtr);
    return _retval;
  }

  /**
   * Sets the dash pattern to use by this stroke.
   * A dash pattern is specified by an array of alternating non-negative
   * values. Each value provides the length of alternate "on" and "off"
   * portions of the stroke.
   * Each "on" segment will have caps applied as if the segment were a
   * separate contour. In particular, it is valid to use an "on" length
   * of 0 with `GSK_LINE_CAP_ROUND` or `GSK_LINE_CAP_SQUARE` to draw dots
   * or squares along a path.
   * If n_dash is 0, if all elements in dash are 0, or if there are
   * negative values in dash, then dashing is disabled.
   * If n_dash is 1, an alternating "on" and "off" pattern with the
   * single dash length provided is assumed.
   * If n_dash is uneven, the dash array will be used with the first
   * element in dash defining an "on" or "off" in alternating passes
   * through the array.
   * You can specify a starting offset into the dash with
   * [Gsk.Stroke.setDashOffset].
   * Params:
   *   dash = the array of dashes
   */
  void setDash(float[] dash)
  {
    size_t _nDash;
    if (dash)
      _nDash = cast(size_t)dash.length;

    auto _dash = cast(const(float)*)dash.ptr;
    gsk_stroke_set_dash(cast(GskStroke*)cPtr, _dash, _nDash);
  }

  /**
   * Sets the offset into the dash pattern where dashing should begin.
   * This is an offset into the length of the path, not an index into
   * the array values of the dash array.
   * See [Gsk.Stroke.setDash] for more details on dashing.
   * Params:
   *   offset = offset into the dash pattern
   */
  void setDashOffset(float offset)
  {
    gsk_stroke_set_dash_offset(cast(GskStroke*)cPtr, offset);
  }

  /**
   * Sets the line cap to be used when stroking.
   * See [Gsk] for details.
   * Params:
   *   lineCap = the `GskLineCap`
   */
  void setLineCap(LineCap lineCap)
  {
    gsk_stroke_set_line_cap(cast(GskStroke*)cPtr, lineCap);
  }

  /**
   * Sets the line join to be used when stroking.
   * See [Gsk] for details.
   * Params:
   *   lineJoin = The line join to use
   */
  void setLineJoin(LineJoin lineJoin)
  {
    gsk_stroke_set_line_join(cast(GskStroke*)cPtr, lineJoin);
  }

  /**
   * Sets the line width to be used when stroking.
   * The line width must be > 0.
   * Params:
   *   lineWidth = width of the line in pixels
   */
  void setLineWidth(float lineWidth)
  {
    gsk_stroke_set_line_width(cast(GskStroke*)cPtr, lineWidth);
  }

  /**
   * Sets the limit for the distance from the corner where sharp
   * turns of joins get cut off.
   * The miter limit is in units of line width and must be non-negative.
   * For joins of type `GSK_LINE_JOIN_MITER` that exceed the miter
   * limit, the join gets rendered as if it was of type
   * `GSK_LINE_JOIN_BEVEL`.
   * Params:
   *   limit = the miter limit
   */
  void setMiterLimit(float limit)
  {
    gsk_stroke_set_miter_limit(cast(GskStroke*)cPtr, limit);
  }

  /**
   * A helper function that sets the stroke parameters
   * of cr from the values found in self.
   * Params:
   *   cr = the cairo context to configure
   */
  void toCairo(Context cr)
  {
    gsk_stroke_to_cairo(cast(GskStroke*)cPtr, cr ? cast(cairo_t*)cr.cPtr(false) : null);
  }

  /**
   * Checks if 2 strokes are identical.
   * Params:
   *   stroke1 = the first `GskStroke`
   *   stroke2 = the second `GskStroke`
   * Returns: `TRUE` if the 2 strokes are equal, `FALSE` otherwise
   */
  static bool equal(const(void)* stroke1, const(void)* stroke2)
  {
    bool _retval;
    _retval = gsk_stroke_equal(stroke1, stroke2);
    return _retval;
  }
}
