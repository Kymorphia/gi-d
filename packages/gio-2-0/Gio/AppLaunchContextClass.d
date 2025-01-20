module Gio.AppLaunchContextClass;

import GObject.ObjectClass;
import Gid.gid;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

class AppLaunchContextClass
{
  GAppLaunchContextClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.AppLaunchContextClass");

    cInstance = *cast(GAppLaunchContextClass*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property ObjectClass parentClass()
  {
    return new ObjectClass(cast(GObjectClass*)&(cast(GAppLaunchContextClass*)cPtr).parentClass);
  }

  alias GetDisplayFuncType = extern(C) char* function(GAppLaunchContext* context, GAppInfo* info, GList* files);

  @property GetDisplayFuncType getDisplay()
  {
    return (cast(GAppLaunchContextClass*)cPtr).getDisplay;
  }

  alias GetStartupNotifyIdFuncType = extern(C) char* function(GAppLaunchContext* context, GAppInfo* info, GList* files);

  @property GetStartupNotifyIdFuncType getStartupNotifyId()
  {
    return (cast(GAppLaunchContextClass*)cPtr).getStartupNotifyId;
  }

  alias LaunchFailedFuncType = extern(C) void function(GAppLaunchContext* context, const(char)* startupNotifyId);

  @property LaunchFailedFuncType launchFailed()
  {
    return (cast(GAppLaunchContextClass*)cPtr).launchFailed;
  }

  alias LaunchedFuncType = extern(C) void function(GAppLaunchContext* context, GAppInfo* info, GVariant* platformData);

  @property LaunchedFuncType launched()
  {
    return (cast(GAppLaunchContextClass*)cPtr).launched;
  }

  alias LaunchStartedFuncType = extern(C) void function(GAppLaunchContext* context, GAppInfo* info, GVariant* platformData);

  @property LaunchStartedFuncType launchStarted()
  {
    return (cast(GAppLaunchContextClass*)cPtr).launchStarted;
  }
}
