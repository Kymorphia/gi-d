//!generate init
//!generate funcs

import std.traits : isPointer;

import GObject.ObjectG;
import GObject.Types;

class Value : Boxed
{

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
