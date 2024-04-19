import GLib.Boxed;
import GLib.Global;

/**
 * Array finite RandomAccessRange template for accessing a GArray.
 */
class ArrayG(T, CT)
{
  GArray* cPtr; // The GArray
  long elemSize; // The size of each array element
  GidOwnership ownership; // Ownership of the array and data

  this(GArray* array, GidOwnership ownership = GidOwnership.None)
  {
    cPtr = array;
    elemSize = g_array_get_element_size(array);
    this.ownership = ownership;
  }

  ~this()
  {
    if (ownership == GidOwnership.None)
      return;

    if (ownership == GidOwnership.Full)
    {
      foreach (i; 0 .. cPtr.len)
        containerFreeItem!T(&cPtr.data[i * elemSize]);
    }

    g_array_free(cPtr, true);
  }

  bool empty() const
  {
    return cPtr.len == 0;
  }

  T front()
  {
    return containerGetItem!T(cPtr.data);
  }

  T back()
  {
    return containerGetItem!T(&cPtr.data[(cPtr.len - 1) * elemSize]);
  }

  void popFront()
  {
    g_array_remove_index(cPtr, 0);
  }

  void popBack()
  {
    g_array_remove_index(cPtr, cPtr.len - 1);
  }

  ArrayG!(T, CT) save()
  {
    auto newArray = g_array_sized_new(false, false, elemSize, cPtr.len);

    foreach (i; 0 .. cPtr.len)
      g_ptr_array_add(newArray, containerCopyItem!T(&cPtr.data[i * elemSize]));

    return new ArrayG!(T, CT)(newArray, GidOwnership.Full);
  }

  T opIndex(size_t index)
  {
    return containerGetItem!T(&cPtr.data[index * elemSize]);
  }

  size_t length() const
  {
    return cPtr.len;
  }
}
