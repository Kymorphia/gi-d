module Gio.VolumeMonitorClass;

import GObject.ObjectClass;
import Gid.gid;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

class VolumeMonitorClass
{
  GVolumeMonitorClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.VolumeMonitorClass");

    cInstance = *cast(GVolumeMonitorClass*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property ObjectClass parentClass()
  {
    return new ObjectClass(cast(GObjectClass*)&(cast(GVolumeMonitorClass*)cPtr).parentClass);
  }

  alias VolumeAddedFuncType = extern(C) void function(GVolumeMonitor* volumeMonitor, GVolume* volume);

  @property VolumeAddedFuncType volumeAdded()
  {
    return (cast(GVolumeMonitorClass*)cPtr).volumeAdded;
  }

  alias VolumeRemovedFuncType = extern(C) void function(GVolumeMonitor* volumeMonitor, GVolume* volume);

  @property VolumeRemovedFuncType volumeRemoved()
  {
    return (cast(GVolumeMonitorClass*)cPtr).volumeRemoved;
  }

  alias VolumeChangedFuncType = extern(C) void function(GVolumeMonitor* volumeMonitor, GVolume* volume);

  @property VolumeChangedFuncType volumeChanged()
  {
    return (cast(GVolumeMonitorClass*)cPtr).volumeChanged;
  }

  alias MountAddedFuncType = extern(C) void function(GVolumeMonitor* volumeMonitor, GMount* mount);

  @property MountAddedFuncType mountAdded()
  {
    return (cast(GVolumeMonitorClass*)cPtr).mountAdded;
  }

  alias MountRemovedFuncType = extern(C) void function(GVolumeMonitor* volumeMonitor, GMount* mount);

  @property MountRemovedFuncType mountRemoved()
  {
    return (cast(GVolumeMonitorClass*)cPtr).mountRemoved;
  }

  alias MountPreUnmountFuncType = extern(C) void function(GVolumeMonitor* volumeMonitor, GMount* mount);

  @property MountPreUnmountFuncType mountPreUnmount()
  {
    return (cast(GVolumeMonitorClass*)cPtr).mountPreUnmount;
  }

  alias MountChangedFuncType = extern(C) void function(GVolumeMonitor* volumeMonitor, GMount* mount);

  @property MountChangedFuncType mountChanged()
  {
    return (cast(GVolumeMonitorClass*)cPtr).mountChanged;
  }

  alias DriveConnectedFuncType = extern(C) void function(GVolumeMonitor* volumeMonitor, GDrive* drive);

  @property DriveConnectedFuncType driveConnected()
  {
    return (cast(GVolumeMonitorClass*)cPtr).driveConnected;
  }

  alias DriveDisconnectedFuncType = extern(C) void function(GVolumeMonitor* volumeMonitor, GDrive* drive);

  @property DriveDisconnectedFuncType driveDisconnected()
  {
    return (cast(GVolumeMonitorClass*)cPtr).driveDisconnected;
  }

  alias DriveChangedFuncType = extern(C) void function(GVolumeMonitor* volumeMonitor, GDrive* drive);

  @property DriveChangedFuncType driveChanged()
  {
    return (cast(GVolumeMonitorClass*)cPtr).driveChanged;
  }

  alias IsSupportedFuncType = extern(C) bool function();

  @property IsSupportedFuncType isSupported()
  {
    return (cast(GVolumeMonitorClass*)cPtr).isSupported;
  }

  alias GetConnectedDrivesFuncType = extern(C) GList* function(GVolumeMonitor* volumeMonitor);

  @property GetConnectedDrivesFuncType getConnectedDrives()
  {
    return (cast(GVolumeMonitorClass*)cPtr).getConnectedDrives;
  }

  alias GetVolumesFuncType = extern(C) GList* function(GVolumeMonitor* volumeMonitor);

  @property GetVolumesFuncType getVolumes()
  {
    return (cast(GVolumeMonitorClass*)cPtr).getVolumes;
  }

  alias GetMountsFuncType = extern(C) GList* function(GVolumeMonitor* volumeMonitor);

  @property GetMountsFuncType getMounts()
  {
    return (cast(GVolumeMonitorClass*)cPtr).getMounts;
  }

  alias GetVolumeForUuidFuncType = extern(C) GVolume* function(GVolumeMonitor* volumeMonitor, const(char)* uuid);

  @property GetVolumeForUuidFuncType getVolumeForUuid()
  {
    return (cast(GVolumeMonitorClass*)cPtr).getVolumeForUuid;
  }

  alias GetMountForUuidFuncType = extern(C) GMount* function(GVolumeMonitor* volumeMonitor, const(char)* uuid);

  @property GetMountForUuidFuncType getMountForUuid()
  {
    return (cast(GVolumeMonitorClass*)cPtr).getMountForUuid;
  }

  alias DriveEjectButtonFuncType = extern(C) void function(GVolumeMonitor* volumeMonitor, GDrive* drive);

  @property DriveEjectButtonFuncType driveEjectButton()
  {
    return (cast(GVolumeMonitorClass*)cPtr).driveEjectButton;
  }

  alias DriveStopButtonFuncType = extern(C) void function(GVolumeMonitor* volumeMonitor, GDrive* drive);

  @property DriveStopButtonFuncType driveStopButton()
  {
    return (cast(GVolumeMonitorClass*)cPtr).driveStopButton;
  }
}
