//!generate init
//!generate funcs

import std.traits : isSomeString;
import std.typecons : isTuple;

class VariantType : Boxed
{

  /**
   * Template for creating a new VariantType from one or more D types
   * Returns: New variant type
   */
  static VariantType create(T...)()
  {
    return new VariantType(getStr!T);
  }

  /**
   * Template to get a variant type string from one or more D types (type strings are concatenated)
   * Returns: Variant type string which can be used with VariantType
   */
  static string getStr(T...)()
  {
    char[] typeStr;

    foreach (Arg; T)
    {
      static if (is(Arg == bool))
        typeStr ~= "b";
      else static if (is(Arg == byte) || is(Arg == ubyte))
        typeStr ~= "y";
      else static if (is(Arg == short))
        typeStr ~= "n";
      else static if (is(Arg == ushort))
        typeStr ~= "q";
      else static if (is(Arg == int))
        typeStr ~= "i";
      else static if (is(Arg == uint))
        typeStr ~= "u";
      else static if (is(Arg == long))
        typeStr ~= "x";
      else static if (is(Arg == ulong))
        typeStr ~= "t";
      else static if (is(Arg == float) || is(Arg == double))
        typeStr ~= "d";
      else static if (isSomeString!Arg)
        typeStr ~= "s";
      else static if (is(Arg : E[], E))
        typeStr ~= "a" ~ getStr!E;
      else static if (is(Arg : V[K], V, K))
        typeStr ~= "a{" ~ getStr!K ~ getStr!V ~ "}";
      else static if (Arg == Variant)
        typeStr ~= "v";
      else static if (isTuple!Arg)
        typeStr ~= "r";
      else
        static assert(false, "Unsupported type for Variant creation: " ~ Arg.stringof);
    }

    return cast(string)typeStr;
  }
}
