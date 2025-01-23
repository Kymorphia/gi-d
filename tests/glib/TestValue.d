module glib.TestValue;

import std.conv : to;
import std.typecons : tuple;

import GLib.String;
import GLib.VariantG;
import GObject.ObjectG;
import GObject.Types;
import GObject.Value;

interface TestInterface {}

// For some reason embedding this in unittest leads to an error (something about function context being needed to `new` nested class)
class TestObj : ObjectG, TestInterface
{
  this()
  {
    super(GTypeEnum.Object);
  }

  this(void* instance, bool owned = false)
  {
    super(instance, owned);
  }
}

unittest
{
  enum TestEnum {First, Last}

  auto testVariant = VariantG.create([1, 2, 3]);
  auto testObj = new TestObj;
  auto testIface = cast(TestInterface)testObj;
  int i;
  auto testPtr = &i;

  auto testVals = tuple(
    true,
    byte.max,
    ubyte.max,
    int.max,
    uint.max,
    long.max,
    ulong.max,
    3.14f,
    3.14,
    TestEnum.First,
    "Test string",
    testVariant,
    testObj,
    testIface,
    testPtr,
  );

  foreach (testval; testVals)
  {
    auto value = Value.create(testval);
    assert(value.get!(typeof(testval)) == testval, "Value does not match test value for type "
      ~ typeof(testval).stringof);
  }

  auto testBoxed = new String("Test GString");
  auto value = Value.create(testBoxed);
  auto cmpBoxed = value.get!String;
  assert(testBoxed.str == cmpBoxed.str);

  // Test a regular D object (not ObjectG derived), it just ends up being a pointer
  auto testDObject = new Object;
  value = Value.create(testDObject);
  auto cmpDObject = value.get!Object;
  assert(testDObject is cmpDObject);
}
