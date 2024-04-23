module GLib.DebugKey;

import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.Gid;

/**
 * Associates a string with a bit flag.
 * Used in g_parse_debug_string().
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
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GDebugKey))
  {
    return cast(T*)&cInstance;
  }

  @property string key()
  {
    return cPtr!GDebugKey.key.fromCString(false);
  }

  @property void key(string propval)
  {
    g_free(cast(void*)cPtr!GDebugKey.key);
    cPtr!GDebugKey.key = propval.toCString(true);
  }

  @property uint value()
  {
    return cPtr!GDebugKey.value;
  }

  @property void value(uint propval)
  {
    cPtr!GDebugKey.value = propval;
  }
}
