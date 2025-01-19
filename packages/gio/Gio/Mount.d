module Gio.Mount;

public import Gio.MountIfaceProxy;
import GLib.ErrorG;
import GObject.DClosure;
import GObject.ObjectG;
import Gid.gid;
import Gio.AsyncResult;
import Gio.AsyncResultT;
import Gio.Cancellable;
import Gio.Drive;
import Gio.DriveT;
import Gio.File;
import Gio.FileT;
import Gio.Icon;
import Gio.IconT;
import Gio.MountOperation;
import Gio.Types;
import Gio.Volume;
import Gio.VolumeT;
import Gio.c.functions;
import Gio.c.types;

/**
 * The `GMount` interface represents user-visible mounts. Note, when
 * [porting from GnomeVFS](migrating-gnome-vfs.html), `GMount` is the moral
 * equivalent of `GnomeVFSVolume`.
 * `GMount` is a ‘mounted’ filesystem that you can access. Mounted is in
 * quotes because it’s not the same as a UNIX mount, it might be a GVFS
 * mount, but you can still access the files on it if you use GIO. Might or
 * might not be related to a volume object.
 * Unmounting a `GMount` instance is an asynchronous operation. For
 * more information about asynchronous operations, see [Gio.AsyncResult]
 * and [Gio.Task]. To unmount a `GMount` instance, first call
 * [Gio.Mount.unmountWithOperation] with (at least) the `GMount`
 * instance and a [Gio.AsyncReadyCallback].  The callback will be fired
 * when the operation has resolved $(LPAREN)either with success or failure$(RPAREN), and a
 * [Gio.AsyncResult] structure will be passed to the callback.  That
 * callback should then call [Gio.Mount.unmountWithOperationFinish]
 * with the `GMount` and the [Gio.AsyncResult] data to see if the
 * operation was completed successfully.  If an `error` is present when
 * [Gio.Mount.unmountWithOperationFinish] is called, then it will be
 * filled with any error information.
 */
interface Mount
{

  static GType getType()
  {
    return g_mount_get_type();
  }

  /**
   * Checks if mount can be ejected.
   * Returns: %TRUE if the mount can be ejected.
   */
  bool canEject();

  /**
   * Checks if mount can be unmounted.
   * Returns: %TRUE if the mount can be unmounted.
   */
  bool canUnmount();

  /**
   * Ejects a mount. This is an asynchronous operation, and is
   * finished by calling [Gio.Mount.ejectFinish] with the mount
   * and #GAsyncResult data returned in the callback.
   * Params:
   *   flags = flags affecting the unmount if required for eject
   *   cancellable = optional #GCancellable object, %NULL to ignore.
   *   callback = a #GAsyncReadyCallback, or %NULL.

   * Deprecated: Use [Gio.Mount.ejectWithOperation] instead.
   */
  void eject(MountUnmountFlags flags, Cancellable cancellable, AsyncReadyCallback callback);

  /**
   * Finishes ejecting a mount. If any errors occurred during the operation,
   * error will be set to contain the errors and %FALSE will be returned.
   * Params:
   *   result = a #GAsyncResult.
   * Returns: %TRUE if the mount was successfully ejected. %FALSE otherwise.

   * Deprecated: Use [Gio.Mount.ejectWithOperationFinish] instead.
   */
  bool ejectFinish(AsyncResult result);

  /**
   * Ejects a mount. This is an asynchronous operation, and is
   * finished by calling [Gio.Mount.ejectWithOperationFinish] with the mount
   * and #GAsyncResult data returned in the callback.
   * Params:
   *   flags = flags affecting the unmount if required for eject
   *   mountOperation = a #GMountOperation or %NULL to avoid
   *     user interaction.
   *   cancellable = optional #GCancellable object, %NULL to ignore.
   *   callback = a #GAsyncReadyCallback, or %NULL.
   */
  void ejectWithOperation(MountUnmountFlags flags, MountOperation mountOperation, Cancellable cancellable, AsyncReadyCallback callback);

  /**
   * Finishes ejecting a mount. If any errors occurred during the operation,
   * error will be set to contain the errors and %FALSE will be returned.
   * Params:
   *   result = a #GAsyncResult.
   * Returns: %TRUE if the mount was successfully ejected. %FALSE otherwise.
   */
  bool ejectWithOperationFinish(AsyncResult result);

  /**
   * Gets the default location of mount. The default location of the given
   * mount is a path that reflects the main entry point for the user $(LPAREN)e.g.
   * the home directory, or the root of the volume$(RPAREN).
   * Returns: a #GFile.
   *   The returned object should be unreffed with
   *   [GObject.ObjectG.unref] when no longer needed.
   */
  File getDefaultLocation();

  /**
   * Gets the drive for the mount.
   * This is a convenience method for getting the #GVolume and then
   * using that object to get the #GDrive.
   * Returns: a #GDrive or %NULL if mount is not
   *   associated with a volume or a drive.
   *   The returned object should be unreffed with
   *   [GObject.ObjectG.unref] when no longer needed.
   */
  Drive getDrive();

