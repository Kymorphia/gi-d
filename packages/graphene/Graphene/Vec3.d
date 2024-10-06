module Graphene.Vec3;

import GLib.Boxed;
import Gid.gid;
import Graphene.Types;
import Graphene.Vec2;
import Graphene.Vec4;
import Graphene.c.functions;
import Graphene.c.types;

/**
 * A structure capable of holding a vector with three dimensions: x, y, and z.
 * The contents of the #graphene_vec3_t structure are private and should
 * never be accessed directly.
 */
class Vec3 : Boxed
{

  this()
  {
    super(safeMalloc(graphene_vec3_t.sizeof), true);
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
    return graphene_vec3_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Allocates a new #graphene_vec3_t structure.
   * The contents of the returned structure are undefined.
   * Use [Graphene.Vec3.init_] to initialize the vector.
   * Returns: the newly allocated #graphene_vec3_t
   *   structure. Use [Graphene.Vec3.free] to free the resources allocated
   *   by this function.
   */
  static Vec3 alloc()
  {
    graphene_vec3_t* _cretval;
    _cretval = graphene_vec3_alloc();
    auto _retval = _cretval ? new Vec3(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Adds each component of the two given vectors.
   * Params:
   *   b = a #graphene_vec3_t
   *   res = return location for the resulting vector
   */
  void add(Vec3 b, out Vec3 res)
  {
    graphene_vec3_t _res;
    graphene_vec3_add(cast(graphene_vec3_t*)cPtr, b ? cast(graphene_vec3_t*)b.cPtr(false) : null, &_res);
    res = new Vec3(cast(void*)&_res, false);
  }

  /**
   * Computes the cross product of the two given vectors.
   * Params:
   *   b = a #graphene_vec3_t
   *   res = return location for the resulting vector
   */
  void cross(Vec3 b, out Vec3 res)
  {
    graphene_vec3_t _res;
    graphene_vec3_cross(cast(graphene_vec3_t*)cPtr, b ? cast(graphene_vec3_t*)b.cPtr(false) : null, &_res);
    res = new Vec3(cast(void*)&_res, false);
  }

  /**
   * Divides each component of the first operand a by the corresponding
   * component of the second operand b, and places the results into the
   * vector res.
   * Params:
   *   b = a #graphene_vec3_t
   *   res = return location for the resulting vector
   */
  void divide(Vec3 b, out Vec3 res)
  {
    graphene_vec3_t _res;
    graphene_vec3_divide(cast(graphene_vec3_t*)cPtr, b ? cast(graphene_vec3_t*)b.cPtr(false) : null, &_res);
    res = new Vec3(cast(void*)&_res, false);
  }

  /**
   * Computes the dot product of the two given vectors.
   * Params:
   *   b = a #graphene_vec3_t
   * Returns: the value of the dot product
   */
  float dot(Vec3 b)
  {
    float _retval;
    _retval = graphene_vec3_dot(cast(graphene_vec3_t*)cPtr, b ? cast(graphene_vec3_t*)b.cPtr(false) : null);
    return _retval;
  }

  /**
   * Checks whether the two given #graphene_vec3_t are equal.
   * Params:
   *   v2 = a #graphene_vec3_t
   * Returns: `true` if the two vectors are equal, and false otherwise
   */
  bool equal(Vec3 v2)
  {
    bool _retval;
    _retval = graphene_vec3_equal(cast(graphene_vec3_t*)cPtr, v2 ? cast(graphene_vec3_t*)v2.cPtr(false) : null);
    return _retval;
  }

  /**
   * Retrieves the first component of the given vector v.
   * Returns: the value of the first component of the vector
   */
  float getX()
  {
    float _retval;
    _retval = graphene_vec3_get_x(cast(graphene_vec3_t*)cPtr);
    return _retval;
  }

  /**
   * Creates a #graphene_vec2_t that contains the first and second
   * components of the given #graphene_vec3_t.
   * Params:
   *   res = return location for a #graphene_vec2_t
   */
  void getXy(out Vec2 res)
  {
    graphene_vec2_t _res;
    graphene_vec3_get_xy(cast(graphene_vec3_t*)cPtr, &_res);
    res = new Vec2(cast(void*)&_res, false);
  }

  /**
   * Creates a #graphene_vec3_t that contains the first two components of
   * the given #graphene_vec3_t, and the third component set to 0.
   * Params:
   *   res = return location for a #graphene_vec3_t
   */
  void getXy0(out Vec3 res)
  {
    graphene_vec3_t _res;
    graphene_vec3_get_xy0(cast(graphene_vec3_t*)cPtr, &_res);
    res = new Vec3(cast(void*)&_res, false);
  }

  /**
   * Converts a #graphene_vec3_t in a #graphene_vec4_t using 0.0
   * as the value for the fourth component of the resulting vector.
   * Params:
   *   res = return location for the vector
   */
  void getXyz0(out Vec4 res)
  {
    graphene_vec4_t _res;
    graphene_vec3_get_xyz0(cast(graphene_vec3_t*)cPtr, &_res);
    res = new Vec4(cast(void*)&_res, false);
  }

  /**
   * Converts a #graphene_vec3_t in a #graphene_vec4_t using 1.0
   * as the value for the fourth component of the resulting vector.
   * Params:
   *   res = return location for the vector
   */
  void getXyz1(out Vec4 res)
  {
    graphene_vec4_t _res;
    graphene_vec3_get_xyz1(cast(graphene_vec3_t*)cPtr, &_res);
    res = new Vec4(cast(void*)&_res, false);
  }

  /**
   * Converts a #graphene_vec3_t in a #graphene_vec4_t using w as
   * the value of the fourth component of the resulting vector.
   * Params:
   *   w = the value of the W component
   *   res = return location for the vector
   */
  void getXyzw(float w, out Vec4 res)
  {
    graphene_vec4_t _res;
    graphene_vec3_get_xyzw(cast(graphene_vec3_t*)cPtr, w, &_res);
    res = new Vec4(cast(void*)&_res, false);
  }

  /**
   * Retrieves the second component of the given vector v.
   * Returns: the value of the second component of the vector
   */
  float getY()
  {
    float _retval;
    _retval = graphene_vec3_get_y(cast(graphene_vec3_t*)cPtr);
    return _retval;
  }

  /**
   * Retrieves the third component of the given vector v.
   * Returns: the value of the third component of the vector
   */
  float getZ()
  {
    float _retval;
    _retval = graphene_vec3_get_z(cast(graphene_vec3_t*)cPtr);
    return _retval;
  }

  /**
   * Initializes a #graphene_vec3_t using the given values.
   * This function can be called multiple times.
   * Params:
   *   x = the X field of the vector
   *   y = the Y field of the vector
   *   z = the Z field of the vector
   * Returns: a pointer to the initialized
   *   vector
   */
  Vec3 init_(float x, float y, float z)
  {
    graphene_vec3_t* _cretval;
    _cretval = graphene_vec3_init(cast(graphene_vec3_t*)cPtr, x, y, z);
    auto _retval = _cretval ? new Vec3(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Initializes a #graphene_vec3_t with the values from an array.
   * Params:
   *   src = an array of 3 floating point values
   * Returns: the initialized vector
   */
  Vec3 initFromFloat(float[] src)
  {
    graphene_vec3_t* _cretval;
    assert(!src || src.length == 3);
    auto _src = cast(const(float)*)src.ptr;
    _cretval = graphene_vec3_init_from_float(cast(graphene_vec3_t*)cPtr, _src);
    auto _retval = _cretval ? new Vec3(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Initializes a #graphene_vec3_t with the values of another
   * #graphene_vec3_t.
   * Params:
   *   src = a #graphene_vec3_t
   * Returns: the initialized vector
   */
  Vec3 initFromVec3(Vec3 src)
  {
    graphene_vec3_t* _cretval;
    _cretval = graphene_vec3_init_from_vec3(cast(graphene_vec3_t*)cPtr, src ? cast(graphene_vec3_t*)src.cPtr(false) : null);
    auto _retval = _cretval ? new Vec3(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Linearly interpolates v1 and v2 using the given factor.
   * Params:
   *   v2 = a #graphene_vec3_t
   *   factor = the interpolation factor
   *   res = the interpolated vector
   */
  void interpolate(Vec3 v2, double factor, out Vec3 res)
  {
    graphene_vec3_t _res;
    graphene_vec3_interpolate(cast(graphene_vec3_t*)cPtr, v2 ? cast(graphene_vec3_t*)v2.cPtr(false) : null, factor, &_res);
    res = new Vec3(cast(void*)&_res, false);
  }

  /**
   * Retrieves the length of the given vector v.
   * Returns: the value of the length of the vector
   */
  float length()
  {
    float _retval;
    _retval = graphene_vec3_length(cast(graphene_vec3_t*)cPtr);
    return _retval;
  }

  /**
   * Compares each component of the two given vectors and creates a
   * vector that contains the maximum values.
   * Params:
   *   b = a #graphene_vec3_t
   *   res = return location for the result vector
   */
  void max(Vec3 b, out Vec3 res)
  {
    graphene_vec3_t _res;
    graphene_vec3_max(cast(graphene_vec3_t*)cPtr, b ? cast(graphene_vec3_t*)b.cPtr(false) : null, &_res);
    res = new Vec3(cast(void*)&_res, false);
  }

  /**
   * Compares each component of the two given vectors and creates a
   * vector that contains the minimum values.
   * Params:
   *   b = a #graphene_vec3_t
   *   res = return location for the result vector
   */
  void min(Vec3 b, out Vec3 res)
  {
    graphene_vec3_t _res;
    graphene_vec3_min(cast(graphene_vec3_t*)cPtr, b ? cast(graphene_vec3_t*)b.cPtr(false) : null, &_res);
    res = new Vec3(cast(void*)&_res, false);
  }

  /**
   * Multiplies each component of the two given vectors.
   * Params:
   *   b = a #graphene_vec3_t
   *   res = return location for the resulting vector
   */
  void multiply(Vec3 b, out Vec3 res)
  {
    graphene_vec3_t _res;
    graphene_vec3_multiply(cast(graphene_vec3_t*)cPtr, b ? cast(graphene_vec3_t*)b.cPtr(false) : null, &_res);
    res = new Vec3(cast(void*)&_res, false);
  }

  /**
   * Compares the two given #graphene_vec3_t vectors and checks
   * whether their values are within the given epsilon.
   * Params:
   *   v2 = a #graphene_vec3_t
   *   epsilon = the threshold between the two vectors
   * Returns: `true` if the two vectors are near each other
   */
  bool near(Vec3 v2, float epsilon)
  {
    bool _retval;
    _retval = graphene_vec3_near(cast(graphene_vec3_t*)cPtr, v2 ? cast(graphene_vec3_t*)v2.cPtr(false) : null, epsilon);
    return _retval;
  }

  /**
   * Negates the given #graphene_vec3_t.
   * Params:
   *   res = return location for the result vector
   */
  void negate(out Vec3 res)
  {
    graphene_vec3_t _res;
    graphene_vec3_negate(cast(graphene_vec3_t*)cPtr, &_res);
    res = new Vec3(cast(void*)&_res, false);
  }

  /**
   * Normalizes the given #graphene_vec3_t.
   * Params:
   *   res = return location for the normalized vector
   */
  void normalize(out Vec3 res)
  {
    graphene_vec3_t _res;
    graphene_vec3_normalize(cast(graphene_vec3_t*)cPtr, &_res);
    res = new Vec3(cast(void*)&_res, false);
  }

  /**
   * Multiplies all components of the given vector with the given scalar factor.
   * Params:
   *   factor = the scalar factor
   *   res = return location for the result vector
   */
  void scale(float factor, out Vec3 res)
  {
    graphene_vec3_t _res;
    graphene_vec3_scale(cast(graphene_vec3_t*)cPtr, factor, &_res);
    res = new Vec3(cast(void*)&_res, false);
  }

  /**
   * Subtracts from each component of the first operand a the
   * corresponding component of the second operand b and places
   * each result into the components of res.
   * Params:
   *   b = a #graphene_vec3_t
   *   res = return location for the resulting vector
   */
  void subtract(Vec3 b, out Vec3 res)
  {
    graphene_vec3_t _res;
    graphene_vec3_subtract(cast(graphene_vec3_t*)cPtr, b ? cast(graphene_vec3_t*)b.cPtr(false) : null, &_res);
    res = new Vec3(cast(void*)&_res, false);
  }

  /**
   * Provides a constant pointer to a vector with three components,
   * all sets to 1.
   * Returns: a constant vector
   */
  static Vec3 one()
  {
    const(graphene_vec3_t)* _cretval;
    _cretval = graphene_vec3_one();
    auto _retval = _cretval ? new Vec3(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Provides a constant pointer to a vector with three components
   * with values set to $(LPAREN)1, 0, 0$(RPAREN).
   * Returns: a constant vector
   */
  static Vec3 xAxis()
  {
    const(graphene_vec3_t)* _cretval;
    _cretval = graphene_vec3_x_axis();
    auto _retval = _cretval ? new Vec3(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Provides a constant pointer to a vector with three components
   * with values set to $(LPAREN)0, 1, 0$(RPAREN).
   * Returns: a constant vector
   */
  static Vec3 yAxis()
  {
    const(graphene_vec3_t)* _cretval;
    _cretval = graphene_vec3_y_axis();
    auto _retval = _cretval ? new Vec3(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Provides a constant pointer to a vector with three components
   * with values set to $(LPAREN)0, 0, 1$(RPAREN).
   * Returns: a constant vector
   */
  static Vec3 zAxis()
  {
    const(graphene_vec3_t)* _cretval;
    _cretval = graphene_vec3_z_axis();
    auto _retval = _cretval ? new Vec3(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Provides a constant pointer to a vector with three components,
   * all sets to 0.
   * Returns: a constant vector
   */
  static Vec3 zero()
  {
    const(graphene_vec3_t)* _cretval;
    _cretval = graphene_vec3_zero();
    auto _retval = _cretval ? new Vec3(cast(void*)_cretval, false) : null;
    return _retval;
  }
}
