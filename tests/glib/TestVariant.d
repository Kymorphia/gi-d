module glib.TestVariant;

import std.typecons : tuple;
import std.variant : Variant;

import GLib.VariantG;

unittest
{
  // Test create template for basic types
  assert(VariantG.create(true).get!bool == true);
  assert(VariantG.create(false).get!bool == false);
  assert(VariantG.create(byte.max).get!byte == byte.max);
  assert(VariantG.create(ubyte.max).get!ubyte == ubyte.max);
  assert(VariantG.create(short.max).get!short == short.max);
  assert(VariantG.create(ushort.max).get!ushort == ushort.max);
  assert(VariantG.create(int.max).get!int == int.max);
  assert(VariantG.create(uint.max).get!uint == uint.max);
  assert(VariantG.create(long.max).get!long == long.max);
  assert(VariantG.create(ulong.max).get!ulong == ulong.max);
  assert(VariantG.create(3.14f).get!float == 3.14f);
  assert(VariantG.create(3.14).get!double == 3.14);
  assert(VariantG.create("test").get!string == "test");

  // Test create with array types
  int[] intArray = [1, 2, 3];
  VariantG varArray = VariantG.create(intArray);
  assert(varArray.get!(int[]) == intArray);

  string[] strArray = ["uno", "dos", "tres"];
  varArray = VariantG.create(strArray);
  assert(varArray.get!(string[]) == strArray);

  // Test create with dictionary type
  int[string] dict = ["one": 1, "two": 2];
  VariantG varDict = VariantG.create(dict);
  assert(varDict.get!(int[string]) == dict);

  // Test creating multiple values in one variant
  VariantG multi = VariantG.create(1, "str", 3.14f);
  auto result = multi.get!(int, string, float);
  assert(result[0] == 1);
  assert(result[1] == "str");
  assert(result[2] == 3.14f);

  // Test variant of variant
  VariantG inner = VariantG.create(42);
  VariantG outer = VariantG.create(inner);
  assert(outer.get!VariantG.get!int == 42);

  // Test std.variant.Variant
  Variant stdVar = Variant(123);
  VariantG fromStdVar = VariantG.create(stdVar);
  assert(fromStdVar.get!int == 123);
}
