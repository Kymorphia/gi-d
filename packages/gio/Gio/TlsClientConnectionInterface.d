module Gio.TlsClientConnectionInterface;

import GObject.TypeInterface;
import Gid.gid;
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
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property TypeInterface gIface()
  {
    return new TypeInterface(cast(GTypeInterface*)&(cast(GTlsClientConnectionInterface*)cPtr).gIface);
  }

  alias CopySessionStateFuncType = extern(C) void function(GTlsClientConnection* conn, GTlsClientConnection* source);

  @property CopySessionStateFuncType copySessionState()
  {
    return (cast(GTlsClientConnectionInterface*)cPtr).copySessionState;
  }
}
