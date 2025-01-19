module Gio.VolumeMonitor;

import GLib.List;
import GObject.DClosure;
import GObject.ObjectG;
import Gid.gid;
import Gio.Drive;
import Gio.DriveT;
import Gio.Mount;
import Gio.MountT;
import Gio.Types;
import Gio.Volume;
import Gio.VolumeT;
import Gio.c.functions;
import Gio.c.types;

/**
 * `GVolumeMonitor` is for listing the user interesting devices and volumes
 * on the computer. In other words, what a file selector or file manager
 * would show in a sidebar.
 * `GVolumeMonitor` is not
 * thread-default-context aware $(LPAREN)see
 * [GLib.MainContext.pushThreadDefault]$(RPAREN), and so should not be used
 * other than from the main thread, with no thread-default-context active.
 * In order to receive updates about volumes and mounts monitored through GVFS,
 * a main loop must be running.
 */
class VolumeMonitor : ObjectG
{

  this()
  {
  }

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_volume_monitor_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * This function should be called by any #GVolumeMonitor
   * implementation when a new #GMount object is created that is not
   * associated with a #GVolume object. It must be called just before
   * emitting the mount_added signal.
   * If the return value is not %NULL, the caller must associate the
   * returned #GVolume object with the #GMount. This involves returning
   * it in its [Gio.Mount.getVolume] implementation. The caller must
   * also listen for the "removed" signal on the returned object
   * and give up its reference when handling that signal
   * Similarly, if implementing [Gio.VolumeMonitor.adoptOrphanMount],
   * the implementor must take a reference to mount and return it in
   * its [Gio.Volume.getMount] implemented. Also, the implementor must
   * listen for the "unmounted" signal on mount and give up its
   * reference upon handling that signal.
   * There are two main use cases for this function.
   * One is when implementing a user space file system driver that reads
   * blocks of a block device that is already represented by the native
   * volume monitor $(LPAREN)for example a CD Audio file system driver$(RPAREN). Such
   * a driver will generate its own #GMount object that needs to be
   * associated with the #GVolume object that represents the volume.
   * The other is for implementing a #GVolumeMonitor whose sole purpose
   * is to return #GVolume objects representing entries in the users
   * "favorite servers" list or similar.
   * Params:
   *   mount = a #GMount object to find a parent for
   * Returns: the #GVolume object that is the parent for mount or %NULL
   *   if no wants to adopt the #GMount.

