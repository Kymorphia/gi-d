module Gio.DriveIface;

import GObject.TypeInterface;
import Gid.gid;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * Interface for creating #GDrive implementations.
 */
class DriveIface
{
  GDriveIface cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.DriveIface");

    cInstance = *cast(GDriveIface*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property TypeInterface gIface()
  {
    return new TypeInterface(cast(GTypeInterface*)&(cast(GDriveIface*)cPtr).gIface);
  }

  alias ChangedFuncType = extern(C) void function(GDrive* drive);

  @property ChangedFuncType changed()
  {
    return (cast(GDriveIface*)cPtr).changed;
  }

  alias DisconnectedFuncType = extern(C) void function(GDrive* drive);

  @property DisconnectedFuncType disconnected()
  {
    return (cast(GDriveIface*)cPtr).disconnected;
  }

  alias EjectButtonFuncType = extern(C) void function(GDrive* drive);

  @property EjectButtonFuncType ejectButton()
  {
    return (cast(GDriveIface*)cPtr).ejectButton;
  }

  alias GetNameFuncType = extern(C) char* function(GDrive* drive);

  @property GetNameFuncType getName()
  {
    return (cast(GDriveIface*)cPtr).getName;
  }

  alias GetIconFuncType = extern(C) GIcon* function(GDrive* drive);

  @property GetIconFuncType getIcon()
  {
    return (cast(GDriveIface*)cPtr).getIcon;
  }

  alias HasVolumesFuncType = extern(C) bool function(GDrive* drive);

  @property HasVolumesFuncType hasVolumes()
  {
    return (cast(GDriveIface*)cPtr).hasVolumes;
  }

  alias GetVolumesFuncType = extern(C) GList* function(GDrive* drive);

  @property GetVolumesFuncType getVolumes()
  {
    return (cast(GDriveIface*)cPtr).getVolumes;
  }

  alias IsMediaRemovableFuncType = extern(C) bool function(GDrive* drive);

  @property IsMediaRemovableFuncType isMediaRemovable()
  {
    return (cast(GDriveIface*)cPtr).isMediaRemovable;
  }

  alias HasMediaFuncType = extern(C) bool function(GDrive* drive);

  @property HasMediaFuncType hasMedia()
  {
    return (cast(GDriveIface*)cPtr).hasMedia;
  }

  alias IsMediaCheckAutomaticFuncType = extern(C) bool function(GDrive* drive);

  @property IsMediaCheckAutomaticFuncType isMediaCheckAutomatic()
  {
    return (cast(GDriveIface*)cPtr).isMediaCheckAutomatic;
  }

  alias CanEjectFuncType = extern(C) bool function(GDrive* drive);

  @property CanEjectFuncType canEject()
  {
    return (cast(GDriveIface*)cPtr).canEject;
  }

  alias CanPollForMediaFuncType = extern(C) bool function(GDrive* drive);

  @property CanPollForMediaFuncType canPollForMedia()
  {
    return (cast(GDriveIface*)cPtr).canPollForMedia;
  }

  alias EjectFuncType = extern(C) void function(GDrive* drive, GMountUnmountFlags flags, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property EjectFuncType eject()
  {
    return (cast(GDriveIface*)cPtr).eject;
  }

  alias EjectFinishFuncType = extern(C) bool function(GDrive* drive, GAsyncResult* result, GError** _err);

  @property EjectFinishFuncType ejectFinish()
  {
    return (cast(GDriveIface*)cPtr).ejectFinish;
  }

  alias PollForMediaFuncType = extern(C) void function(GDrive* drive, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property PollForMediaFuncType pollForMedia()
  {
    return (cast(GDriveIface*)cPtr).pollForMedia;
  }

  alias PollForMediaFinishFuncType = extern(C) bool function(GDrive* drive, GAsyncResult* result, GError** _err);

  @property PollForMediaFinishFuncType pollForMediaFinish()
  {
    return (cast(GDriveIface*)cPtr).pollForMediaFinish;
  }

  alias GetIdentifierFuncType = extern(C) char* function(GDrive* drive, const(char)* kind);

  @property GetIdentifierFuncType getIdentifier()
  {
    return (cast(GDriveIface*)cPtr).getIdentifier;
  }

  alias EnumerateIdentifiersFuncType = extern(C) char** function(GDrive* drive);

  @property EnumerateIdentifiersFuncType enumerateIdentifiers()
  {
    return (cast(GDriveIface*)cPtr).enumerateIdentifiers;
  }

  alias GetStartStopTypeFuncType = extern(C) GDriveStartStopType function(GDrive* drive);

  @property GetStartStopTypeFuncType getStartStopType()
  {
    return (cast(GDriveIface*)cPtr).getStartStopType;
  }

  alias CanStartFuncType = extern(C) bool function(GDrive* drive);

  @property CanStartFuncType canStart()
  {
    return (cast(GDriveIface*)cPtr).canStart;
  }

  alias CanStartDegradedFuncType = extern(C) bool function(GDrive* drive);

  @property CanStartDegradedFuncType canStartDegraded()
  {
    return (cast(GDriveIface*)cPtr).canStartDegraded;
  }

  alias StartFuncType = extern(C) void function(GDrive* drive, GDriveStartFlags flags, GMountOperation* mountOperation, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property StartFuncType start()
  {
    return (cast(GDriveIface*)cPtr).start;
  }

  alias StartFinishFuncType = extern(C) bool function(GDrive* drive, GAsyncResult* result, GError** _err);

  @property StartFinishFuncType startFinish()
  {
    return (cast(GDriveIface*)cPtr).startFinish;
  }

  alias CanStopFuncType = extern(C) bool function(GDrive* drive);

  @property CanStopFuncType canStop()
  {
    return (cast(GDriveIface*)cPtr).canStop;
  }

  alias StopFuncType = extern(C) void function(GDrive* drive, GMountUnmountFlags flags, GMountOperation* mountOperation, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property StopFuncType stop()
  {
    return (cast(GDriveIface*)cPtr).stop;
  }

  alias StopFinishFuncType = extern(C) bool function(GDrive* drive, GAsyncResult* result, GError** _err);

  @property StopFinishFuncType stopFinish()
  {
    return (cast(GDriveIface*)cPtr).stopFinish;
  }

  alias StopButtonFuncType = extern(C) void function(GDrive* drive);

  @property StopButtonFuncType stopButton()
  {
    return (cast(GDriveIface*)cPtr).stopButton;
  }

  alias EjectWithOperationFuncType = extern(C) void function(GDrive* drive, GMountUnmountFlags flags, GMountOperation* mountOperation, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property EjectWithOperationFuncType ejectWithOperation()
  {
    return (cast(GDriveIface*)cPtr).ejectWithOperation;
  }

  alias EjectWithOperationFinishFuncType = extern(C) bool function(GDrive* drive, GAsyncResult* result, GError** _err);

  @property EjectWithOperationFinishFuncType ejectWithOperationFinish()
  {
    return (cast(GDriveIface*)cPtr).ejectWithOperationFinish;
  }

  alias GetSortKeyFuncType = extern(C) const(char)* function(GDrive* drive);

  @property GetSortKeyFuncType getSortKey()
  {
    return (cast(GDriveIface*)cPtr).getSortKey;
  }

  alias GetSymbolicIconFuncType = extern(C) GIcon* function(GDrive* drive);

  @property GetSymbolicIconFuncType getSymbolicIcon()
  {
    return (cast(GDriveIface*)cPtr).getSymbolicIcon;
  }

  alias IsRemovableFuncType = extern(C) bool function(GDrive* drive);

  @property IsRemovableFuncType isRemovable()
  {
    return (cast(GDriveIface*)cPtr).isRemovable;
  }
}
