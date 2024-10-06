module Gio.MountIface;

import GObject.TypeInterface;
import Gid.gid;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * Interface for implementing operations for mounts.
 */
class MountIface
{
  GMountIface cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.MountIface");

    cInstance = *cast(GMountIface*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property TypeInterface gIface()
  {
    return new TypeInterface(cast(GTypeInterface*)&(cast(GMountIface*)cPtr).gIface);
  }

  alias ChangedFuncType = extern(C) void function(GMount* mount);

  @property ChangedFuncType changed()
  {
    return (cast(GMountIface*)cPtr).changed;
  }

  alias UnmountedFuncType = extern(C) void function(GMount* mount);

  @property UnmountedFuncType unmounted()
  {
    return (cast(GMountIface*)cPtr).unmounted;
  }

  alias GetRootFuncType = extern(C) GFile* function(GMount* mount);

  @property GetRootFuncType getRoot()
  {
    return (cast(GMountIface*)cPtr).getRoot;
  }

  alias GetNameFuncType = extern(C) char* function(GMount* mount);

  @property GetNameFuncType getName()
  {
    return (cast(GMountIface*)cPtr).getName;
  }

  alias GetIconFuncType = extern(C) GIcon* function(GMount* mount);

  @property GetIconFuncType getIcon()
  {
    return (cast(GMountIface*)cPtr).getIcon;
  }

  alias GetUuidFuncType = extern(C) char* function(GMount* mount);

  @property GetUuidFuncType getUuid()
  {
    return (cast(GMountIface*)cPtr).getUuid;
  }

  alias GetVolumeFuncType = extern(C) GVolume* function(GMount* mount);

  @property GetVolumeFuncType getVolume()
  {
    return (cast(GMountIface*)cPtr).getVolume;
  }

  alias GetDriveFuncType = extern(C) GDrive* function(GMount* mount);

  @property GetDriveFuncType getDrive()
  {
    return (cast(GMountIface*)cPtr).getDrive;
  }

  alias CanUnmountFuncType = extern(C) bool function(GMount* mount);

  @property CanUnmountFuncType canUnmount()
  {
    return (cast(GMountIface*)cPtr).canUnmount;
  }

  alias CanEjectFuncType = extern(C) bool function(GMount* mount);

  @property CanEjectFuncType canEject()
  {
    return (cast(GMountIface*)cPtr).canEject;
  }

  alias UnmountFuncType = extern(C) void function(GMount* mount, GMountUnmountFlags flags, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property UnmountFuncType unmount()
  {
    return (cast(GMountIface*)cPtr).unmount;
  }

  alias UnmountFinishFuncType = extern(C) bool function(GMount* mount, GAsyncResult* result, GError** _err);

  @property UnmountFinishFuncType unmountFinish()
  {
    return (cast(GMountIface*)cPtr).unmountFinish;
  }

  alias EjectFuncType = extern(C) void function(GMount* mount, GMountUnmountFlags flags, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property EjectFuncType eject()
  {
    return (cast(GMountIface*)cPtr).eject;
  }

  alias EjectFinishFuncType = extern(C) bool function(GMount* mount, GAsyncResult* result, GError** _err);

  @property EjectFinishFuncType ejectFinish()
  {
    return (cast(GMountIface*)cPtr).ejectFinish;
  }

  alias RemountFuncType = extern(C) void function(GMount* mount, GMountMountFlags flags, GMountOperation* mountOperation, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property RemountFuncType remount()
  {
    return (cast(GMountIface*)cPtr).remount;
  }

  alias RemountFinishFuncType = extern(C) bool function(GMount* mount, GAsyncResult* result, GError** _err);

  @property RemountFinishFuncType remountFinish()
  {
    return (cast(GMountIface*)cPtr).remountFinish;
  }

  alias GuessContentTypeFuncType = extern(C) void function(GMount* mount, bool forceRescan, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property GuessContentTypeFuncType guessContentType()
  {
    return (cast(GMountIface*)cPtr).guessContentType;
  }

  alias GuessContentTypeFinishFuncType = extern(C) char** function(GMount* mount, GAsyncResult* result, GError** _err);

  @property GuessContentTypeFinishFuncType guessContentTypeFinish()
  {
    return (cast(GMountIface*)cPtr).guessContentTypeFinish;
  }

  alias GuessContentTypeSyncFuncType = extern(C) char** function(GMount* mount, bool forceRescan, GCancellable* cancellable, GError** _err);

  @property GuessContentTypeSyncFuncType guessContentTypeSync()
  {
    return (cast(GMountIface*)cPtr).guessContentTypeSync;
  }

  alias PreUnmountFuncType = extern(C) void function(GMount* mount);

  @property PreUnmountFuncType preUnmount()
  {
    return (cast(GMountIface*)cPtr).preUnmount;
  }

  alias UnmountWithOperationFuncType = extern(C) void function(GMount* mount, GMountUnmountFlags flags, GMountOperation* mountOperation, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property UnmountWithOperationFuncType unmountWithOperation()
  {
    return (cast(GMountIface*)cPtr).unmountWithOperation;
  }

  alias UnmountWithOperationFinishFuncType = extern(C) bool function(GMount* mount, GAsyncResult* result, GError** _err);

  @property UnmountWithOperationFinishFuncType unmountWithOperationFinish()
  {
    return (cast(GMountIface*)cPtr).unmountWithOperationFinish;
  }

  alias EjectWithOperationFuncType = extern(C) void function(GMount* mount, GMountUnmountFlags flags, GMountOperation* mountOperation, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property EjectWithOperationFuncType ejectWithOperation()
  {
    return (cast(GMountIface*)cPtr).ejectWithOperation;
  }

  alias EjectWithOperationFinishFuncType = extern(C) bool function(GMount* mount, GAsyncResult* result, GError** _err);

  @property EjectWithOperationFinishFuncType ejectWithOperationFinish()
  {
    return (cast(GMountIface*)cPtr).ejectWithOperationFinish;
  }

  alias GetDefaultLocationFuncType = extern(C) GFile* function(GMount* mount);

  @property GetDefaultLocationFuncType getDefaultLocation()
  {
    return (cast(GMountIface*)cPtr).getDefaultLocation;
  }

  alias GetSortKeyFuncType = extern(C) const(char)* function(GMount* mount);

  @property GetSortKeyFuncType getSortKey()
  {
    return (cast(GMountIface*)cPtr).getSortKey;
  }

  alias GetSymbolicIconFuncType = extern(C) GIcon* function(GMount* mount);

  @property GetSymbolicIconFuncType getSymbolicIcon()
  {
    return (cast(GMountIface*)cPtr).getSymbolicIcon;
  }
}
