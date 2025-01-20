module Gio.ConverterIface;

import GObject.TypeInterface;
import Gid.gid;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * Provides an interface for converting data from one type
 * to another type. The conversion can be stateful
 * and may fail at any place.
 */
class ConverterIface
{
  GConverterIface cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.ConverterIface");

    cInstance = *cast(GConverterIface*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property TypeInterface gIface()
  {
    return new TypeInterface(cast(GTypeInterface*)&(cast(GConverterIface*)cPtr).gIface);
  }

  alias ConvertFuncType = extern(C) GConverterResult function(GConverter* converter, void* inbuf, size_t inbufSize, void* outbuf, size_t outbufSize, GConverterFlags flags, size_t* bytesRead, size_t* bytesWritten, GError** _err);

  @property ConvertFuncType convert()
  {
    return (cast(GConverterIface*)cPtr).convert;
  }

  alias ResetFuncType = extern(C) void function(GConverter* converter);

  @property ResetFuncType reset()
  {
    return (cast(GConverterIface*)cPtr).reset;
  }
}
