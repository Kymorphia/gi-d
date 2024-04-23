module Gio.TlsPasswordClass;

import GLib.Types;
import GLib.c.functions;
import GObject.ObjectClass;
import GObject.Types;
import Gid.Gid;
import Gio.TlsPassword;
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
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GTlsPasswordClass))
  {
    return cast(T*)&cInstance;
  }

  @property ObjectClass parentClass()
  {
    return new ObjectClass(cast(GObjectClass*)&cPtr!GTlsPasswordClass.parentClass);
  }

  alias GetValueFuncType = extern(C) const(ubyte)* function(GTlsPassword* password, size_t* length);

  @property GetValueFuncType getValue()
  {
    return cPtr!GTlsPasswordClass.getValue;
  }

  alias SetValueFuncType = extern(C) void function(GTlsPassword* password, ubyte* value, ptrdiff_t length, GDestroyNotify destroy);

  @property SetValueFuncType setValue()
  {
    return cPtr!GTlsPasswordClass.setValue;
  }

  alias GetDefaultWarningFuncType = extern(C) const(char)* function(GTlsPassword* password);

  @property GetDefaultWarningFuncType getDefaultWarning()
  {
    return cPtr!GTlsPasswordClass.getDefaultWarning;
  }
}
