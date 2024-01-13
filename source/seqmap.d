module seqmap;

import std.algorithm : map, stdSort = sort;
import std.array : array;
import std.exception : assertThrown;
import std.range : zip;

/// A general purpose ordered sequence map
final class SeqMap(K=string, V=string)
{
  this()
  {
  }

  /// Get the length of a sequence map
  @property ulong length()
  {
    return valArray.length;
  }

  /// Shrink the number of values in a sequence map
  @property void length(ulong len)
  { // Allow length shrinking only (what would we set new keys to?)
    assert(len <= length);

    foreach (i; len .. length)
      valIndexHash.remove(valArray[i]);

    valArray.length = len;
    keyArray.length = len;
  }

  @property K[] keys()
  {
    return keyArray;
  }

  @property V[] values()
  {
    return valArray;
  }

  /// Get value at index
  V opIndex(size_t index)
  {
    return valArray[index];
  }

  /// Get value by key
  V opIndex(K key)
  {
    return valArray[valIndexHash[key]];
  }

  /// Empty slice access
  V[] opIndex()
  {
    return valArray[];
  }

  /// Assign value to index
  V opIndexAssign(V val, size_t index)
  {
    valArray[index] = val;
    return val;
  }

  /// Assign value to key
  V opIndexAssign(V val, K key)
  {
    append(key, val);
    return val;
  }

  /// Obligatory slice processing method
  V[] opIndex()(V[] slice)
  {
    return slice;
  }

  /// Slice method
  V[] opSlice(size_t dim: 0)(size_t i, size_t j)
  {
    return valArray[i..j];
  }

  /**
   * Insert key/value at given index in a sequence map
   * Params:
   *   index = Index to insert at (0 to prepend, >=count of items or <0 to append)
   *   key = The map hash key (value will be replaced if key already exists)
   *   val = The value to store
   * Returns: true if a value was replaced (identical key), false otherwise
   */
  bool insert(int index, K key, V val)
  {
    if (auto pIndex = key in valIndexHash)
    {
      valArray[*pIndex] = val;
      return true;
    }

    if (index < 0)
      index = cast(int)length;

    if (index + 1 <= length)
    {
      valArray = valArray[0 .. index] ~ val ~ valArray[index .. $];
      keyArray = keyArray[0 .. index] ~ key ~ keyArray[index .. $];
      updateIndexHash;
    }
    else
    {
      valArray ~= val;
      keyArray ~= key;
      valIndexHash[key] = index;
    }

    return false;
  }

  /**
   * Append a key/value to a sequence map. Optimized for appending new values.
   * Params:
   *   key = The map hash key (value will be replaced if key already exists)
   *   val = The value to store
   * Returns: true if a value was replaced (identical key), false otherwise
   */
  bool append(K key, V val)
  {
    return insert(-1, key, val);
  }

  /**
   * Append a key/value to a sequence map. Not optimized for prepending.
   * Params:
   *   key = The map hash key (value will be replaced if key already exists)
   *   val = The value to store
   * Returns: true if a value was replaced (identical key), false otherwise
   */
  bool prepend(K key, V val)
  {
    return insert(0, key, val);
  }

  /**
   * Remove item by key in a sequence map
   * Params:
   *   key = The key of the item to remove
   * Returns: true if item was removed, false if key did not match
   */
  bool remove(K key)
  {
    if (auto pIndex = key in valIndexHash)
    {
      valArray = valArray[0 .. *pIndex] ~ valArray[*pIndex + 1 .. $];
      keyArray = keyArray[0 .. *pIndex] ~ keyArray[*pIndex + 1 .. $];

      if (*pIndex == length)
        valIndexHash.remove(key);
      else
        updateIndexHash;

      return true;
    }

    return false;
  }

  /**
   * Remove an item by index from a sequence map
   * Params:
   *   index = The index of the item to remove (negative indeces remove from the end)
   * Returns: true if the item was removed, false if index is invalid
   */
  bool removeIndex(int index)
  {
    if (index >= length)
      return false;

    if (index + 1 == length)
      valIndexHash.remove(valArray[index]);

    valArray = valArray[0 .. index] ~ valArray[index + 1 .. $];
    keyArray = keyArray[0 .. index] ~ keyArray[index + 1 .. $];

    if (index <= length)
      updateIndexHash;

    return true;
  }

