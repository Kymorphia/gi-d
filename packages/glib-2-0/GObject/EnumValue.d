module GObject.EnumValue;

import GObject.Types;
import GObject.c.functions;
import GObject.c.types;
import Gid.gid;

/**
 * A structure which contains a single enum value, its name, and its
 * nickname.
 */
class EnumValue
{
  GEnumValue cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for GObject.EnumValue");

    cInstance = *cast(GEnumValue*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property int value()
  {
    return (cast(GEnumValue*)cPtr).value;
  }

  @property void value(int propval)
  {
    (cast(GEnumValue*)cPtr).value = propval;
  }

  @property string valueName()
  {
    return (cast(GEnumValue*)cPtr).valueName.fromCString(false);
  }

  @property void valueName(string propval)
  {
    safeFree(cast(void*)(cast(GEnumValue*)cPtr).valueName);
    (cast(GEnumValue*)cPtr).valueName = propval.toCString(true);
  }

  @property string valueNick()
  {
    return (cast(GEnumValue*)cPtr).valueNick.fromCString(false);
  }

  @property void valueNick(string propval)
  {
    safeFree(cast(void*)(cast(GEnumValue*)cPtr).valueNick);
    (cast(GEnumValue*)cPtr).valueNick = propval.toCString(true);
  }
}
