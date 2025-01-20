module Graphene.Euler;

import GLib.Boxed;
import Gid.gid;
import Graphene.Matrix;
import Graphene.Quaternion;
import Graphene.Types;
import Graphene.Vec3;
import Graphene.c.functions;
import Graphene.c.types;

/**
 * Describe a rotation using Euler angles.
 * The contents of the #graphene_euler_t structure are private
 * and should never be accessed directly.
 */
class Euler : Boxed
{

  this()
  {
    super(safeMalloc(graphene_euler_t.sizeof), true);
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
    return graphene_euler_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Allocates a new #graphene_euler_t.
   * The contents of the returned structure are undefined.
   * Returns: the newly allocated #graphene_euler_t
   */
  static Euler alloc()
  {
    graphene_euler_t* _cretval;
    _cretval = graphene_euler_alloc();
    auto _retval = _cretval ? new Euler(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Checks if two #graphene_euler_t are equal.
   * Params:
   *   b = a #graphene_euler_t
   * Returns: `true` if the two #graphene_euler_t are equal
   */
  bool equal(Euler b)
  {
    bool _retval;
    _retval = graphene_euler_equal(cast(graphene_euler_t*)cPtr, b ? cast(graphene_euler_t*)b.cPtr(false) : null);
    return _retval;
  }

  /**
   * Retrieves the first component of the Euler angle vector,
   * depending on the order of rotation.
   * See also: [Graphene.Euler.getX]
   * Returns: the first component of the Euler angle vector, in radians
   */
  float getAlpha()
  {
    float _retval;
    _retval = graphene_euler_get_alpha(cast(graphene_euler_t*)cPtr);
    return _retval;
  }

  /**
   * Retrieves the second component of the Euler angle vector,
   * depending on the order of rotation.
   * See also: [Graphene.Euler.getY]
   * Returns: the second component of the Euler angle vector, in radians
   */
  float getBeta()
  {
    float _retval;
    _retval = graphene_euler_get_beta(cast(graphene_euler_t*)cPtr);
    return _retval;
  }

  /**
   * Retrieves the third component of the Euler angle vector,
   * depending on the order of rotation.
   * See also: [Graphene.Euler.getZ]
   * Returns: the third component of the Euler angle vector, in radians
   */
  float getGamma()
  {
    float _retval;
    _retval = graphene_euler_get_gamma(cast(graphene_euler_t*)cPtr);
    return _retval;
  }

  /**
   * Retrieves the order used to apply the rotations described in the
   * #graphene_euler_t structure, when converting to and from other
   * structures, like #graphene_quaternion_t and #graphene_matrix_t.
   * This function does not return the %GRAPHENE_EULER_ORDER_DEFAULT
   * enumeration value; it will return the effective order of rotation
   * instead.
   * Returns: the order used to apply the rotations
   */
  EulerOrder getOrder()
  {
    graphene_euler_order_t _cretval;
    _cretval = graphene_euler_get_order(cast(graphene_euler_t*)cPtr);
    EulerOrder _retval = cast(EulerOrder)_cretval;
    return _retval;
  }

  /**
   * Retrieves the rotation angle on the X axis, in degrees.
   * Returns: the rotation angle
   */
  float getX()
  {
    float _retval;
    _retval = graphene_euler_get_x(cast(graphene_euler_t*)cPtr);
    return _retval;
  }

  /**
   * Retrieves the rotation angle on the Y axis, in degrees.
   * Returns: the rotation angle
   */
  float getY()
  {
    float _retval;
    _retval = graphene_euler_get_y(cast(graphene_euler_t*)cPtr);
    return _retval;
  }

  /**
   * Retrieves the rotation angle on the Z axis, in degrees.
   * Returns: the rotation angle
   */
  float getZ()
  {
    float _retval;
    _retval = graphene_euler_get_z(cast(graphene_euler_t*)cPtr);
    return _retval;
  }

  /**
   * Initializes a #graphene_euler_t using the given angles.
   * The order of the rotations is %GRAPHENE_EULER_ORDER_DEFAULT.
   * Params:
   *   x = rotation angle on the X axis, in degrees
   *   y = rotation angle on the Y axis, in degrees
   *   z = rotation angle on the Z axis, in degrees
   * Returns: the initialized #graphene_euler_t
   */
  Euler init_(float x, float y, float z)
  {
    graphene_euler_t* _cretval;
    _cretval = graphene_euler_init(cast(graphene_euler_t*)cPtr, x, y, z);
    auto _retval = _cretval ? new Euler(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Initializes a #graphene_euler_t using the angles and order of
   * another #graphene_euler_t.
   * If the #graphene_euler_t src is %NULL, this function is equivalent
   * to calling [Graphene.Euler.init_] with all angles set to 0.
   * Params:
   *   src = a #graphene_euler_t
   * Returns: the initialized #graphene_euler_t
   */
  Euler initFromEuler(Euler src)
  {
    graphene_euler_t* _cretval;
    _cretval = graphene_euler_init_from_euler(cast(graphene_euler_t*)cPtr, src ? cast(graphene_euler_t*)src.cPtr(false) : null);
    auto _retval = _cretval ? new Euler(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Initializes a #graphene_euler_t using the given rotation matrix.
   * If the #graphene_matrix_t m is %NULL, the #graphene_euler_t will
   * be initialized with all angles set to 0.
   * Params:
   *   m = a rotation matrix
   *   order = the order used to apply the rotations
   * Returns: the initialized #graphene_euler_t
   */
  Euler initFromMatrix(Matrix m, EulerOrder order)
  {
    graphene_euler_t* _cretval;
    _cretval = graphene_euler_init_from_matrix(cast(graphene_euler_t*)cPtr, m ? cast(graphene_matrix_t*)m.cPtr(false) : null, order);
    auto _retval = _cretval ? new Euler(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Initializes a #graphene_euler_t using the given normalized quaternion.
   * If the #graphene_quaternion_t q is %NULL, the #graphene_euler_t will
   * be initialized with all angles set to 0.
   * Params:
   *   q = a normalized #graphene_quaternion_t
   *   order = the order used to apply the rotations
   * Returns: the initialized #graphene_euler_t
   */
  Euler initFromQuaternion(Quaternion q, EulerOrder order)
  {
    graphene_euler_t* _cretval;
    _cretval = graphene_euler_init_from_quaternion(cast(graphene_euler_t*)cPtr, q ? cast(graphene_quaternion_t*)q.cPtr(false) : null, order);
    auto _retval = _cretval ? new Euler(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Initializes a #graphene_euler_t using the given angles
   * and order of rotation.
   * Params:
   *   x = rotation angle on the X axis, in radians
   *   y = rotation angle on the Y axis, in radians
   *   z = rotation angle on the Z axis, in radians
   *   order = order of rotations
   * Returns: the initialized #graphene_euler_t
   */
  Euler initFromRadians(float x, float y, float z, EulerOrder order)
  {
    graphene_euler_t* _cretval;
    _cretval = graphene_euler_init_from_radians(cast(graphene_euler_t*)cPtr, x, y, z, order);
    auto _retval = _cretval ? new Euler(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Initializes a #graphene_euler_t using the angles contained in a
   * #graphene_vec3_t.
   * If the #graphene_vec3_t v is %NULL, the #graphene_euler_t will be
   * initialized with all angles set to 0.
   * Params:
   *   v = a #graphene_vec3_t containing the rotation
   *     angles in degrees
   *   order = the order used to apply the rotations
   * Returns: the initialized #graphene_euler_t
   */
  Euler initFromVec3(Vec3 v, EulerOrder order)
  {
    graphene_euler_t* _cretval;
    _cretval = graphene_euler_init_from_vec3(cast(graphene_euler_t*)cPtr, v ? cast(graphene_vec3_t*)v.cPtr(false) : null, order);
    auto _retval = _cretval ? new Euler(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Initializes a #graphene_euler_t with the given angles and order.
   * Params:
   *   x = rotation angle on the X axis, in degrees
   *   y = rotation angle on the Y axis, in degrees
   *   z = rotation angle on the Z axis, in degrees
   *   order = the order used to apply the rotations
   * Returns: the initialized #graphene_euler_t
   */
  Euler initWithOrder(float x, float y, float z, EulerOrder order)
  {
    graphene_euler_t* _cretval;
    _cretval = graphene_euler_init_with_order(cast(graphene_euler_t*)cPtr, x, y, z, order);
    auto _retval = _cretval ? new Euler(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Reorders a #graphene_euler_t using order.
   * This function is equivalent to creating a #graphene_quaternion_t from the
   * given #graphene_euler_t, and then converting the quaternion into another
   * #graphene_euler_t.
   * Params:
   *   order = the new order
   *   res = return location for the reordered
   *     #graphene_euler_t
   */
  void reorder(EulerOrder order, out Euler res)
  {
    graphene_euler_t _res;
    graphene_euler_reorder(cast(graphene_euler_t*)cPtr, order, &_res);
    res = new Euler(cast(void*)&_res, false);
  }

  /**
   * Converts a #graphene_euler_t into a transformation matrix expressing
   * the extrinsic composition of rotations described by the Euler angles.
   * The rotations are applied over the reference frame axes in the order
   * associated with the #graphene_euler_t; for instance, if the order
   * used to initialize e is %GRAPHENE_EULER_ORDER_XYZ:
   * * the first rotation moves the body around the X axis with
   * an angle φ
   * * the second rotation moves the body around the Y axis with
   * an angle of ϑ
   * * the third rotation moves the body around the Z axis with
   * an angle of ψ
   * The rotation sign convention is right-handed, to preserve compatibility
   * between Euler-based, quaternion-based, and angle-axis-based rotations.
   * Params:
   *   res = return location for a #graphene_matrix_t
   */
  void toMatrix(out Matrix res)
  {
    graphene_matrix_t _res;
    graphene_euler_to_matrix(cast(graphene_euler_t*)cPtr, &_res);
    res = new Matrix(cast(void*)&_res, false);
  }

  /**
   * Converts a #graphene_euler_t into a #graphene_quaternion_t.
   * Params:
   *   res = return location for a #graphene_quaternion_t
   */
  void toQuaternion(out Quaternion res)
  {
    graphene_quaternion_t _res;
    graphene_euler_to_quaternion(cast(graphene_euler_t*)cPtr, &_res);
    res = new Quaternion(cast(void*)&_res, false);
  }

  /**
   * Retrieves the angles of a #graphene_euler_t and initializes a
   * #graphene_vec3_t with them.
   * Params:
   *   res = return location for a #graphene_vec3_t
   */
  void toVec3(out Vec3 res)
  {
    graphene_vec3_t _res;
    graphene_euler_to_vec3(cast(graphene_euler_t*)cPtr, &_res);
    res = new Vec3(cast(void*)&_res, false);
  }
}
