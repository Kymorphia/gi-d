module GLib.TestLogBuffer;

import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.Gid;

class TestLogBuffer
{
  GTestLogBuffer cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for GLib.TestLogBuffer");

    cInstance = *cast(GTestLogBuffer*)ptr;

    if (ownedRef)
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GTestLogBuffer))
  {
    return cast(T*)&cInstance;
  }

  /**
   * Internal function for gtester to decode test log messages, no ABI guarantees provided.
   */
  void push(ubyte[] bytes)
  {
    auto _bytes = cast(const(ubyte)*)bytes.ptr;
    g_test_log_buffer_push(cPtr!GTestLogBuffer, bytes ? cast(uint)bytes.length : 0, _bytes);
  }
}
