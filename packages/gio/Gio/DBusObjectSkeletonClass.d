module Gio.DBusObjectSkeletonClass;

import GLib.c.functions;
import GObject.ObjectClass;
import GObject.Types;
import Gid.Gid;
import Gio.DBusInterfaceSkeleton;
import Gio.DBusMethodInvocation;
import Gio.DBusObjectSkeleton;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * Class structure for #GDBusObjectSkeleton.
 */
class DBusObjectSkeletonClass
{
  GDBusObjectSkeletonClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.DBusObjectSkeletonClass");

    cInstance = *cast(GDBusObjectSkeletonClass*)ptr;

    if (ownedRef)
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GDBusObjectSkeletonClass))
  {
    return cast(T*)&cInstance;
  }

  @property ObjectClass parentClass()
  {
    return new ObjectClass(cast(GObjectClass*)&cPtr!GDBusObjectSkeletonClass.parentClass);
  }

  alias AuthorizeMethodFuncType = extern(C) bool function(GDBusObjectSkeleton* object, GDBusInterfaceSkeleton* interface_, GDBusMethodInvocation* invocation);

  @property AuthorizeMethodFuncType authorizeMethod()
  {
    return cPtr!GDBusObjectSkeletonClass.authorizeMethod;
  }
}
