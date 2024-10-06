module Gio.SettingsBackendClass;

import GObject.ObjectClass;
import Gid.gid;
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
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property ObjectClass parentClass()
  {
    return new ObjectClass(cast(GObjectClass*)&(cast(GSettingsBackendClass*)cPtr).parentClass);
  }

  alias ReadFuncType = extern(C) GVariant* function(GSettingsBackend* backend, const(char)* key, const(GVariantType)* expectedType, bool defaultValue);

  @property ReadFuncType read()
  {
    return (cast(GSettingsBackendClass*)cPtr).read;
  }

  alias GetWritableFuncType = extern(C) bool function(GSettingsBackend* backend, const(char)* key);

  @property GetWritableFuncType getWritable()
  {
    return (cast(GSettingsBackendClass*)cPtr).getWritable;
  }

  alias WriteFuncType = extern(C) bool function(GSettingsBackend* backend, const(char)* key, GVariant* value, void* originTag);

  @property WriteFuncType write()
  {
    return (cast(GSettingsBackendClass*)cPtr).write;
  }

  alias WriteTreeFuncType = extern(C) bool function(GSettingsBackend* backend, GTree* tree, void* originTag);

  @property WriteTreeFuncType writeTree()
  {
    return (cast(GSettingsBackendClass*)cPtr).writeTree;
  }

  alias ResetFuncType = extern(C) void function(GSettingsBackend* backend, const(char)* key, void* originTag);

  @property ResetFuncType reset()
  {
    return (cast(GSettingsBackendClass*)cPtr).reset;
  }

  alias SubscribeFuncType = extern(C) void function(GSettingsBackend* backend, const(char)* name);

  @property SubscribeFuncType subscribe()
  {
    return (cast(GSettingsBackendClass*)cPtr).subscribe;
  }

  alias UnsubscribeFuncType = extern(C) void function(GSettingsBackend* backend, const(char)* name);

  @property UnsubscribeFuncType unsubscribe()
  {
    return (cast(GSettingsBackendClass*)cPtr).unsubscribe;
  }

  alias SyncFuncType = extern(C) void function(GSettingsBackend* backend);

  @property SyncFuncType sync()
  {
    return (cast(GSettingsBackendClass*)cPtr).sync;
  }

  alias ReadUserValueFuncType = extern(C) GVariant* function(GSettingsBackend* backend, const(char)* key, const(GVariantType)* expectedType);

  @property ReadUserValueFuncType readUserValue()
  {
    return (cast(GSettingsBackendClass*)cPtr).readUserValue;
  }
}
