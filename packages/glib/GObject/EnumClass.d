module GObject.EnumClass;

import GObject.EnumValue;
import GObject.TypeClass;
import GObject.Types;
import GObject.c.functions;
import GObject.c.types;
import Gid.gid;

/**
 * The class of an enumeration type holds information about its
 * possible values.
 */
class EnumClass
{
  GEnumClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for GObject.EnumClass");

    cInstance = *cast(GEnumClass*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property TypeClass gTypeClass()
  {
    return new TypeClass(cast(GTypeClass*)&(cast(GEnumClass*)cPtr).gTypeClass);
  }

  @property int minimum()
  {
    return (cast(GEnumClass*)cPtr).minimum;
  }

  @property void minimum(int propval)
  {
    (cast(GEnumClass*)cPtr).minimum = propval;
  }

  @property int maximum()
  {
    return (cast(GEnumClass*)cPtr).maximum;
  }

  @property void maximum(int propval)
  {
    (cast(GEnumClass*)cPtr).maximum = propval;
  }

  @property uint nValues()
  {
    return (cast(GEnumClass*)cPtr).nValues;
  }

  @property void nValues(uint propval)
  {
    (cast(GEnumClass*)cPtr).nValues = propval;
  }

  @property EnumValue values()
  {
    return new EnumValue(cast(GEnumValue*)(cast(GEnumClass*)cPtr).values);
  }
}
