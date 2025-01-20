module GLib.TestLogMsg;

import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.gid;

class TestLogMsg
{
  GTestLogMsg cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for GLib.TestLogMsg");

    cInstance = *cast(GTestLogMsg*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }
}
