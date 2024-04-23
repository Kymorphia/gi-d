module GObject.InitiallyUnownedClass;

import GLib.c.functions;
import GObject.ObjectG;
import GObject.ParamSpec;
import GObject.TypeClass;
import GObject.Types;
import GObject.Value;
import GObject.c.functions;
import GObject.c.types;
import Gid.Gid;

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
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GInitiallyUnownedClass))
  {
    return cast(T*)&cInstance;
  }

  @property TypeClass gTypeClass()
  {
    return new TypeClass(cast(GTypeClass*)&cPtr!GInitiallyUnownedClass.gTypeClass);
  }

  alias SetPropertyFuncType = extern(C) void function(ObjectC* object, uint propertyId, const(GValue)* value, GParamSpec* pspec);

  @property SetPropertyFuncType setProperty()
  {
    return cPtr!GInitiallyUnownedClass.setProperty;
  }

  alias GetPropertyFuncType = extern(C) void function(ObjectC* object, uint propertyId, GValue* value, GParamSpec* pspec);

  @property GetPropertyFuncType getProperty()
  {
    return cPtr!GInitiallyUnownedClass.getProperty;
  }

  alias DisposeFuncType = extern(C) void function(ObjectC* object);

  @property DisposeFuncType dispose()
  {
    return cPtr!GInitiallyUnownedClass.dispose;
  }

  alias FinalizeFuncType = extern(C) void function(ObjectC* object);

  @property FinalizeFuncType finalize()
  {
    return cPtr!GInitiallyUnownedClass.finalize;
  }

  alias DispatchPropertiesChangedFuncType = extern(C) void function(ObjectC* object, uint nPspecs, GParamSpec** pspecs);

  @property DispatchPropertiesChangedFuncType dispatchPropertiesChanged()
  {
    return cPtr!GInitiallyUnownedClass.dispatchPropertiesChanged;
  }

  alias NotifyFuncType = extern(C) void function(ObjectC* object, GParamSpec* pspec);

  @property NotifyFuncType notify()
  {
    return cPtr!GInitiallyUnownedClass.notify;
  }

  alias ConstructedFuncType = extern(C) void function(ObjectC* object);

  @property ConstructedFuncType constructed()
  {
    return cPtr!GInitiallyUnownedClass.constructed;
  }
}
