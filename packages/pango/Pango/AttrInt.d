module Pango.AttrInt;

import Gid.gid;
import Pango.Attribute;
import Pango.Types;
import Pango.c.functions;
import Pango.c.types;

/**
 * The `PangoAttrInt` structure is used to represent attributes with
 * an integer or enumeration value.
 */
class AttrInt
{
  PangoAttrInt cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Pango.AttrInt");

    cInstance = *cast(PangoAttrInt*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property Attribute attr()
  {
    return new Attribute(cast(PangoAttribute*)&(cast(PangoAttrInt*)cPtr).attr);
  }

  @property int value()
  {
    return (cast(PangoAttrInt*)cPtr).value;
  }

  @property void value(int propval)
  {
    (cast(PangoAttrInt*)cPtr).value = propval;
  }
}
