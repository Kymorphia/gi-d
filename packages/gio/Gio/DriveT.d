module Gio.DriveT;

public import GLib.ErrorG;
public import GLib.List;
public import GObject.DClosure;
public import GObject.ObjectG;
public import GObject.Types;
public import Gid.gid;
public import Gio.AsyncResult;
public import Gio.AsyncResultT;
public import Gio.Cancellable;
public import Gio.Icon;
public import Gio.IconT;
public import Gio.MountOperation;
public import Gio.Types;
public import Gio.Volume;
public import Gio.VolumeT;
public import Gio.c.functions;
public import Gio.c.types;

/**
 * `GDrive` represents a piece of hardware connected to the machine.
 * It’s generally only created for removable hardware or hardware with
 * removable media.
 * `GDrive` is a container class for [Gio.Volume] objects that stem from
 * the same piece of media. As such, `GDrive` abstracts a drive with
 * $(LPAREN)or without$(RPAREN) removable media and provides operations for querying
 * whether media is available, determining whether media change is
 * automatically detected and ejecting the media.
 * If the `GDrive` reports that media isn’t automatically detected, one
 * can poll for media; typically one should not do this periodically
 * as a poll for media operation is potentially expensive and may
 * spin up the drive creating noise.
 * `GDrive` supports starting and stopping drives with authentication
 * support for the former. This can be used to support a diverse set
 * of use cases including connecting/disconnecting iSCSI devices,
 * powering down external disk enclosures and starting/stopping
 * multi-disk devices such as RAID devices. Note that the actual
 * semantics and side-effects of starting/stopping a `GDrive` may vary
 * according to implementation. To choose the correct verbs in e.g. a
 * file manager, use [Gio.Drive.getStartStopType].
 * For [porting from GnomeVFS](migrating-gnome-vfs.html) note that there is no
 * equivalent of `GDrive` in that API.
 */
