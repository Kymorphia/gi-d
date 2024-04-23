module Gio.ZlibDecompressorClass;

import GLib.c.functions;
import GObject.ObjectClass;
import GObject.Types;
import Gid.Gid;
import Gio.c.functions;
import Gio.c.types;

class ZlibDecompressorClass
{
  GZlibDecompressorClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.ZlibDecompressorClass");

    cInstance = *cast(GZlibDecompressorClass*)ptr;

    if (ownedRef)
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GZlibDecompressorClass))
  {
    return cast(T*)&cInstance;
  }

  @property ObjectClass parentClass()
  {
    return new ObjectClass(cast(GObjectClass*)&cPtr!GZlibDecompressorClass.parentClass);
  }
}
