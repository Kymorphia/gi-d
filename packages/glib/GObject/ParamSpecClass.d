module GObject.ParamSpecClass;

import GLib.c.functions;
import GObject.ParamSpec;
import GObject.TypeClass;
import GObject.Types;
import GObject.Value;
import GObject.c.functions;
import GObject.c.types;
import Gid.Gid;

/**
 * The class structure for the GParamSpec type.
 * Normally, GParamSpec classes are filled by
 * g_param_type_register_static().
 */
class ParamSpecClass
{
  GParamSpecClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for GObject.ParamSpecClass");

    cInstance = *cast(GParamSpecClass*)ptr;

    if (ownedRef)
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GParamSpecClass))
  {
    return cast(T*)&cInstance;
  }

  @property TypeClass gTypeClass()
  {
    return new TypeClass(cast(GTypeClass*)&cPtr!GParamSpecClass.gTypeClass);
  }

  @property GType valueType()
  {
    return cPtr!GParamSpecClass.valueType;
  }

  alias FinalizeFuncType = extern(C) void function(GParamSpec* pspec);

  @property FinalizeFuncType finalize()
  {
    return cPtr!GParamSpecClass.finalize;
  }

  alias ValueSetDefaultFuncType = extern(C) void function(GParamSpec* pspec, GValue* value);

  @property ValueSetDefaultFuncType valueSetDefault()
  {
    return cPtr!GParamSpecClass.valueSetDefault;
  }

  alias ValueValidateFuncType = extern(C) bool function(GParamSpec* pspec, GValue* value);

  @property ValueValidateFuncType valueValidate()
  {
    return cPtr!GParamSpecClass.valueValidate;
  }

  alias ValuesCmpFuncType = extern(C) int function(GParamSpec* pspec, const(GValue)* value1, const(GValue)* value2);

  @property ValuesCmpFuncType valuesCmp()
  {
    return cPtr!GParamSpecClass.valuesCmp;
  }

  alias ValueIsValidFuncType = extern(C) bool function(GParamSpec* pspec, const(GValue)* value);

  @property ValueIsValidFuncType valueIsValid()
  {
    return cPtr!GParamSpecClass.valueIsValid;
  }
}
