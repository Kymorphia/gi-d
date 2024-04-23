module Gio.NativeSocketAddressClass;

import GLib.c.functions;
import Gid.Gid;
import Gio.SocketAddressClass;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

class NativeSocketAddressClass
{
  GNativeSocketAddressClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.NativeSocketAddressClass");

    cInstance = *cast(GNativeSocketAddressClass*)ptr;

    if (ownedRef)
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GNativeSocketAddressClass))
  {
    return cast(T*)&cInstance;
  }

  @property SocketAddressClass parentClass()
  {
    return new SocketAddressClass(cast(GSocketAddressClass*)&cPtr!GNativeSocketAddressClass.parentClass);
  }
}
