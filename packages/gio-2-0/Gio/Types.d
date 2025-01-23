module Gio.Types;

import GLib.ErrorG;
import GLib.Types;
import GLib.VariantG;
import GLib.VariantType;
import GObject.ObjectG;
import GObject.Types;
import GObject.Value;
import Gid.gid;
import Gio.AsyncResult;
import Gio.AsyncResultT;
import Gio.Cancellable;
import Gio.DBusConnection;
import Gio.DBusInterfaceInfo;
import Gio.DBusMessage;
import Gio.DBusMethodInvocation;
import Gio.DBusObjectManagerClient;
import Gio.DatagramBased;
import Gio.DatagramBasedT;
import Gio.DesktopAppInfo;
import Gio.File;
import Gio.FileT;
import Gio.IOSchedulerJob;
import Gio.SimpleAsyncResult;
import Gio.Socket;
import Gio.Task;
import Gio.Vfs;
import Gio.c.functions;
import Gio.c.types;


// Enums
alias AppInfoCreateFlags = GAppInfoCreateFlags;
alias ApplicationFlags = GApplicationFlags;
alias AskPasswordFlags = GAskPasswordFlags;
alias BusNameOwnerFlags = GBusNameOwnerFlags;
alias BusNameWatcherFlags = GBusNameWatcherFlags;
alias BusType = GBusType;
alias ConverterFlags = GConverterFlags;
alias ConverterResult = GConverterResult;
alias CredentialsType = GCredentialsType;
alias DBusCallFlags = GDBusCallFlags;
alias DBusCapabilityFlags = GDBusCapabilityFlags;
alias DBusConnectionFlags = GDBusConnectionFlags;
alias DBusError = GDBusError;
alias DBusInterfaceSkeletonFlags = GDBusInterfaceSkeletonFlags;
alias DBusMessageByteOrder = GDBusMessageByteOrder;
alias DBusMessageFlags = GDBusMessageFlags;
alias DBusMessageHeaderField = GDBusMessageHeaderField;
alias DBusMessageType = GDBusMessageType;
alias DBusObjectManagerClientFlags = GDBusObjectManagerClientFlags;
alias DBusPropertyInfoFlags = GDBusPropertyInfoFlags;
alias DBusProxyFlags = GDBusProxyFlags;
alias DBusSendMessageFlags = GDBusSendMessageFlags;
alias DBusServerFlags = GDBusServerFlags;
alias DBusSignalFlags = GDBusSignalFlags;
alias DBusSubtreeFlags = GDBusSubtreeFlags;
alias DataStreamByteOrder = GDataStreamByteOrder;
alias DataStreamNewlineType = GDataStreamNewlineType;
alias DriveStartFlags = GDriveStartFlags;
alias DriveStartStopType = GDriveStartStopType;
alias EmblemOrigin = GEmblemOrigin;
alias FileAttributeInfoFlags = GFileAttributeInfoFlags;
alias FileAttributeStatus = GFileAttributeStatus;
alias FileAttributeType = GFileAttributeType;
alias FileCopyFlags = GFileCopyFlags;
alias FileCreateFlags = GFileCreateFlags;
alias FileMeasureFlags = GFileMeasureFlags;
alias FileMonitorEvent = GFileMonitorEvent;
alias FileMonitorFlags = GFileMonitorFlags;
alias FileQueryInfoFlags = GFileQueryInfoFlags;
alias FileType = GFileType;
alias FilesystemPreviewType = GFilesystemPreviewType;
alias IOErrorEnum = GIOErrorEnum;
alias IOModuleScopeFlags = GIOModuleScopeFlags;
alias IOStreamSpliceFlags = GIOStreamSpliceFlags;
alias MemoryMonitorWarningLevel = GMemoryMonitorWarningLevel;
alias MountMountFlags = GMountMountFlags;
alias MountOperationResult = GMountOperationResult;
alias MountUnmountFlags = GMountUnmountFlags;
alias NetworkConnectivity = GNetworkConnectivity;
alias NotificationPriority = GNotificationPriority;
alias OutputStreamSpliceFlags = GOutputStreamSpliceFlags;
alias PasswordSave = GPasswordSave;
alias PollableReturn = GPollableReturn;
alias ResolverError = GResolverError;
alias ResolverNameLookupFlags = GResolverNameLookupFlags;
alias ResolverRecordType = GResolverRecordType;
alias ResourceError = GResourceError;
alias ResourceFlags = GResourceFlags;
alias ResourceLookupFlags = GResourceLookupFlags;
alias SettingsBindFlags = GSettingsBindFlags;
alias SocketClientEvent = GSocketClientEvent;
alias SocketFamily = GSocketFamily;
alias SocketListenerEvent = GSocketListenerEvent;
alias SocketMsgFlags = GSocketMsgFlags;
alias SocketProtocol = GSocketProtocol;
alias SocketType = GSocketType;
alias SubprocessFlags = GSubprocessFlags;
alias TestDBusFlags = GTestDBusFlags;
alias TlsAuthenticationMode = GTlsAuthenticationMode;
alias TlsCertificateFlags = GTlsCertificateFlags;
alias TlsCertificateRequestFlags = GTlsCertificateRequestFlags;
alias TlsChannelBindingError = GTlsChannelBindingError;
alias TlsChannelBindingType = GTlsChannelBindingType;
alias TlsDatabaseLookupFlags = GTlsDatabaseLookupFlags;
alias TlsDatabaseVerifyFlags = GTlsDatabaseVerifyFlags;
alias TlsError = GTlsError;
alias TlsInteractionResult = GTlsInteractionResult;
alias TlsPasswordFlags = GTlsPasswordFlags;
alias TlsProtocolVersion = GTlsProtocolVersion;
alias TlsRehandshakeMode = GTlsRehandshakeMode;
alias UnixSocketAddressType = GUnixSocketAddressType;
alias ZlibCompressorFormat = GZlibCompressorFormat;

