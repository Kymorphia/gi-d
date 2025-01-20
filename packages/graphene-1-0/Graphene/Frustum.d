module Graphene.Frustum;

import GLib.Boxed;
import Gid.gid;
import Graphene.Box;
import Graphene.Matrix;
import Graphene.Plane;
import Graphene.Point3D;
import Graphene.Sphere;
import Graphene.Types;
import Graphene.c.functions;
import Graphene.c.types;

/**
 * A 3D volume delimited by 2D clip planes.
 * The contents of the `graphene_frustum_t` are private, and should not be
 * modified directly.
 */
class Frustum : Boxed
{

  this()
  {
    super(safeMalloc(graphene_frustum_t.sizeof), true);
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
    return graphene_frustum_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Allocates a new #graphene_frustum_t structure.
   * The contents of the returned structure are undefined.
   * Returns: the newly allocated #graphene_frustum_t
   *   structure. Use [Graphene.Frustum.free] to free the resources
   *   allocated by this function.
   */
  static Frustum alloc()
  {
    graphene_frustum_t* _cretval;
    _cretval = graphene_frustum_alloc();
    auto _retval = _cretval ? new Frustum(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Checks whether a point is inside the volume defined by the given
   * #graphene_frustum_t.
   * Params:
   *   point = a #graphene_point3d_t
   * Returns: `true` if the point is inside the frustum
   */
  bool containsPoint(Point3D point)
  {
    bool _retval;
    _retval = graphene_frustum_contains_point(cast(graphene_frustum_t*)cPtr, point ? cast(graphene_point3d_t*)point.cPtr(false) : null);
    return _retval;
  }

  /**
   * Checks whether the two given #graphene_frustum_t are equal.
   * Params:
   *   b = a #graphene_frustum_t
   * Returns: `true` if the given frustums are equal
   */
  bool equal(Frustum b)
  {
    bool _retval;
    _retval = graphene_frustum_equal(cast(graphene_frustum_t*)cPtr, b ? cast(graphene_frustum_t*)b.cPtr(false) : null);
    return _retval;
  }

  /**
   * Initializes the given #graphene_frustum_t using the provided
   * clipping planes.
   * Params:
   *   p0 = a clipping plane
   *   p1 = a clipping plane
   *   p2 = a clipping plane
   *   p3 = a clipping plane
   *   p4 = a clipping plane
   *   p5 = a clipping plane
   * Returns: the initialized frustum
   */
  Frustum init_(Plane p0, Plane p1, Plane p2, Plane p3, Plane p4, Plane p5)
  {
    graphene_frustum_t* _cretval;
    _cretval = graphene_frustum_init(cast(graphene_frustum_t*)cPtr, p0 ? cast(graphene_plane_t*)p0.cPtr(false) : null, p1 ? cast(graphene_plane_t*)p1.cPtr(false) : null, p2 ? cast(graphene_plane_t*)p2.cPtr(false) : null, p3 ? cast(graphene_plane_t*)p3.cPtr(false) : null, p4 ? cast(graphene_plane_t*)p4.cPtr(false) : null, p5 ? cast(graphene_plane_t*)p5.cPtr(false) : null);
    auto _retval = _cretval ? new Frustum(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Initializes the given #graphene_frustum_t using the clipping
   * planes of another #graphene_frustum_t.
   * Params:
   *   src = a #graphene_frustum_t
   * Returns: the initialized frustum
   */
  Frustum initFromFrustum(Frustum src)
  {
    graphene_frustum_t* _cretval;
    _cretval = graphene_frustum_init_from_frustum(cast(graphene_frustum_t*)cPtr, src ? cast(graphene_frustum_t*)src.cPtr(false) : null);
    auto _retval = _cretval ? new Frustum(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Initializes a #graphene_frustum_t using the given matrix.
   * Params:
   *   matrix = a #graphene_matrix_t
   * Returns: the initialized frustum
   */
  Frustum initFromMatrix(Matrix matrix)
  {
    graphene_frustum_t* _cretval;
    _cretval = graphene_frustum_init_from_matrix(cast(graphene_frustum_t*)cPtr, matrix ? cast(graphene_matrix_t*)matrix.cPtr(false) : null);
    auto _retval = _cretval ? new Frustum(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Checks whether the given box intersects a plane of
   * a #graphene_frustum_t.
   * Params:
   *   box = a #graphene_box_t
   * Returns: `true` if the box intersects the frustum
   */
  bool intersectsBox(Box box)
  {
    bool _retval;
    _retval = graphene_frustum_intersects_box(cast(graphene_frustum_t*)cPtr, box ? cast(graphene_box_t*)box.cPtr(false) : null);
    return _retval;
  }

  /**
   * Checks whether the given sphere intersects a plane of
   * a #graphene_frustum_t.
   * Params:
   *   sphere = a #graphene_sphere_t
   * Returns: `true` if the sphere intersects the frustum
   */
  bool intersectsSphere(Sphere sphere)
  {
    bool _retval;
    _retval = graphene_frustum_intersects_sphere(cast(graphene_frustum_t*)cPtr, sphere ? cast(graphene_sphere_t*)sphere.cPtr(false) : null);
    return _retval;
  }
}
