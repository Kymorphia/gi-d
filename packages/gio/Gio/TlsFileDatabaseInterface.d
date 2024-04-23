module Gio.TlsFileDatabaseInterface;

import GLib.c.functions;
import GObject.TypeInterface;
import GObject.Types;
import Gid.Gid;
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
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GTlsFileDatabaseInterface))
  {
    return cast(T*)&cInstance;
  }

  @property TypeInterface gIface()
  {
    return new TypeInterface(cast(GTypeInterface*)&cPtr!GTlsFileDatabaseInterface.gIface);
  }
}
