module Gio.Drive;

import GLib.ErrorG;
import GLib.List;
import GLib.Types;
import GObject.DClosure;
import GObject.ObjectG;
import GObject.Types;
import Gid.Gid;
import Gio.AsyncResult;
import Gio.Cancellable;
import Gio.Icon;
import Gio.MountOperation;
import Gio.Types;
import Gio.Volume;
import Gio.c.functions;
import Gio.c.types;

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
interface Drive
{

  static GType getType()
  {
    return g_drive_get_type();
  }

  /**
   * %TRUE if the @drive can be ejected, %FALSE otherwise.
   */
  bool canEject();

  /**
   * %TRUE if the @drive can be polled for media changes,
   * %FALSE otherwise.
   */
  bool canPollForMedia();

  /**
   * %TRUE if the @drive can be started, %FALSE otherwise.
   */
  bool canStart();

  /**
   * %TRUE if the @drive can be started degraded, %FALSE otherwise.
   */
  bool canStartDegraded();

  /**
   * %TRUE if the @drive can be stopped, %FALSE otherwise.
   */
  bool canStop();

  /**
   * Asynchronously ejects a drive.
   *
   * When the operation is finished, @callback will be called.
   * You can then call g_drive_eject_finish() to obtain the
   * result of the operation.
   */
  void eject(MountUnmountFlags flags, Cancellable cancellable, AsyncReadyCallback callback);

  /**
   * %TRUE if the drive has been ejected successfully,
   * %FALSE otherwise.
   */
  bool ejectFinish(AsyncResult result);

  /**
   * Ejects a drive. This is an asynchronous operation, and is
   * finished by calling g_drive_eject_with_operation_finish() with the @drive
   * and #GAsyncResult data returned in the @callback.
   */
  void ejectWithOperation(MountUnmountFlags flags, MountOperation mountOperation, Cancellable cancellable, AsyncReadyCallback callback);

  /**
   * %TRUE if the drive was successfully ejected. %FALSE otherwise.
   */
  bool ejectWithOperationFinish(AsyncResult result);

  /**
   * a %NULL-terminated
   * array of strings containing kinds of identifiers. Use g_strfreev()
   * to free.
   */
  string[] enumerateIdentifiers();

  /**
   * #GIcon for the @drive.
   * Free the returned object with g_object_unref().
   */
  Icon getIcon();

  /**
   * a newly allocated string containing the
   * requested identifier, or %NULL if the #GDrive
   * doesn't have this kind of identifier.
   */
  string getIdentifier(string kind);

  /**
   * a string containing @drive's name. The returned
   * string should be freed when no longer needed.
   */
  string getName();

  /**
   * Sorting key for @drive or %NULL if no such key is available.
   */
  string getSortKey();

  /**
   * A value from the #GDriveStartStopType enumeration.
   */
  DriveStartStopType getStartStopType();

  /**
   * symbolic #GIcon for the @drive.
   * Free the returned object with g_object_unref().
   */
  Icon getSymbolicIcon();

  /**
   * #GList containing any #GVolume objects on the given @drive.
   */
  List!(Volume, GVolume*) getVolumes();

  /**
   * %TRUE if @drive has media, %FALSE otherwise.
   */
  bool hasMedia();

  /**
   * %TRUE if the @drive contains volumes, %FALSE otherwise.
   */
  bool hasVolumes();

  /**
   * %TRUE if the @drive is capable of automatically detecting
   * media changes, %FALSE otherwise.
   */
  bool isMediaCheckAutomatic();

  /**
   * %TRUE if @drive supports removable media, %FALSE otherwise.
   */
  bool isMediaRemovable();

  /**
   * %TRUE if @drive and/or its media is considered removable, %FALSE otherwise.
   */
  bool isRemovable();

  /**
   * Asynchronously polls @drive to see if media has been inserted or removed.
   *
   * When the operation is finished, @callback will be called.
   * You can then call g_drive_poll_for_media_finish() to obtain the
   * result of the operation.
   */
  void pollForMedia(Cancellable cancellable, AsyncReadyCallback callback);

  /**
   * %TRUE if the drive has been poll_for_mediaed successfully,
   * %FALSE otherwise.
   */
  bool pollForMediaFinish(AsyncResult result);

  /**
   * Asynchronously starts a drive.
   *
   * When the operation is finished, @callback will be called.
   * You can then call g_drive_start_finish() to obtain the
   * result of the operation.
   */
  void start(DriveStartFlags flags, MountOperation mountOperation, Cancellable cancellable, AsyncReadyCallback callback);

  /**
   * %TRUE if the drive has been started successfully,
   * %FALSE otherwise.
   */
  bool startFinish(AsyncResult result);

  /**
   * Asynchronously stops a drive.
   *
   * When the operation is finished, @callback will be called.
   * You can then call g_drive_stop_finish() to obtain the
   * result of the operation.
   */
  void stop(MountUnmountFlags flags, MountOperation mountOperation, Cancellable cancellable, AsyncReadyCallback callback);

  /**
   * %TRUE if the drive has been stopped successfully,
   * %FALSE otherwise.
   */
  bool stopFinish(AsyncResult result);

  /**
   * Emitted when the drive's state has changed.
   */
  ulong connectChanged(void delegate(Drive drive) dlg, ConnectFlags flags = ConnectFlags.Default);

  /**
   * This signal is emitted when the #GDrive have been
   * disconnected. If the recipient is holding references to the
   * object they should release them so the object can be
   * finalized.
   */
  ulong connectDisconnected(void delegate(Drive drive) dlg, ConnectFlags flags = ConnectFlags.Default);

  /**
   * Emitted when the physical eject button (if any) of a drive has
   * been pressed.
   */
  ulong connectEjectButton(void delegate(Drive drive) dlg, ConnectFlags flags = ConnectFlags.Default);

  /**
   * Emitted when the physical stop button (if any) of a drive has
   * been pressed.
   */
  ulong connectStopButton(void delegate(Drive drive) dlg, ConnectFlags flags = ConnectFlags.Default);
}