// Structs
alias AppLaunchContextPrivate = GAppLaunchContextPrivate*;
alias ApplicationCommandLinePrivate = GApplicationCommandLinePrivate*;
alias ApplicationPrivate = GApplicationPrivate*;
alias BufferedInputStreamPrivate = GBufferedInputStreamPrivate*;
alias BufferedOutputStreamPrivate = GBufferedOutputStreamPrivate*;
alias CancellablePrivate = GCancellablePrivate*;
alias ConverterInputStreamPrivate = GConverterInputStreamPrivate*;
alias ConverterOutputStreamPrivate = GConverterOutputStreamPrivate*;
alias CredentialsClass = GCredentialsClass*;
alias DBusInterfaceSkeletonPrivate = GDBusInterfaceSkeletonPrivate*;
alias DBusInterfaceVTable = GDBusInterfaceVTable;
alias DBusObjectManagerClientPrivate = GDBusObjectManagerClientPrivate*;
alias DBusObjectManagerServerPrivate = GDBusObjectManagerServerPrivate*;
alias DBusObjectProxyPrivate = GDBusObjectProxyPrivate*;
alias DBusObjectSkeletonPrivate = GDBusObjectSkeletonPrivate*;
alias DBusProxyPrivate = GDBusProxyPrivate*;
alias DBusSubtreeVTable = GDBusSubtreeVTable;
alias DataInputStreamPrivate = GDataInputStreamPrivate*;
alias DataOutputStreamPrivate = GDataOutputStreamPrivate*;
alias EmblemClass = GEmblemClass*;
alias EmblemedIconPrivate = GEmblemedIconPrivate*;
alias FileEnumeratorPrivate = GFileEnumeratorPrivate*;
alias FileIOStreamPrivate = GFileIOStreamPrivate*;
alias FileIconClass = GFileIconClass*;
alias FileInfoClass = GFileInfoClass*;
alias FileInputStreamPrivate = GFileInputStreamPrivate*;
alias FileMonitorPrivate = GFileMonitorPrivate*;
alias FileOutputStreamPrivate = GFileOutputStreamPrivate*;
alias IOModuleClass = GIOModuleClass*;
alias IOStreamAdapter = GIOStreamAdapter*;
alias IOStreamPrivate = GIOStreamPrivate*;
alias InetAddressMaskPrivate = GInetAddressMaskPrivate*;
alias InetAddressPrivate = GInetAddressPrivate*;
alias InetSocketAddressPrivate = GInetSocketAddressPrivate*;
alias InputStreamPrivate = GInputStreamPrivate*;
alias InputVector = GInputVector;
alias MemoryInputStreamPrivate = GMemoryInputStreamPrivate*;
alias MemoryOutputStreamPrivate = GMemoryOutputStreamPrivate*;
alias MenuAttributeIterPrivate = GMenuAttributeIterPrivate*;
alias MenuLinkIterPrivate = GMenuLinkIterPrivate*;
alias MenuModelPrivate = GMenuModelPrivate*;
alias MountOperationPrivate = GMountOperationPrivate*;
alias NativeSocketAddressPrivate = GNativeSocketAddressPrivate*;
alias NetworkAddressPrivate = GNetworkAddressPrivate*;
alias NetworkServicePrivate = GNetworkServicePrivate*;
alias OutputStreamPrivate = GOutputStreamPrivate*;
alias OutputVector = GOutputVector;
alias PermissionPrivate = GPermissionPrivate*;
alias ProxyAddressEnumeratorPrivate = GProxyAddressEnumeratorPrivate*;
alias ProxyAddressPrivate = GProxyAddressPrivate*;
alias ResolverPrivate = GResolverPrivate*;
alias SettingsBackendPrivate = GSettingsBackendPrivate*;
alias SettingsPrivate = GSettingsPrivate*;
alias SimpleActionGroupPrivate = GSimpleActionGroupPrivate*;
alias SimpleAsyncResultClass = GSimpleAsyncResultClass*;
alias SimpleProxyResolverPrivate = GSimpleProxyResolverPrivate*;
alias SocketClientPrivate = GSocketClientPrivate*;
alias SocketConnectionPrivate = GSocketConnectionPrivate*;
alias SocketControlMessagePrivate = GSocketControlMessagePrivate*;
alias SocketListenerPrivate = GSocketListenerPrivate*;
alias SocketPrivate = GSocketPrivate*;
alias SocketServicePrivate = GSocketServicePrivate*;
alias TaskClass = GTaskClass*;
alias TcpConnectionPrivate = GTcpConnectionPrivate*;
alias TcpWrapperConnectionPrivate = GTcpWrapperConnectionPrivate*;
alias ThemedIconClass = GThemedIconClass*;
alias ThreadedSocketServicePrivate = GThreadedSocketServicePrivate*;
alias TlsCertificatePrivate = GTlsCertificatePrivate*;
alias TlsConnectionPrivate = GTlsConnectionPrivate*;
alias TlsDatabasePrivate = GTlsDatabasePrivate*;
alias TlsInteractionPrivate = GTlsInteractionPrivate*;
alias TlsPasswordPrivate = GTlsPasswordPrivate*;
alias UnixConnectionPrivate = GUnixConnectionPrivate*;
alias UnixCredentialsMessagePrivate = GUnixCredentialsMessagePrivate*;
alias UnixFDListPrivate = GUnixFDListPrivate*;
alias UnixFDMessagePrivate = GUnixFDMessagePrivate*;
alias UnixInputStreamPrivate = GUnixInputStreamPrivate*;
alias UnixMountMonitorClass = GUnixMountMonitorClass*;
alias UnixOutputStreamPrivate = GUnixOutputStreamPrivate*;
alias UnixSocketAddressPrivate = GUnixSocketAddressPrivate*;

// Callbacks
alias AsyncReadyCallback = void delegate(ObjectG sourceObject, AsyncResult res);
alias BusAcquiredCallback = void delegate(DBusConnection connection, string name);
alias BusNameAcquiredCallback = void delegate(DBusConnection connection, string name);
alias BusNameAppearedCallback = void delegate(DBusConnection connection, string name, string nameOwner);
alias BusNameLostCallback = void delegate(DBusConnection connection, string name);
alias BusNameVanishedCallback = void delegate(DBusConnection connection, string name);
alias CancellableSourceFunc = bool delegate(Cancellable cancellable);
alias DBusInterfaceGetPropertyFunc = VariantG delegate(DBusConnection connection, string sender, string objectPath, string interfaceName, string propertyName, ErrorG error);
alias DBusInterfaceMethodCallFunc = void delegate(DBusConnection connection, string sender, string objectPath, string interfaceName, string methodName, VariantG parameters, DBusMethodInvocation invocation);
alias DBusInterfaceSetPropertyFunc = bool delegate(DBusConnection connection, string sender, string objectPath, string interfaceName, string propertyName, VariantG value, ErrorG error);
alias DBusMessageFilterFunction = DBusMessage delegate(DBusConnection connection, DBusMessage message, bool incoming);
alias DBusProxyTypeFunc = GType delegate(DBusObjectManagerClient manager, string objectPath, string interfaceName);
alias DBusSignalCallback = void delegate(DBusConnection connection, string senderName, string objectPath, string interfaceName, string signalName, VariantG parameters);
alias DBusSubtreeDispatchFunc = DBusInterfaceVTable delegate(DBusConnection connection, string sender, string objectPath, string interfaceName, string node, out void* outUserData);
alias DBusSubtreeEnumerateFunc = string[] delegate(DBusConnection connection, string sender, string objectPath);
alias DBusSubtreeIntrospectFunc = DBusInterfaceInfo[] delegate(DBusConnection connection, string sender, string objectPath, string node);
alias DatagramBasedSourceFunc = bool delegate(DatagramBased datagramBased, IOCondition condition);
alias DesktopAppLaunchCallback = void delegate(DesktopAppInfo appinfo, Pid pid);
alias FileMeasureProgressCallback = void delegate(bool reporting, ulong currentSize, ulong numDirs, ulong numFiles);
alias FileProgressCallback = void delegate(long currentNumBytes, long totalNumBytes);
alias FileReadMoreCallback = bool delegate(string fileContents, long fileSize);
alias IOSchedulerJobFunc = bool delegate(IOSchedulerJob job, Cancellable cancellable);
alias PollableSourceFunc = bool delegate(ObjectG pollableStream);
alias ReallocFunc = void* delegate(size_t size);
alias SettingsBindGetMapping = bool delegate(Value value, VariantG variant);
alias SettingsBindSetMapping = VariantG delegate(Value value, VariantType expectedType);
alias SettingsGetMapping = bool delegate(VariantG value, out void* result);
alias SimpleAsyncThreadFunc = void delegate(SimpleAsyncResult res, ObjectG object, Cancellable cancellable);
alias SocketSourceFunc = bool delegate(Socket socket, IOCondition condition);
alias TaskThreadFunc = void delegate(Task task, ObjectG sourceObject, Cancellable cancellable);
alias VfsFileLookupFunc = File delegate(Vfs vfs, string identifier);

/**
 * The value returned by handlers of the signals generated by
 * the `gdbus-codegen` tool to indicate that a method call has been
 * handled by an implementation. It is equal to %TRUE, but using
 * this macro is sometimes more readable.
 * In code that needs to be backwards-compatible with older GLib,
 * use %TRUE instead, often written like this:
 * |[
 * g_dbus_method_invocation_return_error $(LPAREN)invocation, ...$(RPAREN);
 * return TRUE;    // handled
 * ]|
 */
enum DBUS_METHOD_INVOCATION_HANDLED = true;


/**
 * The value returned by handlers of the signals generated by
 * the `gdbus-codegen` tool to indicate that a method call has not been
 * handled by an implementation. It is equal to %FALSE, but using
 * this macro is sometimes more readable.
 * In code that needs to be backwards-compatible with older GLib,
 * use %FALSE instead.
 */
