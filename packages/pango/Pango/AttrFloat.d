module Pango.AttrFloat;

import Gid.gid;
import Pango.Attribute;
import Pango.Types;
import Pango.c.functions;
import Pango.c.types;

/**
 * The `PangoAttrFloat` structure is used to represent attributes with
 * a float or double value.
 */
class AttrFloat
{
  PangoAttrFloat cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Pango.AttrFloat");

    cInstance = *cast(PangoAttrFloat*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property Attribute attr()
  {
    return new Attribute(cast(PangoAttribute*)&(cast(PangoAttrFloat*)cPtr).attr);
  }

  @property double value()
  {
    return (cast(PangoAttrFloat*)cPtr).value;
  }

  @property void value(double propval)
  {
    (cast(PangoAttrFloat*)cPtr).value = propval;
  }
}
