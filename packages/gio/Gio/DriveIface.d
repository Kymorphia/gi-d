module Gio.DriveIface;

import GLib.List;
import GLib.Types;
import GLib.c.functions;
import GObject.TypeInterface;
import GObject.Types;
import Gid.Gid;
import Gio.AsyncResult;
import Gio.Cancellable;
import Gio.Drive;
import Gio.Icon;
import Gio.MountOperation;
import Gio.Types;
import Gio.Volume;
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
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GDriveIface))
  {
    return cast(T*)&cInstance;
  }

  @property TypeInterface gIface()
  {
    return new TypeInterface(cast(GTypeInterface*)&cPtr!GDriveIface.gIface);
  }

  alias ChangedFuncType = extern(C) void function(GDrive* drive);

  @property ChangedFuncType changed()
  {
    return cPtr!GDriveIface.changed;
  }

  alias DisconnectedFuncType = extern(C) void function(GDrive* drive);

  @property DisconnectedFuncType disconnected()
  {
    return cPtr!GDriveIface.disconnected;
  }

  alias EjectButtonFuncType = extern(C) void function(GDrive* drive);

  @property EjectButtonFuncType ejectButton()
  {
    return cPtr!GDriveIface.ejectButton;
  }

  alias GetNameFuncType = extern(C) char* function(GDrive* drive);

  @property GetNameFuncType getName()
  {
    return cPtr!GDriveIface.getName;
  }

  alias GetIconFuncType = extern(C) GIcon* function(GDrive* drive);

  @property GetIconFuncType getIcon()
  {
    return cPtr!GDriveIface.getIcon;
  }

  alias HasVolumesFuncType = extern(C) bool function(GDrive* drive);

  @property HasVolumesFuncType hasVolumes()
  {
    return cPtr!GDriveIface.hasVolumes;
  }

  alias GetVolumesFuncType = extern(C) GList* function(GDrive* drive);

  @property GetVolumesFuncType getVolumes()
  {
    return cPtr!GDriveIface.getVolumes;
  }

  alias IsMediaRemovableFuncType = extern(C) bool function(GDrive* drive);

  @property IsMediaRemovableFuncType isMediaRemovable()
  {
    return cPtr!GDriveIface.isMediaRemovable;
  }

  alias HasMediaFuncType = extern(C) bool function(GDrive* drive);

  @property HasMediaFuncType hasMedia()
  {
    return cPtr!GDriveIface.hasMedia;
  }

  alias IsMediaCheckAutomaticFuncType = extern(C) bool function(GDrive* drive);

  @property IsMediaCheckAutomaticFuncType isMediaCheckAutomatic()
  {
    return cPtr!GDriveIface.isMediaCheckAutomatic;
  }

  alias CanEjectFuncType = extern(C) bool function(GDrive* drive);

  @property CanEjectFuncType canEject()
  {
    return cPtr!GDriveIface.canEject;
  }

  alias CanPollForMediaFuncType = extern(C) bool function(GDrive* drive);

  @property CanPollForMediaFuncType canPollForMedia()
  {
    return cPtr!GDriveIface.canPollForMedia;
  }

  alias EjectFuncType = extern(C) void function(GDrive* drive, GMountUnmountFlags flags, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property EjectFuncType eject()
  {
    return cPtr!GDriveIface.eject;
  }

  alias EjectFinishFuncType = extern(C) bool function(GDrive* drive, GAsyncResult* result, GError** _err);

  @property EjectFinishFuncType ejectFinish()
  {
    return cPtr!GDriveIface.ejectFinish;
  }

  alias PollForMediaFuncType = extern(C) void function(GDrive* drive, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property PollForMediaFuncType pollForMedia()
  {
    return cPtr!GDriveIface.pollForMedia;
  }

  alias PollForMediaFinishFuncType = extern(C) bool function(GDrive* drive, GAsyncResult* result, GError** _err);

  @property PollForMediaFinishFuncType pollForMediaFinish()
  {
    return cPtr!GDriveIface.pollForMediaFinish;
  }

  alias GetIdentifierFuncType = extern(C) char* function(GDrive* drive, const(char)* kind);

  @property GetIdentifierFuncType getIdentifier()
  {
    return cPtr!GDriveIface.getIdentifier;
  }

  alias EnumerateIdentifiersFuncType = extern(C) char** function(GDrive* drive);

  @property EnumerateIdentifiersFuncType enumerateIdentifiers()
  {
    return cPtr!GDriveIface.enumerateIdentifiers;
  }

  alias GetStartStopTypeFuncType = extern(C) GDriveStartStopType function(GDrive* drive);

  @property GetStartStopTypeFuncType getStartStopType()
  {
    return cPtr!GDriveIface.getStartStopType;
  }

  alias CanStartFuncType = extern(C) bool function(GDrive* drive);

  @property CanStartFuncType canStart()
  {
    return cPtr!GDriveIface.canStart;
  }

  alias CanStartDegradedFuncType = extern(C) bool function(GDrive* drive);

  @property CanStartDegradedFuncType canStartDegraded()
  {
    return cPtr!GDriveIface.canStartDegraded;
  }

  alias StartFuncType = extern(C) void function(GDrive* drive, GDriveStartFlags flags, GMountOperation* mountOperation, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property StartFuncType start()
  {
    return cPtr!GDriveIface.start;
  }

  alias StartFinishFuncType = extern(C) bool function(GDrive* drive, GAsyncResult* result, GError** _err);

  @property StartFinishFuncType startFinish()
  {
    return cPtr!GDriveIface.startFinish;
  }

  alias CanStopFuncType = extern(C) bool function(GDrive* drive);

  @property CanStopFuncType canStop()
  {
    return cPtr!GDriveIface.canStop;
  }

  alias StopFuncType = extern(C) void function(GDrive* drive, GMountUnmountFlags flags, GMountOperation* mountOperation, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property StopFuncType stop()
  {
    return cPtr!GDriveIface.stop;
  }

  alias StopFinishFuncType = extern(C) bool function(GDrive* drive, GAsyncResult* result, GError** _err);

  @property StopFinishFuncType stopFinish()
  {
    return cPtr!GDriveIface.stopFinish;
  }

  alias StopButtonFuncType = extern(C) void function(GDrive* drive);

  @property StopButtonFuncType stopButton()
  {
    return cPtr!GDriveIface.stopButton;
  }

  alias EjectWithOperationFuncType = extern(C) void function(GDrive* drive, GMountUnmountFlags flags, GMountOperation* mountOperation, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property EjectWithOperationFuncType ejectWithOperation()
  {
    return cPtr!GDriveIface.ejectWithOperation;
  }

  alias EjectWithOperationFinishFuncType = extern(C) bool function(GDrive* drive, GAsyncResult* result, GError** _err);

  @property EjectWithOperationFinishFuncType ejectWithOperationFinish()
  {
    return cPtr!GDriveIface.ejectWithOperationFinish;
  }

  alias GetSortKeyFuncType = extern(C) const(char)* function(GDrive* drive);

  @property GetSortKeyFuncType getSortKey()
  {
    return cPtr!GDriveIface.getSortKey;
  }

  alias GetSymbolicIconFuncType = extern(C) GIcon* function(GDrive* drive);

  @property GetSymbolicIconFuncType getSymbolicIcon()
  {
    return cPtr!GDriveIface.getSymbolicIcon;
  }

  alias IsRemovableFuncType = extern(C) bool function(GDrive* drive);

  @property IsRemovableFuncType isRemovable()
  {
    return cPtr!GDriveIface.isRemovable;
  }
}
