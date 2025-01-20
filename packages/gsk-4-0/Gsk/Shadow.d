module Gsk.Shadow;

import Gdk.RGBA;
import Gid.gid;
import Gsk.Types;
import Gsk.c.functions;
import Gsk.c.types;

/**
 * The shadow parameters in a shadow node.
 */
class Shadow
{
  GskShadow cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gsk.Shadow");

    cInstance = *cast(GskShadow*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property RGBA color()
  {
    return new RGBA(cast(GdkRGBA*)&(cast(GskShadow*)cPtr).color);
  }

  @property float dx()
  {
    return (cast(GskShadow*)cPtr).dx;
  }

  @property void dx(float propval)
  {
    (cast(GskShadow*)cPtr).dx = propval;
  }

  @property float dy()
  {
    return (cast(GskShadow*)cPtr).dy;
  }

  @property void dy(float propval)
  {
    (cast(GskShadow*)cPtr).dy = propval;
  }

  @property float radius()
  {
    return (cast(GskShadow*)cPtr).radius;
  }

  @property void radius(float propval)
  {
    (cast(GskShadow*)cPtr).radius = propval;
  }
}
