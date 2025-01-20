module Gio.VolumeT;

public import Gio.VolumeIfaceProxy;
public import GLib.ErrorG;
public import GObject.DClosure;
public import GObject.ObjectG;
public import Gid.gid;
public import Gio.AsyncResult;
public import Gio.AsyncResultT;
public import Gio.Cancellable;
public import Gio.Drive;
public import Gio.DriveT;
public import Gio.File;
public import Gio.FileT;
public import Gio.Icon;
public import Gio.IconT;
public import Gio.Mount;
public import Gio.MountOperation;
public import Gio.MountT;
public import Gio.Types;
public import Gio.c.functions;
public import Gio.c.types;

/**
 * The `GVolume` interface represents user-visible objects that can be
 * mounted. Note, when [porting from GnomeVFS](migrating-gnome-vfs.html),
 * `GVolume` is the moral equivalent of `GnomeVFSDrive`.
 * Mounting a `GVolume` instance is an asynchronous operation. For more
 * information about asynchronous operations, see [Gio.AsyncResult] and
 * [Gio.Task]. To mount a `GVolume`, first call [Gio.Volume.mount]
 * with $(LPAREN)at least$(RPAREN) the `GVolume` instance, optionally a
 * [Gio.MountOperation] object and a [Gio.AsyncReadyCallback].
 * Typically, one will only want to pass `NULL` for the
 * [Gio.MountOperation] if automounting all volumes when a desktop session
 * starts since it’s not desirable to put up a lot of dialogs asking
 * for credentials.
 * The callback will be fired when the operation has resolved $(LPAREN)either
 * with success or failure$(RPAREN), and a [Gio.AsyncResult] instance will be
 * passed to the callback.  That callback should then call
 * [Gio.Volume.mountFinish] with the `GVolume` instance and the
 * [Gio.AsyncResult] data to see if the operation was completed
 * successfully.  If a [GLib.ErrorG] is present when
 * [Gio.Volume.mountFinish] is called, then it will be filled with any
 * error information.
 * ## Volume Identifiers
 * It is sometimes necessary to directly access the underlying
 * operating system object behind a volume $(LPAREN)e.g. for passing a volume
 * to an application via the command line$(RPAREN). For this purpose, GIO
 * allows to obtain an ‘identifier’ for the volume. There can be
 * different kinds of identifiers, such as Hal UDIs, filesystem labels,
 * traditional Unix devices $(LPAREN)e.g. `/dev/sda2`$(RPAREN), UUIDs. GIO uses predefined
 * strings as names for the different kinds of identifiers:
 * `G_VOLUME_IDENTIFIER_KIND_UUID`, `G_VOLUME_IDENTIFIER_KIND_LABEL`, etc.
 * Use [Gio.Volume.getIdentifier] to obtain an identifier for a volume.
 * Note that `G_VOLUME_IDENTIFIER_KIND_HAL_UDI` will only be available
 * when the GVFS hal volume monitor is in use. Other volume monitors
 * will generally be able to provide the `G_VOLUME_IDENTIFIER_KIND_UNIX_DEVICE`
 * identifier, which can be used to obtain a hal device by means of
 * `libhal_manager_find_device_string_match$(LPAREN)$(RPAREN)`.
 */