enum DBUS_METHOD_INVOCATION_UNHANDLED = false;


/**
 * Extension point for debug control functionality.
 * See [Extending GIO][extending-gio].
 */
enum DEBUG_CONTROLLER_EXTENSION_POINT_NAME = "gio-debug-controller";


/**
 * Extension point for default handler to URI association. See
 * [Extending GIO][extending-gio].

 * Deprecated: The #GDesktopAppInfoLookup interface is deprecated and
 *   unused by GIO.
 */
enum DESKTOP_APP_INFO_LOOKUP_EXTENSION_POINT_NAME = "gio-desktop-app-info-lookup";


/**
 * The string used to obtain a Unix device path with [Gio.Drive.getIdentifier].
 */
enum DRIVE_IDENTIFIER_KIND_UNIX_DEVICE = "unix-device";


/**
 * A key in the "access" namespace for checking deletion privileges.
 * Corresponding #GFileAttributeType is %G_FILE_ATTRIBUTE_TYPE_BOOLEAN.
 * This attribute will be %TRUE if the user is able to delete the file.
 */
enum FILE_ATTRIBUTE_ACCESS_CAN_DELETE = "access::can-delete";


/**
 * A key in the "access" namespace for getting execution privileges.
 * Corresponding #GFileAttributeType is %G_FILE_ATTRIBUTE_TYPE_BOOLEAN.
 * This attribute will be %TRUE if the user is able to execute the file.
 */
enum FILE_ATTRIBUTE_ACCESS_CAN_EXECUTE = "access::can-execute";


/**
 * A key in the "access" namespace for getting read privileges.
 * Corresponding #GFileAttributeType is %G_FILE_ATTRIBUTE_TYPE_BOOLEAN.
 * This attribute will be %TRUE if the user is able to read the file.
 */
enum FILE_ATTRIBUTE_ACCESS_CAN_READ = "access::can-read";


/**
 * A key in the "access" namespace for checking renaming privileges.
 * Corresponding #GFileAttributeType is %G_FILE_ATTRIBUTE_TYPE_BOOLEAN.
 * This attribute will be %TRUE if the user is able to rename the file.
 */
enum FILE_ATTRIBUTE_ACCESS_CAN_RENAME = "access::can-rename";


/**
 * A key in the "access" namespace for checking trashing privileges.
 * Corresponding #GFileAttributeType is %G_FILE_ATTRIBUTE_TYPE_BOOLEAN.
 * This attribute will be %TRUE if the user is able to move the file to
 * the trash.
 */
enum FILE_ATTRIBUTE_ACCESS_CAN_TRASH = "access::can-trash";


/**
 * A key in the "access" namespace for getting write privileges.
 * Corresponding #GFileAttributeType is %G_FILE_ATTRIBUTE_TYPE_BOOLEAN.
 * This attribute will be %TRUE if the user is able to write to the file.
 */
enum FILE_ATTRIBUTE_ACCESS_CAN_WRITE = "access::can-write";


/**
 * A key in the "dos" namespace for checking if the file's archive flag
 * is set.
 * This attribute is %TRUE if the archive flag is set.
 * This attribute is only available for DOS file systems.
 * Corresponding #GFileAttributeType is %G_FILE_ATTRIBUTE_TYPE_BOOLEAN.
 */
enum FILE_ATTRIBUTE_DOS_IS_ARCHIVE = "dos::is-archive";


/**
 * A key in the "dos" namespace for checking if the file is a NTFS mount point
 * $(LPAREN)a volume mount or a junction point$(RPAREN).
 * This attribute is %TRUE if file is a reparse point of type
 * [IO_REPARSE_TAG_MOUNT_POINT](https://msdn.microsoft.com/en-us/library/dd541667.aspx).
 * This attribute is only available for DOS file systems.
 * Corresponding #GFileAttributeType is %G_FILE_ATTRIBUTE_TYPE_BOOLEAN.
 */
enum FILE_ATTRIBUTE_DOS_IS_MOUNTPOINT = "dos::is-mountpoint";


/**
 * A key in the "dos" namespace for checking if the file's backup flag
 * is set.
 * This attribute is %TRUE if the backup flag is set.
 * This attribute is only available for DOS file systems.
 * Corresponding #GFileAttributeType is %G_FILE_ATTRIBUTE_TYPE_BOOLEAN.
 */
enum FILE_ATTRIBUTE_DOS_IS_SYSTEM = "dos::is-system";


/**
 * A key in the "dos" namespace for getting the file NTFS reparse tag.
 * This value is 0 for files that are not reparse points.
 * See the [Reparse Tags](https://msdn.microsoft.com/en-us/library/dd541667.aspx)
 * page for possible reparse tag values.
 * Corresponding #GFileAttributeType is %G_FILE_ATTRIBUTE_TYPE_UINT32.
 */
enum FILE_ATTRIBUTE_DOS_REPARSE_POINT_TAG = "dos::reparse-point-tag";


/**
 * A key in the "etag" namespace for getting the value of the file's
 * entity tag.
 * Corresponding #GFileAttributeType is %G_FILE_ATTRIBUTE_TYPE_STRING.
 */
enum FILE_ATTRIBUTE_ETAG_VALUE = "etag::value";


/**
 * A key in the "filesystem" namespace for getting the number of bytes
 * of free space left on the file system.
 * Corresponding #GFileAttributeType is %G_FILE_ATTRIBUTE_TYPE_UINT64.
 */
enum FILE_ATTRIBUTE_FILESYSTEM_FREE = "filesystem::free";


/**
 * A key in the "filesystem" namespace for checking if the file system
 * is read only.
 * Is set to %TRUE if the file system is read only.
 * Corresponding #GFileAttributeType is %G_FILE_ATTRIBUTE_TYPE_BOOLEAN.
 */
enum FILE_ATTRIBUTE_FILESYSTEM_READONLY = "filesystem::readonly";


/**
 * A key in the "filesystem" namespace for checking if the file system
 * is remote.
 * Is set to %TRUE if the file system is remote.
 * Corresponding #GFileAttributeType is %G_FILE_ATTRIBUTE_TYPE_BOOLEAN.
 */
enum FILE_ATTRIBUTE_FILESYSTEM_REMOTE = "filesystem::remote";


/**
 * A key in the "filesystem" namespace for getting the total size $(LPAREN)in
 * bytes$(RPAREN) of the file system, used in [Gio.File.queryFilesystemInfo].
 * Corresponding #GFileAttributeType is %G_FILE_ATTRIBUTE_TYPE_UINT64.
 */
enum FILE_ATTRIBUTE_FILESYSTEM_SIZE = "filesystem::size";


/**
 * A key in the "filesystem" namespace for getting the file system's type.
 * Corresponding #GFileAttributeType is %G_FILE_ATTRIBUTE_TYPE_STRING.
 */
enum FILE_ATTRIBUTE_FILESYSTEM_TYPE = "filesystem::type";


/**
 * A key in the "filesystem" namespace for getting the number of bytes
 * used by data on the file system.
 * Corresponding #GFileAttributeType is %G_FILE_ATTRIBUTE_TYPE_UINT64.
 */
enum FILE_ATTRIBUTE_FILESYSTEM_USED = "filesystem::used";


/**
 * A key in the "filesystem" namespace for hinting a file manager
 * application whether it should preview $(LPAREN)e.g. thumbnail$(RPAREN) files on the
 * file system.
 * The value for this key contain a #GFilesystemPreviewType.
 */
enum FILE_ATTRIBUTE_FILESYSTEM_USE_PREVIEW = "filesystem::use-preview";


/**
 * A key in the "gvfs" namespace that gets the name of the current
 * GVFS backend in use.
 * Corresponding #GFileAttributeType is %G_FILE_ATTRIBUTE_TYPE_STRING.
 */
