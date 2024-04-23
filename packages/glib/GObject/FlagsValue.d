module GObject.FlagsValue;

import GLib.c.functions;
import GObject.Types;
import GObject.c.functions;
import GObject.c.types;
import Gid.Gid;

/**
 * A structure which contains a single flags value, its name, and its
 * nickname.
 */
class FlagsValue
{
  GFlagsValue cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for GObject.FlagsValue");

    cInstance = *cast(GFlagsValue*)ptr;

    if (ownedRef)
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GFlagsValue))
  {
    return cast(T*)&cInstance;
  }

  @property uint value()
  {
    return cPtr!GFlagsValue.value;
  }

  @property void value(uint propval)
  {
    cPtr!GFlagsValue.value = propval;
  }

  @property string valueName()
  {
    return cPtr!GFlagsValue.valueName.fromCString(false);
  }

  @property void valueName(string propval)
  {
    g_free(cast(void*)cPtr!GFlagsValue.valueName);
    cPtr!GFlagsValue.valueName = propval.toCString(true);
  }

  @property string valueNick()
  {
    return cPtr!GFlagsValue.valueNick.fromCString(false);
  }

  @property void valueNick(string propval)
  {
    g_free(cast(void*)cPtr!GFlagsValue.valueNick);
    cPtr!GFlagsValue.valueNick = propval.toCString(true);
  }
}
