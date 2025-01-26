module glib.TestGid;

import std.algorithm : equal, map;
import std.traits : KeyType, ValueType;
import std.typecons : tuple;

import Gid.gid;
import GObject.ObjectG;
import GObject.Types : GTypeEnum;
import GObject.Value;

interface TestIface
{
}

class TestObjClass : ObjectG, TestIface
{
  this()
  {
    super(GTypeEnum.Object);
  }

  this(void* cObj, bool owned)
  {
  }
}

unittest
{
  ubyte[] array = [1, 2, 3];
  auto byteArray = gByteArrayFromD(array);
  auto cmpArray = gByteArrayToD!(GidOwnership.Full)(byteArray);
  assert(array == cmpArray);

  auto gBytes = gBytesFromD(array);
  cmpArray = gBytesToD!(GidOwnership.Full)(gBytes);
  assert(array == cmpArray);

  auto obj = new TestObjClass;
  auto iface = cast(TestIface)obj;
  auto boxed = Value.create(69);

  struct TestStruct
  {
    double a = 42.0;
    int b = 13;
  }

  TestStruct st;

  auto testArrays = tuple(
    [1, 2, 3],
    [1.0, 2.0, 3.0],
    [st],
  );

  auto testComplexArrays = tuple(
    ["one", "two", "three"],
    [obj],
    [boxed],
    [cast(void*)123],
  );

  foreach (testArray; testArrays ~ testComplexArrays)
  {
    auto gArray = gArrayFromD!(typeof(testArray[0]))(testArray);
    auto cmpDArray = gArrayToD!(typeof(testArray[0]), GidOwnership.Full)(gArray);

    static if (is(typeof(testArray[0]) == Value))
      assert(equal(cmpDArray.map!(x => x.get!int), [69]));
    else
      assert(testArray == cmpDArray);
  }

  foreach (testArray; testComplexArrays)
  {
    auto ptrArray = gPtrArrayFromD!(typeof(testArray[0]))(testArray);
    auto cmpDArray = gPtrArrayToD!(typeof(testArray[0]), GidOwnership.Full)(ptrArray);

    static if (is(typeof(testArray[0]) == Value))
      assert(equal(cmpDArray.map!(x => x.get!int), [69]));
    else
      assert(testArray == cmpDArray);
  }

  foreach (testArray; testComplexArrays)
  {
    auto list = gListFromD!(typeof(testArray[0]))(testArray);
    auto cmpDArray = gListToD!(typeof(testArray[0]), GidOwnership.Full)(list);

    static if (is(typeof(testArray[0]) == Value))
      assert(equal(cmpDArray.map!(x => x.get!int), [69]));
    else
      assert(testArray == cmpDArray);
  }

  foreach (testArray; testComplexArrays)
  {
    auto slist = gSListFromD!(typeof(testArray[0]))(testArray);
    auto cmpDArray = gSListToD!(typeof(testArray[0]), GidOwnership.Full)(slist);

    static if (is(typeof(testArray[0]) == Value))
      assert(equal(cmpDArray.map!(x => x.get!int), [69]));
    else
      assert(testArray == cmpDArray);
  }

  auto testHashes = tuple(
    ["one" : obj],
    ["two" : iface],
    ["three" : "test"],
    [cast(void*)123 : cast(void*)456],
  );

  foreach (testHash; testHashes)
  {
    auto gHashTable = gHashTableFromD(testHash);
    auto cmpHash = gHashTableToD!(KeyType!(typeof(testHash)), ValueType!(typeof(testHash)),
      GidOwnership.Full)(gHashTable);
    assert(testHash == cmpHash);
  }
}
