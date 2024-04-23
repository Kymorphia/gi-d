module Gio.Volume;

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
import Gio.Mount;
import Gio.MountOperation;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

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
interface Volume
{

  static GType getType()
  {
    return g_volume_get_type();
  }

  /**
   * %TRUE if the @volume can be ejected. %FALSE otherwise
   */
  bool canEject();

  /**
   * %TRUE if the @volume can be mounted. %FALSE otherwise
   */
  bool canMount();

  /**
   * Ejects a volume. This is an asynchronous operation, and is
   * finished by calling g_volume_eject_finish() with the @volume
   * and #GAsyncResult returned in the @callback.
   */
  void eject(MountUnmountFlags flags, Cancellable cancellable, AsyncReadyCallback callback);

  /**
   * %TRUE, %FALSE if operation failed
   */
  bool ejectFinish(AsyncResult result);

  /**
   * Ejects a volume. This is an asynchronous operation, and is
   * finished by calling g_volume_eject_with_operation_finish() with the @volume
   * and #GAsyncResult data returned in the @callback.
   */
  void ejectWithOperation(MountUnmountFlags flags, MountOperation mountOperation, Cancellable cancellable, AsyncReadyCallback callback);

  /**
   * %TRUE if the volume was successfully ejected. %FALSE otherwise
   */
  bool ejectWithOperationFinish(AsyncResult result);

  /**
   * a %NULL-terminated array
   * of strings containing kinds of identifiers. Use g_strfreev() to free.
   */
  string[] enumerateIdentifiers();

  /**
   * the activation root of @volume
   * or %NULL. Use g_object_unref() to free.
   */
  File getActivationRoot();

  /**
   * a #GDrive or %NULL if @volume is not
   * associated with a drive. The returned object should be unreffed
   * with g_object_unref() when no longer needed.
   */
  Drive getDrive();

  /**
   * a #GIcon.
   * The returned object should be unreffed with g_object_unref()
   * when no longer needed.
   */
  Icon getIcon();

  /**
   * a newly allocated string containing the
   * requested identifier, or %NULL if the #GVolume
   * doesn't have this kind of identifier
   */
  string getIdentifier(string kind);

  /**
   * a #GMount or %NULL if @volume isn't mounted.
   * The returned object should be unreffed with g_object_unref()
   * when no longer needed.
   */
  Mount getMount();

  /**
   * the name for the given @volume. The returned string should
   * be freed with g_free() when no longer needed.
   */
  string getName();

  /**
   * Sorting key for @volume or %NULL if no such key is available
   */
  string getSortKey();

  /**
   * a #GIcon.
   * The returned object should be unreffed with g_object_unref()
   * when no longer needed.
   */
  Icon getSymbolicIcon();

  /**
   * the UUID for @volume or %NULL if no UUID
   * can be computed.
   * The returned string should be freed with g_free()
   * when no longer needed.
   */
  string getUuid();

  /**
   * Mounts a volume. This is an asynchronous operation, and is
   * finished by calling g_volume_mount_finish() with the @volume
   * and #GAsyncResult returned in the @callback.
   */
  void mount(MountMountFlags flags, MountOperation mountOperation, Cancellable cancellable, AsyncReadyCallback callback);

  /**
   * %TRUE, %FALSE if operation failed
   */
  bool mountFinish(AsyncResult result);

  /**
   * %TRUE if the volume should be automatically mounted
   */
  bool shouldAutomount();

  /**
   * Emitted when the volume has been changed.
   */
  ulong connectChanged(void delegate(Volume volume) dlg, ConnectFlags flags = ConnectFlags.Default);

  /**
   * This signal is emitted when the #GVolume have been removed. If
   * the recipient is holding references to the object they should
   * release them so the object can be finalized.
   */
  ulong connectRemoved(void delegate(Volume volume) dlg, ConnectFlags flags = ConnectFlags.Default);
}
