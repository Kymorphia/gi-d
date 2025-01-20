module GObject.InitiallyUnownedClass;

import GObject.TypeClass;
import GObject.Types;
import GObject.c.functions;
import GObject.c.types;
import Gid.gid;

/**
 * The class structure for the GInitiallyUnowned type.
 */
class InitiallyUnownedClass
{
  GInitiallyUnownedClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for GObject.InitiallyUnownedClass");

    cInstance = *cast(GInitiallyUnownedClass*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property TypeClass gTypeClass()
  {
    return new TypeClass(cast(GTypeClass*)&(cast(GInitiallyUnownedClass*)cPtr).gTypeClass);
  }

  alias SetPropertyFuncType = extern(C) void function(ObjectC* object, uint propertyId, const(GValue)* value, GParamSpec* pspec);

  @property SetPropertyFuncType setProperty()
  {
    return (cast(GInitiallyUnownedClass*)cPtr).setProperty;
  }

  alias GetPropertyFuncType = extern(C) void function(ObjectC* object, uint propertyId, GValue* value, GParamSpec* pspec);

  @property GetPropertyFuncType getProperty()
  {
    return (cast(GInitiallyUnownedClass*)cPtr).getProperty;
  }

  alias DisposeFuncType = extern(C) void function(ObjectC* object);

  @property DisposeFuncType dispose()
  {
    return (cast(GInitiallyUnownedClass*)cPtr).dispose;
  }

  alias FinalizeFuncType = extern(C) void function(ObjectC* object);

  @property FinalizeFuncType finalize()
  {
    return (cast(GInitiallyUnownedClass*)cPtr).finalize;
  }

  alias DispatchPropertiesChangedFuncType = extern(C) void function(ObjectC* object, uint nPspecs, GParamSpec** pspecs);

  @property DispatchPropertiesChangedFuncType dispatchPropertiesChanged()
  {
    return (cast(GInitiallyUnownedClass*)cPtr).dispatchPropertiesChanged;
  }

  alias NotifyFuncType = extern(C) void function(ObjectC* object, GParamSpec* pspec);

  @property NotifyFuncType notify()
  {
    return (cast(GInitiallyUnownedClass*)cPtr).notify;
  }

  alias ConstructedFuncType = extern(C) void function(ObjectC* object);

  @property ConstructedFuncType constructed()
  {
    return (cast(GInitiallyUnownedClass*)cPtr).constructed;
  }
}
