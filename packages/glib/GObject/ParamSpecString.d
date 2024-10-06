module GObject.ParamSpecString;

import GObject.ParamSpec;
import GObject.Types;
import GObject.c.functions;
import GObject.c.types;
import Gid.gid;

/**
 * A #GParamSpec derived structure that contains the meta data for string
 * properties.
 */
class ParamSpecString : ParamSpec
{

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for GObject.ParamSpecString");

    super(cast(GParamSpec*)ptr, ownedRef);
  }
}
