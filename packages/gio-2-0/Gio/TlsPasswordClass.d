module Gio.TlsPasswordClass;

import GObject.ObjectClass;
import Gid.gid;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * Class structure for #GTlsPassword.
 */
class TlsPasswordClass
{
  GTlsPasswordClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.TlsPasswordClass");

    cInstance = *cast(GTlsPasswordClass*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property ObjectClass parentClass()
  {
    return new ObjectClass(cast(GObjectClass*)&(cast(GTlsPasswordClass*)cPtr).parentClass);
  }

  alias GetValueFuncType = extern(C) const(ubyte)* function(GTlsPassword* password, size_t* length);

  @property GetValueFuncType getValue()
  {
    return (cast(GTlsPasswordClass*)cPtr).getValue;
  }

  alias SetValueFuncType = extern(C) void function(GTlsPassword* password, ubyte* value, ptrdiff_t length, GDestroyNotify destroy);

  @property SetValueFuncType setValue()
  {
    return (cast(GTlsPasswordClass*)cPtr).setValue;
  }

  alias GetDefaultWarningFuncType = extern(C) const(char)* function(GTlsPassword* password);

  @property GetDefaultWarningFuncType getDefaultWarning()
  {
    return (cast(GTlsPasswordClass*)cPtr).getDefaultWarning;
  }
}
