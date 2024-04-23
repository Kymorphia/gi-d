module Gio.DtlsServerConnectionInterface;

import GLib.c.functions;
import GObject.TypeInterface;
import GObject.Types;
import Gid.Gid;
import Gio.c.functions;
import Gio.c.types;

/**
 * vtable for a #GDtlsServerConnection implementation.
 */
class DtlsServerConnectionInterface
{
  GDtlsServerConnectionInterface cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.DtlsServerConnectionInterface");

    cInstance = *cast(GDtlsServerConnectionInterface*)ptr;

    if (ownedRef)
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GDtlsServerConnectionInterface))
  {
    return cast(T*)&cInstance;
  }

  @property TypeInterface gIface()
  {
    return new TypeInterface(cast(GTypeInterface*)&cPtr!GDtlsServerConnectionInterface.gIface);
  }
}
