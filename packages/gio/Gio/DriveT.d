module Gio.DriveT;

public import GLib.ErrorG;
public import GLib.List;
public import GLib.Types;
public import GObject.DClosure;
public import GObject.ObjectG;
public import GObject.Types;
public import Gid.Gid;
public import Gio.AsyncResult;
public import Gio.Cancellable;
public import Gio.Icon;
public import Gio.MountOperation;
public import Gio.Types;
public import Gio.Volume;
public import Gio.c.functions;
public import Gio.c.types;

/**
 * #GDrive - this represent a piece of hardware connected to the machine.
 * It's generally only created for removable hardware or hardware with
 * removable media.
 *
 * #GDrive is a container class for #GVolume objects that stem from
 * the same piece of media. As such, #GDrive abstracts a drive with
 * (or without) removable media and provides operations for querying
 * whether media is available, determining whether media change is
 * automatically detected and ejecting the media.
 *
 * If the #GDrive reports that media isn't automatically detected, one
 * can poll for media; typically one should not do this periodically
 * as a poll for media operation is potentially expensive and may
 * spin up the drive creating noise.
 *
 * #GDrive supports starting and stopping drives with authentication
 * support for the former. This can be used to support a diverse set
 * of use cases including connecting/disconnecting iSCSI devices,
 * powering down external disk enclosures and starting/stopping
 * multi-disk devices such as RAID devices. Note that the actual
 * semantics and side-effects of starting/stopping a #GDrive may vary
 * according to implementation. To choose the correct verbs in e.g. a
 * file manager, use g_drive_get_start_stop_type().
 *
 * For porting from GnomeVFS note that there is no equivalent of
 * #GDrive in that API.
 */
