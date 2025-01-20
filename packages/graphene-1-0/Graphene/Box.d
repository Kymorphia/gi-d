module Graphene.Box;

import GLib.Boxed;
import Gid.gid;
import Graphene.Point3D;
import Graphene.Sphere;
import Graphene.Types;
import Graphene.Vec3;
import Graphene.c.functions;
import Graphene.c.types;

/**
 * A 3D box, described as the volume between a minimum and
 * a maximum vertices.
 */
class Box : Boxed
{

  this()
  {
    super(safeMalloc(graphene_box_t.sizeof), true);
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
    return graphene_box_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Allocates a new #graphene_box_t.
   * The contents of the returned structure are undefined.
   * Returns: the newly allocated #graphene_box_t structure.
   *   Use [Graphene.Box.free] to free the resources allocated by this function
   */
  static Box alloc()
  {
    graphene_box_t* _cretval;
    _cretval = graphene_box_alloc();
    auto _retval = _cretval ? new Box(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Checks whether the #graphene_box_t a contains the given
   * #graphene_box_t b.
   * Params:
   *   b = a #graphene_box_t
   * Returns: `true` if the box is contained in the given box
   */
  bool containsBox(Box b)
  {
    bool _retval;
    _retval = graphene_box_contains_box(cast(graphene_box_t*)cPtr, b ? cast(graphene_box_t*)b.cPtr(false) : null);
    return _retval;
  }

  /**
   * Checks whether box contains the given point.
   * Params:
   *   point = the coordinates to check
   * Returns: `true` if the point is contained in the given box
   */
  bool containsPoint(Point3D point)
  {
    bool _retval;
    _retval = graphene_box_contains_point(cast(graphene_box_t*)cPtr, point ? cast(graphene_point3d_t*)point.cPtr(false) : null);
    return _retval;
  }

  /**
   * Checks whether the two given boxes are equal.
   * Params:
   *   b = a #graphene_box_t
   * Returns: `true` if the boxes are equal
   */
  bool equal(Box b)
  {
    bool _retval;
    _retval = graphene_box_equal(cast(graphene_box_t*)cPtr, b ? cast(graphene_box_t*)b.cPtr(false) : null);
    return _retval;
  }

  /**
   * Expands the dimensions of box to include the coordinates at point.
   * Params:
   *   point = the coordinates of the point to include
   *   res = return location for the expanded box
   */
  void expand(Point3D point, out Box res)
  {
    graphene_box_t _res;
    graphene_box_expand(cast(graphene_box_t*)cPtr, point ? cast(graphene_point3d_t*)point.cPtr(false) : null, &_res);
    res = new Box(cast(void*)&_res, false);
  }

  /**
   * Expands the dimensions of box by the given scalar value.
   * If scalar is positive, the #graphene_box_t will grow; if scalar is
   * negative, the #graphene_box_t will shrink.
   * Params:
   *   scalar = a scalar value
   *   res = return location for the expanded box
   */
  void expandScalar(float scalar, out Box res)
  {
    graphene_box_t _res;
    graphene_box_expand_scalar(cast(graphene_box_t*)cPtr, scalar, &_res);
    res = new Box(cast(void*)&_res, false);
  }

  /**
   * Expands the dimensions of box to include the coordinates of the
   * given vector.
   * Params:
   *   vec = the coordinates of the point to include, as a #graphene_vec3_t
   *   res = return location for the expanded box
   */
  void expandVec3(Vec3 vec, out Box res)
  {
    graphene_box_t _res;
    graphene_box_expand_vec3(cast(graphene_box_t*)cPtr, vec ? cast(graphene_vec3_t*)vec.cPtr(false) : null, &_res);
    res = new Box(cast(void*)&_res, false);
  }

  /**
   * Computes the bounding #graphene_sphere_t capable of containing the given
   * #graphene_box_t.
   * Params:
   *   sphere = return location for the bounding sphere
   */
  void getBoundingSphere(out Sphere sphere)
  {
    graphene_sphere_t _sphere;
    graphene_box_get_bounding_sphere(cast(graphene_box_t*)cPtr, &_sphere);
    sphere = new Sphere(cast(void*)&_sphere, false);
  }

  /**
   * Retrieves the coordinates of the center of a #graphene_box_t.
   * Params:
   *   center = return location for the coordinates of
   *     the center
   */
  void getCenter(out Point3D center)
  {
    graphene_point3d_t _center;
    graphene_box_get_center(cast(graphene_box_t*)cPtr, &_center);
    center = new Point3D(cast(void*)&_center, false);
  }

  /**
   * Retrieves the size of the box on the Z axis.
   * Returns: the depth of the box
   */
  float getDepth()
  {
    float _retval;
    _retval = graphene_box_get_depth(cast(graphene_box_t*)cPtr);
    return _retval;
  }

  /**
   * Retrieves the size of the box on the Y axis.
   * Returns: the height of the box
   */
  float getHeight()
  {
    float _retval;
    _retval = graphene_box_get_height(cast(graphene_box_t*)cPtr);
    return _retval;
  }

  /**
   * Retrieves the coordinates of the maximum point of the given
   * #graphene_box_t.
   * Params:
   *   max = return location for the maximum point
   */
  void getMax(out Point3D max)
  {
    graphene_point3d_t _max;
    graphene_box_get_max(cast(graphene_box_t*)cPtr, &_max);
    max = new Point3D(cast(void*)&_max, false);
  }

  /**
   * Retrieves the coordinates of the minimum point of the given
   * #graphene_box_t.
   * Params:
   *   min = return location for the minimum point
   */
  void getMin(out Point3D min)
  {
    graphene_point3d_t _min;
    graphene_box_get_min(cast(graphene_box_t*)cPtr, &_min);
    min = new Point3D(cast(void*)&_min, false);
  }

  /**
   * Retrieves the size of the box on all three axes, and stores
   * it into the given size vector.
   * Params:
   *   size = return location for the size
   */
  void getSize(out Vec3 size)
  {
    graphene_vec3_t _size;
    graphene_box_get_size(cast(graphene_box_t*)cPtr, &_size);
    size = new Vec3(cast(void*)&_size, false);
  }

  /**
   * Retrieves the size of the box on the X axis.
   * Returns: the width of the box
   */
  float getWidth()
  {
    float _retval;
    _retval = graphene_box_get_width(cast(graphene_box_t*)cPtr);
    return _retval;
  }

  /**
   * Initializes the given #graphene_box_t with two vertices.
   * Params:
   *   min = the coordinates of the minimum vertex
   *   max = the coordinates of the maximum vertex
   * Returns: the initialized #graphene_box_t
   */
  Box init_(Point3D min, Point3D max)
  {
    graphene_box_t* _cretval;
    _cretval = graphene_box_init(cast(graphene_box_t*)cPtr, min ? cast(graphene_point3d_t*)min.cPtr(false) : null, max ? cast(graphene_point3d_t*)max.cPtr(false) : null);
    auto _retval = _cretval ? new Box(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Initializes the given #graphene_box_t with the vertices of
   * another #graphene_box_t.
   * Params:
   *   src = a #graphene_box_t
   * Returns: the initialized #graphene_box_t
   */
  Box initFromBox(Box src)
  {
    graphene_box_t* _cretval;
    _cretval = graphene_box_init_from_box(cast(graphene_box_t*)cPtr, src ? cast(graphene_box_t*)src.cPtr(false) : null);
    auto _retval = _cretval ? new Box(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Initializes the given #graphene_box_t with the given array
   * of vertices.
   * If n_points is 0, the returned box is initialized with
   * [Graphene.Box.empty].
   * Params:
   *   points = an array of #graphene_point3d_t
   * Returns: the initialized #graphene_box_t
   */
  Box initFromPoints(Point3D[] points)
  {
    graphene_box_t* _cretval;
    uint _nPoints;
    if (points)
      _nPoints = cast(uint)points.length;

    graphene_point3d_t[] _tmppoints;
    foreach (obj; points)
      _tmppoints ~= *cast(graphene_point3d_t*)obj.cPtr;
    const(graphene_point3d_t)* _points = _tmppoints.ptr;
    _cretval = graphene_box_init_from_points(cast(graphene_box_t*)cPtr, _nPoints, _points);
    auto _retval = _cretval ? new Box(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Initializes the given #graphene_box_t with two vertices
   * stored inside #graphene_vec3_t.
   * Params:
   *   min = the coordinates of the minimum vertex
   *   max = the coordinates of the maximum vertex
   * Returns: the initialized #graphene_box_t
   */
  Box initFromVec3(Vec3 min, Vec3 max)
  {
    graphene_box_t* _cretval;
    _cretval = graphene_box_init_from_vec3(cast(graphene_box_t*)cPtr, min ? cast(graphene_vec3_t*)min.cPtr(false) : null, max ? cast(graphene_vec3_t*)max.cPtr(false) : null);
    auto _retval = _cretval ? new Box(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Initializes the given #graphene_box_t with the given array
   * of vertices.
   * If n_vectors is 0, the returned box is initialized with
   * [Graphene.Box.empty].
   * Params:
   *   vectors = an array of #graphene_vec3_t
   * Returns: the initialized #graphene_box_t
   */
  Box initFromVectors(Vec3[] vectors)
  {
    graphene_box_t* _cretval;
    uint _nVectors;
    if (vectors)
      _nVectors = cast(uint)vectors.length;

    graphene_vec3_t[] _tmpvectors;
    foreach (obj; vectors)
      _tmpvectors ~= *cast(graphene_vec3_t*)obj.cPtr;
    const(graphene_vec3_t)* _vectors = _tmpvectors.ptr;
    _cretval = graphene_box_init_from_vectors(cast(graphene_box_t*)cPtr, _nVectors, _vectors);
    auto _retval = _cretval ? new Box(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Intersects the two given #graphene_box_t.
   * If the two boxes do not intersect, res will contain a degenerate box
   * initialized with [Graphene.Box.empty].
   * Params:
   *   b = a #graphene_box_t
   *   res = return location for the result
   * Returns: true if the two boxes intersect
   */
  bool intersection(Box b, out Box res)
  {
    bool _retval;
    graphene_box_t _res;
    _retval = graphene_box_intersection(cast(graphene_box_t*)cPtr, b ? cast(graphene_box_t*)b.cPtr(false) : null, &_res);
    res = new Box(cast(void*)&_res, false);
    return _retval;
  }

  /**
   * Unions the two given #graphene_box_t.
   * Params:
   *   b = the box to union to a
   *   res = return location for the result
   */
  void union_(Box b, out Box res)
  {
    graphene_box_t _res;
    graphene_box_union(cast(graphene_box_t*)cPtr, b ? cast(graphene_box_t*)b.cPtr(false) : null, &_res);
    res = new Box(cast(void*)&_res, false);
  }

  /**
   * A degenerate #graphene_box_t that can only be expanded.
   * The returned value is owned by Graphene and should not be modified or freed.
   * Returns: a #graphene_box_t
   */
  static Box empty()
  {
    const(graphene_box_t)* _cretval;
    _cretval = graphene_box_empty();
    auto _retval = _cretval ? new Box(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * A degenerate #graphene_box_t that cannot be expanded.
   * The returned value is owned by Graphene and should not be modified or freed.
   * Returns: a #graphene_box_t
   */
  static Box infinite()
  {
    const(graphene_box_t)* _cretval;
    _cretval = graphene_box_infinite();
    auto _retval = _cretval ? new Box(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * A #graphene_box_t with the minimum vertex set at $(LPAREN)-1, -1, -1$(RPAREN) and the
   * maximum vertex set at $(LPAREN)0, 0, 0$(RPAREN).
   * The returned value is owned by Graphene and should not be modified or freed.
   * Returns: a #graphene_box_t
   */
  static Box minusOne()
  {
    const(graphene_box_t)* _cretval;
    _cretval = graphene_box_minus_one();
    auto _retval = _cretval ? new Box(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * A #graphene_box_t with the minimum vertex set at $(LPAREN)0, 0, 0$(RPAREN) and the
   * maximum vertex set at $(LPAREN)1, 1, 1$(RPAREN).
   * The returned value is owned by Graphene and should not be modified or freed.
   * Returns: a #graphene_box_t
   */
  static Box one()
  {
    const(graphene_box_t)* _cretval;
    _cretval = graphene_box_one();
    auto _retval = _cretval ? new Box(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * A #graphene_box_t with the minimum vertex set at $(LPAREN)-1, -1, -1$(RPAREN) and the
   * maximum vertex set at $(LPAREN)1, 1, 1$(RPAREN).
   * The returned value is owned by Graphene and should not be modified or freed.
   * Returns: a #graphene_box_t
   */
  static Box oneMinusOne()
  {
    const(graphene_box_t)* _cretval;
    _cretval = graphene_box_one_minus_one();
    auto _retval = _cretval ? new Box(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * A #graphene_box_t with both the minimum and maximum vertices set at $(LPAREN)0, 0, 0$(RPAREN).
   * The returned value is owned by Graphene and should not be modified or freed.
   * Returns: a #graphene_box_t
   */
  static Box zero()
  {
    const(graphene_box_t)* _cretval;
    _cretval = graphene_box_zero();
    auto _retval = _cretval ? new Box(cast(void*)_cretval, false) : null;
    return _retval;
  }
}
