module Graphene.Matrix;

import GLib.Boxed;
import Gid.gid;
import Graphene.Box;
import Graphene.Euler;
import Graphene.Point;
import Graphene.Point3D;
import Graphene.Quad;
import Graphene.Quaternion;
import Graphene.Ray;
import Graphene.Rect;
import Graphene.Sphere;
import Graphene.Types;
import Graphene.Vec3;
import Graphene.Vec4;
import Graphene.c.functions;
import Graphene.c.types;

/**
 * A structure capable of holding a 4x4 matrix.
 * The contents of the #graphene_matrix_t structure are private and
 * should never be accessed directly.
 */
class Matrix : Boxed
{

  this()
  {
    super(safeMalloc(graphene_matrix_t.sizeof), true);
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
    return graphene_matrix_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Allocates a new #graphene_matrix_t.
   * Returns: the newly allocated matrix
   */
  static Matrix alloc()
  {
    graphene_matrix_t* _cretval;
    _cretval = graphene_matrix_alloc();
    auto _retval = _cretval ? new Matrix(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Decomposes a transformation matrix into its component transformations.
   * The algorithm for decomposing a matrix is taken from the
   * [CSS3 Transforms specification](http://dev.w3.org/csswg/css-transforms/);
   * specifically, the decomposition code is based on the equivalent code
   * published in "Graphics Gems II", edited by Jim Arvo, and
   * [available online](http://web.archive.org/web/20150512160205/http://tog.acm.org/resources/GraphicsGems/gemsii/unmatrix.c).
   * Params:
   *   translate = the translation vector
   *   scale = the scale vector
   *   rotate = the rotation quaternion
   *   shear = the shear vector
   *   perspective = the perspective vector
   * Returns: `true` if the matrix could be decomposed
   */
  bool decompose(out Vec3 translate, out Vec3 scale, out Quaternion rotate, out Vec3 shear, out Vec4 perspective)
  {
    bool _retval;
    graphene_vec3_t _translate;
    graphene_vec3_t _scale;
    graphene_quaternion_t _rotate;
    graphene_vec3_t _shear;
    graphene_vec4_t _perspective;
    _retval = graphene_matrix_decompose(cast(graphene_matrix_t*)cPtr, &_translate, &_scale, &_rotate, &_shear, &_perspective);
    translate = new Vec3(cast(void*)&_translate, false);
    scale = new Vec3(cast(void*)&_scale, false);
    rotate = new Quaternion(cast(void*)&_rotate, false);
    shear = new Vec3(cast(void*)&_shear, false);
    perspective = new Vec4(cast(void*)&_perspective, false);
    return _retval;
  }

  /**
   * Computes the determinant of the given matrix.
   * Returns: the value of the determinant
   */
  float determinant()
  {
    float _retval;
    _retval = graphene_matrix_determinant(cast(graphene_matrix_t*)cPtr);
    return _retval;
  }

  /**
   * Checks whether the two given #graphene_matrix_t matrices are equal.
   * Params:
   *   b = a #graphene_matrix_t
   * Returns: `true` if the two matrices are equal, and `false` otherwise
   */
  bool equal(Matrix b)
  {
    bool _retval;
    _retval = graphene_matrix_equal(cast(graphene_matrix_t*)cPtr, b ? cast(graphene_matrix_t*)b.cPtr(false) : null);
    return _retval;
  }

  /**
   * Checks whether the two given #graphene_matrix_t matrices are
   * byte-by-byte equal.
   * While this function is faster than [Graphene.Matrix.equal], it
   * can also return false negatives, so it should be used in
   * conjuction with either [Graphene.Matrix.equal] or
   * [Graphene.Matrix.near]. For instance:
   * |[<!-- language\="C" -->
   * if $(LPAREN)graphene_matrix_equal_fast $(LPAREN)a, b$(RPAREN)$(RPAREN)
   * {
   * // matrices are definitely the same
   * }
   * else
   * {
   * if $(LPAREN)graphene_matrix_equal $(LPAREN)a, b$(RPAREN)$(RPAREN)
   * // matrices contain the same values within an epsilon of FLT_EPSILON
   * else if $(LPAREN)graphene_matrix_near $(LPAREN)a, b, 0.0001$(RPAREN)$(RPAREN)
   * // matrices contain the same values within an epsilon of 0.0001
   * else
   * // matrices are not equal
   * }
   * ]|
   * Params:
   *   b = a #graphene_matrix_t
   * Returns: `true` if the matrices are equal. and `false` otherwise
   */
  bool equalFast(Matrix b)
  {
    bool _retval;
    _retval = graphene_matrix_equal_fast(cast(graphene_matrix_t*)cPtr, b ? cast(graphene_matrix_t*)b.cPtr(false) : null);
    return _retval;
  }

  /**
   * Retrieves the given row vector at index_ inside a matrix.
   * Params:
   *   index = the index of the row vector, between 0 and 3
   *   res = return location for the #graphene_vec4_t
   *     that is used to store the row vector
   */
  void getRow(uint index, out Vec4 res)
  {
    graphene_vec4_t _res;
    graphene_matrix_get_row(cast(graphene_matrix_t*)cPtr, index, &_res);
    res = new Vec4(cast(void*)&_res, false);
  }

  /**
   * Retrieves the value at the given row and col index.
   * Params:
   *   row = the row index
   *   col = the column index
   * Returns: the value at the given indices
   */
  float getValue(uint row, uint col)
  {
    float _retval;
    _retval = graphene_matrix_get_value(cast(graphene_matrix_t*)cPtr, row, col);
    return _retval;
  }

  /**
   * Retrieves the scaling factor on the X axis in m.
   * Returns: the value of the scaling factor
   */
  float getXScale()
  {
    float _retval;
    _retval = graphene_matrix_get_x_scale(cast(graphene_matrix_t*)cPtr);
    return _retval;
  }

  /**
   * Retrieves the translation component on the X axis from m.
   * Returns: the translation component
   */
  float getXTranslation()
  {
    float _retval;
    _retval = graphene_matrix_get_x_translation(cast(graphene_matrix_t*)cPtr);
    return _retval;
  }

  /**
   * Retrieves the scaling factor on the Y axis in m.
   * Returns: the value of the scaling factor
   */
  float getYScale()
  {
    float _retval;
    _retval = graphene_matrix_get_y_scale(cast(graphene_matrix_t*)cPtr);
    return _retval;
  }

  /**
   * Retrieves the translation component on the Y axis from m.
   * Returns: the translation component
   */
  float getYTranslation()
  {
    float _retval;
    _retval = graphene_matrix_get_y_translation(cast(graphene_matrix_t*)cPtr);
    return _retval;
  }

  /**
   * Retrieves the scaling factor on the Z axis in m.
   * Returns: the value of the scaling factor
   */
  float getZScale()
  {
    float _retval;
    _retval = graphene_matrix_get_z_scale(cast(graphene_matrix_t*)cPtr);
    return _retval;
  }

  /**
   * Retrieves the translation component on the Z axis from m.
   * Returns: the translation component
   */
  float getZTranslation()
  {
    float _retval;
    _retval = graphene_matrix_get_z_translation(cast(graphene_matrix_t*)cPtr);
    return _retval;
  }

  /**
   * Initializes a #graphene_matrix_t from the values of an affine
   * transformation matrix.
   * The arguments map to the following matrix layout:
   * |[<!-- language\="plain" -->
   * ⎛ xx  yx ⎞   ⎛  a   b  0 ⎞
   * ⎜ xy  yy ⎟ \= ⎜  c   d  0 ⎟
   * ⎝ x0  y0 ⎠   ⎝ tx  ty  1 ⎠
   * ]|
   * This function can be used to convert between an affine matrix type
   * from other libraries and a #graphene_matrix_t.
   * Params:
   *   xx = the xx member
   *   yx = the yx member
   *   xy = the xy member
   *   yy = the yy member
   *   x0 = the x0 member
   *   y0 = the y0 member
   * Returns: the initialized matrix
   */
  Matrix initFrom2d(double xx, double yx, double xy, double yy, double x0, double y0)
  {
    graphene_matrix_t* _cretval;
    _cretval = graphene_matrix_init_from_2d(cast(graphene_matrix_t*)cPtr, xx, yx, xy, yy, x0, y0);
    auto _retval = _cretval ? new Matrix(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Initializes a #graphene_matrix_t with the given array of floating
   * point values.
   * Params:
   *   v = an array of at least 16 floating
   *     point values
   * Returns: the initialized matrix
   */
  Matrix initFromFloat(float[] v)
  {
    graphene_matrix_t* _cretval;
    assert(!v || v.length == 16);
    auto _v = cast(const(float)*)v.ptr;
    _cretval = graphene_matrix_init_from_float(cast(graphene_matrix_t*)cPtr, _v);
    auto _retval = _cretval ? new Matrix(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Initializes a #graphene_matrix_t using the values of the
   * given matrix.
   * Params:
   *   src = a #graphene_matrix_t
   * Returns: the initialized matrix
   */
  Matrix initFromMatrix(Matrix src)
  {
    graphene_matrix_t* _cretval;
    _cretval = graphene_matrix_init_from_matrix(cast(graphene_matrix_t*)cPtr, src ? cast(graphene_matrix_t*)src.cPtr(false) : null);
    auto _retval = _cretval ? new Matrix(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Initializes a #graphene_matrix_t with the given four row
   * vectors.
   * Params:
   *   v0 = the first row vector
   *   v1 = the second row vector
   *   v2 = the third row vector
   *   v3 = the fourth row vector
   * Returns: the initialized matrix
   */
  Matrix initFromVec4(Vec4 v0, Vec4 v1, Vec4 v2, Vec4 v3)
  {
    graphene_matrix_t* _cretval;
    _cretval = graphene_matrix_init_from_vec4(cast(graphene_matrix_t*)cPtr, v0 ? cast(graphene_vec4_t*)v0.cPtr(false) : null, v1 ? cast(graphene_vec4_t*)v1.cPtr(false) : null, v2 ? cast(graphene_vec4_t*)v2.cPtr(false) : null, v3 ? cast(graphene_vec4_t*)v3.cPtr(false) : null);
    auto _retval = _cretval ? new Matrix(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Initializes a #graphene_matrix_t compatible with #graphene_frustum_t.
   * See also: [Graphene.Frustum.initFromMatrix]
   * Params:
   *   left = distance of the left clipping plane
   *   right = distance of the right clipping plane
   *   bottom = distance of the bottom clipping plane
   *   top = distance of the top clipping plane
   *   zNear = distance of the near clipping plane
   *   zFar = distance of the far clipping plane
   * Returns: the initialized matrix
   */
  Matrix initFrustum(float left, float right, float bottom, float top, float zNear, float zFar)
  {
    graphene_matrix_t* _cretval;
    _cretval = graphene_matrix_init_frustum(cast(graphene_matrix_t*)cPtr, left, right, bottom, top, zNear, zFar);
    auto _retval = _cretval ? new Matrix(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Initializes a #graphene_matrix_t with the identity matrix.
   * Returns: the initialized matrix
   */
  Matrix initIdentity()
  {
    graphene_matrix_t* _cretval;
    _cretval = graphene_matrix_init_identity(cast(graphene_matrix_t*)cPtr);
    auto _retval = _cretval ? new Matrix(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Initializes a #graphene_matrix_t so that it positions the "camera"
   * at the given eye coordinates towards an object at the center
   * coordinates. The top of the camera is aligned to the direction
   * of the up vector.
   * Before the transform, the camera is assumed to be placed at the
   * origin, looking towards the negative Z axis, with the top side of
   * the camera facing in the direction of the Y axis and the right
   * side in the direction of the X axis.
   * In theory, one could use m to transform a model of such a camera
   * into world-space. However, it is more common to use the inverse of
   * m to transform another object from world coordinates to the view
   * coordinates of the camera. Typically you would then apply the
   * camera projection transform to get from view to screen
   * coordinates.
   * Params:
   *   eye = the vector describing the position to look from
   *   center = the vector describing the position to look at
   *   up = the vector describing the world's upward direction; usually,
   *     this is the [Graphene.Vec3.yAxis] vector
   * Returns: the initialized matrix
   */
  Matrix initLookAt(Vec3 eye, Vec3 center, Vec3 up)
  {
    graphene_matrix_t* _cretval;
    _cretval = graphene_matrix_init_look_at(cast(graphene_matrix_t*)cPtr, eye ? cast(graphene_vec3_t*)eye.cPtr(false) : null, center ? cast(graphene_vec3_t*)center.cPtr(false) : null, up ? cast(graphene_vec3_t*)up.cPtr(false) : null);
    auto _retval = _cretval ? new Matrix(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Initializes a #graphene_matrix_t with an orthographic projection.
   * Params:
   *   left = the left edge of the clipping plane
   *   right = the right edge of the clipping plane
   *   top = the top edge of the clipping plane
   *   bottom = the bottom edge of the clipping plane
   *   zNear = the distance of the near clipping plane
   *   zFar = the distance of the far clipping plane
   * Returns: the initialized matrix
   */
  Matrix initOrtho(float left, float right, float top, float bottom, float zNear, float zFar)
  {
    graphene_matrix_t* _cretval;
    _cretval = graphene_matrix_init_ortho(cast(graphene_matrix_t*)cPtr, left, right, top, bottom, zNear, zFar);
    auto _retval = _cretval ? new Matrix(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Initializes a #graphene_matrix_t with a perspective projection.
   * Params:
   *   fovy = the field of view angle, in degrees
   *   aspect = the aspect value
   *   zNear = the near Z plane
   *   zFar = the far Z plane
   * Returns: the initialized matrix
   */
  Matrix initPerspective(float fovy, float aspect, float zNear, float zFar)
  {
    graphene_matrix_t* _cretval;
    _cretval = graphene_matrix_init_perspective(cast(graphene_matrix_t*)cPtr, fovy, aspect, zNear, zFar);
    auto _retval = _cretval ? new Matrix(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Initializes m to represent a rotation of angle degrees on
   * the axis represented by the axis vector.
   * Params:
   *   angle = the rotation angle, in degrees
   *   axis = the axis vector as a #graphene_vec3_t
   * Returns: the initialized matrix
   */
  Matrix initRotate(float angle, Vec3 axis)
  {
    graphene_matrix_t* _cretval;
    _cretval = graphene_matrix_init_rotate(cast(graphene_matrix_t*)cPtr, angle, axis ? cast(graphene_vec3_t*)axis.cPtr(false) : null);
    auto _retval = _cretval ? new Matrix(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Initializes a #graphene_matrix_t with the given scaling factors.
   * Params:
   *   x = the scale factor on the X axis
   *   y = the scale factor on the Y axis
   *   z = the scale factor on the Z axis
   * Returns: the initialized matrix
   */
  Matrix initScale(float x, float y, float z)
  {
    graphene_matrix_t* _cretval;
    _cretval = graphene_matrix_init_scale(cast(graphene_matrix_t*)cPtr, x, y, z);
    auto _retval = _cretval ? new Matrix(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Initializes a #graphene_matrix_t with a skew transformation
   * with the given factors.
   * Params:
   *   xSkew = skew factor, in radians, on the X axis
   *   ySkew = skew factor, in radians, on the Y axis
   * Returns: the initialized matrix
   */
  Matrix initSkew(float xSkew, float ySkew)
  {
    graphene_matrix_t* _cretval;
    _cretval = graphene_matrix_init_skew(cast(graphene_matrix_t*)cPtr, xSkew, ySkew);
    auto _retval = _cretval ? new Matrix(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Initializes a #graphene_matrix_t with a translation to the
   * given coordinates.
   * Params:
   *   p = the translation coordinates
   * Returns: the initialized matrix
   */
  Matrix initTranslate(Point3D p)
  {
    graphene_matrix_t* _cretval;
    _cretval = graphene_matrix_init_translate(cast(graphene_matrix_t*)cPtr, p ? cast(graphene_point3d_t*)p.cPtr(false) : null);
    auto _retval = _cretval ? new Matrix(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Linearly interpolates the two given #graphene_matrix_t by
   * interpolating the decomposed transformations separately.
   * If either matrix cannot be reduced to their transformations
   * then the interpolation cannot be performed, and this function
   * will return an identity matrix.
   * Params:
   *   b = a #graphene_matrix_t
   *   factor = the linear interpolation factor
   *   res = return location for the
   *     interpolated matrix
   */
  void interpolate(Matrix b, double factor, out Matrix res)
  {
    graphene_matrix_t _res;
    graphene_matrix_interpolate(cast(graphene_matrix_t*)cPtr, b ? cast(graphene_matrix_t*)b.cPtr(false) : null, factor, &_res);
    res = new Matrix(cast(void*)&_res, false);
  }

  /**
   * Inverts the given matrix.
   * Params:
   *   res = return location for the
   *     inverse matrix
   * Returns: `true` if the matrix is invertible
   */
  bool inverse(out Matrix res)
  {
    bool _retval;
    graphene_matrix_t _res;
    _retval = graphene_matrix_inverse(cast(graphene_matrix_t*)cPtr, &_res);
    res = new Matrix(cast(void*)&_res, false);
    return _retval;
  }

  /**
   * Checks whether the given #graphene_matrix_t is compatible with an
   * a 2D affine transformation matrix.
   * Returns: `true` if the matrix is compatible with an affine
   *   transformation matrix
   */
  bool is2d()
  {
    bool _retval;
    _retval = graphene_matrix_is_2d(cast(graphene_matrix_t*)cPtr);
    return _retval;
  }

  /**
   * Checks whether a #graphene_matrix_t has a visible back face.
   * Returns: `true` if the back face of the matrix is visible
   */
  bool isBackfaceVisible()
  {
    bool _retval;
    _retval = graphene_matrix_is_backface_visible(cast(graphene_matrix_t*)cPtr);
    return _retval;
  }

  /**
   * Checks whether the given #graphene_matrix_t is the identity matrix.
   * Returns: `true` if the matrix is the identity matrix
   */
  bool isIdentity()
  {
    bool _retval;
    _retval = graphene_matrix_is_identity(cast(graphene_matrix_t*)cPtr);
    return _retval;
  }

  /**
   * Checks whether a matrix is singular.
   * Returns: `true` if the matrix is singular
   */
  bool isSingular()
  {
    bool _retval;
    _retval = graphene_matrix_is_singular(cast(graphene_matrix_t*)cPtr);
    return _retval;
  }

  /**
   * Multiplies two #graphene_matrix_t.
   * Matrix multiplication is not commutative in general; the order of the factors matters.
   * The product of this multiplication is $(LPAREN)a × b$(RPAREN)
   * Params:
   *   b = a #graphene_matrix_t
   *   res = return location for the matrix
   *     result
   */
  void multiply(Matrix b, out Matrix res)
  {
    graphene_matrix_t _res;
    graphene_matrix_multiply(cast(graphene_matrix_t*)cPtr, b ? cast(graphene_matrix_t*)b.cPtr(false) : null, &_res);
    res = new Matrix(cast(void*)&_res, false);
  }

  /**
   * Compares the two given #graphene_matrix_t matrices and checks
   * whether their values are within the given epsilon of each
   * other.
   * Params:
   *   b = a #graphene_matrix_t
   *   epsilon = the threshold between the two matrices
   * Returns: `true` if the two matrices are near each other, and
   *   `false` otherwise
   */
  bool near(Matrix b, float epsilon)
  {
    bool _retval;
    _retval = graphene_matrix_near(cast(graphene_matrix_t*)cPtr, b ? cast(graphene_matrix_t*)b.cPtr(false) : null, epsilon);
    return _retval;
  }

  /**
   * Normalizes the given #graphene_matrix_t.
   * Params:
   *   res = return location for the normalized matrix
   */
  void normalize(out Matrix res)
  {
    graphene_matrix_t _res;
    graphene_matrix_normalize(cast(graphene_matrix_t*)cPtr, &_res);
    res = new Matrix(cast(void*)&_res, false);
  }

  /**
   * Applies a perspective of depth to the matrix.
   * Params:
   *   depth = the depth of the perspective
   *   res = return location for the
   *     perspective matrix
   */
  void perspective(float depth, out Matrix res)
  {
    graphene_matrix_t _res;
    graphene_matrix_perspective(cast(graphene_matrix_t*)cPtr, depth, &_res);
    res = new Matrix(cast(void*)&_res, false);
  }

  /**
   * Prints the contents of a matrix to the standard error stream.
   * This function is only useful for debugging; there are no guarantees
   * made on the format of the output.
   */
  void print()
  {
    graphene_matrix_print(cast(graphene_matrix_t*)cPtr);
  }

  /**
   * Projects a #graphene_point_t using the matrix m.
   * Params:
   *   p = a #graphene_point_t
   *   res = return location for the projected
   *     point
   */
  void projectPoint(Point p, out Point res)
  {
    graphene_point_t _res;
    graphene_matrix_project_point(cast(graphene_matrix_t*)cPtr, p ? cast(graphene_point_t*)p.cPtr(false) : null, &_res);
    res = new Point(cast(void*)&_res, false);
  }

  /**
   * Projects all corners of a #graphene_rect_t using the given matrix.
   * See also: [Graphene.Matrix.projectPoint]
   * Params:
   *   r = a #graphene_rect_t
   *   res = return location for the projected
   *     rectangle
   */
  void projectRect(Rect r, out Quad res)
  {
    graphene_quad_t _res;
    graphene_matrix_project_rect(cast(graphene_matrix_t*)cPtr, r ? cast(graphene_rect_t*)r.cPtr(false) : null, &_res);
    res = new Quad(cast(void*)&_res, false);
  }

  /**
   * Projects a #graphene_rect_t using the given matrix.
   * The resulting rectangle is the axis aligned bounding rectangle capable
   * of fully containing the projected rectangle.
   * Params:
   *   r = a #graphene_rect_t
   *   res = return location for the projected
   *     rectangle
   */
  void projectRectBounds(Rect r, out Rect res)
  {
    graphene_rect_t _res;
    graphene_matrix_project_rect_bounds(cast(graphene_matrix_t*)cPtr, r ? cast(graphene_rect_t*)r.cPtr(false) : null, &_res);
    res = new Rect(cast(void*)&_res, false);
  }

  /**
   * Adds a rotation transformation to m, using the given angle
   * and axis vector.
   * This is the equivalent of calling [Graphene.Matrix.initRotate] and
   * then multiplying the matrix m with the rotation matrix.
   * Params:
   *   angle = the rotation angle, in degrees
   *   axis = the rotation axis, as a #graphene_vec3_t
   */
  void rotate(float angle, Vec3 axis)
  {
    graphene_matrix_rotate(cast(graphene_matrix_t*)cPtr, angle, axis ? cast(graphene_vec3_t*)axis.cPtr(false) : null);
  }

  /**
   * Adds a rotation transformation to m, using the given
   * #graphene_euler_t.
   * Params:
   *   e = a rotation described by a #graphene_euler_t
   */
  void rotateEuler(Euler e)
  {
    graphene_matrix_rotate_euler(cast(graphene_matrix_t*)cPtr, e ? cast(graphene_euler_t*)e.cPtr(false) : null);
  }

  /**
   * Adds a rotation transformation to m, using the given
   * #graphene_quaternion_t.
   * This is the equivalent of calling [Graphene.Quaternion.toMatrix] and
   * then multiplying m with the rotation matrix.
   * Params:
   *   q = a rotation described by a #graphene_quaternion_t
   */
  void rotateQuaternion(Quaternion q)
  {
    graphene_matrix_rotate_quaternion(cast(graphene_matrix_t*)cPtr, q ? cast(graphene_quaternion_t*)q.cPtr(false) : null);
  }

  /**
   * Adds a rotation transformation around the X axis to m, using
   * the given angle.
   * See also: [Graphene.Matrix.rotate]
   * Params:
   *   angle = the rotation angle, in degrees
   */
  void rotateX(float angle)
  {
    graphene_matrix_rotate_x(cast(graphene_matrix_t*)cPtr, angle);
  }

  /**
   * Adds a rotation transformation around the Y axis to m, using
   * the given angle.
   * See also: [Graphene.Matrix.rotate]
   * Params:
   *   angle = the rotation angle, in degrees
   */
  void rotateY(float angle)
  {
    graphene_matrix_rotate_y(cast(graphene_matrix_t*)cPtr, angle);
  }

  /**
   * Adds a rotation transformation around the Z axis to m, using
   * the given angle.
   * See also: [Graphene.Matrix.rotate]
   * Params:
   *   angle = the rotation angle, in degrees
   */
  void rotateZ(float angle)
  {
    graphene_matrix_rotate_z(cast(graphene_matrix_t*)cPtr, angle);
  }

  /**
   * Adds a scaling transformation to m, using the three
   * given factors.
   * This is the equivalent of calling [Graphene.Matrix.initScale] and then
   * multiplying the matrix m with the scale matrix.
   * Params:
   *   factorX = scaling factor on the X axis
   *   factorY = scaling factor on the Y axis
   *   factorZ = scaling factor on the Z axis
   */
  void scale(float factorX, float factorY, float factorZ)
  {
    graphene_matrix_scale(cast(graphene_matrix_t*)cPtr, factorX, factorY, factorZ);
  }

  /**
   * Adds a skew of factor on the X and Y axis to the given matrix.
   * Params:
   *   factor = skew factor
   */
  void skewXy(float factor)
  {
    graphene_matrix_skew_xy(cast(graphene_matrix_t*)cPtr, factor);
  }

  /**
   * Adds a skew of factor on the X and Z axis to the given matrix.
   * Params:
   *   factor = skew factor
   */
  void skewXz(float factor)
  {
    graphene_matrix_skew_xz(cast(graphene_matrix_t*)cPtr, factor);
  }

  /**
   * Adds a skew of factor on the Y and Z axis to the given matrix.
   * Params:
   *   factor = skew factor
   */
  void skewYz(float factor)
  {
    graphene_matrix_skew_yz(cast(graphene_matrix_t*)cPtr, factor);
  }

  /**
   * Converts a #graphene_matrix_t to an affine transformation
   * matrix, if the given matrix is compatible.
   * The returned values have the following layout:
   * |[<!-- language\="plain" -->
   * ⎛ xx  yx ⎞   ⎛  a   b  0 ⎞
   * ⎜ xy  yy ⎟ \= ⎜  c   d  0 ⎟
   * ⎝ x0  y0 ⎠   ⎝ tx  ty  1 ⎠
   * ]|
   * This function can be used to convert between a #graphene_matrix_t
   * and an affine matrix type from other libraries.
   * Params:
   *   xx = return location for the xx member
   *   yx = return location for the yx member
   *   xy = return location for the xy member
   *   yy = return location for the yy member
   *   x0 = return location for the x0 member
   *   y0 = return location for the y0 member
   * Returns: `true` if the matrix is compatible with an affine
   *   transformation matrix
   */
  bool to2d(out double xx, out double yx, out double xy, out double yy, out double x0, out double y0)
  {
    bool _retval;
    _retval = graphene_matrix_to_2d(cast(graphene_matrix_t*)cPtr, cast(double*)&xx, cast(double*)&yx, cast(double*)&xy, cast(double*)&yy, cast(double*)&x0, cast(double*)&y0);
    return _retval;
  }

  /**
   * Converts a #graphene_matrix_t to an array of floating point
   * values.
   * Params:
   *   v = return location
   *     for an array of floating point values. The array must be capable
   *     of holding at least 16 values.
   */
  void toFloat(ref float[] v)
  {
    graphene_matrix_to_float(cast(graphene_matrix_t*)cPtr, v.ptr);
  }

  /**
   * Transforms each corner of a #graphene_rect_t using the given matrix m.
   * The result is the axis aligned bounding rectangle containing the coplanar
   * quadrilateral.
   * See also: [Graphene.Matrix.transformPoint]
   * Params:
   *   r = a #graphene_rect_t
   *   res = return location for the bounds
   *     of the transformed rectangle
   */
  void transformBounds(Rect r, out Rect res)
  {
    graphene_rect_t _res;
    graphene_matrix_transform_bounds(cast(graphene_matrix_t*)cPtr, r ? cast(graphene_rect_t*)r.cPtr(false) : null, &_res);
    res = new Rect(cast(void*)&_res, false);
  }

  /**
   * Transforms the vertices of a #graphene_box_t using the given matrix m.
   * The result is the axis aligned bounding box containing the transformed
   * vertices.
   * Params:
   *   b = a #graphene_box_t
   *   res = return location for the bounds
   *     of the transformed box
   */
  void transformBox(Box b, out Box res)
  {
    graphene_box_t _res;
    graphene_matrix_transform_box(cast(graphene_matrix_t*)cPtr, b ? cast(graphene_box_t*)b.cPtr(false) : null, &_res);
    res = new Box(cast(void*)&_res, false);
  }

  /**
   * Transforms the given #graphene_point_t using the matrix m.
   * Unlike [Graphene.Matrix.transformVec3], this function will take into
   * account the fourth row vector of the #graphene_matrix_t when computing
   * the dot product of each row vector of the matrix.
   * See also: graphene_simd4x4f_point3_mul$(LPAREN)$(RPAREN)
   * Params:
   *   p = a #graphene_point_t
   *   res = return location for the
   *     transformed #graphene_point_t
   */
  void transformPoint(Point p, out Point res)
  {
    graphene_point_t _res;
    graphene_matrix_transform_point(cast(graphene_matrix_t*)cPtr, p ? cast(graphene_point_t*)p.cPtr(false) : null, &_res);
    res = new Point(cast(void*)&_res, false);
  }

  /**
   * Transforms the given #graphene_point3d_t using the matrix m.
   * Unlike [Graphene.Matrix.transformVec3], this function will take into
   * account the fourth row vector of the #graphene_matrix_t when computing
   * the dot product of each row vector of the matrix.
   * See also: graphene_simd4x4f_point3_mul$(LPAREN)$(RPAREN)
   * Params:
   *   p = a #graphene_point3d_t
   *   res = return location for the result
   */
  void transformPoint3d(Point3D p, out Point3D res)
  {
    graphene_point3d_t _res;
    graphene_matrix_transform_point3d(cast(graphene_matrix_t*)cPtr, p ? cast(graphene_point3d_t*)p.cPtr(false) : null, &_res);
    res = new Point3D(cast(void*)&_res, false);
  }

  /**
   * Transform a #graphene_ray_t using the given matrix m.
   * Params:
   *   r = a #graphene_ray_t
   *   res = return location for the
   *     transformed ray
   */
  void transformRay(Ray r, out Ray res)
  {
    graphene_ray_t _res;
    graphene_matrix_transform_ray(cast(graphene_matrix_t*)cPtr, r ? cast(graphene_ray_t*)r.cPtr(false) : null, &_res);
    res = new Ray(cast(void*)&_res, false);
  }

  /**
   * Transforms each corner of a #graphene_rect_t using the given matrix m.
   * The result is a coplanar quadrilateral.
   * See also: [Graphene.Matrix.transformPoint]
   * Params:
   *   r = a #graphene_rect_t
   *   res = return location for the
   *     transformed quad
   */
  void transformRect(Rect r, out Quad res)
  {
    graphene_quad_t _res;
    graphene_matrix_transform_rect(cast(graphene_matrix_t*)cPtr, r ? cast(graphene_rect_t*)r.cPtr(false) : null, &_res);
    res = new Quad(cast(void*)&_res, false);
  }

  /**
   * Transforms a #graphene_sphere_t using the given matrix m. The
   * result is the bounding sphere containing the transformed sphere.
   * Params:
   *   s = a #graphene_sphere_t
   *   res = return location for the bounds
   *     of the transformed sphere
   */
  void transformSphere(Sphere s, out Sphere res)
  {
    graphene_sphere_t _res;
    graphene_matrix_transform_sphere(cast(graphene_matrix_t*)cPtr, s ? cast(graphene_sphere_t*)s.cPtr(false) : null, &_res);
    res = new Sphere(cast(void*)&_res, false);
  }

  /**
   * Transforms the given #graphene_vec3_t using the matrix m.
   * This function will multiply the X, Y, and Z row vectors of the matrix m
   * with the corresponding components of the vector v. The W row vector will
   * be ignored.
   * See also: graphene_simd4x4f_vec3_mul$(LPAREN)$(RPAREN)
   * Params:
   *   v = a #graphene_vec3_t
   *   res = return location for a #graphene_vec3_t
   */
  void transformVec3(Vec3 v, out Vec3 res)
  {
    graphene_vec3_t _res;
    graphene_matrix_transform_vec3(cast(graphene_matrix_t*)cPtr, v ? cast(graphene_vec3_t*)v.cPtr(false) : null, &_res);
    res = new Vec3(cast(void*)&_res, false);
  }

  /**
   * Transforms the given #graphene_vec4_t using the matrix m.
   * See also: graphene_simd4x4f_vec4_mul$(LPAREN)$(RPAREN)
   * Params:
   *   v = a #graphene_vec4_t
   *   res = return location for a #graphene_vec4_t
   */
  void transformVec4(Vec4 v, out Vec4 res)
  {
    graphene_vec4_t _res;
    graphene_matrix_transform_vec4(cast(graphene_matrix_t*)cPtr, v ? cast(graphene_vec4_t*)v.cPtr(false) : null, &_res);
    res = new Vec4(cast(void*)&_res, false);
  }

  /**
   * Adds a translation transformation to m using the coordinates
   * of the given #graphene_point3d_t.
   * This is the equivalent of calling [Graphene.Matrix.initTranslate] and
   * then multiplying m with the translation matrix.
   * Params:
   *   pos = a #graphene_point3d_t
   */
  void translate(Point3D pos)
  {
    graphene_matrix_translate(cast(graphene_matrix_t*)cPtr, pos ? cast(graphene_point3d_t*)pos.cPtr(false) : null);
  }

  /**
   * Transposes the given matrix.
   * Params:
   *   res = return location for the
   *     transposed matrix
   */
  void transpose(out Matrix res)
  {
    graphene_matrix_t _res;
    graphene_matrix_transpose(cast(graphene_matrix_t*)cPtr, &_res);
    res = new Matrix(cast(void*)&_res, false);
  }

  /**
   * Unprojects the given point using the projection matrix and
   * a modelview matrix.
   * Params:
   *   modelview = a #graphene_matrix_t for the modelview matrix; this is
   *     the inverse of the modelview used when projecting the point
   *   point = a #graphene_point3d_t with the coordinates of the point
   *   res = return location for the unprojected
   *     point
   */
  void unprojectPoint3d(Matrix modelview, Point3D point, out Point3D res)
  {
    graphene_point3d_t _res;
    graphene_matrix_unproject_point3d(cast(graphene_matrix_t*)cPtr, modelview ? cast(graphene_matrix_t*)modelview.cPtr(false) : null, point ? cast(graphene_point3d_t*)point.cPtr(false) : null, &_res);
    res = new Point3D(cast(void*)&_res, false);
  }

  /**
   * Undoes the transformation on the corners of a #graphene_rect_t using the
   * given matrix, within the given axis aligned rectangular bounds.
   * Params:
   *   r = a #graphene_rect_t
   *   bounds = the bounds of the transformation
   *   res = return location for the
   *     untransformed rectangle
   */
  void untransformBounds(Rect r, Rect bounds, out Rect res)
  {
    graphene_rect_t _res;
    graphene_matrix_untransform_bounds(cast(graphene_matrix_t*)cPtr, r ? cast(graphene_rect_t*)r.cPtr(false) : null, bounds ? cast(graphene_rect_t*)bounds.cPtr(false) : null, &_res);
    res = new Rect(cast(void*)&_res, false);
  }

  /**
   * Undoes the transformation of a #graphene_point_t using the
   * given matrix, within the given axis aligned rectangular bounds.
   * Params:
   *   p = a #graphene_point_t
   *   bounds = the bounds of the transformation
   *   res = return location for the
   *     untransformed point
   * Returns: `true` if the point was successfully untransformed
   */
  bool untransformPoint(Point p, Rect bounds, out Point res)
  {
    bool _retval;
    graphene_point_t _res;
    _retval = graphene_matrix_untransform_point(cast(graphene_matrix_t*)cPtr, p ? cast(graphene_point_t*)p.cPtr(false) : null, bounds ? cast(graphene_rect_t*)bounds.cPtr(false) : null, &_res);
    res = new Point(cast(void*)&_res, false);
    return _retval;
  }
}
