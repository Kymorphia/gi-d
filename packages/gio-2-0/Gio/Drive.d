module Gio.Drive;

public import Gio.DriveIfaceProxy;
import GLib.ErrorG;
import GLib.List;
import GObject.DClosure;
import GObject.ObjectG;
import Gid.gid;
import Gio.AsyncResult;
import Gio.AsyncResultT;
import Gio.Cancellable;
import Gio.Icon;
import Gio.IconT;
import Gio.MountOperation;
import Gio.Types;
import Gio.Volume;
import Gio.VolumeT;
import Gio.c.functions;
import Gio.c.types;

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
interface Drive
{

  static GType getType()
  {
    return g_drive_get_type();
  }

  /**
   * Checks if a drive can be ejected.
   * Returns: %TRUE if the drive can be ejected, %FALSE otherwise.
   */
  bool canEject();

  /**
   * Checks if a drive can be polled for media changes.
   * Returns: %TRUE if the drive can be polled for media changes,
   *   %FALSE otherwise.
   */
  bool canPollForMedia();

  /**
   * Checks if a drive can be started.
   * Returns: %TRUE if the drive can be started, %FALSE otherwise.
   */
  bool canStart();

  /**
   * Checks if a drive can be started degraded.
   * Returns: %TRUE if the drive can be started degraded, %FALSE otherwise.
   */
  bool canStartDegraded();

  /**
   * Checks if a drive can be stopped.
   * Returns: %TRUE if the drive can be stopped, %FALSE otherwise.
   */
  bool canStop();

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
  void eject(MountUnmountFlags flags, Cancellable cancellable, AsyncReadyCallback callback);

  /**
   * Finishes ejecting a drive.
   * Params:
   *   result = a #GAsyncResult.
   * Returns: %TRUE if the drive has been ejected successfully,
   *   %FALSE otherwise.

   * Deprecated: Use [Gio.Drive.ejectWithOperationFinish] instead.
   */
  bool ejectFinish(AsyncResult result);

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
  void ejectWithOperation(MountUnmountFlags flags, MountOperation mountOperation, Cancellable cancellable, AsyncReadyCallback callback);

  /**
   * Finishes ejecting a drive. If any errors occurred during the operation,
   * error will be set to contain the errors and %FALSE will be returned.
   * Params:
   *   result = a #GAsyncResult.
   * Returns: %TRUE if the drive was successfully ejected. %FALSE otherwise.
   */
  bool ejectWithOperationFinish(AsyncResult result);

  /**
   * Gets the kinds of identifiers that drive has.
   * Use [Gio.Drive.getIdentifier] to obtain the identifiers
   * themselves.
   * Returns: a %NULL-terminated
   *   array of strings containing kinds of identifiers. Use [GLib.Global.strfreev]
   *   to free.
   */
  string[] enumerateIdentifiers();

  /**
   * Gets the icon for drive.
   * Returns: #GIcon for the drive.
   *   Free the returned object with [GObject.ObjectG.unref].
   */
  Icon getIcon();

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
  string getIdentifier(string kind);

  /**
   * Gets the name of drive.
   * Returns: a string containing drive's name. The returned
   *   string should be freed when no longer needed.
   */
  string getName();

  /**
   * Gets the sort key for drive, if any.
   * Returns: Sorting key for drive or %NULL if no such key is available.
   */
  string getSortKey();

  /**
   * Gets a hint about how a drive can be started/stopped.
   * Returns: A value from the #GDriveStartStopType enumeration.
   */
  DriveStartStopType getStartStopType();

  /**
   * Gets the icon for drive.
   * Returns: symbolic #GIcon for the drive.
   *   Free the returned object with [GObject.ObjectG.unref].
   */
  Icon getSymbolicIcon();

  /**
   * Get a list of mountable volumes for drive.
   * The returned list should be freed with [GLib.List.free], after
   * its elements have been unreffed with [GObject.ObjectG.unref].
   * Returns: #GList containing any #GVolume objects on the given drive.
   */
  List!(Volume, GVolume) getVolumes();

  /**
   * Checks if the drive has media. Note that the OS may not be polling
   * the drive for media changes; see [Gio.Drive.isMediaCheckAutomatic]
   * for more details.
   * Returns: %TRUE if drive has media, %FALSE otherwise.
   */
  bool hasMedia();

  /**
   * Check if drive has any mountable volumes.
   * Returns: %TRUE if the drive contains volumes, %FALSE otherwise.
   */
  bool hasVolumes();

  /**
   * Checks if drive is capable of automatically detecting media changes.
   * Returns: %TRUE if the drive is capable of automatically detecting
   *   media changes, %FALSE otherwise.
   */
  bool isMediaCheckAutomatic();

  /**
   * Checks if the drive supports removable media.
   * Returns: %TRUE if drive supports removable media, %FALSE otherwise.
   */
  bool isMediaRemovable();

  /**
   * Checks if the #GDrive and/or its media is considered removable by the user.
   * See [Gio.Drive.isMediaRemovable].
   * Returns: %TRUE if drive and/or its media is considered removable, %FALSE otherwise.
   */
  bool isRemovable();

  /**
   * Asynchronously polls drive to see if media has been inserted or removed.
   * When the operation is finished, callback will be called.
   * You can then call [Gio.Drive.pollForMediaFinish] to obtain the
   * result of the operation.
   * Params:
   *   cancellable = optional #GCancellable object, %NULL to ignore.
   *   callback = a #GAsyncReadyCallback, or %NULL.
   */
  void pollForMedia(Cancellable cancellable, AsyncReadyCallback callback);

  /**
   * Finishes an operation started with [Gio.Drive.pollForMedia] on a drive.
   * Params:
   *   result = a #GAsyncResult.
   * Returns: %TRUE if the drive has been poll_for_mediaed successfully,
   *   %FALSE otherwise.
   */
  bool pollForMediaFinish(AsyncResult result);

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
  void start(DriveStartFlags flags, MountOperation mountOperation, Cancellable cancellable, AsyncReadyCallback callback);

  /**
   * Finishes starting a drive.
   * Params:
   *   result = a #GAsyncResult.
   * Returns: %TRUE if the drive has been started successfully,
   *   %FALSE otherwise.
   */
  bool startFinish(AsyncResult result);

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
  void stop(MountUnmountFlags flags, MountOperation mountOperation, Cancellable cancellable, AsyncReadyCallback callback);

  /**
   * Finishes stopping a drive.
   * Params:
   *   result = a #GAsyncResult.
   * Returns: %TRUE if the drive has been stopped successfully,
   *   %FALSE otherwise.
   */
  bool stopFinish(AsyncResult result);

  /**
   * Emitted when the drive's state has changed.
   *   drive = the instance the signal is connected to
   */
  alias ChangedCallback = void delegate(Drive drive);

  /**
   * Connect to Changed signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectChanged(ChangedCallback dlg, Flag!"After" after = No.After);

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
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectDisconnected(DisconnectedCallback dlg, Flag!"After" after = No.After);

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
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectEjectButton(EjectButtonCallback dlg, Flag!"After" after = No.After);

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
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectStopButton(StopButtonCallback dlg, Flag!"After" after = No.After);
}
