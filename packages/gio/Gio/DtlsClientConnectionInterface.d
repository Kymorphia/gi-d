module Gio.DtlsClientConnectionInterface;

import GLib.c.functions;
import GObject.TypeInterface;
import GObject.Types;
import Gid.Gid;
import Gio.c.functions;
import Gio.c.types;

/**
 * vtable for a #GDtlsClientConnection implementation.
 */
class DtlsClientConnectionInterface
{
  GDtlsClientConnectionInterface cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.DtlsClientConnectionInterface");

    cInstance = *cast(GDtlsClientConnectionInterface*)ptr;

    if (ownedRef)
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GDtlsClientConnectionInterface))
  {
    return cast(T*)&cInstance;
  }

  @property TypeInterface gIface()
  {
    return new TypeInterface(cast(GTypeInterface*)&cPtr!GDtlsClientConnectionInterface.gIface);
  }
}
