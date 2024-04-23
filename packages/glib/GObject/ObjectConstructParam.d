module GObject.ObjectConstructParam;

import GLib.c.functions;
import GObject.ParamSpec;
import GObject.Types;
import GObject.Value;
import GObject.c.functions;
import GObject.c.types;
import Gid.Gid;

/**
 * The GObjectConstructParam struct is an auxiliary structure used to hand
 * #GParamSpec/#GValue pairs to the @constructor of a #GObjectClass.
 */
class ObjectConstructParam
{
  GObjectConstructParam cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for GObject.ObjectConstructParam");

    cInstance = *cast(GObjectConstructParam*)ptr;

    if (ownedRef)
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GObjectConstructParam))
  {
    return cast(T*)&cInstance;
  }

  @property ParamSpec pspec()
  {
    return new ParamSpec(cast(GParamSpec*)cPtr!GObjectConstructParam.pspec);
  }

  @property Value value()
  {
    return new Value(cast(GValue*)cPtr!GObjectConstructParam.value);
  }
}