  /**
   * Gets the icon for mount.
   * Returns: a #GIcon.
   *   The returned object should be unreffed with
   *   [GObject.ObjectG.unref] when no longer needed.
   */
  Icon getIcon();

  /**
   * Gets the name of mount.
   * Returns: the name for the given mount.
   *   The returned string should be freed with [GLib.Global.gfree]
   *   when no longer needed.
   */
  string getName();

  /**
   * Gets the root directory on mount.
   * Returns: a #GFile.
   *   The returned object should be unreffed with
   *   [GObject.ObjectG.unref] when no longer needed.
   */
  File getRoot();

  /**
   * Gets the sort key for mount, if any.
   * Returns: Sorting key for mount or %NULL if no such key is available.
   */
  string getSortKey();

  /**
   * Gets the symbolic icon for mount.
   * Returns: a #GIcon.
   *   The returned object should be unreffed with
   *   [GObject.ObjectG.unref] when no longer needed.
   */
  Icon getSymbolicIcon();

  /**
   * Gets the UUID for the mount. The reference is typically based on
   * the file system UUID for the mount in question and should be
   * considered an opaque string. Returns %NULL if there is no UUID
   * available.
   * Returns: the UUID for mount or %NULL if no UUID
   *   can be computed.
   *   The returned string should be freed with [GLib.Global.gfree]
   *   when no longer needed.
   */
  string getUuid();

  /**
   * Gets the volume for the mount.
   * Returns: a #GVolume or %NULL if mount is not
   *   associated with a volume.
   *   The returned object should be unreffed with
   *   [GObject.ObjectG.unref] when no longer needed.
   */
  Volume getVolume();

  /**
   * Tries to guess the type of content stored on mount. Returns one or
   * more textual identifiers of well-known content types $(LPAREN)typically
   * prefixed with "x-content/"$(RPAREN), e.g. x-content/image-dcf for camera
   * memory cards. See the
   * [shared-mime-info](http://www.freedesktop.org/wiki/Specifications/shared-mime-info-spec)
   * specification for more on x-content types.
   * This is an asynchronous operation $(LPAREN)see
   * [Gio.Mount.guessContentTypeSync] for the synchronous version$(RPAREN), and
   * is finished by calling [Gio.Mount.guessContentTypeFinish] with the
   * mount and #GAsyncResult data returned in the callback.
   * Params:
   *   forceRescan = Whether to force a rescan of the content.
   *     Otherwise a cached result will be used if available
   *   cancellable = optional #GCancellable object, %NULL to ignore
   *   callback = a #GAsyncReadyCallback
   */
  void guessContentType(bool forceRescan, Cancellable cancellable, AsyncReadyCallback callback);

  /**
   * Finishes guessing content types of mount. If any errors occurred
   * during the operation, error will be set to contain the errors and
   * %FALSE will be returned. In particular, you may get an
   * %G_IO_ERROR_NOT_SUPPORTED if the mount does not support content
   * guessing.
   * Params:
   *   result = a #GAsyncResult
   * Returns: a %NULL-terminated array of content types or %NULL on error.
   *   Caller should free this array with [GLib.Global.strfreev] when done with it.
   */
  string[] guessContentTypeFinish(AsyncResult result);

  /**
   * Tries to guess the type of content stored on mount. Returns one or
   * more textual identifiers of well-known content types $(LPAREN)typically
   * prefixed with "x-content/"$(RPAREN), e.g. x-content/image-dcf for camera
   * memory cards. See the
   * [shared-mime-info](http://www.freedesktop.org/wiki/Specifications/shared-mime-info-spec)
   * specification for more on x-content types.
   * This is a synchronous operation and as such may block doing IO;
   * see [Gio.Mount.guessContentType] for the asynchronous version.
   * Params:
   *   forceRescan = Whether to force a rescan of the content.
   *     Otherwise a cached result will be used if available
   *   cancellable = optional #GCancellable object, %NULL to ignore
   * Returns: a %NULL-terminated array of content types or %NULL on error.
   *   Caller should free this array with [GLib.Global.strfreev] when done with it.
   */
  string[] guessContentTypeSync(bool forceRescan, Cancellable cancellable);

  /**
   * Determines if mount is shadowed. Applications or libraries should
   * avoid displaying mount in the user interface if it is shadowed.
   * A mount is said to be shadowed if there exists one or more user
   * visible objects $(LPAREN)currently #GMount objects$(RPAREN) with a root that is
   * inside the root of mount.
   * One application of shadow mounts is when exposing a single file
   * system that is used to address several logical volumes. In this
   * situation, a #GVolumeMonitor implementation would create two
   * #GVolume objects $(LPAREN)for example, one for the camera functionality of
   * the device and one for a SD card reader on the device$(RPAREN) with
   * activation URIs `gphoto2://[usb:001,002]/store1/`
   * and `gphoto2://[usb:001,002]/store2/`. When the
   * underlying mount $(LPAREN)with root
   * `gphoto2://[usb:001,002]/`$(RPAREN) is mounted, said
   * #GVolumeMonitor implementation would create two #GMount objects
   * $(LPAREN)each with their root matching the corresponding volume activation
   * root$(RPAREN) that would shadow the original mount.
   * The proxy monitor in GVfs 2.26 and later, automatically creates and
   * manage shadow mounts $(LPAREN)and shadows the underlying mount$(RPAREN) if the
   * activation root on a #GVolume is set.
   * Returns: %TRUE if mount is shadowed.
   */
  bool isShadowed();

