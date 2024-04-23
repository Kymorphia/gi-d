module GObject.ParamSpecOverride;

import GObject.ParamSpec;
import GObject.Types;
import GObject.c.functions;
import GObject.c.types;
import Gid.Gid;

/**
 * A #GParamSpec derived structure that redirects operations to
 * other types of #GParamSpec.
 *
 * All operations other than getting or setting the value are redirected,
 * including accessing the nick and blurb, validating a value, and so
 * forth.
 *
 * See g_param_spec_get_redirect_target() for retrieving the overridden
 * property. #GParamSpecOverride is used in implementing
 * g_object_class_override_property(), and will not be directly useful
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

  T* cPtr(T)(bool addRef = false)
  if (is(T == GParamSpecOverride))
  {
    if (addRef)
      (cInstancePtr);

    return cast(T*)cInstancePtr;
  }
}
