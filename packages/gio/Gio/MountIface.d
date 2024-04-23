module Gio.MountIface;

import GLib.c.functions;
import GObject.TypeInterface;
import GObject.Types;
import Gid.Gid;
import Gio.AsyncResult;
import Gio.Cancellable;
import Gio.Drive;
import Gio.File;
import Gio.Icon;
import Gio.Mount;
import Gio.MountOperation;
import Gio.Types;
import Gio.Volume;
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
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GMountIface))
  {
    return cast(T*)&cInstance;
  }

  @property TypeInterface gIface()
  {
    return new TypeInterface(cast(GTypeInterface*)&cPtr!GMountIface.gIface);
  }

  alias ChangedFuncType = extern(C) void function(GMount* mount);

  @property ChangedFuncType changed()
  {
    return cPtr!GMountIface.changed;
  }

  alias UnmountedFuncType = extern(C) void function(GMount* mount);

  @property UnmountedFuncType unmounted()
  {
    return cPtr!GMountIface.unmounted;
  }

  alias GetRootFuncType = extern(C) GFile* function(GMount* mount);

  @property GetRootFuncType getRoot()
  {
    return cPtr!GMountIface.getRoot;
  }

  alias GetNameFuncType = extern(C) char* function(GMount* mount);

  @property GetNameFuncType getName()
  {
    return cPtr!GMountIface.getName;
  }

  alias GetIconFuncType = extern(C) GIcon* function(GMount* mount);

  @property GetIconFuncType getIcon()
  {
    return cPtr!GMountIface.getIcon;
  }

  alias GetUuidFuncType = extern(C) char* function(GMount* mount);

  @property GetUuidFuncType getUuid()
  {
    return cPtr!GMountIface.getUuid;
  }

  alias GetVolumeFuncType = extern(C) GVolume* function(GMount* mount);

  @property GetVolumeFuncType getVolume()
  {
    return cPtr!GMountIface.getVolume;
  }

  alias GetDriveFuncType = extern(C) GDrive* function(GMount* mount);

  @property GetDriveFuncType getDrive()
  {
    return cPtr!GMountIface.getDrive;
  }

  alias CanUnmountFuncType = extern(C) bool function(GMount* mount);

  @property CanUnmountFuncType canUnmount()
  {
    return cPtr!GMountIface.canUnmount;
  }

  alias CanEjectFuncType = extern(C) bool function(GMount* mount);

  @property CanEjectFuncType canEject()
  {
    return cPtr!GMountIface.canEject;
  }

  alias UnmountFuncType = extern(C) void function(GMount* mount, GMountUnmountFlags flags, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property UnmountFuncType unmount()
  {
    return cPtr!GMountIface.unmount;
  }

  alias UnmountFinishFuncType = extern(C) bool function(GMount* mount, GAsyncResult* result, GError** _err);

  @property UnmountFinishFuncType unmountFinish()
  {
    return cPtr!GMountIface.unmountFinish;
  }

  alias EjectFuncType = extern(C) void function(GMount* mount, GMountUnmountFlags flags, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property EjectFuncType eject()
  {
    return cPtr!GMountIface.eject;
  }

  alias EjectFinishFuncType = extern(C) bool function(GMount* mount, GAsyncResult* result, GError** _err);

  @property EjectFinishFuncType ejectFinish()
  {
    return cPtr!GMountIface.ejectFinish;
  }

  alias RemountFuncType = extern(C) void function(GMount* mount, GMountMountFlags flags, GMountOperation* mountOperation, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property RemountFuncType remount()
  {
    return cPtr!GMountIface.remount;
  }

  alias RemountFinishFuncType = extern(C) bool function(GMount* mount, GAsyncResult* result, GError** _err);

  @property RemountFinishFuncType remountFinish()
  {
    return cPtr!GMountIface.remountFinish;
  }

  alias GuessContentTypeFuncType = extern(C) void function(GMount* mount, bool forceRescan, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property GuessContentTypeFuncType guessContentType()
  {
    return cPtr!GMountIface.guessContentType;
  }

  alias GuessContentTypeFinishFuncType = extern(C) char** function(GMount* mount, GAsyncResult* result, GError** _err);

  @property GuessContentTypeFinishFuncType guessContentTypeFinish()
  {
    return cPtr!GMountIface.guessContentTypeFinish;
  }

  alias GuessContentTypeSyncFuncType = extern(C) char** function(GMount* mount, bool forceRescan, GCancellable* cancellable, GError** _err);

  @property GuessContentTypeSyncFuncType guessContentTypeSync()
  {
    return cPtr!GMountIface.guessContentTypeSync;
  }

  alias PreUnmountFuncType = extern(C) void function(GMount* mount);

  @property PreUnmountFuncType preUnmount()
  {
    return cPtr!GMountIface.preUnmount;
  }

  alias UnmountWithOperationFuncType = extern(C) void function(GMount* mount, GMountUnmountFlags flags, GMountOperation* mountOperation, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property UnmountWithOperationFuncType unmountWithOperation()
  {
    return cPtr!GMountIface.unmountWithOperation;
  }

  alias UnmountWithOperationFinishFuncType = extern(C) bool function(GMount* mount, GAsyncResult* result, GError** _err);

  @property UnmountWithOperationFinishFuncType unmountWithOperationFinish()
  {
    return cPtr!GMountIface.unmountWithOperationFinish;
  }

  alias EjectWithOperationFuncType = extern(C) void function(GMount* mount, GMountUnmountFlags flags, GMountOperation* mountOperation, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property EjectWithOperationFuncType ejectWithOperation()
  {
    return cPtr!GMountIface.ejectWithOperation;
  }

  alias EjectWithOperationFinishFuncType = extern(C) bool function(GMount* mount, GAsyncResult* result, GError** _err);

  @property EjectWithOperationFinishFuncType ejectWithOperationFinish()
  {
    return cPtr!GMountIface.ejectWithOperationFinish;
  }

  alias GetDefaultLocationFuncType = extern(C) GFile* function(GMount* mount);

  @property GetDefaultLocationFuncType getDefaultLocation()
  {
    return cPtr!GMountIface.getDefaultLocation;
  }

  alias GetSortKeyFuncType = extern(C) const(char)* function(GMount* mount);

  @property GetSortKeyFuncType getSortKey()
  {
    return cPtr!GMountIface.getSortKey;
  }

  alias GetSymbolicIconFuncType = extern(C) GIcon* function(GMount* mount);

  @property GetSymbolicIconFuncType getSymbolicIcon()
  {
    return cPtr!GMountIface.getSymbolicIcon;
  }
}
