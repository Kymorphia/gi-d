module Graphene.Sphere;

import GLib.Boxed;
import Gid.gid;
import Graphene.Box;
import Graphene.Point3D;
import Graphene.Types;
import Graphene.Vec3;
import Graphene.c.functions;
import Graphene.c.types;

/**
 * A sphere, represented by its center and radius.
 */
class Sphere : Boxed
{

  this()
  {
    super(safeMalloc(graphene_sphere_t.sizeof), true);
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
    return graphene_sphere_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Allocates a new #graphene_sphere_t.
   * The contents of the newly allocated structure are undefined.
   * Returns: the newly allocated #graphene_sphere_t. Use
   *   [Graphene.Sphere.free] to free the resources allocated by this function
   */
  static Sphere alloc()
  {
    graphene_sphere_t* _cretval;
    _cretval = graphene_sphere_alloc();
    auto _retval = _cretval ? new Sphere(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Checks whether the given point is contained in the volume
   * of a #graphene_sphere_t.
   * Params:
   *   point = a #graphene_point3d_t
   * Returns: `true` if the sphere contains the point
   */
  bool containsPoint(Point3D point)
  {
    bool _retval;
    _retval = graphene_sphere_contains_point(cast(graphene_sphere_t*)cPtr, point ? cast(graphene_point3d_t*)point.cPtr(false) : null);
    return _retval;
  }

  /**
   * Computes the distance of the given point from the surface of
   * a #graphene_sphere_t.
   * Params:
   *   point = a #graphene_point3d_t
   * Returns: the distance of the point
   */
  float distance(Point3D point)
  {
    float _retval;
    _retval = graphene_sphere_distance(cast(graphene_sphere_t*)cPtr, point ? cast(graphene_point3d_t*)point.cPtr(false) : null);
    return _retval;
  }

  /**
   * Checks whether two #graphene_sphere_t are equal.
   * Params:
   *   b = a #graphene_sphere_t
   * Returns: `true` if the spheres are equal
   */
  bool equal(Sphere b)
  {
    bool _retval;
    _retval = graphene_sphere_equal(cast(graphene_sphere_t*)cPtr, b ? cast(graphene_sphere_t*)b.cPtr(false) : null);
    return _retval;
  }

  /**
   * Computes the bounding box capable of containing the
   * given #graphene_sphere_t.
   * Params:
   *   box = return location for the bounding box
   */
  void getBoundingBox(out Box box)
  {
    graphene_box_t _box;
    graphene_sphere_get_bounding_box(cast(graphene_sphere_t*)cPtr, &_box);
    box = new Box(cast(void*)&_box, false);
  }

  /**
   * Retrieves the coordinates of the center of a #graphene_sphere_t.
   * Params:
   *   center = return location for the coordinates of
   *     the center
   */
  void getCenter(out Point3D center)
  {
    graphene_point3d_t _center;
    graphene_sphere_get_center(cast(graphene_sphere_t*)cPtr, &_center);
    center = new Point3D(cast(void*)&_center, false);
  }

  /**
   * Retrieves the radius of a #graphene_sphere_t.
   * Returns:
   */
  float getRadius()
  {
    float _retval;
    _retval = graphene_sphere_get_radius(cast(graphene_sphere_t*)cPtr);
    return _retval;
  }

  /**
   * Initializes the given #graphene_sphere_t with the given center and radius.
   * Params:
   *   center = the coordinates of the center of the sphere, or %NULL
   *     for a center in $(LPAREN)0, 0, 0$(RPAREN)
   *   radius = the radius of the sphere
   * Returns: the initialized #graphene_sphere_t
   */
  Sphere init_(Point3D center, float radius)
  {
    graphene_sphere_t* _cretval;
    _cretval = graphene_sphere_init(cast(graphene_sphere_t*)cPtr, center ? cast(graphene_point3d_t*)center.cPtr(false) : null, radius);
    auto _retval = _cretval ? new Sphere(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Initializes the given #graphene_sphere_t using the given array
   * of 3D coordinates so that the sphere includes them.
   * The center of the sphere can either be specified, or will be center
   * of the 3D volume that encompasses all points.
   * Params:
   *   points = an array of #graphene_point3d_t
   *   center = the center of the sphere
   * Returns: the initialized #graphene_sphere_t
   */
  Sphere initFromPoints(Point3D[] points, Point3D center)
  {
    graphene_sphere_t* _cretval;
    uint _nPoints;
    if (points)
      _nPoints = cast(uint)points.length;

    graphene_point3d_t[] _tmppoints;
    foreach (obj; points)
      _tmppoints ~= *cast(graphene_point3d_t*)obj.cPtr;
    const(graphene_point3d_t)* _points = _tmppoints.ptr;
    _cretval = graphene_sphere_init_from_points(cast(graphene_sphere_t*)cPtr, _nPoints, _points, center ? cast(graphene_point3d_t*)center.cPtr(false) : null);
    auto _retval = _cretval ? new Sphere(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Initializes the given #graphene_sphere_t using the given array
   * of 3D coordinates so that the sphere includes them.
   * The center of the sphere can either be specified, or will be center
   * of the 3D volume that encompasses all vectors.
   * Params:
   *   vectors = an array of #graphene_vec3_t
   *   center = the center of the sphere
   * Returns: the initialized #graphene_sphere_t
   */
  Sphere initFromVectors(Vec3[] vectors, Point3D center)
  {
    graphene_sphere_t* _cretval;
    uint _nVectors;
    if (vectors)
      _nVectors = cast(uint)vectors.length;

    graphene_vec3_t[] _tmpvectors;
    foreach (obj; vectors)
      _tmpvectors ~= *cast(graphene_vec3_t*)obj.cPtr;
    const(graphene_vec3_t)* _vectors = _tmpvectors.ptr;
    _cretval = graphene_sphere_init_from_vectors(cast(graphene_sphere_t*)cPtr, _nVectors, _vectors, center ? cast(graphene_point3d_t*)center.cPtr(false) : null);
    auto _retval = _cretval ? new Sphere(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Checks whether the sphere has a zero radius.
   * Returns: `true` if the sphere is empty
   */
  bool isEmpty()
  {
    bool _retval;
    _retval = graphene_sphere_is_empty(cast(graphene_sphere_t*)cPtr);
    return _retval;
  }

  /**
   * Translates the center of the given #graphene_sphere_t using the point
   * coordinates as the delta of the translation.
   * Params:
   *   point = the coordinates of the translation
   *   res = return location for the translated sphere
   */
  void translate(Point3D point, out Sphere res)
  {
    graphene_sphere_t _res;
    graphene_sphere_translate(cast(graphene_sphere_t*)cPtr, point ? cast(graphene_point3d_t*)point.cPtr(false) : null, &_res);
    res = new Sphere(cast(void*)&_res, false);
  }
}
