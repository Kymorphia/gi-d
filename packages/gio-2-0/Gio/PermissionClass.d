module Gio.PermissionClass;

import GObject.ObjectClass;
import Gid.gid;
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
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property ObjectClass parentClass()
  {
    return new ObjectClass(cast(GObjectClass*)&(cast(GPermissionClass*)cPtr).parentClass);
  }

  alias AcquireFuncType = extern(C) bool function(GPermission* permission, GCancellable* cancellable, GError** _err);

  @property AcquireFuncType acquire()
  {
    return (cast(GPermissionClass*)cPtr).acquire;
  }

  alias AcquireAsyncFuncType = extern(C) void function(GPermission* permission, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property AcquireAsyncFuncType acquireAsync()
  {
    return (cast(GPermissionClass*)cPtr).acquireAsync;
  }

  alias AcquireFinishFuncType = extern(C) bool function(GPermission* permission, GAsyncResult* result, GError** _err);

  @property AcquireFinishFuncType acquireFinish()
  {
    return (cast(GPermissionClass*)cPtr).acquireFinish;
  }

  alias ReleaseFuncType = extern(C) bool function(GPermission* permission, GCancellable* cancellable, GError** _err);

  @property ReleaseFuncType release()
  {
    return (cast(GPermissionClass*)cPtr).release;
  }

  alias ReleaseAsyncFuncType = extern(C) void function(GPermission* permission, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property ReleaseAsyncFuncType releaseAsync()
  {
    return (cast(GPermissionClass*)cPtr).releaseAsync;
  }

  alias ReleaseFinishFuncType = extern(C) bool function(GPermission* permission, GAsyncResult* result, GError** _err);

  @property ReleaseFinishFuncType releaseFinish()
  {
    return (cast(GPermissionClass*)cPtr).releaseFinish;
  }
}
