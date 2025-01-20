module Gio.SettingsClass;

import GObject.ObjectClass;
import Gid.gid;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

class SettingsClass
{
  GSettingsClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.SettingsClass");

    cInstance = *cast(GSettingsClass*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property ObjectClass parentClass()
  {
    return new ObjectClass(cast(GObjectClass*)&(cast(GSettingsClass*)cPtr).parentClass);
  }

  alias WritableChangedFuncType = extern(C) void function(GSettings* settings, const(char)* key);

  @property WritableChangedFuncType writableChanged()
  {
    return (cast(GSettingsClass*)cPtr).writableChanged;
  }

  alias ChangedFuncType = extern(C) void function(GSettings* settings, const(char)* key);

  @property ChangedFuncType changed()
  {
    return (cast(GSettingsClass*)cPtr).changed;
  }

  alias WritableChangeEventFuncType = extern(C) bool function(GSettings* settings, GQuark key);

  @property WritableChangeEventFuncType writableChangeEvent()
  {
    return (cast(GSettingsClass*)cPtr).writableChangeEvent;
  }

  alias ChangeEventFuncType = extern(C) bool function(GSettings* settings, const(GQuark)* keys, int nKeys);

  @property ChangeEventFuncType changeEvent()
  {
    return (cast(GSettingsClass*)cPtr).changeEvent;
  }
}
