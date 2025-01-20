module GObject.ParamSpecClass;

import GObject.TypeClass;
import GObject.Types;
import GObject.c.functions;
import GObject.c.types;
import Gid.gid;

/**
 * The class structure for the GParamSpec type.
 * Normally, GParamSpec classes are filled by
 * [GObject.Global.paramTypeRegisterStatic].
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
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property TypeClass gTypeClass()
  {
    return new TypeClass(cast(GTypeClass*)&(cast(GParamSpecClass*)cPtr).gTypeClass);
  }

  @property GType valueType()
  {
    return (cast(GParamSpecClass*)cPtr).valueType;
  }

  alias FinalizeFuncType = extern(C) void function(GParamSpec* pspec);

  @property FinalizeFuncType finalize()
  {
    return (cast(GParamSpecClass*)cPtr).finalize;
  }

  alias ValueSetDefaultFuncType = extern(C) void function(GParamSpec* pspec, GValue* value);

  @property ValueSetDefaultFuncType valueSetDefault()
  {
    return (cast(GParamSpecClass*)cPtr).valueSetDefault;
  }

  alias ValueValidateFuncType = extern(C) bool function(GParamSpec* pspec, GValue* value);

  @property ValueValidateFuncType valueValidate()
  {
    return (cast(GParamSpecClass*)cPtr).valueValidate;
  }

  alias ValuesCmpFuncType = extern(C) int function(GParamSpec* pspec, const(GValue)* value1, const(GValue)* value2);

  @property ValuesCmpFuncType valuesCmp()
  {
    return (cast(GParamSpecClass*)cPtr).valuesCmp;
  }

  alias ValueIsValidFuncType = extern(C) bool function(GParamSpec* pspec, const(GValue)* value);

  @property ValueIsValidFuncType valueIsValid()
  {
    return (cast(GParamSpecClass*)cPtr).valueIsValid;
  }
}