template DriveT(TStruct)
{

  /**
   * Checks if a drive can be ejected.
   * Returns: %TRUE if the drive can be ejected, %FALSE otherwise.
   */
  override bool canEject()
  {
    bool _retval;
    _retval = g_drive_can_eject(cast(GDrive*)cPtr);
    return _retval;
  }

  /**
   * Checks if a drive can be polled for media changes.
   * Returns: %TRUE if the drive can be polled for media changes,
   *   %FALSE otherwise.
   */
  override bool canPollForMedia()
  {
    bool _retval;
    _retval = g_drive_can_poll_for_media(cast(GDrive*)cPtr);
    return _retval;
  }

  /**
   * Checks if a drive can be started.
   * Returns: %TRUE if the drive can be started, %FALSE otherwise.
   */
  override bool canStart()
  {
    bool _retval;
    _retval = g_drive_can_start(cast(GDrive*)cPtr);
    return _retval;
  }

  /**
   * Checks if a drive can be started degraded.
   * Returns: %TRUE if the drive can be started degraded, %FALSE otherwise.
   */
  override bool canStartDegraded()
  {
    bool _retval;
    _retval = g_drive_can_start_degraded(cast(GDrive*)cPtr);
    return _retval;
  }

  /**
   * Checks if a drive can be stopped.
   * Returns: %TRUE if the drive can be stopped, %FALSE otherwise.
   */
  override bool canStop()
  {
    bool _retval;
    _retval = g_drive_can_stop(cast(GDrive*)cPtr);
    return _retval;
  }

  /**
   * Asynchronously ejects a drive.
   * When the operation is finished, callback will be called.
   * You can then call [Gio.Drive.ejectFinish] to obtain the
   * result of the operation.
   * Params:
   *   flags = flags affecting the unmount if required for eject
   *   cancellable = optional #GCancellable object, %NULL to ignore.
   *   callback = a #GAsyncReadyCallback, or %NULL.

   * Deprecated: Use [Gio.Drive.ejectWithOperation] instead.
   */
  override void eject(MountUnmountFlags flags, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(AsyncReadyCallback*)data;

      (*_dlg)(sourceObject ? ObjectG.getDObject!ObjectG(cast(void*)sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(cast(void*)res, false) : null);
    }

    auto _callback = freezeDelegate(cast(void*)&callback);
    g_drive_eject(cast(GDrive*)cPtr, flags, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_callbackCallback, _callback);
  }

  /**
   * Finishes ejecting a drive.
   * Params:
   *   result = a #GAsyncResult.
   * Returns: %TRUE if the drive has been ejected successfully,
   *   %FALSE otherwise.

   * Deprecated: Use [Gio.Drive.ejectWithOperationFinish] instead.
   */
  override bool ejectFinish(AsyncResult result)
  {
    bool _retval;
    GError *_err;
    _retval = g_drive_eject_finish(cast(GDrive*)cPtr, result ? cast(GAsyncResult*)(cast(ObjectG)result).cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Ejects a drive. This is an asynchronous operation, and is
   * finished by calling [Gio.Drive.ejectWithOperationFinish] with the drive
   * and #GAsyncResult data returned in the callback.
   * Params:
   *   flags = flags affecting the unmount if required for eject
   *   mountOperation = a #GMountOperation or %NULL to avoid
   *     user interaction.
   *   cancellable = optional #GCancellable object, %NULL to ignore.
   *   callback = a #GAsyncReadyCallback, or %NULL.
   */
  override void ejectWithOperation(MountUnmountFlags flags, MountOperation mountOperation, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(AsyncReadyCallback*)data;

      (*_dlg)(sourceObject ? ObjectG.getDObject!ObjectG(cast(void*)sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(cast(void*)res, false) : null);
    }

    auto _callback = freezeDelegate(cast(void*)&callback);
    g_drive_eject_with_operation(cast(GDrive*)cPtr, flags, mountOperation ? cast(GMountOperation*)mountOperation.cPtr(false) : null, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_callbackCallback, _callback);
  }

  /**
   * Finishes ejecting a drive. If any errors occurred during the operation,
   * error will be set to contain the errors and %FALSE will be returned.
   * Params:
   *   result = a #GAsyncResult.
   * Returns: %TRUE if the drive was successfully ejected. %FALSE otherwise.
   */
  override bool ejectWithOperationFinish(AsyncResult result)
  {
    bool _retval;
    GError *_err;
    _retval = g_drive_eject_with_operation_finish(cast(GDrive*)cPtr, result ? cast(GAsyncResult*)(cast(ObjectG)result).cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Gets the kinds of identifiers that drive has.
   * Use [Gio.Drive.getIdentifier] to obtain the identifiers
   * themselves.
   * Returns: a %NULL-terminated
   *   array of strings containing kinds of identifiers. Use [GLib.Global.strfreev]
   *   to free.
   */
  override string[] enumerateIdentifiers()
  {
    char** _cretval;
    _cretval = g_drive_enumerate_identifiers(cast(GDrive*)cPtr);
    string[] _retval;

    if (_cretval)
    {
      uint _cretlength;
      for (; _cretval[_cretlength] !is null; _cretlength++)
        break;
      _retval = new string[_cretlength];
      foreach (i; 0 .. _cretlength)
        _retval[i] = _cretval[i].fromCString(true);
    }
    return _retval;
  }

  /**
   * Gets the icon for drive.
   * Returns: #GIcon for the drive.
   *   Free the returned object with [GObject.ObjectG.unref].
   */
  override Icon getIcon()
  {
    GIcon* _cretval;
    _cretval = g_drive_get_icon(cast(GDrive*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Icon(cast(GIcon*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Gets the identifier of the given kind for drive. The only
   * identifier currently available is
   * %G_DRIVE_IDENTIFIER_KIND_UNIX_DEVICE.
   * Params:
   *   kind = the kind of identifier to return
   * Returns: a newly allocated string containing the
   *   requested identifier, or %NULL if the #GDrive
   *   doesn't have this kind of identifier.
   */
  override string getIdentifier(string kind)
  {
    char* _cretval;
    const(char)* _kind = kind.toCString(false);
    _cretval = g_drive_get_identifier(cast(GDrive*)cPtr, _kind);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * Gets the name of drive.
   * Returns: a string containing drive's name. The returned
   *   string should be freed when no longer needed.
   */
  override string getName()
  {
    char* _cretval;
    _cretval = g_drive_get_name(cast(GDrive*)cPtr);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * Gets the sort key for drive, if any.
   * Returns: Sorting key for drive or %NULL if no such key is available.
   */
  override string getSortKey()
  {
    const(char)* _cretval;
    _cretval = g_drive_get_sort_key(cast(GDrive*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Gets a hint about how a drive can be started/stopped.
   * Returns: A value from the #GDriveStartStopType enumeration.
   */
  override DriveStartStopType getStartStopType()
  {
    GDriveStartStopType _cretval;
    _cretval = g_drive_get_start_stop_type(cast(GDrive*)cPtr);
    DriveStartStopType _retval = cast(DriveStartStopType)_cretval;
    return _retval;
  }

  /**
   * Gets the icon for drive.
   * Returns: symbolic #GIcon for the drive.
   *   Free the returned object with [GObject.ObjectG.unref].
   */
  override Icon getSymbolicIcon()
  {
    GIcon* _cretval;
    _cretval = g_drive_get_symbolic_icon(cast(GDrive*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Icon(cast(GIcon*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Get a list of mountable volumes for drive.
   * The returned list should be freed with [GLib.List.free], after
   * its elements have been unreffed with [GObject.ObjectG.unref].
   * Returns: #GList containing any #GVolume objects on the given drive.
   */
  override List!(Volume, GVolume) getVolumes()
  {
    GList* _cretval;
    _cretval = g_drive_get_volumes(cast(GDrive*)cPtr);
    List!(Volume, GVolume) _retval = new List!(Volume, GVolume)(cast(GList*)_cretval, GidOwnership.Full);
    return _retval;
  }

  /**
   * Checks if the drive has media. Note that the OS may not be polling
   * the drive for media changes; see [Gio.Drive.isMediaCheckAutomatic]
   * for more details.
   * Returns: %TRUE if drive has media, %FALSE otherwise.
   */
  override bool hasMedia()
  {
    bool _retval;
    _retval = g_drive_has_media(cast(GDrive*)cPtr);
    return _retval;
  }

  /**
   * Check if drive has any mountable volumes.
   * Returns: %TRUE if the drive contains volumes, %FALSE otherwise.
   */
  override bool hasVolumes()
  {
    bool _retval;
    _retval = g_drive_has_volumes(cast(GDrive*)cPtr);
    return _retval;
  }

  /**
   * Checks if drive is capable of automatically detecting media changes.
   * Returns: %TRUE if the drive is capable of automatically detecting
   *   media changes, %FALSE otherwise.
   */
  override bool isMediaCheckAutomatic()
  {
    bool _retval;
    _retval = g_drive_is_media_check_automatic(cast(GDrive*)cPtr);
    return _retval;
  }

  /**
   * Checks if the drive supports removable media.
   * Returns: %TRUE if drive supports removable media, %FALSE otherwise.
   */
  override bool isMediaRemovable()
  {
    bool _retval;
    _retval = g_drive_is_media_removable(cast(GDrive*)cPtr);
    return _retval;
  }

  /**
   * Checks if the #GDrive and/or its media is considered removable by the user.
   * See [Gio.Drive.isMediaRemovable].
   * Returns: %TRUE if drive and/or its media is considered removable, %FALSE otherwise.
   */
  override bool isRemovable()
  {
    bool _retval;
    _retval = g_drive_is_removable(cast(GDrive*)cPtr);
    return _retval;
  }

  /**
   * Asynchronously polls drive to see if media has been inserted or removed.
   * When the operation is finished, callback will be called.
   * You can then call [Gio.Drive.pollForMediaFinish] to obtain the
   * result of the operation.
   * Params:
   *   cancellable = optional #GCancellable object, %NULL to ignore.
   *   callback = a #GAsyncReadyCallback, or %NULL.
   */
  override void pollForMedia(Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(AsyncReadyCallback*)data;

      (*_dlg)(sourceObject ? ObjectG.getDObject!ObjectG(cast(void*)sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(cast(void*)res, false) : null);
    }

    auto _callback = freezeDelegate(cast(void*)&callback);
    g_drive_poll_for_media(cast(GDrive*)cPtr, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_callbackCallback, _callback);
  }

  /**
   * Finishes an operation started with [Gio.Drive.pollForMedia] on a drive.
   * Params:
   *   result = a #GAsyncResult.
   * Returns: %TRUE if the drive has been poll_for_mediaed successfully,
   *   %FALSE otherwise.
   */
  override bool pollForMediaFinish(AsyncResult result)
  {
    bool _retval;
    GError *_err;
    _retval = g_drive_poll_for_media_finish(cast(GDrive*)cPtr, result ? cast(GAsyncResult*)(cast(ObjectG)result).cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Asynchronously starts a drive.
   * When the operation is finished, callback will be called.
   * You can then call [Gio.Drive.startFinish] to obtain the
   * result of the operation.
   * Params:
   *   flags = flags affecting the start operation.
   *   mountOperation = a #GMountOperation or %NULL to avoid
   *     user interaction.
   *   cancellable = optional #GCancellable object, %NULL to ignore.
   *   callback = a #GAsyncReadyCallback, or %NULL.
   */
  override void start(DriveStartFlags flags, MountOperation mountOperation, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(AsyncReadyCallback*)data;

      (*_dlg)(sourceObject ? ObjectG.getDObject!ObjectG(cast(void*)sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(cast(void*)res, false) : null);
    }

    auto _callback = freezeDelegate(cast(void*)&callback);
    g_drive_start(cast(GDrive*)cPtr, flags, mountOperation ? cast(GMountOperation*)mountOperation.cPtr(false) : null, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_callbackCallback, _callback);
  }

  /**
   * Finishes starting a drive.
   * Params:
   *   result = a #GAsyncResult.
   * Returns: %TRUE if the drive has been started successfully,
   *   %FALSE otherwise.
   */
  override bool startFinish(AsyncResult result)
  {
    bool _retval;
    GError *_err;
    _retval = g_drive_start_finish(cast(GDrive*)cPtr, result ? cast(GAsyncResult*)(cast(ObjectG)result).cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Asynchronously stops a drive.
   * When the operation is finished, callback will be called.
   * You can then call [Gio.Drive.stopFinish] to obtain the
   * result of the operation.
   * Params:
   *   flags = flags affecting the unmount if required for stopping.
   *   mountOperation = a #GMountOperation or %NULL to avoid
   *     user interaction.
   *   cancellable = optional #GCancellable object, %NULL to ignore.
   *   callback = a #GAsyncReadyCallback, or %NULL.
   */
  override void stop(MountUnmountFlags flags, MountOperation mountOperation, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(AsyncReadyCallback*)data;

      (*_dlg)(sourceObject ? ObjectG.getDObject!ObjectG(cast(void*)sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(cast(void*)res, false) : null);
    }

    auto _callback = freezeDelegate(cast(void*)&callback);
    g_drive_stop(cast(GDrive*)cPtr, flags, mountOperation ? cast(GMountOperation*)mountOperation.cPtr(false) : null, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_callbackCallback, _callback);
  }

  /**
   * Finishes stopping a drive.
   * Params:
   *   result = a #GAsyncResult.
   * Returns: %TRUE if the drive has been stopped successfully,
   *   %FALSE otherwise.
   */
  override bool stopFinish(AsyncResult result)
  {
    bool _retval;
    GError *_err;
    _retval = g_drive_stop_finish(cast(GDrive*)cPtr, result ? cast(GAsyncResult*)(cast(ObjectG)result).cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Emitted when the drive's state has changed.
   *   drive = the instance the signal is connected to
   */
  alias ChangedCallback = void delegate(Drive drive);

  /**
   * Connect to Changed signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectChanged(ChangedCallback dlg, ConnectFlags flags = ConnectFlags.Default)
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
   *   drive = the instance the signal is connected to
   */
  alias DisconnectedCallback = void delegate(Drive drive);

  /**
   * Connect to Disconnected signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectDisconnected(DisconnectedCallback dlg, ConnectFlags flags = ConnectFlags.Default)
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
   * Emitted when the physical eject button $(LPAREN)if any$(RPAREN) of a drive has
   * been pressed.
   *   drive = the instance the signal is connected to
   */
  alias EjectButtonCallback = void delegate(Drive drive);

  /**
   * Connect to EjectButton signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectEjectButton(EjectButtonCallback dlg, ConnectFlags flags = ConnectFlags.Default)
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
   * Emitted when the physical stop button $(LPAREN)if any$(RPAREN) of a drive has
   * been pressed.
   *   drive = the instance the signal is connected to
   */
  alias StopButtonCallback = void delegate(Drive drive);

  /**
   * Connect to StopButton signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectStopButton(StopButtonCallback dlg, ConnectFlags flags = ConnectFlags.Default)
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
