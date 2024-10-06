module Graphene.Quaternion;

import GLib.Boxed;
import Gid.gid;
import Graphene.Euler;
import Graphene.Matrix;
import Graphene.Types;
import Graphene.Vec3;
import Graphene.Vec4;
import Graphene.c.functions;
import Graphene.c.types;

/**
 * A quaternion.
 * The contents of the #graphene_quaternion_t structure are private
 * and should never be accessed directly.
 */
class Quaternion : Boxed
{

  this()
  {
    super(safeMalloc(graphene_quaternion_t.sizeof), true);
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
    return graphene_quaternion_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Allocates a new #graphene_quaternion_t.
   * The contents of the returned value are undefined.
   * Returns: the newly allocated #graphene_quaternion_t
   */
  static Quaternion alloc()
  {
    graphene_quaternion_t* _cretval;
    _cretval = graphene_quaternion_alloc();
    auto _retval = _cretval ? new Quaternion(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Adds two #graphene_quaternion_t a and b.
   * Params:
   *   b = a #graphene_quaternion_t
   *   res = the result of the operation
   */
  void add(Quaternion b, out Quaternion res)
  {
    graphene_quaternion_t _res;
    graphene_quaternion_add(cast(graphene_quaternion_t*)cPtr, b ? cast(graphene_quaternion_t*)b.cPtr(false) : null, &_res);
    res = new Quaternion(cast(void*)&_res, false);
  }

  /**
   * Computes the dot product of two #graphene_quaternion_t.
   * Params:
   *   b = a #graphene_quaternion_t
   * Returns: the value of the dot products
   */
  float dot(Quaternion b)
  {
    float _retval;
    _retval = graphene_quaternion_dot(cast(graphene_quaternion_t*)cPtr, b ? cast(graphene_quaternion_t*)b.cPtr(false) : null);
    return _retval;
  }

  /**
   * Checks whether the given quaternions are equal.
   * Params:
   *   b = a #graphene_quaternion_t
   * Returns: `true` if the quaternions are equal
   */
  bool equal(Quaternion b)
  {
    bool _retval;
    _retval = graphene_quaternion_equal(cast(graphene_quaternion_t*)cPtr, b ? cast(graphene_quaternion_t*)b.cPtr(false) : null);
    return _retval;
  }

  /**
   * Initializes a #graphene_quaternion_t using the given four values.
   * Params:
   *   x = the first component of the quaternion
   *   y = the second component of the quaternion
   *   z = the third component of the quaternion
   *   w = the fourth component of the quaternion
   * Returns: the initialized quaternion
   */
  Quaternion init_(float x, float y, float z, float w)
  {
    graphene_quaternion_t* _cretval;
    _cretval = graphene_quaternion_init(cast(graphene_quaternion_t*)cPtr, x, y, z, w);
    auto _retval = _cretval ? new Quaternion(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Initializes a #graphene_quaternion_t using an angle on a
   * specific axis.
   * Params:
   *   angle = the rotation on a given axis, in degrees
   *   axis = the axis of rotation, expressed as a vector
   * Returns: the initialized quaternion
   */
  Quaternion initFromAngleVec3(float angle, Vec3 axis)
  {
    graphene_quaternion_t* _cretval;
    _cretval = graphene_quaternion_init_from_angle_vec3(cast(graphene_quaternion_t*)cPtr, angle, axis ? cast(graphene_vec3_t*)axis.cPtr(false) : null);
    auto _retval = _cretval ? new Quaternion(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Initializes a #graphene_quaternion_t using the values of
   * the [Euler angles](http://en.wikipedia.org/wiki/Euler_angles)
   * on each axis.
   * See also: [Graphene.Quaternion.initFromEuler]
   * Params:
   *   degX = rotation angle on the X axis $(LPAREN)yaw$(RPAREN), in degrees
   *   degY = rotation angle on the Y axis $(LPAREN)pitch$(RPAREN), in degrees
   *   degZ = rotation angle on the Z axis $(LPAREN)roll$(RPAREN), in degrees
   * Returns: the initialized quaternion
   */
  Quaternion initFromAngles(float degX, float degY, float degZ)
  {
    graphene_quaternion_t* _cretval;
    _cretval = graphene_quaternion_init_from_angles(cast(graphene_quaternion_t*)cPtr, degX, degY, degZ);
    auto _retval = _cretval ? new Quaternion(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Initializes a #graphene_quaternion_t using the given #graphene_euler_t.
   * Params:
   *   e = a #graphene_euler_t
   * Returns: the initialized #graphene_quaternion_t
   */
  Quaternion initFromEuler(Euler e)
  {
    graphene_quaternion_t* _cretval;
    _cretval = graphene_quaternion_init_from_euler(cast(graphene_quaternion_t*)cPtr, e ? cast(graphene_euler_t*)e.cPtr(false) : null);
    auto _retval = _cretval ? new Quaternion(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Initializes a #graphene_quaternion_t using the rotation components
   * of a transformation matrix.
   * Params:
   *   m = a #graphene_matrix_t
   * Returns: the initialized quaternion
   */
  Quaternion initFromMatrix(Matrix m)
  {
    graphene_quaternion_t* _cretval;
    _cretval = graphene_quaternion_init_from_matrix(cast(graphene_quaternion_t*)cPtr, m ? cast(graphene_matrix_t*)m.cPtr(false) : null);
    auto _retval = _cretval ? new Quaternion(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Initializes a #graphene_quaternion_t with the values from src.
   * Params:
   *   src = a #graphene_quaternion_t
   * Returns: the initialized quaternion
   */
  Quaternion initFromQuaternion(Quaternion src)
  {
    graphene_quaternion_t* _cretval;
    _cretval = graphene_quaternion_init_from_quaternion(cast(graphene_quaternion_t*)cPtr, src ? cast(graphene_quaternion_t*)src.cPtr(false) : null);
    auto _retval = _cretval ? new Quaternion(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Initializes a #graphene_quaternion_t using the values of
   * the [Euler angles](http://en.wikipedia.org/wiki/Euler_angles)
   * on each axis.
   * See also: [Graphene.Quaternion.initFromEuler]
   * Params:
   *   radX = rotation angle on the X axis $(LPAREN)yaw$(RPAREN), in radians
   *   radY = rotation angle on the Y axis $(LPAREN)pitch$(RPAREN), in radians
   *   radZ = rotation angle on the Z axis $(LPAREN)roll$(RPAREN), in radians
   * Returns: the initialized quaternion
   */
  Quaternion initFromRadians(float radX, float radY, float radZ)
  {
    graphene_quaternion_t* _cretval;
    _cretval = graphene_quaternion_init_from_radians(cast(graphene_quaternion_t*)cPtr, radX, radY, radZ);
    auto _retval = _cretval ? new Quaternion(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Initializes a #graphene_quaternion_t with the values from src.
   * Params:
   *   src = a #graphene_vec4_t
   * Returns: the initialized quaternion
   */
  Quaternion initFromVec4(Vec4 src)
  {
    graphene_quaternion_t* _cretval;
    _cretval = graphene_quaternion_init_from_vec4(cast(graphene_quaternion_t*)cPtr, src ? cast(graphene_vec4_t*)src.cPtr(false) : null);
    auto _retval = _cretval ? new Quaternion(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Initializes a #graphene_quaternion_t using the identity
   * transformation.
   * Returns: the initialized quaternion
   */
  Quaternion initIdentity()
  {
    graphene_quaternion_t* _cretval;
    _cretval = graphene_quaternion_init_identity(cast(graphene_quaternion_t*)cPtr);
    auto _retval = _cretval ? new Quaternion(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Inverts a #graphene_quaternion_t, and returns the conjugate
   * quaternion of q.
   * Params:
   *   res = return location for the inverted
   *     quaternion
   */
  void invert(out Quaternion res)
  {
    graphene_quaternion_t _res;
    graphene_quaternion_invert(cast(graphene_quaternion_t*)cPtr, &_res);
    res = new Quaternion(cast(void*)&_res, false);
  }

  /**
   * Multiplies two #graphene_quaternion_t a and b.
   * Params:
   *   b = a #graphene_quaternion_t
   *   res = the result of the operation
   */
  void multiply(Quaternion b, out Quaternion res)
  {
    graphene_quaternion_t _res;
    graphene_quaternion_multiply(cast(graphene_quaternion_t*)cPtr, b ? cast(graphene_quaternion_t*)b.cPtr(false) : null, &_res);
    res = new Quaternion(cast(void*)&_res, false);
  }

  /**
   * Normalizes a #graphene_quaternion_t.
   * Params:
   *   res = return location for the normalized
   *     quaternion
   */
  void normalize(out Quaternion res)
  {
    graphene_quaternion_t _res;
    graphene_quaternion_normalize(cast(graphene_quaternion_t*)cPtr, &_res);
    res = new Quaternion(cast(void*)&_res, false);
  }

  /**
   * Scales all the elements of a #graphene_quaternion_t q using
   * the given scalar factor.
   * Params:
   *   factor = a scaling factor
   *   res = the result of the operation
   */
  void scale(float factor, out Quaternion res)
  {
    graphene_quaternion_t _res;
    graphene_quaternion_scale(cast(graphene_quaternion_t*)cPtr, factor, &_res);
    res = new Quaternion(cast(void*)&_res, false);
  }

  /**
   * Interpolates between the two given quaternions using a spherical
   * linear interpolation, or [SLERP](http://en.wikipedia.org/wiki/Slerp),
   * using the given interpolation factor.
   * Params:
   *   b = a #graphene_quaternion_t
   *   factor = the linear interpolation factor
   *   res = return location for the interpolated
   *     quaternion
   */
  void slerp(Quaternion b, float factor, out Quaternion res)
  {
    graphene_quaternion_t _res;
    graphene_quaternion_slerp(cast(graphene_quaternion_t*)cPtr, b ? cast(graphene_quaternion_t*)b.cPtr(false) : null, factor, &_res);
    res = new Quaternion(cast(void*)&_res, false);
  }

  /**
   * Converts a quaternion into an angle, axis pair.
   * Params:
   *   angle = return location for the angle, in degrees
   *   axis = return location for the rotation axis
   */
  void toAngleVec3(out float angle, out Vec3 axis)
  {
    graphene_vec3_t _axis;
    graphene_quaternion_to_angle_vec3(cast(graphene_quaternion_t*)cPtr, cast(float*)&angle, &_axis);
    axis = new Vec3(cast(void*)&_axis, false);
  }

  /**
   * Converts a #graphene_quaternion_t to its corresponding rotations
   * on the [Euler angles](http://en.wikipedia.org/wiki/Euler_angles)
   * on each axis.
   * Params:
   *   degX = return location for the rotation angle on
   *     the X axis $(LPAREN)yaw$(RPAREN), in degrees
   *   degY = return location for the rotation angle on
   *     the Y axis $(LPAREN)pitch$(RPAREN), in degrees
   *   degZ = return location for the rotation angle on
   *     the Z axis $(LPAREN)roll$(RPAREN), in degrees
   */
  void toAngles(out float degX, out float degY, out float degZ)
  {
    graphene_quaternion_to_angles(cast(graphene_quaternion_t*)cPtr, cast(float*)&degX, cast(float*)&degY, cast(float*)&degZ);
  }

  /**
   * Converts a quaternion into a transformation matrix expressing
   * the rotation defined by the #graphene_quaternion_t.
   * Params:
   *   m = a #graphene_matrix_t
   */
  void toMatrix(out Matrix m)
  {
    graphene_matrix_t _m;
    graphene_quaternion_to_matrix(cast(graphene_quaternion_t*)cPtr, &_m);
    m = new Matrix(cast(void*)&_m, false);
  }

  /**
   * Converts a #graphene_quaternion_t to its corresponding rotations
   * on the [Euler angles](http://en.wikipedia.org/wiki/Euler_angles)
   * on each axis.
   * Params:
   *   radX = return location for the rotation angle on
   *     the X axis $(LPAREN)yaw$(RPAREN), in radians
   *   radY = return location for the rotation angle on
   *     the Y axis $(LPAREN)pitch$(RPAREN), in radians
   *   radZ = return location for the rotation angle on
   *     the Z axis $(LPAREN)roll$(RPAREN), in radians
   */
  void toRadians(out float radX, out float radY, out float radZ)
  {
    graphene_quaternion_to_radians(cast(graphene_quaternion_t*)cPtr, cast(float*)&radX, cast(float*)&radY, cast(float*)&radZ);
  }

  /**
   * Copies the components of a #graphene_quaternion_t into a
   * #graphene_vec4_t.
   * Params:
   *   res = return location for a
   *     #graphene_vec4_t
   */
  void toVec4(out Vec4 res)
  {
    graphene_vec4_t _res;
    graphene_quaternion_to_vec4(cast(graphene_quaternion_t*)cPtr, &_res);
    res = new Vec4(cast(void*)&_res, false);
  }
}
