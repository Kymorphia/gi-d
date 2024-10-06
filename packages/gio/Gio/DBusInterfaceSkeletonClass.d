module Gio.DBusInterfaceSkeletonClass;

import GObject.ObjectClass;
import Gid.gid;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * Class structure for #GDBusInterfaceSkeleton.
 */
class DBusInterfaceSkeletonClass
{
  GDBusInterfaceSkeletonClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.DBusInterfaceSkeletonClass");

    cInstance = *cast(GDBusInterfaceSkeletonClass*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property ObjectClass parentClass()
  {
    return new ObjectClass(cast(GObjectClass*)&(cast(GDBusInterfaceSkeletonClass*)cPtr).parentClass);
  }

  alias GetInfoFuncType = extern(C) GDBusInterfaceInfo* function(GDBusInterfaceSkeleton* interface_);

  @property GetInfoFuncType getInfo()
  {
    return (cast(GDBusInterfaceSkeletonClass*)cPtr).getInfo;
  }

  alias GetVtableFuncType = extern(C) GDBusInterfaceVTable* function(GDBusInterfaceSkeleton* interface_);

  @property GetVtableFuncType getVtable()
  {
    return (cast(GDBusInterfaceSkeletonClass*)cPtr).getVtable;
  }

  alias GetPropertiesFuncType = extern(C) GVariant* function(GDBusInterfaceSkeleton* interface_);

  @property GetPropertiesFuncType getProperties()
  {
    return (cast(GDBusInterfaceSkeletonClass*)cPtr).getProperties;
  }

  alias FlushFuncType = extern(C) void function(GDBusInterfaceSkeleton* interface_);

  @property FlushFuncType flush()
  {
    return (cast(GDBusInterfaceSkeletonClass*)cPtr).flush;
  }

  alias GAuthorizeMethodFuncType = extern(C) bool function(GDBusInterfaceSkeleton* interface_, GDBusMethodInvocation* invocation);

  @property GAuthorizeMethodFuncType gAuthorizeMethod()
  {
    return (cast(GDBusInterfaceSkeletonClass*)cPtr).gAuthorizeMethod;
  }
}
