module GObject.TypeModuleClass;

import GObject.ObjectClass;
import GObject.Types;
import GObject.c.functions;
import GObject.c.types;
import Gid.gid;

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
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property ObjectClass parentClass()
  {
    return new ObjectClass(cast(GObjectClass*)&(cast(GTypeModuleClass*)cPtr).parentClass);
  }

  alias LoadFuncType = extern(C) bool function(GTypeModule* module_);

  @property LoadFuncType load()
  {
    return (cast(GTypeModuleClass*)cPtr).load;
  }

  alias UnloadFuncType = extern(C) void function(GTypeModule* module_);

  @property UnloadFuncType unload()
  {
    return (cast(GTypeModuleClass*)cPtr).unload;
  }
}
