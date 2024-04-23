module GObject.ParamSpecFloat;

import GObject.ParamSpec;
import GObject.Types;
import GObject.c.functions;
import GObject.c.types;
import Gid.Gid;

/**
 * A #GParamSpec derived structure that contains the meta data for float properties.
 */
class ParamSpecFloat : ParamSpec
{

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for GObject.ParamSpecFloat");

    super(cast(GParamSpec*)ptr, ownedRef);
  }

  T* cPtr(T)(bool addRef = false)
  if (is(T == GParamSpecFloat))
  {
    if (addRef)
      (cInstancePtr);

    return cast(T*)cInstancePtr;
  }
}
