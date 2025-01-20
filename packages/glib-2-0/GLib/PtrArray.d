module GLib.PtrArray;

import GLib.Boxed;
import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.gid;

import GLib.Boxed;
import GLib.Types;

/**
 * PtrArray finite RandomAccessRange template.
 */
/**
 * Contains the public fields of a pointer array.
 */
class PtrArray(T)
{
  GPtrArray* cPtr; // The pointer array
  GidOwnership ownership; // Ownership of the array and data

  this(GPtrArray* array, GidOwnership ownership = GidOwnership.None)
  {
    cPtr = array;
    this.ownership = ownership;
  }

  ~this()
  {
    if (ownership == GidOwnership.None)
      return;

    if (ownership == GidOwnership.Full)
    {
      foreach (i; 0 .. cPtr.len)
        containerFreeItem!T(cPtr.pdata[i]);
    }

    g_ptr_array_free(cPtr, true);
  }

  bool empty() const
  {
    return cPtr.len == 0;
  }

  T front()
  {
    return containerGetItem!T(cPtr.pdata[0]);
  }

  T back()
  {
    return containerGetItem!T(cPtr.pdata[cPtr.len - 1]);
  }

  void popFront()
  {
    g_ptr_array_remove_index(cPtr, 0);
  }

  void popBack()
  {
    g_ptr_array_remove_index(cPtr, cPtr.len - 1);
  }

  PtrArray!(T) save()
  {
    GPtrArray* newArray;

    foreach (i; 0 .. cPtr.len)
      g_ptr_array_add(cPtr, containerCopyItem!T(cPtr.pdata[i]));

    return new PtrArray!(T)(newArray, GidOwnership.Full);
  }

  T opIndex(size_t index)
  {
    return containerGetItem!T(cPtr.pdata[index]);
  }

  size_t length() const
  {
    return cPtr.len;
  }
}
