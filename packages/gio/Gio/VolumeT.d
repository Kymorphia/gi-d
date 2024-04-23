module Gio.VolumeT;

public import GLib.ErrorG;
public import GObject.DClosure;
public import GObject.ObjectG;
public import GObject.Types;
public import Gid.Gid;
public import Gio.AsyncResult;
public import Gio.Cancellable;
public import Gio.Drive;
public import Gio.File;
public import Gio.Icon;
public import Gio.Mount;
public import Gio.MountOperation;
public import Gio.Types;
public import Gio.c.functions;
public import Gio.c.types;

/**
 * The #GVolume interface represents user-visible objects that can be
 * mounted. Note, when porting from GnomeVFS, #GVolume is the moral
 * equivalent of #GnomeVFSDrive.
 *
 * Mounting a #GVolume instance is an asynchronous operation. For more
 * information about asynchronous operations, see #GAsyncResult and
 * #GTask. To mount a #GVolume, first call g_volume_mount() with (at
 * least) the #GVolume instance, optionally a #GMountOperation object
 * and a #GAsyncReadyCallback.
 *
 * Typically, one will only want to pass %NULL for the
 * #GMountOperation if automounting all volumes when a desktop session
 * starts since it's not desirable to put up a lot of dialogs asking
 * for credentials.
 *
 * The callback will be fired when the operation has resolved (either
 * with success or failure), and a #GAsyncResult instance will be
 * passed to the callback.  That callback should then call
 * g_volume_mount_finish() with the #GVolume instance and the
 * #GAsyncResult data to see if the operation was completed
 * successfully.  If an @error is present when g_volume_mount_finish()
 * is called, then it will be filled with any error information.
 *
 * ## Volume Identifiers # {#volume-identifier}
 *
 * It is sometimes necessary to directly access the underlying
 * operating system object behind a volume (e.g. for passing a volume
 * to an application via the commandline). For this purpose, GIO
 * allows to obtain an 'identifier' for the volume. There can be
 * different kinds of identifiers, such as Hal UDIs, filesystem labels,
 * traditional Unix devices (e.g. `/dev/sda2`), UUIDs. GIO uses predefined
 * strings as names for the different kinds of identifiers:
 * %G_VOLUME_IDENTIFIER_KIND_UUID, %G_VOLUME_IDENTIFIER_KIND_LABEL, etc.
 * Use g_volume_get_identifier() to obtain an identifier for a volume.
 *
 *
 * Note that %G_VOLUME_IDENTIFIER_KIND_HAL_UDI will only be available
 * when the gvfs hal volume monitor is in use. Other volume monitors
 * will generally be able to provide the %G_VOLUME_IDENTIFIER_KIND_UNIX_DEVICE
 * identifier, which can be used to obtain a hal device by means of
 * libhal_manager_find_device_string_match().
 */
