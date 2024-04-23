module Gio.VolumeIface;

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
 * Interface for implementing operations for mountable volumes.
 */
class VolumeIface
{
  GVolumeIface cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.VolumeIface");

    cInstance = *cast(GVolumeIface*)ptr;

    if (ownedRef)
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GVolumeIface))
  {
    return cast(T*)&cInstance;
  }

  @property TypeInterface gIface()
  {
    return new TypeInterface(cast(GTypeInterface*)&cPtr!GVolumeIface.gIface);
  }

  alias ChangedFuncType = extern(C) void function(GVolume* volume);

  @property ChangedFuncType changed()
  {
    return cPtr!GVolumeIface.changed;
  }

  alias RemovedFuncType = extern(C) void function(GVolume* volume);

  @property RemovedFuncType removed()
  {
    return cPtr!GVolumeIface.removed;
  }

  alias GetNameFuncType = extern(C) char* function(GVolume* volume);

  @property GetNameFuncType getName()
  {
    return cPtr!GVolumeIface.getName;
  }

  alias GetIconFuncType = extern(C) GIcon* function(GVolume* volume);

  @property GetIconFuncType getIcon()
  {
    return cPtr!GVolumeIface.getIcon;
  }

  alias GetUuidFuncType = extern(C) char* function(GVolume* volume);

  @property GetUuidFuncType getUuid()
  {
    return cPtr!GVolumeIface.getUuid;
  }

  alias GetDriveFuncType = extern(C) GDrive* function(GVolume* volume);

  @property GetDriveFuncType getDrive()
  {
    return cPtr!GVolumeIface.getDrive;
  }

  alias GetMountFuncType = extern(C) GMount* function(GVolume* volume);

  @property GetMountFuncType getMount()
  {
    return cPtr!GVolumeIface.getMount;
  }

  alias CanMountFuncType = extern(C) bool function(GVolume* volume);

  @property CanMountFuncType canMount()
  {
    return cPtr!GVolumeIface.canMount;
  }

  alias CanEjectFuncType = extern(C) bool function(GVolume* volume);

  @property CanEjectFuncType canEject()
  {
    return cPtr!GVolumeIface.canEject;
  }

  alias MountFnFuncType = extern(C) void function(GVolume* volume, GMountMountFlags flags, GMountOperation* mountOperation, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property MountFnFuncType mountFn()
  {
    return cPtr!GVolumeIface.mountFn;
  }

  alias MountFinishFuncType = extern(C) bool function(GVolume* volume, GAsyncResult* result, GError** _err);

  @property MountFinishFuncType mountFinish()
  {
    return cPtr!GVolumeIface.mountFinish;
  }

  alias EjectFuncType = extern(C) void function(GVolume* volume, GMountUnmountFlags flags, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property EjectFuncType eject()
  {
    return cPtr!GVolumeIface.eject;
  }

  alias EjectFinishFuncType = extern(C) bool function(GVolume* volume, GAsyncResult* result, GError** _err);

  @property EjectFinishFuncType ejectFinish()
  {
    return cPtr!GVolumeIface.ejectFinish;
  }

  alias GetIdentifierFuncType = extern(C) char* function(GVolume* volume, const(char)* kind);

  @property GetIdentifierFuncType getIdentifier()
  {
    return cPtr!GVolumeIface.getIdentifier;
  }

  alias EnumerateIdentifiersFuncType = extern(C) char** function(GVolume* volume);

  @property EnumerateIdentifiersFuncType enumerateIdentifiers()
  {
    return cPtr!GVolumeIface.enumerateIdentifiers;
  }

  alias ShouldAutomountFuncType = extern(C) bool function(GVolume* volume);

  @property ShouldAutomountFuncType shouldAutomount()
  {
    return cPtr!GVolumeIface.shouldAutomount;
  }

  alias GetActivationRootFuncType = extern(C) GFile* function(GVolume* volume);

  @property GetActivationRootFuncType getActivationRoot()
  {
    return cPtr!GVolumeIface.getActivationRoot;
  }

  alias EjectWithOperationFuncType = extern(C) void function(GVolume* volume, GMountUnmountFlags flags, GMountOperation* mountOperation, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property EjectWithOperationFuncType ejectWithOperation()
  {
    return cPtr!GVolumeIface.ejectWithOperation;
  }

  alias EjectWithOperationFinishFuncType = extern(C) bool function(GVolume* volume, GAsyncResult* result, GError** _err);

  @property EjectWithOperationFinishFuncType ejectWithOperationFinish()
  {
    return cPtr!GVolumeIface.ejectWithOperationFinish;
  }

  alias GetSortKeyFuncType = extern(C) const(char)* function(GVolume* volume);

  @property GetSortKeyFuncType getSortKey()
  {
    return cPtr!GVolumeIface.getSortKey;
  }

  alias GetSymbolicIconFuncType = extern(C) GIcon* function(GVolume* volume);

  @property GetSymbolicIconFuncType getSymbolicIcon()
  {
    return cPtr!GVolumeIface.getSymbolicIcon;
  }
}
