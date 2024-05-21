//!generate init
//!generate funcs

import std.traits : isPointer;

import GObject.Types;

class Value : Boxed
{
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
  else static if (is(T : ObjectG))
    g_value_set_object(gval, cast(ObjectC*)v.cPtr(false));
  else static if (isPointer!T)
    g_value_set_pointer(gval, v);
  else
    assert(0);

  // g_value_set_gtype - FIXME?
}