  /**
   * Sort by keys in a sequence map
   */
  void sortByKey()
  {
    auto sortedKV = zip(keyArray, valArray).stdSort;
    valArray = sortedKV.map!(x => x[1]).array;
    keyArray = sortedKV.map!(x => x[0]).array;
    updateIndexHash;
  }

  /**
   * Sort the values in a sequence map
   */
  void sortByValue()
  {
    auto sortedVK = zip(valArray, keyArray).stdSort;
    valArray = sortedVK.map!(x => x[0]).array;
    keyArray = sortedVK.map!(x => x[1]).array;
    updateIndexHash;
  }

  // Update the value index hash (required after any value array indexes change)
  private void updateIndexHash()
  {
    valIndexHash.clear;
    foreach (i; 0 .. cast(uint)length)
      valIndexHash[keyArray[i]] = i;
  }

  private:
    V[] valArray;
    V[] keyArray;
    uint[K] valIndexHash;
}

unittest
{
  import core.exception : AssertError;
  import std.conv : to;
  import std.range : iota;

  auto seq = new SeqMap!();

  // Verifies sequence index hash is as expected
  void checkIndexHash()
  {
    foreach (i; 0 .. seq.length)
      assert(seq[seq.keys[i]] == seq.values[i]);
  }

  assert(seq.length == 0);
  assertThrown!AssertError(seq.length = 5); // Increasing size should cause an AssertError

  // Prepend 10 values k0 => v0 to k9 => v9
  foreach (i; 0 .. 10)
    seq.prepend("k" ~ i.to!string, "v" ~ i.to!string);

  checkIndexHash;
  assert(seq.length == 10);
  assert(seq[] == iota(9, -1, -1).map!(x => "v" ~ x.to!string).array); // Check empty slice operator and reverse order values (prepended)

  // Test sort by value
  seq.sortByValue;
  checkIndexHash;
  assert(seq.values == iota(0, 10).map!(x => "v" ~ x.to!string).array); // Check that values are now sorted using the values property

  // Verify values using indexing
  foreach (i; 0 .. 10)
    assert(seq[i] == "v" ~ i.to!string);

  // Test assignment using index and key
  seq[0] = "test";
  checkIndexHash;
  assert(seq[] == ["test", "v1", "v2", "v3", "v4", "v5", "v6", "v7", "v8", "v9"]);
  seq["k0"] = "v0";
  assert(seq.values == iota(0, 10).map!(x => "v" ~ x.to!string).array);
  checkIndexHash;

  // Test slicing
  assert(seq[4 .. 8] == ["v4", "v5", "v6", "v7"]);

  // Test insertion by index
  seq.insert(6, "insKey", "insVal");
  assert(seq[] == ["v0", "v1", "v2", "v3", "v4", "v5", "insVal", "v6", "v7", "v8", "v9"]);
  assert(seq.keys == ["k0", "k1", "k2", "k3", "k4", "k5", "insKey", "k6", "k7", "k8", "k9"]);
  checkIndexHash;

  // Test removal by key
  seq.remove("insKey");
  checkIndexHash;

  // Test sorting by key
  seq.insert(3, "zzz", "aaa");
  seq.sortByKey;
  assert(seq[] == ["v0", "v1", "v2", "v3", "v4", "v5", "v6", "v7", "v8", "v9", "aaa"]);
  assert(seq.keys == ["k0", "k1", "k2", "k3", "k4", "k5", "k6", "k7", "k8", "k9", "zzz"]);

  // Test removal of last key
  seq.remove("zzz");
  checkIndexHash;

  // Test removal of invalid key
  assert(!seq.remove("bogus"));

  // Test removal by index
  seq.removeIndex(9);
  assert(seq.values == iota(0, 9).map!(x => "v" ~ x.to!string).array);
  seq.append("k9", "v9");
  assert(seq.values == iota(0, 10).map!(x => "v" ~ x.to!string).array);
  checkIndexHash;

  // Test removal of invalid index
  assert(!seq.removeIndex(100));

  // Test shrinking with length
  seq.length = 5;
  assert(seq.values == iota(0, 5).map!(x => "v" ~ x.to!string).array);
  checkIndexHash;
}
