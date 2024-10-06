module GObject.ParamSpecInt64;

import GObject.ParamSpec;
import GObject.Types;
import GObject.c.functions;
import GObject.c.types;
import Gid.gid;

/**
 * A #GParamSpec derived structure that contains the meta data for 64bit integer properties.
 */
class ParamSpecInt64 : ParamSpec
{

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for GObject.ParamSpecInt64");

    super(cast(GParamSpec*)ptr, ownedRef);
  }
}
