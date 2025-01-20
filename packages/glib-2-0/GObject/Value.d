module GObject.Value;

import GLib.Boxed;
import GLib.Variant;
import GObject.ObjectG;
import GObject.ParamSpec;
import GObject.TypeInstance;
import GObject.Types;
import GObject.c.functions;
import GObject.c.types;
import Gid.gid;


import std.traits : isPointer;

import GObject.ObjectG;
import GObject.Types;

/**
 * An opaque structure used to hold different types of values.
 * The data within the structure has protected scope: it is accessible only
 * to functions within a #GTypeValueTable structure, or implementations of
 * the g_value_*$(LPAREN)$(RPAREN) API. That is, code portions which implement new fundamental
 * types.
 * #GValue users cannot make any assumptions about how data is stored
 * within the 2 element @data union, and the @g_type member should
 * only be accessed through the G_VALUE_TYPE$(LPAREN)$(RPAREN) macro.
 */
class Value : Boxed
{

  this()
  {
    super(safeMalloc(GValue.sizeof), true);
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
    return g_value_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Template to create a new Value from a D type.
   * Params:
   *   T = The D type to initialize the value to
   *   val = The value to assign
   */
  static Value create(T)(T val)
  {
    Value value = new Value;
    value.init_!T();
    value.set!T(val);
    return value;
  }

  /**
   * Template to initialize a Value to a D type.
   * Params:
   *   T = The D type to initialize the Value to
   */
  void init_(T)()
  {
    initVal!T(cast(GValue*)cPtr);
  }

  /**
   * Template to get a Value of a specific type.
   * Params:
   *   T = The D type of the value to get (must match the type of the Value)
   * Returns: The value
   */
  T get(T)()
  {
    return getVal!T(cast(GValue*)cPtr);
  }

  /**
   * Template to set a Value of a specific type.
   * Params:
   *   T = The D type of the value to set (must match the type of the Value)
   *   val = The value to assign
   */
  void set(T)(T val)
  {
    return setVal!T(cast(GValue*)cPtr, val);
  }

  /**
   * Copies the value of src_value into dest_value.
   * Params:
   *   destValue = An initialized #GValue structure of the same type as src_value.
   */
  void copy(Value destValue)
  {
    g_value_copy(cast(GValue*)cPtr, destValue ? cast(GValue*)destValue.cPtr(false) : null);
  }

  /**
   * Get the contents of a %G_TYPE_OBJECT derived #GValue, increasing
   * its reference count. If the contents of the #GValue are %NULL, then
   * %NULL will be returned.
   * Returns: object content of value,
   *   should be unreferenced when no longer needed.
   */
  ObjectG dupObject()
  {
    ObjectC* _cretval;
    _cretval = g_value_dup_object(cast(GValue*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!ObjectG(cast(ObjectC*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Get a copy the contents of a %G_TYPE_STRING #GValue.
   * Returns: a newly allocated copy of the string content of value
   */
  string dupString()
  {
    char* _cretval;
    _cretval = g_value_dup_string(cast(GValue*)cPtr);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * Get the contents of a variant #GValue, increasing its refcount. The returned
   * #GVariant is never floating.
   * Returns: variant contents of value $(LPAREN)may be %NULL$(RPAREN);
   *   should be unreffed using [GLib.Variant.unref] when no longer needed
   */
  Variant dupVariant()
  {
    GVariant* _cretval;
    _cretval = g_value_dup_variant(cast(GValue*)cPtr);
    auto _retval = _cretval ? new Variant(cast(GVariant*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Determines if value will fit inside the size of a pointer value.
   * This is an internal function introduced mainly for C marshallers.
   * Returns: %TRUE if value will fit inside a pointer value.
   */
  bool fitsPointer()
  {
    bool _retval;
    _retval = g_value_fits_pointer(cast(GValue*)cPtr);
    return _retval;
  }

  /**
   * Get the contents of a %G_TYPE_BOOLEAN #GValue.
   * Returns: boolean contents of value
   */
  bool getBoolean()
  {
    bool _retval;
    _retval = g_value_get_boolean(cast(GValue*)cPtr);
    return _retval;
  }

  /**
   * Get the contents of a %G_TYPE_BOXED derived #GValue.
   * Returns: boxed contents of value
   */
  void* getBoxed()
  {
    void* _retval;
    _retval = g_value_get_boxed(cast(GValue*)cPtr);
    return _retval;
  }

  /**
   * Do not use this function; it is broken on platforms where the %char
   * type is unsigned, such as ARM and PowerPC.  See [GObject.Value.getSchar].
   * Get the contents of a %G_TYPE_CHAR #GValue.
   * Returns: character contents of value

   * Deprecated: This function's return type is broken, see [GObject.Value.getSchar]
   */
  char getChar()
  {
    char _retval;
    _retval = g_value_get_char(cast(GValue*)cPtr);
    return _retval;
  }

  /**
   * Get the contents of a %G_TYPE_DOUBLE #GValue.
   * Returns: double contents of value
   */
  double getDouble()
  {
    double _retval;
    _retval = g_value_get_double(cast(GValue*)cPtr);
    return _retval;
  }

  /**
   * Get the contents of a %G_TYPE_ENUM #GValue.
   * Returns: enum contents of value
   */
  int getEnum()
  {
    int _retval;
    _retval = g_value_get_enum(cast(GValue*)cPtr);
    return _retval;
  }

  /**
   * Get the contents of a %G_TYPE_FLAGS #GValue.
   * Returns: flags contents of value
   */
  uint getFlags()
  {
    uint _retval;
    _retval = g_value_get_flags(cast(GValue*)cPtr);
    return _retval;
  }

  /**
   * Get the contents of a %G_TYPE_FLOAT #GValue.
   * Returns: float contents of value
   */
  float getFloat()
  {
    float _retval;
    _retval = g_value_get_float(cast(GValue*)cPtr);
    return _retval;
  }

  /**
   * Get the contents of a %G_TYPE_GTYPE #GValue.
   * Returns: the #GType stored in value
   */
  GType getGtype()
  {
    GType _retval;
    _retval = g_value_get_gtype(cast(GValue*)cPtr);
    return _retval;
  }

  /**
   * Get the contents of a %G_TYPE_INT #GValue.
   * Returns: integer contents of value
   */
  int getInt()
  {
    int _retval;
    _retval = g_value_get_int(cast(GValue*)cPtr);
    return _retval;
  }

  /**
   * Get the contents of a %G_TYPE_INT64 #GValue.
   * Returns: 64bit integer contents of value
   */
  long getInt64()
  {
    long _retval;
    _retval = g_value_get_int64(cast(GValue*)cPtr);
    return _retval;
  }

  /**
   * Get the contents of a %G_TYPE_LONG #GValue.
   * Returns: long integer contents of value
   */
  long getLong()
  {
    long _retval;
    _retval = g_value_get_long(cast(GValue*)cPtr);
    return _retval;
  }

  /**
   * Get the contents of a %G_TYPE_OBJECT derived #GValue.
   * Returns: object contents of value
   */
  ObjectG getObject()
  {
    ObjectC* _cretval;
    _cretval = g_value_get_object(cast(GValue*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!ObjectG(cast(ObjectC*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Get the contents of a %G_TYPE_PARAM #GValue.
   * Returns: #GParamSpec content of value
   */
  ParamSpec getParam()
  {
    GParamSpec* _cretval;
    _cretval = g_value_get_param(cast(GValue*)cPtr);
    auto _retval = _cretval ? new ParamSpec(cast(GParamSpec*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Get the contents of a pointer #GValue.
   * Returns: pointer contents of value
   */
  void* getPointer()
  {
    void* _retval;
    _retval = g_value_get_pointer(cast(GValue*)cPtr);
    return _retval;
  }

  /**
   * Get the contents of a %G_TYPE_CHAR #GValue.
   * Returns: signed 8 bit integer contents of value
   */
  byte getSchar()
  {
    byte _retval;
    _retval = g_value_get_schar(cast(GValue*)cPtr);
    return _retval;
  }

  /**
   * Get the contents of a %G_TYPE_STRING #GValue.
   * Returns: string content of value
   */
  string getString()
  {
    const(char)* _cretval;
    _cretval = g_value_get_string(cast(GValue*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Get the contents of a %G_TYPE_UCHAR #GValue.
   * Returns: unsigned character contents of value
   */
  ubyte getUchar()
  {
    ubyte _retval;
    _retval = g_value_get_uchar(cast(GValue*)cPtr);
    return _retval;
  }

  /**
   * Get the contents of a %G_TYPE_UINT #GValue.
   * Returns: unsigned integer contents of value
   */
  uint getUint()
  {
    uint _retval;
    _retval = g_value_get_uint(cast(GValue*)cPtr);
    return _retval;
  }

  /**
   * Get the contents of a %G_TYPE_UINT64 #GValue.
   * Returns: unsigned 64bit integer contents of value
   */
  ulong getUint64()
  {
    ulong _retval;
    _retval = g_value_get_uint64(cast(GValue*)cPtr);
    return _retval;
  }

  /**
   * Get the contents of a %G_TYPE_ULONG #GValue.
   * Returns: unsigned long integer contents of value
   */
  ulong getUlong()
  {
    ulong _retval;
    _retval = g_value_get_ulong(cast(GValue*)cPtr);
    return _retval;
  }

  /**
   * Get the contents of a variant #GValue.
   * Returns: variant contents of value $(LPAREN)may be %NULL$(RPAREN)
   */
  Variant getVariant()
  {
    GVariant* _cretval;
    _cretval = g_value_get_variant(cast(GValue*)cPtr);
    auto _retval = _cretval ? new Variant(cast(GVariant*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Initializes value with the default value of type.
   * Params:
   *   gType = Type the #GValue should hold values of.
   * Returns: the #GValue structure that has been passed in
   */
  Value init_(GType gType)
  {
    GValue* _cretval;
    _cretval = g_value_init(cast(GValue*)cPtr, gType);
    auto _retval = _cretval ? new Value(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Initializes and sets value from an instantiatable type via the
   * value_table's collect_value$(LPAREN)$(RPAREN) function.
   * Note: The value will be initialised with the exact type of
   * instance.  If you wish to set the value's type to a different GType
   * $(LPAREN)such as a parent class GType$(RPAREN), you need to manually call
   * [GObject.Value.init_] and [GObject.Value.setInstance].
   * Params:
   *   instance = the instance
   */
  void initFromInstance(TypeInstance instance)
  {
    g_value_init_from_instance(cast(GValue*)cPtr, instance ? cast(GTypeInstance*)instance.cPtr : null);
  }

  /**
   * Returns the value contents as pointer. This function asserts that
   * [GObject.Value.fitsPointer] returned %TRUE for the passed in value.
   * This is an internal function introduced mainly for C marshallers.
   * Returns: the value contents as pointer
   */
  void* peekPointer()
  {
    void* _retval;
    _retval = g_value_peek_pointer(cast(GValue*)cPtr);
    return _retval;
  }

  /**
   * Clears the current value in value and resets it to the default value
   * $(LPAREN)as if the value had just been initialized$(RPAREN).
   * Returns: the #GValue structure that has been passed in
   */
  Value reset()
  {
    GValue* _cretval;
    _cretval = g_value_reset(cast(GValue*)cPtr);
    auto _retval = _cretval ? new Value(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Set the contents of a %G_TYPE_BOOLEAN #GValue to v_boolean.
   * Params:
   *   vBoolean = boolean value to be set
   */
  void setBoolean(bool vBoolean)
  {
    g_value_set_boolean(cast(GValue*)cPtr, vBoolean);
  }

  /**
   * Set the contents of a %G_TYPE_BOXED derived #GValue to v_boxed.
   * Params:
   *   vBoxed = boxed value to be set
   */
  void setBoxed(const(void)* vBoxed)
  {
    g_value_set_boxed(cast(GValue*)cPtr, vBoxed);
  }

  /**
   * This is an internal function introduced mainly for C marshallers.
   * Params:
   *   vBoxed = duplicated unowned boxed value to be set

   * Deprecated: Use [GObject.Value.takeBoxed] instead.
   */
  void setBoxedTakeOwnership(const(void)* vBoxed)
  {
    g_value_set_boxed_take_ownership(cast(GValue*)cPtr, vBoxed);
  }

  /**
   * Set the contents of a %G_TYPE_CHAR #GValue to v_char.
   * Params:
   *   vChar = character value to be set

   * Deprecated: This function's input type is broken, see [GObject.Value.setSchar]
   */
  void setChar(char vChar)
  {
    g_value_set_char(cast(GValue*)cPtr, vChar);
  }

  /**
   * Set the contents of a %G_TYPE_DOUBLE #GValue to v_double.
   * Params:
   *   vDouble = double value to be set
   */
  void setDouble(double vDouble)
  {
    g_value_set_double(cast(GValue*)cPtr, vDouble);
  }

  /**
   * Set the contents of a %G_TYPE_ENUM #GValue to v_enum.
   * Params:
   *   vEnum = enum value to be set
   */
  void setEnum(int vEnum)
  {
    g_value_set_enum(cast(GValue*)cPtr, vEnum);
  }

  /**
   * Set the contents of a %G_TYPE_FLAGS #GValue to v_flags.
   * Params:
   *   vFlags = flags value to be set
   */
  void setFlags(uint vFlags)
  {
    g_value_set_flags(cast(GValue*)cPtr, vFlags);
  }

  /**
   * Set the contents of a %G_TYPE_FLOAT #GValue to v_float.
   * Params:
   *   vFloat = float value to be set
   */
  void setFloat(float vFloat)
  {
    g_value_set_float(cast(GValue*)cPtr, vFloat);
  }

  /**
   * Set the contents of a %G_TYPE_GTYPE #GValue to v_gtype.
   * Params:
   *   vGtype = #GType to be set
   */
  void setGtype(GType vGtype)
  {
    g_value_set_gtype(cast(GValue*)cPtr, vGtype);
  }

  /**
   * Sets value from an instantiatable type via the
   * value_table's collect_value$(LPAREN)$(RPAREN) function.
   * Params:
   *   instance = the instance
   */
  void setInstance(void* instance)
  {
    g_value_set_instance(cast(GValue*)cPtr, instance);
  }

  /**
   * Set the contents of a %G_TYPE_INT #GValue to v_int.
   * Params:
   *   vInt = integer value to be set
   */
  void setInt(int vInt)
  {
    g_value_set_int(cast(GValue*)cPtr, vInt);
  }

  /**
   * Set the contents of a %G_TYPE_INT64 #GValue to v_int64.
   * Params:
   *   vInt64 = 64bit integer value to be set
   */
  void setInt64(long vInt64)
  {
    g_value_set_int64(cast(GValue*)cPtr, vInt64);
  }

  /**
   * Set the contents of a %G_TYPE_STRING #GValue to v_string.  The string is
   * assumed to be static and interned $(LPAREN)canonical, for example from
   * [GLib.Global.internString]$(RPAREN), and is thus not duplicated when setting the #GValue.
   * Params:
   *   vString = static string to be set
   */
  void setInternedString(string vString)
  {
    const(char)* _vString = vString.toCString(false);
    g_value_set_interned_string(cast(GValue*)cPtr, _vString);
  }

  /**
   * Set the contents of a %G_TYPE_LONG #GValue to v_long.
   * Params:
   *   vLong = long integer value to be set
   */
  void setLong(long vLong)
  {
    g_value_set_long(cast(GValue*)cPtr, vLong);
  }

  /**
   * Set the contents of a %G_TYPE_OBJECT derived #GValue to v_object.
   * [GObject.Value.setObject] increases the reference count of v_object
   * $(LPAREN)the #GValue holds a reference to v_object$(RPAREN).  If you do not wish
   * to increase the reference count of the object $(LPAREN)i.e. you wish to
   * pass your current reference to the #GValue because you no longer
   * need it$(RPAREN), use [GObject.Value.takeObject] instead.
   * It is important that your #GValue holds a reference to v_object $(LPAREN)either its
   * own, or one it has taken$(RPAREN) to ensure that the object won't be destroyed while
   * the #GValue still exists$(RPAREN).
   * Params:
   *   vObject = object value to be set
   */
  void setObject(ObjectG vObject)
  {
    g_value_set_object(cast(GValue*)cPtr, vObject ? cast(ObjectC*)vObject.cPtr(false) : null);
  }

  /**
   * Set the contents of a %G_TYPE_PARAM #GValue to param.
   * Params:
   *   param = the #GParamSpec to be set
   */
  void setParam(ParamSpec param)
  {
    g_value_set_param(cast(GValue*)cPtr, param ? cast(GParamSpec*)param.cPtr(false) : null);
  }

  /**
   * Set the contents of a pointer #GValue to v_pointer.
   * Params:
   *   vPointer = pointer value to be set
   */
  void setPointer(void* vPointer)
  {
    g_value_set_pointer(cast(GValue*)cPtr, vPointer);
  }

  /**
   * Set the contents of a %G_TYPE_CHAR #GValue to v_char.
   * Params:
   *   vChar = signed 8 bit integer to be set
   */
  void setSchar(byte vChar)
  {
    g_value_set_schar(cast(GValue*)cPtr, vChar);
  }

  /**
   * Set the contents of a %G_TYPE_BOXED derived #GValue to v_boxed.
   * The boxed value is assumed to be static, and is thus not duplicated
   * when setting the #GValue.
   * Params:
   *   vBoxed = static boxed value to be set
   */
  void setStaticBoxed(const(void)* vBoxed)
  {
    g_value_set_static_boxed(cast(GValue*)cPtr, vBoxed);
  }

  /**
   * Set the contents of a %G_TYPE_STRING #GValue to v_string.
   * The string is assumed to be static, and is thus not duplicated
   * when setting the #GValue.
   * If the the string is a canonical string, using [GObject.Value.setInternedString]
   * is more appropriate.
   * Params:
   *   vString = static string to be set
   */
  void setStaticString(string vString)
  {
    const(char)* _vString = vString.toCString(false);
    g_value_set_static_string(cast(GValue*)cPtr, _vString);
  }

  /**
   * Set the contents of a %G_TYPE_STRING #GValue to a copy of v_string.
   * Params:
   *   vString = caller-owned string to be duplicated for the #GValue
   */
  void setString(string vString)
  {
    const(char)* _vString = vString.toCString(false);
    g_value_set_string(cast(GValue*)cPtr, _vString);
  }

  /**
   * This is an internal function introduced mainly for C marshallers.
   * Params:
   *   vString = duplicated unowned string to be set

   * Deprecated: Use [GObject.Value.takeString] instead.
   */
  void setStringTakeOwnership(string vString)
  {
    char* _vString = vString.toCString(false);
    g_value_set_string_take_ownership(cast(GValue*)cPtr, _vString);
  }

  /**
   * Set the contents of a %G_TYPE_UCHAR #GValue to v_uchar.
   * Params:
   *   vUchar = unsigned character value to be set
   */
  void setUchar(ubyte vUchar)
  {
    g_value_set_uchar(cast(GValue*)cPtr, vUchar);
  }

  /**
   * Set the contents of a %G_TYPE_UINT #GValue to v_uint.
   * Params:
   *   vUint = unsigned integer value to be set
   */
  void setUint(uint vUint)
  {
    g_value_set_uint(cast(GValue*)cPtr, vUint);
  }

  /**
   * Set the contents of a %G_TYPE_UINT64 #GValue to v_uint64.
   * Params:
   *   vUint64 = unsigned 64bit integer value to be set
   */
  void setUint64(ulong vUint64)
  {
    g_value_set_uint64(cast(GValue*)cPtr, vUint64);
  }

  /**
   * Set the contents of a %G_TYPE_ULONG #GValue to v_ulong.
   * Params:
   *   vUlong = unsigned long integer value to be set
   */
  void setUlong(ulong vUlong)
  {
    g_value_set_ulong(cast(GValue*)cPtr, vUlong);
  }

  /**
   * Set the contents of a variant #GValue to variant.
   * If the variant is floating, it is consumed.
   * Params:
   *   variant = a #GVariant, or %NULL
   */
  void setVariant(Variant variant)
  {
    g_value_set_variant(cast(GValue*)cPtr, variant ? cast(GVariant*)variant.cPtr(false) : null);
  }

  /**
   * Steal ownership on contents of a %G_TYPE_STRING #GValue.
   * As a result of this operation the value's contents will be reset to %NULL.
   * The purpose of this call is to provide a way to avoid an extra copy
   * when some object have been serialized into string through #GValue API.
   * NOTE: for safety and compatibility purposes, if #GValue contains
   * static string, or an interned one, this function will return a copy
   * of the string. Otherwise the transfer notation would be ambiguous.
   * Returns: string content of value;
   *   Should be freed with [GLib.Global.gfree] when no longer needed.
   */
  string stealString()
  {
    char* _cretval;
    _cretval = g_value_steal_string(cast(GValue*)cPtr);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * Sets the contents of a %G_TYPE_BOXED derived #GValue to v_boxed
   * and takes over the ownership of the caller’s reference to v_boxed;
   * the caller doesn’t have to unref it any more.
   * Params:
   *   vBoxed = duplicated unowned boxed value to be set
   */
  void takeBoxed(const(void)* vBoxed)
  {
    g_value_take_boxed(cast(GValue*)cPtr, vBoxed);
  }

  /**
   * Sets the contents of a %G_TYPE_STRING #GValue to v_string.
   * Params:
   *   vString = string to take ownership of
   */
  void takeString(string vString)
  {
    char* _vString = vString.toCString(true);
    g_value_take_string(cast(GValue*)cPtr, _vString);
  }

  /**
   * Set the contents of a variant #GValue to variant, and takes over
   * the ownership of the caller's reference to variant;
   * the caller doesn't have to unref it any more $(LPAREN)i.e. the reference
   * count of the variant is not increased$(RPAREN).
   * If variant was floating then its floating reference is converted to
   * a hard reference.
   * If you want the #GValue to hold its own reference to variant, use
   * [GObject.Value.setVariant] instead.
   * This is an internal function introduced mainly for C marshallers.
   * Params:
   *   variant = a #GVariant, or %NULL
   */
  void takeVariant(Variant variant)
  {
    g_value_take_variant(cast(GValue*)cPtr, variant ? cast(GVariant*)variant.cPtr(true) : null);
  }

  /**
   * Tries to cast the contents of src_value into a type appropriate
   * to store in dest_value, e.g. to transform a %G_TYPE_INT value
   * into a %G_TYPE_FLOAT value. Performing transformations between
   * value types might incur precision lossage. Especially
   * transformations into strings might reveal seemingly arbitrary
   * results and shouldn't be relied upon for production code $(LPAREN)such
   * as rcfile value or object property serialization$(RPAREN).
   * Params:
   *   destValue = Target value.
   * Returns: Whether a transformation rule was found and could be applied.
   *   Upon failing transformations, dest_value is left untouched.
   */
  bool transform(Value destValue)
  {
    bool _retval;
    _retval = g_value_transform(cast(GValue*)cPtr, destValue ? cast(GValue*)destValue.cPtr(false) : null);
    return _retval;
  }

  /**
   * Clears the current value in value $(LPAREN)if any$(RPAREN) and "unsets" the type,
   * this releases all resources associated with this GValue. An unset
   * value is the same as an uninitialized $(LPAREN)zero-filled$(RPAREN) #GValue
   * structure.
   */
  void unset()
  {
    g_value_unset(cast(GValue*)cPtr);
  }

  /**
   * Returns whether a #GValue of type src_type can be copied into
   * a #GValue of type dest_type.
   * Params:
   *   srcType = source type to be copied.
   *   destType = destination type for copying.
   * Returns: %TRUE if [GObject.Value.copy] is possible with src_type and dest_type.
   */
  static bool typeCompatible(GType srcType, GType destType)
  {
    bool _retval;
    _retval = g_value_type_compatible(srcType, destType);
    return _retval;
  }

  /**
   * Check whether [GObject.Value.transform] is able to transform values
   * of type src_type into values of type dest_type. Note that for
   * the types to be transformable, they must be compatible or a
   * transformation function must be registered.
   * Params:
   *   srcType = Source type.
   *   destType = Target type.
   * Returns: %TRUE if the transformation is possible, %FALSE otherwise.
   */
  static bool typeTransformable(GType srcType, GType destType)
  {
    bool _retval;
    _retval = g_value_type_transformable(srcType, destType);
    return _retval;
  }
}

void initVal(T)(GValue* gval)
{
  static if (is(T == bool))
    g_value_init(gval, GTypeEnum.Boolean);
  else static if (is(T == byte))
    g_value_init(gval, GTypeEnum.Char);
  else static if (is(T == ubyte))
    g_value_init(gval, GTypeEnum.Uchar);
  else static if (is(T == int))
    g_value_init(gval, GTypeEnum.Int);
  else static if (is(T == uint))
    g_value_init(gval, GTypeEnum.Uint);
  else static if (is(T == long))
    g_value_init(gval, GTypeEnum.Int64);
  else static if (is(T == ulong))
    g_value_init(gval, GTypeEnum.Uint64);
  else static if (is(T == float))
    g_value_init(gval, GTypeEnum.Float);
  else static if (is(T == double))
    g_value_init(gval, GTypeEnum.Double);
  else static if (is(T == enum)) // FIXME enum or flags
    g_value_init(gval, GTypeEnum.Enum);
  else static if (is(T == string))
    g_value_init(gval, GTypeEnum.String);
  else static if (is(T == Variant))
    g_value_init(gval, GTypeEnum.Variant);
  else static if (is(T : ParamSpec))
    g_value_init(gval, GTypeEnum.Param);
  else static if (is(T : Boxed))
    g_value_init(gval, GTypeEnum.Boxed);
  else static if (is(T : ObjectG) || is(T == interface))
    g_value_init(gval, GTypeEnum.Object);
  else static if (is(T : Object) || isPointer!T)
    g_value_init(gval, GTypeEnum.Pointer);
  else
    assert(0);
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
  {
    auto v = g_value_get_variant(gval);
    return v ? new Variant(v, false) : null;
  }
  else static if (is(T : ParamSpec))
  {
    auto v = g_value_get_param(gval);
    return v ? new T(v, false) : null;
  }
  else static if (is(T : Boxed))
  {
    auto v = g_value_get_boxed(gval);
    return v ? new T(v, false) : null;
  }
  else static if (is(T : ObjectG) || is(T == interface))
  {
    auto v = g_value_get_object(gval);
    return v ? ObjectG.getDObject!T(v, false) : null;
  }
  else static if (is(T : Object) || isPointer!T)
    return cast(T)g_value_get_pointer(gval);
  else
    assert(0);
}

/// Template to set a GValue to a given D type (must have been initialized to the proper type)
void setVal(T)(GValue* gval, T v)
{
  static if (is(T == bool))
    g_value_set_boolean(gval, v);
  else static if (is(T == byte))
    g_value_set_schar(gval, v);
  else static if (is(T == ubyte))
    g_value_set_uchar(gval, v);
  else static if (is(T == int))
    g_value_set_int(gval, v);
  else static if (is(T == uint))
    g_value_set_uint(gval, v);
  else static if (is(T == long))
    g_value_set_int64(gval, v);
  else static if (is(T == ulong))
    g_value_set_uint64(gval, v);
  else static if (is(T == float))
    g_value_set_float(gval, v);
  else static if (is(T == double))
    g_value_set_double(gval, v);
  else static if (is(T == enum))
  {
    if (g_type_is_a(gval.gType, GTypeEnum.Flags))
      g_value_set_flags(gval, v);
    else
      g_value_set_enum(gval, v);
  }
  else static if (is(T == string))
    g_value_take_string(gval, v.toCString(true));
  else static if (is(T == Variant))
    g_value_set_variant(gval, v.cPtr!GVariant);
  else static if (is(T : ParamSpec))
    g_value_set_param(gval, v.cPtr!GParamSpec);
  else static if (is(T : Boxed))
    g_value_set_boxed(gval, v.cInstancePtr);
  else static if (is(T : ObjectG) || is(T == interface))
    g_value_set_object(gval, cast(ObjectC*)v.cPtr(false));
  else static if (is(T : Object) || isPointer!T)
    g_value_set_pointer(gval, cast(void*)v);
  else
    assert(0);
}
