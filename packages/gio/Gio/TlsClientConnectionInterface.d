module Gio.TlsClientConnectionInterface;

import GLib.c.functions;
import GObject.TypeInterface;
import GObject.Types;
import Gid.Gid;
import Gio.TlsClientConnection;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * vtable for a #GTlsClientConnection implementation.
 */
class TlsClientConnectionInterface
{
  GTlsClientConnectionInterface cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.TlsClientConnectionInterface");

    cInstance = *cast(GTlsClientConnectionInterface*)ptr;

    if (ownedRef)
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GTlsClientConnectionInterface))
  {
    return cast(T*)&cInstance;
  }

  @property TypeInterface gIface()
  {
    return new TypeInterface(cast(GTypeInterface*)&cPtr!GTlsClientConnectionInterface.gIface);
  }

  alias CopySessionStateFuncType = extern(C) void function(GTlsClientConnection* conn, GTlsClientConnection* source);

  @property CopySessionStateFuncType copySessionState()
  {
    return cPtr!GTlsClientConnectionInterface.copySessionState;
  }
}
