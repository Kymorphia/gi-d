module Gio.FileAttributeInfo;

import Gid.gid;
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
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property string name()
  {
    return (cast(GFileAttributeInfo*)cPtr).name.fromCString(false);
  }

  @property void name(string propval)
  {
    safeFree(cast(void*)(cast(GFileAttributeInfo*)cPtr).name);
    (cast(GFileAttributeInfo*)cPtr).name = propval.toCString(true);
  }

  @property FileAttributeType type()
  {
    return cast(FileAttributeType)(cast(GFileAttributeInfo*)cPtr).type;
  }

  @property void type(FileAttributeType propval)
  {
    (cast(GFileAttributeInfo*)cPtr).type = cast(GFileAttributeType)propval;
  }

  @property FileAttributeInfoFlags flags()
  {
    return cast(FileAttributeInfoFlags)(cast(GFileAttributeInfo*)cPtr).flags;
  }

  @property void flags(FileAttributeInfoFlags propval)
  {
    (cast(GFileAttributeInfo*)cPtr).flags = cast(GFileAttributeInfoFlags)propval;
  }
}
