module Pango.AttrColor;

import Gid.gid;
import Pango.Attribute;
import Pango.Color;
import Pango.Types;
import Pango.c.functions;
import Pango.c.types;

/**
 * The `PangoAttrColor` structure is used to represent attributes that
 * are colors.
 */
class AttrColor
{
  PangoAttrColor cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Pango.AttrColor");

    cInstance = *cast(PangoAttrColor*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property Attribute attr()
  {
    return new Attribute(cast(PangoAttribute*)&(cast(PangoAttrColor*)cPtr).attr);
  }

  @property Color color()
  {
    return new Color(cast(PangoColor*)&(cast(PangoAttrColor*)cPtr).color);
  }
}
