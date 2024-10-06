module Gio.DtlsClientConnectionInterface;

import GObject.TypeInterface;
import Gid.gid;
import Gio.Types;
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
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property TypeInterface gIface()
  {
    return new TypeInterface(cast(GTypeInterface*)&(cast(GDtlsClientConnectionInterface*)cPtr).gIface);
  }
}