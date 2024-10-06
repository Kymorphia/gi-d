module Gsk.Transform;

import GLib.Boxed;
import GLib.String;
import Gid.gid;
import Graphene.Matrix;
import Graphene.Point;
import Graphene.Point3D;
import Graphene.Rect;
import Graphene.Vec3;
import Gsk.Types;
import Gsk.c.functions;
import Gsk.c.types;

/**
 * `GskTransform` is an object to describe transform matrices.
 * Unlike `graphene_matrix_t`, `GskTransform` retains the steps in how
 * a transform was constructed, and allows inspecting them. It is modeled
 * after the way CSS describes transforms.
 * `GskTransform` objects are immutable and cannot be changed after creation.
 * This means code can safely expose them as properties of objects without
 * having to worry about others changing them.
 */
class Transform : Boxed
{

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
    return gsk_transform_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  this()
  {
    GskTransform* _cretval;
    _cretval = gsk_transform_new();
    this(_cretval, true);
  }

  /**
   * Checks two transforms for equality.
   * Params:
   *   second = the second transform
   * Returns: %TRUE if the two transforms perform the same operation
   */
  bool equal(Transform second)
  {
    bool _retval;
    _retval = gsk_transform_equal(cast(GskTransform*)cPtr, second ? cast(GskTransform*)second.cPtr(false) : null);
    return _retval;
  }

  /**
   * Returns the category this transform belongs to.
   * Returns: The category of the transform
   */
  TransformCategory getCategory()
  {
    GskTransformCategory _cretval;
    _cretval = gsk_transform_get_category(cast(GskTransform*)cPtr);
    TransformCategory _retval = cast(TransformCategory)_cretval;
    return _retval;
  }

