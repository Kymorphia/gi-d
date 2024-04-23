module Gio.UnixCredentialsMessageClass;

import GLib.c.functions;
import Gid.Gid;
import Gio.SocketControlMessageClass;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * Class structure for #GUnixCredentialsMessage.
 */
class UnixCredentialsMessageClass
{
  GUnixCredentialsMessageClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.UnixCredentialsMessageClass");

    cInstance = *cast(GUnixCredentialsMessageClass*)ptr;

    if (ownedRef)
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GUnixCredentialsMessageClass))
  {
    return cast(T*)&cInstance;
  }

  @property SocketControlMessageClass parentClass()
  {
    return new SocketControlMessageClass(cast(GSocketControlMessageClass*)&cPtr!GUnixCredentialsMessageClass.parentClass);
  }
}
