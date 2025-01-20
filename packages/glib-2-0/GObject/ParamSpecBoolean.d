module GObject.ParamSpecBoolean;

import GObject.ParamSpec;
import GObject.Types;
import GObject.c.functions;
import GObject.c.types;
import Gid.gid;

/**
 * A #GParamSpec derived structure that contains the meta data for boolean properties.
 */
class ParamSpecBoolean : ParamSpec
{

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for GObject.ParamSpecBoolean");

    super(cast(GParamSpec*)ptr, ownedRef);
  }
}
