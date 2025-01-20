module Gio.FileDescriptorBasedIface;

import GObject.TypeInterface;
import Gid.gid;
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
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property TypeInterface gIface()
  {
    return new TypeInterface(cast(GTypeInterface*)&(cast(GFileDescriptorBasedIface*)cPtr).gIface);
  }

  alias GetFdFuncType = extern(C) int function(GFileDescriptorBased* fdBased);

  @property GetFdFuncType getFd()
  {
    return (cast(GFileDescriptorBasedIface*)cPtr).getFd;
  }
}
