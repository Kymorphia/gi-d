module Gio.DBusObjectSkeletonClass;

import GObject.ObjectClass;
import Gid.gid;
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
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property ObjectClass parentClass()
  {
    return new ObjectClass(cast(GObjectClass*)&(cast(GDBusObjectSkeletonClass*)cPtr).parentClass);
  }

  alias AuthorizeMethodFuncType = extern(C) bool function(GDBusObjectSkeleton* object, GDBusInterfaceSkeleton* interface_, GDBusMethodInvocation* invocation);

  @property AuthorizeMethodFuncType authorizeMethod()
  {
    return (cast(GDBusObjectSkeletonClass*)cPtr).authorizeMethod;
  }
}
