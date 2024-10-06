module GLib.LogField;

import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.gid;

/**
 * Structure representing a single field in a structured log entry. See
 * [GLib.Global.logStructured] for details.
 * Log fields may contain arbitrary values, including binary with embedded nul
 * bytes. If the field contains a string, the string must be UTF-8 encoded and
 * have a trailing nul byte. Otherwise, @length must be set to a non-negative
 * value.
 */
class LogField
{
  GLogField cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for GLib.LogField");

    cInstance = *cast(GLogField*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property string key()
  {
    return (cast(GLogField*)cPtr).key.fromCString(false);
  }

  @property void key(string propval)
  {
    safeFree(cast(void*)(cast(GLogField*)cPtr).key);
    (cast(GLogField*)cPtr).key = propval.toCString(true);
  }

  @property ptrdiff_t length()
  {
    return (cast(GLogField*)cPtr).length;
  }

  @property void length(ptrdiff_t propval)
  {
    (cast(GLogField*)cPtr).length = propval;
  }
}
