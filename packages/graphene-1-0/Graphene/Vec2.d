module Graphene.Vec2;

import GLib.Boxed;
import Gid.gid;
import Graphene.Types;
import Graphene.c.functions;
import Graphene.c.types;

/**
 * A structure capable of holding a vector with two dimensions, x and y.
 * The contents of the #graphene_vec2_t structure are private and should
 * never be accessed directly.
 */
class Vec2 : Boxed
{

  this()
  {
    super(safeMalloc(graphene_vec2_t.sizeof), true);
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
    return graphene_vec2_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Allocates a new #graphene_vec2_t structure.
   * The contents of the returned structure are undefined.
   * Use [Graphene.Vec2.init_] to initialize the vector.
   * Returns: the newly allocated #graphene_vec2_t
   *   structure. Use [Graphene.Vec2.free] to free the resources allocated
   *   by this function.
   */
  static Vec2 alloc()
  {
    graphene_vec2_t* _cretval;
    _cretval = graphene_vec2_alloc();
    auto _retval = _cretval ? new Vec2(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Adds each component of the two passed vectors and places
   * each result into the components of res.
   * Params:
   *   b = a #graphene_vec2_t
   *   res = return location for the result
   */
  void add(Vec2 b, out Vec2 res)
  {
    graphene_vec2_t _res;
    graphene_vec2_add(cast(graphene_vec2_t*)cPtr, b ? cast(graphene_vec2_t*)b.cPtr(false) : null, &_res);
    res = new Vec2(cast(void*)&_res, false);
  }

  /**
   * Divides each component of the first operand a by the corresponding
   * component of the second operand b, and places the results into the
   * vector res.
   * Params:
   *   b = a #graphene_vec2_t
   *   res = return location for the result
   */
  void divide(Vec2 b, out Vec2 res)
  {
    graphene_vec2_t _res;
    graphene_vec2_divide(cast(graphene_vec2_t*)cPtr, b ? cast(graphene_vec2_t*)b.cPtr(false) : null, &_res);
    res = new Vec2(cast(void*)&_res, false);
  }

  /**
   * Computes the dot product of the two given vectors.
   * Params:
   *   b = a #graphene_vec2_t
   * Returns: the dot product of the vectors
   */
  float dot(Vec2 b)
  {
    float _retval;
    _retval = graphene_vec2_dot(cast(graphene_vec2_t*)cPtr, b ? cast(graphene_vec2_t*)b.cPtr(false) : null);
    return _retval;
  }

  /**
   * Checks whether the two given #graphene_vec2_t are equal.
   * Params:
   *   v2 = a #graphene_vec2_t
   * Returns: `true` if the two vectors are equal, and false otherwise
   */
  bool equal(Vec2 v2)
  {
    bool _retval;
    _retval = graphene_vec2_equal(cast(graphene_vec2_t*)cPtr, v2 ? cast(graphene_vec2_t*)v2.cPtr(false) : null);
    return _retval;
  }

  /**
   * Retrieves the X component of the #graphene_vec2_t.
   * Returns: the value of the X component
   */
  float getX()
  {
    float _retval;
    _retval = graphene_vec2_get_x(cast(graphene_vec2_t*)cPtr);
    return _retval;
  }

  /**
   * Retrieves the Y component of the #graphene_vec2_t.
   * Returns: the value of the Y component
   */
  float getY()
  {
    float _retval;
    _retval = graphene_vec2_get_y(cast(graphene_vec2_t*)cPtr);
    return _retval;
  }

  /**
   * Initializes a #graphene_vec2_t using the given values.
   * This function can be called multiple times.
   * Params:
   *   x = the X field of the vector
   *   y = the Y field of the vector
   * Returns: the initialized vector
   */
  Vec2 init_(float x, float y)
  {
    graphene_vec2_t* _cretval;
    _cretval = graphene_vec2_init(cast(graphene_vec2_t*)cPtr, x, y);
    auto _retval = _cretval ? new Vec2(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Initializes v with the contents of the given array.
   * Params:
   *   src = an array of floating point values
   *     with at least two elements
   * Returns: the initialized vector
   */
  Vec2 initFromFloat(float[] src)
  {
    graphene_vec2_t* _cretval;
    assert(!src || src.length == 2);
    auto _src = cast(const(float)*)src.ptr;
    _cretval = graphene_vec2_init_from_float(cast(graphene_vec2_t*)cPtr, _src);
    auto _retval = _cretval ? new Vec2(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Copies the contents of src into v.
   * Params:
   *   src = a #graphene_vec2_t
   * Returns: the initialized vector
   */
  Vec2 initFromVec2(Vec2 src)
  {
    graphene_vec2_t* _cretval;
    _cretval = graphene_vec2_init_from_vec2(cast(graphene_vec2_t*)cPtr, src ? cast(graphene_vec2_t*)src.cPtr(false) : null);
    auto _retval = _cretval ? new Vec2(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Linearly interpolates v1 and v2 using the given factor.
   * Params:
   *   v2 = a #graphene_vec2_t
   *   factor = the interpolation factor
   *   res = the interpolated vector
   */
  void interpolate(Vec2 v2, double factor, out Vec2 res)
  {
    graphene_vec2_t _res;
    graphene_vec2_interpolate(cast(graphene_vec2_t*)cPtr, v2 ? cast(graphene_vec2_t*)v2.cPtr(false) : null, factor, &_res);
    res = new Vec2(cast(void*)&_res, false);
  }

  /**
   * Computes the length of the given vector.
   * Returns: the length of the vector
   */
  float length()
  {
    float _retval;
    _retval = graphene_vec2_length(cast(graphene_vec2_t*)cPtr);
    return _retval;
  }

  /**
   * Compares the two given vectors and places the maximum
   * values of each component into res.
   * Params:
   *   b = a #graphene_vec2_t
   *   res = the resulting vector
   */
  void max(Vec2 b, out Vec2 res)
  {
    graphene_vec2_t _res;
    graphene_vec2_max(cast(graphene_vec2_t*)cPtr, b ? cast(graphene_vec2_t*)b.cPtr(false) : null, &_res);
    res = new Vec2(cast(void*)&_res, false);
  }

  /**
   * Compares the two given vectors and places the minimum
   * values of each component into res.
   * Params:
   *   b = a #graphene_vec2_t
   *   res = the resulting vector
   */
  void min(Vec2 b, out Vec2 res)
  {
    graphene_vec2_t _res;
    graphene_vec2_min(cast(graphene_vec2_t*)cPtr, b ? cast(graphene_vec2_t*)b.cPtr(false) : null, &_res);
    res = new Vec2(cast(void*)&_res, false);
  }

  /**
   * Multiplies each component of the two passed vectors and places
   * each result into the components of res.
   * Params:
   *   b = a #graphene_vec2_t
   *   res = return location for the result
   */
  void multiply(Vec2 b, out Vec2 res)
  {
    graphene_vec2_t _res;
    graphene_vec2_multiply(cast(graphene_vec2_t*)cPtr, b ? cast(graphene_vec2_t*)b.cPtr(false) : null, &_res);
    res = new Vec2(cast(void*)&_res, false);
  }

  /**
   * Compares the two given #graphene_vec2_t vectors and checks
   * whether their values are within the given epsilon.
   * Params:
   *   v2 = a #graphene_vec2_t
   *   epsilon = the threshold between the two vectors
   * Returns: `true` if the two vectors are near each other
   */
  bool near(Vec2 v2, float epsilon)
  {
    bool _retval;
    _retval = graphene_vec2_near(cast(graphene_vec2_t*)cPtr, v2 ? cast(graphene_vec2_t*)v2.cPtr(false) : null, epsilon);
    return _retval;
  }

  /**
   * Negates the given #graphene_vec2_t.
   * Params:
   *   res = return location for the result vector
   */
  void negate(out Vec2 res)
  {
    graphene_vec2_t _res;
    graphene_vec2_negate(cast(graphene_vec2_t*)cPtr, &_res);
    res = new Vec2(cast(void*)&_res, false);
  }

  /**
   * Computes the normalized vector for the given vector v.
   * Params:
   *   res = return location for the
   *     normalized vector
   */
  void normalize(out Vec2 res)
  {
    graphene_vec2_t _res;
    graphene_vec2_normalize(cast(graphene_vec2_t*)cPtr, &_res);
    res = new Vec2(cast(void*)&_res, false);
  }

  /**
   * Multiplies all components of the given vector with the given scalar factor.
   * Params:
   *   factor = the scalar factor
   *   res = return location for the result vector
   */
  void scale(float factor, out Vec2 res)
  {
    graphene_vec2_t _res;
    graphene_vec2_scale(cast(graphene_vec2_t*)cPtr, factor, &_res);
    res = new Vec2(cast(void*)&_res, false);
  }

  /**
   * Subtracts from each component of the first operand a the
   * corresponding component of the second operand b and places
   * each result into the components of res.
   * Params:
   *   b = a #graphene_vec2_t
   *   res = return location for the result
   */
  void subtract(Vec2 b, out Vec2 res)
  {
    graphene_vec2_t _res;
    graphene_vec2_subtract(cast(graphene_vec2_t*)cPtr, b ? cast(graphene_vec2_t*)b.cPtr(false) : null, &_res);
    res = new Vec2(cast(void*)&_res, false);
  }

  /**
   * Stores the components of v into an array.
   * Params:
   *   dest = return location
   *     for an array of floating point values with at least 2 elements
   */
  void toFloat(ref float[] dest)
  {
    graphene_vec2_to_float(cast(graphene_vec2_t*)cPtr, dest.ptr);
  }

  /**
   * Retrieves a constant vector with $(LPAREN)1, 1$(RPAREN) components.
   * Returns: the one vector
   */
  static Vec2 one()
  {
    const(graphene_vec2_t)* _cretval;
    _cretval = graphene_vec2_one();
    auto _retval = _cretval ? new Vec2(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Retrieves a constant vector with $(LPAREN)1, 0$(RPAREN) components.
   * Returns: the X axis vector
   */
  static Vec2 xAxis()
  {
    const(graphene_vec2_t)* _cretval;
    _cretval = graphene_vec2_x_axis();
    auto _retval = _cretval ? new Vec2(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Retrieves a constant vector with $(LPAREN)0, 1$(RPAREN) components.
   * Returns: the Y axis vector
   */
  static Vec2 yAxis()
  {
    const(graphene_vec2_t)* _cretval;
    _cretval = graphene_vec2_y_axis();
    auto _retval = _cretval ? new Vec2(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Retrieves a constant vector with $(LPAREN)0, 0$(RPAREN) components.
   * Returns: the zero vector
   */
  static Vec2 zero()
  {
    const(graphene_vec2_t)* _cretval;
    _cretval = graphene_vec2_zero();
    auto _retval = _cretval ? new Vec2(cast(void*)_cretval, false) : null;
    return _retval;
  }
}
