//!generate init
//!generate funcs

import GLib.VariantBuilder;
import GLib.VariantType;

import std.conv : to;
import std.traits : isSomeString;
import std.typecons : isTuple, Tuple;
import std.variant : Variant;

class VariantG
{

  override bool opEquals(Object other)
  {
    if (auto otherVariant = cast(VariantG)other)
      return equal(otherVariant);
    else
      return super.opEquals(other);
  }

  override int opCmp(Object other)
  {
    if (auto otherVariant = cast(VariantG)other)
      return compare(otherVariant);
    else
      return super.opCmp(other);
  }

  override string toString()
  {
    return print(true);
  }

  /**
   * Template to create a new VariantG from a single D value.
   * Params:
   *   T = The D type to create the variant from
   *   val = The value to assign
   */
  static VariantG create(T)(T val)
  {
    static if (is(T == bool))
      return newBoolean(val);
    else static if (is(T == byte) || is(T == ubyte))
      return newByte(val);
    else static if (is(T == short))
      return newInt16(val);
    else static if (is(T == ushort))
      return newUint16(val);
    else static if (is(T == int))
      return newInt32(val);
    else static if (is(T == uint))
      return newUint32(val);
    else static if (is(T == long))
      return newInt64(val);
    else static if (is(T == ulong))
      return newUint64(val);
    else static if (is(T == float) || is(T == double))
      return newDouble(val);
    else static if (isSomeString!T)
      return newString(val.to!string);
    else static if (is(T : E[], E))
    {
      VariantBuilder builder = new VariantBuilder(VariantType.create!T);

      foreach (item; val)
        builder.addValue(create(item));

      return builder.end;
    }
    else static if (is(T : V[K], V, K)) // Dictionary
    {
      VariantBuilder builder = new VariantBuilder(VariantType.create!T);

      foreach (k, v; val)
        builder.addValue(newDictEntry(create(k), create(v)));

      return builder.end;
    }
    else static if (is(T == VariantG)) // A variant (copy it)
      return VariantG.newVariant(val);
    else static if (is(T == Variant)) // std.variant.Variant (only basic types supported currently)
    {
      if (val.type is typeid(bool))
        return create(val.get!bool);
      else if (val.type is typeid(byte) || val.type is typeid(ubyte))
        return create(val.coerce!byte);
      else if (val.type is typeid(short))
        return create(val.get!short);
      else if (val.type is typeid(ushort))
        return create(val.get!ushort);
      else if (val.type is typeid(int))
        return create(val.get!int);
      else if (val.type is typeid(uint))
        return create(val.get!uint);
      else if (val.type is typeid(long))
        return create(val.get!long);
      else if (val.type is typeid(ulong))
        return create(val.get!ulong);
      else if (val.type is typeid(float) || val.type is typeid(double))
        return create(val.coerce!double);
      else if (val.type is typeid(string) || val.type is typeid(wstring) || val.type is typeid(dstring))
        return create(val.coerce!string);
      else
        assert(false, "VariantG.create does not support D Variant type " ~ val.type.to!string);
    }
    else static if (isTuple!T)
      return create(val.expand);
    else
      static assert(false, "Unsupported type for VariantG.create: " ~ T.stringof);
  }

  /**
   * Template to create a new VariantG from multiple D values. The variant is constructed as a Variant tuple container.
   * Params:
   *   T = The D types to create the variant from
   *   vals = The value to assign
   */
  static VariantG create(T...)(T vals)
    if (vals.length > 1)
  {
    VariantBuilder builder = new VariantBuilder(new VariantType("r")); // Build a tuple container variant

    foreach (v; vals)
      builder.addValue(create(v));

    return builder.end;
  }

  /**
   * Template to get a single value from a VariantG
   */
  T get(T)()
  {
    static if (is(T == bool))
      return getBoolean;
    else static if (is(T == byte) || is(T == ubyte))
      return cast(T)getByte;
    else static if (is(T == short))
      return getInt16;
    else static if (is(T == ushort))
      return getUint16;
    else static if (is(T == int))
      return getInt32;
    else static if (is(T == uint))
      return getUint32;
    else static if (is(T == long))
      return getInt64;
    else static if (is(T == ulong))
      return getUint64;
    else static if (is(T == float) || is(T == double))
      return cast(T)getDouble;
    else static if (isSomeString!T)
      return getString.to!T;
    else static if (is(T : E[], E))
    {
      T valArray;
      valArray.length = nChildren;

      foreach (i; 0 .. valArray.length)
        valArray[i] = getChildValue(i).get!E;

      return valArray;
    }
    else static if (is(T : V[K], V, K)) // Dictionary
    {
      T dict;

      foreach (i; 0 .. nChildren)
        dict[getChildValue(i).getChildValue(0).get!K] = getChildValue(i).getChildValue(1).get!V; // VariantG dict entries hold 2 values (key, value)

      return dict;
    }
    else static if (is(T == VariantG)) // A variant (unwrap it)
      return getVariant;
    else static if (is(T == Variant)) // std.variant.Variant (only basic types supported currently)
    {
      if (getType.isBasic)
      {
        switch (getTypeStr[0])
        {
          case 'b':
            return Variant(get!bool);
          case 'y':
            return Variant(get!byte);
          case 'n':
            return Variant(get!short);
          case 'q':
            return Variant(get!ushort);
          case 'i':
            return Variant(get!int);
          case 'u':
            return Variant(get!uint);
          case 'x':
            return Variant(get!long);
          case 't':
            return Variant(get!ulong);
          case 'd':
            return Variant(get!double);
          case 's':
            return Variant(coerce!string);
          default:
            assert(false, "VariantG.create does not support D Variant type " ~ val.type.to!string);
        }
      }
    }
    else static if (isTuple!T)
      return create(val.expand);
    else
      static assert(false, "Unsupported type for VariantG.get: " ~ T.stringof);
  }

  /**
   * Template to get multiple values from a VariantG
   */
  auto get(T...)()
    if (T.length > 1)
  {
    Tuple!T vals;

    foreach (i, E; T)
      vals[i] = getChildValue(i).get!E;

    return vals;
  }
}
