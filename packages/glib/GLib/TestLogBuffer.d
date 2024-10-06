module GLib.TestLogBuffer;

import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.gid;

class TestLogBuffer
{
  GTestLogBuffer cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for GLib.TestLogBuffer");

    cInstance = *cast(GTestLogBuffer*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  /**
   * Internal function for gtester to decode test log messages, no ABI guarantees provided.
   * Params:
   *   bytes =
   */
  void push(ubyte[] bytes)
  {
    uint _nBytes;
    if (bytes)
      _nBytes = cast(uint)bytes.length;

    auto _bytes = cast(const(ubyte)*)bytes.ptr;
    g_test_log_buffer_push(cast(GTestLogBuffer*)cPtr, _nBytes, _bytes);
  }
}