  /**
   * Inverts the given transform.
   * If self is not invertible, %NULL is returned.
   * Note that inverting %NULL also returns %NULL, which is
   * the correct inverse of %NULL. If you need to differentiate
   * between those cases, you should check self is not %NULL
   * before calling this function.
   * Returns: The inverted transform
   */
  Transform invert()
  {
    GskTransform* _cretval;
    _cretval = gsk_transform_invert(cast(GskTransform*)cPtr);
    auto _retval = _cretval ? new Transform(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Multiplies next with the given matrix.
   * Params:
   *   matrix = the matrix to multiply next with
   * Returns: The new transform
   */
  Transform matrix(Matrix matrix)
  {
    GskTransform* _cretval;
    _cretval = gsk_transform_matrix(cast(GskTransform*)cPtr, matrix ? cast(graphene_matrix_t*)matrix.cPtr(false) : null);
    auto _retval = _cretval ? new Transform(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Applies a perspective projection transform.
   * This transform scales points in X and Y based on their Z value,
   * scaling points with positive Z values away from the origin, and
   * those with negative Z values towards the origin. Points
   * on the z\=0 plane are unchanged.
   * Params:
   *   depth = distance of the z\=0 plane. Lower values give a more
   *     flattened pyramid and therefore a more pronounced
   *     perspective effect.
   * Returns: The new transform
   */
  Transform perspective(float depth)
  {
    GskTransform* _cretval;
    _cretval = gsk_transform_perspective(cast(GskTransform*)cPtr, depth);
    auto _retval = _cretval ? new Transform(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Converts self into a human-readable string representation suitable
   * for printing.
   * The result of this function can later be parsed with
   * [Gsk.Transform.parse].
   * Params:
   *   string_ = The string to print into
   */
  void print(String string_)
  {
    gsk_transform_print(cast(GskTransform*)cPtr, string_ ? cast(GString*)string_.cPtr(false) : null);
  }

  /**
   * Rotates next angle degrees in 2D - or in 3D-speak, around the Z axis.
   * The rotation happens around the origin point of $(LPAREN)0, 0$(RPAREN).
   * Params:
   *   angle = the rotation angle, in degrees $(LPAREN)clockwise$(RPAREN)
   * Returns: The new transform
   */
  Transform rotate(float angle)
  {
    GskTransform* _cretval;
    _cretval = gsk_transform_rotate(cast(GskTransform*)cPtr, angle);
    auto _retval = _cretval ? new Transform(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Rotates next angle degrees around axis.
   * For a rotation in 2D space, use [Gsk.Transform.rotate]
   * Params:
   *   angle = the rotation angle, in degrees $(LPAREN)clockwise$(RPAREN)
   *   axis = The rotation axis
   * Returns: The new transform
   */
  Transform rotate3d(float angle, Vec3 axis)
  {
    GskTransform* _cretval;
    _cretval = gsk_transform_rotate_3d(cast(GskTransform*)cPtr, angle, axis ? cast(graphene_vec3_t*)axis.cPtr(false) : null);
    auto _retval = _cretval ? new Transform(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Scales next in 2-dimensional space by the given factors.
   * Use [Gsk.Transform.scale3d] to scale in all 3 dimensions.
   * Params:
   *   factorX = scaling factor on the X axis
   *   factorY = scaling factor on the Y axis
   * Returns: The new transform
   */
  Transform scale(float factorX, float factorY)
  {
    GskTransform* _cretval;
    _cretval = gsk_transform_scale(cast(GskTransform*)cPtr, factorX, factorY);
    auto _retval = _cretval ? new Transform(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Scales next by the given factors.
   * Params:
   *   factorX = scaling factor on the X axis
   *   factorY = scaling factor on the Y axis
   *   factorZ = scaling factor on the Z axis
   * Returns: The new transform
   */
  Transform scale3d(float factorX, float factorY, float factorZ)
  {
    GskTransform* _cretval;
    _cretval = gsk_transform_scale_3d(cast(GskTransform*)cPtr, factorX, factorY, factorZ);
    auto _retval = _cretval ? new Transform(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Applies a skew transform.
   * Params:
   *   skewX = skew factor, in degrees, on the X axis
   *   skewY = skew factor, in degrees, on the Y axis
   * Returns: The new transform
   */
  Transform skew(float skewX, float skewY)
  {
    GskTransform* _cretval;
    _cretval = gsk_transform_skew(cast(GskTransform*)cPtr, skewX, skewY);
    auto _retval = _cretval ? new Transform(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Converts a `GskTransform` to a 2D transformation matrix.
   * self must be a 2D transformation. If you are not
   * sure, use [Gsk.Transform.getCategory] >\=
   * %GSK_TRANSFORM_CATEGORY_2D to check.
   * The returned values have the following layout:
   * ```
   * | xx yx |   |  a  b  0 |
   * | xy yy | \= |  c  d  0 |
   * | dx dy |   | tx ty  1 |
   * ```
   * This function can be used to convert between a `GskTransform`
   * and a matrix type from other 2D drawing libraries, in particular
   * Cairo.
   * Params:
   *   outXx = return location for the xx member
   *   outYx = return location for the yx member
   *   outXy = return location for the xy member
   *   outYy = return location for the yy member
   *   outDx = return location for the x0 member
   *   outDy = return location for the y0 member
   */
  void to2d(out float outXx, out float outYx, out float outXy, out float outYy, out float outDx, out float outDy)
  {
    gsk_transform_to_2d(cast(GskTransform*)cPtr, cast(float*)&outXx, cast(float*)&outYx, cast(float*)&outXy, cast(float*)&outYy, cast(float*)&outDx, cast(float*)&outDy);
  }

  /**
   * Converts a `GskTransform` to 2D transformation factors.
   * To recreate an equivalent transform from the factors returned
   * by this function, use
   * gsk_transform_skew $(LPAREN)
   * gsk_transform_scale $(LPAREN)
   * gsk_transform_rotate $(LPAREN)
   * gsk_transform_translate $(LPAREN)NULL, &GRAPHENE_POINT_T $(LPAREN)dx, dy$(RPAREN)$(RPAREN),
   * angle$(RPAREN),
   * scale_x, scale_y$(RPAREN),
   * skew_x, skew_y$(RPAREN)
   * self must be a 2D transformation. If you are not sure, use
   * [Gsk.Transform.getCategory] >\= %GSK_TRANSFORM_CATEGORY_2D
   * to check.
   * Params:
   *   outSkewX = return location for the skew factor
   *     in the  x direction
   *   outSkewY = return location for the skew factor
   *     in the  y direction
   *   outScaleX = return location for the scale
   *     factor in the x direction
   *   outScaleY = return location for the scale
   *     factor in the y direction
   *   outAngle = return location for the rotation angle
   *   outDx = return location for the translation
   *     in the x direction
   *   outDy = return location for the translation
   *     in the y direction
   */
  void to2dComponents(out float outSkewX, out float outSkewY, out float outScaleX, out float outScaleY, out float outAngle, out float outDx, out float outDy)
  {
    gsk_transform_to_2d_components(cast(GskTransform*)cPtr, cast(float*)&outSkewX, cast(float*)&outSkewY, cast(float*)&outScaleX, cast(float*)&outScaleY, cast(float*)&outAngle, cast(float*)&outDx, cast(float*)&outDy);
  }

  /**
   * Converts a `GskTransform` to 2D affine transformation factors.
   * To recreate an equivalent transform from the factors returned
   * by this function, use
   * gsk_transform_scale $(LPAREN)gsk_transform_translate $(LPAREN)NULL,
   * &GRAPHENE_POINT_T $(LPAREN)dx, dy$(RPAREN)$(RPAREN),
   * sx, sy$(RPAREN)
   * self must be a 2D affine transformation. If you are not
   * sure, use
   * [Gsk.Transform.getCategory] >\= %GSK_TRANSFORM_CATEGORY_2D_AFFINE
   * to check.
   * Params:
   *   outScaleX = return location for the scale
   *     factor in the x direction
   *   outScaleY = return location for the scale
   *     factor in the y direction
   *   outDx = return location for the translation
   *     in the x direction
   *   outDy = return location for the translation
   *     in the y direction
   */
  void toAffine(out float outScaleX, out float outScaleY, out float outDx, out float outDy)
  {
    gsk_transform_to_affine(cast(GskTransform*)cPtr, cast(float*)&outScaleX, cast(float*)&outScaleY, cast(float*)&outDx, cast(float*)&outDy);
  }

  /**
   * Computes the actual value of self and stores it in out_matrix.
   * The previous value of out_matrix will be ignored.
   * Params:
   *   outMatrix = The matrix to set
   */
  void toMatrix(out Matrix outMatrix)
  {
    graphene_matrix_t _outMatrix;
    gsk_transform_to_matrix(cast(GskTransform*)cPtr, &_outMatrix);
    outMatrix = new Matrix(cast(void*)&_outMatrix, false);
  }

  /**
   * Converts a matrix into a string that is suitable for printing.
   * The resulting string can be parsed with [Gsk.Transform.parse].
   * This is a wrapper around [Gsk.Transform.print].
   * Returns: A new string for self
   */
  string toString_()
  {
    char* _cretval;
    _cretval = gsk_transform_to_string(cast(GskTransform*)cPtr);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * Converts a `GskTransform` to a translation operation.
   * self must be a 2D transformation. If you are not
   * sure, use
   * [Gsk.Transform.getCategory] >\= %GSK_TRANSFORM_CATEGORY_2D_TRANSLATE
   * to check.
   * Params:
   *   outDx = return location for the translation
   *     in the x direction
   *   outDy = return location for the translation
   *     in the y direction
   */
  void toTranslate(out float outDx, out float outDy)
  {
    gsk_transform_to_translate(cast(GskTransform*)cPtr, cast(float*)&outDx, cast(float*)&outDy);
  }

  /**
   * Applies all the operations from other to next.
   * Params:
   *   other = Transform to apply
   * Returns: The new transform
   */
  Transform transform(Transform other)
  {
    GskTransform* _cretval;
    _cretval = gsk_transform_transform(cast(GskTransform*)cPtr, other ? cast(GskTransform*)other.cPtr(false) : null);
    auto _retval = _cretval ? new Transform(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Transforms a `graphene_rect_t` using the given transform self.
   * The result is the bounding box containing the coplanar quad.
   * Params:
   *   rect = a `graphene_rect_t`
   *   outRect = return location for the bounds
   *     of the transformed rectangle
   */
  void transformBounds(Rect rect, out Rect outRect)
  {
    graphene_rect_t _outRect;
    gsk_transform_transform_bounds(cast(GskTransform*)cPtr, rect ? cast(graphene_rect_t*)rect.cPtr(false) : null, &_outRect);
    outRect = new Rect(cast(void*)&_outRect, false);
  }

  /**
   * Transforms a `graphene_point_t` using the given transform self.
   * Params:
   *   point = a `graphene_point_t`
   *   outPoint = return location for
   *     the transformed point
   */
  void transformPoint(Point point, out Point outPoint)
  {
    graphene_point_t _outPoint;
    gsk_transform_transform_point(cast(GskTransform*)cPtr, point ? cast(graphene_point_t*)point.cPtr(false) : null, &_outPoint);
    outPoint = new Point(cast(void*)&_outPoint, false);
  }

  /**
   * Translates next in 2-dimensional space by point.
   * Params:
   *   point = the point to translate the transform by
   * Returns: The new transform
   */
  Transform translate(Point point)
  {
    GskTransform* _cretval;
    _cretval = gsk_transform_translate(cast(GskTransform*)cPtr, point ? cast(graphene_point_t*)point.cPtr(false) : null);
    auto _retval = _cretval ? new Transform(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Translates next by point.
   * Params:
   *   point = the point to translate the transform by
   * Returns: The new transform
   */
  Transform translate3d(Point3D point)
  {
    GskTransform* _cretval;
    _cretval = gsk_transform_translate_3d(cast(GskTransform*)cPtr, point ? cast(graphene_point3d_t*)point.cPtr(false) : null);
    auto _retval = _cretval ? new Transform(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Parses the given string into a transform and puts it in
   * out_transform.
   * Strings printed via [Gsk.Transform.toString_]
   * can be read in again successfully using this function.
   * If string does not describe a valid transform, %FALSE is
   * returned and %NULL is put in out_transform.
   * Params:
   *   string_ = the string to parse
   *   outTransform = The location to put the transform in
   * Returns: %TRUE if string described a valid transform.
   */
  static bool parse(string string_, out Transform outTransform)
  {
    bool _retval;
    const(char)* _string_ = string_.toCString(false);
    GskTransform* _outTransform;
    _retval = gsk_transform_parse(_string_, &_outTransform);
    outTransform = new Transform(cast(void*)_outTransform, true);
    return _retval;
  }
}
