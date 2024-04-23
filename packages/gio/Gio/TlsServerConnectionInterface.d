module Gio.TlsServerConnectionInterface;

import GLib.c.functions;
import GObject.TypeInterface;
import GObject.Types;
import Gid.Gid;
import Gio.c.functions;
import Gio.c.types;

/**
 * vtable for a #GTlsServerConnection implementation.
 */
class TlsServerConnectionInterface
{
  GTlsServerConnectionInterface cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.TlsServerConnectionInterface");

    cInstance = *cast(GTlsServerConnectionInterface*)ptr;

    if (ownedRef)
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GTlsServerConnectionInterface))
  {
    return cast(T*)&cInstance;
  }

  @property TypeInterface gIface()
  {
    return new TypeInterface(cast(GTypeInterface*)&cPtr!GTlsServerConnectionInterface.gIface);
  }
}
