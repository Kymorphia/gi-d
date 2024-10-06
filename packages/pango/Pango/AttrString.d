module Pango.AttrString;

import Gid.gid;
import Pango.Attribute;
import Pango.Types;
import Pango.c.functions;
import Pango.c.types;

/**
 * The `PangoAttrString` structure is used to represent attributes with
 * a string value.
 */
class AttrString
{
  PangoAttrString cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Pango.AttrString");

    cInstance = *cast(PangoAttrString*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property Attribute attr()
  {
    return new Attribute(cast(PangoAttribute*)&(cast(PangoAttrString*)cPtr).attr);
  }

  @property string value()
  {
    return (cast(PangoAttrString*)cPtr).value.fromCString(false);
  }

  @property void value(string propval)
  {
    safeFree(cast(void*)(cast(PangoAttrString*)cPtr).value);
    (cast(PangoAttrString*)cPtr).value = propval.toCString(true);
  }
}
