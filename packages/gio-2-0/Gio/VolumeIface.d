module Gio.VolumeIface;

import GObject.TypeInterface;
import Gid.gid;
import Gio.Types;
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
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property TypeInterface gIface()
  {
    return new TypeInterface(cast(GTypeInterface*)&(cast(GVolumeIface*)cPtr).gIface);
  }

  alias ChangedFuncType = extern(C) void function(GVolume* volume);

  @property ChangedFuncType changed()
  {
    return (cast(GVolumeIface*)cPtr).changed;
  }

  alias RemovedFuncType = extern(C) void function(GVolume* volume);

  @property RemovedFuncType removed()
  {
    return (cast(GVolumeIface*)cPtr).removed;
  }

  alias GetNameFuncType = extern(C) char* function(GVolume* volume);

  @property GetNameFuncType getName()
  {
    return (cast(GVolumeIface*)cPtr).getName;
  }

  alias GetIconFuncType = extern(C) GIcon* function(GVolume* volume);

  @property GetIconFuncType getIcon()
  {
    return (cast(GVolumeIface*)cPtr).getIcon;
  }

  alias GetUuidFuncType = extern(C) char* function(GVolume* volume);

  @property GetUuidFuncType getUuid()
  {
    return (cast(GVolumeIface*)cPtr).getUuid;
  }

  alias GetDriveFuncType = extern(C) GDrive* function(GVolume* volume);

  @property GetDriveFuncType getDrive()
  {
    return (cast(GVolumeIface*)cPtr).getDrive;
  }

  alias GetMountFuncType = extern(C) GMount* function(GVolume* volume);

  @property GetMountFuncType getMount()
  {
    return (cast(GVolumeIface*)cPtr).getMount;
  }

  alias CanMountFuncType = extern(C) bool function(GVolume* volume);

  @property CanMountFuncType canMount()
  {
    return (cast(GVolumeIface*)cPtr).canMount;
  }

  alias CanEjectFuncType = extern(C) bool function(GVolume* volume);

  @property CanEjectFuncType canEject()
  {
    return (cast(GVolumeIface*)cPtr).canEject;
  }

  alias MountFnFuncType = extern(C) void function(GVolume* volume, GMountMountFlags flags, GMountOperation* mountOperation, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property MountFnFuncType mountFn()
  {
    return (cast(GVolumeIface*)cPtr).mountFn;
  }

  alias MountFinishFuncType = extern(C) bool function(GVolume* volume, GAsyncResult* result, GError** _err);

  @property MountFinishFuncType mountFinish()
  {
    return (cast(GVolumeIface*)cPtr).mountFinish;
  }

  alias EjectFuncType = extern(C) void function(GVolume* volume, GMountUnmountFlags flags, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property EjectFuncType eject()
  {
    return (cast(GVolumeIface*)cPtr).eject;
  }

  alias EjectFinishFuncType = extern(C) bool function(GVolume* volume, GAsyncResult* result, GError** _err);

  @property EjectFinishFuncType ejectFinish()
  {
    return (cast(GVolumeIface*)cPtr).ejectFinish;
  }

  alias GetIdentifierFuncType = extern(C) char* function(GVolume* volume, const(char)* kind);

  @property GetIdentifierFuncType getIdentifier()
  {
    return (cast(GVolumeIface*)cPtr).getIdentifier;
  }

  alias EnumerateIdentifiersFuncType = extern(C) char** function(GVolume* volume);

  @property EnumerateIdentifiersFuncType enumerateIdentifiers()
  {
    return (cast(GVolumeIface*)cPtr).enumerateIdentifiers;
  }

  alias ShouldAutomountFuncType = extern(C) bool function(GVolume* volume);

  @property ShouldAutomountFuncType shouldAutomount()
  {
    return (cast(GVolumeIface*)cPtr).shouldAutomount;
  }

  alias GetActivationRootFuncType = extern(C) GFile* function(GVolume* volume);

  @property GetActivationRootFuncType getActivationRoot()
  {
    return (cast(GVolumeIface*)cPtr).getActivationRoot;
  }

  alias EjectWithOperationFuncType = extern(C) void function(GVolume* volume, GMountUnmountFlags flags, GMountOperation* mountOperation, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property EjectWithOperationFuncType ejectWithOperation()
  {
    return (cast(GVolumeIface*)cPtr).ejectWithOperation;
  }

  alias EjectWithOperationFinishFuncType = extern(C) bool function(GVolume* volume, GAsyncResult* result, GError** _err);

  @property EjectWithOperationFinishFuncType ejectWithOperationFinish()
  {
    return (cast(GVolumeIface*)cPtr).ejectWithOperationFinish;
  }

  alias GetSortKeyFuncType = extern(C) const(char)* function(GVolume* volume);

  @property GetSortKeyFuncType getSortKey()
  {
    return (cast(GVolumeIface*)cPtr).getSortKey;
  }

  alias GetSymbolicIconFuncType = extern(C) GIcon* function(GVolume* volume);

  @property GetSymbolicIconFuncType getSymbolicIcon()
  {
    return (cast(GVolumeIface*)cPtr).getSymbolicIcon;
  }
}
