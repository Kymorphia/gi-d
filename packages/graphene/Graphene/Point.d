module Graphene.Point;

import GLib.Boxed;
import Gid.gid;
import Graphene.Types;
import Graphene.Vec2;
import Graphene.c.functions;
import Graphene.c.types;

/**
 * A point with two coordinates.
 */
class Point : Boxed
{

  this()
  {
    super(safeMalloc(graphene_point_t.sizeof), true);
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
    return graphene_point_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  @property float x()
  {
    return (cast(graphene_point_t*)cPtr).x;
  }

  @property void x(float propval)
  {
    (cast(graphene_point_t*)cPtr).x = propval;
  }

  @property float y()
  {
    return (cast(graphene_point_t*)cPtr).y;
  }

  @property void y(float propval)
  {
    (cast(graphene_point_t*)cPtr).y = propval;
  }

  /**
   * Allocates a new #graphene_point_t structure.
   * The coordinates of the returned point are $(LPAREN)0, 0$(RPAREN).
   * It's possible to chain this function with [Graphene.Point.init_]
   * or [Graphene.Point.initFromPoint], e.g.:
   * |[<!-- language\="C" -->
   * graphene_point_t *
   * point_new $(LPAREN)float x, float y$(RPAREN)
   * {
   * return graphene_point_init $(LPAREN)graphene_point_alloc $(LPAREN)$(RPAREN), x, y$(RPAREN);
   * }
   * graphene_point_t *
   * point_copy $(LPAREN)const graphene_point_t *p$(RPAREN)
   * {
   * return graphene_point_init_from_point $(LPAREN)graphene_point_alloc $(LPAREN)$(RPAREN), p$(RPAREN);
   * }
   * ]|
   * Returns: the newly allocated #graphene_point_t.
   *   Use [Graphene.Point.free] to free the resources allocated by
   *   this function.
   */
  static Point alloc()
  {
    graphene_point_t* _cretval;
    _cretval = graphene_point_alloc();
    auto _retval = _cretval ? new Point(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Computes the distance between a and b.
   * Params:
   *   b = a #graphene_point_t
   *   dX = distance component on the X axis
   *   dY = distance component on the Y axis
   * Returns: the distance between the two points
   */
  float distance(Point b, out float dX, out float dY)
  {
    float _retval;
    _retval = graphene_point_distance(cast(graphene_point_t*)cPtr, b ? cast(graphene_point_t*)b.cPtr(false) : null, cast(float*)&dX, cast(float*)&dY);
    return _retval;
  }

  /**
   * Checks if the two points a and b point to the same
   * coordinates.
   * This function accounts for floating point fluctuations; if
   * you want to control the fuzziness of the match, you can use
   * [Graphene.Point.near] instead.
   * Params:
   *   b = a #graphene_point_t
   * Returns: `true` if the points have the same coordinates
   */
  bool equal(Point b)
  {
    bool _retval;
    _retval = graphene_point_equal(cast(graphene_point_t*)cPtr, b ? cast(graphene_point_t*)b.cPtr(false) : null);
    return _retval;
  }

  /**
   * Initializes p to the given x and y coordinates.
   * It's safe to call this function multiple times.
   * Params:
   *   x = the X coordinate
   *   y = the Y coordinate
   * Returns: the initialized point
   */
  Point init_(float x, float y)
  {
    graphene_point_t* _cretval;
    _cretval = graphene_point_init(cast(graphene_point_t*)cPtr, x, y);
    auto _retval = _cretval ? new Point(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Initializes p with the same coordinates of src.
   * Params:
   *   src = the #graphene_point_t to use
   * Returns: the initialized point
   */
  Point initFromPoint(Point src)
  {
    graphene_point_t* _cretval;
    _cretval = graphene_point_init_from_point(cast(graphene_point_t*)cPtr, src ? cast(graphene_point_t*)src.cPtr(false) : null);
    auto _retval = _cretval ? new Point(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Initializes p with the coordinates inside the given #graphene_vec2_t.
   * Params:
   *   src = a #graphene_vec2_t
   * Returns: the initialized point
   */
  Point initFromVec2(Vec2 src)
  {
    graphene_point_t* _cretval;
    _cretval = graphene_point_init_from_vec2(cast(graphene_point_t*)cPtr, src ? cast(graphene_vec2_t*)src.cPtr(false) : null);
    auto _retval = _cretval ? new Point(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Linearly interpolates the coordinates of a and b using the
   * given factor.
   * Params:
   *   b = a #graphene_point_t
   *   factor = the linear interpolation factor
   *   res = return location for the interpolated
   *     point
   */
  void interpolate(Point b, double factor, out Point res)
  {
    graphene_point_t _res;
    graphene_point_interpolate(cast(graphene_point_t*)cPtr, b ? cast(graphene_point_t*)b.cPtr(false) : null, factor, &_res);
    res = new Point(cast(void*)&_res, false);
  }

  /**
   * Checks whether the two points a and b are within
   * the threshold of epsilon.
   * Params:
   *   b = a #graphene_point_t
   *   epsilon = threshold between the two points
   * Returns: `true` if the distance is within epsilon
   */
  bool near(Point b, float epsilon)
  {
    bool _retval;
    _retval = graphene_point_near(cast(graphene_point_t*)cPtr, b ? cast(graphene_point_t*)b.cPtr(false) : null, epsilon);
    return _retval;
  }

  /**
   * Stores the coordinates of the given #graphene_point_t into a
   * #graphene_vec2_t.
   * Params:
   *   v = return location for the vertex
   */
  void toVec2(out Vec2 v)
  {
    graphene_vec2_t _v;
    graphene_point_to_vec2(cast(graphene_point_t*)cPtr, &_v);
    v = new Vec2(cast(void*)&_v, false);
  }

  /**
   * Returns a point fixed at $(LPAREN)0, 0$(RPAREN).
   * Returns: a fixed point
   */
  static Point zero()
  {
    const(graphene_point_t)* _cretval;
    _cretval = graphene_point_zero();
    auto _retval = _cretval ? new Point(cast(void*)_cretval, false) : null;
    return _retval;
  }
}
