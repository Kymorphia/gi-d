module Graphene.Triangle;

import GLib.Boxed;
import Gid.gid;
import Graphene.Box;
import Graphene.Plane;
import Graphene.Point3D;
import Graphene.Types;
import Graphene.Vec2;
import Graphene.Vec3;
import Graphene.c.functions;
import Graphene.c.types;

/**
 * A triangle.
 */
class Triangle : Boxed
{

  this()
  {
    super(safeMalloc(graphene_triangle_t.sizeof), true);
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
    return graphene_triangle_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Allocates a new #graphene_triangle_t.
   * The contents of the returned structure are undefined.
   * Returns: the newly allocated #graphene_triangle_t
   *   structure. Use [Graphene.Triangle.free] to free the resources
   *   allocated by this function
   */
  static Triangle alloc()
  {
    graphene_triangle_t* _cretval;
    _cretval = graphene_triangle_alloc();
    auto _retval = _cretval ? new Triangle(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Checks whether the given triangle t contains the point p.
   * Params:
   *   p = a #graphene_point3d_t
   * Returns: `true` if the point is inside the triangle
   */
  bool containsPoint(Point3D p)
  {
    bool _retval;
    _retval = graphene_triangle_contains_point(cast(graphene_triangle_t*)cPtr, p ? cast(graphene_point3d_t*)p.cPtr(false) : null);
    return _retval;
  }

  /**
   * Checks whether the two given #graphene_triangle_t are equal.
   * Params:
   *   b = a #graphene_triangle_t
   * Returns: `true` if the triangles are equal
   */
  bool equal(Triangle b)
  {
    bool _retval;
    _retval = graphene_triangle_equal(cast(graphene_triangle_t*)cPtr, b ? cast(graphene_triangle_t*)b.cPtr(false) : null);
    return _retval;
  }

  /**
   * Computes the area of the given #graphene_triangle_t.
   * Returns: the area of the triangle
   */
  float getArea()
  {
    float _retval;
    _retval = graphene_triangle_get_area(cast(graphene_triangle_t*)cPtr);
    return _retval;
  }

  /**
   * Computes the [barycentric coordinates](http://en.wikipedia.org/wiki/Barycentric_coordinate_system)
   * of the given point p.
   * The point p must lie on the same plane as the triangle t; if the
   * point is not coplanar, the result of this function is undefined.
   * If we place the origin in the coordinates of the triangle's A point,
   * the barycentric coordinates are `u`, which is on the AC vector; and `v`
   * which is on the AB vector:
   * ![](triangle-barycentric.png)
   * The returned #graphene_vec2_t contains the following values, in order:
   * - `res.x \= u`
   * - `res.y \= v`
   * Params:
   *   p = a #graphene_point3d_t
   *   res = return location for the vector
   *     with the barycentric coordinates
   * Returns: `true` if the barycentric coordinates are valid
   */
  bool getBarycoords(Point3D p, out Vec2 res)
  {
    bool _retval;
    graphene_vec2_t _res;
    _retval = graphene_triangle_get_barycoords(cast(graphene_triangle_t*)cPtr, p ? cast(graphene_point3d_t*)p.cPtr(false) : null, &_res);
    res = new Vec2(cast(void*)&_res, false);
    return _retval;
  }

  /**
   * Computes the bounding box of the given #graphene_triangle_t.
   * Params:
   *   res = return location for the box
   */
  void getBoundingBox(out Box res)
  {
    graphene_box_t _res;
    graphene_triangle_get_bounding_box(cast(graphene_triangle_t*)cPtr, &_res);
    res = new Box(cast(void*)&_res, false);
  }

  /**
   * Computes the coordinates of the midpoint of the given #graphene_triangle_t.
   * The midpoint G is the [centroid](https://en.wikipedia.org/wiki/Centroid#Triangle_centroid)
   * of the triangle, i.e. the intersection of its medians.
   * Params:
   *   res = return location for the coordinates of
   *     the midpoint
   */
  void getMidpoint(out Point3D res)
  {
    graphene_point3d_t _res;
    graphene_triangle_get_midpoint(cast(graphene_triangle_t*)cPtr, &_res);
    res = new Point3D(cast(void*)&_res, false);
  }

  /**
   * Computes the normal vector of the given #graphene_triangle_t.
   * Params:
   *   res = return location for the normal vector
   */
  void getNormal(out Vec3 res)
  {
    graphene_vec3_t _res;
    graphene_triangle_get_normal(cast(graphene_triangle_t*)cPtr, &_res);
    res = new Vec3(cast(void*)&_res, false);
  }

  /**
   * Computes the plane based on the vertices of the given #graphene_triangle_t.
   * Params:
   *   res = return location for the plane
   */
  void getPlane(out Plane res)
  {
    graphene_plane_t _res;
    graphene_triangle_get_plane(cast(graphene_triangle_t*)cPtr, &_res);
    res = new Plane(cast(void*)&_res, false);
  }

  /**
   * Retrieves the three vertices of the given #graphene_triangle_t and returns
   * their coordinates as #graphene_point3d_t.
   * Params:
   *   a = return location for the coordinates
   *     of the first vertex
   *   b = return location for the coordinates
   *     of the second vertex
   *   c = return location for the coordinates
   *     of the third vertex
   */
  void getPoints(out Point3D a, out Point3D b, out Point3D c)
  {
    graphene_point3d_t _a;
    graphene_point3d_t _b;
    graphene_point3d_t _c;
    graphene_triangle_get_points(cast(graphene_triangle_t*)cPtr, &_a, &_b, &_c);
    a = new Point3D(cast(void*)&_a, false);
    b = new Point3D(cast(void*)&_b, false);
    c = new Point3D(cast(void*)&_c, false);
  }

  /**
   * Computes the UV coordinates of the given point p.
   * The point p must lie on the same plane as the triangle t; if the point
   * is not coplanar, the result of this function is undefined. If p is %NULL,
   * the point will be set in $(LPAREN)0, 0, 0$(RPAREN).
   * The UV coordinates will be placed in the res vector:
   * - `res.x \= u`
   * - `res.y \= v`
   * See also: [Graphene.Triangle.getBarycoords]
   * Params:
   *   p = a #graphene_point3d_t
   *   uvA = the UV coordinates of the first point
   *   uvB = the UV coordinates of the second point
   *   uvC = the UV coordinates of the third point
   *   res = a vector containing the UV coordinates
   *     of the given point p
   * Returns: `true` if the coordinates are valid
   */
  bool getUv(Point3D p, Vec2 uvA, Vec2 uvB, Vec2 uvC, out Vec2 res)
  {
    bool _retval;
    graphene_vec2_t _res;
    _retval = graphene_triangle_get_uv(cast(graphene_triangle_t*)cPtr, p ? cast(graphene_point3d_t*)p.cPtr(false) : null, uvA ? cast(graphene_vec2_t*)uvA.cPtr(false) : null, uvB ? cast(graphene_vec2_t*)uvB.cPtr(false) : null, uvC ? cast(graphene_vec2_t*)uvC.cPtr(false) : null, &_res);
    res = new Vec2(cast(void*)&_res, false);
    return _retval;
  }

  /**
   * Retrieves the three vertices of the given #graphene_triangle_t.
   * Params:
   *   a = return location for the first vertex
   *   b = return location for the second vertex
   *   c = return location for the third vertex
   */
  void getVertices(out Vec3 a, out Vec3 b, out Vec3 c)
  {
    graphene_vec3_t _a;
    graphene_vec3_t _b;
    graphene_vec3_t _c;
    graphene_triangle_get_vertices(cast(graphene_triangle_t*)cPtr, &_a, &_b, &_c);
    a = new Vec3(cast(void*)&_a, false);
    b = new Vec3(cast(void*)&_b, false);
    c = new Vec3(cast(void*)&_c, false);
  }

  /**
   * Initializes a #graphene_triangle_t using the three given arrays
   * of floating point values, each representing the coordinates of
   * a point in 3D space.
   * Params:
   *   a = an array of 3 floating point values
   *   b = an array of 3 floating point values
   *   c = an array of 3 floating point values
   * Returns: the initialized #graphene_triangle_t
   */
  Triangle initFromFloat(float[] a, float[] b, float[] c)
  {
    graphene_triangle_t* _cretval;
    assert(!a || a.length == 3);
    auto _a = cast(const(float)*)a.ptr;
    assert(!b || b.length == 3);
    auto _b = cast(const(float)*)b.ptr;
    assert(!c || c.length == 3);
    auto _c = cast(const(float)*)c.ptr;
    _cretval = graphene_triangle_init_from_float(cast(graphene_triangle_t*)cPtr, _a, _b, _c);
    auto _retval = _cretval ? new Triangle(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Initializes a #graphene_triangle_t using the three given 3D points.
   * Params:
   *   a = a #graphene_point3d_t
   *   b = a #graphene_point3d_t
   *   c = a #graphene_point3d_t
   * Returns: the initialized #graphene_triangle_t
   */
  Triangle initFromPoint3d(Point3D a, Point3D b, Point3D c)
  {
    graphene_triangle_t* _cretval;
    _cretval = graphene_triangle_init_from_point3d(cast(graphene_triangle_t*)cPtr, a ? cast(graphene_point3d_t*)a.cPtr(false) : null, b ? cast(graphene_point3d_t*)b.cPtr(false) : null, c ? cast(graphene_point3d_t*)c.cPtr(false) : null);
    auto _retval = _cretval ? new Triangle(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Initializes a #graphene_triangle_t using the three given vectors.
   * Params:
   *   a = a #graphene_vec3_t
   *   b = a #graphene_vec3_t
   *   c = a #graphene_vec3_t
   * Returns: the initialized #graphene_triangle_t
   */
  Triangle initFromVec3(Vec3 a, Vec3 b, Vec3 c)
  {
    graphene_triangle_t* _cretval;
    _cretval = graphene_triangle_init_from_vec3(cast(graphene_triangle_t*)cPtr, a ? cast(graphene_vec3_t*)a.cPtr(false) : null, b ? cast(graphene_vec3_t*)b.cPtr(false) : null, c ? cast(graphene_vec3_t*)c.cPtr(false) : null);
    auto _retval = _cretval ? new Triangle(cast(void*)_cretval, false) : null;
    return _retval;
  }
}
