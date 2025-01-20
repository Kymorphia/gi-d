module Graphene.Point3D;

import GLib.Boxed;
import Gid.gid;
import Graphene.Rect;
import Graphene.Types;
import Graphene.Vec3;
import Graphene.c.functions;
import Graphene.c.types;

/**
 * A point with three components: X, Y, and Z.
 */
class Point3D : Boxed
{

  this()
  {
    super(safeMalloc(graphene_point3d_t.sizeof), true);
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
    return graphene_point3d_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  @property float x()
  {
    return (cast(graphene_point3d_t*)cPtr).x;
  }

  @property void x(float propval)
  {
    (cast(graphene_point3d_t*)cPtr).x = propval;
  }

  @property float y()
  {
    return (cast(graphene_point3d_t*)cPtr).y;
  }

  @property void y(float propval)
  {
    (cast(graphene_point3d_t*)cPtr).y = propval;
  }

  @property float z()
  {
    return (cast(graphene_point3d_t*)cPtr).z;
  }

  @property void z(float propval)
  {
    (cast(graphene_point3d_t*)cPtr).z = propval;
  }

  /**
   * Allocates a #graphene_point3d_t structure.
   * Returns: the newly allocated structure.
   *   Use [Graphene.Point3D.free] to free the resources
   *   allocated by this function.
   */
  static Point3D alloc()
  {
    graphene_point3d_t* _cretval;
    _cretval = graphene_point3d_alloc();
    auto _retval = _cretval ? new Point3D(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Computes the cross product of the two given #graphene_point3d_t.
   * Params:
   *   b = a #graphene_point3d_t
   *   res = return location for the cross
   *     product
   */
  void cross(Point3D b, out Point3D res)
  {
    graphene_point3d_t _res;
    graphene_point3d_cross(cast(graphene_point3d_t*)cPtr, b ? cast(graphene_point3d_t*)b.cPtr(false) : null, &_res);
    res = new Point3D(cast(void*)&_res, false);
  }

  /**
   * Computes the distance between the two given #graphene_point3d_t.
   * Params:
   *   b = a #graphene_point3d_t
   *   delta = return location for the distance
   *     components on the X, Y, and Z axis
   * Returns: the distance between two points
   */
  float distance(Point3D b, out Vec3 delta)
  {
    float _retval;
    graphene_vec3_t _delta;
    _retval = graphene_point3d_distance(cast(graphene_point3d_t*)cPtr, b ? cast(graphene_point3d_t*)b.cPtr(false) : null, &_delta);
    delta = new Vec3(cast(void*)&_delta, false);
    return _retval;
  }

  /**
   * Computes the dot product of the two given #graphene_point3d_t.
   * Params:
   *   b = a #graphene_point3d_t
   * Returns: the value of the dot product
   */
  float dot(Point3D b)
  {
    float _retval;
    _retval = graphene_point3d_dot(cast(graphene_point3d_t*)cPtr, b ? cast(graphene_point3d_t*)b.cPtr(false) : null);
    return _retval;
  }

  /**
   * Checks whether two given points are equal.
   * Params:
   *   b = a #graphene_point3d_t
   * Returns: `true` if the points are equal
   */
  bool equal(Point3D b)
  {
    bool _retval;
    _retval = graphene_point3d_equal(cast(graphene_point3d_t*)cPtr, b ? cast(graphene_point3d_t*)b.cPtr(false) : null);
    return _retval;
  }

  /**
   * Initializes a #graphene_point3d_t with the given coordinates.
   * Params:
   *   x = the X coordinate of the point
   *   y = the Y coordinate of the point
   *   z = the Z coordinate of the point
   * Returns: the initialized #graphene_point3d_t
   */
  Point3D init_(float x, float y, float z)
  {
    graphene_point3d_t* _cretval;
    _cretval = graphene_point3d_init(cast(graphene_point3d_t*)cPtr, x, y, z);
    auto _retval = _cretval ? new Point3D(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Initializes a #graphene_point3d_t using the coordinates of
   * another #graphene_point3d_t.
   * Params:
   *   src = a #graphene_point3d_t
   * Returns: the initialized point
   */
  Point3D initFromPoint(Point3D src)
  {
    graphene_point3d_t* _cretval;
    _cretval = graphene_point3d_init_from_point(cast(graphene_point3d_t*)cPtr, src ? cast(graphene_point3d_t*)src.cPtr(false) : null);
    auto _retval = _cretval ? new Point3D(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Initializes a #graphene_point3d_t using the components
   * of a #graphene_vec3_t.
   * Params:
   *   v = a #graphene_vec3_t
   * Returns: the initialized #graphene_point3d_t
   */
  Point3D initFromVec3(Vec3 v)
  {
    graphene_point3d_t* _cretval;
    _cretval = graphene_point3d_init_from_vec3(cast(graphene_point3d_t*)cPtr, v ? cast(graphene_vec3_t*)v.cPtr(false) : null);
    auto _retval = _cretval ? new Point3D(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Linearly interpolates each component of a and b using the
   * provided factor, and places the result in res.
   * Params:
   *   b = a #graphene_point3d_t
   *   factor = the interpolation factor
   *   res = the return location for the
   *     interpolated #graphene_point3d_t
   */
  void interpolate(Point3D b, double factor, out Point3D res)
  {
    graphene_point3d_t _res;
    graphene_point3d_interpolate(cast(graphene_point3d_t*)cPtr, b ? cast(graphene_point3d_t*)b.cPtr(false) : null, factor, &_res);
    res = new Point3D(cast(void*)&_res, false);
  }

  /**
   * Computes the length of the vector represented by the
   * coordinates of the given #graphene_point3d_t.
   * Returns: the length of the vector represented by the point
   */
  float length()
  {
    float _retval;
    _retval = graphene_point3d_length(cast(graphene_point3d_t*)cPtr);
    return _retval;
  }

  /**
   * Checks whether the two points are near each other, within
   * an epsilon factor.
   * Params:
   *   b = a #graphene_point3d_t
   *   epsilon = fuzzyness factor
   * Returns: `true` if the points are near each other
   */
  bool near(Point3D b, float epsilon)
  {
    bool _retval;
    _retval = graphene_point3d_near(cast(graphene_point3d_t*)cPtr, b ? cast(graphene_point3d_t*)b.cPtr(false) : null, epsilon);
    return _retval;
  }

  /**
   * Computes the normalization of the vector represented by the
   * coordinates of the given #graphene_point3d_t.
   * Params:
   *   res = return location for the normalized
   *     #graphene_point3d_t
   */
  void normalize(out Point3D res)
  {
    graphene_point3d_t _res;
    graphene_point3d_normalize(cast(graphene_point3d_t*)cPtr, &_res);
    res = new Point3D(cast(void*)&_res, false);
  }

  /**
   * Normalizes the coordinates of a #graphene_point3d_t using the
   * given viewport and clipping planes.
   * The coordinates of the resulting #graphene_point3d_t will be
   * in the [ -1, 1 ] range.
   * Params:
   *   viewport = a #graphene_rect_t representing a viewport
   *   zNear = the coordinate of the near clipping plane, or 0 for
   *     the default near clipping plane
   *   zFar = the coordinate of the far clipping plane, or 1 for the
   *     default far clipping plane
   *   res = the return location for the
   *     normalized #graphene_point3d_t
   */
  void normalizeViewport(Rect viewport, float zNear, float zFar, out Point3D res)
  {
    graphene_point3d_t _res;
    graphene_point3d_normalize_viewport(cast(graphene_point3d_t*)cPtr, viewport ? cast(graphene_rect_t*)viewport.cPtr(false) : null, zNear, zFar, &_res);
    res = new Point3D(cast(void*)&_res, false);
  }

  /**
   * Scales the coordinates of the given #graphene_point3d_t by
   * the given factor.
   * Params:
   *   factor = the scaling factor
   *   res = return location for the scaled point
   */
  void scale(float factor, out Point3D res)
  {
    graphene_point3d_t _res;
    graphene_point3d_scale(cast(graphene_point3d_t*)cPtr, factor, &_res);
    res = new Point3D(cast(void*)&_res, false);
  }

  /**
   * Stores the coordinates of a #graphene_point3d_t into a
   * #graphene_vec3_t.
   * Params:
   *   v = return location for a #graphene_vec3_t
   */
  void toVec3(out Vec3 v)
  {
    graphene_vec3_t _v;
    graphene_point3d_to_vec3(cast(graphene_point3d_t*)cPtr, &_v);
    v = new Vec3(cast(void*)&_v, false);
  }

  /**
   * Retrieves a constant point with all three coordinates set to 0.
   * Returns: a zero point
   */
  static Point3D zero()
  {
    const(graphene_point3d_t)* _cretval;
    _cretval = graphene_point3d_zero();
    auto _retval = _cretval ? new Point3D(cast(void*)_cretval, false) : null;
    return _retval;
  }
}
