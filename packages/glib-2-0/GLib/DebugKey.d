module GLib.DebugKey;

import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.gid;

/**
 * Associates a string with a bit flag.
 * Used in [GLib.Global.parseDebugString].
 */
class DebugKey
{
  GDebugKey cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for GLib.DebugKey");

    cInstance = *cast(GDebugKey*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property string key()
  {
    return (cast(GDebugKey*)cPtr).key.fromCString(false);
  }

  @property void key(string propval)
  {
    safeFree(cast(void*)(cast(GDebugKey*)cPtr).key);
    (cast(GDebugKey*)cPtr).key = propval.toCString(true);
  }

  @property uint value()
  {
    return (cast(GDebugKey*)cPtr).value;
  }

  @property void value(uint propval)
  {
    (cast(GDebugKey*)cPtr).value = propval;
  }
}
