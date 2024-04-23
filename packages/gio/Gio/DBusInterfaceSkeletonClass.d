module Gio.DBusInterfaceSkeletonClass;

import GLib.Types;
import GLib.Variant;
import GLib.c.functions;
import GObject.ObjectClass;
import GObject.Types;
import Gid.Gid;
import Gio.DBusInterfaceInfo;
import Gio.DBusInterfaceSkeleton;
import Gio.DBusInterfaceVTable;
import Gio.DBusMethodInvocation;
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
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GDBusInterfaceSkeletonClass))
  {
    return cast(T*)&cInstance;
  }

  @property ObjectClass parentClass()
  {
    return new ObjectClass(cast(GObjectClass*)&cPtr!GDBusInterfaceSkeletonClass.parentClass);
  }

  alias GetInfoFuncType = extern(C) GDBusInterfaceInfo* function(GDBusInterfaceSkeleton* interface_);

  @property GetInfoFuncType getInfo()
  {
    return cPtr!GDBusInterfaceSkeletonClass.getInfo;
  }

  alias GetVtableFuncType = extern(C) GDBusInterfaceVTable* function(GDBusInterfaceSkeleton* interface_);

  @property GetVtableFuncType getVtable()
  {
    return cPtr!GDBusInterfaceSkeletonClass.getVtable;
  }

  alias GetPropertiesFuncType = extern(C) GVariant* function(GDBusInterfaceSkeleton* interface_);

  @property GetPropertiesFuncType getProperties()
  {
    return cPtr!GDBusInterfaceSkeletonClass.getProperties;
  }

  alias FlushFuncType = extern(C) void function(GDBusInterfaceSkeleton* interface_);

  @property FlushFuncType flush()
  {
    return cPtr!GDBusInterfaceSkeletonClass.flush;
  }

  alias GAuthorizeMethodFuncType = extern(C) bool function(GDBusInterfaceSkeleton* interface_, GDBusMethodInvocation* invocation);

  @property GAuthorizeMethodFuncType gAuthorizeMethod()
  {
    return cPtr!GDBusInterfaceSkeletonClass.gAuthorizeMethod;
  }
}
