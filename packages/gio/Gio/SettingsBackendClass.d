module Gio.SettingsBackendClass;

import GLib.Tree;
import GLib.Types;
import GLib.Variant;
import GLib.VariantType;
import GLib.c.functions;
import GObject.ObjectClass;
import GObject.Types;
import Gid.Gid;
import Gio.SettingsBackend;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * Class structure for #GSettingsBackend.
 */
class SettingsBackendClass
{
  GSettingsBackendClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.SettingsBackendClass");

    cInstance = *cast(GSettingsBackendClass*)ptr;

    if (ownedRef)
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GSettingsBackendClass))
  {
    return cast(T*)&cInstance;
  }

  @property ObjectClass parentClass()
  {
    return new ObjectClass(cast(GObjectClass*)&cPtr!GSettingsBackendClass.parentClass);
  }

  alias ReadFuncType = extern(C) GVariant* function(GSettingsBackend* backend, const(char)* key, const(GVariantType)* expectedType, bool defaultValue);

  @property ReadFuncType read()
  {
    return cPtr!GSettingsBackendClass.read;
  }

  alias GetWritableFuncType = extern(C) bool function(GSettingsBackend* backend, const(char)* key);

  @property GetWritableFuncType getWritable()
  {
    return cPtr!GSettingsBackendClass.getWritable;
  }

  alias WriteFuncType = extern(C) bool function(GSettingsBackend* backend, const(char)* key, GVariant* value, void* originTag);

  @property WriteFuncType write()
  {
    return cPtr!GSettingsBackendClass.write;
  }

  alias WriteTreeFuncType = extern(C) bool function(GSettingsBackend* backend, GTree* tree, void* originTag);

  @property WriteTreeFuncType writeTree()
  {
    return cPtr!GSettingsBackendClass.writeTree;
  }

  alias ResetFuncType = extern(C) void function(GSettingsBackend* backend, const(char)* key, void* originTag);

  @property ResetFuncType reset()
  {
    return cPtr!GSettingsBackendClass.reset;
  }

  alias SubscribeFuncType = extern(C) void function(GSettingsBackend* backend, const(char)* name);

  @property SubscribeFuncType subscribe()
  {
    return cPtr!GSettingsBackendClass.subscribe;
  }

  alias UnsubscribeFuncType = extern(C) void function(GSettingsBackend* backend, const(char)* name);

  @property UnsubscribeFuncType unsubscribe()
  {
    return cPtr!GSettingsBackendClass.unsubscribe;
  }

  alias SyncFuncType = extern(C) void function(GSettingsBackend* backend);

  @property SyncFuncType sync()
  {
    return cPtr!GSettingsBackendClass.sync;
  }

  alias ReadUserValueFuncType = extern(C) GVariant* function(GSettingsBackend* backend, const(char)* key, const(GVariantType)* expectedType);

  @property ReadUserValueFuncType readUserValue()
  {
    return cPtr!GSettingsBackendClass.readUserValue;
  }
}
