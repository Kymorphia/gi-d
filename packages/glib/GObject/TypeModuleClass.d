module GObject.TypeModuleClass;

import GLib.c.functions;
import GObject.ObjectClass;
import GObject.TypeModule;
import GObject.Types;
import GObject.c.functions;
import GObject.c.types;
import Gid.Gid;

/**
 * In order to implement dynamic loading of types based on #GTypeModule,
 * the @load and @unload functions in #GTypeModuleClass must be implemented.
 */
class TypeModuleClass
{
  GTypeModuleClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for GObject.TypeModuleClass");

    cInstance = *cast(GTypeModuleClass*)ptr;

    if (ownedRef)
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GTypeModuleClass))
  {
    return cast(T*)&cInstance;
  }

  @property ObjectClass parentClass()
  {
    return new ObjectClass(cast(GObjectClass*)&cPtr!GTypeModuleClass.parentClass);
  }

  alias LoadFuncType = extern(C) bool function(GTypeModule* module_);

  @property LoadFuncType load()
  {
    return cPtr!GTypeModuleClass.load;
  }

  alias UnloadFuncType = extern(C) void function(GTypeModule* module_);

  @property UnloadFuncType unload()
  {
    return cPtr!GTypeModuleClass.unload;
  }
}
