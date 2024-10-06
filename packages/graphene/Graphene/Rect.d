module Graphene.Rect;

import GLib.Boxed;
import Gid.gid;
import Graphene.Point;
import Graphene.Size;
import Graphene.Types;
import Graphene.c.functions;
import Graphene.c.types;

/**
 * The location and size of a rectangle region.
 * The width and height of a #graphene_rect_t can be negative; for instance,
 * a #graphene_rect_t with an origin of [ 0, 0 ] and a size of [ 10, 10 ] is
 * equivalent to a #graphene_rect_t with an origin of [ 10, 10 ] and a size
 * of [ -10, -10 ].
 * Application code can normalize rectangles using [Graphene.Rect.normalize];
 * this function will ensure that the width and height of a rectangle are
 * positive values. All functions taking a #graphene_rect_t as an argument
 * will internally operate on a normalized copy; all functions returning a
 * #graphene_rect_t will always return a normalized rectangle.
 */
class Rect : Boxed
{

  this()
  {
    super(safeMalloc(graphene_rect_t.sizeof), true);
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
    return graphene_rect_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  @property Point origin()
  {
    return new Point(cast(graphene_point_t*)&(cast(graphene_rect_t*)cPtr).origin);
  }

  @property Size size()
  {
    return new Size(cast(graphene_size_t*)&(cast(graphene_rect_t*)cPtr).size);
  }

  /**
   * Checks whether a #graphene_rect_t contains the given coordinates.
   * Params:
   *   p = a #graphene_point_t
   * Returns: `true` if the rectangle contains the point
   */
  bool containsPoint(Point p)
  {
    bool _retval;
    _retval = graphene_rect_contains_point(cast(graphene_rect_t*)cPtr, p ? cast(graphene_point_t*)p.cPtr(false) : null);
    return _retval;
  }

  /**
   * Checks whether a #graphene_rect_t fully contains the given
   * rectangle.
   * Params:
   *   b = a #graphene_rect_t
   * Returns: `true` if the rectangle a fully contains b
   */
  bool containsRect(Rect b)
  {
    bool _retval;
    _retval = graphene_rect_contains_rect(cast(graphene_rect_t*)cPtr, b ? cast(graphene_rect_t*)b.cPtr(false) : null);
    return _retval;
  }

  /**
   * Checks whether the two given rectangle are equal.
   * Params:
   *   b = a #graphene_rect_t
   * Returns: `true` if the rectangles are equal
   */
  bool equal(Rect b)
  {
    bool _retval;
    _retval = graphene_rect_equal(cast(graphene_rect_t*)cPtr, b ? cast(graphene_rect_t*)b.cPtr(false) : null);
    return _retval;
  }

  /**
   * Expands a #graphene_rect_t to contain the given #graphene_point_t.
   * Params:
   *   p = a #graphene_point_t
   *   res = return location for the expanded rectangle
   */
  void expand(Point p, out Rect res)
  {
    graphene_rect_t _res;
    graphene_rect_expand(cast(graphene_rect_t*)cPtr, p ? cast(graphene_point_t*)p.cPtr(false) : null, &_res);
    res = new Rect(cast(void*)&_res, false);
  }

  /**
   * Compute the area of given normalized rectangle.
   * Returns: the area of the normalized rectangle
   */
  float getArea()
  {
    float _retval;
    _retval = graphene_rect_get_area(cast(graphene_rect_t*)cPtr);
    return _retval;
  }

  /**
   * Retrieves the coordinates of the bottom-left corner of the given rectangle.
   * Params:
   *   p = return location for a #graphene_point_t
   */
  void getBottomLeft(out Point p)
  {
    graphene_point_t _p;
    graphene_rect_get_bottom_left(cast(graphene_rect_t*)cPtr, &_p);
    p = new Point(cast(void*)&_p, false);
  }

  /**
   * Retrieves the coordinates of the bottom-right corner of the given rectangle.
   * Params:
   *   p = return location for a #graphene_point_t
   */
  void getBottomRight(out Point p)
  {
    graphene_point_t _p;
    graphene_rect_get_bottom_right(cast(graphene_rect_t*)cPtr, &_p);
    p = new Point(cast(void*)&_p, false);
  }

  /**
   * Retrieves the coordinates of the center of the given rectangle.
   * Params:
   *   p = return location for a #graphene_point_t
   */
  void getCenter(out Point p)
  {
    graphene_point_t _p;
    graphene_rect_get_center(cast(graphene_rect_t*)cPtr, &_p);
    p = new Point(cast(void*)&_p, false);
  }

  /**
   * Retrieves the normalized height of the given rectangle.
   * Returns: the normalized height of the rectangle
   */
  float getHeight()
  {
    float _retval;
    _retval = graphene_rect_get_height(cast(graphene_rect_t*)cPtr);
    return _retval;
  }

  /**
   * Retrieves the coordinates of the top-left corner of the given rectangle.
   * Params:
   *   p = return location for a #graphene_point_t
   */
  void getTopLeft(out Point p)
  {
    graphene_point_t _p;
    graphene_rect_get_top_left(cast(graphene_rect_t*)cPtr, &_p);
    p = new Point(cast(void*)&_p, false);
  }

  /**
   * Retrieves the coordinates of the top-right corner of the given rectangle.
   * Params:
   *   p = return location for a #graphene_point_t
   */
  void getTopRight(out Point p)
  {
    graphene_point_t _p;
    graphene_rect_get_top_right(cast(graphene_rect_t*)cPtr, &_p);
    p = new Point(cast(void*)&_p, false);
  }

  /**
   * Retrieves the normalized width of the given rectangle.
   * Returns: the normalized width of the rectangle
   */
  float getWidth()
  {
    float _retval;
    _retval = graphene_rect_get_width(cast(graphene_rect_t*)cPtr);
    return _retval;
  }

  /**
   * Retrieves the normalized X coordinate of the origin of the given
   * rectangle.
   * Returns: the normalized X coordinate of the rectangle
   */
  float getX()
  {
    float _retval;
    _retval = graphene_rect_get_x(cast(graphene_rect_t*)cPtr);
    return _retval;
  }

  /**
   * Retrieves the normalized Y coordinate of the origin of the given
   * rectangle.
   * Returns: the normalized Y coordinate of the rectangle
   */
  float getY()
  {
    float _retval;
    _retval = graphene_rect_get_y(cast(graphene_rect_t*)cPtr);
    return _retval;
  }

  /**
   * Initializes the given #graphene_rect_t with the given values.
   * This function will implicitly normalize the #graphene_rect_t
   * before returning.
   * Params:
   *   x = the X coordinate of the graphene_rect_t.origin
   *   y = the Y coordinate of the graphene_rect_t.origin
   *   width = the width of the graphene_rect_t.size
   *   height = the height of the graphene_rect_t.size
   * Returns: the initialized rectangle
   */
  Rect init_(float x, float y, float width, float height)
  {
    graphene_rect_t* _cretval;
    _cretval = graphene_rect_init(cast(graphene_rect_t*)cPtr, x, y, width, height);
    auto _retval = _cretval ? new Rect(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Initializes r using the given src rectangle.
   * This function will implicitly normalize the #graphene_rect_t
   * before returning.
   * Params:
   *   src = a #graphene_rect_t
   * Returns: the initialized rectangle
   */
  Rect initFromRect(Rect src)
  {
    graphene_rect_t* _cretval;
    _cretval = graphene_rect_init_from_rect(cast(graphene_rect_t*)cPtr, src ? cast(graphene_rect_t*)src.cPtr(false) : null);
    auto _retval = _cretval ? new Rect(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Changes the given rectangle to be smaller, or larger depending on the
   * given inset parameters.
   * To create an inset rectangle, use positive d_x or d_y values; to
   * create a larger, encompassing rectangle, use negative d_x or d_y
   * values.
   * The origin of the rectangle is offset by d_x and d_y, while the size
   * is adjusted by `$(LPAREN)2 * d_x, 2 * d_y$(RPAREN)`. If d_x and d_y are positive
   * values, the size of the rectangle is decreased; if d_x and d_y are
   * negative values, the size of the rectangle is increased.
   * If the size of the resulting inset rectangle has a negative width or
   * height then the size will be set to zero.
   * Params:
   *   dX = the horizontal inset
   *   dY = the vertical inset
   * Returns: the inset rectangle
   */
  Rect inset(float dX, float dY)
  {
    graphene_rect_t* _cretval;
    _cretval = graphene_rect_inset(cast(graphene_rect_t*)cPtr, dX, dY);
    auto _retval = _cretval ? new Rect(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Changes the given rectangle to be smaller, or larger depending on the
   * given inset parameters.
   * To create an inset rectangle, use positive d_x or d_y values; to
   * create a larger, encompassing rectangle, use negative d_x or d_y
   * values.
   * The origin of the rectangle is offset by d_x and d_y, while the size
   * is adjusted by `$(LPAREN)2 * d_x, 2 * d_y$(RPAREN)`. If d_x and d_y are positive
   * values, the size of the rectangle is decreased; if d_x and d_y are
   * negative values, the size of the rectangle is increased.
   * If the size of the resulting inset rectangle has a negative width or
   * height then the size will be set to zero.
   * Params:
   *   dX = the horizontal inset
   *   dY = the vertical inset
   *   res = return location for the inset rectangle
   */
  void insetR(float dX, float dY, out Rect res)
  {
    graphene_rect_t _res;
    graphene_rect_inset_r(cast(graphene_rect_t*)cPtr, dX, dY, &_res);
    res = new Rect(cast(void*)&_res, false);
  }

  /**
   * Linearly interpolates the origin and size of the two given
   * rectangles.
   * Params:
   *   b = a #graphene_rect_t
   *   factor = the linear interpolation factor
   *   res = return location for the
   *     interpolated rectangle
   */
  void interpolate(Rect b, double factor, out Rect res)
  {
    graphene_rect_t _res;
    graphene_rect_interpolate(cast(graphene_rect_t*)cPtr, b ? cast(graphene_rect_t*)b.cPtr(false) : null, factor, &_res);
    res = new Rect(cast(void*)&_res, false);
  }

  /**
   * Computes the intersection of the two given rectangles.
   * ![](rectangle-intersection.png)
   * The intersection in the image above is the blue outline.
   * If the two rectangles do not intersect, res will contain
   * a degenerate rectangle with origin in $(LPAREN)0, 0$(RPAREN) and a size of 0.
   * Params:
   *   b = a #graphene_rect_t
   *   res = return location for
   *     a #graphene_rect_t
   * Returns: `true` if the two rectangles intersect
   */
  bool intersection(Rect b, out Rect res)
  {
    bool _retval;
    graphene_rect_t _res;
    _retval = graphene_rect_intersection(cast(graphene_rect_t*)cPtr, b ? cast(graphene_rect_t*)b.cPtr(false) : null, &_res);
    res = new Rect(cast(void*)&_res, false);
    return _retval;
  }

  /**
   * Normalizes the passed rectangle.
   * This function ensures that the size of the rectangle is made of
   * positive values, and that the origin is the top-left corner of
   * the rectangle.
   * Returns: the normalized rectangle
   */
  Rect normalize()
  {
    graphene_rect_t* _cretval;
    _cretval = graphene_rect_normalize(cast(graphene_rect_t*)cPtr);
    auto _retval = _cretval ? new Rect(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Normalizes the passed rectangle.
   * This function ensures that the size of the rectangle is made of
   * positive values, and that the origin is in the top-left corner
   * of the rectangle.
   * Params:
   *   res = the return location for the
   *     normalized rectangle
   */
  void normalizeR(out Rect res)
  {
    graphene_rect_t _res;
    graphene_rect_normalize_r(cast(graphene_rect_t*)cPtr, &_res);
    res = new Rect(cast(void*)&_res, false);
  }

  /**
   * Offsets the origin by d_x and d_y.
   * The size of the rectangle is unchanged.
   * Params:
   *   dX = the horizontal offset
   *   dY = the vertical offset
   * Returns: the offset rectangle
   */
  Rect offset(float dX, float dY)
  {
    graphene_rect_t* _cretval;
    _cretval = graphene_rect_offset(cast(graphene_rect_t*)cPtr, dX, dY);
    auto _retval = _cretval ? new Rect(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Offsets the origin of the given rectangle by d_x and d_y.
   * The size of the rectangle is left unchanged.
   * Params:
   *   dX = the horizontal offset
   *   dY = the vertical offset
   *   res = return location for the offset
   *     rectangle
   */
  void offsetR(float dX, float dY, out Rect res)
  {
    graphene_rect_t _res;
    graphene_rect_offset_r(cast(graphene_rect_t*)cPtr, dX, dY, &_res);
    res = new Rect(cast(void*)&_res, false);
  }

  /**
   * Rounds the origin and size of the given rectangle to
   * their nearest integer values; the rounding is guaranteed
   * to be large enough to have an area bigger or equal to the
   * original rectangle, but might not fully contain its extents.
   * Use [Graphene.Rect.roundExtents] in case you need to round
   * to a rectangle that covers fully the original one.
   * This function is the equivalent of calling `floor` on
   * the coordinates of the origin, and `ceil` on the size.
   * Params:
   *   res = return location for the
   *     rounded rectangle

   * Deprecated: Use [Graphene.Rect.roundExtents] instead
   */
  void round(out Rect res)
  {
    graphene_rect_t _res;
    graphene_rect_round(cast(graphene_rect_t*)cPtr, &_res);
    res = new Rect(cast(void*)&_res, false);
  }

  /**
   * Rounds the origin of the given rectangle to its nearest
   * integer value and and recompute the size so that the
   * rectangle is large enough to contain all the conrners
   * of the original rectangle.
   * This function is the equivalent of calling `floor` on
   * the coordinates of the origin, and recomputing the size
   * calling `ceil` on the bottom-right coordinates.
   * If you want to be sure that the rounded rectangle
   * completely covers the area that was covered by the
   * original rectangle — i.e. you want to cover the area
   * including all its corners — this function will make sure
   * that the size is recomputed taking into account the ceiling
   * of the coordinates of the bottom-right corner.
   * If the difference between the original coordinates and the
   * coordinates of the rounded rectangle is greater than the
   * difference between the original size and and the rounded
   * size, then the move of the origin would not be compensated
   * by a move in the anti-origin, leaving the corners of the
   * original rectangle outside the rounded one.
   * Params:
   *   res = return location for the
   *     rectangle with rounded extents
   */
  void roundExtents(out Rect res)
  {
    graphene_rect_t _res;
    graphene_rect_round_extents(cast(graphene_rect_t*)cPtr, &_res);
    res = new Rect(cast(void*)&_res, false);
  }

  /**
   * Rounds the origin and the size of the given rectangle to
   * their nearest integer values; the rounding is guaranteed
   * to be large enough to contain the original rectangle.
   * Returns: the pixel-aligned rectangle.

   * Deprecated: Use [Graphene.Rect.round] instead
   */
  Rect roundToPixel()
  {
    graphene_rect_t* _cretval;
    _cretval = graphene_rect_round_to_pixel(cast(graphene_rect_t*)cPtr);
    auto _retval = _cretval ? new Rect(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Scales the size and origin of a rectangle horizontaly by s_h,
   * and vertically by s_v. The result res is normalized.
   * Params:
   *   sH = horizontal scale factor
   *   sV = vertical scale factor
   *   res = return location for the
   *     scaled rectangle
   */
  void scale(float sH, float sV, out Rect res)
  {
    graphene_rect_t _res;
    graphene_rect_scale(cast(graphene_rect_t*)cPtr, sH, sV, &_res);
    res = new Rect(cast(void*)&_res, false);
  }

  /**
   * Computes the union of the two given rectangles.
   * ![](rectangle-union.png)
   * The union in the image above is the blue outline.
   * Params:
   *   b = a #graphene_rect_t
   *   res = return location for a #graphene_rect_t
   */
  void union_(Rect b, out Rect res)
  {
    graphene_rect_t _res;
    graphene_rect_union(cast(graphene_rect_t*)cPtr, b ? cast(graphene_rect_t*)b.cPtr(false) : null, &_res);
    res = new Rect(cast(void*)&_res, false);
  }

  /**
   * Allocates a new #graphene_rect_t.
   * The contents of the returned rectangle are undefined.
   * Returns: the newly allocated rectangle
   */
  static Rect alloc()
  {
    graphene_rect_t* _cretval;
    _cretval = graphene_rect_alloc();
    auto _retval = _cretval ? new Rect(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Returns a degenerate rectangle with origin fixed at $(LPAREN)0, 0$(RPAREN) and
   * a size of 0, 0.
   * Returns: a fixed rectangle
   */
  static Rect zero()
  {
    const(graphene_rect_t)* _cretval;
    _cretval = graphene_rect_zero();
    auto _retval = _cretval ? new Rect(cast(void*)_cretval, false) : null;
    return _retval;
  }
}
