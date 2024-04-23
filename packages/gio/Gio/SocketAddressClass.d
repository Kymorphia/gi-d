module Gio.SocketAddressClass;

import GLib.c.functions;
import GObject.ObjectClass;
import GObject.Types;
import Gid.Gid;
import Gio.SocketAddress;
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
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GSocketAddressClass))
  {
    return cast(T*)&cInstance;
  }

  @property ObjectClass parentClass()
  {
    return new ObjectClass(cast(GObjectClass*)&cPtr!GSocketAddressClass.parentClass);
  }

  alias GetFamilyFuncType = extern(C) GSocketFamily function(GSocketAddress* address);

  @property GetFamilyFuncType getFamily()
  {
    return cPtr!GSocketAddressClass.getFamily;
  }

  alias GetNativeSizeFuncType = extern(C) ptrdiff_t function(GSocketAddress* address);

  @property GetNativeSizeFuncType getNativeSize()
  {
    return cPtr!GSocketAddressClass.getNativeSize;
  }

  alias ToNativeFuncType = extern(C) bool function(GSocketAddress* address, void* dest, size_t destlen, GError** _err);

  @property ToNativeFuncType toNative()
  {
    return cPtr!GSocketAddressClass.toNative;
  }
}
