module GObject.Value;

import GLib.Boxed;
import GLib.Types;
import GLib.Variant;
import GObject.ObjectG;
import GObject.ParamSpec;
import GObject.TypeInstance;
import GObject.Types;
import GObject.c.functions;
import GObject.c.types;
import Gid.Gid;
import std.traits : isPointer;




/**
 * An opaque structure used to hold different types of values.
 *
 * The data within the structure has protected scope: it is accessible only
 * to functions within a #GTypeValueTable structure, or implementations of
 * the g_value_*() API. That is, code portions which implement new fundamental
 * types.
 *
 * #GValue users cannot make any assumptions about how data is stored
 * within the 2 element @data union, and the @g_type member should
 * only be accessed through the G_VALUE_TYPE() macro.
 */
class Value : Boxed
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  T* cPtr(T)(bool makeCopy = false)
  if (is(T == GValue))
  {
    return makeCopy ? copy_!T : cast(T*)cInstancePtr;
  }

  static GType getType()
  {
    return g_value_get_type();
  }

  /**
   * Copies the value of @src_value into @dest_value.
   */
  void copy(Value destValue)
  {
    g_value_copy(cPtr!GValue, destValue ? destValue.cPtr!GValue : null);
  }

  /**
   * object content of @value,
   * should be unreferenced when no longer needed.
   */
  ObjectG dupObject()
  {
    ObjectC* _cretval;
    _cretval = g_value_dup_object(cPtr!GValue);
    ObjectG _retval = ObjectG.getDObject!ObjectG(cast(ObjectC*)_cretval, true);
    return _retval;
  }

  /**
   * a newly allocated copy of the string content of @value
   */
  string dupString()
  {
    char* _cretval;
    _cretval = g_value_dup_string(cPtr!GValue);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * variant contents of @value (may be %NULL);
   * should be unreffed using g_variant_unref() when no longer needed
   */
  Variant dupVariant()
  {
    GVariant* _cretval;
    _cretval = g_value_dup_variant(cPtr!GValue);
    Variant _retval = new Variant(cast(GVariant*)_cretval, true);
    return _retval;
  }

  /**
   * %TRUE if @value will fit inside a pointer value.
   */
  bool fitsPointer()
  {
    bool _retval;
    _retval = g_value_fits_pointer(cPtr!GValue);
    return _retval;
  }

  /**
   * boolean contents of @value
   */
  bool getBoolean()
  {
    bool _retval;
    _retval = g_value_get_boolean(cPtr!GValue);
    return _retval;
  }

  /**
   * boxed contents of @value
   */
  void* getBoxed()
  {
    void* _retval;
    _retval = g_value_get_boxed(cPtr!GValue);
    return _retval;
  }

  /**
   * character contents of @value
   */
  char getChar()
  {
    char _retval;
    _retval = g_value_get_char(cPtr!GValue);
    return _retval;
  }

  /**
   * double contents of @value
   */
  double getDouble()
  {
    double _retval;
    _retval = g_value_get_double(cPtr!GValue);
    return _retval;
  }

  /**
   * enum contents of @value
   */
  int getEnum()
  {
    int _retval;
    _retval = g_value_get_enum(cPtr!GValue);
    return _retval;
  }

  /**
   * flags contents of @value
   */
  uint getFlags()
  {
    uint _retval;
    _retval = g_value_get_flags(cPtr!GValue);
    return _retval;
  }

  /**
   * float contents of @value
   */
  float getFloat()
  {
    float _retval;
    _retval = g_value_get_float(cPtr!GValue);
    return _retval;
  }

  /**
   * the #GType stored in @value
   */
  GType getGtype()
  {
    GType _retval;
    _retval = g_value_get_gtype(cPtr!GValue);
    return _retval;
  }

  /**
   * integer contents of @value
   */
  int getInt()
  {
    int _retval;
    _retval = g_value_get_int(cPtr!GValue);
    return _retval;
  }

  /**
   * 64bit integer contents of @value
   */
  long getInt64()
  {
    long _retval;
    _retval = g_value_get_int64(cPtr!GValue);
    return _retval;
  }

  /**
   * long integer contents of @value
   */
  long getLong()
  {
    long _retval;
    _retval = g_value_get_long(cPtr!GValue);
    return _retval;
  }

  /**
   * object contents of @value
   */
  ObjectG getObject()
  {
    ObjectC* _cretval;
    _cretval = g_value_get_object(cPtr!GValue);
    ObjectG _retval = ObjectG.getDObject!ObjectG(cast(ObjectC*)_cretval, false);
    return _retval;
  }

  /**
   * #GParamSpec content of @value
   */
  ParamSpec getParam()
  {
    GParamSpec* _cretval;
    _cretval = g_value_get_param(cPtr!GValue);
    ParamSpec _retval = new ParamSpec(cast(GParamSpec*)_cretval, false);
    return _retval;
  }

  /**
   * pointer contents of @value
   */
  void* getPointer()
  {
    void* _retval;
    _retval = g_value_get_pointer(cPtr!GValue);
    return _retval;
  }

  /**
   * signed 8 bit integer contents of @value
   */
  byte getSchar()
  {
    byte _retval;
    _retval = g_value_get_schar(cPtr!GValue);
    return _retval;
  }

  /**
   * string content of @value
   */
  string getString()
  {
    const(char)* _cretval;
    _cretval = g_value_get_string(cPtr!GValue);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * unsigned character contents of @value
   */
  ubyte getUchar()
  {
    ubyte _retval;
    _retval = g_value_get_uchar(cPtr!GValue);
    return _retval;
  }

  /**
   * unsigned integer contents of @value
   */
  uint getUint()
  {
    uint _retval;
    _retval = g_value_get_uint(cPtr!GValue);
    return _retval;
  }

  /**
   * unsigned 64bit integer contents of @value
   */
  ulong getUint64()
  {
    ulong _retval;
    _retval = g_value_get_uint64(cPtr!GValue);
    return _retval;
  }

  /**
   * unsigned long integer contents of @value
   */
  ulong getUlong()
  {
    ulong _retval;
    _retval = g_value_get_ulong(cPtr!GValue);
    return _retval;
  }

  /**
   * variant contents of @value (may be %NULL)
   */
  Variant getVariant()
  {
    GVariant* _cretval;
    _cretval = g_value_get_variant(cPtr!GValue);
    Variant _retval = new Variant(cast(GVariant*)_cretval, false);
    return _retval;
  }

  /**
   * the #GValue structure that has been passed in
   */
  Value init_(GType gType)
  {
    GValue* _cretval;
    _cretval = g_value_init(cPtr!GValue, gType);
    Value _retval = new Value(cast(GValue*)_cretval, false);
    return _retval;
  }

  /**
   * Initializes and sets @value from an instantiatable type via the
   * value_table's collect_value() function.
   *
   * Note: The @value will be initialised with the exact type of
   * @instance.  If you wish to set the @value's type to a different GType
   * (such as a parent class GType), you need to manually call
   * g_value_init() and g_value_set_instance().
   */
  void initFromInstance(TypeInstance instance)
  {
    g_value_init_from_instance(cPtr!GValue, instance ? instance.cPtr!GTypeInstance : null);
  }

  /**
   * the value contents as pointer
   */
  void* peekPointer()
  {
    void* _retval;
    _retval = g_value_peek_pointer(cPtr!GValue);
    return _retval;
  }

  /**
   * the #GValue structure that has been passed in
   */
  Value reset()
  {
    GValue* _cretval;
    _cretval = g_value_reset(cPtr!GValue);
    Value _retval = new Value(cast(GValue*)_cretval, true);
    return _retval;
  }

  /**
   * Set the contents of a %G_TYPE_BOOLEAN #GValue to @v_boolean.
   */
  void setBoolean(bool vBoolean)
  {
    g_value_set_boolean(cPtr!GValue, vBoolean);
  }

  /**
   * Set the contents of a %G_TYPE_BOXED derived #GValue to @v_boxed.
   */
  void setBoxed(const(void)* vBoxed)
  {
    g_value_set_boxed(cPtr!GValue, vBoxed);
  }

  /**
   * This is an internal function introduced mainly for C marshallers.
   */
  void setBoxedTakeOwnership(const(void)* vBoxed)
  {
    g_value_set_boxed_take_ownership(cPtr!GValue, vBoxed);
  }

  /**
   * Set the contents of a %G_TYPE_CHAR #GValue to @v_char.
   */
  void setChar(char vChar)
  {
    g_value_set_char(cPtr!GValue, vChar);
  }

  /**
   * Set the contents of a %G_TYPE_DOUBLE #GValue to @v_double.
   */
  void setDouble(double vDouble)
  {
    g_value_set_double(cPtr!GValue, vDouble);
  }

  /**
   * Set the contents of a %G_TYPE_ENUM #GValue to @v_enum.
   */
  void setEnum(int vEnum)
  {
    g_value_set_enum(cPtr!GValue, vEnum);
  }

  /**
   * Set the contents of a %G_TYPE_FLAGS #GValue to @v_flags.
   */
  void setFlags(uint vFlags)
  {
    g_value_set_flags(cPtr!GValue, vFlags);
  }

  /**
   * Set the contents of a %G_TYPE_FLOAT #GValue to @v_float.
   */
  void setFloat(float vFloat)
  {
    g_value_set_float(cPtr!GValue, vFloat);
  }

  /**
   * Set the contents of a %G_TYPE_GTYPE #GValue to @v_gtype.
   */
  void setGtype(GType vGtype)
  {
    g_value_set_gtype(cPtr!GValue, vGtype);
  }

  /**
   * Sets @value from an instantiatable type via the
   * value_table's collect_value() function.
   */
  void setInstance(void* instance)
  {
    g_value_set_instance(cPtr!GValue, instance);
  }

  /**
   * Set the contents of a %G_TYPE_INT #GValue to @v_int.
   */
  void setInt(int vInt)
  {
    g_value_set_int(cPtr!GValue, vInt);
  }

  /**
   * Set the contents of a %G_TYPE_INT64 #GValue to @v_int64.
   */
  void setInt64(long vInt64)
  {
    g_value_set_int64(cPtr!GValue, vInt64);
  }

  /**
   * Set the contents of a %G_TYPE_STRING #GValue to @v_string.  The string is
   * assumed to be static and interned (canonical, for example from
   * g_intern_string()), and is thus not duplicated when setting the #GValue.
   */
  void setInternedString(string vString)
  {
    const(char)* _vString = vString.toCString(false);
    g_value_set_interned_string(cPtr!GValue, _vString);
  }

  /**
   * Set the contents of a %G_TYPE_LONG #GValue to @v_long.
   */
  void setLong(long vLong)
  {
    g_value_set_long(cPtr!GValue, vLong);
  }

  /**
   * Set the contents of a %G_TYPE_OBJECT derived #GValue to @v_object.
   *
   * g_value_set_object() increases the reference count of @v_object
   * (the #GValue holds a reference to @v_object).  If you do not wish
   * to increase the reference count of the object (i.e. you wish to
   * pass your current reference to the #GValue because you no longer
   * need it), use g_value_take_object() instead.
   *
   * It is important that your #GValue holds a reference to @v_object (either its
   * own, or one it has taken) to ensure that the object won't be destroyed while
   * the #GValue still exists).
   */
  void setObject(ObjectG vObject)
  {
    g_value_set_object(cPtr!GValue, vObject ? vObject.cPtr!ObjectC : null);
  }

  /**
   * Set the contents of a %G_TYPE_PARAM #GValue to @param.
   */
  void setParam(ParamSpec param)
  {
    g_value_set_param(cPtr!GValue, param ? param.cPtr!GParamSpec : null);
  }

  /**
   * Set the contents of a pointer #GValue to @v_pointer.
   */
  void setPointer(void* vPointer)
  {
    g_value_set_pointer(cPtr!GValue, vPointer);
  }

  /**
   * Set the contents of a %G_TYPE_CHAR #GValue to @v_char.
   */
  void setSchar(byte vChar)
  {
    g_value_set_schar(cPtr!GValue, vChar);
  }

  /**
   * Set the contents of a %G_TYPE_BOXED derived #GValue to @v_boxed.
   *
   * The boxed value is assumed to be static, and is thus not duplicated
   * when setting the #GValue.
   */
  void setStaticBoxed(const(void)* vBoxed)
  {
    g_value_set_static_boxed(cPtr!GValue, vBoxed);
  }

  /**
   * Set the contents of a %G_TYPE_STRING #GValue to @v_string.
   * The string is assumed to be static, and is thus not duplicated
   * when setting the #GValue.
   *
   * If the the string is a canonical string, using g_value_set_interned_string()
   * is more appropriate.
   */
  void setStaticString(string vString)
  {
    const(char)* _vString = vString.toCString(false);
    g_value_set_static_string(cPtr!GValue, _vString);
  }

  /**
   * Set the contents of a %G_TYPE_STRING #GValue to a copy of @v_string.
   */
  void setString(string vString)
  {
    const(char)* _vString = vString.toCString(false);
    g_value_set_string(cPtr!GValue, _vString);
  }

  /**
   * This is an internal function introduced mainly for C marshallers.
   */
  void setStringTakeOwnership(string vString)
  {
    char* _vString = vString.toCString(false);
    g_value_set_string_take_ownership(cPtr!GValue, _vString);
  }

  /**
   * Set the contents of a %G_TYPE_UCHAR #GValue to @v_uchar.
   */
  void setUchar(ubyte vUchar)
  {
    g_value_set_uchar(cPtr!GValue, vUchar);
  }

  /**
   * Set the contents of a %G_TYPE_UINT #GValue to @v_uint.
   */
  void setUint(uint vUint)
  {
    g_value_set_uint(cPtr!GValue, vUint);
  }

  /**
   * Set the contents of a %G_TYPE_UINT64 #GValue to @v_uint64.
   */
  void setUint64(ulong vUint64)
  {
    g_value_set_uint64(cPtr!GValue, vUint64);
  }

  /**
   * Set the contents of a %G_TYPE_ULONG #GValue to @v_ulong.
   */
  void setUlong(ulong vUlong)
  {
    g_value_set_ulong(cPtr!GValue, vUlong);
  }

  /**
   * Set the contents of a variant #GValue to @variant.
   * If the variant is floating, it is consumed.
   */
  void setVariant(Variant variant)
  {
    g_value_set_variant(cPtr!GValue, variant ? variant.cPtr!GVariant : null);
  }

  /**
   * Sets the contents of a %G_TYPE_BOXED derived #GValue to @v_boxed
   * and takes over the ownership of the caller’s reference to @v_boxed;
   * the caller doesn’t have to unref it any more.
   */
  void takeBoxed(const(void)* vBoxed)
  {
    g_value_take_boxed(cPtr!GValue, vBoxed);
  }

  /**
   * Sets the contents of a %G_TYPE_STRING #GValue to @v_string.
   */
  void takeString(string vString)
  {
    char* _vString = vString.toCString(true);
    g_value_take_string(cPtr!GValue, _vString);
  }

  /**
   * Set the contents of a variant #GValue to @variant, and takes over
   * the ownership of the caller's reference to @variant;
   * the caller doesn't have to unref it any more (i.e. the reference
   * count of the variant is not increased).
   *
   * If @variant was floating then its floating reference is converted to
   * a hard reference.
   *
   * If you want the #GValue to hold its own reference to @variant, use
   * g_value_set_variant() instead.
   *
   * This is an internal function introduced mainly for C marshallers.
   */
  void takeVariant(Variant variant)
  {
    g_value_take_variant(cPtr!GValue, variant ? variant.cPtr!GVariant : null);
  }

  /**
   * Whether a transformation rule was found and could be applied.
   * Upon failing transformations, @dest_value is left untouched.
   */
  bool transform(Value destValue)
  {
    bool _retval;
    _retval = g_value_transform(cPtr!GValue, destValue ? destValue.cPtr!GValue : null);
    return _retval;
  }

  /**
   * Clears the current value in @value (if any) and "unsets" the type,
   * this releases all resources associated with this GValue. An unset
   * value is the same as an uninitialized (zero-filled) #GValue
   * structure.
   */
  void unset()
  {
    g_value_unset(cPtr!GValue);
  }

  /**
   * %TRUE if g_value_copy() is possible with @src_type and @dest_type.
   */
  static bool typeCompatible(GType srcType, GType destType)
  {
    bool _retval;
    _retval = g_value_type_compatible(srcType, destType);
    return _retval;
  }

  /**
   * %TRUE if the transformation is possible, %FALSE otherwise.
   */
  static bool typeTransformable(GType srcType, GType destType)
  {
    bool _retval;
    _retval = g_value_type_transformable(srcType, destType);
    return _retval;
  }
}

/// Template to get a value from a GValue of a given D type (must contain the correct type)
T getVal(T)(const(GValue)* gval)
{
  static if (is(T == bool))
    return g_value_get_boolean(gval);
  else static if (is(T == byte))
    return g_value_get_schar(gval);
  else static if (is(T == ubyte))
    return g_value_get_uchar(gval);
  else static if (is(T == int))
    return g_value_get_int(gval);
  else static if (is(T == uint))
    return g_value_get_uint(gval);
  else static if (is(T == long))
    return g_value_get_int64(gval);
  else static if (is(T == ulong))
    return g_value_get_uint64(gval);
  else static if (is(T == float))
    return g_value_get_float(gval);
  else static if (is(T == double))
    return g_value_get_double(gval);
  else static if (is(T == enum)) // enum or flags
    return g_type_is_a(gval.gType, GTypeEnum.Flags) ? cast(T)g_value_get_flags(gval) : cast(T)g_value_get_enum(gval);
  else static if (is(T == string))
    return g_value_get_string(gval).fromCString(false);
  else static if (is(T == Variant))
    return new Variant(g_value_get_variant(gval), false);
  else static if (is(T : ParamSpec))
    return new T(g_value_get_param(gval), false);
  else static if (is(T : Boxed))
    return new T(g_value_get_boxed(gval), false);
  else static if (is(T : ObjectG))
    return new T(g_value_get_object(gval), false);
  else static if (isPointer!T)
    return cast(T)g_value_get_pointer(gval);
  else
    assert(0);

  // g_value_get_gtype - FIXME?
}

/// Template to set a GValue to a given D type (must have been initialized to the proper type)
void setVal(T)(GValue* gval, T v)
{
  static if (is(T == bool))
    return g_value_set_boolean(gval, v);
  else static if (is(T == byte))
    return g_value_set_schar(gval, v);
  else static if (is(T == ubyte))
    return g_value_set_uchar(gval, v);
  else static if (is(T == int))
    return g_value_set_int(gval, v);
  else static if (is(T == uint))
    return g_value_set_uint(gval, v);
  else static if (is(T == long))
    return g_value_set_int64(gval, v);
  else static if (is(T == ulong))
    return g_value_set_uint64(gval, v);
  else static if (is(T == float))
    return g_value_set_float(gval, v);
  else static if (is(T == double))
    return g_value_set_double(gval, v);
  else static if (is(T == enum)) // enum or flags
    return g_type_is_a(gval.gType, GTypeEnum.Flags) ? cast(T)g_value_set_flags(gval, v) : cast(T)g_value_set_enum(gval, v);
  else static if (is(T == string))
    return g_value_take_string(gval, v).toCString(true);
  else static if (is(T == Variant))
    return g_value_set_variant(gval, v.cPtr!GVariant);
  else static if (is(T : ParamSpec))
    return g_value_set_param(gval, v.cPtr!GParamSpec);
  else static if (is(T : Boxed))
    return g_value_set_boxed(gval, v.cInstancePtr);
  else static if (is(T : ObjectG))
    return g_value_set_object(gval, v.cPtr!ObjectC);
  else static if (isPointer!T)
    return g_value_set_pointer(gval, v);
  else
    assert(0);

  // g_value_set_gtype - FIXME?
}
