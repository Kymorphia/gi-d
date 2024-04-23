module GObject.EnumValue;

import GLib.c.functions;
import GObject.Types;
import GObject.c.functions;
import GObject.c.types;
import Gid.Gid;

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
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GEnumValue))
  {
    return cast(T*)&cInstance;
  }

  @property int value()
  {
    return cPtr!GEnumValue.value;
  }

  @property void value(int propval)
  {
    cPtr!GEnumValue.value = propval;
  }

  @property string valueName()
  {
    return cPtr!GEnumValue.valueName.fromCString(false);
  }

  @property void valueName(string propval)
  {
    g_free(cast(void*)cPtr!GEnumValue.valueName);
    cPtr!GEnumValue.valueName = propval.toCString(true);
  }

  @property string valueNick()
  {
    return cPtr!GEnumValue.valueNick.fromCString(false);
  }

  @property void valueNick(string propval)
  {
    g_free(cast(void*)cPtr!GEnumValue.valueNick);
    cPtr!GEnumValue.valueNick = propval.toCString(true);
  }
}