template DriveT(TStruct)
{

  /**
   * %TRUE if the @drive can be ejected, %FALSE otherwise.
   */
  override bool canEject()
  {
    bool _retval;
    _retval = g_drive_can_eject(cPtr!GDrive);
    return _retval;
  }

  /**
   * %TRUE if the @drive can be polled for media changes,
   * %FALSE otherwise.
   */
  override bool canPollForMedia()
  {
    bool _retval;
    _retval = g_drive_can_poll_for_media(cPtr!GDrive);
    return _retval;
  }

  /**
   * %TRUE if the @drive can be started, %FALSE otherwise.
   */
  override bool canStart()
  {
    bool _retval;
    _retval = g_drive_can_start(cPtr!GDrive);
    return _retval;
  }

  /**
   * %TRUE if the @drive can be started degraded, %FALSE otherwise.
   */
  override bool canStartDegraded()
  {
    bool _retval;
    _retval = g_drive_can_start_degraded(cPtr!GDrive);
    return _retval;
  }

  /**
   * %TRUE if the @drive can be stopped, %FALSE otherwise.
   */
  override bool canStop()
  {
    bool _retval;
    _retval = g_drive_can_stop(cPtr!GDrive);
    return _retval;
  }

  /**
   * Asynchronously ejects a drive.
   *
   * When the operation is finished, @callback will be called.
   * You can then call g_drive_eject_finish() to obtain the
   * result of the operation.
   */
  override void eject(MountUnmountFlags flags, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    ptrFreezeGC(cast(void*)&callback);
    g_drive_eject(cPtr!GDrive, flags, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * %TRUE if the drive has been ejected successfully,
   * %FALSE otherwise.
   */
  override bool ejectFinish(AsyncResult result)
  {
    bool _retval;
    GError *_err;
    _retval = g_drive_eject_finish(cPtr!GDrive, result ? (cast(ObjectG)result).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Ejects a drive. This is an asynchronous operation, and is
   * finished by calling g_drive_eject_with_operation_finish() with the @drive
   * and #GAsyncResult data returned in the @callback.
   */
  override void ejectWithOperation(MountUnmountFlags flags, MountOperation mountOperation, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    ptrFreezeGC(cast(void*)&callback);
    g_drive_eject_with_operation(cPtr!GDrive, flags, mountOperation ? mountOperation.cPtr!GMountOperation : null, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * %TRUE if the drive was successfully ejected. %FALSE otherwise.
   */
  override bool ejectWithOperationFinish(AsyncResult result)
  {
    bool _retval;
    GError *_err;
    _retval = g_drive_eject_with_operation_finish(cPtr!GDrive, result ? (cast(ObjectG)result).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * a %NULL-terminated
   * array of strings containing kinds of identifiers. Use g_strfreev()
   * to free.
   */
  override string[] enumerateIdentifiers()
  {
    char** _cretval;
    _cretval = g_drive_enumerate_identifiers(cPtr!GDrive);
    string[] _retval;

    if (_cretval)
    {
      uint _cretlength;
      for (; _cretval[_cretlength] != null; _cretlength++)
        break;
      _retval = new string[_cretlength];
      foreach (i; 0 .. _cretlength)
        _retval[i] = _cretval[i].fromCString(true);
    }
    return _retval;
  }

  /**
   * #GIcon for the @drive.
   * Free the returned object with g_object_unref().
   */
  override Icon getIcon()
  {
    GIcon* _cretval;
    _cretval = g_drive_get_icon(cPtr!GDrive);
    Icon _retval = ObjectG.getDObject!Icon(cast(GIcon*)_cretval, true);
    return _retval;
  }

  /**
   * a newly allocated string containing the
   * requested identifier, or %NULL if the #GDrive
   * doesn't have this kind of identifier.
   */
  override string getIdentifier(string kind)
  {
    char* _cretval;
    const(char)* _kind = kind.toCString(false);
    _cretval = g_drive_get_identifier(cPtr!GDrive, _kind);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * a string containing @drive's name. The returned
   * string should be freed when no longer needed.
   */
  override string getName()
  {
    char* _cretval;
    _cretval = g_drive_get_name(cPtr!GDrive);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * Sorting key for @drive or %NULL if no such key is available.
   */
  override string getSortKey()
  {
    const(char)* _cretval;
    _cretval = g_drive_get_sort_key(cPtr!GDrive);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * A value from the #GDriveStartStopType enumeration.
   */
  override DriveStartStopType getStartStopType()
  {
    GDriveStartStopType _cretval;
    _cretval = g_drive_get_start_stop_type(cPtr!GDrive);
    DriveStartStopType _retval = cast(DriveStartStopType)_cretval;
    return _retval;
  }

  /**
   * symbolic #GIcon for the @drive.
   * Free the returned object with g_object_unref().
   */
  override Icon getSymbolicIcon()
  {
    GIcon* _cretval;
    _cretval = g_drive_get_symbolic_icon(cPtr!GDrive);
    Icon _retval = ObjectG.getDObject!Icon(cast(GIcon*)_cretval, true);
    return _retval;
  }

  /**
   * #GList containing any #GVolume objects on the given @drive.
   */
  override List!(Volume, GVolume*) getVolumes()
  {
    GList* _cretval;
    _cretval = g_drive_get_volumes(cPtr!GDrive);
    List!(Volume, GVolume*) _retval = _cretval ? new List!(Volume, GVolume*)(_cretval, GidOwnership.Full) : null;
    return _retval;
  }

  /**
   * %TRUE if @drive has media, %FALSE otherwise.
   */
  override bool hasMedia()
  {
    bool _retval;
    _retval = g_drive_has_media(cPtr!GDrive);
    return _retval;
  }

  /**
   * %TRUE if the @drive contains volumes, %FALSE otherwise.
   */
  override bool hasVolumes()
  {
    bool _retval;
    _retval = g_drive_has_volumes(cPtr!GDrive);
    return _retval;
  }

  /**
   * %TRUE if the @drive is capable of automatically detecting
   * media changes, %FALSE otherwise.
   */
  override bool isMediaCheckAutomatic()
  {
    bool _retval;
    _retval = g_drive_is_media_check_automatic(cPtr!GDrive);
    return _retval;
  }

  /**
   * %TRUE if @drive supports removable media, %FALSE otherwise.
   */
  override bool isMediaRemovable()
  {
    bool _retval;
    _retval = g_drive_is_media_removable(cPtr!GDrive);
    return _retval;
  }

  /**
   * %TRUE if @drive and/or its media is considered removable, %FALSE otherwise.
   */
  override bool isRemovable()
  {
    bool _retval;
    _retval = g_drive_is_removable(cPtr!GDrive);
    return _retval;
  }

  /**
   * Asynchronously polls @drive to see if media has been inserted or removed.
   *
   * When the operation is finished, @callback will be called.
   * You can then call g_drive_poll_for_media_finish() to obtain the
   * result of the operation.
   */
  override void pollForMedia(Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    ptrFreezeGC(cast(void*)&callback);
    g_drive_poll_for_media(cPtr!GDrive, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * %TRUE if the drive has been poll_for_mediaed successfully,
   * %FALSE otherwise.
   */
  override bool pollForMediaFinish(AsyncResult result)
  {
    bool _retval;
    GError *_err;
    _retval = g_drive_poll_for_media_finish(cPtr!GDrive, result ? (cast(ObjectG)result).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Asynchronously starts a drive.
   *
   * When the operation is finished, @callback will be called.
   * You can then call g_drive_start_finish() to obtain the
   * result of the operation.
   */
  override void start(DriveStartFlags flags, MountOperation mountOperation, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    ptrFreezeGC(cast(void*)&callback);
    g_drive_start(cPtr!GDrive, flags, mountOperation ? mountOperation.cPtr!GMountOperation : null, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * %TRUE if the drive has been started successfully,
   * %FALSE otherwise.
   */
  override bool startFinish(AsyncResult result)
  {
    bool _retval;
    GError *_err;
    _retval = g_drive_start_finish(cPtr!GDrive, result ? (cast(ObjectG)result).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Asynchronously stops a drive.
   *
   * When the operation is finished, @callback will be called.
   * You can then call g_drive_stop_finish() to obtain the
   * result of the operation.
   */
  override void stop(MountUnmountFlags flags, MountOperation mountOperation, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    ptrFreezeGC(cast(void*)&callback);
    g_drive_stop(cPtr!GDrive, flags, mountOperation ? mountOperation.cPtr!GMountOperation : null, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * %TRUE if the drive has been stopped successfully,
   * %FALSE otherwise.
   */
  override bool stopFinish(AsyncResult result)
  {
    bool _retval;
    GError *_err;
    _retval = g_drive_stop_finish(cPtr!GDrive, result ? (cast(ObjectG)result).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Emitted when the drive's state has changed.
   */
  ulong connectChanged(void delegate(Drive drive) dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto drive = getVal!Drive(_paramVals);
      _dgClosure.dlg(drive);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("changed", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * This signal is emitted when the #GDrive have been
   * disconnected. If the recipient is holding references to the
   * object they should release them so the object can be
   * finalized.
   */
  ulong connectDisconnected(void delegate(Drive drive) dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto drive = getVal!Drive(_paramVals);
      _dgClosure.dlg(drive);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("disconnected", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * Emitted when the physical eject button (if any) of a drive has
   * been pressed.
   */
  ulong connectEjectButton(void delegate(Drive drive) dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto drive = getVal!Drive(_paramVals);
      _dgClosure.dlg(drive);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("eject-button", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * Emitted when the physical stop button (if any) of a drive has
   * been pressed.
   */
  ulong connectStopButton(void delegate(Drive drive) dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto drive = getVal!Drive(_paramVals);
      _dgClosure.dlg(drive);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("stop-button", closure, (flags & ConnectFlags.After) != 0);
  }
}
