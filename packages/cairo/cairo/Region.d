module cairo.Region;

import GLib.Boxed;
import Gid.gid;
import cairo.RectangleInt;
import cairo.Types;
import cairo.c.functions;
import cairo.c.types;

/**
 * A #cairo_region_t represents a set of integer-aligned rectangles.
 * It allows set-theoretical operations like [cairo.Region.union_] and
 * [cairo.Region.intersect] to be performed on them.
 * Memory management of #cairo_region_t is done with
 * [cairo.Region.reference] and [cairo.Region.destroy].
 */
class Region : Boxed
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
    return cairo_gobject_region_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Checks whether $(LPAREN)x, y$(RPAREN) is contained in region.
   * Params:
   *   x = the x coordinate of a point
   *   y = the y coordinate of a point
   * Returns: %TRUE if $(LPAREN)x, y$(RPAREN) is contained in region, %FALSE if it is not.
   */
  Bool containsPoint(int x, int y)
  {
    Bool _retval;
    _retval = cairo_region_contains_point(cast(cairo_region_t*)cPtr, x, y);
    return _retval;
  }

  /**
   * Checks whether rectangle is inside, outside or partially contained
   * in region
   * Params:
   *   rectangle = a #cairo_rectangle_int_t
   * Returns: %CAIRO_REGION_OVERLAP_IN if rectangle is entirely inside region,
   *   %CAIRO_REGION_OVERLAP_OUT if rectangle is entirely outside region, or
   *   %CAIRO_REGION_OVERLAP_PART if rectangle is partially inside and partially outside region.
   */
  RegionOverlap containsRectangle(RectangleInt rectangle)
  {
    cairo_region_overlap_t _cretval;
    _cretval = cairo_region_contains_rectangle(cast(cairo_region_t*)cPtr, rectangle ? cast(cairo_rectangle_int_t*)rectangle.cPtr(false) : null);
    RegionOverlap _retval = cast(RegionOverlap)_cretval;
    return _retval;
  }

  /**
   * Allocates a new region object copying the area from original.
   * Returns: A newly allocated #cairo_region_t. Free with
   *   [cairo.Region.destroy]. This function always returns a
   *   valid pointer; if memory cannot be allocated, then a special
   *   error object is returned where all operations on the object do nothing.
   *   You can check for this with [cairo.Region.status].
   */
  Region copy()
  {
    cairo_region_t* _cretval;
    _cretval = cairo_region_copy(cast(cairo_region_t*)cPtr);
    auto _retval = _cretval ? new Region(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Compares whether region_a is equivalent to region_b. %NULL as an argument
   * is equal to itself, but not to any non-%NULL region.
   * Params:
   *   b = a #cairo_region_t or %NULL
   * Returns: %TRUE if both regions contained the same coverage,
   *   %FALSE if it is not or any region is in an error status.
   */
  Bool equal(Region b)
  {
    Bool _retval;
    _retval = cairo_region_equal(cast(cairo_region_t*)cPtr, b ? cast(cairo_region_t*)b.cPtr(false) : null);
    return _retval;
  }

  /**
   * Gets the bounding rectangle of region as a #cairo_rectangle_int_t
   * Params:
   *   extents = rectangle into which to store the extents
   */
  void getExtents(RectangleInt extents)
  {
    cairo_region_get_extents(cast(cairo_region_t*)cPtr, extents ? cast(cairo_rectangle_int_t*)extents.cPtr(false) : null);
  }

  /**
   * Stores the nth rectangle from the region in rectangle.
   * Params:
   *   nth = a number indicating which rectangle should be returned
   *   rectangle = return location for a #cairo_rectangle_int_t
   */
  void getRectangle(int nth, RectangleInt rectangle)
  {
    cairo_region_get_rectangle(cast(cairo_region_t*)cPtr, nth, rectangle ? cast(cairo_rectangle_int_t*)rectangle.cPtr(false) : null);
  }

  /**
   * Computes the intersection of dst with other and places the result in dst
   * Params:
   *   other = another #cairo_region_t
   * Returns: %CAIRO_STATUS_SUCCESS or %CAIRO_STATUS_NO_MEMORY
   */
  Status intersect(Region other)
  {
    cairo_status_t _cretval;
    _cretval = cairo_region_intersect(cast(cairo_region_t*)cPtr, other ? cast(cairo_region_t*)other.cPtr(false) : null);
    Status _retval = cast(Status)_cretval;
    return _retval;
  }

  /**
   * Computes the intersection of dst with rectangle and places the
   * result in dst
   * Params:
   *   rectangle = a #cairo_rectangle_int_t
   * Returns: %CAIRO_STATUS_SUCCESS or %CAIRO_STATUS_NO_MEMORY
   */
  Status intersectRectangle(RectangleInt rectangle)
  {
    cairo_status_t _cretval;
    _cretval = cairo_region_intersect_rectangle(cast(cairo_region_t*)cPtr, rectangle ? cast(cairo_rectangle_int_t*)rectangle.cPtr(false) : null);
    Status _retval = cast(Status)_cretval;
    return _retval;
  }

  /**
   * Checks whether region is empty.
   * Returns: %TRUE if region is empty, %FALSE if it isn't.
   */
  Bool isEmpty()
  {
    Bool _retval;
    _retval = cairo_region_is_empty(cast(cairo_region_t*)cPtr);
    return _retval;
  }

  /**
   * Returns the number of rectangles contained in region.
   * Returns: The number of rectangles contained in region.
   */
  int numRectangles()
  {
    int _retval;
    _retval = cairo_region_num_rectangles(cast(cairo_region_t*)cPtr);
    return _retval;
  }

  /**
   * Checks whether an error has previous occurred for this
   * region object.
   * Returns: %CAIRO_STATUS_SUCCESS or %CAIRO_STATUS_NO_MEMORY
   */
  Status status()
  {
    cairo_status_t _cretval;
    _cretval = cairo_region_status(cast(cairo_region_t*)cPtr);
    Status _retval = cast(Status)_cretval;
    return _retval;
  }

  /**
   * Subtracts other from dst and places the result in dst
   * Params:
   *   other = another #cairo_region_t
   * Returns: %CAIRO_STATUS_SUCCESS or %CAIRO_STATUS_NO_MEMORY
   */
  Status subtract(Region other)
  {
    cairo_status_t _cretval;
    _cretval = cairo_region_subtract(cast(cairo_region_t*)cPtr, other ? cast(cairo_region_t*)other.cPtr(false) : null);
    Status _retval = cast(Status)_cretval;
    return _retval;
  }

  /**
   * Subtracts rectangle from dst and places the result in dst
   * Params:
   *   rectangle = a #cairo_rectangle_int_t
   * Returns: %CAIRO_STATUS_SUCCESS or %CAIRO_STATUS_NO_MEMORY
   */
  Status subtractRectangle(RectangleInt rectangle)
  {
    cairo_status_t _cretval;
    _cretval = cairo_region_subtract_rectangle(cast(cairo_region_t*)cPtr, rectangle ? cast(cairo_rectangle_int_t*)rectangle.cPtr(false) : null);
    Status _retval = cast(Status)_cretval;
    return _retval;
  }

  /**
   * Translates region by $(LPAREN)dx, dy$(RPAREN).
   * Params:
   *   dx = Amount to translate in the x direction
   *   dy = Amount to translate in the y direction
   */
  void translate(int dx, int dy)
  {
    cairo_region_translate(cast(cairo_region_t*)cPtr, dx, dy);
  }

  /**
   * Computes the union of dst with other and places the result in dst
   * Params:
   *   other = another #cairo_region_t
   * Returns: %CAIRO_STATUS_SUCCESS or %CAIRO_STATUS_NO_MEMORY
   */
  Status union_(Region other)
  {
    cairo_status_t _cretval;
    _cretval = cairo_region_union(cast(cairo_region_t*)cPtr, other ? cast(cairo_region_t*)other.cPtr(false) : null);
    Status _retval = cast(Status)_cretval;
    return _retval;
  }

  /**
   * Computes the union of dst with rectangle and places the result in dst.
   * Params:
   *   rectangle = a #cairo_rectangle_int_t
   * Returns: %CAIRO_STATUS_SUCCESS or %CAIRO_STATUS_NO_MEMORY
   */
  Status unionRectangle(RectangleInt rectangle)
  {
    cairo_status_t _cretval;
    _cretval = cairo_region_union_rectangle(cast(cairo_region_t*)cPtr, rectangle ? cast(cairo_rectangle_int_t*)rectangle.cPtr(false) : null);
    Status _retval = cast(Status)_cretval;
    return _retval;
  }

  /**
   * Computes the exclusive difference of dst with other and places the
   * result in dst. That is, dst will be set to contain all areas that
   * are either in dst or in other, but not in both.
   * Params:
   *   other = another #cairo_region_t
   * Returns: %CAIRO_STATUS_SUCCESS or %CAIRO_STATUS_NO_MEMORY
   */
  Status xor(Region other)
  {
    cairo_status_t _cretval;
    _cretval = cairo_region_xor(cast(cairo_region_t*)cPtr, other ? cast(cairo_region_t*)other.cPtr(false) : null);
    Status _retval = cast(Status)_cretval;
    return _retval;
  }

  /**
   * Computes the exclusive difference of dst with rectangle and places the
   * result in dst. That is, dst will be set to contain all areas that are
   * either in dst or in rectangle, but not in both.
   * Params:
   *   rectangle = a #cairo_rectangle_int_t
   * Returns: %CAIRO_STATUS_SUCCESS or %CAIRO_STATUS_NO_MEMORY
   */
  Status xorRectangle(RectangleInt rectangle)
  {
    cairo_status_t _cretval;
    _cretval = cairo_region_xor_rectangle(cast(cairo_region_t*)cPtr, rectangle ? cast(cairo_rectangle_int_t*)rectangle.cPtr(false) : null);
    Status _retval = cast(Status)_cretval;
    return _retval;
  }
}
