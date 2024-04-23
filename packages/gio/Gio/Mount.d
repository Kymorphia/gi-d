module Gio.Mount;

import GLib.ErrorG;
import GObject.DClosure;
import GObject.ObjectG;
import GObject.Types;
import Gid.Gid;
import Gio.AsyncResult;
import Gio.Cancellable;
import Gio.Drive;
import Gio.File;
import Gio.Icon;
import Gio.MountOperation;
import Gio.Types;
import Gio.Volume;
import Gio.c.functions;
import Gio.c.types;

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
interface Mount
{

  static GType getType()
  {
    return g_mount_get_type();
  }

  /**
   * %TRUE if the @mount can be ejected.
   */
  bool canEject();

  /**
   * %TRUE if the @mount can be unmounted.
   */
  bool canUnmount();

  /**
   * Ejects a mount. This is an asynchronous operation, and is
   * finished by calling g_mount_eject_finish() with the @mount
   * and #GAsyncResult data returned in the @callback.
   */
  void eject(MountUnmountFlags flags, Cancellable cancellable, AsyncReadyCallback callback);

  /**
   * %TRUE if the mount was successfully ejected. %FALSE otherwise.
   */
  bool ejectFinish(AsyncResult result);

  /**
   * Ejects a mount. This is an asynchronous operation, and is
   * finished by calling g_mount_eject_with_operation_finish() with the @mount
   * and #GAsyncResult data returned in the @callback.
   */
  void ejectWithOperation(MountUnmountFlags flags, MountOperation mountOperation, Cancellable cancellable, AsyncReadyCallback callback);

  /**
   * %TRUE if the mount was successfully ejected. %FALSE otherwise.
   */
  bool ejectWithOperationFinish(AsyncResult result);

  /**
   * a #GFile.
   * The returned object should be unreffed with
   * g_object_unref() when no longer needed.
   */
  File getDefaultLocation();

  /**
   * a #GDrive or %NULL if @mount is not
   * associated with a volume or a drive.
   * The returned object should be unreffed with
   * g_object_unref() when no longer needed.
   */
  Drive getDrive();

  /**
   * a #GIcon.
   * The returned object should be unreffed with
   * g_object_unref() when no longer needed.
   */
  Icon getIcon();

  /**
   * the name for the given @mount.
   * The returned string should be freed with g_free()
   * when no longer needed.
   */
  string getName();

  /**
   * a #GFile.
   * The returned object should be unreffed with
   * g_object_unref() when no longer needed.
   */
  File getRoot();

  /**
   * Sorting key for @mount or %NULL if no such key is available.
   */
  string getSortKey();

  /**
   * a #GIcon.
   * The returned object should be unreffed with
   * g_object_unref() when no longer needed.
   */
  Icon getSymbolicIcon();

  /**
   * the UUID for @mount or %NULL if no UUID
   * can be computed.
   * The returned string should be freed with g_free()
   * when no longer needed.
   */
  string getUuid();

  /**
   * a #GVolume or %NULL if @mount is not
   * associated with a volume.
   * The returned object should be unreffed with
   * g_object_unref() when no longer needed.
   */
  Volume getVolume();

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
  void guessContentType(bool forceRescan, Cancellable cancellable, AsyncReadyCallback callback);

  /**
   * a %NULL-terminated array of content types or %NULL on error.
   * Caller should free this array with g_strfreev() when done with it.
   */
  string[] guessContentTypeFinish(AsyncResult result);

  /**
   * a %NULL-terminated array of content types or %NULL on error.
   * Caller should free this array with g_strfreev() when done with it.
   */
  string[] guessContentTypeSync(bool forceRescan, Cancellable cancellable);

  /**
   * %TRUE if @mount is shadowed.
   */
  bool isShadowed();

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
  void remount(MountMountFlags flags, MountOperation mountOperation, Cancellable cancellable, AsyncReadyCallback callback);

  /**
   * %TRUE if the mount was successfully remounted. %FALSE otherwise.
   */
  bool remountFinish(AsyncResult result);

  /**
   * Increments the shadow count on @mount. Usually used by
   * #GVolumeMonitor implementations when creating a shadow mount for
   * @mount, see g_mount_is_shadowed() for more information. The caller
   * will need to emit the #GMount::changed signal on @mount manually.
   */
  void shadow();

  /**
   * Unmounts a mount. This is an asynchronous operation, and is
   * finished by calling g_mount_unmount_finish() with the @mount
   * and #GAsyncResult data returned in the @callback.
   */
  void unmount(MountUnmountFlags flags, Cancellable cancellable, AsyncReadyCallback callback);

  /**
   * %TRUE if the mount was successfully unmounted. %FALSE otherwise.
   */
  bool unmountFinish(AsyncResult result);

  /**
   * Unmounts a mount. This is an asynchronous operation, and is
   * finished by calling g_mount_unmount_with_operation_finish() with the @mount
   * and #GAsyncResult data returned in the @callback.
   */
  void unmountWithOperation(MountUnmountFlags flags, MountOperation mountOperation, Cancellable cancellable, AsyncReadyCallback callback);

  /**
   * %TRUE if the mount was successfully unmounted. %FALSE otherwise.
   */
  bool unmountWithOperationFinish(AsyncResult result);

  /**
   * Decrements the shadow count on @mount. Usually used by
   * #GVolumeMonitor implementations when destroying a shadow mount for
   * @mount, see g_mount_is_shadowed() for more information. The caller
   * will need to emit the #GMount::changed signal on @mount manually.
   */
  void unshadow();

  /**
   * Emitted when the mount has been changed.
   */
  ulong connectChanged(void delegate(Mount mount) dlg, ConnectFlags flags = ConnectFlags.Default);

  /**
   * This signal may be emitted when the #GMount is about to be
   * unmounted.
   *
   * This signal depends on the backend and is only emitted if
   * GIO was used to unmount.
   */
  ulong connectPreUnmount(void delegate(Mount mount) dlg, ConnectFlags flags = ConnectFlags.Default);

  /**
   * This signal is emitted when the #GMount have been
   * unmounted. If the recipient is holding references to the
   * object they should release them so the object can be
   * finalized.
   */
  ulong connectUnmounted(void delegate(Mount mount) dlg, ConnectFlags flags = ConnectFlags.Default);
}