enum FILE_ATTRIBUTE_GVFS_BACKEND = "gvfs::backend";


/**
 * A key in the "id" namespace for getting a file identifier.
 * Corresponding #GFileAttributeType is %G_FILE_ATTRIBUTE_TYPE_STRING.
 * An example use would be during listing files, to avoid recursive
 * directory scanning.
 */
enum FILE_ATTRIBUTE_ID_FILE = "id::file";


/**
 * A key in the "id" namespace for getting the file system identifier.
 * Corresponding #GFileAttributeType is %G_FILE_ATTRIBUTE_TYPE_STRING.
 * An example use would be during drag and drop to see if the source
 * and target are on the same filesystem $(LPAREN)default to move$(RPAREN) or not $(LPAREN)default
 * to copy$(RPAREN).
 */
enum FILE_ATTRIBUTE_ID_FILESYSTEM = "id::filesystem";


/**
 * A key in the "mountable" namespace for checking if a file $(LPAREN)of
 * type G_FILE_TYPE_MOUNTABLE$(RPAREN) can be ejected.
 * Corresponding #GFileAttributeType is %G_FILE_ATTRIBUTE_TYPE_BOOLEAN.
 */
enum FILE_ATTRIBUTE_MOUNTABLE_CAN_EJECT = "mountable::can-eject";


/**
 * A key in the "mountable" namespace for checking if a file $(LPAREN)of
 * type G_FILE_TYPE_MOUNTABLE$(RPAREN) is mountable.
 * Corresponding #GFileAttributeType is %G_FILE_ATTRIBUTE_TYPE_BOOLEAN.
 */
enum FILE_ATTRIBUTE_MOUNTABLE_CAN_MOUNT = "mountable::can-mount";


/**
 * A key in the "mountable" namespace for checking if a file $(LPAREN)of
 * type G_FILE_TYPE_MOUNTABLE$(RPAREN) can be polled.
 * Corresponding #GFileAttributeType is %G_FILE_ATTRIBUTE_TYPE_BOOLEAN.
 */
enum FILE_ATTRIBUTE_MOUNTABLE_CAN_POLL = "mountable::can-poll";


/**
 * A key in the "mountable" namespace for checking if a file $(LPAREN)of
 * type G_FILE_TYPE_MOUNTABLE$(RPAREN) can be started.
 * Corresponding #GFileAttributeType is %G_FILE_ATTRIBUTE_TYPE_BOOLEAN.
 */
enum FILE_ATTRIBUTE_MOUNTABLE_CAN_START = "mountable::can-start";


/**
 * A key in the "mountable" namespace for checking if a file $(LPAREN)of
 * type G_FILE_TYPE_MOUNTABLE$(RPAREN) can be started degraded.
 * Corresponding #GFileAttributeType is %G_FILE_ATTRIBUTE_TYPE_BOOLEAN.
 */
enum FILE_ATTRIBUTE_MOUNTABLE_CAN_START_DEGRADED = "mountable::can-start-degraded";


/**
 * A key in the "mountable" namespace for checking if a file $(LPAREN)of
 * type G_FILE_TYPE_MOUNTABLE$(RPAREN) can be stopped.
 * Corresponding #GFileAttributeType is %G_FILE_ATTRIBUTE_TYPE_BOOLEAN.
 */
enum FILE_ATTRIBUTE_MOUNTABLE_CAN_STOP = "mountable::can-stop";


/**
 * A key in the "mountable" namespace for checking if a file $(LPAREN)of
 * type G_FILE_TYPE_MOUNTABLE$(RPAREN)  is unmountable.
 * Corresponding #GFileAttributeType is %G_FILE_ATTRIBUTE_TYPE_BOOLEAN.
 */
enum FILE_ATTRIBUTE_MOUNTABLE_CAN_UNMOUNT = "mountable::can-unmount";


/**
 * A key in the "mountable" namespace for getting the HAL UDI for the mountable
 * file.
 * Corresponding #GFileAttributeType is %G_FILE_ATTRIBUTE_TYPE_STRING.
 */
enum FILE_ATTRIBUTE_MOUNTABLE_HAL_UDI = "mountable::hal-udi";


/**
 * A key in the "mountable" namespace for checking if a file $(LPAREN)of
 * type G_FILE_TYPE_MOUNTABLE$(RPAREN) is automatically polled for media.
 * Corresponding #GFileAttributeType is %G_FILE_ATTRIBUTE_TYPE_BOOLEAN.
 */
enum FILE_ATTRIBUTE_MOUNTABLE_IS_MEDIA_CHECK_AUTOMATIC = "mountable::is-media-check-automatic";


/**
 * A key in the "mountable" namespace for getting the #GDriveStartStopType.
 * Corresponding #GFileAttributeType is %G_FILE_ATTRIBUTE_TYPE_UINT32.
 */
enum FILE_ATTRIBUTE_MOUNTABLE_START_STOP_TYPE = "mountable::start-stop-type";


/**
 * A key in the "mountable" namespace for getting the unix device.
 * Corresponding #GFileAttributeType is %G_FILE_ATTRIBUTE_TYPE_UINT32.
 */
enum FILE_ATTRIBUTE_MOUNTABLE_UNIX_DEVICE = "mountable::unix-device";


/**
 * A key in the "mountable" namespace for getting the unix device file.
 * Corresponding #GFileAttributeType is %G_FILE_ATTRIBUTE_TYPE_STRING.
 */
enum FILE_ATTRIBUTE_MOUNTABLE_UNIX_DEVICE_FILE = "mountable::unix-device-file";


/**
 * A key in the "owner" namespace for getting the file owner's group.
 * Corresponding #GFileAttributeType is %G_FILE_ATTRIBUTE_TYPE_STRING.
 */
enum FILE_ATTRIBUTE_OWNER_GROUP = "owner::group";


/**
 * A key in the "owner" namespace for getting the user name of the
 * file's owner.
 * Corresponding #GFileAttributeType is %G_FILE_ATTRIBUTE_TYPE_STRING.
 */
enum FILE_ATTRIBUTE_OWNER_USER = "owner::user";


/**
 * A key in the "owner" namespace for getting the real name of the
 * user that owns the file.
 * Corresponding #GFileAttributeType is %G_FILE_ATTRIBUTE_TYPE_STRING.
 */
enum FILE_ATTRIBUTE_OWNER_USER_REAL = "owner::user-real";


/**
 * A key in the "preview" namespace for getting a #GIcon that can be
 * used to get preview of the file.
 * For example, it may be a low resolution thumbnail without metadata.
 * Corresponding #GFileAttributeType is %G_FILE_ATTRIBUTE_TYPE_OBJECT.
 * The value for this key should contain a #GIcon.
 */
enum FILE_ATTRIBUTE_PREVIEW_ICON = "preview::icon";


/**
 * A key in the "recent" namespace for getting time, when the metadata for the
 * file in `recent:///` was last changed.
 * Corresponding #GFileAttributeType is %G_FILE_ATTRIBUTE_TYPE_INT64.
 */
enum FILE_ATTRIBUTE_RECENT_MODIFIED = "recent::modified";


/**
 * A key in the "selinux" namespace for getting the file's SELinux
 * context.
 * Corresponding #GFileAttributeType is %G_FILE_ATTRIBUTE_TYPE_STRING.
 * Note that this attribute is only available if GLib has been built
 * with SELinux support.
 */
enum FILE_ATTRIBUTE_SELINUX_CONTEXT = "selinux::context";


/**
 * A key in the "standard" namespace for getting the amount of disk space
 * that is consumed by the file $(LPAREN)in bytes$(RPAREN).
 * This will generally be larger than the file size $(LPAREN)due to block size
 * overhead$(RPAREN) but can occasionally be smaller $(LPAREN)for example, for sparse files$(RPAREN).
 * Corresponding #GFileAttributeType is %G_FILE_ATTRIBUTE_TYPE_UINT64.
 */