template VolumeT()
{

  /**
   * Checks if a volume can be ejected.
   * Returns: %TRUE if the volume can be ejected. %FALSE otherwise
   */
  override bool canEject()
  {
    bool _retval;
    _retval = g_volume_can_eject(cast(GVolume*)cPtr);
    return _retval;
  }

  /**
   * Checks if a volume can be mounted.
   * Returns: %TRUE if the volume can be mounted. %FALSE otherwise
   */
  override bool canMount()
  {
    bool _retval;
    _retval = g_volume_can_mount(cast(GVolume*)cPtr);
    return _retval;
  }

  /**
   * Ejects a volume. This is an asynchronous operation, and is
   * finished by calling [Gio.Volume.ejectFinish] with the volume
   * and #GAsyncResult returned in the callback.
   * Params:
   *   flags = flags affecting the unmount if required for eject
   *   cancellable = optional #GCancellable object, %NULL to ignore
   *   callback = a #GAsyncReadyCallback, or %NULL

   * Deprecated: Use [Gio.Volume.ejectWithOperation] instead.
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
    g_volume_eject(cast(GVolume*)cPtr, flags, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_callbackCallback, _callback);
  }

  /**
   * Finishes ejecting a volume. If any errors occurred during the operation,
   * error will be set to contain the errors and %FALSE will be returned.
   * Params:
   *   result = a #GAsyncResult
   * Returns: %TRUE, %FALSE if operation failed

   * Deprecated: Use [Gio.Volume.ejectWithOperationFinish] instead.
   */
  override bool ejectFinish(AsyncResult result)
  {
    bool _retval;
    GError *_err;
    _retval = g_volume_eject_finish(cast(GVolume*)cPtr, result ? cast(GAsyncResult*)(cast(ObjectG)result).cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Ejects a volume. This is an asynchronous operation, and is
   * finished by calling [Gio.Volume.ejectWithOperationFinish] with the volume
   * and #GAsyncResult data returned in the callback.
   * Params:
   *   flags = flags affecting the unmount if required for eject
   *   mountOperation = a #GMountOperation or %NULL to
   *     avoid user interaction
   *   cancellable = optional #GCancellable object, %NULL to ignore
   *   callback = a #GAsyncReadyCallback, or %NULL
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
    g_volume_eject_with_operation(cast(GVolume*)cPtr, flags, mountOperation ? cast(GMountOperation*)mountOperation.cPtr(false) : null, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_callbackCallback, _callback);
  }

  /**
   * Finishes ejecting a volume. If any errors occurred during the operation,
   * error will be set to contain the errors and %FALSE will be returned.
   * Params:
   *   result = a #GAsyncResult
   * Returns: %TRUE if the volume was successfully ejected. %FALSE otherwise
   */
  override bool ejectWithOperationFinish(AsyncResult result)
  {
    bool _retval;
    GError *_err;
    _retval = g_volume_eject_with_operation_finish(cast(GVolume*)cPtr, result ? cast(GAsyncResult*)(cast(ObjectG)result).cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Gets the kinds of [identifiers](#volume-identifiers) that volume has.
   * Use [Gio.Volume.getIdentifier] to obtain the identifiers themselves.
   * Returns: a %NULL-terminated array
   *   of strings containing kinds of identifiers. Use [GLib.Global.strfreev] to free.
   */
  override string[] enumerateIdentifiers()
  {
    char** _cretval;
    _cretval = g_volume_enumerate_identifiers(cast(GVolume*)cPtr);
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
   * Gets the activation root for a #GVolume if it is known ahead of
   * mount time. Returns %NULL otherwise. If not %NULL and if volume
   * is mounted, then the result of [Gio.Mount.getRoot] on the
   * #GMount object obtained from [Gio.Volume.getMount] will always
   * either be equal or a prefix of what this function returns. In
   * other words, in code
   * |[<!-- language\="C" -->
   * GMount *mount;
   * GFile *mount_root
   * GFile *volume_activation_root;
   * mount \= g_volume_get_mount $(LPAREN)volume$(RPAREN); // mounted, so never NULL
   * mount_root \= g_mount_get_root $(LPAREN)mount$(RPAREN);
   * volume_activation_root \= g_volume_get_activation_root $(LPAREN)volume$(RPAREN); // assume not NULL
   * ]|
   * then the expression
   * |[<!-- language\="C" -->
   * $(LPAREN)g_file_has_prefix $(LPAREN)volume_activation_root, mount_root$(RPAREN) ||
   * g_file_equal $(LPAREN)volume_activation_root, mount_root$(RPAREN)$(RPAREN)
   * ]|
   * will always be %TRUE.
   * Activation roots are typically used in #GVolumeMonitor
   * implementations to find the underlying mount to shadow, see
   * [Gio.Mount.isShadowed] for more details.
   * Returns: the activation root of volume
   *   or %NULL. Use [GObject.ObjectG.unref] to free.
   */
  override File getActivationRoot()
  {
    GFile* _cretval;
    _cretval = g_volume_get_activation_root(cast(GVolume*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!File(cast(GFile*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Gets the drive for the volume.
   * Returns: a #GDrive or %NULL if volume is not
   *   associated with a drive. The returned object should be unreffed
   *   with [GObject.ObjectG.unref] when no longer needed.
   */
  override Drive getDrive()
  {
    GDrive* _cretval;
    _cretval = g_volume_get_drive(cast(GVolume*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Drive(cast(GDrive*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Gets the icon for volume.
   * Returns: a #GIcon.
   *   The returned object should be unreffed with [GObject.ObjectG.unref]
   *   when no longer needed.
   */
  override Icon getIcon()
  {
    GIcon* _cretval;
    _cretval = g_volume_get_icon(cast(GVolume*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Icon(cast(GIcon*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Gets the identifier of the given kind for volume.
   * See the [introduction](#volume-identifiers) for more
   * information about volume identifiers.
   * Params:
   *   kind = the kind of identifier to return
   * Returns: a newly allocated string containing the
   *   requested identifier, or %NULL if the #GVolume
   *   doesn't have this kind of identifier
   */
  override string getIdentifier(string kind)
  {
    char* _cretval;
    const(char)* _kind = kind.toCString(false);
    _cretval = g_volume_get_identifier(cast(GVolume*)cPtr, _kind);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * Gets the mount for the volume.
   * Returns: a #GMount or %NULL if volume isn't mounted.
   *   The returned object should be unreffed with [GObject.ObjectG.unref]
   *   when no longer needed.
   */
  override Mount getMount()
  {
    GMount* _cretval;
    _cretval = g_volume_get_mount(cast(GVolume*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Mount(cast(GMount*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Gets the name of volume.
   * Returns: the name for the given volume. The returned string should
   *   be freed with [GLib.Global.gfree] when no longer needed.
   */
  override string getName()
  {
    char* _cretval;
    _cretval = g_volume_get_name(cast(GVolume*)cPtr);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * Gets the sort key for volume, if any.
   * Returns: Sorting key for volume or %NULL if no such key is available
   */
  override string getSortKey()
  {
    const(char)* _cretval;
    _cretval = g_volume_get_sort_key(cast(GVolume*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Gets the symbolic icon for volume.
   * Returns: a #GIcon.
   *   The returned object should be unreffed with [GObject.ObjectG.unref]
   *   when no longer needed.
   */
  override Icon getSymbolicIcon()
  {
    GIcon* _cretval;
    _cretval = g_volume_get_symbolic_icon(cast(GVolume*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Icon(cast(GIcon*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Gets the UUID for the volume. The reference is typically based on
   * the file system UUID for the volume in question and should be
   * considered an opaque string. Returns %NULL if there is no UUID
   * available.
   * Returns: the UUID for volume or %NULL if no UUID
   *   can be computed.
   *   The returned string should be freed with [GLib.Global.gfree]
   *   when no longer needed.
   */
  override string getUuid()
  {
    char* _cretval;
    _cretval = g_volume_get_uuid(cast(GVolume*)cPtr);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * Mounts a volume. This is an asynchronous operation, and is
   * finished by calling [Gio.Volume.mountFinish] with the volume
   * and #GAsyncResult returned in the callback.
   * Params:
   *   flags = flags affecting the operation
   *   mountOperation = a #GMountOperation or %NULL to avoid user interaction
   *   cancellable = optional #GCancellable object, %NULL to ignore
   *   callback = a #GAsyncReadyCallback, or %NULL
   */
  override void mount(MountMountFlags flags, MountOperation mountOperation, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(AsyncReadyCallback*)data;

      (*_dlg)(sourceObject ? ObjectG.getDObject!ObjectG(cast(void*)sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(cast(void*)res, false) : null);
    }

    auto _callback = freezeDelegate(cast(void*)&callback);
    g_volume_mount(cast(GVolume*)cPtr, flags, mountOperation ? cast(GMountOperation*)mountOperation.cPtr(false) : null, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_callbackCallback, _callback);
  }

  /**
   * Finishes mounting a volume. If any errors occurred during the operation,
   * error will be set to contain the errors and %FALSE will be returned.
   * If the mount operation succeeded, [Gio.Volume.getMount] on volume
   * is guaranteed to return the mount right after calling this
   * function; there's no need to listen for the 'mount-added' signal on
   * #GVolumeMonitor.
   * Params:
   *   result = a #GAsyncResult
   * Returns: %TRUE, %FALSE if operation failed
   */
  override bool mountFinish(AsyncResult result)
  {
    bool _retval;
    GError *_err;
    _retval = g_volume_mount_finish(cast(GVolume*)cPtr, result ? cast(GAsyncResult*)(cast(ObjectG)result).cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Returns whether the volume should be automatically mounted.
   * Returns: %TRUE if the volume should be automatically mounted
   */
  override bool shouldAutomount()
  {
    bool _retval;
    _retval = g_volume_should_automount(cast(GVolume*)cPtr);
    return _retval;
  }

  /**
   * Emitted when the volume has been changed.
   *   volume = the instance the signal is connected to
   */
  alias ChangedCallback = void delegate(Volume volume);

  /**
   * Connect to Changed signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectChanged(ChangedCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto volume = getVal!Volume(_paramVals);
      _dgClosure.dlg(volume);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("changed", closure, after);
  }

  /**
   * This signal is emitted when the #GVolume have been removed. If
   * the recipient is holding references to the object they should
   * release them so the object can be finalized.
   *   volume = the instance the signal is connected to
   */
  alias RemovedCallback = void delegate(Volume volume);

  /**
   * Connect to Removed signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectRemoved(RemovedCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto volume = getVal!Volume(_paramVals);
      _dgClosure.dlg(volume);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("removed", closure, after);
  }
}
