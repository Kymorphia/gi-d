module Gio.SettingsClass;

import GLib.Types;
import GLib.c.functions;
import GObject.ObjectClass;
import GObject.Types;
import Gid.Gid;
import Gio.Settings;
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
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GSettingsClass))
  {
    return cast(T*)&cInstance;
  }

  @property ObjectClass parentClass()
  {
    return new ObjectClass(cast(GObjectClass*)&cPtr!GSettingsClass.parentClass);
  }

  alias WritableChangedFuncType = extern(C) void function(GSettings* settings, const(char)* key);

  @property WritableChangedFuncType writableChanged()
  {
    return cPtr!GSettingsClass.writableChanged;
  }

  alias ChangedFuncType = extern(C) void function(GSettings* settings, const(char)* key);

  @property ChangedFuncType changed()
  {
    return cPtr!GSettingsClass.changed;
  }

  alias WritableChangeEventFuncType = extern(C) bool function(GSettings* settings, GQuark key);

  @property WritableChangeEventFuncType writableChangeEvent()
  {
    return cPtr!GSettingsClass.writableChangeEvent;
  }

  alias ChangeEventFuncType = extern(C) bool function(GSettings* settings, const(GQuark)* keys, int nKeys);

  @property ChangeEventFuncType changeEvent()
  {
    return cPtr!GSettingsClass.changeEvent;
  }
}
