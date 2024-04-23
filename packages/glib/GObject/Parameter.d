module GObject.Parameter;

import GLib.c.functions;
import GObject.Types;
import GObject.Value;
import GObject.c.functions;
import GObject.c.types;
import Gid.Gid;

/**
 * The GParameter struct is an auxiliary structure used
 * to hand parameter name/value pairs to g_object_newv().
 */
class Parameter
{
  GParameter cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for GObject.Parameter");

    cInstance = *cast(GParameter*)ptr;

    if (ownedRef)
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GParameter))
  {
    return cast(T*)&cInstance;
  }

  @property string name()
  {
    return cPtr!GParameter.name.fromCString(false);
  }

  @property void name(string propval)
  {
    g_free(cast(void*)cPtr!GParameter.name);
    cPtr!GParameter.name = propval.toCString(true);
  }

  @property Value value()
  {
    return new Value(cast(GValue*)&cPtr!GParameter.value);
  }
}