enum FILE_ATTRIBUTE_STANDARD_ALLOCATED_SIZE = "standard::allocated-size";


/**
 * A key in the "standard" namespace for getting the content type of the file.
 * Corresponding #GFileAttributeType is %G_FILE_ATTRIBUTE_TYPE_STRING.
 * The value for this key should contain a valid content type.
 */
enum FILE_ATTRIBUTE_STANDARD_CONTENT_TYPE = "standard::content-type";


/**
 * A key in the "standard" namespace for getting the copy name of the file.
 * The copy name is an optional version of the name. If available it's always
 * in UTF8, and corresponds directly to the original filename $(LPAREN)only transcoded to
 * UTF8$(RPAREN). This is useful if you want to copy the file to another filesystem that
 * might have a different encoding. If the filename is not a valid string in the
 * encoding selected for the filesystem it is in then the copy name will not be set.
 * Corresponding #GFileAttributeType is %G_FILE_ATTRIBUTE_TYPE_STRING.
 */
enum FILE_ATTRIBUTE_STANDARD_COPY_NAME = "standard::copy-name";


/**
 * A key in the "standard" namespace for getting the description of the file.
 * The description is a utf8 string that describes the file, generally containing
 * the filename, but can also contain further information. Example descriptions
 * could be "filename $(LPAREN)on hostname$(RPAREN)" for a remote file or "filename $(LPAREN)in trash$(RPAREN)"
 * for a file in the trash. This is useful for instance as the window title
 * when displaying a directory or for a bookmarks menu.
 * Corresponding #GFileAttributeType is %G_FILE_ATTRIBUTE_TYPE_STRING.
 */
enum FILE_ATTRIBUTE_STANDARD_DESCRIPTION = "standard::description";


/**
 * A key in the "standard" namespace for getting the display name of the file.
 * A display name is guaranteed to be in UTF-8 and can thus be displayed in
 * the UI. It is guaranteed to be set on every file.
 * Corresponding #GFileAttributeType is %G_FILE_ATTRIBUTE_TYPE_STRING.
 */
enum FILE_ATTRIBUTE_STANDARD_DISPLAY_NAME = "standard::display-name";


/**
 * A key in the "standard" namespace for edit name of the file.
 * An edit name is similar to the display name, but it is meant to be
 * used when you want to rename the file in the UI. The display name
 * might contain information you don't want in the new filename $(LPAREN)such as
 * "$(LPAREN)invalid unicode$(RPAREN)" if the filename was in an invalid encoding$(RPAREN).
 * Corresponding #GFileAttributeType is %G_FILE_ATTRIBUTE_TYPE_STRING.
 */
enum FILE_ATTRIBUTE_STANDARD_EDIT_NAME = "standard::edit-name";


/**
 * A key in the "standard" namespace for getting the fast content type.
 * The fast content type isn't as reliable as the regular one, as it
 * only uses the filename to guess it, but it is faster to calculate than the
 * regular content type.
 * Corresponding #GFileAttributeType is %G_FILE_ATTRIBUTE_TYPE_STRING.
 */
enum FILE_ATTRIBUTE_STANDARD_FAST_CONTENT_TYPE = "standard::fast-content-type";


/**
 * A key in the "standard" namespace for getting the icon for the file.
 * Corresponding #GFileAttributeType is %G_FILE_ATTRIBUTE_TYPE_OBJECT.
 * The value for this key should contain a #GIcon.
 */
enum FILE_ATTRIBUTE_STANDARD_ICON = "standard::icon";


/**
 * A key in the "standard" namespace for checking if a file is a backup file.
 * Corresponding #GFileAttributeType is %G_FILE_ATTRIBUTE_TYPE_BOOLEAN.
 */
enum FILE_ATTRIBUTE_STANDARD_IS_BACKUP = "standard::is-backup";


/**
 * A key in the "standard" namespace for checking if a file is hidden.
 * Corresponding #GFileAttributeType is %G_FILE_ATTRIBUTE_TYPE_BOOLEAN.
 */
enum FILE_ATTRIBUTE_STANDARD_IS_HIDDEN = "standard::is-hidden";


/**
 * A key in the "standard" namespace for checking if the file is a symlink.
 * Typically the actual type is something else, if we followed the symlink
 * to get the type.
 * On Windows NTFS mountpoints are considered to be symlinks as well.
 * Corresponding #GFileAttributeType is %G_FILE_ATTRIBUTE_TYPE_BOOLEAN.
 */
enum FILE_ATTRIBUTE_STANDARD_IS_SYMLINK = "standard::is-symlink";


/**
 * A key in the "standard" namespace for checking if a file is virtual.
 * Corresponding #GFileAttributeType is %G_FILE_ATTRIBUTE_TYPE_BOOLEAN.
 */
enum FILE_ATTRIBUTE_STANDARD_IS_VIRTUAL = "standard::is-virtual";


/**
 * A key in the "standard" namespace for checking if a file is
 * volatile. This is meant for opaque, non-POSIX-like backends to
 * indicate that the URI is not persistent. Applications should look
 * at %G_FILE_ATTRIBUTE_STANDARD_SYMLINK_TARGET for the persistent URI.
 * Corresponding #GFileAttributeType is %G_FILE_ATTRIBUTE_TYPE_BOOLEAN.
 */
enum FILE_ATTRIBUTE_STANDARD_IS_VOLATILE = "standard::is-volatile";


/**
 * A key in the "standard" namespace for getting the name of the file.
 * The name is the on-disk filename which may not be in any known encoding,
 * and can thus not be generally displayed as is. It is guaranteed to be set on
 * every file.
 * Use %G_FILE_ATTRIBUTE_STANDARD_DISPLAY_NAME if you need to display the
 * name in a user interface.
 * Corresponding #GFileAttributeType is %G_FILE_ATTRIBUTE_TYPE_BYTE_STRING.
 */
enum FILE_ATTRIBUTE_STANDARD_NAME = "standard::name";


/**
 * A key in the "standard" namespace for getting the file's size $(LPAREN)in bytes$(RPAREN).
 * Corresponding #GFileAttributeType is %G_FILE_ATTRIBUTE_TYPE_UINT64.
 */
enum FILE_ATTRIBUTE_STANDARD_SIZE = "standard::size";


/**
 * A key in the "standard" namespace for setting the sort order of a file.
 * Corresponding #GFileAttributeType is %G_FILE_ATTRIBUTE_TYPE_INT32.
 * An example use would be in file managers, which would use this key
 * to set the order files are displayed. Files with smaller sort order
 * should be sorted first, and files without sort order as if sort order
 * was zero.
 */
enum FILE_ATTRIBUTE_STANDARD_SORT_ORDER = "standard::sort-order";


/**
 * A key in the "standard" namespace for getting the symbolic icon for the file.
 * Corresponding #GFileAttributeType is %G_FILE_ATTRIBUTE_TYPE_OBJECT.
 * The value for this key should contain a #GIcon.
 */
enum FILE_ATTRIBUTE_STANDARD_SYMBOLIC_ICON = "standard::symbolic-icon";


/**
 * A key in the "standard" namespace for getting the symlink target, if the file
 * is a symlink.
 * Corresponding #GFileAttributeType is %G_FILE_ATTRIBUTE_TYPE_BYTE_STRING.
 */
enum FILE_ATTRIBUTE_STANDARD_SYMLINK_TARGET = "standard::symlink-target";


/**
 * A key in the "standard" namespace for getting the target URI for the file, in
 * the case of %G_FILE_TYPE_SHORTCUT or %G_FILE_TYPE_MOUNTABLE files.
 * Corresponding #GFileAttributeType is %G_FILE_ATTRIBUTE_TYPE_STRING.
 */
enum FILE_ATTRIBUTE_STANDARD_TARGET_URI = "standard::target-uri";


