module GObject.EnumClass;

import GLib.c.functions;
import GObject.EnumValue;
import GObject.TypeClass;
import GObject.Types;
import GObject.c.functions;
import GObject.c.types;
import Gid.Gid;

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
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GEnumClass))
  {
    return cast(T*)&cInstance;
  }

  @property TypeClass gTypeClass()
  {
    return new TypeClass(cast(GTypeClass*)&cPtr!GEnumClass.gTypeClass);
  }

  @property int minimum()
  {
    return cPtr!GEnumClass.minimum;
  }

  @property void minimum(int propval)
  {
    cPtr!GEnumClass.minimum = propval;
  }

  @property int maximum()
  {
    return cPtr!GEnumClass.maximum;
  }

  @property void maximum(int propval)
  {
    cPtr!GEnumClass.maximum = propval;
  }

  @property uint nValues()
  {
    return cPtr!GEnumClass.nValues;
  }

  @property void nValues(uint propval)
  {
    cPtr!GEnumClass.nValues = propval;
  }

  @property EnumValue values()
  {
    return new EnumValue(cast(GEnumValue*)cPtr!GEnumClass.values);
  }
}
