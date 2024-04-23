module GLib.LogField;

import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.Gid;

/**
 * Structure representing a single field in a structured log entry. See
 * g_log_structured() for details.
 *
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
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GLogField))
  {
    return cast(T*)&cInstance;
  }

  @property string key()
  {
    return cPtr!GLogField.key.fromCString(false);
  }

  @property void key(string propval)
  {
    g_free(cast(void*)cPtr!GLogField.key);
    cPtr!GLogField.key = propval.toCString(true);
  }

  @property ptrdiff_t length()
  {
    return cPtr!GLogField.length;
  }

  @property void length(ptrdiff_t propval)
  {
    cPtr!GLogField.length = propval;
  }
}
