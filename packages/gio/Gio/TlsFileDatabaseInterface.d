module Gio.TlsFileDatabaseInterface;

import GObject.TypeInterface;
import Gid.gid;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * Provides an interface for #GTlsFileDatabase implementations.
 */
class TlsFileDatabaseInterface
{
  GTlsFileDatabaseInterface cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.TlsFileDatabaseInterface");

    cInstance = *cast(GTlsFileDatabaseInterface*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property TypeInterface gIface()
  {
    return new TypeInterface(cast(GTypeInterface*)&(cast(GTlsFileDatabaseInterface*)cPtr).gIface);
  }
}