  /**
   * Remounts a mount. This is an asynchronous operation, and is
   * finished by calling [Gio.Mount.remountFinish] with the mount
   * and #GAsyncResults data returned in the callback.
   * Remounting is useful when some setting affecting the operation
   * of the volume has been changed, as these may need a remount to
   * take affect. While this is semantically equivalent with unmounting
   * and then remounting not all backends might need to actually be
   * unmounted.
   * Params:
   *   flags = flags affecting the operation
   *   mountOperation = a #GMountOperation or %NULL to avoid
   *     user interaction.
   *   cancellable = optional #GCancellable object, %NULL to ignore.
   *   callback = a #GAsyncReadyCallback, or %NULL.
   */
  void remount(MountMountFlags flags, MountOperation mountOperation, Cancellable cancellable, AsyncReadyCallback callback);

  /**
   * Finishes remounting a mount. If any errors occurred during the operation,
   * error will be set to contain the errors and %FALSE will be returned.
   * Params:
   *   result = a #GAsyncResult.
   * Returns: %TRUE if the mount was successfully remounted. %FALSE otherwise.
   */
  bool remountFinish(AsyncResult result);

  /**
   * Increments the shadow count on mount. Usually used by
   * #GVolumeMonitor implementations when creating a shadow mount for
   * mount, see [Gio.Mount.isShadowed] for more information. The caller
   * will need to emit the #GMount::changed signal on mount manually.
   */
  void shadow();

  /**
   * Unmounts a mount. This is an asynchronous operation, and is
   * finished by calling [Gio.Mount.unmountFinish] with the mount
   * and #GAsyncResult data returned in the callback.
   * Params:
   *   flags = flags affecting the operation
   *   cancellable = optional #GCancellable object, %NULL to ignore.
   *   callback = a #GAsyncReadyCallback, or %NULL.

   * Deprecated: Use [Gio.Mount.unmountWithOperation] instead.
   */
  void unmount(MountUnmountFlags flags, Cancellable cancellable, AsyncReadyCallback callback);

  /**
   * Finishes unmounting a mount. If any errors occurred during the operation,
   * error will be set to contain the errors and %FALSE will be returned.
   * Params:
   *   result = a #GAsyncResult.
   * Returns: %TRUE if the mount was successfully unmounted. %FALSE otherwise.

   * Deprecated: Use [Gio.Mount.unmountWithOperationFinish] instead.
   */
  bool unmountFinish(AsyncResult result);

  /**
   * Unmounts a mount. This is an asynchronous operation, and is
   * finished by calling [Gio.Mount.unmountWithOperationFinish] with the mount
   * and #GAsyncResult data returned in the callback.
   * Params:
   *   flags = flags affecting the operation
   *   mountOperation = a #GMountOperation or %NULL to avoid
   *     user interaction.
   *   cancellable = optional #GCancellable object, %NULL to ignore.
   *   callback = a #GAsyncReadyCallback, or %NULL.
   */
  void unmountWithOperation(MountUnmountFlags flags, MountOperation mountOperation, Cancellable cancellable, AsyncReadyCallback callback);

  /**
   * Finishes unmounting a mount. If any errors occurred during the operation,
   * error will be set to contain the errors and %FALSE will be returned.
   * Params:
   *   result = a #GAsyncResult.
   * Returns: %TRUE if the mount was successfully unmounted. %FALSE otherwise.
   */
  bool unmountWithOperationFinish(AsyncResult result);

  /**
   * Decrements the shadow count on mount. Usually used by
   * #GVolumeMonitor implementations when destroying a shadow mount for
   * mount, see [Gio.Mount.isShadowed] for more information. The caller
   * will need to emit the #GMount::changed signal on mount manually.
   */
  void unshadow();

  /**
   * Emitted when the mount has been changed.
   *   mount = the instance the signal is connected to
   */
  alias ChangedCallback = void delegate(Mount mount);

  /**
   * Connect to Changed signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectChanged(ChangedCallback dlg, Flag!"After" after = No.After);

  /**
   * This signal may be emitted when the #GMount is about to be
   * unmounted.
   * This signal depends on the backend and is only emitted if
   * GIO was used to unmount.
   *   mount = the instance the signal is connected to
   */
  alias PreUnmountCallback = void delegate(Mount mount);

  /**
   * Connect to PreUnmount signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectPreUnmount(PreUnmountCallback dlg, Flag!"After" after = No.After);

  /**
   * This signal is emitted when the #GMount have been
   * unmounted. If the recipient is holding references to the
   * object they should release them so the object can be
   * finalized.
   *   mount = the instance the signal is connected to
   */
  alias UnmountedCallback = void delegate(Mount mount);

  /**
   * Connect to Unmounted signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectUnmounted(UnmountedCallback dlg, Flag!"After" after = No.After);
}
