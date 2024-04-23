module Gio.FileDescriptorBasedIface;

import GLib.c.functions;
import GObject.TypeInterface;
import GObject.Types;
import Gid.Gid;
import Gio.FileDescriptorBased;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * An interface for file descriptor based io objects.
 */
class FileDescriptorBasedIface
{
  GFileDescriptorBasedIface cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.FileDescriptorBasedIface");

    cInstance = *cast(GFileDescriptorBasedIface*)ptr;

    if (ownedRef)
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GFileDescriptorBasedIface))
  {
    return cast(T*)&cInstance;
  }

  @property TypeInterface gIface()
  {
    return new TypeInterface(cast(GTypeInterface*)&cPtr!GFileDescriptorBasedIface.gIface);
  }

  alias GetFdFuncType = extern(C) int function(GFileDescriptorBased* fdBased);

  @property GetFdFuncType getFd()
  {
    return cPtr!GFileDescriptorBasedIface.getFd;
  }
}