/**
 * A key in the "standard" namespace for storing file types.
 * Corresponding #GFileAttributeType is %G_FILE_ATTRIBUTE_TYPE_UINT32.
 * The value for this key should contain a #GFileType.
 */
enum FILE_ATTRIBUTE_STANDARD_TYPE = "standard::type";


/**
 * A key in the "thumbnail" namespace for checking if thumbnailing failed.
 * This attribute is %TRUE if thumbnailing failed.
 * Corresponding #GFileAttributeType is %G_FILE_ATTRIBUTE_TYPE_BOOLEAN.
 */
enum FILE_ATTRIBUTE_THUMBNAILING_FAILED = "thumbnail::failed";


/**
 * A key in the "thumbnail" namespace for checking if thumbnailing failed
 * for the large image.
 * This attribute is %TRUE if thumbnailing failed.
 * Corresponding #GFileAttributeType is %G_FILE_ATTRIBUTE_TYPE_BOOLEAN.
 */
enum FILE_ATTRIBUTE_THUMBNAILING_FAILED_LARGE = "thumbnail::failed-large";


/**
 * A key in the "thumbnail" namespace for checking if thumbnailing failed
 * for the normal image.
 * This attribute is %TRUE if thumbnailing failed.
 * Corresponding #GFileAttributeType is %G_FILE_ATTRIBUTE_TYPE_BOOLEAN.
 */
enum FILE_ATTRIBUTE_THUMBNAILING_FAILED_NORMAL = "thumbnail::failed-normal";


/**
 * A key in the "thumbnail" namespace for checking if thumbnailing failed
 * for the x-large image.
 * This attribute is %TRUE if thumbnailing failed.
 * Corresponding #GFileAttributeType is %G_FILE_ATTRIBUTE_TYPE_BOOLEAN.
 */
enum FILE_ATTRIBUTE_THUMBNAILING_FAILED_XLARGE = "thumbnail::failed-xlarge";


/**
 * A key in the "thumbnail" namespace for checking if thumbnailing failed
 * for the xx-large image.
 * This attribute is %TRUE if thumbnailing failed.
 * Corresponding #GFileAttributeType is %G_FILE_ATTRIBUTE_TYPE_BOOLEAN.
 */
enum FILE_ATTRIBUTE_THUMBNAILING_FAILED_XXLARGE = "thumbnail::failed-xxlarge";


/**
 * A key in the "thumbnail" namespace for checking whether the thumbnail is outdated.
 * This attribute is %TRUE if the thumbnail is up-to-date with the file it represents,
 * and %FALSE if the file has been modified since the thumbnail was generated.
 * If %G_FILE_ATTRIBUTE_THUMBNAILING_FAILED is %TRUE and this attribute is %FALSE,
 * it indicates that thumbnailing may be attempted again and may succeed.
 * Corresponding #GFileAttributeType is %G_FILE_ATTRIBUTE_TYPE_BOOLEAN.
 */
enum FILE_ATTRIBUTE_THUMBNAIL_IS_VALID = "thumbnail::is-valid";


/**
 * A key in the "thumbnail" namespace for checking whether the large
 * thumbnail is outdated.
 * This attribute is %TRUE if the large thumbnail is up-to-date with the file
 * it represents, and %FALSE if the file has been modified since the thumbnail
 * was generated.
 * If %G_FILE_ATTRIBUTE_THUMBNAILING_FAILED_LARGE is %TRUE and this attribute
 * is %FALSE, it indicates that thumbnailing may be attempted again and may
 * succeed.
 * Corresponding #GFileAttributeType is %G_FILE_ATTRIBUTE_TYPE_BOOLEAN.
 */
enum FILE_ATTRIBUTE_THUMBNAIL_IS_VALID_LARGE = "thumbnail::is-valid-large";


/**
 * A key in the "thumbnail" namespace for checking whether the normal
 * thumbnail is outdated.
 * This attribute is %TRUE if the normal thumbnail is up-to-date with the file
 * it represents, and %FALSE if the file has been modified since the thumbnail
 * was generated.
 * If %G_FILE_ATTRIBUTE_THUMBNAILING_FAILED_NORMAL is %TRUE and this attribute
 * is %FALSE, it indicates that thumbnailing may be attempted again and may
 * succeed.
 * Corresponding #GFileAttributeType is %G_FILE_ATTRIBUTE_TYPE_BOOLEAN.
 */
enum FILE_ATTRIBUTE_THUMBNAIL_IS_VALID_NORMAL = "thumbnail::is-valid-normal";


/**
 * A key in the "thumbnail" namespace for checking whether the x-large
 * thumbnail is outdated.
 * This attribute is %TRUE if the x-large thumbnail is up-to-date with the file
 * it represents, and %FALSE if the file has been modified since the thumbnail
 * was generated.
 * If %G_FILE_ATTRIBUTE_THUMBNAILING_FAILED_XLARGE is %TRUE and this attribute
 * is %FALSE, it indicates that thumbnailing may be attempted again and may
 * succeed.
 * Corresponding #GFileAttributeType is %G_FILE_ATTRIBUTE_TYPE_BOOLEAN.
 */
enum FILE_ATTRIBUTE_THUMBNAIL_IS_VALID_XLARGE = "thumbnail::is-valid-xlarge";


/**
 * A key in the "thumbnail" namespace for checking whether the xx-large
 * thumbnail is outdated.
 * This attribute is %TRUE if the x-large thumbnail is up-to-date with the file
 * it represents, and %FALSE if the file has been modified since the thumbnail
 * was generated.
 * If %G_FILE_ATTRIBUTE_THUMBNAILING_FAILED_XXLARGE is %TRUE and this attribute
 * is %FALSE, it indicates that thumbnailing may be attempted again and may
 * succeed.
 * Corresponding #GFileAttributeType is %G_FILE_ATTRIBUTE_TYPE_BOOLEAN.
 */
enum FILE_ATTRIBUTE_THUMBNAIL_IS_VALID_XXLARGE = "thumbnail::is-valid-xxlarge";


/**
 * A key in the "thumbnail" namespace for getting the path to the thumbnail
 * image with the biggest size available.
 * Corresponding #GFileAttributeType is %G_FILE_ATTRIBUTE_TYPE_BYTE_STRING.
 */
enum FILE_ATTRIBUTE_THUMBNAIL_PATH = "thumbnail::path";


/**
 * A key in the "thumbnail" namespace for getting the path to the large
 * thumbnail image.
 * Corresponding #GFileAttributeType is %G_FILE_ATTRIBUTE_TYPE_BYTE_STRING.
 */
enum FILE_ATTRIBUTE_THUMBNAIL_PATH_LARGE = "thumbnail::path-large";


/**
 * A key in the "thumbnail" namespace for getting the path to the normal
 * thumbnail image.
 * Corresponding #GFileAttributeType is %G_FILE_ATTRIBUTE_TYPE_BYTE_STRING.
 */
enum FILE_ATTRIBUTE_THUMBNAIL_PATH_NORMAL = "thumbnail::path-normal";


/**
 * A key in the "thumbnail" namespace for getting the path to the x-large
 * thumbnail image.
 * Corresponding #GFileAttributeType is %G_FILE_ATTRIBUTE_TYPE_BYTE_STRING.
 */
enum FILE_ATTRIBUTE_THUMBNAIL_PATH_XLARGE = "thumbnail::path-xlarge";


/**
 * A key in the "thumbnail" namespace for getting the path to the xx-large
 * thumbnail image.
 * Corresponding #GFileAttributeType is %G_FILE_ATTRIBUTE_TYPE_BYTE_STRING.
 */
enum FILE_ATTRIBUTE_THUMBNAIL_PATH_XXLARGE = "thumbnail::path-xxlarge";


/**
 * A key in the "time" namespace for getting the time the file was last
 * accessed.
 * Corresponding #GFileAttributeType is %G_FILE_ATTRIBUTE_TYPE_UINT64, and
 * contains the time since the file was last accessed, in seconds since the
 * UNIX epoch.
 */
