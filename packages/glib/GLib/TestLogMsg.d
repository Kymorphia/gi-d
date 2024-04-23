module GLib.TestLogMsg;

import GLib.c.functions;
import GLib.c.types;
import Gid.Gid;

class TestLogMsg
{
  GTestLogMsg cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for GLib.TestLogMsg");

    cInstance = *cast(GTestLogMsg*)ptr;

    if (ownedRef)
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GTestLogMsg))
  {
    return cast(T*)&cInstance;
  }
}
