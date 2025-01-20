module Gio.SocketAddressClass;

import GObject.ObjectClass;
import Gid.gid;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

class SocketAddressClass
{
  GSocketAddressClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.SocketAddressClass");

    cInstance = *cast(GSocketAddressClass*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property ObjectClass parentClass()
  {
    return new ObjectClass(cast(GObjectClass*)&(cast(GSocketAddressClass*)cPtr).parentClass);
  }

  alias GetFamilyFuncType = extern(C) GSocketFamily function(GSocketAddress* address);

  @property GetFamilyFuncType getFamily()
  {
    return (cast(GSocketAddressClass*)cPtr).getFamily;
  }

  alias GetNativeSizeFuncType = extern(C) ptrdiff_t function(GSocketAddress* address);

  @property GetNativeSizeFuncType getNativeSize()
  {
    return (cast(GSocketAddressClass*)cPtr).getNativeSize;
  }

  alias ToNativeFuncType = extern(C) bool function(GSocketAddress* address, void* dest, size_t destlen, GError** _err);

  @property ToNativeFuncType toNative()
  {
    return (cast(GSocketAddressClass*)cPtr).toNative;
  }
}
