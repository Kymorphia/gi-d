module Gio.VolumeMonitorClass;

import GLib.List;
import GLib.Types;
import GLib.c.functions;
import GObject.ObjectClass;
import GObject.Types;
import Gid.Gid;
import Gio.Drive;
import Gio.Mount;
import Gio.Types;
import Gio.Volume;
import Gio.VolumeMonitor;
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
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GVolumeMonitorClass))
  {
    return cast(T*)&cInstance;
  }

  @property ObjectClass parentClass()
  {
    return new ObjectClass(cast(GObjectClass*)&cPtr!GVolumeMonitorClass.parentClass);
  }

  alias VolumeAddedFuncType = extern(C) void function(GVolumeMonitor* volumeMonitor, GVolume* volume);

  @property VolumeAddedFuncType volumeAdded()
  {
    return cPtr!GVolumeMonitorClass.volumeAdded;
  }

  alias VolumeRemovedFuncType = extern(C) void function(GVolumeMonitor* volumeMonitor, GVolume* volume);

  @property VolumeRemovedFuncType volumeRemoved()
  {
    return cPtr!GVolumeMonitorClass.volumeRemoved;
  }

  alias VolumeChangedFuncType = extern(C) void function(GVolumeMonitor* volumeMonitor, GVolume* volume);

  @property VolumeChangedFuncType volumeChanged()
  {
    return cPtr!GVolumeMonitorClass.volumeChanged;
  }

  alias MountAddedFuncType = extern(C) void function(GVolumeMonitor* volumeMonitor, GMount* mount);

  @property MountAddedFuncType mountAdded()
  {
    return cPtr!GVolumeMonitorClass.mountAdded;
  }

  alias MountRemovedFuncType = extern(C) void function(GVolumeMonitor* volumeMonitor, GMount* mount);

  @property MountRemovedFuncType mountRemoved()
  {
    return cPtr!GVolumeMonitorClass.mountRemoved;
  }

  alias MountPreUnmountFuncType = extern(C) void function(GVolumeMonitor* volumeMonitor, GMount* mount);

  @property MountPreUnmountFuncType mountPreUnmount()
  {
    return cPtr!GVolumeMonitorClass.mountPreUnmount;
  }

  alias MountChangedFuncType = extern(C) void function(GVolumeMonitor* volumeMonitor, GMount* mount);

  @property MountChangedFuncType mountChanged()
  {
    return cPtr!GVolumeMonitorClass.mountChanged;
  }

  alias DriveConnectedFuncType = extern(C) void function(GVolumeMonitor* volumeMonitor, GDrive* drive);

  @property DriveConnectedFuncType driveConnected()
  {
    return cPtr!GVolumeMonitorClass.driveConnected;
  }

  alias DriveDisconnectedFuncType = extern(C) void function(GVolumeMonitor* volumeMonitor, GDrive* drive);

  @property DriveDisconnectedFuncType driveDisconnected()
  {
    return cPtr!GVolumeMonitorClass.driveDisconnected;
  }

  alias DriveChangedFuncType = extern(C) void function(GVolumeMonitor* volumeMonitor, GDrive* drive);

  @property DriveChangedFuncType driveChanged()
  {
    return cPtr!GVolumeMonitorClass.driveChanged;
  }

  alias IsSupportedFuncType = extern(C) bool function();

  @property IsSupportedFuncType isSupported()
  {
    return cPtr!GVolumeMonitorClass.isSupported;
  }

  alias GetConnectedDrivesFuncType = extern(C) GList* function(GVolumeMonitor* volumeMonitor);

  @property GetConnectedDrivesFuncType getConnectedDrives()
  {
    return cPtr!GVolumeMonitorClass.getConnectedDrives;
  }

  alias GetVolumesFuncType = extern(C) GList* function(GVolumeMonitor* volumeMonitor);

  @property GetVolumesFuncType getVolumes()
  {
    return cPtr!GVolumeMonitorClass.getVolumes;
  }

  alias GetMountsFuncType = extern(C) GList* function(GVolumeMonitor* volumeMonitor);

  @property GetMountsFuncType getMounts()
  {
    return cPtr!GVolumeMonitorClass.getMounts;
  }

  alias GetVolumeForUuidFuncType = extern(C) GVolume* function(GVolumeMonitor* volumeMonitor, const(char)* uuid);

  @property GetVolumeForUuidFuncType getVolumeForUuid()
  {
    return cPtr!GVolumeMonitorClass.getVolumeForUuid;
  }

  alias GetMountForUuidFuncType = extern(C) GMount* function(GVolumeMonitor* volumeMonitor, const(char)* uuid);

  @property GetMountForUuidFuncType getMountForUuid()
  {
    return cPtr!GVolumeMonitorClass.getMountForUuid;
  }

  alias DriveEjectButtonFuncType = extern(C) void function(GVolumeMonitor* volumeMonitor, GDrive* drive);

  @property DriveEjectButtonFuncType driveEjectButton()
  {
    return cPtr!GVolumeMonitorClass.driveEjectButton;
  }

  alias DriveStopButtonFuncType = extern(C) void function(GVolumeMonitor* volumeMonitor, GDrive* drive);

  @property DriveStopButtonFuncType driveStopButton()
  {
    return cPtr!GVolumeMonitorClass.driveStopButton;
  }
}
