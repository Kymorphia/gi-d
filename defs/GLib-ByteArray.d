import GLib.c.functions;
import GLib.c.types;

/**
 * ByteArray finite RandomAccessRange.
 */
class ByteArray
{
  GByteArray* cPtr; // The byte array

  this(GByteArray* array)
  {
    cPtr = array;
  }

  ~this()
  {
    g_byte_array_free(cPtr, true);
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
