module Gio.PermissionClass;

import GLib.c.functions;
import GObject.ObjectClass;
import GObject.Types;
import Gid.Gid;
import Gio.AsyncResult;
import Gio.Cancellable;
import Gio.Permission;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

class PermissionClass
{
  GPermissionClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.PermissionClass");

    cInstance = *cast(GPermissionClass*)ptr;

    if (ownedRef)
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GPermissionClass))
  {
    return cast(T*)&cInstance;
  }

  @property ObjectClass parentClass()
  {
    return new ObjectClass(cast(GObjectClass*)&cPtr!GPermissionClass.parentClass);
  }

  alias AcquireFuncType = extern(C) bool function(GPermission* permission, GCancellable* cancellable, GError** _err);

  @property AcquireFuncType acquire()
  {
    return cPtr!GPermissionClass.acquire;
  }

  alias AcquireAsyncFuncType = extern(C) void function(GPermission* permission, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property AcquireAsyncFuncType acquireAsync()
  {
    return cPtr!GPermissionClass.acquireAsync;
  }

  alias AcquireFinishFuncType = extern(C) bool function(GPermission* permission, GAsyncResult* result, GError** _err);

  @property AcquireFinishFuncType acquireFinish()
  {
    return cPtr!GPermissionClass.acquireFinish;
  }

  alias ReleaseFuncType = extern(C) bool function(GPermission* permission, GCancellable* cancellable, GError** _err);

  @property ReleaseFuncType release()
  {
    return cPtr!GPermissionClass.release;
  }

  alias ReleaseAsyncFuncType = extern(C) void function(GPermission* permission, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property ReleaseAsyncFuncType releaseAsync()
  {
    return cPtr!GPermissionClass.releaseAsync;
  }

  alias ReleaseFinishFuncType = extern(C) bool function(GPermission* permission, GAsyncResult* result, GError** _err);

  @property ReleaseFinishFuncType releaseFinish()
  {
    return cPtr!GPermissionClass.releaseFinish;
  }
}
