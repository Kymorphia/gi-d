module GObject.FlagsClass;

import GLib.c.functions;
import GObject.FlagsValue;
import GObject.TypeClass;
import GObject.Types;
import GObject.c.functions;
import GObject.c.types;
import Gid.Gid;

/**
 * The class of a flags type holds information about its
 * possible values.
 */
class FlagsClass
{
  GFlagsClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for GObject.FlagsClass");

    cInstance = *cast(GFlagsClass*)ptr;

    if (ownedRef)
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GFlagsClass))
  {
    return cast(T*)&cInstance;
  }

  @property TypeClass gTypeClass()
  {
    return new TypeClass(cast(GTypeClass*)&cPtr!GFlagsClass.gTypeClass);
  }

  @property uint mask()
  {
    return cPtr!GFlagsClass.mask;
  }

  @property void mask(uint propval)
  {
    cPtr!GFlagsClass.mask = propval;
  }

  @property uint nValues()
  {
    return cPtr!GFlagsClass.nValues;
  }

  @property void nValues(uint propval)
  {
    cPtr!GFlagsClass.nValues = propval;
  }

  @property FlagsValue values()
  {
    return new FlagsValue(cast(GFlagsValue*)cPtr!GFlagsClass.values);
  }
}
