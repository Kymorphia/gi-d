module GLib.ByteArray;

import GLib.Boxed;
import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.gid;

import GLib.c.functions;
import GLib.c.types;

/**
 * ByteArray finite RandomAccessRange.
 */
/**
 * Contains the public fields of a GByteArray.
 */
class ByteArray
{
  GByteArray* cPtr; // The byte array
  GidOwnership ownership; // Ownership of the container

  this(GByteArray* array, GidOwnership ownership = GidOwnership.None)
  {
    cPtr = array;
    this.ownership = ownership;
  }

  ~this()
  {
    if (ownership != GidOwnership.None)
      g_byte_array_free(cPtr, ownership == GidOwnership.Full);
  }

  bool empty() const
  {
    return cPtr.len == 0;
  }

  ubyte front()
  {
    return cPtr.data[0];
  }

  ubyte back()
  {
    return cPtr.data[cPtr.len - 1];
  }

  void popFront()
  {
    g_byte_array_remove_index(cPtr, 0);
  }

  void popBack()
  {
    g_byte_array_remove_index(cPtr, cPtr.len - 1);
  }

  ByteArray save() const
  {
    return new ByteArray(g_byte_array_new_take(cast(ubyte*)g_memdup2(cPtr.data, cPtr.len), cPtr.len));
  }

  ubyte opIndex(size_t index) const
  {
    return cPtr.data[index];
  }

  size_t length() const
  {
    return cPtr.len;
  }
}
