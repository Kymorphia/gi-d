module GObject.ParamSpecOverride;

import GObject.ParamSpec;
import GObject.Types;
import GObject.c.functions;
import GObject.c.types;
import Gid.gid;

/**
 * A #GParamSpec derived structure that redirects operations to
 * other types of #GParamSpec.
 * All operations other than getting or setting the value are redirected,
 * including accessing the nick and blurb, validating a value, and so
 * forth.
 * See [GObject.ParamSpec.getRedirectTarget] for retrieving the overridden
 * property. #GParamSpecOverride is used in implementing
 * [GObject.ObjectClass.overrideProperty], and will not be directly useful
 * unless you are implementing a new base type similar to GObject.
 */
class ParamSpecOverride : ParamSpec
{

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for GObject.ParamSpecOverride");

    super(cast(GParamSpec*)ptr, ownedRef);
  }
}
