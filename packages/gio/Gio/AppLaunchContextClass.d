module Gio.AppLaunchContextClass;

import GLib.List;
import GLib.Types;
import GLib.Variant;
import GLib.c.functions;
import GObject.ObjectClass;
import GObject.Types;
import Gid.Gid;
import Gio.AppInfo;
import Gio.AppLaunchContext;
import Gio.File;
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
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GAppLaunchContextClass))
  {
    return cast(T*)&cInstance;
  }

  @property ObjectClass parentClass()
  {
    return new ObjectClass(cast(GObjectClass*)&cPtr!GAppLaunchContextClass.parentClass);
  }

  alias GetDisplayFuncType = extern(C) char* function(GAppLaunchContext* context, GAppInfo* info, GList* files);

  @property GetDisplayFuncType getDisplay()
  {
    return cPtr!GAppLaunchContextClass.getDisplay;
  }

  alias GetStartupNotifyIdFuncType = extern(C) char* function(GAppLaunchContext* context, GAppInfo* info, GList* files);

  @property GetStartupNotifyIdFuncType getStartupNotifyId()
  {
    return cPtr!GAppLaunchContextClass.getStartupNotifyId;
  }

  alias LaunchFailedFuncType = extern(C) void function(GAppLaunchContext* context, const(char)* startupNotifyId);

  @property LaunchFailedFuncType launchFailed()
  {
    return cPtr!GAppLaunchContextClass.launchFailed;
  }

  alias LaunchedFuncType = extern(C) void function(GAppLaunchContext* context, GAppInfo* info, GVariant* platformData);

  @property LaunchedFuncType launched()
  {
    return cPtr!GAppLaunchContextClass.launched;
  }

  alias LaunchStartedFuncType = extern(C) void function(GAppLaunchContext* context, GAppInfo* info, GVariant* platformData);

  @property LaunchStartedFuncType launchStarted()
  {
    return cPtr!GAppLaunchContextClass.launchStarted;
  }
}
