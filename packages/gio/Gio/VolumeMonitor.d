module Gio.VolumeMonitor;

import GLib.List;
import GLib.Types;
import GObject.DClosure;
import GObject.ObjectG;
import GObject.Types;
import Gid.Gid;
import Gio.Drive;
import Gio.Mount;
import Gio.Types;
import Gio.Volume;
import Gio.c.functions;
import Gio.c.types;

/**
 * #GVolumeMonitor is for listing the user interesting devices and volumes
 * on the computer. In other words, what a file selector or file manager
 * would show in a sidebar.
 *
 * #GVolumeMonitor is not
 * [thread-default-context aware][g-main-context-push-thread-default],
 * and so should not be used other than from the main thread, with no
 * thread-default-context active.
 *
 * In order to receive updates about volumes and mounts monitored through GVFS,
 * a main loop must be running.
 */
class VolumeMonitor : ObjectG
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_volume_monitor_get_type();
  }

  /**
   * the #GVolume object that is the parent for @mount or %NULL
   * if no wants to adopt the #GMount.
   */
  static Volume adoptOrphanMount(Mount mount)
  {
    GVolume* _cretval;
    _cretval = g_volume_monitor_adopt_orphan_mount(mount ? (cast(ObjectG)mount).cPtr!GMount : null);
    Volume _retval = ObjectG.getDObject!Volume(cast(GVolume*)_cretval, true);
    return _retval;
  }

  /**
   * a reference to the #GVolumeMonitor used by gio. Call
   * g_object_unref() when done with it.
   */
  static VolumeMonitor get()
  {
    GVolumeMonitor* _cretval;
    _cretval = g_volume_monitor_get();
    VolumeMonitor _retval = ObjectG.getDObject!VolumeMonitor(cast(GVolumeMonitor*)_cretval, true);
    return _retval;
  }

  /**
   * a #GList of connected #GDrive objects.
   */
  List!(Drive, GDrive*) getConnectedDrives()
  {
    GList* _cretval;
    _cretval = g_volume_monitor_get_connected_drives(cPtr!GVolumeMonitor);
    List!(Drive, GDrive*) _retval = _cretval ? new List!(Drive, GDrive*)(_cretval, GidOwnership.Full) : null;
    return _retval;
  }

  /**
   * a #GMount or %NULL if no such mount is available.
   * Free the returned object with g_object_unref().
   */
  Mount getMountForUuid(string uuid)
  {
    GMount* _cretval;
    const(char)* _uuid = uuid.toCString(false);
    _cretval = g_volume_monitor_get_mount_for_uuid(cPtr!GVolumeMonitor, _uuid);
    Mount _retval = ObjectG.getDObject!Mount(cast(GMount*)_cretval, true);
    return _retval;
  }

  /**
   * a #GList of #GMount objects.
   */
  List!(Mount, GMount*) getMounts()
  {
    GList* _cretval;
    _cretval = g_volume_monitor_get_mounts(cPtr!GVolumeMonitor);
    List!(Mount, GMount*) _retval = _cretval ? new List!(Mount, GMount*)(_cretval, GidOwnership.Full) : null;
    return _retval;
  }

  /**
   * a #GVolume or %NULL if no such volume is available.
   * Free the returned object with g_object_unref().
   */
  Volume getVolumeForUuid(string uuid)
  {
    GVolume* _cretval;
    const(char)* _uuid = uuid.toCString(false);
    _cretval = g_volume_monitor_get_volume_for_uuid(cPtr!GVolumeMonitor, _uuid);
    Volume _retval = ObjectG.getDObject!Volume(cast(GVolume*)_cretval, true);
    return _retval;
  }

  /**
   * a #GList of #GVolume objects.
   */
  List!(Volume, GVolume*) getVolumes()
  {
    GList* _cretval;
    _cretval = g_volume_monitor_get_volumes(cPtr!GVolumeMonitor);
    List!(Volume, GVolume*) _retval = _cretval ? new List!(Volume, GVolume*)(_cretval, GidOwnership.Full) : null;
    return _retval;
  }

  /**
   * Emitted when a drive changes.
   */
  ulong connectDriveChanged(void delegate(Drive drive, VolumeMonitor volumeMonitor) dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto volumeMonitor = getVal!VolumeMonitor(_paramVals);
      auto drive = getVal!Drive(&_paramVals[1]);
      _dgClosure.dlg(drive, volumeMonitor);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("drive-changed", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * Emitted when a drive is connected to the system.
   */
  ulong connectDriveConnected(void delegate(Drive drive, VolumeMonitor volumeMonitor) dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto volumeMonitor = getVal!VolumeMonitor(_paramVals);
      auto drive = getVal!Drive(&_paramVals[1]);
      _dgClosure.dlg(drive, volumeMonitor);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("drive-connected", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * Emitted when a drive is disconnected from the system.
   */
  ulong connectDriveDisconnected(void delegate(Drive drive, VolumeMonitor volumeMonitor) dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto volumeMonitor = getVal!VolumeMonitor(_paramVals);
      auto drive = getVal!Drive(&_paramVals[1]);
      _dgClosure.dlg(drive, volumeMonitor);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("drive-disconnected", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * Emitted when the eject button is pressed on @drive.
   */
  ulong connectDriveEjectButton(void delegate(Drive drive, VolumeMonitor volumeMonitor) dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto volumeMonitor = getVal!VolumeMonitor(_paramVals);
      auto drive = getVal!Drive(&_paramVals[1]);
      _dgClosure.dlg(drive, volumeMonitor);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("drive-eject-button", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * Emitted when the stop button is pressed on @drive.
   */
  ulong connectDriveStopButton(void delegate(Drive drive, VolumeMonitor volumeMonitor) dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto volumeMonitor = getVal!VolumeMonitor(_paramVals);
      auto drive = getVal!Drive(&_paramVals[1]);
      _dgClosure.dlg(drive, volumeMonitor);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("drive-stop-button", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * Emitted when a mount is added.
   */
  ulong connectMountAdded(void delegate(Mount mount, VolumeMonitor volumeMonitor) dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto volumeMonitor = getVal!VolumeMonitor(_paramVals);
      auto mount = getVal!Mount(&_paramVals[1]);
      _dgClosure.dlg(mount, volumeMonitor);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("mount-added", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * Emitted when a mount changes.
   */
  ulong connectMountChanged(void delegate(Mount mount, VolumeMonitor volumeMonitor) dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto volumeMonitor = getVal!VolumeMonitor(_paramVals);
      auto mount = getVal!Mount(&_paramVals[1]);
      _dgClosure.dlg(mount, volumeMonitor);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("mount-changed", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * May be emitted when a mount is about to be removed.
   *
   * This signal depends on the backend and is only emitted if
   * GIO was used to unmount.
   */
  ulong connectMountPreUnmount(void delegate(Mount mount, VolumeMonitor volumeMonitor) dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto volumeMonitor = getVal!VolumeMonitor(_paramVals);
      auto mount = getVal!Mount(&_paramVals[1]);
      _dgClosure.dlg(mount, volumeMonitor);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("mount-pre-unmount", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * Emitted when a mount is removed.
   */
  ulong connectMountRemoved(void delegate(Mount mount, VolumeMonitor volumeMonitor) dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto volumeMonitor = getVal!VolumeMonitor(_paramVals);
      auto mount = getVal!Mount(&_paramVals[1]);
      _dgClosure.dlg(mount, volumeMonitor);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("mount-removed", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * Emitted when a mountable volume is added to the system.
   */
  ulong connectVolumeAdded(void delegate(Volume volume, VolumeMonitor volumeMonitor) dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto volumeMonitor = getVal!VolumeMonitor(_paramVals);
      auto volume = getVal!Volume(&_paramVals[1]);
      _dgClosure.dlg(volume, volumeMonitor);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("volume-added", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * Emitted when mountable volume is changed.
   */
  ulong connectVolumeChanged(void delegate(Volume volume, VolumeMonitor volumeMonitor) dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto volumeMonitor = getVal!VolumeMonitor(_paramVals);
      auto volume = getVal!Volume(&_paramVals[1]);
      _dgClosure.dlg(volume, volumeMonitor);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("volume-changed", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * Emitted when a mountable volume is removed from the system.
   */
  ulong connectVolumeRemoved(void delegate(Volume volume, VolumeMonitor volumeMonitor) dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto volumeMonitor = getVal!VolumeMonitor(_paramVals);
      auto volume = getVal!Volume(&_paramVals[1]);
      _dgClosure.dlg(volume, volumeMonitor);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("volume-removed", closure, (flags & ConnectFlags.After) != 0);
  }
}
