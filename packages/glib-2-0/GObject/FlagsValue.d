module GObject.FlagsValue;

import GObject.Types;
import GObject.c.functions;
import GObject.c.types;
import Gid.gid;

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
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property uint value()
  {
    return (cast(GFlagsValue*)cPtr).value;
  }

  @property void value(uint propval)
  {
    (cast(GFlagsValue*)cPtr).value = propval;
  }

  @property string valueName()
  {
    return (cast(GFlagsValue*)cPtr).valueName.fromCString(false);
  }

  @property void valueName(string propval)
  {
    safeFree(cast(void*)(cast(GFlagsValue*)cPtr).valueName);
    (cast(GFlagsValue*)cPtr).valueName = propval.toCString(true);
  }

  @property string valueNick()
  {
    return (cast(GFlagsValue*)cPtr).valueNick.fromCString(false);
  }

  @property void valueNick(string propval)
  {
    safeFree(cast(void*)(cast(GFlagsValue*)cPtr).valueNick);
    (cast(GFlagsValue*)cPtr).valueNick = propval.toCString(true);
  }
}
