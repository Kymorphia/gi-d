module Gio.FileAttributeInfo;

import GLib.c.functions;
import Gid.Gid;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * Information about a specific attribute.
 */
class FileAttributeInfo
{
  GFileAttributeInfo cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.FileAttributeInfo");

    cInstance = *cast(GFileAttributeInfo*)ptr;

    if (ownedRef)
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GFileAttributeInfo))
  {
    return cast(T*)&cInstance;
  }

  @property string name()
  {
    return cPtr!GFileAttributeInfo.name.fromCString(false);
  }

  @property void name(string propval)
  {
    g_free(cast(void*)cPtr!GFileAttributeInfo.name);
    cPtr!GFileAttributeInfo.name = propval.toCString(true);
  }

  @property FileAttributeType type()
  {
    return cast(FileAttributeType)cPtr!GFileAttributeInfo.type;
  }

  @property void type(FileAttributeType propval)
  {
    cPtr!GFileAttributeInfo.type = cast(GFileAttributeType)propval;
  }

  @property FileAttributeInfoFlags flags()
  {
    return cast(FileAttributeInfoFlags)cPtr!GFileAttributeInfo.flags;
  }

  @property void flags(FileAttributeInfoFlags propval)
  {
    cPtr!GFileAttributeInfo.flags = cast(GFileAttributeInfoFlags)propval;
  }
}
