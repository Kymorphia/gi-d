module GdkPixbuf.PixbufLoaderClass;

import GObject.ObjectClass;
import GdkPixbuf.Types;
import GdkPixbuf.c.functions;
import GdkPixbuf.c.types;
import Gid.gid;

class PixbufLoaderClass
{
  GdkPixbufLoaderClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for GdkPixbuf.PixbufLoaderClass");

    cInstance = *cast(GdkPixbufLoaderClass*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property ObjectClass parentClass()
  {
    return new ObjectClass(cast(GObjectClass*)&(cast(GdkPixbufLoaderClass*)cPtr).parentClass);
  }

  alias SizePreparedFuncType = extern(C) void function(GdkPixbufLoader* loader, int width, int height);

  @property SizePreparedFuncType sizePrepared()
  {
    return (cast(GdkPixbufLoaderClass*)cPtr).sizePrepared;
  }

  alias AreaPreparedFuncType = extern(C) void function(GdkPixbufLoader* loader);

  @property AreaPreparedFuncType areaPrepared()
  {
    return (cast(GdkPixbufLoaderClass*)cPtr).areaPrepared;
  }

  alias AreaUpdatedFuncType = extern(C) void function(GdkPixbufLoader* loader, int x, int y, int width, int height);

  @property AreaUpdatedFuncType areaUpdated()
  {
    return (cast(GdkPixbufLoaderClass*)cPtr).areaUpdated;
  }

  alias ClosedFuncType = extern(C) void function(GdkPixbufLoader* loader);

  @property ClosedFuncType closed()
  {
    return (cast(GdkPixbufLoaderClass*)cPtr).closed;
  }
}
