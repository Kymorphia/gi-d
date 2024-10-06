module Gsk.ColorStop;

import Gdk.RGBA;
import Gid.gid;
import Gsk.Types;
import Gsk.c.functions;
import Gsk.c.types;

/**
 * A color stop in a gradient node.
 */
class ColorStop
{
  GskColorStop cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gsk.ColorStop");

    cInstance = *cast(GskColorStop*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property float offset()
  {
    return (cast(GskColorStop*)cPtr).offset;
  }

  @property void offset(float propval)
  {
    (cast(GskColorStop*)cPtr).offset = propval;
  }

  @property RGBA color()
  {
    return new RGBA(cast(GdkRGBA*)&(cast(GskColorStop*)cPtr).color);
  }
}