   * Deprecated: Instead of using this function, #GVolumeMonitor
   *   implementations should instead create shadow mounts with the URI of
   *   the mount they intend to adopt. See the proxy volume monitor in
   *   gvfs for an example of this. Also see [Gio.Mount.isShadowed],
   *   [Gio.Mount.shadow] and [Gio.Mount.unshadow] functions.
   */
  static Volume adoptOrphanMount(Mount mount)
  {
    GVolume* _cretval;
    _cretval = g_volume_monitor_adopt_orphan_mount(mount ? cast(GMount*)(cast(ObjectG)mount).cPtr(false) : null);
    auto _retval = _cretval ? ObjectG.getDObject!Volume(cast(GVolume*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Gets the volume monitor used by gio.
   * Returns: a reference to the #GVolumeMonitor used by gio. Call
   *   [GObject.ObjectG.unref] when done with it.
   */
  static VolumeMonitor get()
  {
    GVolumeMonitor* _cretval;
    _cretval = g_volume_monitor_get();
    auto _retval = _cretval ? ObjectG.getDObject!VolumeMonitor(cast(GVolumeMonitor*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Gets a list of drives connected to the system.
   * The returned list should be freed with [GLib.List.free], after
   * its elements have been unreffed with [GObject.ObjectG.unref].
   * Returns: a #GList of connected #GDrive objects.
   */
  List!(Drive, GDrive) getConnectedDrives()
  {
    GList* _cretval;
    _cretval = g_volume_monitor_get_connected_drives(cast(GVolumeMonitor*)cPtr);
    List!(Drive, GDrive) _retval = new List!(Drive, GDrive)(cast(GList*)_cretval, GidOwnership.Full);
    return _retval;
  }

  /**
   * Finds a #GMount object by its UUID $(LPAREN)see [Gio.Mount.getUuid]$(RPAREN)
   * Params:
   *   uuid = the UUID to look for
   * Returns: a #GMount or %NULL if no such mount is available.
   *   Free the returned object with [GObject.ObjectG.unref].
   */
  Mount getMountForUuid(string uuid)
  {
    GMount* _cretval;
    const(char)* _uuid = uuid.toCString(false);
    _cretval = g_volume_monitor_get_mount_for_uuid(cast(GVolumeMonitor*)cPtr, _uuid);
    auto _retval = _cretval ? ObjectG.getDObject!Mount(cast(GMount*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Gets a list of the mounts on the system.
   * The returned list should be freed with [GLib.List.free], after
   * its elements have been unreffed with [GObject.ObjectG.unref].
   * Returns: a #GList of #GMount objects.
   */
  List!(Mount, GMount) getMounts()
  {
    GList* _cretval;
    _cretval = g_volume_monitor_get_mounts(cast(GVolumeMonitor*)cPtr);
    List!(Mount, GMount) _retval = new List!(Mount, GMount)(cast(GList*)_cretval, GidOwnership.Full);
    return _retval;
  }

  /**
   * Finds a #GVolume object by its UUID $(LPAREN)see [Gio.Volume.getUuid]$(RPAREN)
   * Params:
   *   uuid = the UUID to look for
   * Returns: a #GVolume or %NULL if no such volume is available.
   *   Free the returned object with [GObject.ObjectG.unref].
   */
  Volume getVolumeForUuid(string uuid)
  {
    GVolume* _cretval;
    const(char)* _uuid = uuid.toCString(false);
    _cretval = g_volume_monitor_get_volume_for_uuid(cast(GVolumeMonitor*)cPtr, _uuid);
    auto _retval = _cretval ? ObjectG.getDObject!Volume(cast(GVolume*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Gets a list of the volumes on the system.
   * The returned list should be freed with [GLib.List.free], after
   * its elements have been unreffed with [GObject.ObjectG.unref].
   * Returns: a #GList of #GVolume objects.
   */
  List!(Volume, GVolume) getVolumes()
  {
    GList* _cretval;
    _cretval = g_volume_monitor_get_volumes(cast(GVolumeMonitor*)cPtr);
    List!(Volume, GVolume) _retval = new List!(Volume, GVolume)(cast(GList*)_cretval, GidOwnership.Full);
    return _retval;
  }

  /**
   * Emitted when a drive changes.
   * Params
   *   drive = the drive that changed
   *   volumeMonitor = the instance the signal is connected to
   */
  alias DriveChangedCallback = void delegate(Drive drive, VolumeMonitor volumeMonitor);

  /**
   * Connect to DriveChanged signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectDriveChanged(DriveChangedCallback dlg, Flag!"After" after = No.After)
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
    return connectSignalClosure("drive-changed", closure, after);
  }

  /**
   * Emitted when a drive is connected to the system.
   * Params
   *   drive = a #GDrive that was connected.
   *   volumeMonitor = the instance the signal is connected to
   */
  alias DriveConnectedCallback = void delegate(Drive drive, VolumeMonitor volumeMonitor);

  /**
   * Connect to DriveConnected signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectDriveConnected(DriveConnectedCallback dlg, Flag!"After" after = No.After)
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
    return connectSignalClosure("drive-connected", closure, after);
  }

  /**
   * Emitted when a drive is disconnected from the system.
   * Params
   *   drive = a #GDrive that was disconnected.
   *   volumeMonitor = the instance the signal is connected to
   */
  alias DriveDisconnectedCallback = void delegate(Drive drive, VolumeMonitor volumeMonitor);

  /**
   * Connect to DriveDisconnected signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectDriveDisconnected(DriveDisconnectedCallback dlg, Flag!"After" after = No.After)
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
    return connectSignalClosure("drive-disconnected", closure, after);
  }

  /**
   * Emitted when the eject button is pressed on drive.
   * Params
   *   drive = the drive where the eject button was pressed
   *   volumeMonitor = the instance the signal is connected to
   */
  alias DriveEjectButtonCallback = void delegate(Drive drive, VolumeMonitor volumeMonitor);

  /**
   * Connect to DriveEjectButton signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectDriveEjectButton(DriveEjectButtonCallback dlg, Flag!"After" after = No.After)
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
    return connectSignalClosure("drive-eject-button", closure, after);
  }

  /**
   * Emitted when the stop button is pressed on drive.
   * Params
   *   drive = the drive where the stop button was pressed
   *   volumeMonitor = the instance the signal is connected to
   */
  alias DriveStopButtonCallback = void delegate(Drive drive, VolumeMonitor volumeMonitor);

  /**
   * Connect to DriveStopButton signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectDriveStopButton(DriveStopButtonCallback dlg, Flag!"After" after = No.After)
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
    return connectSignalClosure("drive-stop-button", closure, after);
  }

  /**
   * Emitted when a mount is added.
   * Params
   *   mount = a #GMount that was added.
   *   volumeMonitor = the instance the signal is connected to
   */
  alias MountAddedCallback = void delegate(Mount mount, VolumeMonitor volumeMonitor);

  /**
   * Connect to MountAdded signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectMountAdded(MountAddedCallback dlg, Flag!"After" after = No.After)
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
    return connectSignalClosure("mount-added", closure, after);
  }

  /**
   * Emitted when a mount changes.
   * Params
   *   mount = a #GMount that changed.
   *   volumeMonitor = the instance the signal is connected to
   */
  alias MountChangedCallback = void delegate(Mount mount, VolumeMonitor volumeMonitor);

  /**
   * Connect to MountChanged signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectMountChanged(MountChangedCallback dlg, Flag!"After" after = No.After)
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
    return connectSignalClosure("mount-changed", closure, after);
  }

  /**
   * May be emitted when a mount is about to be removed.
   * This signal depends on the backend and is only emitted if
   * GIO was used to unmount.
   * Params
   *   mount = a #GMount that is being unmounted.
   *   volumeMonitor = the instance the signal is connected to
   */
  alias MountPreUnmountCallback = void delegate(Mount mount, VolumeMonitor volumeMonitor);

  /**
   * Connect to MountPreUnmount signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectMountPreUnmount(MountPreUnmountCallback dlg, Flag!"After" after = No.After)
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
    return connectSignalClosure("mount-pre-unmount", closure, after);
  }

  /**
   * Emitted when a mount is removed.
   * Params
   *   mount = a #GMount that was removed.
   *   volumeMonitor = the instance the signal is connected to
   */
  alias MountRemovedCallback = void delegate(Mount mount, VolumeMonitor volumeMonitor);

  /**
   * Connect to MountRemoved signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectMountRemoved(MountRemovedCallback dlg, Flag!"After" after = No.After)
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
    return connectSignalClosure("mount-removed", closure, after);
  }

  /**
   * Emitted when a mountable volume is added to the system.
   * Params
   *   volume = a #GVolume that was added.
   *   volumeMonitor = the instance the signal is connected to
   */
  alias VolumeAddedCallback = void delegate(Volume volume, VolumeMonitor volumeMonitor);

  /**
   * Connect to VolumeAdded signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectVolumeAdded(VolumeAddedCallback dlg, Flag!"After" after = No.After)
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
    return connectSignalClosure("volume-added", closure, after);
  }

  /**
   * Emitted when mountable volume is changed.
   * Params
   *   volume = a #GVolume that changed.
   *   volumeMonitor = the instance the signal is connected to
   */
  alias VolumeChangedCallback = void delegate(Volume volume, VolumeMonitor volumeMonitor);

  /**
   * Connect to VolumeChanged signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectVolumeChanged(VolumeChangedCallback dlg, Flag!"After" after = No.After)
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
    return connectSignalClosure("volume-changed", closure, after);
  }

  /**
   * Emitted when a mountable volume is removed from the system.
   * Params
   *   volume = a #GVolume that was removed.
   *   volumeMonitor = the instance the signal is connected to
   */
  alias VolumeRemovedCallback = void delegate(Volume volume, VolumeMonitor volumeMonitor);

  /**
   * Connect to VolumeRemoved signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectVolumeRemoved(VolumeRemovedCallback dlg, Flag!"After" after = No.After)
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
    return connectSignalClosure("volume-removed", closure, after);
  }
}