enum FILE_ATTRIBUTE_TIME_ACCESS = "time::access";


/**
 * A key in the "time" namespace for getting the nanoseconds of the time
 * the file was last accessed. This should be used in conjunction with
 * #G_FILE_ATTRIBUTE_TIME_ACCESS. Corresponding #GFileAttributeType is
 * %G_FILE_ATTRIBUTE_TYPE_UINT32.
 */
enum FILE_ATTRIBUTE_TIME_ACCESS_NSEC = "time::access-nsec";


/**
 * A key in the "time" namespace for getting the microseconds of the time
 * the file was last accessed.
 * This should be used in conjunction with %G_FILE_ATTRIBUTE_TIME_ACCESS.
 * Corresponding #GFileAttributeType is %G_FILE_ATTRIBUTE_TYPE_UINT32.
 */
enum FILE_ATTRIBUTE_TIME_ACCESS_USEC = "time::access-usec";


/**
 * A key in the "time" namespace for getting the time the file was last
 * changed.
 * Corresponding #GFileAttributeType is %G_FILE_ATTRIBUTE_TYPE_UINT64,
 * and contains the time since the file was last changed, in seconds since
 * the UNIX epoch.
 * This corresponds to the traditional UNIX ctime.
 */
enum FILE_ATTRIBUTE_TIME_CHANGED = "time::changed";


/**
 * A key in the "time" namespace for getting the nanoseconds of the time
 * the file was last changed. This should be used in conjunction with
 * #G_FILE_ATTRIBUTE_TIME_CHANGED. Corresponding #GFileAttributeType is
 * %G_FILE_ATTRIBUTE_TYPE_UINT32.
 */
enum FILE_ATTRIBUTE_TIME_CHANGED_NSEC = "time::changed-nsec";


/**
 * A key in the "time" namespace for getting the microseconds of the time
 * the file was last changed.
 * This should be used in conjunction with %G_FILE_ATTRIBUTE_TIME_CHANGED.
 * Corresponding #GFileAttributeType is %G_FILE_ATTRIBUTE_TYPE_UINT32.
 */
enum FILE_ATTRIBUTE_TIME_CHANGED_USEC = "time::changed-usec";


/**
 * A key in the "time" namespace for getting the time the file was created.
 * Corresponding #GFileAttributeType is %G_FILE_ATTRIBUTE_TYPE_UINT64,
 * and contains the time since the file was created, in seconds since the UNIX
 * epoch.
 * This may correspond to Linux `stx_btime`, FreeBSD `st_birthtim`, NetBSD
 * `st_birthtime` or NTFS `ctime`.
 */
enum FILE_ATTRIBUTE_TIME_CREATED = "time::created";


/**
 * A key in the "time" namespace for getting the nanoseconds of the time
 * the file was created. This should be used in conjunction with
 * #G_FILE_ATTRIBUTE_TIME_CREATED. Corresponding #GFileAttributeType is
 * %G_FILE_ATTRIBUTE_TYPE_UINT32.
 */
enum FILE_ATTRIBUTE_TIME_CREATED_NSEC = "time::created-nsec";


/**
 * A key in the "time" namespace for getting the microseconds of the time
 * the file was created.
 * This should be used in conjunction with %G_FILE_ATTRIBUTE_TIME_CREATED.
 * Corresponding #GFileAttributeType is %G_FILE_ATTRIBUTE_TYPE_UINT32.
 */
enum FILE_ATTRIBUTE_TIME_CREATED_USEC = "time::created-usec";


/**
 * A key in the "time" namespace for getting the time the file was last
 * modified.
 * Corresponding #GFileAttributeType is %G_FILE_ATTRIBUTE_TYPE_UINT64, and
 * contains the time since the file was modified, in seconds since the UNIX
 * epoch.
 */
enum FILE_ATTRIBUTE_TIME_MODIFIED = "time::modified";


/**
 * A key in the "time" namespace for getting the nanoseconds of the time
 * the file was last modified. This should be used in conjunction with
 * #G_FILE_ATTRIBUTE_TIME_MODIFIED. Corresponding #GFileAttributeType is
 * %G_FILE_ATTRIBUTE_TYPE_UINT32.
 */
enum FILE_ATTRIBUTE_TIME_MODIFIED_NSEC = "time::modified-nsec";


/**
 * A key in the "time" namespace for getting the microseconds of the time
 * the file was last modified.
 * This should be used in conjunction with %G_FILE_ATTRIBUTE_TIME_MODIFIED.
 * Corresponding #GFileAttributeType is %G_FILE_ATTRIBUTE_TYPE_UINT32.
 */
enum FILE_ATTRIBUTE_TIME_MODIFIED_USEC = "time::modified-usec";


/**
 * A key in the "trash" namespace for getting the deletion date and time
 * of a file inside the `trash:///` folder.
 * The format of the returned string is `YYYY-MM-DDThh:mm:ss`.
 * Corresponding #GFileAttributeType is %G_FILE_ATTRIBUTE_TYPE_STRING.
 */
enum FILE_ATTRIBUTE_TRASH_DELETION_DATE = "trash::deletion-date";


/**
 * A key in the "trash" namespace for getting the number of $(LPAREN)toplevel$(RPAREN) items
 * that are present in the `trash:///` folder.
 * Corresponding #GFileAttributeType is %G_FILE_ATTRIBUTE_TYPE_UINT32.
 */
enum FILE_ATTRIBUTE_TRASH_ITEM_COUNT = "trash::item-count";


/**
 * A key in the "trash" namespace for getting the original path of a file
 * inside the `trash:///` folder before it was trashed.
 * Corresponding #GFileAttributeType is %G_FILE_ATTRIBUTE_TYPE_BYTE_STRING.
 */
enum FILE_ATTRIBUTE_TRASH_ORIG_PATH = "trash::orig-path";


/**
 * A key in the "unix" namespace for getting the number of blocks allocated
 * for the file.
 * This attribute is only available for UNIX file systems.
 * Corresponding #GFileAttributeType is %G_FILE_ATTRIBUTE_TYPE_UINT64.
 */
enum FILE_ATTRIBUTE_UNIX_BLOCKS = "unix::blocks";


/**
 * A key in the "unix" namespace for getting the block size for the file
 * system.
 * This attribute is only available for UNIX file systems.
 * Corresponding #GFileAttributeType is %G_FILE_ATTRIBUTE_TYPE_UINT32.
 */
enum FILE_ATTRIBUTE_UNIX_BLOCK_SIZE = "unix::block-size";


/**
 * A key in the "unix" namespace for getting the device id of the device the
 * file is located on $(LPAREN)see stat$(LPAREN)$(RPAREN) documentation$(RPAREN).
 * This attribute is only available for UNIX file systems.
 * Corresponding #GFileAttributeType is %G_FILE_ATTRIBUTE_TYPE_UINT32.
 */
enum FILE_ATTRIBUTE_UNIX_DEVICE = "unix::device";


/**
 * A key in the "unix" namespace for getting the group ID for the file.
 * This attribute is only available for UNIX file systems.
 * Corresponding #GFileAttributeType is %G_FILE_ATTRIBUTE_TYPE_UINT32.
 */
enum FILE_ATTRIBUTE_UNIX_GID = "unix::gid";


/**
 * A key in the "unix" namespace for getting the inode of the file.
 * This attribute is only available for UNIX file systems.
 * Corresponding #GFileAttributeType is %G_FILE_ATTRIBUTE_TYPE_UINT64.
 */
enum FILE_ATTRIBUTE_UNIX_INODE = "unix::inode";


/**
 * A key in the "unix" namespace for checking if the file represents a
 * UNIX mount point.
 * This attribute is %TRUE if the file is a UNIX mount point.
 * Since 2.58, `/` is considered to be a mount point.
 * This attribute is only available for UNIX file systems.
 * Corresponding #GFileAttributeType is %G_FILE_ATTRIBUTE_TYPE_BOOLEAN.
 */
