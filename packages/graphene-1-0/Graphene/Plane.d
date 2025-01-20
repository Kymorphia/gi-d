module Graphene.Plane;

import GLib.Boxed;
import Gid.gid;
import Graphene.Matrix;
import Graphene.Point3D;
import Graphene.Types;
import Graphene.Vec3;
import Graphene.Vec4;
import Graphene.c.functions;
import Graphene.c.types;

/**
 * A 2D plane that extends infinitely in a 3D volume.
 * The contents of the `graphene_plane_t` are private, and should not be
 * modified directly.
 */
class Plane : Boxed
{

  this()
  {
    super(safeMalloc(graphene_plane_t.sizeof), true);
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
    return graphene_plane_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Allocates a new #graphene_plane_t structure.
   * The contents of the returned structure are undefined.
   * Returns: the newly allocated #graphene_plane_t.
   *   Use [Graphene.Plane.free] to free the resources allocated by
   *   this function
   */
  static Plane alloc()
  {
    graphene_plane_t* _cretval;
    _cretval = graphene_plane_alloc();
    auto _retval = _cretval ? new Plane(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Computes the distance of point from a #graphene_plane_t.
   * Params:
   *   point = a #graphene_point3d_t
   * Returns: the distance of the given #graphene_point3d_t from the plane
   */
  float distance(Point3D point)
  {
    float _retval;
    _retval = graphene_plane_distance(cast(graphene_plane_t*)cPtr, point ? cast(graphene_point3d_t*)point.cPtr(false) : null);
    return _retval;
  }

  /**
   * Checks whether the two given #graphene_plane_t are equal.
   * Params:
   *   b = a #graphene_plane_t
   * Returns: `true` if the given planes are equal
   */
  bool equal(Plane b)
  {
    bool _retval;
    _retval = graphene_plane_equal(cast(graphene_plane_t*)cPtr, b ? cast(graphene_plane_t*)b.cPtr(false) : null);
    return _retval;
  }

  /**
   * Retrieves the distance along the normal vector of the
   * given #graphene_plane_t from the origin.
   * Returns: the constant value of the plane
   */
  float getConstant()
  {
    float _retval;
    _retval = graphene_plane_get_constant(cast(graphene_plane_t*)cPtr);
    return _retval;
  }

  /**
   * Retrieves the normal vector pointing towards the origin of the
   * given #graphene_plane_t.
   * Params:
   *   normal = return location for the normal vector
   */
  void getNormal(out Vec3 normal)
  {
    graphene_vec3_t _normal;
    graphene_plane_get_normal(cast(graphene_plane_t*)cPtr, &_normal);
    normal = new Vec3(cast(void*)&_normal, false);
  }

  /**
   * Initializes the given #graphene_plane_t using the given normal vector
   * and constant values.
   * Params:
   *   normal = a unit length normal vector defining the plane
   *     pointing towards the origin; if unset, we use the X axis by default
   *   constant = the distance from the origin to the plane along the
   *     normal vector; the sign determines the half-space occupied by the
   *     plane
   * Returns: the initialized plane
   */
  Plane init_(Vec3 normal, float constant)
  {
    graphene_plane_t* _cretval;
    _cretval = graphene_plane_init(cast(graphene_plane_t*)cPtr, normal ? cast(graphene_vec3_t*)normal.cPtr(false) : null, constant);
    auto _retval = _cretval ? new Plane(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Initializes the given #graphene_plane_t using the normal
   * vector and constant of another #graphene_plane_t.
   * Params:
   *   src = a #graphene_plane_t
   * Returns: the initialized plane
   */
  Plane initFromPlane(Plane src)
  {
    graphene_plane_t* _cretval;
    _cretval = graphene_plane_init_from_plane(cast(graphene_plane_t*)cPtr, src ? cast(graphene_plane_t*)src.cPtr(false) : null);
    auto _retval = _cretval ? new Plane(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Initializes the given #graphene_plane_t using the given normal vector
   * and an arbitrary co-planar point.
   * Params:
   *   normal = a normal vector defining the plane pointing towards the origin
   *   point = a #graphene_point3d_t
   * Returns: the initialized plane
   */
  Plane initFromPoint(Vec3 normal, Point3D point)
  {
    graphene_plane_t* _cretval;
    _cretval = graphene_plane_init_from_point(cast(graphene_plane_t*)cPtr, normal ? cast(graphene_vec3_t*)normal.cPtr(false) : null, point ? cast(graphene_point3d_t*)point.cPtr(false) : null);
    auto _retval = _cretval ? new Plane(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Initializes the given #graphene_plane_t using the 3 provided co-planar
   * points.
   * The winding order is counter-clockwise, and determines which direction
   * the normal vector will point.
   * Params:
   *   a = a #graphene_point3d_t
   *   b = a #graphene_point3d_t
   *   c = a #graphene_point3d_t
   * Returns: the initialized plane
   */
  Plane initFromPoints(Point3D a, Point3D b, Point3D c)
  {
    graphene_plane_t* _cretval;
    _cretval = graphene_plane_init_from_points(cast(graphene_plane_t*)cPtr, a ? cast(graphene_point3d_t*)a.cPtr(false) : null, b ? cast(graphene_point3d_t*)b.cPtr(false) : null, c ? cast(graphene_point3d_t*)c.cPtr(false) : null);
    auto _retval = _cretval ? new Plane(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Initializes the given #graphene_plane_t using the components of
   * the given #graphene_vec4_t vector.
   * Params:
   *   src = a #graphene_vec4_t containing the normal vector in its first
   *     three components, and the distance in its fourth component
   * Returns: the initialized plane
   */
  Plane initFromVec4(Vec4 src)
  {
    graphene_plane_t* _cretval;
    _cretval = graphene_plane_init_from_vec4(cast(graphene_plane_t*)cPtr, src ? cast(graphene_vec4_t*)src.cPtr(false) : null);
    auto _retval = _cretval ? new Plane(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Negates the normal vector and constant of a #graphene_plane_t, effectively
   * mirroring the plane across the origin.
   * Params:
   *   res = return location for the negated plane
   */
  void negate(out Plane res)
  {
    graphene_plane_t _res;
    graphene_plane_negate(cast(graphene_plane_t*)cPtr, &_res);
    res = new Plane(cast(void*)&_res, false);
  }

  /**
   * Normalizes the vector of the given #graphene_plane_t,
   * and adjusts the constant accordingly.
   * Params:
   *   res = return location for the normalized plane
   */
  void normalize(out Plane res)
  {
    graphene_plane_t _res;
    graphene_plane_normalize(cast(graphene_plane_t*)cPtr, &_res);
    res = new Plane(cast(void*)&_res, false);
  }

  /**
   * Transforms a #graphene_plane_t p using the given matrix
   * and normal_matrix.
   * If normal_matrix is %NULL, a transformation matrix for the plane
   * normal will be computed from matrix. If you are transforming
   * multiple planes using the same matrix it's recommended to compute
   * the normal matrix beforehand to avoid incurring in the cost of
   * recomputing it every time.
   * Params:
   *   matrix = a #graphene_matrix_t
   *   normalMatrix = a #graphene_matrix_t
   *   res = the transformed plane
   */
  void transform(Matrix matrix, Matrix normalMatrix, out Plane res)
  {
    graphene_plane_t _res;
    graphene_plane_transform(cast(graphene_plane_t*)cPtr, matrix ? cast(graphene_matrix_t*)matrix.cPtr(false) : null, normalMatrix ? cast(graphene_matrix_t*)normalMatrix.cPtr(false) : null, &_res);
    res = new Plane(cast(void*)&_res, false);
  }
}
