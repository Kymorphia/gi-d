module GObject.ObjectConstructParam;

import GObject.ParamSpec;
import GObject.Types;
import GObject.Value;
import GObject.c.functions;
import GObject.c.types;
import Gid.gid;

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
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property ParamSpec pspec()
  {
    return new ParamSpec(cast(GParamSpec*)(cast(GObjectConstructParam*)cPtr).pspec);
  }

  @property Value value()
  {
    return new Value(cast(GValue*)(cast(GObjectConstructParam*)cPtr).value);
  }
}
