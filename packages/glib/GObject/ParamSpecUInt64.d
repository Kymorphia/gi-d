module GObject.ParamSpecUInt64;

import GObject.ParamSpec;
import GObject.Types;
import GObject.c.functions;
import GObject.c.types;
import Gid.gid;

/**
 * A #GParamSpec derived structure that contains the meta data for unsigned 64bit integer properties.
 */
class ParamSpecUInt64 : ParamSpec
{

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for GObject.ParamSpecUInt64");

    super(cast(GParamSpec*)ptr, ownedRef);
  }
}
