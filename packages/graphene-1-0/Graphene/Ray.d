module Graphene.Ray;

import GLib.Boxed;
import Gid.gid;
import Graphene.Box;
import Graphene.Plane;
import Graphene.Point3D;
import Graphene.Sphere;
import Graphene.Triangle;
import Graphene.Types;
import Graphene.Vec3;
import Graphene.c.functions;
import Graphene.c.types;

/**
 * A ray emitted from an origin in a given direction.
 * The contents of the `graphene_ray_t` structure are private, and should not
 * be modified directly.
 */
class Ray : Boxed
{

  this()
  {
    super(safeMalloc(graphene_ray_t.sizeof), true);
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
    return graphene_ray_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Allocates a new #graphene_ray_t structure.
   * The contents of the returned structure are undefined.
   * Returns: the newly allocated #graphene_ray_t.
   *   Use [Graphene.Ray.free] to free the resources allocated by
   *   this function
   */
  static Ray alloc()
  {
    graphene_ray_t* _cretval;
    _cretval = graphene_ray_alloc();
    auto _retval = _cretval ? new Ray(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Checks whether the two given #graphene_ray_t are equal.
   * Params:
   *   b = a #graphene_ray_t
   * Returns: `true` if the given rays are equal
   */
  bool equal(Ray b)
  {
    bool _retval;
    _retval = graphene_ray_equal(cast(graphene_ray_t*)cPtr, b ? cast(graphene_ray_t*)b.cPtr(false) : null);
    return _retval;
  }

  /**
   * Computes the point on the given #graphene_ray_t that is closest to the
   * given point p.
   * Params:
   *   p = a #graphene_point3d_t
   *   res = return location for the closest point3d
   */
  void getClosestPointToPoint(Point3D p, out Point3D res)
  {
    graphene_point3d_t _res;
    graphene_ray_get_closest_point_to_point(cast(graphene_ray_t*)cPtr, p ? cast(graphene_point3d_t*)p.cPtr(false) : null, &_res);
    res = new Point3D(cast(void*)&_res, false);
  }

  /**
   * Retrieves the direction of the given #graphene_ray_t.
   * Params:
   *   direction = return location for the direction
   */
  void getDirection(out Vec3 direction)
  {
    graphene_vec3_t _direction;
    graphene_ray_get_direction(cast(graphene_ray_t*)cPtr, &_direction);
    direction = new Vec3(cast(void*)&_direction, false);
  }

  /**
   * Computes the distance of the origin of the given #graphene_ray_t from the
   * given plane.
   * If the ray does not intersect the plane, this function returns `INFINITY`.
   * Params:
   *   p = a #graphene_plane_t
   * Returns: the distance of the origin of the ray from the plane
   */
  float getDistanceToPlane(Plane p)
  {
    float _retval;
    _retval = graphene_ray_get_distance_to_plane(cast(graphene_ray_t*)cPtr, p ? cast(graphene_plane_t*)p.cPtr(false) : null);
    return _retval;
  }

  /**
   * Computes the distance of the closest approach between the
   * given #graphene_ray_t r and the point p.
   * The closest approach to a ray from a point is the distance
   * between the point and the projection of the point on the
   * ray itself.
   * Params:
   *   p = a #graphene_point3d_t
   * Returns: the distance of the point
   */
  float getDistanceToPoint(Point3D p)
  {
    float _retval;
    _retval = graphene_ray_get_distance_to_point(cast(graphene_ray_t*)cPtr, p ? cast(graphene_point3d_t*)p.cPtr(false) : null);
    return _retval;
  }

  /**
   * Retrieves the origin of the given #graphene_ray_t.
   * Params:
   *   origin = return location for the origin
   */
  void getOrigin(out Point3D origin)
  {
    graphene_point3d_t _origin;
    graphene_ray_get_origin(cast(graphene_ray_t*)cPtr, &_origin);
    origin = new Point3D(cast(void*)&_origin, false);
  }

  /**
   * Retrieves the coordinates of a point at the distance t along the
   * given #graphene_ray_t.
   * Params:
   *   t = the distance along the ray
   *   position = return location for the position
   */
  void getPositionAt(float t, out Point3D position)
  {
    graphene_point3d_t _position;
    graphene_ray_get_position_at(cast(graphene_ray_t*)cPtr, t, &_position);
    position = new Point3D(cast(void*)&_position, false);
  }

  /**
   * Initializes the given #graphene_ray_t using the given origin
   * and direction values.
   * Params:
   *   origin = the origin of the ray
   *   direction = the direction vector
   * Returns: the initialized ray
   */
  Ray init_(Point3D origin, Vec3 direction)
  {
    graphene_ray_t* _cretval;
    _cretval = graphene_ray_init(cast(graphene_ray_t*)cPtr, origin ? cast(graphene_point3d_t*)origin.cPtr(false) : null, direction ? cast(graphene_vec3_t*)direction.cPtr(false) : null);
    auto _retval = _cretval ? new Ray(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Initializes the given #graphene_ray_t using the origin and direction
   * values of another #graphene_ray_t.
   * Params:
   *   src = a #graphene_ray_t
   * Returns: the initialized ray
   */
  Ray initFromRay(Ray src)
  {
    graphene_ray_t* _cretval;
    _cretval = graphene_ray_init_from_ray(cast(graphene_ray_t*)cPtr, src ? cast(graphene_ray_t*)src.cPtr(false) : null);
    auto _retval = _cretval ? new Ray(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Initializes the given #graphene_ray_t using the given vectors.
   * Params:
   *   origin = a #graphene_vec3_t
   *   direction = a #graphene_vec3_t
   * Returns: the initialized ray
   */
  Ray initFromVec3(Vec3 origin, Vec3 direction)
  {
    graphene_ray_t* _cretval;
    _cretval = graphene_ray_init_from_vec3(cast(graphene_ray_t*)cPtr, origin ? cast(graphene_vec3_t*)origin.cPtr(false) : null, direction ? cast(graphene_vec3_t*)direction.cPtr(false) : null);
    auto _retval = _cretval ? new Ray(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Intersects the given #graphene_ray_t r with the given
   * #graphene_box_t b.
   * Params:
   *   b = a #graphene_box_t
   *   tOut = the distance of the point on the ray that intersects the box
   * Returns: the type of intersection
   */
  RayIntersectionKind intersectBox(Box b, out float tOut)
  {
    graphene_ray_intersection_kind_t _cretval;
    _cretval = graphene_ray_intersect_box(cast(graphene_ray_t*)cPtr, b ? cast(graphene_box_t*)b.cPtr(false) : null, cast(float*)&tOut);
    RayIntersectionKind _retval = cast(RayIntersectionKind)_cretval;
    return _retval;
  }

  /**
   * Intersects the given #graphene_ray_t r with the given
   * #graphene_sphere_t s.
   * Params:
   *   s = a #graphene_sphere_t
   *   tOut = the distance of the point on the ray that intersects the sphere
   * Returns: the type of intersection
   */
  RayIntersectionKind intersectSphere(Sphere s, out float tOut)
  {
    graphene_ray_intersection_kind_t _cretval;
    _cretval = graphene_ray_intersect_sphere(cast(graphene_ray_t*)cPtr, s ? cast(graphene_sphere_t*)s.cPtr(false) : null, cast(float*)&tOut);
    RayIntersectionKind _retval = cast(RayIntersectionKind)_cretval;
    return _retval;
  }

  /**
   * Intersects the given #graphene_ray_t r with the given
   * #graphene_triangle_t t.
   * Params:
   *   t = a #graphene_triangle_t
   *   tOut = the distance of the point on the ray that intersects the triangle
   * Returns: the type of intersection
   */
  RayIntersectionKind intersectTriangle(Triangle t, out float tOut)
  {
    graphene_ray_intersection_kind_t _cretval;
    _cretval = graphene_ray_intersect_triangle(cast(graphene_ray_t*)cPtr, t ? cast(graphene_triangle_t*)t.cPtr(false) : null, cast(float*)&tOut);
    RayIntersectionKind _retval = cast(RayIntersectionKind)_cretval;
    return _retval;
  }

  /**
   * Checks whether the given #graphene_ray_t r intersects the
   * given #graphene_box_t b.
   * See also: [Graphene.Ray.intersectBox]
   * Params:
   *   b = a #graphene_box_t
   * Returns: `true` if the ray intersects the box
   */
  bool intersectsBox(Box b)
  {
    bool _retval;
    _retval = graphene_ray_intersects_box(cast(graphene_ray_t*)cPtr, b ? cast(graphene_box_t*)b.cPtr(false) : null);
    return _retval;
  }

  /**
   * Checks if the given #graphene_ray_t r intersects the
   * given #graphene_sphere_t s.
   * See also: [Graphene.Ray.intersectSphere]
   * Params:
   *   s = a #graphene_sphere_t
   * Returns: `true` if the ray intersects the sphere
   */
  bool intersectsSphere(Sphere s)
  {
    bool _retval;
    _retval = graphene_ray_intersects_sphere(cast(graphene_ray_t*)cPtr, s ? cast(graphene_sphere_t*)s.cPtr(false) : null);
    return _retval;
  }

  /**
   * Checks whether the given #graphene_ray_t r intersects the
   * given #graphene_triangle_t b.
   * See also: [Graphene.Ray.intersectTriangle]
   * Params:
   *   t = a #graphene_triangle_t
   * Returns: `true` if the ray intersects the triangle
   */
  bool intersectsTriangle(Triangle t)
  {
    bool _retval;
    _retval = graphene_ray_intersects_triangle(cast(graphene_ray_t*)cPtr, t ? cast(graphene_triangle_t*)t.cPtr(false) : null);
    return _retval;
  }
}