template VolumeT(TStruct)
{

  /**
   * %TRUE if the @volume can be ejected. %FALSE otherwise
   */
  override bool canEject()
  {
    bool _retval;
    _retval = g_volume_can_eject(cPtr!GVolume);
    return _retval;
  }

  /**
   * %TRUE if the @volume can be mounted. %FALSE otherwise
   */
  override bool canMount()
  {
    bool _retval;
    _retval = g_volume_can_mount(cPtr!GVolume);
    return _retval;
  }

  /**
   * Ejects a volume. This is an asynchronous operation, and is
   * finished by calling g_volume_eject_finish() with the @volume
   * and #GAsyncResult returned in the @callback.
   */
  override void eject(MountUnmountFlags flags, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    ptrFreezeGC(cast(void*)&callback);
    g_volume_eject(cPtr!GVolume, flags, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * %TRUE, %FALSE if operation failed
   */
  override bool ejectFinish(AsyncResult result)
  {
    bool _retval;
    GError *_err;
    _retval = g_volume_eject_finish(cPtr!GVolume, result ? (cast(ObjectG)result).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Ejects a volume. This is an asynchronous operation, and is
   * finished by calling g_volume_eject_with_operation_finish() with the @volume
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
    g_volume_eject_with_operation(cPtr!GVolume, flags, mountOperation ? mountOperation.cPtr!GMountOperation : null, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * %TRUE if the volume was successfully ejected. %FALSE otherwise
   */
  override bool ejectWithOperationFinish(AsyncResult result)
  {
    bool _retval;
    GError *_err;
    _retval = g_volume_eject_with_operation_finish(cPtr!GVolume, result ? (cast(ObjectG)result).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * a %NULL-terminated array
   * of strings containing kinds of identifiers. Use g_strfreev() to free.
   */
  override string[] enumerateIdentifiers()
  {
    char** _cretval;
    _cretval = g_volume_enumerate_identifiers(cPtr!GVolume);
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
   * the activation root of @volume
   * or %NULL. Use g_object_unref() to free.
   */
  override File getActivationRoot()
  {
    GFile* _cretval;
    _cretval = g_volume_get_activation_root(cPtr!GVolume);
    File _retval = ObjectG.getDObject!File(cast(GFile*)_cretval, true);
    return _retval;
  }

  /**
   * a #GDrive or %NULL if @volume is not
   * associated with a drive. The returned object should be unreffed
   * with g_object_unref() when no longer needed.
   */
  override Drive getDrive()
  {
    GDrive* _cretval;
    _cretval = g_volume_get_drive(cPtr!GVolume);
    Drive _retval = ObjectG.getDObject!Drive(cast(GDrive*)_cretval, true);
    return _retval;
  }

  /**
   * a #GIcon.
   * The returned object should be unreffed with g_object_unref()
   * when no longer needed.
   */
  override Icon getIcon()
  {
    GIcon* _cretval;
    _cretval = g_volume_get_icon(cPtr!GVolume);
    Icon _retval = ObjectG.getDObject!Icon(cast(GIcon*)_cretval, true);
    return _retval;
  }

  /**
   * a newly allocated string containing the
   * requested identifier, or %NULL if the #GVolume
   * doesn't have this kind of identifier
   */
  override string getIdentifier(string kind)
  {
    char* _cretval;
    const(char)* _kind = kind.toCString(false);
    _cretval = g_volume_get_identifier(cPtr!GVolume, _kind);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * a #GMount or %NULL if @volume isn't mounted.
   * The returned object should be unreffed with g_object_unref()
   * when no longer needed.
   */
  override Mount getMount()
  {
    GMount* _cretval;
    _cretval = g_volume_get_mount(cPtr!GVolume);
    Mount _retval = ObjectG.getDObject!Mount(cast(GMount*)_cretval, true);
    return _retval;
  }

  /**
   * the name for the given @volume. The returned string should
   * be freed with g_free() when no longer needed.
   */
  override string getName()
  {
    char* _cretval;
    _cretval = g_volume_get_name(cPtr!GVolume);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * Sorting key for @volume or %NULL if no such key is available
   */
  override string getSortKey()
  {
    const(char)* _cretval;
    _cretval = g_volume_get_sort_key(cPtr!GVolume);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * a #GIcon.
   * The returned object should be unreffed with g_object_unref()
   * when no longer needed.
   */
  override Icon getSymbolicIcon()
  {
    GIcon* _cretval;
    _cretval = g_volume_get_symbolic_icon(cPtr!GVolume);
    Icon _retval = ObjectG.getDObject!Icon(cast(GIcon*)_cretval, true);
    return _retval;
  }

  /**
   * the UUID for @volume or %NULL if no UUID
   * can be computed.
   * The returned string should be freed with g_free()
   * when no longer needed.
   */
  override string getUuid()
  {
    char* _cretval;
    _cretval = g_volume_get_uuid(cPtr!GVolume);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * Mounts a volume. This is an asynchronous operation, and is
   * finished by calling g_volume_mount_finish() with the @volume
   * and #GAsyncResult returned in the @callback.
   */
  override void mount(MountMountFlags flags, MountOperation mountOperation, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    ptrFreezeGC(cast(void*)&callback);
    g_volume_mount(cPtr!GVolume, flags, mountOperation ? mountOperation.cPtr!GMountOperation : null, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * %TRUE, %FALSE if operation failed
   */
  override bool mountFinish(AsyncResult result)
  {
    bool _retval;
    GError *_err;
    _retval = g_volume_mount_finish(cPtr!GVolume, result ? (cast(ObjectG)result).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * %TRUE if the volume should be automatically mounted
   */
  override bool shouldAutomount()
  {
    bool _retval;
    _retval = g_volume_should_automount(cPtr!GVolume);
    return _retval;
  }

  /**
   * Emitted when the volume has been changed.
   */
  ulong connectChanged(void delegate(Volume volume) dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto volume = getVal!Volume(_paramVals);
      _dgClosure.dlg(volume);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("changed", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * This signal is emitted when the #GVolume have been removed. If
   * the recipient is holding references to the object they should
   * release them so the object can be finalized.
   */
  ulong connectRemoved(void delegate(Volume volume) dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto volume = getVal!Volume(_paramVals);
      _dgClosure.dlg(volume);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("removed", closure, (flags & ConnectFlags.After) != 0);
  }
}
