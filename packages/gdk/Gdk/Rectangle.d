module Gdk.Rectangle;

import GLib.Boxed;
import Gdk.Types;
import Gdk.c.functions;
import Gdk.c.types;
import Gid.gid;

/**
 * A `GdkRectangle` data type for representing rectangles.
 * `GdkRectangle` is identical to `cairo_rectangle_t`. Together with Cairo’s
 * `cairo_region_t` data type, these are the central types for representing
 * sets of pixels.
 * The intersection of two rectangles can be computed with
 * [Gdk.Rectangle.intersect]; to find the union of two rectangles use
 * [Gdk.Rectangle.union_].
 * The `cairo_region_t` type provided by Cairo is usually used for managing
 * non-rectangular clipping of graphical operations.
 * The Graphene library has a number of other data types for regions and
 * volumes in 2D and 3D.
 */
class Rectangle : Boxed
{

  this()
  {
    super(safeMalloc(GdkRectangle.sizeof), true);
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
    return gdk_rectangle_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  @property int x()
  {
    return (cast(GdkRectangle*)cPtr).x;
  }

  @property void x(int propval)
  {
    (cast(GdkRectangle*)cPtr).x = propval;
  }

  @property int y()
  {
    return (cast(GdkRectangle*)cPtr).y;
  }

  @property void y(int propval)
  {
    (cast(GdkRectangle*)cPtr).y = propval;
  }

  @property int width()
  {
    return (cast(GdkRectangle*)cPtr).width;
  }

  @property void width(int propval)
  {
    (cast(GdkRectangle*)cPtr).width = propval;
  }

  @property int height()
  {
    return (cast(GdkRectangle*)cPtr).height;
  }

  @property void height(int propval)
  {
    (cast(GdkRectangle*)cPtr).height = propval;
  }

  /**
   * Returns %TRUE if rect contains the point described by x and y.
   * Params:
   *   x = X coordinate
   *   y = Y coordinate
   * Returns: %TRUE if rect contains the point
   */
  bool containsPoint(int x, int y)
  {
    bool _retval;
    _retval = gdk_rectangle_contains_point(cast(GdkRectangle*)cPtr, x, y);
    return _retval;
  }

  /**
   * Checks if the two given rectangles are equal.
   * Params:
   *   rect2 = a `GdkRectangle`
   * Returns: %TRUE if the rectangles are equal.
   */
  bool equal(Rectangle rect2)
  {
    bool _retval;
    _retval = gdk_rectangle_equal(cast(GdkRectangle*)cPtr, rect2 ? cast(GdkRectangle*)rect2.cPtr(false) : null);
    return _retval;
  }

  /**
   * Calculates the intersection of two rectangles.
   * It is allowed for dest to be the same as either src1 or src2.
   * If the rectangles do not intersect, dest’s width and height is set
   * to 0 and its x and y values are undefined. If you are only interested
   * in whether the rectangles intersect, but not in the intersecting area
   * itself, pass %NULL for dest.
   * Params:
   *   src2 = a `GdkRectangle`
   *   dest = return location for the
   *     intersection of src1 and src2
   * Returns: %TRUE if the rectangles intersect.
   */
  bool intersect(Rectangle src2, out Rectangle dest)
  {
    bool _retval;
    GdkRectangle _dest;
    _retval = gdk_rectangle_intersect(cast(GdkRectangle*)cPtr, src2 ? cast(GdkRectangle*)src2.cPtr(false) : null, &_dest);
    dest = new Rectangle(cast(void*)&_dest, false);
    return _retval;
  }

  /**
   * Calculates the union of two rectangles.
   * The union of rectangles src1 and src2 is the smallest rectangle which
   * includes both src1 and src2 within it. It is allowed for dest to be
   * the same as either src1 or src2.
   * Note that this function does not ignore 'empty' rectangles $(LPAREN)ie. with
   * zero width or height$(RPAREN).
   * Params:
   *   src2 = a `GdkRectangle`
   *   dest = return location for the union of src1 and src2
   */
  void union_(Rectangle src2, out Rectangle dest)
  {
    GdkRectangle _dest;
    gdk_rectangle_union(cast(GdkRectangle*)cPtr, src2 ? cast(GdkRectangle*)src2.cPtr(false) : null, &_dest);
    dest = new Rectangle(cast(void*)&_dest, false);
  }
}
