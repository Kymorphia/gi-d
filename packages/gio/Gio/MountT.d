module Gio.MountT;

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
public import Gio.MountOperation;
public import Gio.Types;
public import Gio.Volume;
public import Gio.c.functions;
public import Gio.c.types;

/**
 * The #GMount interface represents user-visible mounts. Note, when
 * porting from GnomeVFS, #GMount is the moral equivalent of #GnomeVFSVolume.
 *
 * #GMount is a "mounted" filesystem that you can access. Mounted is in
 * quotes because it's not the same as a unix mount, it might be a gvfs
 * mount, but you can still access the files on it if you use GIO. Might or
 * might not be related to a volume object.
 *
 * Unmounting a #GMount instance is an asynchronous operation. For
 * more information about asynchronous operations, see #GAsyncResult
 * and #GTask. To unmount a #GMount instance, first call
 * g_mount_unmount_with_operation() with (at least) the #GMount instance and a
 * #GAsyncReadyCallback.  The callback will be fired when the
 * operation has resolved (either with success or failure), and a
 * #GAsyncResult structure will be passed to the callback.  That
 * callback should then call g_mount_unmount_with_operation_finish() with the #GMount
 * and the #GAsyncResult data to see if the operation was completed
 * successfully.  If an @error is present when g_mount_unmount_with_operation_finish()
 * is called, then it will be filled with any error information.
 */