enum FILE_ATTRIBUTE_UNIX_IS_MOUNTPOINT = "unix::is-mountpoint";


/**
 * A key in the "unix" namespace for getting the mode of the file
 * $(LPAREN)e.g. whether the file is a regular file, symlink, etc$(RPAREN).
 * See the documentation for `lstat$(LPAREN)$(RPAREN)`: this attribute is equivalent to
 * the `st_mode` member of `struct stat`, and includes both the file type
 * and permissions.
 * This attribute is only available for UNIX file systems.
 * Corresponding #GFileAttributeType is %G_FILE_ATTRIBUTE_TYPE_UINT32.
 */
enum FILE_ATTRIBUTE_UNIX_MODE = "unix::mode";


/**
 * A key in the "unix" namespace for getting the number of hard links
 * for a file.
 * See the documentation for `lstat$(LPAREN)$(RPAREN)`.
 * This attribute is only available for UNIX file systems.
 * Corresponding #GFileAttributeType is %G_FILE_ATTRIBUTE_TYPE_UINT32.
 */
enum FILE_ATTRIBUTE_UNIX_NLINK = "unix::nlink";


/**
 * A key in the "unix" namespace for getting the device ID for the file
 * $(LPAREN)if it is a special file$(RPAREN).
 * See the documentation for `lstat$(LPAREN)$(RPAREN)`.
 * This attribute is only available for UNIX file systems.
 * Corresponding #GFileAttributeType is %G_FILE_ATTRIBUTE_TYPE_UINT32.
 */
enum FILE_ATTRIBUTE_UNIX_RDEV = "unix::rdev";


/**
 * A key in the "unix" namespace for getting the user ID for the file.
 * This attribute is only available for UNIX file systems.
 * Corresponding #GFileAttributeType is %G_FILE_ATTRIBUTE_TYPE_UINT32.
 */
enum FILE_ATTRIBUTE_UNIX_UID = "unix::uid";


/**
 * Extension point for memory usage monitoring functionality.
 * See [Extending GIO][extending-gio].
 */
enum MEMORY_MONITOR_EXTENSION_POINT_NAME = "gio-memory-monitor";


/**
 * The menu item attribute which holds the action name of the item.  Action
 * names are namespaced with an identifier for the action group in which the
 * action resides. For example, "win." for window-specific actions and "app."
 * for application-wide actions.
 * See also [Gio.MenuModel.getItemAttribute] and [Gio.MenuItem.setAttribute].
 */
enum MENU_ATTRIBUTE_ACTION = "action";


/**
 * The menu item attribute that holds the namespace for all action names in
 * menus that are linked from this item.
 */
enum MENU_ATTRIBUTE_ACTION_NAMESPACE = "action-namespace";


/**
 * The menu item attribute which holds the icon of the item.
 * The icon is stored in the format returned by [Gio.Icon.serialize].
 * This attribute is intended only to represent 'noun' icons such as
 * favicons for a webpage, or application icons.  It should not be used
 * for 'verbs' $(LPAREN)ie: stock icons$(RPAREN).
 */
enum MENU_ATTRIBUTE_ICON = "icon";


/**
 * The menu item attribute which holds the label of the item.
 */
enum MENU_ATTRIBUTE_LABEL = "label";


/**
 * The menu item attribute which holds the target with which the item's action
 * will be activated.
 * See also [Gio.MenuItem.setActionAndTarget]
 */
enum MENU_ATTRIBUTE_TARGET = "target";


/**
 * The maximum number of entries in a menu section supported by
 * [Gio.DBusConnection.exportMenuModel].
 * The exact value of the limit may change in future GLib versions.
 */
enum MENU_EXPORTER_MAX_SECTION_SIZE = 1000;


/**
 * The name of the link that associates a menu item with a section.  The linked
 * menu will usually be shown in place of the menu item, using the item's label
 * as a header.
 * See also [Gio.MenuItem.setLink].
 */
enum MENU_LINK_SECTION = "section";


/**
 * The name of the link that associates a menu item with a submenu.
 * See also [Gio.MenuItem.setLink].
 */
enum MENU_LINK_SUBMENU = "submenu";


enum NATIVE_VOLUME_MONITOR_EXTENSION_POINT_NAME = "gio-native-volume-monitor";


/**
 * Extension point for network status monitoring functionality.
 * See [Extending GIO][extending-gio].
 */
enum NETWORK_MONITOR_EXTENSION_POINT_NAME = "gio-network-monitor";


/**
 * Extension point for power profile usage monitoring functionality.
 * See [Extending GIO][extending-gio].
 */
enum POWER_PROFILE_MONITOR_EXTENSION_POINT_NAME = "gio-power-profile-monitor";


/**
 * Extension point for proxy functionality.
 * See [Extending GIO][extending-gio].
 */
enum PROXY_EXTENSION_POINT_NAME = "gio-proxy";


/**
 * Extension point for proxy resolving functionality.
 * See [Extending GIO][extending-gio].
 */
enum PROXY_RESOLVER_EXTENSION_POINT_NAME = "gio-proxy-resolver";


/**
 * Extension point for #GSettingsBackend functionality.
 */
enum SETTINGS_BACKEND_EXTENSION_POINT_NAME = "gsettings-backend";


/**
 * Extension point for TLS functionality via #GTlsBackend.
 * See [Extending GIO][extending-gio].
 */
enum TLS_BACKEND_EXTENSION_POINT_NAME = "gio-tls-backend";


/**
 * The purpose used to verify the client certificate in a TLS connection.
 * Used by TLS servers.
 */
enum TLS_DATABASE_PURPOSE_AUTHENTICATE_CLIENT = "1.3.6.1.5.5.7.3.2";


/**
 * The purpose used to verify the server certificate in a TLS connection. This
 * is the most common purpose in use. Used by TLS clients.
 */
enum TLS_DATABASE_PURPOSE_AUTHENTICATE_SERVER = "1.3.6.1.5.5.7.3.1";


/**
 * Extension point for #GVfs functionality.
 * See [Extending GIO][extending-gio].
 */
enum VFS_EXTENSION_POINT_NAME = "gio-vfs";


/**
 * The string used to obtain the volume class with [Gio.Volume.getIdentifier].
 * Known volume classes include `device`, `network`, and `loop`. Other
 * classes may be added in the future.
 * This is intended to be used by applications to classify #GVolume
 * instances into different sections - for example a file manager or
 * file chooser can use this information to show `network` volumes under
 * a "Network" heading and `device` volumes under a "Devices" heading.
 */
enum VOLUME_IDENTIFIER_KIND_CLASS = "class";


/**
 * The string used to obtain a Hal UDI with [Gio.Volume.getIdentifier].

 * Deprecated: Do not use, HAL is deprecated.
 */
enum VOLUME_IDENTIFIER_KIND_HAL_UDI = "hal-udi";


/**
 * The string used to obtain a filesystem label with [Gio.Volume.getIdentifier].
 */
enum VOLUME_IDENTIFIER_KIND_LABEL = "label";


/**
 * The string used to obtain a NFS mount with [Gio.Volume.getIdentifier].
 */
enum VOLUME_IDENTIFIER_KIND_NFS_MOUNT = "nfs-mount";


/**
 * The string used to obtain a Unix device path with [Gio.Volume.getIdentifier].
 */
enum VOLUME_IDENTIFIER_KIND_UNIX_DEVICE = "unix-device";


/**
 * The string used to obtain a UUID with [Gio.Volume.getIdentifier].
 */
enum VOLUME_IDENTIFIER_KIND_UUID = "uuid";


/**
 * Extension point for volume monitor functionality.
 * See [Extending GIO][extending-gio].
 */
enum VOLUME_MONITOR_EXTENSION_POINT_NAME = "gio-volume-monitor";

