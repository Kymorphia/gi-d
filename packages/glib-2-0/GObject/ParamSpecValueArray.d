module GObject.ParamSpecValueArray;

import GObject.ParamSpec;
import GObject.Types;
import GObject.c.functions;
import GObject.c.types;
import Gid.gid;

/**
 * A #GParamSpec derived structure that contains the meta data for #GValueArray properties.
 */
class ParamSpecValueArray : ParamSpec
{

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for GObject.ParamSpecValueArray");

    super(cast(GParamSpec*)ptr, ownedRef);
  }
}