template MountT(TStruct)
{

  /**
   * %TRUE if the @mount can be ejected.
   */
  override bool canEject()
  {
    bool _retval;
    _retval = g_mount_can_eject(cPtr!GMount);
    return _retval;
  }

  /**
   * %TRUE if the @mount can be unmounted.
   */
  override bool canUnmount()
  {
    bool _retval;
    _retval = g_mount_can_unmount(cPtr!GMount);
    return _retval;
  }

  /**
   * Ejects a mount. This is an asynchronous operation, and is
   * finished by calling g_mount_eject_finish() with the @mount
   * and #GAsyncResult data returned in the @callback.
   */
  override void eject(MountUnmountFlags flags, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    ptrFreezeGC(cast(void*)&callback);
    g_mount_eject(cPtr!GMount, flags, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * %TRUE if the mount was successfully ejected. %FALSE otherwise.
   */
  override bool ejectFinish(AsyncResult result)
  {
    bool _retval;
    GError *_err;
    _retval = g_mount_eject_finish(cPtr!GMount, result ? (cast(ObjectG)result).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Ejects a mount. This is an asynchronous operation, and is
   * finished by calling g_mount_eject_with_operation_finish() with the @mount
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
    g_mount_eject_with_operation(cPtr!GMount, flags, mountOperation ? mountOperation.cPtr!GMountOperation : null, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * %TRUE if the mount was successfully ejected. %FALSE otherwise.
   */
  override bool ejectWithOperationFinish(AsyncResult result)
  {
    bool _retval;
    GError *_err;
    _retval = g_mount_eject_with_operation_finish(cPtr!GMount, result ? (cast(ObjectG)result).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * a #GFile.
   * The returned object should be unreffed with
   * g_object_unref() when no longer needed.
   */
  override File getDefaultLocation()
  {
    GFile* _cretval;
    _cretval = g_mount_get_default_location(cPtr!GMount);
    File _retval = ObjectG.getDObject!File(cast(GFile*)_cretval, true);
    return _retval;
  }

  /**
   * a #GDrive or %NULL if @mount is not
   * associated with a volume or a drive.
   * The returned object should be unreffed with
   * g_object_unref() when no longer needed.
   */
  override Drive getDrive()
  {
    GDrive* _cretval;
    _cretval = g_mount_get_drive(cPtr!GMount);
    Drive _retval = ObjectG.getDObject!Drive(cast(GDrive*)_cretval, true);
    return _retval;
  }

  /**
   * a #GIcon.
   * The returned object should be unreffed with
   * g_object_unref() when no longer needed.
   */
  override Icon getIcon()
  {
    GIcon* _cretval;
    _cretval = g_mount_get_icon(cPtr!GMount);
    Icon _retval = ObjectG.getDObject!Icon(cast(GIcon*)_cretval, true);
    return _retval;
  }

  /**
   * the name for the given @mount.
   * The returned string should be freed with g_free()
   * when no longer needed.
   */
  override string getName()
  {
    char* _cretval;
    _cretval = g_mount_get_name(cPtr!GMount);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * a #GFile.
   * The returned object should be unreffed with
   * g_object_unref() when no longer needed.
   */
  override File getRoot()
  {
    GFile* _cretval;
    _cretval = g_mount_get_root(cPtr!GMount);
    File _retval = ObjectG.getDObject!File(cast(GFile*)_cretval, true);
    return _retval;
  }

  /**
   * Sorting key for @mount or %NULL if no such key is available.
   */
  override string getSortKey()
  {
    const(char)* _cretval;
    _cretval = g_mount_get_sort_key(cPtr!GMount);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * a #GIcon.
   * The returned object should be unreffed with
   * g_object_unref() when no longer needed.
   */
  override Icon getSymbolicIcon()
  {
    GIcon* _cretval;
    _cretval = g_mount_get_symbolic_icon(cPtr!GMount);
    Icon _retval = ObjectG.getDObject!Icon(cast(GIcon*)_cretval, true);
    return _retval;
  }

  /**
   * the UUID for @mount or %NULL if no UUID
   * can be computed.
   * The returned string should be freed with g_free()
   * when no longer needed.
   */
  override string getUuid()
  {
    char* _cretval;
    _cretval = g_mount_get_uuid(cPtr!GMount);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * a #GVolume or %NULL if @mount is not
   * associated with a volume.
   * The returned object should be unreffed with
   * g_object_unref() when no longer needed.
   */
  override Volume getVolume()
  {
    GVolume* _cretval;
    _cretval = g_mount_get_volume(cPtr!GMount);
    Volume _retval = ObjectG.getDObject!Volume(cast(GVolume*)_cretval, true);
    return _retval;
  }

  /**
   * Tries to guess the type of content stored on @mount. Returns one or
   * more textual identifiers of well-known content types (typically
   * prefixed with "x-content/"), e.g. x-content/image-dcf for camera
   * memory cards. See the
   * [shared-mime-info](http://www.freedesktop.org/wiki/Specifications/shared-mime-info-spec)
   * specification for more on x-content types.
   *
   * This is an asynchronous operation (see
   * g_mount_guess_content_type_sync() for the synchronous version), and
   * is finished by calling g_mount_guess_content_type_finish() with the
   * @mount and #GAsyncResult data returned in the @callback.
   */
  override void guessContentType(bool forceRescan, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    ptrFreezeGC(cast(void*)&callback);
    g_mount_guess_content_type(cPtr!GMount, forceRescan, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * a %NULL-terminated array of content types or %NULL on error.
   * Caller should free this array with g_strfreev() when done with it.
   */
  override string[] guessContentTypeFinish(AsyncResult result)
  {
    char** _cretval;
    GError *_err;
    _cretval = g_mount_guess_content_type_finish(cPtr!GMount, result ? (cast(ObjectG)result).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
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
   * a %NULL-terminated array of content types or %NULL on error.
   * Caller should free this array with g_strfreev() when done with it.
   */
  override string[] guessContentTypeSync(bool forceRescan, Cancellable cancellable)
  {
    char** _cretval;
    GError *_err;
    _cretval = g_mount_guess_content_type_sync(cPtr!GMount, forceRescan, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
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
   * %TRUE if @mount is shadowed.
   */
  override bool isShadowed()
  {
    bool _retval;
    _retval = g_mount_is_shadowed(cPtr!GMount);
    return _retval;
  }

  /**
   * Remounts a mount. This is an asynchronous operation, and is
   * finished by calling g_mount_remount_finish() with the @mount
   * and #GAsyncResults data returned in the @callback.
   *
   * Remounting is useful when some setting affecting the operation
   * of the volume has been changed, as these may need a remount to
   * take affect. While this is semantically equivalent with unmounting
   * and then remounting not all backends might need to actually be
   * unmounted.
   */
  override void remount(MountMountFlags flags, MountOperation mountOperation, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    ptrFreezeGC(cast(void*)&callback);
    g_mount_remount(cPtr!GMount, flags, mountOperation ? mountOperation.cPtr!GMountOperation : null, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * %TRUE if the mount was successfully remounted. %FALSE otherwise.
   */
  override bool remountFinish(AsyncResult result)
  {
    bool _retval;
    GError *_err;
    _retval = g_mount_remount_finish(cPtr!GMount, result ? (cast(ObjectG)result).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Increments the shadow count on @mount. Usually used by
   * #GVolumeMonitor implementations when creating a shadow mount for
   * @mount, see g_mount_is_shadowed() for more information. The caller
   * will need to emit the #GMount::changed signal on @mount manually.
   */
  override void shadow()
  {
    g_mount_shadow(cPtr!GMount);
  }

  /**
   * Unmounts a mount. This is an asynchronous operation, and is
   * finished by calling g_mount_unmount_finish() with the @mount
   * and #GAsyncResult data returned in the @callback.
   */
  override void unmount(MountUnmountFlags flags, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    ptrFreezeGC(cast(void*)&callback);
    g_mount_unmount(cPtr!GMount, flags, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * %TRUE if the mount was successfully unmounted. %FALSE otherwise.
   */
  override bool unmountFinish(AsyncResult result)
  {
    bool _retval;
    GError *_err;
    _retval = g_mount_unmount_finish(cPtr!GMount, result ? (cast(ObjectG)result).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Unmounts a mount. This is an asynchronous operation, and is
   * finished by calling g_mount_unmount_with_operation_finish() with the @mount
   * and #GAsyncResult data returned in the @callback.
   */
  override void unmountWithOperation(MountUnmountFlags flags, MountOperation mountOperation, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    ptrFreezeGC(cast(void*)&callback);
    g_mount_unmount_with_operation(cPtr!GMount, flags, mountOperation ? mountOperation.cPtr!GMountOperation : null, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * %TRUE if the mount was successfully unmounted. %FALSE otherwise.
   */
  override bool unmountWithOperationFinish(AsyncResult result)
  {
    bool _retval;
    GError *_err;
    _retval = g_mount_unmount_with_operation_finish(cPtr!GMount, result ? (cast(ObjectG)result).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Decrements the shadow count on @mount. Usually used by
   * #GVolumeMonitor implementations when destroying a shadow mount for
   * @mount, see g_mount_is_shadowed() for more information. The caller
   * will need to emit the #GMount::changed signal on @mount manually.
   */
  override void unshadow()
  {
    g_mount_unshadow(cPtr!GMount);
  }

  /**
   * Emitted when the mount has been changed.
   */
  ulong connectChanged(void delegate(Mount mount) dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto mount = getVal!Mount(_paramVals);
      _dgClosure.dlg(mount);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("changed", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * This signal may be emitted when the #GMount is about to be
   * unmounted.
   *
   * This signal depends on the backend and is only emitted if
   * GIO was used to unmount.
   */
  ulong connectPreUnmount(void delegate(Mount mount) dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto mount = getVal!Mount(_paramVals);
      _dgClosure.dlg(mount);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("pre-unmount", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * This signal is emitted when the #GMount have been
   * unmounted. If the recipient is holding references to the
   * object they should release them so the object can be
   * finalized.
   */
  ulong connectUnmounted(void delegate(Mount mount) dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto mount = getVal!Mount(_paramVals);
      _dgClosure.dlg(mount);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("unmounted", closure, (flags & ConnectFlags.After) != 0);
  }
}
