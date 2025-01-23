module Gio.c.types;

public import GLib.c.types;
public import GModule.c.types;
public import GObject.c.types;

/**
 * Flags used when creating a #GAppInfo.
 */
enum GAppInfoCreateFlags : uint
{
  /**
   * No flags.
   */
  None = 0,

  /**
   * Application opens in a terminal window.
   */
  NeedsTerminal = 1,

  /**
   * Application supports URI arguments.
   */
  SupportsUris = 2,

  /**
   * Application supports startup notification. Since 2.26
   */
  SupportsStartupNotification = 4,
}

/**
 * Flags used to define the behaviour of a #GApplication.
 */
enum GApplicationFlags : uint
{
  /**
   * Default. Deprecated in 2.74, use
   * %G_APPLICATION_DEFAULT_FLAGS instead
   */
  FlagsNone = 0,

  /**
   * Default flags. Since: 2.74
   */
  DefaultFlags = 0,

  /**
   * Run as a service. In this mode, registration
   * fails if the service is already running, and the application
   * will initially wait up to 10 seconds for an initial activation
   * message to arrive.
   */
  IsService = 1,

  /**
   * Don't try to become the primary instance.
   */
  IsLauncher = 2,

  /**
   * This application handles opening files $(LPAREN)in
   * the primary instance$(RPAREN). Note that this flag only affects the default
   * implementation of local_command_line$(LPAREN)$(RPAREN), and has no effect if
   * %G_APPLICATION_HANDLES_COMMAND_LINE is given.
   * See [Gio.Application.run] for details.
   */
  HandlesOpen = 4,

  /**
   * This application handles command line
   * arguments $(LPAREN)in the primary instance$(RPAREN). Note that this flag only affect
   * the default implementation of local_command_line$(LPAREN)$(RPAREN).
   * See [Gio.Application.run] for details.
   */
  HandlesCommandLine = 8,

  /**
   * Send the environment of the
   * launching process to the primary instance. Set this flag if your
   * application is expected to behave differently depending on certain
   * environment variables. For instance, an editor might be expected
   * to use the `GIT_COMMITTER_NAME` environment variable
   * when editing a git commit message. The environment is available
   * to the #GApplication::command-line signal handler, via
   * [Gio.ApplicationCommandLine.getenv].
   */
  SendEnvironment = 16,

  /**
   * Make no attempts to do any of the typical
   * single-instance application negotiation, even if the application
   * ID is given.  The application neither attempts to become the
   * owner of the application ID nor does it check if an existing
   * owner already exists.  Everything occurs in the local process.
   * Since: 2.30.
   */
  NonUnique = 32,

  /**
   * Allow users to override the
   * application ID from the command line with `--gapplication-app-id`.
   * Since: 2.48
   */
  CanOverrideAppId = 64,

  /**
   * Allow another instance to take over
   * the bus name. Since: 2.60
   */
  AllowReplacement = 128,

  /**
   * Take over from another instance. This flag is
   * usually set by passing `--gapplication-replace` on the commandline.
   * Since: 2.60
   */
  Replace = 256,
}

/**
 * #GAskPasswordFlags are used to request specific information from the
 * user, or to notify the user of their choices in an authentication
 * situation.
 */
enum GAskPasswordFlags : uint
{
  /**
   * operation requires a password.
   */
  NeedPassword = 1,

  /**
   * operation requires a username.
   */
  NeedUsername = 2,

  /**
   * operation requires a domain.
   */
  NeedDomain = 4,

  /**
   * operation supports saving settings.
   */
  SavingSupported = 8,

  /**
   * operation supports anonymous users.
   */
  AnonymousSupported = 16,

  /**
   * operation takes TCRYPT parameters $(LPAREN)Since: 2.58$(RPAREN)
   */
  Tcrypt = 32,
}

/**
 * Flags used in [Gio.Global.busOwnName].
 */
enum GBusNameOwnerFlags : uint
{
  /**
   * No flags set.
   */
  None = 0,

  /**
   * Allow another message bus connection to claim the name.
   */
  AllowReplacement = 1,

  /**
   * If another message bus connection owns the name and have
   * specified %G_BUS_NAME_OWNER_FLAGS_ALLOW_REPLACEMENT, then take the name from the other connection.
   */
  Replace = 2,

  /**
   * If another message bus connection owns the name, immediately
   * return an error from [Gio.Global.busOwnName] rather than entering the waiting queue for that name. (Since 2.54)
   */
  DoNotQueue = 4,
}

/**
 * Flags used in [Gio.Global.busWatchName].
 */
enum GBusNameWatcherFlags : uint
{
  /**
   * No flags set.
   */
  None = 0,

  /**
   * If no-one owns the name when
   * beginning to watch the name, ask the bus to launch an owner for the
   * name.
   */
  AutoStart = 1,
}

/**
 * An enumeration for well-known message buses.
 */
enum GBusType
{
  /**
   * An alias for the message bus that activated the process, if any.
   */
  Starter = -1,

  /**
   * Not a message bus.
   */
  None = 0,

  /**
   * The system-wide message bus.
   */
  System = 1,

  /**
   * The login session message bus.
   */
  Session = 2,
}

/**
 * Flags used when calling a [Gio.Converter.convert].
 */
enum GConverterFlags : uint
{
  /**
   * No flags.
   */
  None = 0,

  /**
   * At end of input data
   */
  InputAtEnd = 1,

  /**
   * Flush data
   */
  Flush = 2,
}

/**
 * Results returned from [Gio.Converter.convert].
 */
enum GConverterResult
{
  /**
   * There was an error during conversion.
   */
  Error = 0,

  /**
   * Some data was consumed or produced
   */
  Converted = 1,

  /**
   * The conversion is finished
   */
  Finished = 2,

  /**
   * Flushing is finished
   */
  Flushed = 3,
}

/**
 * Enumeration describing different kinds of native credential types.
 */
enum GCredentialsType
{
  /**
   * Indicates an invalid native credential type.
   */
  Invalid = 0,

  /**
   * The native credentials type is a `struct ucred`.
   */
  LinuxUcred = 1,

  /**
   * The native credentials type is a `struct cmsgcred`.
   */
  FreebsdCmsgcred = 2,

  /**
   * The native credentials type is a `struct sockpeercred`. Added in 2.30.
   */
  OpenbsdSockpeercred = 3,

  /**
   * The native credentials type is a `ucred_t`. Added in 2.40.
   */
  SolarisUcred = 4,

  /**
   * The native credentials type is a `struct unpcbid`. Added in 2.42.
   */
  NetbsdUnpcbid = 5,

  /**
   * The native credentials type is a `struct xucred`. Added in 2.66.
   */
  AppleXucred = 6,

  /**
   * The native credentials type is a PID `DWORD`. Added in 2.72.
   */
  Win32Pid = 7,
}

/**
 * Flags used in [Gio.DBusConnection.call] and similar APIs.
 */
enum GDBusCallFlags : uint
{
  /**
   * No flags set.
   */
  None = 0,

  /**
   * The bus must not launch
   * an owner for the destination name in response to this method
   * invocation.
   */
  NoAutoStart = 1,

  /**
   * the caller is prepared to
   * wait for interactive authorization. Since 2.46.
   */
  AllowInteractiveAuthorization = 2,
}

/**
 * Capabilities negotiated with the remote peer.
 */
enum GDBusCapabilityFlags : uint
{
  /**
   * No flags set.
   */
  None = 0,

  /**
   * The connection
   * supports exchanging UNIX file descriptors with the remote peer.
   */
  UnixFdPassing = 1,
}

/**
 * Flags used when creating a new #GDBusConnection.
 */
enum GDBusConnectionFlags : uint
{
  /**
   * No flags set.
   */
  None = 0,

  /**
   * Perform authentication against server.
   */
  AuthenticationClient = 1,

  /**
   * Perform authentication against client.
   */
  AuthenticationServer = 2,

  /**
   * When
   * authenticating as a server, allow the anonymous authentication
   * method.
   */
  AuthenticationAllowAnonymous = 4,

  /**
   * Pass this flag if connecting to a peer that is a
   * message bus. This means that the Hello$(LPAREN)$(RPAREN) method will be invoked as part of the connection setup.
   */
  MessageBusConnection = 8,

  /**
   * If set, processing of D-Bus messages is
   * delayed until [Gio.DBusConnection.startMessageProcessing] is called.
   */
  DelayMessageProcessing = 16,

  /**
   * When authenticating
   * as a server, require the UID of the peer to be the same as the UID of the server. $(LPAREN)Since: 2.68$(RPAREN)
   */
  AuthenticationRequireSameUser = 32,

  /**
   * When authenticating, try to use
   * protocols that work across a Linux user namespace boundary, even if this
   * reduces interoperability with older D-Bus implementations. This currently
   * affects client-side `EXTERNAL` authentication, for which this flag makes
   * connections to a server in another user namespace succeed, but causes
   * a deadlock when connecting to a GDBus server older than 2.73.3. Since: 2.74
   */
  CrossNamespace = 64,
}

/**
 * Error codes for the %G_DBUS_ERROR error domain.
 */
enum GDBusError
{
  /**
   * A generic error; "something went wrong" - see the error message for
   * more.
   */
  Failed = 0,

  /**
   * There was not enough memory to complete an operation.
   */
  NoMemory = 1,

  /**
   * The bus doesn't know how to launch a service to supply the bus name
   * you wanted.
   */
  ServiceUnknown = 2,

  /**
   * The bus name you referenced doesn't exist $(LPAREN)i.e. no application owns
   * it$(RPAREN).
   */
  NameHasNoOwner = 3,

  /**
   * No reply to a message expecting one, usually means a timeout occurred.
   */
  NoReply = 4,

  /**
   * Something went wrong reading or writing to a socket, for example.
   */
  IoError = 5,

  /**
   * A D-Bus bus address was malformed.
   */
  BadAddress = 6,

  /**
   * Requested operation isn't supported $(LPAREN)like ENOSYS on UNIX$(RPAREN).
   */
  NotSupported = 7,

  /**
   * Some limited resource is exhausted.
   */
  LimitsExceeded = 8,

  /**
   * Security restrictions don't allow doing what you're trying to do.
   */
  AccessDenied = 9,

  /**
   * Authentication didn't work.
   */
  AuthFailed = 10,

  /**
   * Unable to connect to server $(LPAREN)probably caused by ECONNREFUSED on a
   * socket$(RPAREN).
   */
  NoServer = 11,

  /**
   * Certain timeout errors, possibly ETIMEDOUT on a socket.  Note that
   * %G_DBUS_ERROR_NO_REPLY is used for message reply timeouts. Warning:
   * this is confusingly-named given that %G_DBUS_ERROR_TIMED_OUT also
   * exists. We can't fix it for compatibility reasons so just be
   * careful.
   */
  Timeout = 12,

  /**
   * No network access $(LPAREN)probably ENETUNREACH on a socket$(RPAREN).
   */
  NoNetwork = 13,

  /**
   * Can't bind a socket since its address is in use $(LPAREN)i.e. EADDRINUSE$(RPAREN).
   */
  AddressInUse = 14,

  /**
   * The connection is disconnected and you're trying to use it.
   */
  Disconnected = 15,

  /**
   * Invalid arguments passed to a method call.
   */
  InvalidArgs = 16,

  /**
   * Missing file.
   */
  FileNotFound = 17,

  /**
   * Existing file and the operation you're using does not silently overwrite.
   */
  FileExists = 18,

  /**
   * Method name you invoked isn't known by the object you invoked it on.
   */
  UnknownMethod = 19,

  /**
   * Certain timeout errors, e.g. while starting a service. Warning: this is
   * confusingly-named given that %G_DBUS_ERROR_TIMEOUT also exists. We
   * can't fix it for compatibility reasons so just be careful.
   */
  TimedOut = 20,

  /**
   * Tried to remove or modify a match rule that didn't exist.
   */
  MatchRuleNotFound = 21,

  /**
   * The match rule isn't syntactically valid.
   */
  MatchRuleInvalid = 22,

  /**
   * While starting a new process, the exec$(LPAREN)$(RPAREN) call failed.
   */
  SpawnExecFailed = 23,

  /**
   * While starting a new process, the fork$(LPAREN)$(RPAREN) call failed.
   */
  SpawnForkFailed = 24,

  /**
   * While starting a new process, the child exited with a status code.
   */
  SpawnChildExited = 25,

  /**
   * While starting a new process, the child exited on a signal.
   */
  SpawnChildSignaled = 26,

  /**
   * While starting a new process, something went wrong.
   */
  SpawnFailed = 27,

  /**
   * We failed to setup the environment correctly.
   */
  SpawnSetupFailed = 28,

  /**
   * We failed to setup the config parser correctly.
   */
  SpawnConfigInvalid = 29,

  /**
   * Bus name was not valid.
   */
  SpawnServiceInvalid = 30,

  /**
   * Service file not found in system-services directory.
   */
  SpawnServiceNotFound = 31,

  /**
   * Permissions are incorrect on the setuid helper.
   */
  SpawnPermissionsInvalid = 32,

  /**
   * Service file invalid $(LPAREN)Name, User or Exec missing$(RPAREN).
   */
  SpawnFileInvalid = 33,

  /**
   * Tried to get a UNIX process ID and it wasn't available.
   */
  SpawnNoMemory = 34,

  /**
   * Tried to get a UNIX process ID and it wasn't available.
   */
  UnixProcessIdUnknown = 35,

  /**
   * A type signature is not valid.
   */
  InvalidSignature = 36,

  /**
   * A file contains invalid syntax or is otherwise broken.
   */
  InvalidFileContent = 37,

  /**
   * Asked for SELinux security context and it wasn't available.
   */
  SelinuxSecurityContextUnknown = 38,

  /**
   * Asked for ADT audit data and it wasn't available.
   */
  AdtAuditDataUnknown = 39,

  /**
   * There's already an object with the requested object path.
   */
  ObjectPathInUse = 40,

  /**
   * Object you invoked a method on isn't known. Since 2.42
   */
  UnknownObject = 41,

  /**
   * Interface you invoked a method on isn't known by the object. Since 2.42
   */
  UnknownInterface = 42,

  /**
   * Property you tried to access isn't known by the object. Since 2.42
   */
  UnknownProperty = 43,

  /**
   * Property you tried to set is read-only. Since 2.42
   */
  PropertyReadOnly = 44,
}

/**
 * Flags describing the behavior of a #GDBusInterfaceSkeleton instance.
 */
enum GDBusInterfaceSkeletonFlags : uint
{
  /**
   * No flags set.
   */
  None = 0,

  /**
   * Each method invocation is handled in
   * a thread dedicated to the invocation. This means that the method implementation can use blocking IO
   * without blocking any other part of the process. It also means that the method implementation must
   * use locking to access data structures used by other threads.
   */
  HandleMethodInvocationsInThread = 1,
}

/**
 * Enumeration used to describe the byte order of a D-Bus message.
 */
enum GDBusMessageByteOrder
{
  /**
   * The byte order is big endian.
   */
  BigEndian = 66,

  /**
   * The byte order is little endian.
   */
  LittleEndian = 108,
}

/**
 * Message flags used in #GDBusMessage.
 */
enum GDBusMessageFlags : uint
{
  /**
   * No flags set.
   */
  None = 0,

  /**
   * A reply is not expected.
   */
  NoReplyExpected = 1,

  /**
   * The bus must not launch an
   * owner for the destination name in response to this message.
   */
  NoAutoStart = 2,

  /**
   * If set on a method
   * call, this flag means that the caller is prepared to wait for interactive
   * authorization. Since 2.46.
   */
  AllowInteractiveAuthorization = 4,
}

/**
 * Header fields used in #GDBusMessage.
 */
enum GDBusMessageHeaderField
{
  /**
   * Not a valid header field.
   */
  Invalid = 0,

  /**
   * The object path.
   */
  Path = 1,

  /**
   * The interface name.
   */
  Interface = 2,

  /**
   * The method or signal name.
   */
  Member = 3,

  /**
   * The name of the error that occurred.
   */
  ErrorName = 4,

  /**
   * The serial number the message is a reply to.
   */
  ReplySerial = 5,

  /**
   * The name the message is intended for.
   */
  Destination = 6,

  /**
   * Unique name of the sender of the message $(LPAREN)filled in by the bus$(RPAREN).
   */
  Sender = 7,

  /**
   * The signature of the message body.
   */
  Signature = 8,

  /**
   * The number of UNIX file descriptors that accompany the message.
   */
  NumUnixFds = 9,
}

/**
 * Message types used in #GDBusMessage.
 */
enum GDBusMessageType
{
  /**
   * Message is of invalid type.
   */
  Invalid = 0,

  /**
   * Method call.
   */
  MethodCall = 1,

  /**
   * Method reply.
   */
  MethodReturn = 2,

  /**
   * Error reply.
   */
  Error = 3,

  /**
   * Signal emission.
   */
  Signal = 4,
}

/**
 * Flags used when constructing a #GDBusObjectManagerClient.
 */
enum GDBusObjectManagerClientFlags : uint
{
  /**
   * No flags set.
   */
  None = 0,

  /**
   * If not set and the
   * manager is for a well-known name, then request the bus to launch
   * an owner for the name if no-one owns the name. This flag can only
   * be used in managers for well-known names.
   */
  DoNotAutoStart = 1,
}

/**
 * Flags describing the access control of a D-Bus property.
 */
enum GDBusPropertyInfoFlags : uint
{
  /**
   * No flags set.
   */
  None = 0,

  /**
   * Property is readable.
   */
  Readable = 1,

  /**
   * Property is writable.
   */
  Writable = 2,
}

/**
 * Flags used when constructing an instance of a #GDBusProxy derived class.
 */
enum GDBusProxyFlags : uint
{
  /**
   * No flags set.
   */
  None = 0,

  /**
   * Don't load properties.
   */
  DoNotLoadProperties = 1,

  /**
   * Don't connect to signals on the remote object.
   */
  DoNotConnectSignals = 2,

  /**
   * If the proxy is for a well-known name,
   * do not ask the bus to launch an owner during proxy initialization or a method call.
   * This flag is only meaningful in proxies for well-known names.
   */
  DoNotAutoStart = 4,

  /**
   * If set, the property value for any __invalidated property__ will be $(LPAREN)asynchronously$(RPAREN) retrieved upon receiving the [`PropertiesChanged`](http://dbus.freedesktop.org/doc/dbus-specification.html#standard-interfaces-properties) D-Bus signal and the property will not cause emission of the #GDBusProxy::g-properties-changed signal. When the value is received the #GDBusProxy::g-properties-changed signal is emitted for the property along with the retrieved value. Since 2.32.
   */
  GetInvalidatedProperties = 8,

  /**
   * If the proxy is for a well-known name,
   * do not ask the bus to launch an owner during proxy initialization, but allow it to be
   * autostarted by a method call. This flag is only meaningful in proxies for well-known names,
   * and only if %G_DBUS_PROXY_FLAGS_DO_NOT_AUTO_START is not also specified.
   */
  DoNotAutoStartAtConstruction = 16,

  /**
   * Don't actually send the AddMatch D-Bus
   * call for this signal subscription. This gives you more control
   * over which match rules you add $(LPAREN)but you must add them manually$(RPAREN). $(LPAREN)Since: 2.72$(RPAREN)
   */
  NoMatchRule = 32,
}

/**
 * Flags used when sending #GDBusMessages on a #GDBusConnection.
 */
enum GDBusSendMessageFlags : uint
{
  /**
   * No flags set.
   */
  None = 0,

  /**
   * Do not automatically
   * assign a serial number from the #GDBusConnection object when
   * sending a message.
   */
  PreserveSerial = 1,
}

/**
 * Flags used when creating a #GDBusServer.
 */
enum GDBusServerFlags : uint
{
  /**
   * No flags set.
   */
  None = 0,

  /**
   * All #GDBusServer::new-connection
   * signals will run in separated dedicated threads $(LPAREN)see signal for
   * details$(RPAREN).
   */
  RunInThread = 1,

  /**
   * Allow the anonymous
   * authentication method.
   */
  AuthenticationAllowAnonymous = 2,

  /**
   * Require the UID of the
   * peer to be the same as the UID of the server when authenticating. $(LPAREN)Since: 2.68$(RPAREN)
   */
  AuthenticationRequireSameUser = 4,
}

/**
 * Flags used when subscribing to signals via [Gio.DBusConnection.signalSubscribe].
 */
enum GDBusSignalFlags : uint
{
  /**
   * No flags set.
   */
  None = 0,

  /**
   * Don't actually send the AddMatch
   * D-Bus call for this signal subscription.  This gives you more control
   * over which match rules you add $(LPAREN)but you must add them manually$(RPAREN).
   */
  NoMatchRule = 1,

  /**
   * Match first arguments that
   * contain a bus or interface name with the given namespace.
   */
  MatchArg0Namespace = 2,

  /**
   * Match first arguments that
   * contain an object path that is either equivalent to the given path,
   * or one of the paths is a subpath of the other.
   */
  MatchArg0Path = 4,
}

/**
 * Flags passed to [Gio.DBusConnection.registerSubtree].
 */
enum GDBusSubtreeFlags : uint
{
  /**
   * No flags set.
   */
  None = 0,

  /**
   * Method calls to objects not in the enumerated range
   * will still be dispatched. This is useful if you want
   * to dynamically spawn objects in the subtree.
   */
  DispatchToUnenumeratedNodes = 1,
}

/**
 * #GDataStreamByteOrder is used to ensure proper endianness of streaming data sources
 * across various machine architectures.
 */
enum GDataStreamByteOrder
{
  /**
   * Selects Big Endian byte order.
   */
  BigEndian = 0,

  /**
   * Selects Little Endian byte order.
   */
  LittleEndian = 1,

  /**
   * Selects endianness based on host machine's architecture.
   */
  HostEndian = 2,
}

/**
 * #GDataStreamNewlineType is used when checking for or setting the line endings for a given file.
 */
enum GDataStreamNewlineType
{
  /**
   * Selects "LF" line endings, common on most modern UNIX platforms.
   */
  Lf = 0,

  /**
   * Selects "CR" line endings.
   */
  Cr = 1,

  /**
   * Selects "CR, LF" line ending, common on Microsoft Windows.
   */
  CrLf = 2,

  /**
   * Automatically try to handle any line ending type.
   */
  Any = 3,
}

/**
 * Flags used when starting a drive.
 */
enum GDriveStartFlags : uint
{
  /**
   * No flags set.
   */
  None = 0,
}

/**
 * Enumeration describing how a drive can be started/stopped.
 */
enum GDriveStartStopType
{
  /**
   * Unknown or drive doesn't support
   * start/stop.
   */
  Unknown = 0,

  /**
   * The stop method will physically
   * shut down the drive and e.g. power down the port the drive is
   * attached to.
   */
  Shutdown = 1,

  /**
   * The start/stop methods are used
   * for connecting/disconnect to the drive over the network.
   */
  Network = 2,

  /**
   * The start/stop methods will
   * assemble/disassemble a virtual drive from several physical
   * drives.
   */
  Multidisk = 3,

  /**
   * The start/stop methods will
   * unlock/lock the disk $(LPAREN)for example using the ATA <quote>SECURITY
   * UNLOCK DEVICE</quote> command$(RPAREN)
   */
  Password = 4,
}

/**
 * GEmblemOrigin is used to add information about the origin of the emblem
 * to #GEmblem.
 */
enum GEmblemOrigin
{
  /**
   * Emblem of unknown origin
   */
  Unknown = 0,

  /**
   * Emblem adds device-specific information
   */
  Device = 1,

  /**
   * Emblem depicts live metadata, such as "readonly"
   */
  Livemetadata = 2,

  /**
   * Emblem comes from a user-defined tag, e.g. set by nautilus $(LPAREN)in the future$(RPAREN)
   */
  Tag = 3,
}

/**
 * Flags specifying the behaviour of an attribute.
 */
enum GFileAttributeInfoFlags : uint
{
  /**
   * no flags set.
   */
  None = 0,

  /**
   * copy the attribute values when the file is copied.
   */
  CopyWithFile = 1,

  /**
   * copy the attribute values when the file is moved.
   */
  CopyWhenMoved = 2,
}

/**
 * Used by [Gio.File.setAttributesFromInfo] when setting file attributes.
 */
enum GFileAttributeStatus
{
  /**
   * Attribute value is unset $(LPAREN)empty$(RPAREN).
   */
  Unset = 0,

  /**
   * Attribute value is set.
   */
  Set = 1,

  /**
   * Indicates an error in setting the value.
   */
  ErrorSetting = 2,
}

/**
 * The data types for file attributes.
 */
enum GFileAttributeType
{
  /**
   * indicates an invalid or uninitialized type.
   */
  Invalid = 0,

  /**
   * a null terminated UTF8 string.
   */
  String = 1,

  /**
   * a zero terminated string of non-zero bytes.
   */
  ByteString = 2,

  /**
   * a boolean value.
   */
  Boolean = 3,

  /**
   * an unsigned 4-byte/32-bit integer.
   */
  Uint32 = 4,

  /**
   * a signed 4-byte/32-bit integer.
   */
  Int32 = 5,

  /**
   * an unsigned 8-byte/64-bit integer.
   */
  Uint64 = 6,

  /**
   * a signed 8-byte/64-bit integer.
   */
  Int64 = 7,

  /**
   * a #GObject.
   */
  Object = 8,

  /**
   * a %NULL terminated char **. Since 2.22
   */
  Stringv = 9,
}

/**
 * Flags used when copying or moving files.
 */
enum GFileCopyFlags : uint
{
  /**
   * No flags set.
   */
  None = 0,

  /**
   * Overwrite any existing files
   */
  Overwrite = 1,

  /**
   * Make a backup of any existing files.
   */
  Backup = 2,

  /**
   * Don't follow symlinks.
   */
  NofollowSymlinks = 4,

  /**
   * Copy all file metadata instead of just default set used for copy $(LPAREN)see #GFileInfo$(RPAREN).
   */
  AllMetadata = 8,

  /**
   * Don't use copy and delete fallback if native move not supported.
   */
  NoFallbackForMove = 16,

  /**
   * Leaves target file with default perms, instead of setting the source file perms.
   */
  TargetDefaultPerms = 32,

  /**
   * Use default modification
   * timestamps instead of copying them from the source file. Since 2.80
   */
  TargetDefaultModifiedTime = 64,
}

/**
 * Flags used when an operation may create a file.
 */
enum GFileCreateFlags : uint
{
  /**
   * No flags set.
   */
  None = 0,

  /**
   * Create a file that can only be
   * accessed by the current user.
   */
  Private = 1,

  /**
   * Replace the destination
   * as if it didn't exist before. Don't try to keep any old
   * permissions, replace instead of following links. This
   * is generally useful if you're doing a "copy over"
   * rather than a "save new version of" replace operation.
   * You can think of it as "unlink destination" before
   * writing to it, although the implementation may not
   * be exactly like that. This flag can only be used with
   * [Gio.File.replace] and its variants, including [Gio.File.replaceContents].
   * Since 2.20
   */
  ReplaceDestination = 2,
}

/**
 * Flags that can be used with [Gio.File.measureDiskUsage].
 */
enum GFileMeasureFlags : uint
{
  /**
   * No flags set.
   */
  None = 0,

  /**
   * Report any error encountered
   * while traversing the directory tree.  Normally errors are only
   * reported for the toplevel file.
   */
  ReportAnyError = 2,

  /**
   * Tally usage based on apparent file
   * sizes.  Normally, the block-size is used, if available, as this is a
   * more accurate representation of disk space used.
   * Compare with `du --apparent-size`.
   * Since GLib 2.78. and similarly to `du` since GNU Coreutils 9.2, this will
   * ignore the sizes of file types other than regular files and links, as the
   * sizes of other file types are not specified in a standard way.
   */
  ApparentSize = 4,

  /**
   * Do not cross mount point boundaries.
   * Compare with `du -x`.
   */
  NoXdev = 8,
}

/**
 * Specifies what type of event a monitor event is.
 */
enum GFileMonitorEvent
{
  /**
   * a file changed.
   */
  Changed = 0,

  /**
   * a hint that this was probably the last change in a set of changes.
   */
  ChangesDoneHint = 1,

  /**
   * a file was deleted.
   */
  Deleted = 2,

  /**
   * a file was created.
   */
  Created = 3,

  /**
   * a file attribute was changed.
   */
  AttributeChanged = 4,

  /**
   * the file location will soon be unmounted.
   */
  PreUnmount = 5,

  /**
   * the file location was unmounted.
   */
  Unmounted = 6,

  /**
   * the file was moved -- only sent if the
   * $(LPAREN)deprecated$(RPAREN) %G_FILE_MONITOR_SEND_MOVED flag is set
   */
  Moved = 7,

  /**
   * the file was renamed within the
   * current directory -- only sent if the %G_FILE_MONITOR_WATCH_MOVES
   * flag is set.  Since: 2.46.
   */
  Renamed = 8,

  /**
   * the file was moved into the
   * monitored directory from another location -- only sent if the
   * %G_FILE_MONITOR_WATCH_MOVES flag is set.  Since: 2.46.
   */
  MovedIn = 9,

  /**
   * the file was moved out of the
   * monitored directory to another location -- only sent if the
   * %G_FILE_MONITOR_WATCH_MOVES flag is set.  Since: 2.46
   */
  MovedOut = 10,
}

/**
 * Flags used to set what a #GFileMonitor will watch for.
 */
enum GFileMonitorFlags : uint
{
  /**
   * No flags set.
   */
  None = 0,

  /**
   * Watch for mount events.
   */
  WatchMounts = 1,

  /**
   * Pair DELETED and CREATED events caused
   * by file renames $(LPAREN)moves$(RPAREN) and send a single G_FILE_MONITOR_EVENT_MOVED
   * event instead $(LPAREN)NB: not supported on all backends; the default
   * behaviour -without specifying this flag- is to send single DELETED
   * and CREATED events$(RPAREN).  Deprecated since 2.46: use
   * %G_FILE_MONITOR_WATCH_MOVES instead.
   */
  SendMoved = 2,

  /**
   * Watch for changes to the file made
   * via another hard link. Since 2.36.
   */
  WatchHardLinks = 4,

  /**
   * Watch for rename operations on a
   * monitored directory.  This causes %G_FILE_MONITOR_EVENT_RENAMED,
   * %G_FILE_MONITOR_EVENT_MOVED_IN and %G_FILE_MONITOR_EVENT_MOVED_OUT
   * events to be emitted when possible.  Since: 2.46.
   */
  WatchMoves = 8,
}

/**
 * Flags used when querying a #GFileInfo.
 */
enum GFileQueryInfoFlags : uint
{
  /**
   * No flags set.
   */
  None = 0,

  /**
   * Don't follow symlinks.
   */
  NofollowSymlinks = 1,
}

/**
 * Indicates the file's on-disk type.
 * On Windows systems a file will never have %G_FILE_TYPE_SYMBOLIC_LINK type;
 * use #GFileInfo and %G_FILE_ATTRIBUTE_STANDARD_IS_SYMLINK to determine
 * whether a file is a symlink or not. This is due to the fact that NTFS does
 * not have a single filesystem object type for symbolic links - it has
 * files that symlink to files, and directories that symlink to directories.
 * #GFileType enumeration cannot precisely represent this important distinction,
 * which is why all Windows symlinks will continue to be reported as
 * %G_FILE_TYPE_REGULAR or %G_FILE_TYPE_DIRECTORY.
 */
enum GFileType
{
  /**
   * File's type is unknown.
   */
  Unknown = 0,

  /**
   * File handle represents a regular file.
   */
  Regular = 1,

  /**
   * File handle represents a directory.
   */
  Directory = 2,

  /**
   * File handle represents a symbolic link
   * $(LPAREN)Unix systems$(RPAREN).
   */
  SymbolicLink = 3,

  /**
   * File is a "special" file, such as a socket, fifo,
   * block device, or character device.
   */
  Special = 4,

  /**
   * File is a shortcut $(LPAREN)Windows systems$(RPAREN).
   */
  Shortcut = 5,

  /**
   * File is a mountable location.
   */
  Mountable = 6,
}

/**
 * Indicates a hint from the file system whether files should be
 * previewed in a file manager. Returned as the value of the key
 * %G_FILE_ATTRIBUTE_FILESYSTEM_USE_PREVIEW.
 */
enum GFilesystemPreviewType
{
  /**
   * Only preview files if user has explicitly requested it.
   */
  IfAlways = 0,

  /**
   * Preview files if user has requested preview of "local" files.
   */
  IfLocal = 1,

  /**
   * Never preview files.
   */
  Never = 2,
}

/**
 * Error codes returned by GIO functions.
 * Note that this domain may be extended in future GLib releases. In
 * general, new error codes either only apply to new APIs, or else
 * replace %G_IO_ERROR_FAILED in cases that were not explicitly
 * distinguished before. You should therefore avoid writing code like
 * |[<!-- language\="C" -->
 * if $(LPAREN)g_error_matches $(LPAREN)error, G_IO_ERROR, G_IO_ERROR_FAILED$(RPAREN)$(RPAREN)
 * {
 * // Assume that this is EPRINTERONFIRE
 * ...
 * }
 * ]|
 * but should instead treat all unrecognized error codes the same as
 * %G_IO_ERROR_FAILED.
 * See also #GPollableReturn for a cheaper way of returning
 * %G_IO_ERROR_WOULD_BLOCK to callers without allocating a #GError.
 */
enum GIOErrorEnum
{
  /**
   * Generic error condition for when an operation fails
   * and no more specific #GIOErrorEnum value is defined.
   */
  Failed = 0,

  /**
   * File not found.
   */
  NotFound = 1,

  /**
   * File already exists.
   */
  Exists = 2,

  /**
   * File is a directory.
   */
  IsDirectory = 3,

  /**
   * File is not a directory.
   */
  NotDirectory = 4,

  /**
   * File is a directory that isn't empty.
   */
  NotEmpty = 5,

  /**
   * File is not a regular file.
   */
  NotRegularFile = 6,

  /**
   * File is not a symbolic link.
   */
  NotSymbolicLink = 7,

  /**
   * File cannot be mounted.
   */
  NotMountableFile = 8,

  /**
   * Filename is too many characters.
   */
  FilenameTooLong = 9,

  /**
   * Filename is invalid or contains invalid characters.
   */
  InvalidFilename = 10,

  /**
   * File contains too many symbolic links.
   */
  TooManyLinks = 11,

  /**
   * No space left on drive.
   */
  NoSpace = 12,

  /**
   * Invalid argument.
   */
  InvalidArgument = 13,

  /**
   * Permission denied.
   */
  PermissionDenied = 14,

  /**
   * Operation $(LPAREN)or one of its parameters$(RPAREN) not supported
   */
  NotSupported = 15,

  /**
   * File isn't mounted.
   */
  NotMounted = 16,

  /**
   * File is already mounted.
   */
  AlreadyMounted = 17,

  /**
   * File was closed.
   */
  Closed = 18,

  /**
   * Operation was cancelled. See #GCancellable.
   */
  Cancelled = 19,

  /**
   * Operations are still pending.
   */
  Pending = 20,

  /**
   * File is read only.
   */
  ReadOnly = 21,

  /**
   * Backup couldn't be created.
   */
  CantCreateBackup = 22,

  /**
   * File's Entity Tag was incorrect.
   */
  WrongEtag = 23,

  /**
   * Operation timed out.
   */
  TimedOut = 24,

  /**
   * Operation would be recursive.
   */
  WouldRecurse = 25,

  /**
   * File is busy.
   */
  Busy = 26,

  /**
   * Operation would block.
   */
  WouldBlock = 27,

  /**
   * Host couldn't be found $(LPAREN)remote operations$(RPAREN).
   */
  HostNotFound = 28,

  /**
   * Operation would merge files.
   */
  WouldMerge = 29,

  /**
   * Operation failed and a helper program has
   * already interacted with the user. Do not display any error dialog.
   */
  FailedHandled = 30,

  /**
   * The current process has too many files
   * open and can't open any more. Duplicate descriptors do count toward
   * this limit. Since 2.20
   */
  TooManyOpenFiles = 31,

  /**
   * The object has not been initialized. Since 2.22
   */
  NotInitialized = 32,

  /**
   * The requested address is already in use. Since 2.22
   */
  AddressInUse = 33,

  /**
   * Need more input to finish operation. Since 2.24
   */
  PartialInput = 34,

  /**
   * The input data was invalid. Since 2.24
   */
  InvalidData = 35,

  /**
   * A remote object generated an error that
   * doesn't correspond to a locally registered #GError error
   * domain. Use [Gio.Global.dbusErrorGetRemoteError] to extract the D-Bus
   * error name and [Gio.Global.dbusErrorStripRemoteError] to fix up the
   * message so it matches what was received on the wire. Since 2.26.
   */
  DbusError = 36,

  /**
   * Host unreachable. Since 2.26
   */
  HostUnreachable = 37,

  /**
   * Network unreachable. Since 2.26
   */
  NetworkUnreachable = 38,

  /**
   * Connection refused. Since 2.26
   */
  ConnectionRefused = 39,

  /**
   * Connection to proxy server failed. Since 2.26
   */
  ProxyFailed = 40,

  /**
   * Proxy authentication failed. Since 2.26
   */
  ProxyAuthFailed = 41,

  /**
   * Proxy server needs authentication. Since 2.26
   */
  ProxyNeedAuth = 42,

  /**
   * Proxy connection is not allowed by ruleset.
   * Since 2.26
   */
  ProxyNotAllowed = 43,

  /**
   * Broken pipe. Since 2.36
   */
  BrokenPipe = 44,

  /**
   * Connection closed by peer. Note that this
   * is the same code as %G_IO_ERROR_BROKEN_PIPE; before 2.44 some
   * "connection closed" errors returned %G_IO_ERROR_BROKEN_PIPE, but others
   * returned %G_IO_ERROR_FAILED. Now they should all return the same
   * value, which has this more logical name. Since 2.44.
   */
  ConnectionClosed = 44,

  /**
   * Transport endpoint is not connected. Since 2.44
   */
  NotConnected = 45,

  /**
   * Message too large. Since 2.48.
   */
  MessageTooLarge = 46,

  /**
   * No such device found. Since 2.74
   */
  NoSuchDevice = 47,

  /**
   * Destination address unset. Since 2.80
   */
  DestinationUnset = 48,
}

/**
 * Flags for use with [Gio.IOModuleScope.new_].
 */
enum GIOModuleScopeFlags
{
  /**
   * No module scan flags
   */
  None = 0,

  /**
   * When using this scope to load or
   * scan modules, automatically block a modules which has the same base
   * basename as previously loaded module.
   */
  BlockDuplicates = 1,
}

/**
 * GIOStreamSpliceFlags determine how streams should be spliced.
 */
enum GIOStreamSpliceFlags : uint
{
  /**
   * Do not close either stream.
   */
  None = 0,

  /**
   * Close the first stream after
   * the splice.
   */
  CloseStream1 = 1,

  /**
   * Close the second stream after
   * the splice.
   */
  CloseStream2 = 2,

  /**
   * Wait for both splice operations to finish
   * before calling the callback.
   */
  WaitForBoth = 4,
}

/**
 * Memory availability warning levels.
 * Note that because new values might be added, it is recommended that applications check
 * #GMemoryMonitorWarningLevel as ranges, for example:
 * |[<!-- language\="C" -->
 * if $(LPAREN)warning_level > G_MEMORY_MONITOR_WARNING_LEVEL_LOW$(RPAREN)
 * drop_caches $(LPAREN)$(RPAREN);
 * ]|
 */
enum GMemoryMonitorWarningLevel
{
  /**
   * Memory on the device is low, processes
   * should free up unneeded resources $(LPAREN)for example, in-memory caches$(RPAREN) so they can
   * be used elsewhere.
   */
  Low = 50,

  /**
   * Same as @G_MEMORY_MONITOR_WARNING_LEVEL_LOW
   * but the device has even less free memory, so processes should try harder to free
   * up unneeded resources. If your process does not need to stay running, it is a
   * good time for it to quit.
   */
  Medium = 100,

  /**
   * The system will soon start terminating
   * processes to reclaim memory, including background processes.
   */
  Critical = 255,
}

/**
 * Flags used when mounting a mount.
 */
enum GMountMountFlags : uint
{
  /**
   * No flags set.
   */
  None = 0,
}

/**
 * #GMountOperationResult is returned as a result when a request for
 * information is send by the mounting operation.
 */
enum GMountOperationResult
{
  /**
   * The request was fulfilled and the
   * user specified data is now available
   */
  Handled = 0,

  /**
   * The user requested the mount operation
   * to be aborted
   */
  Aborted = 1,

  /**
   * The request was unhandled $(LPAREN)i.e. not
   * implemented$(RPAREN)
   */
  Unhandled = 2,
}

/**
 * Flags used when an unmounting a mount.
 */
enum GMountUnmountFlags : uint
{
  /**
   * No flags set.
   */
  None = 0,

  /**
   * Unmount even if there are outstanding
   * file operations on the mount.
   */
  Force = 1,
}

/**
 * The host's network connectivity state, as reported by #GNetworkMonitor.
 */
enum GNetworkConnectivity
{
  /**
   * The host is not configured with a
   * route to the Internet; it may or may not be connected to a local
   * network.
   */
  Local = 1,

  /**
   * The host is connected to a network, but
   * does not appear to be able to reach the full Internet, perhaps
   * due to upstream network problems.
   */
  Limited = 2,

  /**
   * The host is behind a captive portal and
   * cannot reach the full Internet.
   */
  Portal = 3,

  /**
   * The host is connected to a network, and
   * appears to be able to reach the full Internet.
   */
  Full = 4,
}

/**
 * Priority levels for #GNotifications.
 */
enum GNotificationPriority
{
  /**
   * the default priority, to be used for the
   * majority of notifications $(LPAREN)for example email messages, software updates,
   * completed download/sync operations$(RPAREN)
   */
  Normal = 0,

  /**
   * for notifications that do not require
   * immediate attention - typically used for contextual background
   * information, such as contact birthdays or local weather
   */
  Low = 1,

  /**
   * for events that require more attention,
   * usually because responses are time-sensitive $(LPAREN)for example chat and SMS
   * messages or alarms$(RPAREN)
   */
  High = 2,

  /**
   * for urgent notifications, or notifications
   * that require a response in a short space of time $(LPAREN)for example phone calls
   * or emergency warnings$(RPAREN)
   */
  Urgent = 3,
}

/**
 * GOutputStreamSpliceFlags determine how streams should be spliced.
 */
enum GOutputStreamSpliceFlags : uint
{
  /**
   * Do not close either stream.
   */
  None = 0,

  /**
   * Close the source stream after
   * the splice.
   */
  CloseSource = 1,

  /**
   * Close the target stream after
   * the splice.
   */
  CloseTarget = 2,
}

/**
 * #GPasswordSave is used to indicate the lifespan of a saved password.
 * #Gvfs stores passwords in the Gnome keyring when this flag allows it
 * to, and later retrieves it again from there.
 */
enum GPasswordSave
{
  /**
   * never save a password.
   */
  Never = 0,

  /**
   * save a password for the session.
   */
  ForSession = 1,

  /**
   * save a password permanently.
   */
  Permanently = 2,
}

/**
 * Return value for various IO operations that signal errors via the
 * return value and not necessarily via a #GError.
 * This enum exists to be able to return errors to callers without having to
 * allocate a #GError. Allocating #GErrors can be quite expensive for
 * regularly happening errors like %G_IO_ERROR_WOULD_BLOCK.
 * In case of %G_POLLABLE_RETURN_FAILED a #GError should be set for the
 * operation to give details about the error that happened.
 */
enum GPollableReturn
{
  /**
   * Generic error condition for when an operation fails.
   */
  Failed = 0,

  /**
   * The operation was successfully finished.
   */
  Ok = 1,

  /**
   * The operation would block.
   */
  WouldBlock = -27,
}

/**
 * An error code used with %G_RESOLVER_ERROR in a #GError returned
 * from a #GResolver routine.
 */
enum GResolverError
{
  /**
   * the requested name/address/service was not
   * found
   */
  NotFound = 0,

  /**
   * the requested information could not
   * be looked up due to a network error or similar problem
   */
  TemporaryFailure = 1,

  /**
   * unknown error
   */
  Internal = 2,
}

/**
 * Flags to modify lookup behavior.
 */
enum GResolverNameLookupFlags : uint
{
  /**
   * default behavior $(LPAREN)same as [Gio.Resolver.lookupByName]$(RPAREN)
   */
  Default = 0,

  /**
   * only resolve ipv4 addresses
   */
  Ipv4Only = 1,

  /**
   * only resolve ipv6 addresses
   */
  Ipv6Only = 2,
}

/**
 * The type of record that [Gio.Resolver.lookupRecords] or
 * [Gio.Resolver.lookupRecordsAsync] should retrieve. The records are returned
 * as lists of #GVariant tuples. Each record type has different values in
 * the variant tuples returned.
 * %G_RESOLVER_RECORD_SRV records are returned as variants with the signature
 * `$(LPAREN)qqqs$(RPAREN)`, containing a `guint16` with the priority, a `guint16` with the
 * weight, a `guint16` with the port, and a string of the hostname.
 * %G_RESOLVER_RECORD_MX records are returned as variants with the signature
 * `$(LPAREN)qs$(RPAREN)`, representing a `guint16` with the preference, and a string containing
 * the mail exchanger hostname.
 * %G_RESOLVER_RECORD_TXT records are returned as variants with the signature
 * `$(LPAREN)as$(RPAREN)`, representing an array of the strings in the text record. Note: Most TXT
 * records only contain a single string, but
 * [RFC 1035](https://tools.ietf.org/html/rfc1035#section-3.3.14) does allow a
 * record to contain multiple strings. The RFC which defines the interpretation
 * of a specific TXT record will likely require concatenation of multiple
 * strings if they are present, as with
 * [RFC 7208](https://tools.ietf.org/html/rfc7208#section-3.3).
 * %G_RESOLVER_RECORD_SOA records are returned as variants with the signature
 * `$(LPAREN)ssuuuuu$(RPAREN)`, representing a string containing the primary name server, a
 * string containing the administrator, the serial as a `guint32`, the refresh
 * interval as a `guint32`, the retry interval as a `guint32`, the expire timeout
 * as a `guint32`, and the TTL as a `guint32`.
 * %G_RESOLVER_RECORD_NS records are returned as variants with the signature
 * `$(LPAREN)s$(RPAREN)`, representing a string of the hostname of the name server.
 */
enum GResolverRecordType
{
  /**
   * look up DNS SRV records for a domain
   */
  Srv = 1,

  /**
   * look up DNS MX records for a domain
   */
  Mx = 2,

  /**
   * look up DNS TXT records for a name
   */
  Txt = 3,

  /**
   * look up DNS SOA records for a zone
   */
  Soa = 4,

  /**
   * look up DNS NS records for a domain
   */
  Ns = 5,
}

/**
 * An error code used with %G_RESOURCE_ERROR in a #GError returned
 * from a #GResource routine.
 */
enum GResourceError
{
  /**
   * no file was found at the requested path
   */
  NotFound = 0,

  /**
   * unknown error
   */
  Internal = 1,
}

/**
 * GResourceFlags give information about a particular file inside a resource
 * bundle.
 */
enum GResourceFlags : uint
{
  /**
   * No flags set.
   */
  None = 0,

  /**
   * The file is compressed.
   */
  Compressed = 1,
}

/**
 * GResourceLookupFlags determine how resource path lookups are handled.
 */
enum GResourceLookupFlags : uint
{
  /**
   * No flags set.
   */
  None = 0,
}

/**
 * Flags used when creating a binding. These flags determine in which
 * direction the binding works. The default is to synchronize in both
 * directions.
 */
enum GSettingsBindFlags : uint
{
  /**
   * Equivalent to `G_SETTINGS_BIND_GET|G_SETTINGS_BIND_SET`
   */
  Default = 0,

  /**
   * Update the #GObject property when the setting changes.
   * It is an error to use this flag if the property is not writable.
   */
  Get = 1,

  /**
   * Update the setting when the #GObject property changes.
   * It is an error to use this flag if the property is not readable.
   */
  Set = 2,

  /**
   * Do not try to bind a "sensitivity" property to the writability of the setting
   */
  NoSensitivity = 4,

  /**
   * When set in addition to %G_SETTINGS_BIND_GET, set the #GObject property
   * value initially from the setting, but do not listen for changes of the setting
   */
  GetNoChanges = 8,

  /**
   * When passed to [Gio.Settings.bind], uses a pair of mapping functions that invert
   * the boolean value when mapping between the setting and the property.  The setting and property must both
   * be booleans.  You cannot pass this flag to [Gio.Settings.bindWithMapping].
   */
  InvertBoolean = 16,
}

/**
 * Describes an event occurring on a #GSocketClient. See the
 * #GSocketClient::event signal for more details.
 * Additional values may be added to this type in the future.
 */
enum GSocketClientEvent
{
  /**
   * The client is doing a DNS lookup.
   */
  Resolving = 0,

  /**
   * The client has completed a DNS lookup.
   */
  Resolved = 1,

  /**
   * The client is connecting to a remote
   * host $(LPAREN)either a proxy or the destination server$(RPAREN).
   */
  Connecting = 2,

  /**
   * The client has connected to a remote
   * host.
   */
  Connected = 3,

  /**
   * The client is negotiating
   * with a proxy to connect to the destination server.
   */
  ProxyNegotiating = 4,

  /**
   * The client has negotiated
   * with the proxy server.
   */
  ProxyNegotiated = 5,

  /**
   * The client is performing a
   * TLS handshake.
   */
  TlsHandshaking = 6,

  /**
   * The client has performed a
   * TLS handshake.
   */
  TlsHandshaked = 7,

  /**
   * The client is done with a particular
   * #GSocketConnectable.
   */
  Complete = 8,
}

/**
 * The protocol family of a #GSocketAddress. $(LPAREN)These values are
 * identical to the system defines %AF_INET, %AF_INET6 and %AF_UNIX,
 * if available.$(RPAREN)
 */
enum GSocketFamily
{
  /**
   * no address family
   */
  Invalid = 0,

  /**
   * the UNIX domain family
   */
  Unix = 1,

  /**
   * the IPv4 family
   */
  Ipv4 = 2,

  /**
   * the IPv6 family
   */
  Ipv6 = 10,
}

/**
 * Describes an event occurring on a #GSocketListener. See the
 * #GSocketListener::event signal for more details.
 * Additional values may be added to this type in the future.
 */
enum GSocketListenerEvent
{
  /**
   * The listener is about to bind a socket.
   */
  Binding = 0,

  /**
   * The listener has bound a socket.
   */
  Bound = 1,

  /**
   * The listener is about to start
   * listening on this socket.
   */
  Listening = 2,

  /**
   * The listener is now listening on
   * this socket.
   */
  Listened = 3,
}

/**
 * Flags used in [Gio.Socket.receiveMessage] and [Gio.Socket.sendMessage].
 * The flags listed in the enum are some commonly available flags, but the
 * values used for them are the same as on the platform, and any other flags
 * are passed in/out as is. So to use a platform specific flag, just include
 * the right system header and pass in the flag.
 */
enum GSocketMsgFlags : uint
{
  /**
   * No flags.
   */
  None = 0,

  /**
   * Request to send/receive out of band data.
   */
  Oob = 1,

  /**
   * Read data from the socket without removing it from
   * the queue.
   */
  Peek = 2,

  /**
   * Don't use a gateway to send out the packet,
   * only send to hosts on directly connected networks.
   */
  Dontroute = 4,
}

/**
 * A protocol identifier is specified when creating a #GSocket, which is a
 * family/type specific identifier, where 0 means the default protocol for
 * the particular family/type.
 * This enum contains a set of commonly available and used protocols. You
 * can also pass any other identifiers handled by the platform in order to
 * use protocols not listed here.
 */
enum GSocketProtocol
{
  /**
   * The protocol type is unknown
   */
  Unknown = -1,

  /**
   * The default protocol for the family/type
   */
  Default = 0,

  /**
   * TCP over IP
   */
  Tcp = 6,

  /**
   * UDP over IP
   */
  Udp = 17,

  /**
   * SCTP over IP
   */
  Sctp = 132,
}

/**
 * Flags used when creating a #GSocket. Some protocols may not implement
 * all the socket types.
 */
enum GSocketType
{
  /**
   * Type unknown or wrong
   */
  Invalid = 0,

  /**
   * Reliable connection-based byte streams $(LPAREN)e.g. TCP$(RPAREN).
   */
  Stream = 1,

  /**
   * Connectionless, unreliable datagram passing.
   * $(LPAREN)e.g. UDP$(RPAREN)
   */
  Datagram = 2,

  /**
   * Reliable connection-based passing of datagrams
   * of fixed maximum length $(LPAREN)e.g. SCTP$(RPAREN).
   */
  Seqpacket = 3,
}

/**
 * Flags to define the behaviour of a #GSubprocess.
 * Note that the default for stdin is to redirect from `/dev/null`.  For
 * stdout and stderr the default are for them to inherit the
 * corresponding descriptor from the calling process.
 * Note that it is a programmer error to mix 'incompatible' flags.  For
 * example, you may not request both %G_SUBPROCESS_FLAGS_STDOUT_PIPE and
 * %G_SUBPROCESS_FLAGS_STDOUT_SILENCE.
 */
enum GSubprocessFlags : uint
{
  /**
   * No flags.
   */
  None = 0,

  /**
   * create a pipe for the stdin of the
   * spawned process that can be accessed with
   * [Gio.Subprocess.getStdinPipe].
   */
  StdinPipe = 1,

  /**
   * stdin is inherited from the
   * calling process.
   */
  StdinInherit = 2,

  /**
   * create a pipe for the stdout of the
   * spawned process that can be accessed with
   * [Gio.Subprocess.getStdoutPipe].
   */
  StdoutPipe = 4,

  /**
   * silence the stdout of the spawned
   * process $(LPAREN)ie: redirect to `/dev/null`$(RPAREN).
   */
  StdoutSilence = 8,

  /**
   * create a pipe for the stderr of the
   * spawned process that can be accessed with
   * [Gio.Subprocess.getStderrPipe].
   */
  StderrPipe = 16,

  /**
   * silence the stderr of the spawned
   * process $(LPAREN)ie: redirect to `/dev/null`$(RPAREN).
   */
  StderrSilence = 32,

  /**
   * merge the stderr of the spawned
   * process with whatever the stdout happens to be.  This is a good way
   * of directing both streams to a common log file, for example.
   */
  StderrMerge = 64,

  /**
   * spawned processes will inherit the
   * file descriptors of their parent, unless those descriptors have
   * been explicitly marked as close-on-exec.  This flag has no effect
   * over the "standard" file descriptors $(LPAREN)stdin, stdout, stderr$(RPAREN).
   */
  InheritFds = 128,

  /**
   * if path searching is
   * needed when spawning the subprocess, use the `PATH` in the launcher
   * environment. $(LPAREN)Since: 2.72$(RPAREN)
   */
  SearchPathFromEnvp = 256,
}

/**
 * Flags to define future #GTestDBus behaviour.
 */
enum GTestDBusFlags : uint
{
  /**
   * No flags.
   */
  None = 0,
}

/**
 * The client authentication mode for a #GTlsServerConnection.
 */
enum GTlsAuthenticationMode
{
  /**
   * client authentication not required
   */
  None = 0,

  /**
   * client authentication is requested
   */
  Requested = 1,

  /**
   * client authentication is required
   */
  Required = 2,
}

/**
 * A set of flags describing TLS certification validation. This can be
 * used to describe why a particular certificate was rejected $(LPAREN)for
 * example, in #GTlsConnection::accept-certificate$(RPAREN).
 * GLib guarantees that if certificate verification fails, at least one
 * flag will be set, but it does not guarantee that all possible flags
 * will be set. Accordingly, you may not safely decide to ignore any
 * particular type of error. For example, it would be incorrect to mask
 * %G_TLS_CERTIFICATE_EXPIRED if you want to allow expired certificates,
 * because this could potentially be the only error flag set even if
 * other problems exist with the certificate.
 */
enum GTlsCertificateFlags : uint
{
  /**
   * No flags set. Since: 2.74
   */
  NoFlags = 0,

  /**
   * The signing certificate authority is
   * not known.
   */
  UnknownCa = 1,

  /**
   * The certificate does not match the
   * expected identity of the site that it was retrieved from.
   */
  BadIdentity = 2,

  /**
   * The certificate's activation time
   * is still in the future
   */
  NotActivated = 4,

  /**
   * The certificate has expired
   */
  Expired = 8,

  /**
   * The certificate has been revoked
   * according to the #GTlsConnection's certificate revocation list.
   */
  Revoked = 16,

  /**
   * The certificate's algorithm is
   * considered insecure.
   */
  Insecure = 32,

  /**
   * Some other error occurred validating
   * the certificate
   */
  GenericError = 64,

  /**
   * the combination of all of the above
   * flags
   */
  ValidateAll = 127,
}

/**
 * Flags for [Gio.TlsInteraction.requestCertificate],
 * [Gio.TlsInteraction.requestCertificateAsync], and
 * [Gio.TlsInteraction.invokeRequestCertificate].
 */
enum GTlsCertificateRequestFlags
{
  /**
   * No flags
   */
  None = 0,
}

/**
 * An error code used with %G_TLS_CHANNEL_BINDING_ERROR in a #GError to
 * indicate a TLS channel binding retrieval error.
 */
enum GTlsChannelBindingError
{
  /**
   * Either entire binding
   * retrieval facility or specific binding type is not implemented in the
   * TLS backend.
   */
  NotImplemented = 0,

  /**
   * The handshake is not yet
   * complete on the connection which is a strong requirement for any existing
   * binding type.
   */
  InvalidState = 1,

  /**
   * Handshake is complete but
   * binding data is not available. That normally indicates the TLS
   * implementation failed to provide the binding data. For example, some
   * implementations do not provide a peer certificate for resumed connections.
   */
  NotAvailable = 2,

  /**
   * Binding type is not supported
   * on the current connection. This error could be triggered when requesting
   * `tls-server-end-point` binding data for a certificate which has no hash
   * function or uses multiple hash functions.
   */
  NotSupported = 3,

  /**
   * Any other backend error
   * preventing binding data retrieval.
   */
  GeneralError = 4,
}

/**
 * The type of TLS channel binding data to retrieve from #GTlsConnection
 * or #GDtlsConnection, as documented by RFC 5929 or RFC 9266. The
 * [`tls-unique-for-telnet`](https://tools.ietf.org/html/rfc5929#section-5)
 * binding type is not currently implemented.
 */
enum GTlsChannelBindingType
{
  /**
   * [`tls-unique`](https://tools.ietf.org/html/rfc5929#section-3) binding
   * type
   */
  Unique = 0,

  /**
   * [`tls-server-end-point`](https://tools.ietf.org/html/rfc5929#section-4)
   * binding type
   */
  ServerEndPoint = 1,

  /**
   * [`tls-exporter`](https://www.rfc-editor.org/rfc/rfc9266.html) binding
   * type. Since: 2.74
   */
  Exporter = 2,
}

/**
 * Flags for [Gio.TlsDatabase.lookupCertificateForHandle],
 * [Gio.TlsDatabase.lookupCertificateIssuer],
 * and [Gio.TlsDatabase.lookupCertificatesIssuedBy].
 */
enum GTlsDatabaseLookupFlags
{
  /**
   * No lookup flags
   */
  None = 0,

  /**
   * Restrict lookup to certificates that have
   * a private key.
   */
  Keypair = 1,
}

/**
 * Flags for [Gio.TlsDatabase.verifyChain].
 */
enum GTlsDatabaseVerifyFlags : uint
{
  /**
   * No verification flags
   */
  None = 0,
}

/**
 * An error code used with %G_TLS_ERROR in a #GError returned from a
 * TLS-related routine.
 */
enum GTlsError
{
  /**
   * No TLS provider is available
   */
  Unavailable = 0,

  /**
   * Miscellaneous TLS error
   */
  Misc = 1,

  /**
   * The certificate presented could not
   * be parsed or failed validation.
   */
  BadCertificate = 2,

  /**
   * The TLS handshake failed because the
   * peer does not seem to be a TLS server.
   */
  NotTls = 3,

  /**
   * The TLS handshake failed because the
   * peer's certificate was not acceptable.
   */
  Handshake = 4,

  /**
   * The TLS handshake failed because
   * the server requested a client-side certificate, but none was
   * provided. See [Gio.TlsConnection.setCertificate].
   */
  CertificateRequired = 5,

  /**
   * The TLS connection was closed without proper
   * notice, which may indicate an attack. See
   * [Gio.TlsConnection.setRequireCloseNotify].
   */
  Eof = 6,

  /**
   * The TLS handshake failed
   * because the client sent the fallback SCSV, indicating a protocol
   * downgrade attack. Since: 2.60
   */
  InappropriateFallback = 7,

  /**
   * The certificate failed
   * to load because a password was incorrect. Since: 2.72
   */
  BadCertificatePassword = 8,
}

/**
 * #GTlsInteractionResult is returned by various functions in #GTlsInteraction
 * when finishing an interaction request.
 */
enum GTlsInteractionResult
{
  /**
   * The interaction was unhandled $(LPAREN)i.e. not
   * implemented$(RPAREN).
   */
  Unhandled = 0,

  /**
   * The interaction completed, and resulting data
   * is available.
   */
  Handled = 1,

  /**
   * The interaction has failed, or was cancelled.
   * and the operation should be aborted.
   */
  Failed = 2,
}

/**
 * Various flags for the password.
 */
enum GTlsPasswordFlags : uint
{
  /**
   * No flags
   */
  None = 0,

  /**
   * The password was wrong, and the user should retry.
   */
  Retry = 2,

  /**
   * Hint to the user that the password has been
   * wrong many times, and the user may not have many chances left.
   */
  ManyTries = 4,

  /**
   * Hint to the user that this is the last try to get
   * this password right.
   */
  FinalTry = 8,

  /**
   * For PKCS #11, the user PIN is required.
   * Since: 2.70.
   */
  Pkcs11User = 16,

  /**
   * For PKCS #11, the security officer
   * PIN is required. Since: 2.70.
   */
  Pkcs11SecurityOfficer = 32,

  /**
   * For PKCS #11, the context-specific
   * PIN is required. Since: 2.70.
   */
  Pkcs11ContextSpecific = 64,
}

/**
 * The TLS or DTLS protocol version used by a #GTlsConnection or
 * #GDtlsConnection. The integer values of these versions are sequential
 * to ensure newer known protocol versions compare greater than older
 * known versions. Any known DTLS protocol version will compare greater
 * than any SSL or TLS protocol version. The protocol version may be
 * %G_TLS_PROTOCOL_VERSION_UNKNOWN if the TLS backend supports a newer
 * protocol version that GLib does not yet know about. This means that
 * it's possible for an unknown DTLS protocol version to compare less
 * than the TLS protocol versions.
 */
enum GTlsProtocolVersion
{
  /**
   * No protocol version or unknown protocol version
   */
  Unknown = 0,

  /**
   * SSL 3.0, which is insecure and should not be used
   */
  Ssl30 = 1,

  /**
   * TLS 1.0, which is insecure and should not be used
   */
  Tls10 = 2,

  /**
   * TLS 1.1, which is insecure and should not be used
   */
  Tls11 = 3,

  /**
   * TLS 1.2, defined by [RFC 5246](https://datatracker.ietf.org/doc/html/rfc5246)
   */
  Tls12 = 4,

  /**
   * TLS 1.3, defined by [RFC 8446](https://datatracker.ietf.org/doc/html/rfc8446)
   */
  Tls13 = 5,

  /**
   * DTLS 1.0, which is insecure and should not be used
   */
  Dtls10 = 201,

  /**
   * DTLS 1.2, defined by [RFC 6347](https://datatracker.ietf.org/doc/html/rfc6347)
   */
  Dtls12 = 202,
}

/**
 * When to allow rehandshaking. See
 * [Gio.TlsConnection.setRehandshakeMode].

 * Deprecated: Changing the rehandshake mode is no longer
 *   required for compatibility. Also, rehandshaking has been removed
 *   from the TLS protocol in TLS 1.3.
 */
enum GTlsRehandshakeMode
{
  /**
   * Never allow rehandshaking
   */
  Never = 0,

  /**
   * Allow safe rehandshaking only
   */
  Safely = 1,

  /**
   * Allow unsafe rehandshaking
   */
  Unsafely = 2,
}

/**
 * The type of name used by a #GUnixSocketAddress.
 * %G_UNIX_SOCKET_ADDRESS_PATH indicates a traditional unix domain
 * socket bound to a filesystem path. %G_UNIX_SOCKET_ADDRESS_ANONYMOUS
 * indicates a socket not bound to any name $(LPAREN)eg, a client-side socket,
 * or a socket created with socketpair$(LPAREN)$(RPAREN)$(RPAREN).
 * For abstract sockets, there are two incompatible ways of naming
 * them; the man pages suggest using the entire `struct sockaddr_un`
 * as the name, padding the unused parts of the %sun_path field with
 * zeroes; this corresponds to %G_UNIX_SOCKET_ADDRESS_ABSTRACT_PADDED.
 * However, many programs instead just use a portion of %sun_path, and
 * pass an appropriate smaller length to bind$(LPAREN)$(RPAREN) or connect$(LPAREN)$(RPAREN). This is
 * %G_UNIX_SOCKET_ADDRESS_ABSTRACT.
 */
enum GUnixSocketAddressType
{
  /**
   * invalid
   */
  Invalid = 0,

  /**
   * anonymous
   */
  Anonymous = 1,

  /**
   * a filesystem path
   */
  Path = 2,

  /**
   * an abstract name
   */
  Abstract = 3,

  /**
   * an abstract name, 0-padded
   * to the full length of a unix socket name
   */
  AbstractPadded = 4,
}

/**
 * Used to select the type of data format to use for #GZlibDecompressor
 * and #GZlibCompressor.
 */
enum GZlibCompressorFormat
{
  /**
   * deflate compression with zlib header
   */
  Zlib = 0,

  /**
   * gzip file format
   */
  Gzip = 1,

  /**
   * deflate compression with no header
   */
  Raw = 2,
}

/**
 * `GAction` represents a single named action.
 * The main interface to an action is that it can be activated with
 * [Gio.Action.activate]. This results in the 'activate' signal being
 * emitted. An activation has a `GVariant` parameter $(LPAREN)which may be
 * `NULL`$(RPAREN). The correct type for the parameter is determined by a static
 * parameter type $(LPAREN)which is given at construction time$(RPAREN).
 * An action may optionally have a state, in which case the state may be
 * set with [Gio.Action.changeState]. This call takes a #GVariant. The
 * correct type for the state is determined by a static state type
 * $(LPAREN)which is given at construction time$(RPAREN).
 * The state may have a hint associated with it, specifying its valid
 * range.
 * `GAction` is merely the interface to the concept of an action, as
 * described above.  Various implementations of actions exist, including
 * [Gio.SimpleAction].
 * In all cases, the implementing class is responsible for storing the
 * name of the action, the parameter type, the enabled state, the optional
 * state type and the state and emitting the appropriate signals when these
 * change. The implementor is responsible for filtering calls to
 * [Gio.Action.activate] and [Gio.Action.changeState]
 * for type safety and for the state being enabled.
 * Probably the only useful thing to do with a `GAction` is to put it
 * inside of a [Gio.SimpleActionGroup].
 */
struct GAction;

/**
 * This struct defines a single action.  It is for use with
 * [Gio.ActionMap.addActionEntries].
 * The order of the items in the structure are intended to reflect
 * frequency of use.  It is permissible to use an incomplete initialiser
 * in order to leave some of the later values as %NULL.  All values
 * after @name are optional.  Additional optional fields may be added in
 * the future.
 * See [Gio.ActionMap.addActionEntries] for an example.
 */
struct GActionEntry
{
  /**
   * the name of the action
   */
  const(char)* name;

  /**
   * the callback to connect to the "activate" signal of the
   * action.  Since GLib 2.40, this can be %NULL for stateful
   * actions, in which case the default handler is used.  For
   * boolean-stated actions with no parameter, this is a
   * toggle.  For other state types $(LPAREN)and parameter type equal
   * to the state type$(RPAREN) this will be a function that
   * just calls @change_state $(LPAREN)which you should provide$(RPAREN).
   */
  extern(C) void function(GSimpleAction* action, VariantC* parameter, void* userData) activate;

  /**
   * the type of the parameter that must be passed to the
   * activate function for this action, given as a single
   * GVariant type string $(LPAREN)or %NULL for no parameter$(RPAREN)
   */
  const(char)* parameterType;

  /**
   * the initial state for this action, given in
   * [GVariant text format][gvariant-text].  The state is parsed
   * with no extra type information, so type tags must be added to
   * the string if they are necessary.  Stateless actions should
   * give %NULL here.
   */
  const(char)* state;

  /**
   * the callback to connect to the "change-state" signal
   * of the action.  All stateful actions should provide a
   * handler here; stateless actions should not.
   */
  extern(C) void function(GSimpleAction* action, VariantC* value, void* userData) changeState;

  size_t[3] padding;
}

/**
 * `GActionGroup` represents a group of actions.
 * Actions can be used to expose functionality in a structured way, either
 * from one part of a program to another, or to the outside world. Action
 * groups are often used together with a `GMenuModel` that provides additional
 * representation data for displaying the actions to the user, e.g. in a menu.
 * The main way to interact with the actions in a `GActionGroup` is to
 * activate them with [Gio.ActionGroup.activateAction]. Activating an
 * action may require a `GVariant` parameter. The required type of the
 * parameter can be inquired with [Gio.ActionGroup.getActionParameterType].
 * Actions may be disabled, see [Gio.ActionGroup.getActionEnabled].
 * Activating a disabled action has no effect.
 * Actions may optionally have a state in the form of a #GVariant. The current
 * state of an action can be inquired with [Gio.ActionGroup.getActionState].
 * Activating a stateful action may change its state, but it is also possible to
 * set the state by calling [Gio.ActionGroup.changeActionState].
 * As typical example, consider a text editing application which has an
 * option to change the current font to 'bold'. A good way to represent
 * this would be a stateful action, with a boolean state. Activating the
 * action would toggle the state.
 * Each action in the group has a unique name $(LPAREN)which is a string$(RPAREN).  All
 * method calls, except [Gio.ActionGroup.listActions] take the name of
 * an action as an argument.
 * The `GActionGroup` API is meant to be the 'public' API to the action
 * group. The calls here are exactly the interaction that 'external
 * forces' $(LPAREN)eg: UI, incoming D-Bus messages, etc.$(RPAREN) are supposed to have
 * with actions. 'Internal' APIs $(LPAREN)ie: ones meant only to be accessed by
 * the action group implementation$(RPAREN) are found on subclasses. This is
 * why you will find - for example - [Gio.ActionGroup.getActionEnabled]
 * but not an equivalent set$(LPAREN)$(RPAREN) call.
 * Signals are emitted on the action group in response to state changes
 * on individual actions.
 * Implementations of `GActionGroup` should provide implementations for
 * the virtual functions [Gio.ActionGroup.listActions] and
 * [Gio.ActionGroup.queryAction]. The other virtual functions should
 * not be implemented - their "wrappers" are actually implemented with
 * calls to [Gio.ActionGroup.queryAction].
 */
struct GActionGroup;

/**
 * The virtual function table for #GActionGroup.
 */
struct GActionGroupInterface
{
  GTypeInterface gIface;

  /**
   * the virtual function pointer for [Gio.ActionGroup.hasAction]
   */
  extern(C) bool function(GActionGroup* actionGroup, const(char)* actionName) hasAction;

  /**
   * the virtual function pointer for [Gio.ActionGroup.listActions]
   */
  extern(C) char** function(GActionGroup* actionGroup) listActions;

  /**
   * the virtual function pointer for [Gio.ActionGroup.getActionEnabled]
   */
  extern(C) bool function(GActionGroup* actionGroup, const(char)* actionName) getActionEnabled;

  /**
   * the virtual function pointer for [Gio.ActionGroup.getActionParameterType]
   */
  extern(C) const(GVariantType)* function(GActionGroup* actionGroup, const(char)* actionName) getActionParameterType;

  /**
   * the virtual function pointer for [Gio.ActionGroup.getActionStateType]
   */
  extern(C) const(GVariantType)* function(GActionGroup* actionGroup, const(char)* actionName) getActionStateType;

  /**
   * the virtual function pointer for [Gio.ActionGroup.getActionStateHint]
   */
  extern(C) VariantC* function(GActionGroup* actionGroup, const(char)* actionName) getActionStateHint;

  /**
   * the virtual function pointer for [Gio.ActionGroup.getActionState]
   */
  extern(C) VariantC* function(GActionGroup* actionGroup, const(char)* actionName) getActionState;

  /**
   * the virtual function pointer for [Gio.ActionGroup.changeActionState]
   */
  extern(C) void function(GActionGroup* actionGroup, const(char)* actionName, VariantC* value) changeActionState;

  /**
   * the virtual function pointer for [Gio.ActionGroup.activateAction]
   */
  extern(C) void function(GActionGroup* actionGroup, const(char)* actionName, VariantC* parameter) activateAction;

  /**
   * the class closure for the #GActionGroup::action-added signal
   */
  extern(C) void function(GActionGroup* actionGroup, const(char)* actionName) actionAdded;

  /**
   * the class closure for the #GActionGroup::action-removed signal
   */
  extern(C) void function(GActionGroup* actionGroup, const(char)* actionName) actionRemoved;

  /**
   * the class closure for the #GActionGroup::action-enabled-changed signal
   */
  extern(C) void function(GActionGroup* actionGroup, const(char)* actionName, bool enabled) actionEnabledChanged;

  /**
   * the class closure for the #GActionGroup::action-enabled-changed signal
   */
  extern(C) void function(GActionGroup* actionGroup, const(char)* actionName, VariantC* state) actionStateChanged;

  /**
   * the virtual function pointer for [Gio.ActionGroup.queryAction]
   */
  extern(C) bool function(GActionGroup* actionGroup, const(char)* actionName, bool* enabled, const(GVariantType*)* parameterType, const(GVariantType*)* stateType, VariantC** stateHint, VariantC** state) queryAction;
}

/**
 * The virtual function table for #GAction.
 */
struct GActionInterface
{
  GTypeInterface gIface;

  /**
   * the virtual function pointer for [Gio.Action.getName]
   */
  extern(C) const(char)* function(GAction* action) getName;

  /**
   * the virtual function pointer for [Gio.Action.getParameterType]
   */
  extern(C) const(GVariantType)* function(GAction* action) getParameterType;

  /**
   * the virtual function pointer for [Gio.Action.getStateType]
   */
  extern(C) const(GVariantType)* function(GAction* action) getStateType;

  /**
   * the virtual function pointer for [Gio.Action.getStateHint]
   */
  extern(C) VariantC* function(GAction* action) getStateHint;

  /**
   * the virtual function pointer for [Gio.Action.getEnabled]
   */
  extern(C) bool function(GAction* action) getEnabled;

  /**
   * the virtual function pointer for [Gio.Action.getState]
   */
  extern(C) VariantC* function(GAction* action) getState;

  /**
   * the virtual function pointer for [Gio.Action.changeState]
   */
  extern(C) void function(GAction* action, VariantC* value) changeState;

  /**
   * the virtual function pointer for [Gio.Action.activate].  Note that #GAction does not have an
   * 'activate' signal but that implementations of it may have one.
   */
  extern(C) void function(GAction* action, VariantC* parameter) activate;
}

/**
 * `GActionMap` is an interface for action containers.
 * The `GActionMap` interface is implemented by [Gio.ActionGroup]
 * implementations that operate by containing a number of named
 * [Gio.Action] instances, such as [Gio.SimpleActionGroup].
 * One useful application of this interface is to map the
 * names of actions from various action groups to unique,
 * prefixed names $(LPAREN)e.g. by prepending "app." or "win."$(RPAREN).
 * This is the motivation for the 'Map' part of the interface
 * name.
 */
struct GActionMap;

/**
 * The virtual function table for #GActionMap.
 */
struct GActionMapInterface
{
  GTypeInterface gIface;

  /**
   * the virtual function pointer for [Gio.ActionMap.lookupAction]
   */
  extern(C) GAction* function(GActionMap* actionMap, const(char)* actionName) lookupAction;

  /**
   * the virtual function pointer for [Gio.ActionMap.addAction]
   */
  extern(C) void function(GActionMap* actionMap, GAction* action) addAction;

  /**
   * the virtual function pointer for [Gio.ActionMap.removeAction]
   */
  extern(C) void function(GActionMap* actionMap, const(char)* actionName) removeAction;
}

/**
 * Information about an installed application and methods to launch
 * it $(LPAREN)with file arguments$(RPAREN).
 * `GAppInfo` and `GAppLaunchContext` are used for describing and launching
 * applications installed on the system.
 * As of GLib 2.20, URIs will always be converted to POSIX paths
 * $(LPAREN)using [Gio.File.getPath]$(RPAREN) when using [Gio.AppInfo.launch]
 * even if the application requested an URI and not a POSIX path. For example
 * for a desktop-file based application with Exec key `totem
 * %U` and a single URI, `sftp://foo/file.avi`, then
 * `/home/user/.gvfs/sftp on foo/file.avi` will be passed. This will
 * only work if a set of suitable GIO extensions $(LPAREN)such as GVfs 2.26
 * compiled with FUSE support$(RPAREN), is available and operational; if this
 * is not the case, the URI will be passed unmodified to the application.
 * Some URIs, such as `mailto:`, of course cannot be mapped to a POSIX
 * path $(LPAREN)in GVfs there's no FUSE mount for it$(RPAREN); such URIs will be
 * passed unmodified to the application.
 * Specifically for GVfs 2.26 and later, the POSIX URI will be mapped
 * back to the GIO URI in the [Gio.File] constructors $(LPAREN)since GVfs
 * implements the GVfs extension point$(RPAREN). As such, if the application
 * needs to examine the URI, it needs to use [Gio.File.getUri]
 * or similar on [Gio.File]. In other words, an application cannot
 * assume that the URI passed to e.g. [Gio.File.newForCommandlineArg]
 * is equal to the result of [Gio.File.getUri]. The following snippet
 * illustrates this:
 * ```c
 * GFile *f;
 * char *uri;
 * file \= g_file_new_for_commandline_arg $(LPAREN)uri_from_commandline$(RPAREN);
 * uri \= g_file_get_uri $(LPAREN)file$(RPAREN);
 * strcmp $(LPAREN)uri, uri_from_commandline$(RPAREN) \=\= 0;
 * g_free $(LPAREN)uri$(RPAREN);
 * if $(LPAREN)g_file_has_uri_scheme $(LPAREN)file, "cdda"$(RPAREN)$(RPAREN)
 * {
 * // do something special with uri
 * }
 * g_object_unref $(LPAREN)file$(RPAREN);
 * ```
 * This code will work when both `cdda://sr0/Track 1.wav` and
 * `/home/user/.gvfs/cdda on sr0/Track 1.wav` is passed to the
 * application. It should be noted that it's generally not safe
 * for applications to rely on the format of a particular URIs.
 * Different launcher applications $(LPAREN)e.g. file managers$(RPAREN) may have
 * different ideas of what a given URI means.
 */
struct GAppInfo;

/**
 * Application Information interface, for operating system portability.
 */
struct GAppInfoIface
{
  /**
   * The parent interface.
   */
  GTypeInterface gIface;

  /**
   * Copies a #GAppInfo.
   */
  extern(C) GAppInfo* function(GAppInfo* appinfo) dup;

  /**
   * Checks two #GAppInfos for equality.
   */
  extern(C) bool function(GAppInfo* appinfo1, GAppInfo* appinfo2) equal;

  /**
   * Gets a string identifier for a #GAppInfo.
   */
  extern(C) const(char)* function(GAppInfo* appinfo) getId;

  /**
   * Gets the name of the application for a #GAppInfo.
   */
  extern(C) const(char)* function(GAppInfo* appinfo) getName;

  /**
   * Gets a short description for the application described by the #GAppInfo.
   */
  extern(C) const(char)* function(GAppInfo* appinfo) getDescription;

  /**
   * Gets the executable name for the #GAppInfo.
   */
  extern(C) const(char)* function(GAppInfo* appinfo) getExecutable;

  /**
   * Gets the #GIcon for the #GAppInfo.
   */
  extern(C) GIcon* function(GAppInfo* appinfo) getIcon;

  /**
   * Launches an application specified by the #GAppInfo.
   */
  extern(C) bool function(GAppInfo* appinfo, GList* files, GAppLaunchContext* context, GError** _err) launch;

  /**
   * Indicates whether the application specified supports launching URIs.
   */
  extern(C) bool function(GAppInfo* appinfo) supportsUris;

  /**
   * Indicates whether the application specified accepts filename arguments.
   */
  extern(C) bool function(GAppInfo* appinfo) supportsFiles;

  /**
   * Launches an application with a list of URIs.
   */
  extern(C) bool function(GAppInfo* appinfo, GList* uris, GAppLaunchContext* context, GError** _err) launchUris;

  /**
   * Returns whether an application should be shown $(LPAREN)e.g. when getting a list of installed applications$(RPAREN).
   * [FreeDesktop.Org Startup Notification Specification](http://standards.freedesktop.org/startup-notification-spec/startup-notification-latest.txt).
   */
  extern(C) bool function(GAppInfo* appinfo) shouldShow;

  /**
   * Sets an application as default for a given content type.
   */
  extern(C) bool function(GAppInfo* appinfo, const(char)* contentType, GError** _err) setAsDefaultForType;

  /**
   * Sets an application as default for a given file extension.
   */
  extern(C) bool function(GAppInfo* appinfo, const(char)* extension, GError** _err) setAsDefaultForExtension;

  /**
   * Adds to the #GAppInfo information about supported file types.
   */
  extern(C) bool function(GAppInfo* appinfo, const(char)* contentType, GError** _err) addSupportsType;

  /**
   * Checks for support for removing supported file types from a #GAppInfo.
   */
  extern(C) bool function(GAppInfo* appinfo) canRemoveSupportsType;

  /**
   * Removes a supported application type from a #GAppInfo.
   */
  extern(C) bool function(GAppInfo* appinfo, const(char)* contentType, GError** _err) removeSupportsType;

  /**
   * Checks if a #GAppInfo can be deleted. Since 2.20
   */
  extern(C) bool function(GAppInfo* appinfo) canDelete;

  /**
   * Deletes a #GAppInfo. Since 2.20
   */
  extern(C) bool function(GAppInfo* appinfo) doDelete;

  /**
   * Gets the commandline for the #GAppInfo. Since 2.20
   */
  extern(C) const(char)* function(GAppInfo* appinfo) getCommandline;

  /**
   * Gets the display name for the #GAppInfo. Since 2.24
   */
  extern(C) const(char)* function(GAppInfo* appinfo) getDisplayName;

  /**
   * Sets the application as the last used. See [Gio.AppInfo.setAsLastUsedForType].
   */
  extern(C) bool function(GAppInfo* appinfo, const(char)* contentType, GError** _err) setAsLastUsedForType;

  /**
   * Retrieves the list of content types that @app_info claims to support.
   */
  extern(C) const(char*)* function(GAppInfo* appinfo) getSupportedTypes;

  /**
   * Asynchronously launches an application with a list of URIs. $(LPAREN)Since: 2.60$(RPAREN)
   */
  extern(C) void function(GAppInfo* appinfo, GList* uris, GAppLaunchContext* context, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) launchUrisAsync;

  /**
   * Finishes an operation started with @launch_uris_async. $(LPAREN)Since: 2.60$(RPAREN)
   */
  extern(C) bool function(GAppInfo* appinfo, GAsyncResult* result, GError** _err) launchUrisFinish;
}

/**
 * `GAppInfoMonitor` monitors application information for changes.
 * `GAppInfoMonitor` is a very simple object used for monitoring the app
 * info database for changes $(LPAREN)newly installed or removed applications$(RPAREN).
 * Call [Gio.AppInfoMonitor.get] to get a `GAppInfoMonitor` and connect
 * to the [Gio.AppInfoMonitor.changed] signal. The signal will be emitted once when
 * the app info database changes, and will not be emitted again until after the
 * next call to [Gio.AppInfo.getAll] or another `g_app_info_*()` function.
 * This is because monitoring the app info database for changes is expensive.
 * The following functions will re-arm the [Gio.AppInfoMonitor.changed]
 * signal so it can be emitted again:
 * - [Gio.AppInfo.getAll]
 * - [Gio.AppInfo.getAllForType]
 * - [Gio.AppInfo.getDefaultForType]
 * - [Gio.AppInfo.getFallbackForType]
 * - [Gio.AppInfo.getRecommendedForType]
 * - [`[Gio.DesktopAppInfo.getImplementations]`](../gio-unix/type_func.DesktopAppInfo.get_implementation.html)
 * - [`[Gio.DesktopAppInfo.new_]`](../gio-unix/ctor.DesktopAppInfo.new.html)
 * - [`[Gio.DesktopAppInfo.newFromFilename]`](../gio-unix/ctor.DesktopAppInfo.new_from_filename.html)
 * - [`[Gio.DesktopAppInfo.newFromKeyfile]`](../gio-unix/ctor.DesktopAppInfo.new_from_keyfile.html)
 * - [`[Gio.DesktopAppInfo.search]`](../gio-unix/type_func.DesktopAppInfo.search.html)
 * The latter functions are available if using
 * [`GDesktopAppInfo`](../gio-unix/class.DesktopAppInfo.html) from
 * `gio-unix-2.0.pc` $(LPAREN)GIR namespace `GioUnix-2.0`$(RPAREN).
 * In the usual case, applications should try to make note of the change
 * $(LPAREN)doing things like invalidating caches$(RPAREN) but not act on it. In
 * particular, applications should avoid making calls to `GAppInfo` APIs
 * in response to the change signal, deferring these until the time that
 * the updated data is actually required. The exception to this case is when
 * application information is actually being displayed on the screen
 * $(LPAREN)for example, during a search or when the list of all applications is shown$(RPAREN).
 * The reason for this is that changes to the list of installed applications
 * often come in groups $(LPAREN)like during system updates$(RPAREN) and rescanning the list
 * on every change is pointless and expensive.
 */
struct GAppInfoMonitor;

/**
 * Integrating the launch with the launching application. This is used to
 * handle for instance startup notification and launching the new application
 * on the same screen as the launching window.
 */
struct GAppLaunchContext
{
  ObjectC parentInstance;

  GAppLaunchContextPrivate* priv;
}

struct GAppLaunchContextClass
{
  GObjectClass parentClass;

  extern(C) char* function(GAppLaunchContext* context, GAppInfo* info, GList* files) getDisplay;

  extern(C) char* function(GAppLaunchContext* context, GAppInfo* info, GList* files) getStartupNotifyId;

  extern(C) void function(GAppLaunchContext* context, const(char)* startupNotifyId) launchFailed;

  extern(C) void function(GAppLaunchContext* context, GAppInfo* info, VariantC* platformData) launched;

  extern(C) void function(GAppLaunchContext* context, GAppInfo* info, VariantC* platformData) launchStarted;

  extern(C) void function() GReserved1;

  extern(C) void function() GReserved2;

  extern(C) void function() GReserved3;
}

struct GAppLaunchContextPrivate;

/**
 * `GApplication` is the core class for application support.
 * A `GApplication` is the foundation of an application. It wraps some
 * low-level platform-specific services and is intended to act as the
 * foundation for higher-level application classes such as
 * `GtkApplication` or `MxApplication`. In general, you should not use
 * this class outside of a higher level framework.
 * `GApplication` provides convenient life-cycle management by maintaining
 * a "use count" for the primary application instance. The use count can
 * be changed using [Gio.Application.hold] and
 * [Gio.Application.release]. If it drops to zero, the application
 * exits. Higher-level classes such as `GtkApplication` employ the use count
 * to ensure that the application stays alive as long as it has any opened
 * windows.
 * Another feature that `GApplication` $(LPAREN)optionally$(RPAREN) provides is process
 * uniqueness. Applications can make use of this functionality by
 * providing a unique application ID. If given, only one application
 * with this ID can be running at a time per session. The session
 * concept is platform-dependent, but corresponds roughly to a graphical
 * desktop login. When your application is launched again, its
 * arguments are passed through platform communication to the already
 * running program. The already running instance of the program is
 * called the "primary instance"; for non-unique applications this is
 * always the current instance. On Linux, the D-Bus session bus
 * is used for communication.
 * The use of `GApplication` differs from some other commonly-used
 * uniqueness libraries $(LPAREN)such as libunique$(RPAREN) in important ways. The
 * application is not expected to manually register itself and check
 * if it is the primary instance. Instead, the main$(LPAREN)$(RPAREN) function of a
 * `GApplication` should do very little more than instantiating the
 * application instance, possibly connecting signal handlers, then
 * calling [Gio.Application.run]. All checks for uniqueness are done
 * internally. If the application is the primary instance then the
 * startup signal is emitted and the mainloop runs. If the application
 * is not the primary instance then a signal is sent to the primary
 * instance and [Gio.Application.run] promptly returns. See the code
 * examples below.
 * If used, the expected form of an application identifier is the
 * same as that of a
 * [D-Bus well-known bus name](https://dbus.freedesktop.org/doc/dbus-specification.html#message-protocol-names-bus).
 * Examples include: `com.example.MyApp`, `org.example.internal_apps.Calculator`,
 * `org._7_zip.Archiver`.
 * For details on valid application identifiers, see [Gio.Application.idIsValid].
 * On Linux, the application identifier is claimed as a well-known bus name
 * on the user's session bus. This means that the uniqueness of your
 * application is scoped to the current session. It also means that your
 * application may provide additional services $(LPAREN)through registration of other
 * object paths$(RPAREN) at that bus name. The registration of these object paths
 * should be done with the shared GDBus session bus. Note that due to the
 * internal architecture of GDBus, method calls can be dispatched at any time
 * $(LPAREN)even if a main loop is not running$(RPAREN). For this reason, you must ensure that
 * any object paths that you wish to register are registered before #GApplication
 * attempts to acquire the bus name of your application $(LPAREN)which happens in
 * [Gio.Application.register]$(RPAREN). Unfortunately, this means that you cannot
 * use property@Gio.Application:is-remote to decide if you want to register
 * object paths.
 * `GApplication` also implements the [Gio.ActionGroup] and [Gio.ActionMap]
 * interfaces and lets you easily export actions by adding them with
 * [Gio.ActionMap.addAction]. When invoking an action by calling
 * [Gio.ActionGroup.activateAction] on the application, it is always
 * invoked in the primary instance. The actions are also exported on
 * the session bus, and GIO provides the [Gio.DBusActionGroup] wrapper to
 * conveniently access them remotely. GIO provides a [Gio.DBusMenuModel] wrapper
 * for remote access to exported [Gio.MenuModel]s.
 * Note: Due to the fact that actions are exported on the session bus,
 * using `maybe` parameters is not supported, since D-Bus does not support
 * `maybe` types.
 * There is a number of different entry points into a `GApplication`:
 * - via 'Activate' $(LPAREN)i.e. just starting the application$(RPAREN)
 * - via 'Open' $(LPAREN)i.e. opening some files$(RPAREN)
 * - by handling a command-line
 * - via activating an action
 * The [Gio.Application.startup] signal lets you handle the application
 * initialization for all of these in a single place.
 * Regardless of which of these entry points is used to start the
 * application, `GApplication` passes some ‘platform data’ from the
 * launching instance to the primary instance, in the form of a
 * [GLib.VariantG] dictionary mapping strings to variants. To use platform
 * data, override the vfunc@Gio.Application.before_emit or
 * vfunc@Gio.Application.after_emit virtual functions
 * in your `GApplication` subclass. When dealing with
 * [Gio.ApplicationCommandLine] objects, the platform data is
 * directly available via [Gio.ApplicationCommandLine.getCwd],
 * [Gio.ApplicationCommandLine.getEnviron] and
 * [Gio.ApplicationCommandLine.getPlatformData].
 * As the name indicates, the platform data may vary depending on the
 * operating system, but it always includes the current directory $(LPAREN)key
 * `cwd`$(RPAREN), and optionally the environment $(LPAREN)ie the set of environment
 * variables and their values$(RPAREN) of the calling process $(LPAREN)key `environ`$(RPAREN).
 * The environment is only added to the platform data if the
 * `G_APPLICATION_SEND_ENVIRONMENT` flag is set. `GApplication` subclasses
 * can add their own platform data by overriding the
 * vfunc@Gio.Application.add_platform_data virtual function. For instance,
 * `GtkApplication` adds startup notification data in this way.
 * To parse commandline arguments you may handle the
 * signal@Gio.Application::command-line signal or override the
 * vfunc@Gio.Application.local_command_line virtual funcion, to parse them in
 * either the primary instance or the local instance, respectively.
 * For an example of opening files with a `GApplication`, see
 * [gapplication-example-open.c](https://gitlab.gnome.org/GNOME/glib/-/blob/HEAD/gio/tests/gapplication-example-open.c).
 * For an example of using actions with `GApplication`, see
 * [gapplication-example-actions.c](https://gitlab.gnome.org/GNOME/glib/-/blob/HEAD/gio/tests/gapplication-example-actions.c).
 * For an example of using extra D-Bus hooks with `GApplication`, see
 * [gapplication-example-dbushooks.c](https://gitlab.gnome.org/GNOME/glib/-/blob/HEAD/gio/tests/gapplication-example-dbushooks.c).
 */
struct GApplication
{
  ObjectC parentInstance;

  GApplicationPrivate* priv;
}

/**
 * Virtual function table for #GApplication.
 */
struct GApplicationClass
{
  GObjectClass parentClass;

  /**
   * invoked on the primary instance immediately after registration
   */
  extern(C) void function(GApplication* application) startup;

  /**
   * invoked on the primary instance when an activation occurs
   */
  extern(C) void function(GApplication* application) activate;

  /**
   * invoked on the primary instance when there are files to open
   */
  extern(C) void function(GApplication* application, GFile** files, int nFiles, const(char)* hint) open;

  /**
   * invoked on the primary instance when a command-line is
   * not handled locally
   */
  extern(C) int function(GApplication* application, GApplicationCommandLine* commandLine) commandLine;

  /**
   * invoked $(LPAREN)locally$(RPAREN). The virtual function has the chance
   * to inspect $(LPAREN)and possibly replace$(RPAREN) command line arguments. See
   * [Gio.Application.run] for more information. Also see the
   * #GApplication::handle-local-options signal, which is a simpler
   * alternative to handling some commandline options locally
   */
  extern(C) bool function(GApplication* application, char*** arguments, int* exitStatus) localCommandLine;

  /**
   * invoked on the primary instance before 'activate', 'open',
   * 'command-line' or any action invocation, gets the 'platform data' from
   * the calling instance
   */
  extern(C) void function(GApplication* application, VariantC* platformData) beforeEmit;

  /**
   * invoked on the primary instance after 'activate', 'open',
   * 'command-line' or any action invocation, gets the 'platform data' from
   * the calling instance
   */
  extern(C) void function(GApplication* application, VariantC* platformData) afterEmit;

  /**
   * invoked $(LPAREN)locally$(RPAREN) to add 'platform data' to be sent to
   * the primary instance when activating, opening or invoking actions
   */
  extern(C) void function(GApplication* application, GVariantBuilder* builder) addPlatformData;

  /**
   * Used to be invoked on the primary instance when the use
   * count of the application drops to zero $(LPAREN)and after any inactivity
   * timeout, if requested$(RPAREN). Not used anymore since 2.32
   */
  extern(C) void function(GApplication* application) quitMainloop;

  /**
   * Used to be invoked on the primary instance from
   * [Gio.Application.run] if the use-count is non-zero. Since 2.32,
   * GApplication is iterating the main context directly and is not
   * using @run_mainloop anymore
   */
  extern(C) void function(GApplication* application) runMainloop;

  /**
   * invoked only on the registered primary instance immediately
   * after the main loop terminates
   */
  extern(C) void function(GApplication* application) shutdown;

  /**
   * invoked locally during registration, if the application is
   * using its D-Bus backend. You can use this to export extra objects on the
   * bus, that need to exist before the application tries to own the bus name.
   * The function is passed the #GDBusConnection to to session bus, and the
   * object path that #GApplication will use to export its D-Bus API.
   * If this function returns %TRUE, registration will proceed; otherwise
   * registration will abort. Since: 2.34
   */
  extern(C) bool function(GApplication* application, GDBusConnection* connection, const(char)* objectPath, GError** _err) dbusRegister;

  /**
   * invoked locally during unregistration, if the application
   * is using its D-Bus backend. Use this to undo anything done by
   * the @dbus_register vfunc. Since: 2.34
   */
  extern(C) void function(GApplication* application, GDBusConnection* connection, const(char)* objectPath) dbusUnregister;

  /**
   * invoked locally after the parsing of the commandline
   * options has occurred. Since: 2.40
   */
  extern(C) int function(GApplication* application, GVariantDict* options) handleLocalOptions;

  /**
   * invoked when another instance is taking over the name. Since: 2.60
   */
  extern(C) bool function(GApplication* application) nameLost;

  void*[7] padding;
}

/**
 * `GApplicationCommandLine` represents a command-line invocation of
 * an application.
 * It is created by [Gio.Application] and emitted
 * in the signal@Gio.Application::command-line signal and virtual function.
 * The class contains the list of arguments that the program was invoked
 * with. It is also possible to query if the commandline invocation was
 * local $(LPAREN)ie: the current process is running in direct response to the
 * invocation$(RPAREN) or remote $(LPAREN)ie: some other process forwarded the
 * commandline to this process$(RPAREN).
 * The `GApplicationCommandLine` object can provide the @argc and @argv
 * parameters for use with the [GLib.OptionContext] command-line parsing API,
 * with the [Gio.ApplicationCommandLine.getArguments] function. See
 * [gapplication-example-cmdline3.c][gapplication-example-cmdline3]
 * for an example.
 * The exit status of the originally-invoked process may be set and
 * messages can be printed to stdout or stderr of that process.
 * For remote invocation, the originally-invoked process exits when
 * [Gio.ApplicationCommandLine.done] method is called. This method is
 * also automatically called when the object is disposed.
 * The main use for `GApplicationCommandLine` $(LPAREN)and the
 * signal@Gio.Application::command-line signal$(RPAREN) is 'Emacs server' like use cases:
 * You can set the `EDITOR` environment variable to have e.g. git use
 * your favourite editor to edit commit messages, and if you already
 * have an instance of the editor running, the editing will happen
 * in the running instance, instead of opening a new one. An important
 * aspect of this use case is that the process that gets started by git
 * does not return until the editing is done.
 * Normally, the commandline is completely handled in the
 * signal@Gio.Application::command-line handler. The launching instance exits
 * once the signal handler in the primary instance has returned, and
 * the return value of the signal handler becomes the exit status
 * of the launching instance.
 * ```c
 * static int
 * command_line $(LPAREN)GApplication            *application,
 * GApplicationCommandLine *cmdline$(RPAREN)
 * {
 * gchar **argv;
 * gint argc;
 * gint i;
 * argv \= g_application_command_line_get_arguments $(LPAREN)cmdline, &argc$(RPAREN);
 * g_application_command_line_print $(LPAREN)cmdline,
 * "This text is written back\n"
 * "to stdout of the caller\n"$(RPAREN);
 * for $(LPAREN)i \= 0; i < argc; i++$(RPAREN)
 * g_print $(LPAREN)"argument %d: %s\n", i, argv[i]$(RPAREN);
 * g_strfreev $(LPAREN)argv$(RPAREN);
 * return 0;
 * }
 * ```
 * The complete example can be found here:
 * [gapplication-example-cmdline.c](https://gitlab.gnome.org/GNOME/glib/-/blob/HEAD/gio/tests/gapplication-example-cmdline.c)
 * In more complicated cases, the handling of the commandline can be
 * split between the launcher and the primary instance.
 * ```c
 * static gboolean
 * test_local_cmdline $(LPAREN)GApplication   *application,
 * gchar        ***arguments,
 * gint           *exit_status$(RPAREN)
 * {
 * gint i, j;
 * gchar **argv;
 * argv \= *arguments;
 * if $(LPAREN)argv[0] \=\= NULL$(RPAREN)
 * {
 * *exit_status \= 0;
 * return FALSE;
 * }
 * i \= 1;
 * while $(LPAREN)argv[i]$(RPAREN)
 * {
 * if $(LPAREN)g_str_has_prefix $(LPAREN)argv[i], "--local-"$(RPAREN)$(RPAREN)
 * {
 * g_print $(LPAREN)"handling argument %s locally\n", argv[i]$(RPAREN);
 * g_free $(LPAREN)argv[i]$(RPAREN);
 * for $(LPAREN)j \= i; argv[j]; j++$(RPAREN)
 * argv[j] \= argv[j + 1];
 * }
 * else
 * {
 * g_print $(LPAREN)"not handling argument %s locally\n", argv[i]$(RPAREN);
 * i++;
 * }
 * }
 * *exit_status \= 0;
 * return FALSE;
 * }
 * static void
 * test_application_class_init $(LPAREN)TestApplicationClass *class$(RPAREN)
 * {
 * G_APPLICATION_CLASS $(LPAREN)class$(RPAREN)->local_command_line \= test_local_cmdline;
 * ...
 * }
 * ```
 * In this example of split commandline handling, options that start
 * with `--local-` are handled locally, all other options are passed
 * to the signal@Gio.Application::command-line handler which runs in the primary
 * instance.
 * The complete example can be found here:
 * [gapplication-example-cmdline2.c](https://gitlab.gnome.org/GNOME/glib/-/blob/HEAD/gio/tests/gapplication-example-cmdline2.c)
 * If handling the commandline requires a lot of work, it may be better to defer it.
 * ```c
 * static gboolean
 * my_cmdline_handler $(LPAREN)gpointer data$(RPAREN)
 * {
 * GApplicationCommandLine *cmdline \= data;
 * // do the heavy lifting in an idle
 * g_application_command_line_set_exit_status $(LPAREN)cmdline, 0$(RPAREN);
 * g_object_unref $(LPAREN)cmdline$(RPAREN); // this releases the application
 * return G_SOURCE_REMOVE;
 * }
 * static int
 * command_line $(LPAREN)GApplication            *application,
 * GApplicationCommandLine *cmdline$(RPAREN)
 * {
 * // keep the application running until we are done with this commandline
 * g_application_hold $(LPAREN)application$(RPAREN);
 * g_object_set_data_full $(LPAREN)G_OBJECT $(LPAREN)cmdline$(RPAREN),
 * "application", application,
 * $(LPAREN)GDestroyNotify$(RPAREN)g_application_release$(RPAREN);
 * g_object_ref $(LPAREN)cmdline$(RPAREN);
 * g_idle_add $(LPAREN)my_cmdline_handler, cmdline$(RPAREN);
 * return 0;
 * }
 * ```
 * In this example the commandline is not completely handled before
 * the signal@Gio.Application::command-line handler returns. Instead, we keep
 * a reference to the `GApplicationCommandLine` object and handle it
 * later $(LPAREN)in this example, in an idle$(RPAREN). Note that it is necessary to
 * hold the application until you are done with the commandline.
 * The complete example can be found here:
 * [gapplication-example-cmdline3.c](https://gitlab.gnome.org/GNOME/glib/-/blob/HEAD/gio/tests/gapplication-example-cmdline3.c)
 */
struct GApplicationCommandLine
{
  ObjectC parentInstance;

  GApplicationCommandLinePrivate* priv;
}

/**
 * The #GApplicationCommandLineClass-struct
 * contains private data only.
 */
struct GApplicationCommandLineClass
{
  GObjectClass parentClass;

  extern(C) void function(GApplicationCommandLine* cmdline, const(char)* message) printLiteral;

  extern(C) void function(GApplicationCommandLine* cmdline, const(char)* message) printerrLiteral;

  extern(C) GInputStream* function(GApplicationCommandLine* cmdline) getStdin;

  extern(C) void function(GApplicationCommandLine* cmdline) done;

  void*[10] padding;
}

struct GApplicationCommandLinePrivate;

struct GApplicationPrivate;

/**
 * `GAsyncInitable` is an interface for asynchronously initializable objects.
 * This is the asynchronous version of [Gio.Initable]; it behaves the same
 * in all ways except that initialization is asynchronous. For more details
 * see the descriptions on `GInitable`.
 * A class may implement both the `GInitable` and `GAsyncInitable` interfaces.
 * Users of objects implementing this are not intended to use the interface
 * method directly; instead it will be used automatically in various ways.
 * For C applications you generally just call [Gio.AsyncInitable.newAsync]
 * directly, or indirectly via a foo_thing_new_async$(LPAREN)$(RPAREN) wrapper. This will call
 * [Gio.AsyncInitable.initAsync] under the covers, calling back with `NULL`
 * and a set `GError` on failure.
 * A typical implementation might look something like this:
 * ```c
 * enum {
 * NOT_INITIALIZED,
 * INITIALIZING,
 * INITIALIZED
 * };
 * static void
 * _foo_ready_cb $(LPAREN)Foo *self$(RPAREN)
 * {
 * GList *l;
 * self->priv->state \= INITIALIZED;
 * for $(LPAREN)l \= self->priv->init_results; l !\= NULL; l \= l->next$(RPAREN)
 * {
 * GTask *task \= l->data;
 * if $(LPAREN)self->priv->success$(RPAREN)
 * g_task_return_boolean $(LPAREN)task, TRUE$(RPAREN);
 * else
 * g_task_return_new_error $(LPAREN)task, ...$(RPAREN);
 * g_object_unref $(LPAREN)task$(RPAREN);
 * }
 * g_list_free $(LPAREN)self->priv->init_results$(RPAREN);
 * self->priv->init_results \= NULL;
 * }
 * static void
 * foo_init_async $(LPAREN)GAsyncInitable       *initable,
 * int                   io_priority,
 * GCancellable         *cancellable,
 * GAsyncReadyCallback   callback,
 * gpointer              user_data$(RPAREN)
 * {
 * Foo *self \= FOO $(LPAREN)initable$(RPAREN);
 * GTask *task;
 * task \= g_task_new $(LPAREN)initable, cancellable, callback, user_data$(RPAREN);
 * g_task_set_name $(LPAREN)task, G_STRFUNC$(RPAREN);
 * switch $(LPAREN)self->priv->state$(RPAREN)
 * {
 * case NOT_INITIALIZED:
 * _foo_get_ready $(LPAREN)self$(RPAREN);
 * self->priv->init_results \= g_list_append $(LPAREN)self->priv->init_results,
 * task$(RPAREN);
 * self->priv->state \= INITIALIZING;
 * break;
 * case INITIALIZING:
 * self->priv->init_results \= g_list_append $(LPAREN)self->priv->init_results,
 * task$(RPAREN);
 * break;
 * case INITIALIZED:
 * if $(LPAREN)!self->priv->success$(RPAREN)
 * g_task_return_new_error $(LPAREN)task, ...$(RPAREN);
 * else
 * g_task_return_boolean $(LPAREN)task, TRUE$(RPAREN);
 * g_object_unref $(LPAREN)task$(RPAREN);
 * break;
 * }
 * }
 * static gboolean
 * foo_init_finish $(LPAREN)GAsyncInitable       *initable,
 * GAsyncResult         *result,
 * GError              **error$(RPAREN)
 * {
 * g_return_val_if_fail $(LPAREN)g_task_is_valid $(LPAREN)result, initable$(RPAREN), FALSE$(RPAREN);
 * return g_task_propagate_boolean $(LPAREN)G_TASK $(LPAREN)result$(RPAREN), error$(RPAREN);
 * }
 * static void
 * foo_async_initable_iface_init $(LPAREN)gpointer g_iface,
 * gpointer data$(RPAREN)
 * {
 * GAsyncInitableIface *iface \= g_iface;
 * iface->init_async \= foo_init_async;
 * iface->init_finish \= foo_init_finish;
 * }
 * ```
 */
struct GAsyncInitable;

/**
 * Provides an interface for asynchronous initializing object such that
 * initialization may fail.
 */
struct GAsyncInitableIface
{
  /**
   * The parent interface.
   */
  GTypeInterface gIface;

  /**
   * Starts initialization of the object.
   */
  extern(C) void function(GAsyncInitable* initable, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) initAsync;

  /**
   * Finishes initialization of the object.
   */
  extern(C) bool function(GAsyncInitable* initable, GAsyncResult* res, GError** _err) initFinish;
}

/**
 * `GAsyncResult` provides a base class for implementing asynchronous function results.
 * Asynchronous operations are broken up into two separate operations
 * which are chained together by a `GAsyncReadyCallback`. To begin
 * an asynchronous operation, provide a `GAsyncReadyCallback` to the
 * asynchronous function. This callback will be triggered when the
 * operation has completed, and must be run in a later iteration of
 * the thread-default main context $(LPAREN)see
 * [GLib.MainContext.pushThreadDefault]$(RPAREN) from where the operation was
 * initiated. It will be passed a `GAsyncResult` instance filled with the
 * details of the operation's success or failure, the object the asynchronous
 * function was started for and any error codes returned. The asynchronous
 * callback function is then expected to call the corresponding `_finish$(LPAREN)$(RPAREN)`
 * function, passing the object the function was called for, the
 * `GAsyncResult` instance, and $(LPAREN)optionally$(RPAREN) an @error to grab any
 * error conditions that may have occurred.
 * The `_finish$(LPAREN)$(RPAREN)` function for an operation takes the generic result
 * $(LPAREN)of type `GAsyncResult`$(RPAREN) and returns the specific result that the
 * operation in question yields $(LPAREN)e.g. a [Gio.FileEnumerator] for a
 * "enumerate children" operation$(RPAREN). If the result or error status of the
 * operation is not needed, there is no need to call the `_finish$(LPAREN)$(RPAREN)`
 * function; GIO will take care of cleaning up the result and error
 * information after the `GAsyncReadyCallback` returns. You can pass
 * `NULL` for the `GAsyncReadyCallback` if you don't need to take any
 * action at all after the operation completes. Applications may also
 * take a reference to the `GAsyncResult` and call `_finish$(LPAREN)$(RPAREN)` later;
 * however, the `_finish$(LPAREN)$(RPAREN)` function may be called at most once.
 * Example of a typical asynchronous operation flow:
 * ```c
 * void _theoretical_frobnitz_async $(LPAREN)Theoretical         *t,
 * GCancellable        *c,
 * GAsyncReadyCallback  cb,
 * gpointer             u$(RPAREN);
 * gboolean _theoretical_frobnitz_finish $(LPAREN)Theoretical   *t,
 * GAsyncResult  *res,
 * GError       **e$(RPAREN);
 * static void
 * frobnitz_result_func $(LPAREN)GObject      *source_object,
 * GAsyncResult *res,
 * gpointer      user_data$(RPAREN)
 * {
 * gboolean success \= FALSE;
 * success \= _theoretical_frobnitz_finish $(LPAREN)source_object, res, NULL$(RPAREN);
 * if $(LPAREN)success$(RPAREN)
 * g_printf $(LPAREN)"Hurray!\n"$(RPAREN);
 * else
 * g_printf $(LPAREN)"Uh oh!\n"$(RPAREN);
 * ...
 * }
 * int main $(LPAREN)int argc, void *argv[]$(RPAREN)
 * {
 * ...
 * _theoretical_frobnitz_async $(LPAREN)theoretical_data,
 * NULL,
 * frobnitz_result_func,
 * NULL$(RPAREN);
 * ...
 * }
 * ```
 * The callback for an asynchronous operation is called only once, and is
 * always called, even in the case of a cancelled operation. On cancellation
 * the result is a `G_IO_ERROR_CANCELLED` error.
 * ## I/O Priority
 * Many I/O-related asynchronous operations have a priority parameter,
 * which is used in certain cases to determine the order in which
 * operations are executed. They are not used to determine system-wide
 * I/O scheduling. Priorities are integers, with lower numbers indicating
 * higher priority. It is recommended to choose priorities between
 * `G_PRIORITY_LOW` and `G_PRIORITY_HIGH`, with `G_PRIORITY_DEFAULT`
 * as a default.
 */
struct GAsyncResult;

/**
 * Interface definition for #GAsyncResult.
 */
struct GAsyncResultIface
{
  /**
   * The parent interface.
   */
  GTypeInterface gIface;

  /**
   * Gets the user data passed to the callback.
   */
  extern(C) void* function(GAsyncResult* res) getUserData;

  /**
   * Gets the source object that issued the asynchronous operation.
   */
  extern(C) ObjectC* function(GAsyncResult* res) getSourceObject;

  /**
   * Checks if a result is tagged with a particular source.
   */
  extern(C) bool function(GAsyncResult* res, void* sourceTag) isTagged;
}

/**
 * Buffered input stream implements #GFilterInputStream and provides
 * for buffered reads.
 * By default, `GBufferedInputStream`'s buffer size is set at 4 kilobytes.
 * To create a buffered input stream, use [Gio.BufferedInputStream.new_],
 * or [Gio.BufferedInputStream.newSized] to specify the buffer's size at
 * construction.
 * To get the size of a buffer within a buffered input stream, use
 * [Gio.BufferedInputStream.getBufferSize]. To change the size of a
 * buffered input stream's buffer, use [Gio.BufferedInputStream.setBufferSize].
 * Note that the buffer's size cannot be reduced below the size of the data within the buffer.
 */
struct GBufferedInputStream
{
  GFilterInputStream parentInstance;

  GBufferedInputStreamPrivate* priv;
}

struct GBufferedInputStreamClass
{
  GFilterInputStreamClass parentClass;

  extern(C) ptrdiff_t function(GBufferedInputStream* stream, ptrdiff_t count, GCancellable* cancellable, GError** _err) fill;

  extern(C) void function(GBufferedInputStream* stream, ptrdiff_t count, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) fillAsync;

  extern(C) ptrdiff_t function(GBufferedInputStream* stream, GAsyncResult* result, GError** _err) fillFinish;

  extern(C) void function() GReserved1;

  extern(C) void function() GReserved2;

  extern(C) void function() GReserved3;

  extern(C) void function() GReserved4;

  extern(C) void function() GReserved5;
}

struct GBufferedInputStreamPrivate;

/**
 * Buffered output stream implements [Gio.FilterOutputStream] and provides
 * for buffered writes.
 * By default, `GBufferedOutputStream`'s buffer size is set at 4 kilobytes.
 * To create a buffered output stream, use [Gio.BufferedOutputStream.new_],
 * or [Gio.BufferedOutputStream.newSized] to specify the buffer's size
 * at construction.
 * To get the size of a buffer within a buffered input stream, use
 * [Gio.BufferedOutputStream.getBufferSize]. To change the size of a
 * buffered output stream's buffer, use [Gio.BufferedOutputStream.setBufferSize].
 * Note that the buffer's size cannot be reduced below the size of the data within the buffer.
 */
struct GBufferedOutputStream
{
  GFilterOutputStream parentInstance;

  GBufferedOutputStreamPrivate* priv;
}

struct GBufferedOutputStreamClass
{
  GFilterOutputStreamClass parentClass;

  extern(C) void function() GReserved1;

  extern(C) void function() GReserved2;
}

struct GBufferedOutputStreamPrivate;

/**
 * `GBytesIcon` specifies an image held in memory in a common format $(LPAREN)usually
 * PNG$(RPAREN) to be used as icon.
 */
struct GBytesIcon;

/**
 * `GCancellable` allows operations to be cancelled.
 * `GCancellable` is a thread-safe operation cancellation stack used
 * throughout GIO to allow for cancellation of synchronous and
 * asynchronous operations.
 */
struct GCancellable
{
  ObjectC parentInstance;

  GCancellablePrivate* priv;
}

struct GCancellableClass
{
  GObjectClass parentClass;

  extern(C) void function(GCancellable* cancellable) cancelled;

  extern(C) void function() GReserved1;

  extern(C) void function() GReserved2;

  extern(C) void function() GReserved3;

  extern(C) void function() GReserved4;

  extern(C) void function() GReserved5;
}

struct GCancellablePrivate;

/**
 * `GCharsetConverter` is an implementation of [Gio.Converter] based on
 * [GLib.IConv].
 */
struct GCharsetConverter;

struct GCharsetConverterClass
{
  GObjectClass parentClass;
}

/**
 * `GConverter` is an interface for streaming conversions.
 * `GConverter` is implemented by objects that convert
 * binary data in various ways. The conversion can be
 * stateful and may fail at any place.
 * Some example conversions are: character set conversion,
 * compression, decompression and regular expression
 * replace.
 */
struct GConverter;

/**
 * Provides an interface for converting data from one type
 * to another type. The conversion can be stateful
 * and may fail at any place.
 */
struct GConverterIface
{
  /**
   * The parent interface.
   */
  GTypeInterface gIface;

  /**
   * Converts data.
   */
  extern(C) GConverterResult function(GConverter* converter, void* inbuf, size_t inbufSize, void* outbuf, size_t outbufSize, GConverterFlags flags, size_t* bytesRead, size_t* bytesWritten, GError** _err) convert;

  /**
   * Reverts the internal state of the converter to its initial state.
   */
  extern(C) void function(GConverter* converter) reset;
}

/**
 * Converter input stream implements [Gio.InputStream] and allows
 * conversion of data of various types during reading.
 * As of GLib 2.34, `GConverterInputStream` implements
 * [Gio.PollableInputStream].
 */
struct GConverterInputStream
{
  GFilterInputStream parentInstance;

  GConverterInputStreamPrivate* priv;
}

struct GConverterInputStreamClass
{
  GFilterInputStreamClass parentClass;

  extern(C) void function() GReserved1;

  extern(C) void function() GReserved2;

  extern(C) void function() GReserved3;

  extern(C) void function() GReserved4;

  extern(C) void function() GReserved5;
}

struct GConverterInputStreamPrivate;

/**
 * Converter output stream implements [Gio.OutputStream] and allows
 * conversion of data of various types during reading.
 * As of GLib 2.34, `GConverterOutputStream` implements
 * [Gio.PollableOutputStream].
 */
struct GConverterOutputStream
{
  GFilterOutputStream parentInstance;

  GConverterOutputStreamPrivate* priv;
}

struct GConverterOutputStreamClass
{
  GFilterOutputStreamClass parentClass;

  extern(C) void function() GReserved1;

  extern(C) void function() GReserved2;

  extern(C) void function() GReserved3;

  extern(C) void function() GReserved4;

  extern(C) void function() GReserved5;
}

struct GConverterOutputStreamPrivate;

/**
 * The `GCredentials` type is a reference-counted wrapper for native
 * credentials.
 * The information in `GCredentials` is typically used for identifying,
 * authenticating and authorizing other processes.
 * Some operating systems supports looking up the credentials of the remote
 * peer of a communication endpoint - see e.g. [Gio.Socket.getCredentials].
 * Some operating systems supports securely sending and receiving
 * credentials over a Unix Domain Socket, see [Gio.UnixCredentialsMessage],
 * [Gio.UnixConnection.sendCredentials] and
 * [Gio.UnixConnection.receiveCredentials] for details.
 * On Linux, the native credential type is a `struct ucred` - see the
 * [`unix$(LPAREN)7$(RPAREN)` man page]$(LPAREN)$(RPAREN)(man:unix7) for details. This corresponds to
 * `G_CREDENTIALS_TYPE_LINUX_UCRED`.
 * On Apple operating systems $(LPAREN)including iOS, tvOS, and macOS$(RPAREN), the native credential
 * type is a `struct xucred`. This corresponds to `G_CREDENTIALS_TYPE_APPLE_XUCRED`.
 * On FreeBSD, Debian GNU/kFreeBSD, and GNU/Hurd, the native credential type is a
 * `struct cmsgcred`. This corresponds to `G_CREDENTIALS_TYPE_FREEBSD_CMSGCRED`.
 * On NetBSD, the native credential type is a `struct unpcbid`.
 * This corresponds to `G_CREDENTIALS_TYPE_NETBSD_UNPCBID`.
 * On OpenBSD, the native credential type is a `struct sockpeercred`.
 * This corresponds to `G_CREDENTIALS_TYPE_OPENBSD_SOCKPEERCRED`.
 * On Solaris $(LPAREN)including OpenSolaris and its derivatives$(RPAREN), the native credential type
 * is a `ucred_t`. This corresponds to `G_CREDENTIALS_TYPE_SOLARIS_UCRED`.
 * Since GLib 2.72, on Windows, the native credentials may contain the PID of a
 * process. This corresponds to `G_CREDENTIALS_TYPE_WIN32_PID`.
 */
struct GCredentials;

/**
 * Class structure for #GCredentials.
 */
struct GCredentialsClass;

/**
 * `GDBusActionGroup` is an implementation of the [Gio.ActionGroup]
 * interface.
 * `GDBusActionGroup` can be used as a proxy for an action group
 * that is exported over D-Bus with [Gio.DBusConnection.exportActionGroup].
 */
struct GDBusActionGroup;

/**
 * Information about an annotation.
 */
struct GDBusAnnotationInfo
{
  /**
   * The reference count or -1 if statically allocated.
   */
  int refCount;

  /**
   * The name of the annotation, e.g. "org.freedesktop.DBus.Deprecated".
   */
  char* key;

  /**
   * The value of the annotation.
   */
  char* value;

  /**
   * A pointer to a %NULL-terminated array of pointers to #GDBusAnnotationInfo structures or %NULL if there are no annotations.
   */
  GDBusAnnotationInfo** annotations;
}

/**
 * Information about an argument for a method or a signal.
 */
struct GDBusArgInfo
{
  /**
   * The reference count or -1 if statically allocated.
   */
  int refCount;

  /**
   * Name of the argument, e.g. @unix_user_id.
   */
  char* name;

  /**
   * D-Bus signature of the argument $(LPAREN)a single complete type$(RPAREN).
   */
  char* signature;

  /**
   * A pointer to a %NULL-terminated array of pointers to #GDBusAnnotationInfo structures or %NULL if there are no annotations.
   */
  GDBusAnnotationInfo** annotations;
}

/**
 * `GDBusAuthObserver` provides a mechanism for participating
 * in how a [Gio.DBusServer] [](or a Gio.DBusConnection)
 * authenticates remote peers.
 * Simply instantiate a `GDBusAuthObserver` and connect to the
 * signals you are interested in. Note that new signals may be added
 * in the future.
 * ## Controlling Authentication Mechanisms
 * By default, a `GDBusServer` or server-side `GDBusConnection` will allow
 * any authentication mechanism to be used. If you only want to allow D-Bus
 * connections with the `EXTERNAL` mechanism, which makes use of credentials
 * passing and is the recommended mechanism for modern Unix platforms such
 * as Linux and the BSD family, you would use a signal handler like this:
 * ```c
 * static gboolean
 * on_allow_mechanism $(LPAREN)GDBusAuthObserver *observer,
 * const gchar       *mechanism,
 * gpointer           user_data$(RPAREN)
 * {
 * if $(LPAREN)g_strcmp0 $(LPAREN)mechanism, "EXTERNAL"$(RPAREN) \=\= 0$(RPAREN)
 * {
 * return TRUE;
 * }
 * return FALSE;
 * }
 * ```
 * ## Controlling Authorization
 * By default, a `GDBusServer` or server-side `GDBusConnection` will accept
 * connections from any successfully authenticated user $(LPAREN)but not from
 * anonymous connections using the `ANONYMOUS` mechanism$(RPAREN). If you only
 * want to allow D-Bus connections from processes owned by the same uid
 * as the server, since GLib 2.68, you should use the
 * `G_DBUS_SERVER_FLAGS_AUTHENTICATION_REQUIRE_SAME_USER` flag. It’s equivalent
 * to the following signal handler:
 * ```c
 * static gboolean
 * on_authorize_authenticated_peer $(LPAREN)GDBusAuthObserver *observer,
 * GIOStream         *stream,
 * GCredentials      *credentials,
 * gpointer           user_data$(RPAREN)
 * {
 * gboolean authorized;
 * authorized \= FALSE;
 * if $(LPAREN)credentials !\= NULL$(RPAREN)
 * {
 * GCredentials *own_credentials;
 * own_credentials \= g_credentials_new $(LPAREN)$(RPAREN);
 * if $(LPAREN)g_credentials_is_same_user $(LPAREN)credentials, own_credentials, NULL$(RPAREN)$(RPAREN)
 * authorized \= TRUE;
 * g_object_unref $(LPAREN)own_credentials$(RPAREN);
 * }
 * return authorized;
 * }
 * ```
 */
struct GDBusAuthObserver;

/**
 * The `GDBusConnection` type is used for D-Bus connections to remote
 * peers such as a message buses.
 * It is a low-level API that offers a lot of flexibility. For instance,
 * it lets you establish a connection over any transport that can by represented
 * as a [Gio.IOStream].
 * This class is rarely used directly in D-Bus clients. If you are writing
 * a D-Bus client, it is often easier to use the func@Gio.bus_own_name,
 * func@Gio.bus_watch_name or [Gio.DBusProxy.newForBus] APIs.
 * As an exception to the usual GLib rule that a particular object must not
 * be used by two threads at the same time, `GDBusConnection`s methods may be
 * called from any thread. This is so that func@Gio.bus_get and
 * func@Gio.bus_get_sync can safely return the same `GDBusConnection` when
 * called from any thread.
 * Most of the ways to obtain a `GDBusConnection` automatically initialize it
 * $(LPAREN)i.e. connect to D-Bus$(RPAREN): for instance, [Gio.DBusConnection.new_] and
 * func@Gio.bus_get, and the synchronous versions of those methods, give you
 * an initialized connection. Language bindings for GIO should use
 * [Gio.Initable.new_] or [Gio.AsyncInitable.newAsync], which also
 * initialize the connection.
 * If you construct an uninitialized `GDBusConnection`, such as via
 * [GObject.ObjectG.new_], you must initialize it via [Gio.Initable.init_] or
 * [Gio.AsyncInitable.initAsync] before using its methods or properties.
 * Calling methods or accessing properties on a `GDBusConnection` that has not
 * completed initialization successfully is considered to be invalid, and leads
 * to undefined behaviour. In particular, if initialization fails with a
 * `GError`, the only valid thing you can do with that `GDBusConnection` is to
 * free it with [GObject.ObjectG.unref].
 * ## An example D-Bus server
 * Here is an example for a D-Bus server:
 * [gdbus-example-server.c](https://gitlab.gnome.org/GNOME/glib/-/blob/HEAD/gio/tests/gdbus-example-server.c)
 * ## An example for exporting a subtree
 * Here is an example for exporting a subtree:
 * [gdbus-example-subtree.c](https://gitlab.gnome.org/GNOME/glib/-/blob/HEAD/gio/tests/gdbus-example-subtree.c)
 * ## An example for file descriptor passing
 * Here is an example for passing UNIX file descriptors:
 * [gdbus-unix-fd-client.c](https://gitlab.gnome.org/GNOME/glib/-/blob/HEAD/gio/tests/gdbus-example-unix-fd-client.c)
 * ## An example for exporting a GObject
 * Here is an example for exporting a #GObject:
 * [gdbus-example-export.c](https://gitlab.gnome.org/GNOME/glib/-/blob/HEAD/gio/tests/gdbus-example-export.c)
 */
struct GDBusConnection;

/**
 * Struct used in [Gio.Global.dbusErrorRegisterErrorDomain].
 */
struct GDBusErrorEntry
{
  /**
   * An error code.
   */
  int errorCode;

  /**
   * The D-Bus error name to associate with @error_code.
   */
  const(char)* dbusErrorName;
}

/**
 * Base type for D-Bus interfaces.
 * The `GDBusInterface` type is the base type for D-Bus interfaces both
 * on the service side $(LPAREN)see [Gio.DBusInterfaceSkeleton]$(RPAREN) and client side
 * $(LPAREN)see [Gio.DBusProxy]$(RPAREN).
 */
struct GDBusInterface;

/**
 * Base type for D-Bus interfaces.
 */
struct GDBusInterfaceIface
{
  /**
   * The parent interface.
   */
  GTypeInterface parentIface;

  /**
   * Returns a #GDBusInterfaceInfo. See [Gio.DBusInterface.getInfo].
   */
  extern(C) GDBusInterfaceInfo* function(GDBusInterface* interface_) getInfo;

  /**
   * Gets the enclosing #GDBusObject. See [Gio.DBusInterface.getObject].
   */
  extern(C) GDBusObject* function(GDBusInterface* interface_) getObject;

  /**
   * Sets the enclosing #GDBusObject. See [Gio.DBusInterface.setObject].
   */
  extern(C) void function(GDBusInterface* interface_, GDBusObject* object) setObject;

  /**
   * Gets a reference to the enclosing #GDBusObject. See [Gio.DBusInterface.dupObject]. Added in 2.32.
   */
  extern(C) GDBusObject* function(GDBusInterface* interface_) dupObject;
}

/**
 * Information about a D-Bus interface.
 */
struct GDBusInterfaceInfo
{
  /**
   * The reference count or -1 if statically allocated.
   */
  int refCount;

  /**
   * The name of the D-Bus interface, e.g. "org.freedesktop.DBus.Properties".
   */
  char* name;

  /**
   * A pointer to a %NULL-terminated array of pointers to #GDBusMethodInfo structures or %NULL if there are no methods.
   */
  GDBusMethodInfo** methods;

  /**
   * A pointer to a %NULL-terminated array of pointers to #GDBusSignalInfo structures or %NULL if there are no signals.
   */
  GDBusSignalInfo** signals;

  /**
   * A pointer to a %NULL-terminated array of pointers to #GDBusPropertyInfo structures or %NULL if there are no properties.
   */
  GDBusPropertyInfo** properties;

  /**
   * A pointer to a %NULL-terminated array of pointers to #GDBusAnnotationInfo structures or %NULL if there are no annotations.
   */
  GDBusAnnotationInfo** annotations;
}

/**
 * Abstract base class for D-Bus interfaces on the service side.
 */
struct GDBusInterfaceSkeleton
{
  ObjectC parentInstance;

  GDBusInterfaceSkeletonPrivate* priv;
}

/**
 * Class structure for #GDBusInterfaceSkeleton.
 */
struct GDBusInterfaceSkeletonClass
{
  /**
   * The parent class.
   */
  GObjectClass parentClass;

  /**
   * Returns a #GDBusInterfaceInfo. See [Gio.DBusInterfaceSkeleton.getInfo] for details.
   */
  extern(C) GDBusInterfaceInfo* function(GDBusInterfaceSkeleton* interface_) getInfo;

  /**
   * Returns a #GDBusInterfaceVTable. See [Gio.DBusInterfaceSkeleton.getVtable] for details.
   */
  extern(C) GDBusInterfaceVTable* function(GDBusInterfaceSkeleton* interface_) getVtable;

  /**
   * Returns a #GVariant with all properties. See [Gio.DBusInterfaceSkeleton.getProperties].
   */
  extern(C) VariantC* function(GDBusInterfaceSkeleton* interface_) getProperties;

  /**
   * Emits outstanding changes, if any. See [Gio.DBusInterfaceSkeleton.flush].
   */
  extern(C) void function(GDBusInterfaceSkeleton* interface_) flush;

  void*[8] vfuncPadding;

  /**
   * Signal class handler for the #GDBusInterfaceSkeleton::g-authorize-method signal.
   */
  extern(C) bool function(GDBusInterfaceSkeleton* interface_, GDBusMethodInvocation* invocation) gAuthorizeMethod;

  void*[8] signalPadding;
}

struct GDBusInterfaceSkeletonPrivate;

/**
 * Virtual table for handling properties and method calls for a D-Bus
 * interface.
 * Since 2.38, if you want to handle getting/setting D-Bus properties
 * asynchronously, give %NULL as your get_property$(LPAREN)$(RPAREN) or set_property$(LPAREN)$(RPAREN)
 * function. The D-Bus call will be directed to your @method_call function,
 * with the provided @interface_name set to "org.freedesktop.DBus.Properties".
 * Ownership of the #GDBusMethodInvocation object passed to the
 * method_call$(LPAREN)$(RPAREN) function is transferred to your handler; you must
 * call one of the methods of #GDBusMethodInvocation to return a reply
 * $(LPAREN)possibly empty$(RPAREN), or an error. These functions also take ownership
 * of the passed-in invocation object, so unless the invocation
 * object has otherwise been referenced, it will be then be freed.
 * Calling one of these functions may be done within your
 * method_call$(LPAREN)$(RPAREN) implementation but it also can be done at a later
 * point to handle the method asynchronously.
 * The usual checks on the validity of the calls is performed. For
 * `Get` calls, an error is automatically returned if the property does
 * not exist or the permissions do not allow access. The same checks are
 * performed for `Set` calls, and the provided value is also checked for
 * being the correct type.
 * For both `Get` and `Set` calls, the #GDBusMethodInvocation
 * passed to the @method_call handler can be queried with
 * [Gio.DBusMethodInvocation.getPropertyInfo] to get a pointer
 * to the #GDBusPropertyInfo of the property.
 * If you have readable properties specified in your interface info,
 * you must ensure that you either provide a non-%NULL @get_property$(LPAREN)$(RPAREN)
 * function or provide implementations of both the `Get` and `GetAll`
 * methods on org.freedesktop.DBus.Properties interface in your @method_call
 * function. Note that the required return type of the `Get` call is
 * `$(LPAREN)v$(RPAREN)`, not the type of the property. `GetAll` expects a return value
 * of type `a{sv}`.
 * If you have writable properties specified in your interface info,
 * you must ensure that you either provide a non-%NULL @set_property$(LPAREN)$(RPAREN)
 * function or provide an implementation of the `Set` call. If implementing
 * the call, you must return the value of type %G_VARIANT_TYPE_UNIT.
 */
struct GDBusInterfaceVTable
{
  /**
   * Function for handling incoming method calls.
   */
  GDBusInterfaceMethodCallFunc methodCall;

  /**
   * Function for getting a property.
   */
  GDBusInterfaceGetPropertyFunc getProperty;

  /**
   * Function for setting a property.
   */
  GDBusInterfaceSetPropertyFunc setProperty;

  void*[8] padding;
}

/**
 * `GDBusMenuModel` is an implementation of [Gio.MenuModel] that can be
 * used as a proxy for a menu model that is exported over D-Bus with
 * [Gio.DBusConnection.exportMenuModel].
 */
struct GDBusMenuModel;

/**
 * A type for representing D-Bus messages that can be sent or received
 * on a [Gio.DBusConnection].
 */
struct GDBusMessage;

/**
 * Information about a method on an D-Bus interface.
 */
struct GDBusMethodInfo
{
  /**
   * The reference count or -1 if statically allocated.
   */
  int refCount;

  /**
   * The name of the D-Bus method, e.g. @RequestName.
   */
  char* name;

  /**
   * A pointer to a %NULL-terminated array of pointers to #GDBusArgInfo structures or %NULL if there are no in arguments.
   */
  GDBusArgInfo** inArgs;

  /**
   * A pointer to a %NULL-terminated array of pointers to #GDBusArgInfo structures or %NULL if there are no out arguments.
   */
  GDBusArgInfo** outArgs;

  /**
   * A pointer to a %NULL-terminated array of pointers to #GDBusAnnotationInfo structures or %NULL if there are no annotations.
   */
  GDBusAnnotationInfo** annotations;
}

/**
 * Instances of the `GDBusMethodInvocation` class are used when
 * handling D-Bus method calls. It provides a way to asynchronously
 * return results and errors.
 * The normal way to obtain a `GDBusMethodInvocation` object is to receive
 * it as an argument to the `handle_method_call$(LPAREN)$(RPAREN)` function in a
 * [Gio.DBusInterfaceVTable] that was passed to
 * [Gio.DBusConnection.registerObject].
 */
struct GDBusMethodInvocation;

/**
 * Information about nodes in a remote object hierarchy.
 */
struct GDBusNodeInfo
{
  /**
   * The reference count or -1 if statically allocated.
   */
  int refCount;

  /**
   * The path of the node or %NULL if omitted. Note that this may be a relative path. See the D-Bus specification for more details.
   */
  char* path;

  /**
   * A pointer to a %NULL-terminated array of pointers to #GDBusInterfaceInfo structures or %NULL if there are no interfaces.
   */
  GDBusInterfaceInfo** interfaces;

  /**
   * A pointer to a %NULL-terminated array of pointers to #GDBusNodeInfo structures or %NULL if there are no nodes.
   */
  GDBusNodeInfo** nodes;

  /**
   * A pointer to a %NULL-terminated array of pointers to #GDBusAnnotationInfo structures or %NULL if there are no annotations.
   */
  GDBusAnnotationInfo** annotations;
}

/**
 * The `GDBusObject` type is the base type for D-Bus objects on both
 * the service side $(LPAREN)see [Gio.DBusObjectSkeleton]$(RPAREN) and the client side
 * $(LPAREN)see [Gio.DBusObjectProxy]$(RPAREN). It is essentially just a container of
 * interfaces.
 */
struct GDBusObject;

/**
 * Base object type for D-Bus objects.
 */
struct GDBusObjectIface
{
  /**
   * The parent interface.
   */
  GTypeInterface parentIface;

  /**
   * Returns the object path. See [Gio.DBusObject.getObjectPath].
   */
  extern(C) const(char)* function(GDBusObject* object) getObjectPath;

  /**
   * Returns all interfaces. See [Gio.DBusObject.getInterfaces].
   */
  extern(C) GList* function(GDBusObject* object) getInterfaces;

  /**
   * Returns an interface by name. See [Gio.DBusObject.getInterface].
   */
  extern(C) GDBusInterface* function(GDBusObject* object, const(char)* interfaceName) getInterface;

  /**
   * Signal handler for the #GDBusObject::interface-added signal.
   */
  extern(C) void function(GDBusObject* object, GDBusInterface* interface_) interfaceAdded;

  /**
   * Signal handler for the #GDBusObject::interface-removed signal.
   */
  extern(C) void function(GDBusObject* object, GDBusInterface* interface_) interfaceRemoved;
}

/**
 * The `GDBusObjectManager` type is the base type for service- and
 * client-side implementations of the standardized
 * [`org.freedesktop.DBus.ObjectManager`](http://dbus.freedesktop.org/doc/dbus-specification.html#standard-interfaces-objectmanager)
 * interface.
 * See [Gio.DBusObjectManagerClient] for the client-side implementation
 * and [Gio.DBusObjectManagerServer] for the service-side implementation.
 */
struct GDBusObjectManager;

/**
 * `GDBusObjectManagerClient` is used to create, monitor and delete object
 * proxies for remote objects exported by a [Gio.DBusObjectManagerServer]
 * $(LPAREN)or any code implementing the
 * [org.freedesktop.DBus.ObjectManager](http://dbus.freedesktop.org/doc/dbus-specification.html#standard-interfaces-objectmanager)
 * interface$(RPAREN).
 * Once an instance of this type has been created, you can connect to
 * the signal@Gio.DBusObjectManager::object-added and
 * signal@Gio.DBusObjectManager::object-removed signals and inspect the
 * [Gio.DBusObjectProxy] objects returned by
 * [Gio.DBusObjectManager.getObjects].
 * If the name for a `GDBusObjectManagerClient` is not owned by anyone at
 * object construction time, the default behavior is to request the
 * message bus to launch an owner for the name. This behavior can be
 * disabled using the `G_DBUS_OBJECT_MANAGER_CLIENT_FLAGS_DO_NOT_AUTO_START`
 * flag. It’s also worth noting that this only works if the name of
 * interest is activatable in the first place. E.g. in some cases it
 * is not possible to launch an owner for the requested name. In this
 * case, `GDBusObjectManagerClient` object construction still succeeds but
 * there will be no object proxies
 * $(LPAREN)e.g. [Gio.DBusObjectManager.getObjects] returns the empty list$(RPAREN) and
 * the [Gio.DBusObjectManagerClient.name] property is `NULL`.
 * The owner of the requested name can come and go $(LPAREN)for example
 * consider a system service being restarted$(RPAREN) – `GDBusObjectManagerClient`
 * handles this case too; simply connect to the [GObject.ObjectG.notify]
 * signal to watch for changes on the
 * [Gio.DBusObjectManagerClient.name] property. When the name
 * owner vanishes, the behavior is that
 * [Gio.DBusObjectManagerClient.name] is set to `NULL` $(LPAREN)this
 * includes emission of the [GObject.ObjectG.notify] signal$(RPAREN) and then
 * signal@Gio.DBusObjectManager::object-removed signals are synthesized
 * for all currently existing object proxies. Since
 * [Gio.DBusObjectManagerClient.name] is `NULL` when this
 * happens, you can use this information to disambiguate a synthesized signal
 * from a genuine signal caused by object removal on the remote
 * [Gio.DBusObjectManager]. Similarly, when a new name owner appears,
 * signal@Gio.DBusObjectManager::object-added signals are synthesized
 * while [Gio.DBusObjectManagerClient.name] is still `NULL`. Only
 * when all object proxies have been added, the
 * [Gio.DBusObjectManagerClient.name] is set to the new name
 * owner $(LPAREN)this includes emission of the [GObject.ObjectG.notify] signal$(RPAREN).
 * Furthermore, you are guaranteed that
 * [Gio.DBusObjectManagerClient.name] will alternate between a
 * name owner $(LPAREN)e.g. `:1.42`$(RPAREN) and `NULL` even in the case where
 * the name of interest is atomically replaced
 * Ultimately, `GDBusObjectManagerClient` is used to obtain
 * [Gio.DBusProxy] instances. All signals $(LPAREN)including the
 * `org.freedesktop.DBus.Properties::PropertiesChanged` signal$(RPAREN)
 * delivered to [Gio.DBusProxy] instances are guaranteed to originate
 * from the name owner. This guarantee along with the behavior
 * described above, means that certain race conditions including the
 * “half the proxy is from the old owner and the other half is from
 * the new owner” problem cannot happen.
 * To avoid having the application connect to signals on the returned
 * [Gio.DBusObjectProxy] and [Gio.DBusProxy] objects, the
 * signal@Gio.DBusObject::interface-added,
 * signal@Gio.DBusObject::interface-removed,
 * signal@Gio.DBusProxy::g-properties-changed and
 * signal@Gio.DBusProxy::g-signal signals
 * are also emitted on the `GDBusObjectManagerClient` instance managing these
 * objects. The signals emitted are
 * signal@Gio.DBusObjectManager::interface-added,
 * signal@Gio.DBusObjectManager::interface-removed,
 * signal@Gio.DBusObjectManagerClient::interface-proxy-properties-changed and
 * signal@Gio.DBusObjectManagerClient::interface-proxy-signal.
 * Note that all callbacks and signals are emitted in the
 * thread-default main context $(LPAREN)see
 * [GLib.MainContext.pushThreadDefault]$(RPAREN) that the
 * `GDBusObjectManagerClient` object was constructed in. Additionally, the
 * [Gio.DBusObjectProxy] and [Gio.DBusProxy] objects
 * originating from the `GDBusObjectManagerClient` object will be created in
 * the same context and, consequently, will deliver signals in the
 * same main loop.
 */
struct GDBusObjectManagerClient
{
  ObjectC parentInstance;

  GDBusObjectManagerClientPrivate* priv;
}

/**
 * Class structure for #GDBusObjectManagerClient.
 */
struct GDBusObjectManagerClientClass
{
  /**
   * The parent class.
   */
  GObjectClass parentClass;

  /**
   * Signal class handler for the #GDBusObjectManagerClient::interface-proxy-signal signal.
   */
  extern(C) void function(GDBusObjectManagerClient* manager, GDBusObjectProxy* objectProxy, GDBusProxy* interfaceProxy, const(char)* senderName, const(char)* signalName, VariantC* parameters) interfaceProxySignal;

  /**
   * Signal class handler for the #GDBusObjectManagerClient::interface-proxy-properties-changed signal.
   */
  extern(C) void function(GDBusObjectManagerClient* manager, GDBusObjectProxy* objectProxy, GDBusProxy* interfaceProxy, VariantC* changedProperties, const(char*)* invalidatedProperties) interfaceProxyPropertiesChanged;

  void*[8] padding;
}

struct GDBusObjectManagerClientPrivate;

/**
 * Base type for D-Bus object managers.
 */
struct GDBusObjectManagerIface
{
  /**
   * The parent interface.
   */
  GTypeInterface parentIface;

  /**
   * Virtual function for [Gio.DBusObjectManager.getObjectPath].
   */
  extern(C) const(char)* function(GDBusObjectManager* manager) getObjectPath;

  /**
   * Virtual function for [Gio.DBusObjectManager.getObjects].
   */
  extern(C) GList* function(GDBusObjectManager* manager) getObjects;

  /**
   * Virtual function for [Gio.DBusObjectManager.getObject].
   */
  extern(C) GDBusObject* function(GDBusObjectManager* manager, const(char)* objectPath) getObject;

  /**
   * Virtual function for [Gio.DBusObjectManager.getInterface].
   */
  extern(C) GDBusInterface* function(GDBusObjectManager* manager, const(char)* objectPath, const(char)* interfaceName) getInterface;

  /**
   * Signal handler for the #GDBusObjectManager::object-added signal.
   */
  extern(C) void function(GDBusObjectManager* manager, GDBusObject* object) objectAdded;

  /**
   * Signal handler for the #GDBusObjectManager::object-removed signal.
   */
  extern(C) void function(GDBusObjectManager* manager, GDBusObject* object) objectRemoved;

  /**
   * Signal handler for the #GDBusObjectManager::interface-added signal.
   */
  extern(C) void function(GDBusObjectManager* manager, GDBusObject* object, GDBusInterface* interface_) interfaceAdded;

  /**
   * Signal handler for the #GDBusObjectManager::interface-removed signal.
   */
  extern(C) void function(GDBusObjectManager* manager, GDBusObject* object, GDBusInterface* interface_) interfaceRemoved;
}

/**
 * `GDBusObjectManagerServer` is used to export [Gio.DBusObject] instances
 * using the standardized
 * [`org.freedesktop.DBus.ObjectManager`](http://dbus.freedesktop.org/doc/dbus-specification.html#standard-interfaces-objectmanager)
 * interface. For example, remote D-Bus clients can get all objects
 * and properties in a single call. Additionally, any change in the
 * object hierarchy is broadcast using signals. This means that D-Bus
 * clients can keep caches up to date by only listening to D-Bus
 * signals.
 * The recommended path to export an object manager at is the path form of the
 * well-known name of a D-Bus service, or below. For example, if a D-Bus service
 * is available at the well-known name `net.example.ExampleService1`, the object
 * manager should typically be exported at `/net/example/ExampleService1`, or
 * below $(LPAREN)to allow for multiple object managers in a service$(RPAREN).
 * It is supported, but not recommended, to export an object manager at the root
 * path, `/`.
 * See [Gio.DBusObjectManagerClient] for the client-side code that is
 * intended to be used with `GDBusObjectManagerServer` or any D-Bus
 * object implementing the `org.freedesktop.DBus.ObjectManager` interface.
 */
struct GDBusObjectManagerServer
{
  ObjectC parentInstance;

  GDBusObjectManagerServerPrivate* priv;
}

/**
 * Class structure for #GDBusObjectManagerServer.
 */
struct GDBusObjectManagerServerClass
{
  /**
   * The parent class.
   */
  GObjectClass parentClass;

  void*[8] padding;
}

struct GDBusObjectManagerServerPrivate;

/**
 * A `GDBusObjectProxy` is an object used to represent a remote object
 * with one or more D-Bus interfaces. Normally, you don’t instantiate
 * a `GDBusObjectProxy` yourself — typically [Gio.DBusObjectManagerClient]
 * is used to obtain it.
 */
struct GDBusObjectProxy
{
  ObjectC parentInstance;

  GDBusObjectProxyPrivate* priv;
}

/**
 * Class structure for #GDBusObjectProxy.
 */
struct GDBusObjectProxyClass
{
  /**
   * The parent class.
   */
  GObjectClass parentClass;

  void*[8] padding;
}

struct GDBusObjectProxyPrivate;

/**
 * A `GDBusObjectSkeleton` instance is essentially a group of D-Bus
 * interfaces. The set of exported interfaces on the object may be
 * dynamic and change at runtime.
 * This type is intended to be used with [Gio.DBusObjectManager].
 */
struct GDBusObjectSkeleton
{
  ObjectC parentInstance;

  GDBusObjectSkeletonPrivate* priv;
}

/**
 * Class structure for #GDBusObjectSkeleton.
 */
struct GDBusObjectSkeletonClass
{
  /**
   * The parent class.
   */
  GObjectClass parentClass;

  /**
   * Signal class handler for the #GDBusObjectSkeleton::authorize-method signal.
   */
  extern(C) bool function(GDBusObjectSkeleton* object, GDBusInterfaceSkeleton* interface_, GDBusMethodInvocation* invocation) authorizeMethod;

  void*[8] padding;
}

struct GDBusObjectSkeletonPrivate;

/**
 * Information about a D-Bus property on a D-Bus interface.
 */
struct GDBusPropertyInfo
{
  /**
   * The reference count or -1 if statically allocated.
   */
  int refCount;

  /**
   * The name of the D-Bus property, e.g. "SupportedFilesystems".
   */
  char* name;

  /**
   * The D-Bus signature of the property $(LPAREN)a single complete type$(RPAREN).
   */
  char* signature;

  /**
   * Access control flags for the property.
   */
  GDBusPropertyInfoFlags flags;

  /**
   * A pointer to a %NULL-terminated array of pointers to #GDBusAnnotationInfo structures or %NULL if there are no annotations.
   */
  GDBusAnnotationInfo** annotations;
}

/**
 * `GDBusProxy` is a base class used for proxies to access a D-Bus
 * interface on a remote object. A `GDBusProxy` can be constructed for
 * both well-known and unique names.
 * By default, `GDBusProxy` will cache all properties $(LPAREN)and listen to
 * changes$(RPAREN) of the remote object, and proxy all signals that get
 * emitted. This behaviour can be changed by passing suitable
 * [Gio] when the proxy is created. If the proxy is for a
 * well-known name, the property cache is flushed when the name owner
 * vanishes and reloaded when a name owner appears.
 * The unique name owner of the proxy’s name is tracked and can be read from
 * property@Gio.DBusProxy:g-name-owner. Connect to the
 * [GObject.ObjectG.notify] signal to get notified of changes.
 * Additionally, only signals and property changes emitted from the current name
 * owner are considered and calls are always sent to the current name owner.
 * This avoids a number of race conditions when the name is lost by one owner
 * and claimed by another. However, if no name owner currently exists,
 * then calls will be sent to the well-known name which may result in
 * the message bus launching an owner $(LPAREN)unless
 * `G_DBUS_PROXY_FLAGS_DO_NOT_AUTO_START` is set$(RPAREN).
 * If the proxy is for a stateless D-Bus service, where the name owner may
 * be started and stopped between calls, the
 * property@Gio.DBusProxy:g-name-owner tracking of `GDBusProxy` will cause the
 * proxy to drop signal and property changes from the service after it has
 * restarted for the first time. When interacting with a stateless D-Bus
 * service, do not use `GDBusProxy` — use direct D-Bus method calls and signal
 * connections.
 * The generic signal@Gio.DBusProxy::g-properties-changed and
 * signal@Gio.DBusProxy::g-signal signals are not very convenient to work
 * with. Therefore, the recommended way of working with proxies is to subclass
 * `GDBusProxy`, and have more natural properties and signals in your derived
 * class. This [example](migrating-gdbus.html#using-gdbus-codegen) shows how
 * this can easily be done using the [`gdbus-codegen`](gdbus-codegen.html) tool.
 * A `GDBusProxy` instance can be used from multiple threads but note
 * that all signals $(LPAREN)e.g. signal@Gio.DBusProxy::g-signal,
 * signal@Gio.DBusProxy::g-properties-changed and
 * [GObject.ObjectG.notify]$(RPAREN) are emitted in the thread-default main
 * context $(LPAREN)see [GLib.MainContext.pushThreadDefault]$(RPAREN) of the thread
 * where the instance was constructed.
 * An example using a proxy for a well-known name can be found in
 * [`gdbus-example-watch-proxy.c`](https://gitlab.gnome.org/GNOME/glib/-/blob/HEAD/gio/tests/gdbus-example-watch-proxy.c).
 */
struct GDBusProxy
{
  ObjectC parentInstance;

  GDBusProxyPrivate* priv;
}

/**
 * Class structure for #GDBusProxy.
 */
struct GDBusProxyClass
{
  GObjectClass parentClass;

  /**
   * Signal class handler for the #GDBusProxy::g-properties-changed signal.
   */
  extern(C) void function(GDBusProxy* proxy, VariantC* changedProperties, const(char*)* invalidatedProperties) gPropertiesChanged;

  /**
   * Signal class handler for the #GDBusProxy::g-signal signal.
   */
  extern(C) void function(GDBusProxy* proxy, const(char)* senderName, const(char)* signalName, VariantC* parameters) gSignal;

  void*[32] padding;
}

struct GDBusProxyPrivate;

/**
 * `GDBusServer` is a helper for listening to and accepting D-Bus
 * connections. This can be used to create a new D-Bus server, allowing two
 * peers to use the D-Bus protocol for their own specialized communication.
 * A server instance provided in this way will not perform message routing or
 * implement the
 * [`org.freedesktop.DBus` interface](https://dbus.freedesktop.org/doc/dbus-specification.html#message-bus-messages).
 * To just export an object on a well-known name on a message bus, such as the
 * session or system bus, you should instead use func@Gio.bus_own_name.
 * An example of peer-to-peer communication with GDBus can be found
 * in [gdbus-example-peer.c](https://gitlab.gnome.org/GNOME/glib/-/blob/HEAD/gio/tests/gdbus-example-peer.c).
 * Note that a minimal `GDBusServer` will accept connections from any
 * peer. In many use-cases it will be necessary to add a
 * [Gio.DBusAuthObserver] that only accepts connections that have
 * successfully authenticated as the same user that is running the
 * `GDBusServer`. Since GLib 2.68 this can be achieved more simply by passing
 * the `G_DBUS_SERVER_FLAGS_AUTHENTICATION_REQUIRE_SAME_USER` flag to the
 * server.
 */
struct GDBusServer;

/**
 * Information about a signal on a D-Bus interface.
 */
struct GDBusSignalInfo
{
  /**
   * The reference count or -1 if statically allocated.
   */
  int refCount;

  /**
   * The name of the D-Bus signal, e.g. "NameOwnerChanged".
   */
  char* name;

  /**
   * A pointer to a %NULL-terminated array of pointers to #GDBusArgInfo structures or %NULL if there are no arguments.
   */
  GDBusArgInfo** args;

  /**
   * A pointer to a %NULL-terminated array of pointers to #GDBusAnnotationInfo structures or %NULL if there are no annotations.
   */
  GDBusAnnotationInfo** annotations;
}

/**
 * Virtual table for handling subtrees registered with [Gio.DBusConnection.registerSubtree].
 */
struct GDBusSubtreeVTable
{
  /**
   * Function for enumerating child nodes.
   */
  GDBusSubtreeEnumerateFunc enumerate;

  /**
   * Function for introspecting a child node.
   */
  GDBusSubtreeIntrospectFunc introspect;

  /**
   * Function for dispatching a remote call on a child node.
   */
  GDBusSubtreeDispatchFunc dispatch;

  void*[8] padding;
}

/**
 * Data input stream implements [Gio.InputStream] and includes functions
 * for reading structured data directly from a binary input stream.
 */
struct GDataInputStream
{
  GBufferedInputStream parentInstance;

  GDataInputStreamPrivate* priv;
}

struct GDataInputStreamClass
{
  GBufferedInputStreamClass parentClass;

  extern(C) void function() GReserved1;

  extern(C) void function() GReserved2;

  extern(C) void function() GReserved3;

  extern(C) void function() GReserved4;

  extern(C) void function() GReserved5;
}

struct GDataInputStreamPrivate;

/**
 * Data output stream implements [Gio.OutputStream] and includes functions
 * for writing data directly to an output stream.
 */
struct GDataOutputStream
{
  GFilterOutputStream parentInstance;

  GDataOutputStreamPrivate* priv;
}

struct GDataOutputStreamClass
{
  GFilterOutputStreamClass parentClass;

  extern(C) void function() GReserved1;

  extern(C) void function() GReserved2;

  extern(C) void function() GReserved3;

  extern(C) void function() GReserved4;

  extern(C) void function() GReserved5;
}

struct GDataOutputStreamPrivate;

/**
 * Interface for socket-like objects with datagram semantics.
 * A `GDatagramBased` is a networking interface for representing datagram-based
 * communications. It is a more or less direct mapping of the core parts of the
 * BSD socket API in a portable GObject interface. It is implemented by
 * [Gio.Socket], which wraps the UNIX socket API on UNIX and winsock2 on Windows.
 * `GDatagramBased` is entirely platform independent, and is intended to be used
 * alongside higher-level networking APIs such as [Gio.IOStream].
 * It uses vectored scatter/gather I/O by default, allowing for many messages
 * to be sent or received in a single call. Where possible, implementations of
 * the interface should take advantage of vectored I/O to minimise processing
 * or system calls. For example, `GSocket` uses `recvmmsg$(LPAREN)$(RPAREN)` and `sendmmsg$(LPAREN)$(RPAREN)`
 * where possible. Callers should take advantage of scatter/gather I/O $(LPAREN)the use of
 * multiple buffers per message$(RPAREN) to avoid unnecessary copying of data to
 * assemble or disassemble a message.
 * Each `GDatagramBased` operation has a timeout parameter which may be negative
 * for blocking behaviour, zero for non-blocking behaviour, or positive for
 * timeout behaviour. A blocking operation blocks until finished or there is an
 * error. A non-blocking operation will return immediately with a
 * `G_IO_ERROR_WOULD_BLOCK` error if it cannot make progress. A timeout operation
 * will block until the operation is complete or the timeout expires; if the
 * timeout expires it will return what progress it made, or
 * `G_IO_ERROR_TIMED_OUT` if no progress was made. To know when a call would
 * successfully run you can call [Gio.DatagramBased.conditionCheck] or
 * [Gio.DatagramBased.conditionWait]. You can also use
 * [Gio.DatagramBased.createSource] and attach it to a [GLib.MainContext]
 * to get callbacks when I/O is possible.
 * When running a non-blocking operation applications should always be able to
 * handle getting a `G_IO_ERROR_WOULD_BLOCK` error even when some other function
 * said that I/O was possible. This can easily happen in case of a race
 * condition in the application, but it can also happen for other reasons. For
 * instance, on Windows a socket is always seen as writable until a write
 * returns `G_IO_ERROR_WOULD_BLOCK`.
 * As with `GSocket`, `GDatagramBased`s can be either connection oriented $(LPAREN)for
 * example, SCTP$(RPAREN) or connectionless $(LPAREN)for example, UDP$(RPAREN). `GDatagramBased`s must be
 * datagram-based, not stream-based. The interface does not cover connection
 * establishment — use methods on the underlying type to establish a connection
 * before sending and receiving data through the `GDatagramBased` API. For
 * connectionless socket types the target/source address is specified or
 * received in each I/O operation.
 * Like most other APIs in GLib, `GDatagramBased` is not inherently thread safe.
 * To use a `GDatagramBased` concurrently from multiple threads, you must
 * implement your own locking.
 */
struct GDatagramBased;

/**
 * Provides an interface for socket-like objects which have datagram semantics,
 * following the Berkeley sockets API. The interface methods are thin wrappers
 * around the corresponding virtual methods, and no pre-processing of inputs is
 * implemented — so implementations of this API must handle all functionality
 * documented in the interface methods.
 */
struct GDatagramBasedInterface
{
  /**
   * The parent interface.
   */
  GTypeInterface gIface;

  /**
   * Virtual method for [Gio.DatagramBased.receiveMessages].
   */
  extern(C) int function(GDatagramBased* datagramBased, GInputMessage* messages, uint numMessages, int flags, long timeout, GCancellable* cancellable, GError** _err) receiveMessages;

  /**
   * Virtual method for [Gio.DatagramBased.sendMessages].
   */
  extern(C) int function(GDatagramBased* datagramBased, GOutputMessage* messages, uint numMessages, int flags, long timeout, GCancellable* cancellable, GError** _err) sendMessages;

  /**
   * Virtual method for [Gio.DatagramBased.createSource].
   */
  extern(C) GSource* function(GDatagramBased* datagramBased, GIOCondition condition, GCancellable* cancellable) createSource;

  /**
   * Virtual method for [Gio.DatagramBased.conditionCheck].
   */
  extern(C) GIOCondition function(GDatagramBased* datagramBased, GIOCondition condition) conditionCheck;

  /**
   * Virtual method for
   * [Gio.DatagramBased.conditionWait].
   */
  extern(C) bool function(GDatagramBased* datagramBased, GIOCondition condition, long timeout, GCancellable* cancellable, GError** _err) conditionWait;
}

/**
 * `GDebugController` is an interface to expose control of debugging features and
 * debug output.
 * It is implemented on Linux using [Gio.DebugControllerDBus], which
 * exposes a D-Bus interface to allow authenticated peers to control debug
 * features in this process.
 * Whether debug output is enabled is exposed as
 * property@Gio.DebugController:debug-enabled. This controls
 * func@GLib.log_set_debug_enabled by default. Application code may
 * connect to the [GObject.ObjectG.notify] signal for it
 * to control other parts of its debug infrastructure as necessary.
 * If your application or service is using the default GLib log writer function,
 * creating one of the built-in implementations of `GDebugController` should be
 * all that’s needed to dynamically enable or disable debug output.
 */
struct GDebugController;

/**
 * `GDebugControllerDBus` is an implementation of [Gio.DebugController]
 * which exposes debug settings as a D-Bus object.
 * It is a [Gio.Initable] object, and will register an object at
 * `/org/gtk/Debugging` on the bus given as
 * [Gio.DebugControllerDBus.connection] once it’s initialized. The
 * object will be unregistered when the last reference to the
 * `GDebugControllerDBus` is dropped.
 * This D-Bus object can be used by remote processes to enable or disable debug
 * output in this process. Remote processes calling
 * `org.gtk.Debugging.SetDebugEnabled$(LPAREN)$(RPAREN)` will affect the value of
 * property@Gio.DebugController:debug-enabled and, by default,
 * func@GLib.log_get_debug_enabled.
 * By default, no processes are allowed to call `SetDebugEnabled$(LPAREN)$(RPAREN)` unless a
 * [Gio.DebugControllerDBus.authorize] signal handler is installed. This
 * is because the process may be privileged, or might expose sensitive
 * information in its debug output. You may want to restrict the ability to
 * enable debug output to privileged users or processes.
 * One option is to install a D-Bus security policy which restricts access to
 * `SetDebugEnabled$(LPAREN)$(RPAREN)`, installing something like the following in
 * `\$datadir/dbus-1/system.d/`:
 * ```xml
 * <?xml version\="1.0"?> <!--*-nxml-*-->
 * <!DOCTYPE busconfig PUBLIC "-//freedesktop//DTD D-BUS Bus Configuration 1.0//EN"
 * "http://www.freedesktop.org/standards/dbus/1.0/busconfig.dtd">
 * <busconfig>
 * <policy user\="root">
 * <allow send_destination\="com.example.MyService" send_interface\="org.gtk.Debugging"/>
 * </policy>
 * <policy context\="default">
 * <deny send_destination\="com.example.MyService" send_interface\="org.gtk.Debugging"/>
 * </policy>
 * </busconfig>
 * ```
 * This will prevent the `SetDebugEnabled$(LPAREN)$(RPAREN)` method from being called by all
 * except root. It will not prevent the `DebugEnabled` property from being read,
 * as it’s accessed through the `org.freedesktop.DBus.Properties` interface.
 * Another option is to use polkit to allow or deny requests on a case-by-case
 * basis, allowing for the possibility of dynamic authorisation. To do this,
 * connect to the [Gio.DebugControllerDBus.authorize] signal and query
 * polkit in it:
 * ```c
 * g_autoptr$(LPAREN)GError$(RPAREN) child_error \= NULL;
 * g_autoptr$(LPAREN)GDBusConnection$(RPAREN) connection \= g_bus_get_sync $(LPAREN)G_BUS_TYPE_SYSTEM, NULL, NULL$(RPAREN);
 * gulong debug_controller_authorize_id \= 0;
 * // Set up the debug controller.
 * debug_controller \= G_DEBUG_CONTROLLER $(LPAREN)g_debug_controller_dbus_new $(LPAREN)priv->connection, NULL, &child_error$(RPAREN)$(RPAREN);
 * if $(LPAREN)debug_controller \=\= NULL$(RPAREN)
 * {
 * g_error $(LPAREN)"Could not register debug controller on bus: %s"$(RPAREN),
 * child_error->message$(RPAREN);
 * }
 * debug_controller_authorize_id \= g_signal_connect $(LPAREN)debug_controller,
 * "authorize",
 * G_CALLBACK $(LPAREN)debug_controller_authorize_cb$(RPAREN),
 * self$(RPAREN);
 * static gboolean
 * debug_controller_authorize_cb $(LPAREN)GDebugControllerDBus  *debug_controller,
 * GDBusMethodInvocation *invocation,
 * gpointer               user_data$(RPAREN)
 * {
 * g_autoptr$(LPAREN)PolkitAuthority$(RPAREN) authority \= NULL;
 * g_autoptr$(LPAREN)PolkitSubject$(RPAREN) subject \= NULL;
 * g_autoptr$(LPAREN)PolkitAuthorizationResult$(RPAREN) auth_result \= NULL;
 * g_autoptr$(LPAREN)GError$(RPAREN) local_error \= NULL;
 * GDBusMessage *message;
 * GDBusMessageFlags message_flags;
 * PolkitCheckAuthorizationFlags flags \= POLKIT_CHECK_AUTHORIZATION_FLAGS_NONE;
 * message \= g_dbus_method_invocation_get_message $(LPAREN)invocation$(RPAREN);
 * message_flags \= g_dbus_message_get_flags $(LPAREN)message$(RPAREN);
 * authority \= polkit_authority_get_sync $(LPAREN)NULL, &local_error$(RPAREN);
 * if $(LPAREN)authority \=\= NULL$(RPAREN)
 * {
 * g_warning $(LPAREN)"Failed to get polkit authority: %s", local_error->message$(RPAREN);
 * return FALSE;
 * }
 * if $(LPAREN)message_flags & G_DBUS_MESSAGE_FLAGS_ALLOW_INTERACTIVE_AUTHORIZATION$(RPAREN)
 * flags |\= POLKIT_CHECK_AUTHORIZATION_FLAGS_ALLOW_USER_INTERACTION;
 * subject \= polkit_system_bus_name_new $(LPAREN)g_dbus_method_invocation_get_sender $(LPAREN)invocation$(RPAREN)$(RPAREN);
 * auth_result \= polkit_authority_check_authorization_sync $(LPAREN)authority,
 * subject,
 * "com.example.MyService.set-debug-enabled",
 * NULL,
 * flags,
 * NULL,
 * &local_error$(RPAREN);
 * if $(LPAREN)auth_result \=\= NULL$(RPAREN)
 * {
 * g_warning $(LPAREN)"Failed to get check polkit authorization: %s", local_error->message$(RPAREN);
 * return FALSE;
 * }
 * return polkit_authorization_result_get_is_authorized $(LPAREN)auth_result$(RPAREN);
 * }
 * ```
 */
struct GDebugControllerDBus
{
  ObjectC parentInstance;
}

/**
 * The virtual function table for #GDebugControllerDBus.
 */
struct GDebugControllerDBusClass
{
  /**
   * The parent class.
   */
  GObjectClass parentClass;

  /**
   * Default handler for the #GDebugControllerDBus::authorize signal.
   */
  extern(C) bool function(GDebugControllerDBus* controller, GDBusMethodInvocation* invocation) authorize;

  void*[12] padding;
}

/**
 * The virtual function table for #GDebugController.
 */
struct GDebugControllerInterface
{
  /**
   * The parent interface.
   */
  GTypeInterface gIface;
}

/**
 * `GDesktopAppInfo` is an implementation of [Gio.AppInfo] based on
 * desktop files.
 * Note that `<gio/gdesktopappinfo.h>` belongs to the UNIX-specific
 * GIO interfaces, thus you have to use the `gio-unix-2.0.pc` pkg-config
 * file or the `GioUnix-2.0` GIR namespace when using it.
 */
struct GDesktopAppInfo;

struct GDesktopAppInfoClass
{
  GObjectClass parentClass;
}

/**
 * #GDesktopAppInfoLookup is an opaque data structure and can only be accessed
 * using the following functions.

 * Deprecated: The #GDesktopAppInfoLookup interface is deprecated and
 *   unused by GIO.
 */
struct GDesktopAppInfoLookup;

/**
 * Interface that is used by backends to associate default
 * handlers with URI schemes.
 */
struct GDesktopAppInfoLookupIface
{
  GTypeInterface gIface;

  /**
   * Virtual method for
   * [Gio.DesktopAppInfoLookup.getDefaultForUriScheme].
   */
  extern(C) GAppInfo* function(GDesktopAppInfoLookup* lookup, const(char)* uriScheme) getDefaultForUriScheme;
}

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
struct GDrive;

/**
 * Interface for creating #GDrive implementations.
 */
struct GDriveIface
{
  /**
   * The parent interface.
   */
  GTypeInterface gIface;

  /**
   * Signal emitted when the drive is changed.
   */
  extern(C) void function(GDrive* drive) changed;

  /**
   * The removed signal that is emitted when the #GDrive have been disconnected. If the recipient is holding references to the object they should release them so the object can be finalized.
   */
  extern(C) void function(GDrive* drive) disconnected;

  /**
   * Signal emitted when the physical eject button $(LPAREN)if any$(RPAREN) of a drive have been pressed.
   */
  extern(C) void function(GDrive* drive) ejectButton;

  /**
   * Returns the name for the given #GDrive.
   */
  extern(C) char* function(GDrive* drive) getName;

  /**
   * Returns a #GIcon for the given #GDrive.
   */
  extern(C) GIcon* function(GDrive* drive) getIcon;

  /**
   * Returns %TRUE if the #GDrive has mountable volumes.
   */
  extern(C) bool function(GDrive* drive) hasVolumes;

  /**
   * Returns a list #GList of #GVolume for the #GDrive.
   */
  extern(C) GList* function(GDrive* drive) getVolumes;

  /**
   * Returns %TRUE if the #GDrive supports removal and insertion of media.
   */
  extern(C) bool function(GDrive* drive) isMediaRemovable;

  /**
   * Returns %TRUE if the #GDrive has media inserted.
   */
  extern(C) bool function(GDrive* drive) hasMedia;

  /**
   * Returns %TRUE if the #GDrive is capable of automatically detecting media changes.
   */
  extern(C) bool function(GDrive* drive) isMediaCheckAutomatic;

  /**
   * Returns %TRUE if the #GDrive can eject media.
   */
  extern(C) bool function(GDrive* drive) canEject;

  /**
   * Returns %TRUE if the #GDrive is capable of manually polling for media change.
   */
  extern(C) bool function(GDrive* drive) canPollForMedia;

  /**
   * Ejects a #GDrive.
   */
  extern(C) void function(GDrive* drive, GMountUnmountFlags flags, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) eject;

  /**
   * Finishes an eject operation.
   */
  extern(C) bool function(GDrive* drive, GAsyncResult* result, GError** _err) ejectFinish;

  /**
   * Poll for media insertion/removal on a #GDrive.
   */
  extern(C) void function(GDrive* drive, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) pollForMedia;

  /**
   * Finishes a media poll operation.
   */
  extern(C) bool function(GDrive* drive, GAsyncResult* result, GError** _err) pollForMediaFinish;

  /**
   * Returns the identifier of the given kind, or %NULL if
   * the #GDrive doesn't have one.
   */
  extern(C) char* function(GDrive* drive, const(char)* kind) getIdentifier;

  /**
   * Returns an array strings listing the kinds
   * of identifiers which the #GDrive has.
   */
  extern(C) char** function(GDrive* drive) enumerateIdentifiers;

  /**
   * Gets a #GDriveStartStopType with details about starting/stopping the drive. Since 2.22.
   */
  extern(C) GDriveStartStopType function(GDrive* drive) getStartStopType;

  /**
   * Returns %TRUE if a #GDrive can be started. Since 2.22.
   */
  extern(C) bool function(GDrive* drive) canStart;

  /**
   * Returns %TRUE if a #GDrive can be started degraded. Since 2.22.
   */
  extern(C) bool function(GDrive* drive) canStartDegraded;

  /**
   * Starts a #GDrive. Since 2.22.
   */
  extern(C) void function(GDrive* drive, GDriveStartFlags flags, GMountOperation* mountOperation, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) start;

  /**
   * Finishes a start operation. Since 2.22.
   */
  extern(C) bool function(GDrive* drive, GAsyncResult* result, GError** _err) startFinish;

  /**
   * Returns %TRUE if a #GDrive can be stopped. Since 2.22.
   */
  extern(C) bool function(GDrive* drive) canStop;

  /**
   * Stops a #GDrive. Since 2.22.
   */
  extern(C) void function(GDrive* drive, GMountUnmountFlags flags, GMountOperation* mountOperation, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) stop;

  /**
   * Finishes a stop operation. Since 2.22.
   */
  extern(C) bool function(GDrive* drive, GAsyncResult* result, GError** _err) stopFinish;

  /**
   * Signal emitted when the physical stop button $(LPAREN)if any$(RPAREN) of a drive have been pressed. Since 2.22.
   */
  extern(C) void function(GDrive* drive) stopButton;

  /**
   * Starts ejecting a #GDrive using a #GMountOperation. Since 2.22.
   */
  extern(C) void function(GDrive* drive, GMountUnmountFlags flags, GMountOperation* mountOperation, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) ejectWithOperation;

  /**
   * Finishes an eject operation using a #GMountOperation. Since 2.22.
   */
  extern(C) bool function(GDrive* drive, GAsyncResult* result, GError** _err) ejectWithOperationFinish;

  /**
   * Gets a key used for sorting #GDrive instances or %NULL if no such key exists. Since 2.32.
   */
  extern(C) const(char)* function(GDrive* drive) getSortKey;

  /**
   * Returns a symbolic #GIcon for the given #GDrive. Since 2.34.
   */
  extern(C) GIcon* function(GDrive* drive) getSymbolicIcon;

  /**
   * Returns %TRUE if the #GDrive and/or its media is considered removable by the user. Since 2.50.
   */
  extern(C) bool function(GDrive* drive) isRemovable;
}

/**
 * `GDtlsClientConnection` is the client-side subclass of
 * [Gio.DtlsConnection], representing a client-side DTLS connection.
 */
struct GDtlsClientConnection;

/**
 * vtable for a #GDtlsClientConnection implementation.
 */
struct GDtlsClientConnectionInterface
{
  /**
   * The parent interface.
   */
  GTypeInterface gIface;
}

/**
 * `GDtlsConnection` is the base DTLS connection class type, which wraps
 * a [Gio.DatagramBased] and provides DTLS encryption on top of it. Its
 * subclasses, [Gio.DtlsClientConnection] and
 * [Gio.DtlsServerConnection], implement client-side and server-side DTLS,
 * respectively.
 * For TLS support, see [Gio.TlsConnection].
 * As DTLS is datagram based, `GDtlsConnection` implements
 * [Gio.DatagramBased], presenting a datagram-socket-like API for the
 * encrypted connection. This operates over a base datagram connection, which is
 * also a `GDatagramBased` $(LPAREN)property@Gio.DtlsConnection:base-socket$(RPAREN).
 * To close a DTLS connection, use [Gio.DtlsConnection.close].
 * Neither [Gio.DtlsServerConnection] or [Gio.DtlsClientConnection]
 * set the peer address on their base [Gio.DatagramBased] if it is a
 * [Gio.Socket] — it is up to the caller to do that if they wish. If they
 * do not, and [Gio.Socket.close] is called on the base socket, the
 * `GDtlsConnection` will not raise a `G_IO_ERROR_NOT_CONNECTED` error on
 * further I/O.
 */
struct GDtlsConnection;

/**
 * Virtual method table for a #GDtlsConnection implementation.
 */
struct GDtlsConnectionInterface
{
  /**
   * The parent interface.
   */
  GTypeInterface gIface;

  /**
   * Check whether to accept a certificate.
   */
  extern(C) bool function(GDtlsConnection* connection, GTlsCertificate* peerCert, GTlsCertificateFlags errors) acceptCertificate;

  /**
   * Perform a handshake operation.
   */
  extern(C) bool function(GDtlsConnection* conn, GCancellable* cancellable, GError** _err) handshake;

  /**
   * Start an asynchronous handshake operation.
   */
  extern(C) void function(GDtlsConnection* conn, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) handshakeAsync;

  /**
   * Finish an asynchronous handshake operation.
   */
  extern(C) bool function(GDtlsConnection* conn, GAsyncResult* result, GError** _err) handshakeFinish;

  /**
   * Shut down one or both directions of the connection.
   */
  extern(C) bool function(GDtlsConnection* conn, bool shutdownRead, bool shutdownWrite, GCancellable* cancellable, GError** _err) shutdown;

  /**
   * Start an asynchronous shutdown operation.
   */
  extern(C) void function(GDtlsConnection* conn, bool shutdownRead, bool shutdownWrite, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) shutdownAsync;

  /**
   * Finish an asynchronous shutdown operation.
   */
  extern(C) bool function(GDtlsConnection* conn, GAsyncResult* result, GError** _err) shutdownFinish;

  /**
   * Set APLN protocol list $(LPAREN)Since: 2.60$(RPAREN)
   */
  extern(C) void function(GDtlsConnection* conn, const(char*)* protocols) setAdvertisedProtocols;

  /**
   * Get ALPN-negotiated protocol $(LPAREN)Since: 2.60$(RPAREN)
   */
  extern(C) const(char)* function(GDtlsConnection* conn) getNegotiatedProtocol;

  /**
   * Retrieve TLS channel binding data $(LPAREN)Since: 2.66$(RPAREN)
   */
  extern(C) bool function(GDtlsConnection* conn, GTlsChannelBindingType type, GByteArray* data, GError** _err) getBindingData;
}

/**
 * `GDtlsServerConnection` is the server-side subclass of
 * [Gio.DtlsConnection], representing a server-side DTLS connection.
 */
struct GDtlsServerConnection;

/**
 * vtable for a #GDtlsServerConnection implementation.
 */
struct GDtlsServerConnectionInterface
{
  /**
   * The parent interface.
   */
  GTypeInterface gIface;
}

/**
 * `GEmblem` is an implementation of [Gio.Icon] that supports
 * having an emblem, which is an icon with additional properties.
 * It can than be added to a [Gio.EmblemedIcon].
 * Currently, only metainformation about the emblem's origin is
 * supported. More may be added in the future.
 */
struct GEmblem;

struct GEmblemClass;

/**
 * `GEmblemedIcon` is an implementation of [Gio.Icon] that supports
 * adding an emblem to an icon. Adding multiple emblems to an
 * icon is ensured via [Gio.EmblemedIcon.addEmblem].
 * Note that `GEmblemedIcon` allows no control over the position
 * of the emblems. See also [Gio.Emblem] for more information.
 */
struct GEmblemedIcon
{
  ObjectC parentInstance;

  GEmblemedIconPrivate* priv;
}

struct GEmblemedIconClass
{
  GObjectClass parentClass;
}

struct GEmblemedIconPrivate;

/**
 * `GFile` is a high level abstraction for manipulating files on a
 * virtual file system. `GFile`s are lightweight, immutable objects
 * that do no I/O upon creation. It is necessary to understand that
 * `GFile` objects do not represent files, merely an identifier for a
 * file. All file content I/O is implemented as streaming operations
 * $(LPAREN)see [Gio.InputStream] and [Gio.OutputStream]$(RPAREN).
 * To construct a `GFile`, you can use:
 * - [Gio.File.newForPath] if you have a path.
 * - [Gio.File.newForUri] if you have a URI.
 * - [Gio.File.newForCommandlineArg] or
 * [Gio.File.newForCommandlineArgAndCwd] for a command line
 * argument.
 * - [Gio.File.newTmp] to create a temporary file from a template.
 * - [Gio.File.newTmpAsync] to asynchronously create a temporary file.
 * - [Gio.File.newTmpDirAsync] to asynchronously create a temporary
 * directory.
 * - [Gio.File.parseName] from a UTF-8 string gotten from
 * [Gio.File.getParseName].
 * - [Gio.File.newBuildFilename] or [Gio.File.newBuildFilenamev]
 * to create a file from path elements.
 * One way to think of a `GFile` is as an abstraction of a pathname. For
 * normal files the system pathname is what is stored internally, but as
 * `GFile`s are extensible it could also be something else that corresponds
 * to a pathname in a userspace implementation of a filesystem.
 * `GFile`s make up hierarchies of directories and files that correspond to
 * the files on a filesystem. You can move through the file system with
 * `GFile` using [Gio.File.getParent] to get an identifier for the
 * parent directory, [Gio.File.getChild] to get a child within a
 * directory, and [Gio.File.resolveRelativePath] to resolve a relative
 * path between two `GFile`s. There can be multiple hierarchies, so you may not
 * end up at the same root if you repeatedly call [Gio.File.getParent]
 * on two different files.
 * All `GFile`s have a basename $(LPAREN)get with [Gio.File.getBasename]$(RPAREN). These
 * names are byte strings that are used to identify the file on the filesystem
 * $(LPAREN)relative to its parent directory$(RPAREN) and there is no guarantees that they
 * have any particular charset encoding or even make any sense at all. If
 * you want to use filenames in a user interface you should use the display
 * name that you can get by requesting the
 * `G_FILE_ATTRIBUTE_STANDARD_DISPLAY_NAME` attribute with
 * [Gio.File.queryInfo]. This is guaranteed to be in UTF-8 and can be
 * used in a user interface. But always store the real basename or the `GFile`
 * to use to actually access the file, because there is no way to go from a
 * display name to the actual name.
 * Using `GFile` as an identifier has the same weaknesses as using a path
 * in that there may be multiple aliases for the same file. For instance,
 * hard or soft links may cause two different `GFile`s to refer to the same
 * file. Other possible causes for aliases are: case insensitive filesystems,
 * short and long names on FAT/NTFS, or bind mounts in Linux. If you want to
 * check if two `GFile`s point to the same file you can query for the
 * `G_FILE_ATTRIBUTE_ID_FILE` attribute. Note that `GFile` does some trivial
 * canonicalization of pathnames passed in, so that trivial differences in
 * the path string used at creation $(LPAREN)duplicated slashes, slash at end of
 * path, `.` or `..` path segments, etc$(RPAREN) does not create different `GFile`s.
 * Many `GFile` operations have both synchronous and asynchronous versions
 * to suit your application. Asynchronous versions of synchronous functions
 * simply have `_async$(LPAREN)$(RPAREN)` appended to their function names. The asynchronous
 * I/O functions call a [Gio.AsyncReadyCallback] which is then used to
 * finalize the operation, producing a [Gio.AsyncResult] which is then
 * passed to the function’s matching `_finish$(LPAREN)$(RPAREN)` operation.
 * It is highly recommended to use asynchronous calls when running within a
 * shared main loop, such as in the main thread of an application. This avoids
 * I/O operations blocking other sources on the main loop from being dispatched.
 * Synchronous I/O operations should be performed from worker threads. See the
 * [introduction to asynchronous programming section](overview.html#asynchronous-programming)
 * for more.
 * Some `GFile` operations almost always take a noticeable amount of time, and
 * so do not have synchronous analogs. Notable cases include:
 * - [Gio.File.mountMountable] to mount a mountable file.
 * - [Gio.File.unmountMountableWithOperation] to unmount a mountable
 * file.
 * - [Gio.File.ejectMountableWithOperation] to eject a mountable file.
 * ## Entity Tags
 * One notable feature of `GFile`s are entity tags, or ‘etags’ for
 * short. Entity tags are somewhat like a more abstract version of the
 * traditional mtime, and can be used to quickly determine if the file
 * has been modified from the version on the file system. See the
 * HTTP 1.1
 * [specification](http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html)
 * for HTTP `ETag` headers, which are a very similar concept.
 */
struct GFile;

/**
 * Information about a specific attribute.
 */
struct GFileAttributeInfo
{
  /**
   * the name of the attribute.
   */
  char* name;

  /**
   * the #GFileAttributeType type of the attribute.
   */
  GFileAttributeType type;

  /**
   * a set of #GFileAttributeInfoFlags.
   */
  GFileAttributeInfoFlags flags;
}

/**
 * Acts as a lightweight registry for possible valid file attributes.
 * The registry stores Key-Value pair formats as #GFileAttributeInfos.
 */
struct GFileAttributeInfoList
{
  /**
   * an array of #GFileAttributeInfos.
   */
  GFileAttributeInfo* infos;

  /**
   * the number of values in the array.
   */
  int nInfos;
}

/**
 * Determines if a string matches a file attribute.
 */
struct GFileAttributeMatcher;

/**
 * `GFileDescriptorBased` is an interface for file descriptor based IO.
 * It is implemented by streams $(LPAREN)implementations of [Gio.InputStream] or
 * [Gio.OutputStream]$(RPAREN) that are based on file descriptors.
 * Note that `<gio/gfiledescriptorbased.h>` belongs to the UNIX-specific
 * GIO interfaces, thus you have to use the `gio-unix-2.0.pc` pkg-config
 * file or the `GioUnix-2.0` GIR namespace when using it.
 */
struct GFileDescriptorBased;

/**
 * An interface for file descriptor based io objects.
 */
struct GFileDescriptorBasedIface
{
  /**
   * The parent interface.
   */
  GTypeInterface gIface;

  /**
   * Gets the underlying file descriptor.
   */
  extern(C) int function(GFileDescriptorBased* fdBased) getFd;
}

/**
 * `GFileEnumerator` allows you to operate on a set of [Gio.File] objects,
 * returning a [Gio.FileInfo] structure for each file enumerated $(LPAREN)e.g.
 * [Gio.File.enumerateChildren] will return a `GFileEnumerator` for each
 * of the children within a directory$(RPAREN).
 * To get the next file's information from a `GFileEnumerator`, use
 * [Gio.FileEnumerator.nextFile] or its asynchronous version,
 * [Gio.FileEnumerator.nextFilesAsync]. Note that the asynchronous
 * version will return a list of [Gio.FileInfo] objects, whereas the
 * synchronous will only return the next file in the enumerator.
 * The ordering of returned files is unspecified for non-Unix
 * platforms; for more information, see [GLib.Dir.readName].  On Unix,
 * when operating on local files, returned files will be sorted by
 * inode number.  Effectively you can assume that the ordering of
 * returned files will be stable between successive calls $(LPAREN)and
 * applications$(RPAREN) assuming the directory is unchanged.
 * If your application needs a specific ordering, such as by name or
 * modification time, you will have to implement that in your
 * application code.
 * To close a `GFileEnumerator`, use [Gio.FileEnumerator.close], or
 * its asynchronous version, [Gio.FileEnumerator.closeAsync]. Once
 * a `GFileEnumerator` is closed, no further actions may be performed
 * on it, and it should be freed with [GObject.ObjectG.unref].
 */
struct GFileEnumerator
{
  ObjectC parentInstance;

  GFileEnumeratorPrivate* priv;
}

struct GFileEnumeratorClass
{
  GObjectClass parentClass;

  extern(C) GFileInfo* function(GFileEnumerator* enumerator, GCancellable* cancellable, GError** _err) nextFile;

  extern(C) bool function(GFileEnumerator* enumerator, GCancellable* cancellable, GError** _err) closeFn;

  extern(C) void function(GFileEnumerator* enumerator, int numFiles, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) nextFilesAsync;

  extern(C) GList* function(GFileEnumerator* enumerator, GAsyncResult* result, GError** _err) nextFilesFinish;

  extern(C) void function(GFileEnumerator* enumerator, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) closeAsync;

  extern(C) bool function(GFileEnumerator* enumerator, GAsyncResult* result, GError** _err) closeFinish;

  extern(C) void function() GReserved1;

  extern(C) void function() GReserved2;

  extern(C) void function() GReserved3;

  extern(C) void function() GReserved4;

  extern(C) void function() GReserved5;

  extern(C) void function() GReserved6;

  extern(C) void function() GReserved7;
}

struct GFileEnumeratorPrivate;

/**
 * `GFileIOStream` provides I/O streams that both read and write to the same
 * file handle.
 * `GFileIOStream` implements [Gio.Seekable], which allows the I/O
 * stream to jump to arbitrary positions in the file and to truncate
 * the file, provided the filesystem of the file supports these
 * operations.
 * To find the position of a file I/O stream, use [Gio.Seekable.tell].
 * To find out if a file I/O stream supports seeking, use
 * [Gio.Seekable.canSeek]. To position a file I/O stream, use
 * [Gio.Seekable.seek]. To find out if a file I/O stream supports
 * truncating, use [Gio.Seekable.canTruncate]. To truncate a file I/O
 * stream, use [Gio.Seekable.truncate].
 * The default implementation of all the `GFileIOStream` operations
 * and the implementation of [Gio.Seekable] just call into the same
 * operations on the output stream.
 */
struct GFileIOStream
{
  GIOStream parentInstance;

  GFileIOStreamPrivate* priv;
}

struct GFileIOStreamClass
{
  GIOStreamClass parentClass;

  extern(C) long function(GFileIOStream* stream) tell;

  extern(C) bool function(GFileIOStream* stream) canSeek;

  extern(C) bool function(GFileIOStream* stream, long offset, GSeekType type, GCancellable* cancellable, GError** _err) seek;

  extern(C) bool function(GFileIOStream* stream) canTruncate;

  extern(C) bool function(GFileIOStream* stream, long size, GCancellable* cancellable, GError** _err) truncateFn;

  extern(C) GFileInfo* function(GFileIOStream* stream, const(char)* attributes, GCancellable* cancellable, GError** _err) queryInfo;

  extern(C) void function(GFileIOStream* stream, const(char)* attributes, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) queryInfoAsync;

  extern(C) GFileInfo* function(GFileIOStream* stream, GAsyncResult* result, GError** _err) queryInfoFinish;

  extern(C) char* function(GFileIOStream* stream) getEtag;

  extern(C) void function() GReserved1;

  extern(C) void function() GReserved2;

  extern(C) void function() GReserved3;

  extern(C) void function() GReserved4;

  extern(C) void function() GReserved5;
}

struct GFileIOStreamPrivate;

/**
 * `GFileIcon` specifies an icon by pointing to an image file
 * to be used as icon.
 * It implements [Gio.LoadableIcon].
 */
struct GFileIcon;

struct GFileIconClass;

/**
 * An interface for writing VFS file handles.
 */
struct GFileIface
{
  /**
   * The parent interface.
   */
  GTypeInterface gIface;

  /**
   * Duplicates a #GFile.
   */
  extern(C) GFile* function(GFile* file) dup;

  /**
   * Creates a hash of a #GFile.
   */
  extern(C) uint function(GFile* file) hash;

  /**
   * Checks equality of two given #GFiles.
   */
  extern(C) bool function(GFile* file1, GFile* file2) equal;

  /**
   * Checks to see if a file is native to the system.
   */
  extern(C) bool function(GFile* file) isNative;

  /**
   * Checks to see if a #GFile has a given URI scheme.
   */
  extern(C) bool function(GFile* file, const(char)* uriScheme) hasUriScheme;

  /**
   * Gets the URI scheme for a #GFile.
   */
  extern(C) char* function(GFile* file) getUriScheme;

  /**
   * Gets the basename for a given #GFile.
   */
  extern(C) char* function(GFile* file) getBasename;

  /**
   * Gets the current path within a #GFile.
   */
  extern(C) char* function(GFile* file) getPath;

  /**
   * Gets a URI for the path within a #GFile.
   */
  extern(C) char* function(GFile* file) getUri;

  /**
   * Gets the parsed name for the #GFile.
   */
  extern(C) char* function(GFile* file) getParseName;

  /**
   * Gets the parent directory for the #GFile.
   */
  extern(C) GFile* function(GFile* file) getParent;

  /**
   * Checks whether a #GFile contains a specified file.
   */
  extern(C) bool function(GFile* prefix, GFile* file) prefixMatches;

  /**
   * Gets the path for a #GFile relative to a given path.
   */
  extern(C) char* function(GFile* parent, GFile* descendant) getRelativePath;

  /**
   * Resolves a relative path for a #GFile to an absolute path.
   */
  extern(C) GFile* function(GFile* file, const(char)* relativePath) resolveRelativePath;

  /**
   * Gets the child #GFile for a given display name.
   */
  extern(C) GFile* function(GFile* file, const(char)* displayName, GError** _err) getChildForDisplayName;

  /**
   * Gets a #GFileEnumerator with the children of a #GFile.
   */
  extern(C) GFileEnumerator* function(GFile* file, const(char)* attributes, GFileQueryInfoFlags flags, GCancellable* cancellable, GError** _err) enumerateChildren;

  /**
   * Asynchronously gets a #GFileEnumerator with the children of a #GFile.
   */
  extern(C) void function(GFile* file, const(char)* attributes, GFileQueryInfoFlags flags, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) enumerateChildrenAsync;

  /**
   * Finishes asynchronously enumerating the children.
   */
  extern(C) GFileEnumerator* function(GFile* file, GAsyncResult* res, GError** _err) enumerateChildrenFinish;

  /**
   * Gets the #GFileInfo for a #GFile.
   */
  extern(C) GFileInfo* function(GFile* file, const(char)* attributes, GFileQueryInfoFlags flags, GCancellable* cancellable, GError** _err) queryInfo;

  /**
   * Asynchronously gets the #GFileInfo for a #GFile.
   */
  extern(C) void function(GFile* file, const(char)* attributes, GFileQueryInfoFlags flags, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) queryInfoAsync;

  /**
   * Finishes an asynchronous query info operation.
   */
  extern(C) GFileInfo* function(GFile* file, GAsyncResult* res, GError** _err) queryInfoFinish;

  /**
   * Gets a #GFileInfo for the file system #GFile is on.
   */
  extern(C) GFileInfo* function(GFile* file, const(char)* attributes, GCancellable* cancellable, GError** _err) queryFilesystemInfo;

  /**
   * Asynchronously gets a #GFileInfo for the file system #GFile is on.
   */
  extern(C) void function(GFile* file, const(char)* attributes, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) queryFilesystemInfoAsync;

  /**
   * Finishes asynchronously getting the file system info.
   */
  extern(C) GFileInfo* function(GFile* file, GAsyncResult* res, GError** _err) queryFilesystemInfoFinish;

  /**
   * Gets a #GMount for the #GFile.
   */
  extern(C) GMount* function(GFile* file, GCancellable* cancellable, GError** _err) findEnclosingMount;

  /**
   * Asynchronously gets the #GMount for a #GFile.
   */
  extern(C) void function(GFile* file, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) findEnclosingMountAsync;

  /**
   * Finishes asynchronously getting the volume.
   */
  extern(C) GMount* function(GFile* file, GAsyncResult* res, GError** _err) findEnclosingMountFinish;

  /**
   * Sets the display name for a #GFile.
   */
  extern(C) GFile* function(GFile* file, const(char)* displayName, GCancellable* cancellable, GError** _err) setDisplayName;

  /**
   * Asynchronously sets a #GFile's display name.
   */
  extern(C) void function(GFile* file, const(char)* displayName, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) setDisplayNameAsync;

  /**
   * Finishes asynchronously setting a #GFile's display name.
   */
  extern(C) GFile* function(GFile* file, GAsyncResult* res, GError** _err) setDisplayNameFinish;

  /**
   * Returns a list of #GFileAttributeInfos that can be set.
   */
  extern(C) GFileAttributeInfoList* function(GFile* file, GCancellable* cancellable, GError** _err) querySettableAttributes;

  /**
   * Asynchronously gets a list of #GFileAttributeInfos that can be set.
   */
  extern(C) void function() QuerySettableAttributesAsync;

  /**
   * Finishes asynchronously querying settable attributes.
   */
  extern(C) void function() QuerySettableAttributesFinish;

  /**
   * Returns a list of #GFileAttributeInfo namespaces that are writable.
   */
  extern(C) GFileAttributeInfoList* function(GFile* file, GCancellable* cancellable, GError** _err) queryWritableNamespaces;

  /**
   * Asynchronously gets a list of #GFileAttributeInfo namespaces that are writable.
   */
  extern(C) void function() QueryWritableNamespacesAsync;

  /**
   * Finishes asynchronously querying the writable namespaces.
   */
  extern(C) void function() QueryWritableNamespacesFinish;

  /**
   * Sets a #GFileAttributeInfo.
   */
  extern(C) bool function(GFile* file, const(char)* attribute, GFileAttributeType type, void* valueP, GFileQueryInfoFlags flags, GCancellable* cancellable, GError** _err) setAttribute;

  /**
   * Sets a #GFileAttributeInfo with information from a #GFileInfo.
   */
  extern(C) bool function(GFile* file, GFileInfo* info, GFileQueryInfoFlags flags, GCancellable* cancellable, GError** _err) setAttributesFromInfo;

  /**
   * Asynchronously sets a file's attributes.
   */
  extern(C) void function(GFile* file, GFileInfo* info, GFileQueryInfoFlags flags, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) setAttributesAsync;

  /**
   * Finishes setting a file's attributes asynchronously.
   */
  extern(C) bool function(GFile* file, GAsyncResult* result, GFileInfo** info, GError** _err) setAttributesFinish;

  /**
   * Reads a file asynchronously.
   */
  extern(C) GFileInputStream* function(GFile* file, GCancellable* cancellable, GError** _err) readFn;

  /**
   * Asynchronously reads a file.
   */
  extern(C) void function(GFile* file, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) readAsync;

  /**
   * Finishes asynchronously reading a file.
   */
  extern(C) GFileInputStream* function(GFile* file, GAsyncResult* res, GError** _err) readFinish;

  /**
   * Writes to the end of a file.
   */
  extern(C) GFileOutputStream* function(GFile* file, GFileCreateFlags flags, GCancellable* cancellable, GError** _err) appendTo;

  /**
   * Asynchronously writes to the end of a file.
   */
  extern(C) void function(GFile* file, GFileCreateFlags flags, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) appendToAsync;

  /**
   * Finishes an asynchronous file append operation.
   */
  extern(C) GFileOutputStream* function(GFile* file, GAsyncResult* res, GError** _err) appendToFinish;

  /**
   * Creates a new file.
   */
  extern(C) GFileOutputStream* function(GFile* file, GFileCreateFlags flags, GCancellable* cancellable, GError** _err) create;

  /**
   * Asynchronously creates a file.
   */
  extern(C) void function(GFile* file, GFileCreateFlags flags, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) createAsync;

  /**
   * Finishes asynchronously creating a file.
   */
  extern(C) GFileOutputStream* function(GFile* file, GAsyncResult* res, GError** _err) createFinish;

  /**
   * Replaces the contents of a file.
   */
  extern(C) GFileOutputStream* function(GFile* file, const(char)* etag, bool makeBackup, GFileCreateFlags flags, GCancellable* cancellable, GError** _err) replace;

  /**
   * Asynchronously replaces the contents of a file.
   */
  extern(C) void function(GFile* file, const(char)* etag, bool makeBackup, GFileCreateFlags flags, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) replaceAsync;

  /**
   * Finishes asynchronously replacing a file.
   */
  extern(C) GFileOutputStream* function(GFile* file, GAsyncResult* res, GError** _err) replaceFinish;

  /**
   * Deletes a file.
   */
  extern(C) bool function(GFile* file, GCancellable* cancellable, GError** _err) deleteFile;

  /**
   * Asynchronously deletes a file.
   */
  extern(C) void function(GFile* file, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) deleteFileAsync;

  /**
   * Finishes an asynchronous delete.
   */
  extern(C) bool function(GFile* file, GAsyncResult* result, GError** _err) deleteFileFinish;

  /**
   * Sends a #GFile to the Trash location.
   */
  extern(C) bool function(GFile* file, GCancellable* cancellable, GError** _err) trash;

  /**
   * Asynchronously sends a #GFile to the Trash location.
   */
  extern(C) void function(GFile* file, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) trashAsync;

  /**
   * Finishes an asynchronous file trashing operation.
   */
  extern(C) bool function(GFile* file, GAsyncResult* result, GError** _err) trashFinish;

  /**
   * Makes a directory.
   */
  extern(C) bool function(GFile* file, GCancellable* cancellable, GError** _err) makeDirectory;

  /**
   * Asynchronously makes a directory.
   */
  extern(C) void function(GFile* file, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) makeDirectoryAsync;

  /**
   * Finishes making a directory asynchronously.
   */
  extern(C) bool function(GFile* file, GAsyncResult* result, GError** _err) makeDirectoryFinish;

  /**
   * Makes a symbolic link. %NULL if symbolic
   * links are unsupported.
   */
  extern(C) bool function(GFile* file, const(char)* symlinkValue, GCancellable* cancellable, GError** _err) makeSymbolicLink;

  /**
   * Asynchronously makes a symbolic link
   */
  extern(C) void function(GFile* file, const(char)* symlinkValue, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) makeSymbolicLinkAsync;

  /**
   * Finishes making a symbolic link asynchronously.
   */
  extern(C) bool function(GFile* file, GAsyncResult* result, GError** _err) makeSymbolicLinkFinish;

  /**
   * Copies a file. %NULL if copying is unsupported, which will
   * cause `GFile` to use a fallback copy method where it reads from the
   * source and writes to the destination.
   */
  extern(C) bool function(GFile* source, GFile* destination, GFileCopyFlags flags, GCancellable* cancellable, GFileProgressCallback progressCallback, void* progressCallbackData, GError** _err) copy;

  /**
   * Asynchronously copies a file.
   */
  extern(C) void function(GFile* source, GFile* destination, GFileCopyFlags flags, int ioPriority, GCancellable* cancellable, GFileProgressCallback progressCallback, void* progressCallbackData, GAsyncReadyCallback callback, void* userData) copyAsync;

  /**
   * Finishes an asynchronous copy operation.
   */
  extern(C) bool function(GFile* file, GAsyncResult* res, GError** _err) copyFinish;

  /**
   * Moves a file.
   */
  extern(C) bool function(GFile* source, GFile* destination, GFileCopyFlags flags, GCancellable* cancellable, GFileProgressCallback progressCallback, void* progressCallbackData, GError** _err) move;

  /**
   * Asynchronously moves a file. Since: 2.72
   */
  extern(C) void function(GFile* source, GFile* destination, GFileCopyFlags flags, int ioPriority, GCancellable* cancellable, GFileProgressCallback progressCallback, void* progressCallbackData, GAsyncReadyCallback callback, void* userData) moveAsync;

  /**
   * Finishes an asynchronous move operation. Since: 2.72
   */
  extern(C) bool function(GFile* file, GAsyncResult* result, GError** _err) moveFinish;

  /**
   * Mounts a mountable object.
   */
  extern(C) void function(GFile* file, GMountMountFlags flags, GMountOperation* mountOperation, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) mountMountable;

  /**
   * Finishes a mounting operation.
   */
  extern(C) GFile* function(GFile* file, GAsyncResult* result, GError** _err) mountMountableFinish;

  /**
   * Unmounts a mountable object.
   */
  extern(C) void function(GFile* file, GMountUnmountFlags flags, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) unmountMountable;

  /**
   * Finishes an unmount operation.
   */
  extern(C) bool function(GFile* file, GAsyncResult* result, GError** _err) unmountMountableFinish;

  /**
   * Ejects a mountable.
   */
  extern(C) void function(GFile* file, GMountUnmountFlags flags, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) ejectMountable;

  /**
   * Finishes an eject operation.
   */
  extern(C) bool function(GFile* file, GAsyncResult* result, GError** _err) ejectMountableFinish;

  /**
   * Mounts a specified location.
   */
  extern(C) void function(GFile* location, GMountMountFlags flags, GMountOperation* mountOperation, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) mountEnclosingVolume;

  /**
   * Finishes mounting a specified location.
   */
  extern(C) bool function(GFile* location, GAsyncResult* result, GError** _err) mountEnclosingVolumeFinish;

  /**
   * Creates a #GFileMonitor for the location.
   */
  extern(C) GFileMonitor* function(GFile* file, GFileMonitorFlags flags, GCancellable* cancellable, GError** _err) monitorDir;

  /**
   * Creates a #GFileMonitor for the location.
   */
  extern(C) GFileMonitor* function(GFile* file, GFileMonitorFlags flags, GCancellable* cancellable, GError** _err) monitorFile;

  /**
   * Open file read/write. Since 2.22.
   */
  extern(C) GFileIOStream* function(GFile* file, GCancellable* cancellable, GError** _err) openReadwrite;

  /**
   * Asynchronously opens file read/write. Since 2.22.
   */
  extern(C) void function(GFile* file, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) openReadwriteAsync;

  /**
   * Finishes an asynchronous open read/write. Since 2.22.
   */
  extern(C) GFileIOStream* function(GFile* file, GAsyncResult* res, GError** _err) openReadwriteFinish;

  /**
   * Creates file read/write. Since 2.22.
   */
  extern(C) GFileIOStream* function(GFile* file, GFileCreateFlags flags, GCancellable* cancellable, GError** _err) createReadwrite;

  /**
   * Asynchronously creates file read/write. Since 2.22.
   */
  extern(C) void function(GFile* file, GFileCreateFlags flags, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) createReadwriteAsync;

  /**
   * Finishes an asynchronous creates read/write. Since 2.22.
   */
  extern(C) GFileIOStream* function(GFile* file, GAsyncResult* res, GError** _err) createReadwriteFinish;

  /**
   * Replaces file read/write. Since 2.22.
   */
  extern(C) GFileIOStream* function(GFile* file, const(char)* etag, bool makeBackup, GFileCreateFlags flags, GCancellable* cancellable, GError** _err) replaceReadwrite;

  /**
   * Asynchronously replaces file read/write. Since 2.22.
   */
  extern(C) void function(GFile* file, const(char)* etag, bool makeBackup, GFileCreateFlags flags, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) replaceReadwriteAsync;

  /**
   * Finishes an asynchronous replace read/write. Since 2.22.
   */
  extern(C) GFileIOStream* function(GFile* file, GAsyncResult* res, GError** _err) replaceReadwriteFinish;

  /**
   * Starts a mountable object. Since 2.22.
   */
  extern(C) void function(GFile* file, GDriveStartFlags flags, GMountOperation* startOperation, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) startMountable;

  /**
   * Finishes a start operation. Since 2.22.
   */
  extern(C) bool function(GFile* file, GAsyncResult* result, GError** _err) startMountableFinish;

  /**
   * Stops a mountable. Since 2.22.
   */
  extern(C) void function(GFile* file, GMountUnmountFlags flags, GMountOperation* mountOperation, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) stopMountable;

  /**
   * Finishes a stop operation. Since 2.22.
   */
  extern(C) bool function(GFile* file, GAsyncResult* result, GError** _err) stopMountableFinish;

  /**
   * a boolean that indicates whether the #GFile implementation supports thread-default contexts. Since 2.22.
   */
  bool supportsThreadContexts;

  /**
   * Unmounts a mountable object using a #GMountOperation. Since 2.22.
   */
  extern(C) void function(GFile* file, GMountUnmountFlags flags, GMountOperation* mountOperation, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) unmountMountableWithOperation;

  /**
   * Finishes an unmount operation using a #GMountOperation. Since 2.22.
   */
  extern(C) bool function(GFile* file, GAsyncResult* result, GError** _err) unmountMountableWithOperationFinish;

  /**
   * Ejects a mountable object using a #GMountOperation. Since 2.22.
   */
  extern(C) void function(GFile* file, GMountUnmountFlags flags, GMountOperation* mountOperation, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) ejectMountableWithOperation;

  /**
   * Finishes an eject operation using a #GMountOperation. Since 2.22.
   */
  extern(C) bool function(GFile* file, GAsyncResult* result, GError** _err) ejectMountableWithOperationFinish;

  /**
   * Polls a mountable object for media changes. Since 2.22.
   */
  extern(C) void function(GFile* file, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) pollMountable;

  /**
   * Finishes a poll operation for media changes. Since 2.22.
   */
  extern(C) bool function(GFile* file, GAsyncResult* result, GError** _err) pollMountableFinish;

  /**
   * Recursively measures the disk usage of @file. Since 2.38
   */
  extern(C) bool function(GFile* file, GFileMeasureFlags flags, GCancellable* cancellable, GFileMeasureProgressCallback progressCallback, void* progressData, ulong* diskUsage, ulong* numDirs, ulong* numFiles, GError** _err) measureDiskUsage;

  /**
   * Asynchronously recursively measures the disk usage of @file. Since 2.38
   */
  extern(C) void function(GFile* file, GFileMeasureFlags flags, int ioPriority, GCancellable* cancellable, GFileMeasureProgressCallback progressCallback, void* progressData, GAsyncReadyCallback callback, void* userData) measureDiskUsageAsync;

  /**
   * Finishes an asynchronous recursive measurement of the disk usage of @file. Since 2.38
   */
  extern(C) bool function(GFile* file, GAsyncResult* result, ulong* diskUsage, ulong* numDirs, ulong* numFiles, GError** _err) measureDiskUsageFinish;
}

/**
 * Stores information about a file system object referenced by a [Gio.File].
 * Functionality for manipulating basic metadata for files. `GFileInfo`
 * implements methods for getting information that all files should
 * contain, and allows for manipulation of extended attributes.
 * See [file-attributes.html](file attributes) for more information on how GIO
 * handles file attributes.
 * To obtain a `GFileInfo` for a [Gio.File], use
 * [Gio.File.queryInfo] (or its async variant). To obtain a `GFileInfo`
 * for a file input or output stream, use [Gio.FileInputStream.queryInfo]
 * or [Gio.FileOutputStream.queryInfo] (or their async variants).
 * To change the actual attributes of a file, you should then set the
 * attribute in the `GFileInfo` and call [Gio.File.setAttributesFromInfo]
 * or [Gio.File.setAttributesAsync] on a `GFile`.
 * However, not all attributes can be changed in the file. For instance,
 * the actual size of a file cannot be changed via [Gio.FileInfo.setSize].
 * You may call [Gio.File.querySettableAttributes] and
 * [Gio.File.queryWritableNamespaces] to discover the settable attributes
 * of a particular file at runtime.
 * The direct accessors, such as [Gio.FileInfo.getName], are slightly more
 * optimized than the generic attribute accessors, such as
 * [Gio.FileInfo.getAttributeByteString].This optimization will matter
 * only if calling the API in a tight loop.
 * It is an error to call these accessors without specifying their required file
 * attributes when creating the `GFileInfo`. Use
 * [Gio.FileInfo.hasAttribute] or [Gio.FileInfo.listAttributes]
 * to check what attributes are specified for a `GFileInfo`.
 * [Gio.FileAttributeMatcher] allows for searching through a `GFileInfo`
 * for attributes.
 */
struct GFileInfo;

struct GFileInfoClass;

/**
 * `GFileInputStream` provides input streams that take their
 * content from a file.
 * `GFileInputStream` implements [Gio.Seekable], which allows the input
 * stream to jump to arbitrary positions in the file, provided the
 * filesystem of the file allows it. To find the position of a file
 * input stream, use [Gio.Seekable.tell]. To find out if a file input
 * stream supports seeking, use vfunc@Gio.Seekable.can_seek.
 * To position a file input stream, use vfunc@Gio.Seekable.seek.
 */
struct GFileInputStream
{
  GInputStream parentInstance;

  GFileInputStreamPrivate* priv;
}

struct GFileInputStreamClass
{
  GInputStreamClass parentClass;

  extern(C) long function(GFileInputStream* stream) tell;

  extern(C) bool function(GFileInputStream* stream) canSeek;

  extern(C) bool function(GFileInputStream* stream, long offset, GSeekType type, GCancellable* cancellable, GError** _err) seek;

  extern(C) GFileInfo* function(GFileInputStream* stream, const(char)* attributes, GCancellable* cancellable, GError** _err) queryInfo;

  extern(C) void function(GFileInputStream* stream, const(char)* attributes, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) queryInfoAsync;

  extern(C) GFileInfo* function(GFileInputStream* stream, GAsyncResult* result, GError** _err) queryInfoFinish;

  extern(C) void function() GReserved1;

  extern(C) void function() GReserved2;

  extern(C) void function() GReserved3;

  extern(C) void function() GReserved4;

  extern(C) void function() GReserved5;
}

struct GFileInputStreamPrivate;

/**
 * Monitors a file or directory for changes.
 * To obtain a `GFileMonitor` for a file or directory, use
 * [Gio.File.monitor], [Gio.File.monitorFile], or
 * [Gio.File.monitorDirectory].
 * To get informed about changes to the file or directory you are
 * monitoring, connect to the [Gio.FileMonitor.changed] signal. The
 * signal will be emitted in the thread-default main context $(LPAREN)see
 * [GLib.MainContext.pushThreadDefault]$(RPAREN) of the thread that the monitor
 * was created in $(LPAREN)though if the global default main context is blocked, this
 * may cause notifications to be blocked even if the thread-default
 * context is still running$(RPAREN).
 */
struct GFileMonitor
{
  ObjectC parentInstance;

  GFileMonitorPrivate* priv;
}

struct GFileMonitorClass
{
  GObjectClass parentClass;

  extern(C) void function(GFileMonitor* monitor, GFile* file, GFile* otherFile, GFileMonitorEvent eventType) changed;

  extern(C) bool function(GFileMonitor* monitor) cancel;

  extern(C) void function() GReserved1;

  extern(C) void function() GReserved2;

  extern(C) void function() GReserved3;

  extern(C) void function() GReserved4;

  extern(C) void function() GReserved5;
}

struct GFileMonitorPrivate;

/**
 * `GFileOutputStream` provides output streams that write their
 * content to a file.
 * `GFileOutputStream` implements [Gio.Seekable], which allows the output
 * stream to jump to arbitrary positions in the file and to truncate
 * the file, provided the filesystem of the file supports these
 * operations.
 * To find the position of a file output stream, use [Gio.Seekable.tell].
 * To find out if a file output stream supports seeking, use
 * [Gio.Seekable.canSeek].To position a file output stream, use
 * [Gio.Seekable.seek]. To find out if a file output stream supports
 * truncating, use [Gio.Seekable.canTruncate]. To truncate a file output
 * stream, use [Gio.Seekable.truncate].
 */
struct GFileOutputStream
{
  GOutputStream parentInstance;

  GFileOutputStreamPrivate* priv;
}

struct GFileOutputStreamClass
{
  GOutputStreamClass parentClass;

  extern(C) long function(GFileOutputStream* stream) tell;

  extern(C) bool function(GFileOutputStream* stream) canSeek;

  extern(C) bool function(GFileOutputStream* stream, long offset, GSeekType type, GCancellable* cancellable, GError** _err) seek;

  extern(C) bool function(GFileOutputStream* stream) canTruncate;

  extern(C) bool function(GFileOutputStream* stream, long size, GCancellable* cancellable, GError** _err) truncateFn;

  extern(C) GFileInfo* function(GFileOutputStream* stream, const(char)* attributes, GCancellable* cancellable, GError** _err) queryInfo;

  extern(C) void function(GFileOutputStream* stream, const(char)* attributes, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) queryInfoAsync;

  extern(C) GFileInfo* function(GFileOutputStream* stream, GAsyncResult* result, GError** _err) queryInfoFinish;

  extern(C) char* function(GFileOutputStream* stream) getEtag;

  extern(C) void function() GReserved1;

  extern(C) void function() GReserved2;

  extern(C) void function() GReserved3;

  extern(C) void function() GReserved4;

  extern(C) void function() GReserved5;
}

struct GFileOutputStreamPrivate;

/**
 * Completes partial file and directory names given a partial string by
 * looking in the file system for clues. Can return a list of possible
 * completion strings for widget implementations.
 */
struct GFilenameCompleter;

struct GFilenameCompleterClass
{
  GObjectClass parentClass;

  extern(C) void function(GFilenameCompleter* filenameCompleter) gotCompletionData;

  extern(C) void function() GReserved1;

  extern(C) void function() GReserved2;

  extern(C) void function() GReserved3;
}

/**
 * Base class for input stream implementations that perform some
 * kind of filtering operation on a base stream. Typical examples
 * of filtering operations are character set conversion, compression
 * and byte order flipping.
 */
struct GFilterInputStream
{
  GInputStream parentInstance;

  GInputStream* baseStream;
}

struct GFilterInputStreamClass
{
  GInputStreamClass parentClass;

  extern(C) void function() GReserved1;

  extern(C) void function() GReserved2;

  extern(C) void function() GReserved3;
}

/**
 * Base class for output stream implementations that perform some
 * kind of filtering operation on a base stream. Typical examples
 * of filtering operations are character set conversion, compression
 * and byte order flipping.
 */
struct GFilterOutputStream
{
  GOutputStream parentInstance;

  GOutputStream* baseStream;
}

struct GFilterOutputStreamClass
{
  GOutputStreamClass parentClass;

  extern(C) void function() GReserved1;

  extern(C) void function() GReserved2;

  extern(C) void function() GReserved3;
}

/**
 * #GIOExtension is an opaque data structure and can only be accessed
 * using the following functions.
 */
struct GIOExtension;

/**
 * `GIOExtensionPoint` provides a mechanism for modules to extend the
 * functionality of the library or application that loaded it in an
 * organized fashion.
 * An extension point is identified by a name, and it may optionally
 * require that any implementation must be of a certain type $(LPAREN)or derived
 * thereof$(RPAREN). Use [Gio.IOExtensionPoint.register] to register an
 * extension point, and [Gio.IOExtensionPoint.setRequiredType] to
 * set a required type.
 * A module can implement an extension point by specifying the
 * [GObject.GType] that implements the functionality. Additionally, each
 * implementation of an extension point has a name, and a priority. Use
 * [Gio.IOExtensionPoint.implement] to implement an extension point.
 * ```c
 * GIOExtensionPoint *ep;
 * // Register an extension point
 * ep \= g_io_extension_point_register $(LPAREN)"my-extension-point"$(RPAREN);
 * g_io_extension_point_set_required_type $(LPAREN)ep, MY_TYPE_EXAMPLE$(RPAREN);
 * ```
 * ```c
 * // Implement an extension point
 * G_DEFINE_TYPE $(LPAREN)MyExampleImpl, my_example_impl, MY_TYPE_EXAMPLE$(RPAREN)
 * g_io_extension_point_implement $(LPAREN)"my-extension-point",
 * my_example_impl_get_type $(LPAREN)$(RPAREN),
 * "my-example",
 * 10$(RPAREN);
 * ```
 * It is up to the code that registered the extension point how
 * it uses the implementations that have been associated with it.
 * Depending on the use case, it may use all implementations, or
 * only the one with the highest priority, or pick a specific
 * one by name.
 * To avoid opening all modules just to find out what extension
 * points they implement, GIO makes use of a caching mechanism,
 * see [gio-querymodules](gio-querymodules.html).
 * You are expected to run this command after installing a
 * GIO module.
 * The `GIO_EXTRA_MODULES` environment variable can be used to
 * specify additional directories to automatically load modules
 * from. This environment variable has the same syntax as the
 * `PATH`. If two modules have the same base name in different
 * directories, then the latter one will be ignored. If additional
 * directories are specified GIO will load modules from the built-in
 * directory last.
 */
struct GIOExtensionPoint;

/**
 * Provides an interface and default functions for loading and unloading
 * modules. This is used internally to make GIO extensible, but can also
 * be used by others to implement module loading.
 */
struct GIOModule;

struct GIOModuleClass;

/**
 * Represents a scope for loading IO modules. A scope can be used for blocking
 * duplicate modules, or blocking a module you don't want to load.
 * The scope can be used with [Gio.Global.ioModulesLoadAllInDirectoryWithScope]
 * or [Gio.Global.ioModulesScanAllInDirectoryWithScope].
 */
struct GIOModuleScope;

/**
 * Opaque class for defining and scheduling IO jobs.

 * Deprecated: Use [GLib.ThreadPool] or
 *   [Gio.Task.runInThread]
 */
struct GIOSchedulerJob;

/**
 * `GIOStream` represents an object that has both read and write streams.
 * Generally the two streams act as separate input and output streams,
 * but they share some common resources and state. For instance, for
 * seekable streams, both streams may use the same position.
 * Examples of `GIOStream` objects are [Gio.SocketConnection], which represents
 * a two-way network connection; and [Gio.FileIOStream], which represents a
 * file handle opened in read-write mode.
 * To do the actual reading and writing you need to get the substreams
 * with [Gio.IOStream.getInputStream] and
 * [Gio.IOStream.getOutputStream].
 * The `GIOStream` object owns the input and the output streams, not the other
 * way around, so keeping the substreams alive will not keep the `GIOStream`
 * object alive. If the `GIOStream` object is freed it will be closed, thus
 * closing the substreams, so even if the substreams stay alive they will
 * always return `G_IO_ERROR_CLOSED` for all operations.
 * To close a stream use [Gio.IOStream.close] which will close the common
 * stream object and also the individual substreams. You can also close
 * the substreams themselves. In most cases this only marks the
 * substream as closed, so further I/O on it fails but common state in the
 * `GIOStream` may still be open. However, some streams may support
 * ‘half-closed’ states where one direction of the stream is actually shut down.
 * Operations on `GIOStream`s cannot be started while another operation on the
 * `GIOStream` or its substreams is in progress. Specifically, an application can
 * read from the [Gio.InputStream] and write to the
 * [Gio.OutputStream] simultaneously $(LPAREN)either in separate threads, or as
 * asynchronous operations in the same thread$(RPAREN), but an application cannot start
 * any `GIOStream` operation while there is a `GIOStream`, `GInputStream` or
 * `GOutputStream` operation in progress, and an application can’t start any
 * `GInputStream` or `GOutputStream` operation while there is a `GIOStream`
 * operation in progress.
 * This is a product of individual stream operations being associated with a
 * given [GLib.MainContext] $(LPAREN)the thread-default context at the time the
 * operation was started$(RPAREN), rather than entire streams being associated with a
 * single `GMainContext`.
 * GIO may run operations on `GIOStream`s from other $(LPAREN)worker$(RPAREN) threads, and this
 * may be exposed to application code in the behaviour of wrapper streams, such
 * as [Gio.BufferedInputStream] or [Gio.TlsConnection]. With such
 * wrapper APIs, application code may only run operations on the base $(LPAREN)wrapped$(RPAREN)
 * stream when the wrapper stream is idle. Note that the semantics of such
 * operations may not be well-defined due to the state the wrapper stream leaves
 * the base stream in $(LPAREN)though they are guaranteed not to crash$(RPAREN).
 */
struct GIOStream
{
  ObjectC parentInstance;

  GIOStreamPrivate* priv;
}

struct GIOStreamAdapter;

struct GIOStreamClass
{
  GObjectClass parentClass;

  extern(C) GInputStream* function(GIOStream* stream) getInputStream;

  extern(C) GOutputStream* function(GIOStream* stream) getOutputStream;

  extern(C) bool function(GIOStream* stream, GCancellable* cancellable, GError** _err) closeFn;

  extern(C) void function(GIOStream* stream, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) closeAsync;

  extern(C) bool function(GIOStream* stream, GAsyncResult* result, GError** _err) closeFinish;

  extern(C) void function() GReserved1;

  extern(C) void function() GReserved2;

  extern(C) void function() GReserved3;

  extern(C) void function() GReserved4;

  extern(C) void function() GReserved5;

  extern(C) void function() GReserved6;

  extern(C) void function() GReserved7;

  extern(C) void function() GReserved8;

  extern(C) void function() GReserved9;

  extern(C) void function() GReserved10;
}

struct GIOStreamPrivate;

/**
 * `GIcon` is a very minimal interface for icons. It provides functions
 * for checking the equality of two icons, hashing of icons and
 * serializing an icon to and from strings.
 * `GIcon` does not provide the actual pixmap for the icon as this is out
 * of GIO's scope, however implementations of `GIcon` may contain the name
 * of an icon $(LPAREN)see [Gio.ThemedIcon]$(RPAREN), or the path to an icon
 * $(LPAREN)see [Gio.LoadableIcon]$(RPAREN).
 * To obtain a hash of a `GIcon`, see [Gio.Icon.hash].
 * To check if two `GIcon`s are equal, see [Gio.Icon.equal].
 * For serializing a `GIcon`, use [Gio.Icon.serialize] and
 * [Gio.Icon.deserialize].
 * If you want to consume `GIcon` $(LPAREN)for example, in a toolkit$(RPAREN) you must
 * be prepared to handle at least the three following cases:
 * [Gio.LoadableIcon], [Gio.ThemedIcon] and [Gio.EmblemedIcon].
 * It may also make sense to have fast-paths for other cases $(LPAREN)like handling
 * [`GdkPixbuf`](https://docs.gtk.org/gdk-pixbuf/class.Pixbuf.html) directly,
 * for example$(RPAREN) but all compliant `GIcon` implementations outside of GIO must
 * implement [Gio.LoadableIcon].
 * If your application or library provides one or more `GIcon`
 * implementations you need to ensure that your new implementation also
 * implements [Gio.LoadableIcon].  Additionally, you must provide an
 * implementation of [Gio.Icon.serialize] that gives a result that is
 * understood by [Gio.Icon.deserialize], yielding one of the built-in
 * icon types.
 */
struct GIcon;

/**
 * GIconIface is used to implement GIcon types for various
 * different systems. See #GThemedIcon and #GLoadableIcon for
 * examples of how to implement this interface.
 */
struct GIconIface
{
  /**
   * The parent interface.
   */
  GTypeInterface gIface;

  /**
   * A hash for a given #GIcon.
   */
  extern(C) uint function(GIcon* icon) hash;

  /**
   * Checks if two #GIcons are equal.
   */
  extern(C) bool function(GIcon* icon1, GIcon* icon2) equal;

  /**
   * Serializes a #GIcon into tokens. The tokens must not
   * contain any whitespace. Don't implement if the #GIcon can't be
   * serialized $(LPAREN)Since 2.20$(RPAREN).
   */
  extern(C) bool function(GIcon* icon, GPtrArray* tokens, int* outVersion) toTokens;

  /**
   * Constructs a #GIcon from tokens. Set the #GError if
   * the tokens are malformed. Don't implement if the #GIcon can't be
   * serialized $(LPAREN)Since 2.20$(RPAREN).
   */
  extern(C) GIcon* function(char** tokens, int numTokens, int version_, GError** _err) fromTokens;

  /**
   * Serializes a #GIcon into a #GVariant. Since: 2.38
   */
  extern(C) VariantC* function(GIcon* icon) serialize;
}

/**
 * `GInetAddress` represents an IPv4 or IPv6 internet address. Use
 * [Gio.Resolver.lookupByName] or
 * [Gio.Resolver.lookupByNameAsync] to look up the `GInetAddress` for
 * a hostname. Use [Gio.Resolver.lookupByAddress] or
 * [Gio.Resolver.lookupByAddressAsync] to look up the hostname for a
 * `GInetAddress`.
 * To actually connect to a remote host, you will need a
 * [Gio.InetSocketAddress] $(LPAREN)which includes a `GInetAddress` as well as a
 * port number$(RPAREN).
 */
struct GInetAddress
{
  ObjectC parentInstance;

  GInetAddressPrivate* priv;
}

struct GInetAddressClass
{
  GObjectClass parentClass;

  extern(C) char* function(GInetAddress* address) toString_;

  extern(C) const(ubyte)* function(GInetAddress* address) toBytes;
}

/**
 * `GInetAddressMask` represents a range of IPv4 or IPv6 addresses
 * described by a base address and a length indicating how many bits
 * of the base address are relevant for matching purposes. These are
 * often given in string form. For example, `10.0.0.0/8`, or `fe80::/10`.
 */
struct GInetAddressMask
{
  ObjectC parentInstance;

  GInetAddressMaskPrivate* priv;
}

struct GInetAddressMaskClass
{
  GObjectClass parentClass;
}

struct GInetAddressMaskPrivate;

struct GInetAddressPrivate;

/**
 * An IPv4 or IPv6 socket address. That is, the combination of a
 * [Gio.InetAddress] and a port number.
 * In UNIX terms, `GInetSocketAddress` corresponds to a
 * [`struct sockaddr_in` or `struct sockaddr_in6`]$(LPAREN)$(RPAREN)(man:sockaddr3type).
 */
struct GInetSocketAddress
{
  GSocketAddress parentInstance;

  GInetSocketAddressPrivate* priv;
}

struct GInetSocketAddressClass
{
  GSocketAddressClass parentClass;
}

struct GInetSocketAddressPrivate;

/**
 * `GInitable` is implemented by objects that can fail during
 * initialization. If an object implements this interface then
 * it must be initialized as the first thing after construction,
 * either via [Gio.Initable.init_] or [Gio.AsyncInitable.initAsync]
 * $(LPAREN)the latter is only available if it also implements [Gio.AsyncInitable]$(RPAREN).
 * If the object is not initialized, or initialization returns with an
 * error, then all operations on the object except `[GObject.ObjectG.ref_]` and
 * `[GObject.ObjectG.unref]` are considered to be invalid, and have undefined
 * behaviour. They will often fail with func@GLib.critical or
 * func@GLib.warning, but this must not be relied on.
 * Users of objects implementing this are not intended to use
 * the interface method directly, instead it will be used automatically
 * in various ways. For C applications you generally just call
 * [Gio.Initable.new_] directly, or indirectly via a `foo_thing_new()` wrapper.
 * This will call [Gio.Initable.init_] under the cover, returning `NULL`
 * and setting a `GError` on failure $(LPAREN)at which point the instance is
 * unreferenced$(RPAREN).
 * For bindings in languages where the native constructor supports
 * exceptions the binding could check for objects implementing `GInitable`
 * during normal construction and automatically initialize them, throwing
 * an exception on failure.
 */
struct GInitable;

/**
 * Provides an interface for initializing object such that initialization
 * may fail.
 */
struct GInitableIface
{
  /**
   * The parent interface.
   */
  GTypeInterface gIface;

  /**
   * Initializes the object.
   */
  extern(C) bool function(GInitable* initable, GCancellable* cancellable, GError** _err) init_;
}

/**
 * Structure used for scatter/gather data input when receiving multiple
 * messages or packets in one go. You generally pass in an array of empty
 * #GInputVectors and the operation will use all the buffers as if they
 * were one buffer, and will set @bytes_received to the total number of bytes
 * received across all #GInputVectors.
 * This structure closely mirrors `struct mmsghdr` and `struct msghdr` from
 * the POSIX sockets API $(LPAREN)see `man 2 recvmmsg`$(RPAREN).
 * If @address is non-%NULL then it is set to the source address the message
 * was received from, and the caller must free it afterwards.
 * If @control_messages is non-%NULL then it is set to an array of control
 * messages received with the message $(LPAREN)if any$(RPAREN), and the caller must free it
 * afterwards. @num_control_messages is set to the number of elements in
 * this array, which may be zero.
 * Flags relevant to this message will be returned in @flags. For example,
 * `MSG_EOR` or `MSG_TRUNC`.
 */
struct GInputMessage
{
  /**
   * return location
   * for a #GSocketAddress, or %NULL
   */
  GSocketAddress** address;

  /**
   * pointer to an
   * array of input vectors
   */
  GInputVector* vectors;

  /**
   * the number of input vectors pointed to by @vectors
   */
  uint numVectors;

  /**
   * will be set to the number of bytes that have been
   * received
   */
  size_t bytesReceived;

  /**
   * collection of #GSocketMsgFlags for the received message,
   * outputted by the call
   */
  int flags;

  /**
   * return location for a
   * caller-allocated array of #GSocketControlMessages, or %NULL
   */
  GSocketControlMessage*** controlMessages;

  /**
   * return location for the number of
   * elements in @control_messages
   */
  uint* numControlMessages;
}

/**
 * `GInputStream` is a base class for implementing streaming input.
 * It has functions to read from a stream $(LPAREN)[Gio.InputStream.read]$(RPAREN),
 * to close a stream $(LPAREN)[Gio.InputStream.close]$(RPAREN) and to skip some content
 * $(LPAREN)[Gio.InputStream.skip]$(RPAREN).
 * To copy the content of an input stream to an output stream without
 * manually handling the reads and writes, use [Gio.OutputStream.splice].
 * See the documentation for [Gio.IOStream] for details of thread safety
 * of streaming APIs.
 * All of these functions have async variants too.
 */
struct GInputStream
{
  ObjectC parentInstance;

  GInputStreamPrivate* priv;
}

struct GInputStreamClass
{
  GObjectClass parentClass;

  extern(C) ptrdiff_t function(GInputStream* stream, void* buffer, size_t count, GCancellable* cancellable, GError** _err) readFn;

  extern(C) ptrdiff_t function(GInputStream* stream, size_t count, GCancellable* cancellable, GError** _err) skip;

  extern(C) bool function(GInputStream* stream, GCancellable* cancellable, GError** _err) closeFn;

  extern(C) void function(GInputStream* stream, void* buffer, size_t count, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) readAsync;

  extern(C) ptrdiff_t function(GInputStream* stream, GAsyncResult* result, GError** _err) readFinish;

  extern(C) void function(GInputStream* stream, size_t count, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) skipAsync;

  extern(C) ptrdiff_t function(GInputStream* stream, GAsyncResult* result, GError** _err) skipFinish;

  extern(C) void function(GInputStream* stream, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) closeAsync;

  extern(C) bool function(GInputStream* stream, GAsyncResult* result, GError** _err) closeFinish;

  extern(C) void function() GReserved1;

  extern(C) void function() GReserved2;

  extern(C) void function() GReserved3;

  extern(C) void function() GReserved4;

  extern(C) void function() GReserved5;
}

struct GInputStreamPrivate;

/**
 * Structure used for scatter/gather data input.
 * You generally pass in an array of #GInputVectors
 * and the operation will store the read data starting in the
 * first buffer, switching to the next as needed.
 */
struct GInputVector
{
  /**
   * Pointer to a buffer where data will be written.
   */
  void* buffer;

  /**
   * the available size in @buffer.
   */
  size_t size;
}

/**
 * `GListModel` is an interface that represents a mutable list of
 * [GObject.ObjectG]. Its main intention is as a model for various widgets
 * in user interfaces, such as list views, but it can also be used as a
 * convenient method of returning lists of data, with support for
 * updates.
 * Each object in the list may also report changes in itself via some
 * mechanism $(LPAREN)normally the [GObject.ObjectG.notify] signal$(RPAREN).  Taken
 * together with the signal@Gio.ListModel::items-changed signal, this provides
 * for a list that can change its membership, and in which the members can
 * change their individual properties.
 * A good example would be the list of visible wireless network access
 * points, where each access point can report dynamic properties such as
 * signal strength.
 * It is important to note that the `GListModel` itself does not report
 * changes to the individual items.  It only reports changes to the list
 * membership.  If you want to observe changes to the objects themselves
 * then you need to connect signals to the objects that you are
 * interested in.
 * All items in a `GListModel` are of $(LPAREN)or derived from$(RPAREN) the same type.
 * [Gio.ListModel.getItemType] returns that type.  The type may be an
 * interface, in which case all objects in the list must implement it.
 * The semantics are close to that of an array:
 * [Gio.ListModel.getNItems] returns the number of items in the list
 * and [Gio.ListModel.getItem] returns an item at a (0-based) position.
 * In order to allow implementations to calculate the list length lazily,
 * you can also iterate over items: starting from 0, repeatedly call
 * [Gio.ListModel.getItem] until it returns `NULL`.
 * An implementation may create objects lazily, but must take care to
 * return the same object for a given position until all references to
 * it are gone.
 * On the other side, a consumer is expected only to hold references on
 * objects that are currently ‘user visible’, in order to facilitate the
 * maximum level of laziness in the implementation of the list and to
 * reduce the required number of signal connections at a given time.
 * This interface is intended only to be used from a single thread.  The
 * thread in which it is appropriate to use it depends on the particular
 * implementation, but typically it will be from the thread that owns
 * the thread-default main context $(LPAREN)see
 * [GLib.MainContext.pushThreadDefault]$(RPAREN) in effect at the time that the
 * model was created.
 * Over time, it has established itself as good practice for list model
 * implementations to provide properties `item-type` and `n-items` to
 * ease working with them. While it is not required, it is recommended
 * that implementations provide these two properties. They should return
 * the values of [Gio.ListModel.getItemType] and
 * [Gio.ListModel.getNItems] respectively and be defined as such:
 * ```c
 * properties[PROP_ITEM_TYPE] \=
 * g_param_spec_gtype $(LPAREN)"item-type", NULL, NULL, G_TYPE_OBJECT,
 * G_PARAM_CONSTRUCT_ONLY | G_PARAM_READWRITE | G_PARAM_STATIC_STRINGS$(RPAREN);
 * properties[PROP_N_ITEMS] \=
 * g_param_spec_uint $(LPAREN)"n-items", NULL, NULL, 0, G_MAXUINT, 0,
 * G_PARAM_READABLE | G_PARAM_STATIC_STRINGS$(RPAREN);
 * ```
 */
struct GListModel;

/**
 * The virtual function table for #GListModel.
 */
struct GListModelInterface
{
  /**
   * parent #GTypeInterface
   */
  GTypeInterface gIface;

  /**
   * the virtual function pointer for [Gio.ListModel.getItemType]
   */
  extern(C) GType function(GListModel* list) getItemType;

  /**
   * the virtual function pointer for [Gio.ListModel.getNItems]
   */
  extern(C) uint function(GListModel* list) getNItems;

  /**
   * the virtual function pointer for [Gio.ListModel.getItem]
   */
  extern(C) ObjectC* function(GListModel* list, uint position) getItem;
}

/**
 * `GListStore` is a simple implementation of [Gio.ListModel] that stores
 * all items in memory.
 * It provides insertions, deletions, and lookups in logarithmic time
 * with a fast path for the common case of iterating the list linearly.
 */
struct GListStore;

struct GListStoreClass
{
  GObjectClass parentClass;
}

/**
 * `GLoadableIcon` extends the [Gio.Icon] interface and adds the ability
 * to load icons from streams.
 */
struct GLoadableIcon;

/**
 * Interface for icons that can be loaded as a stream.
 */
struct GLoadableIconIface
{
  /**
   * The parent interface.
   */
  GTypeInterface gIface;

  /**
   * Loads an icon.
   */
  extern(C) GInputStream* function(GLoadableIcon* icon, int size, char** type, GCancellable* cancellable, GError** _err) load;

  /**
   * Loads an icon asynchronously.
   */
  extern(C) void function(GLoadableIcon* icon, int size, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) loadAsync;

  /**
   * Finishes an asynchronous icon load.
   */
  extern(C) GInputStream* function(GLoadableIcon* icon, GAsyncResult* res, char** type, GError** _err) loadFinish;
}

/**
 * `GMemoryInputStream` is a class for using arbitrary
 * memory chunks as input for GIO streaming input operations.
 * As of GLib 2.34, `GMemoryInputStream` implements
 * [Gio.PollableInputStream].
 */
struct GMemoryInputStream
{
  GInputStream parentInstance;

  GMemoryInputStreamPrivate* priv;
}

struct GMemoryInputStreamClass
{
  GInputStreamClass parentClass;

  extern(C) void function() GReserved1;

  extern(C) void function() GReserved2;

  extern(C) void function() GReserved3;

  extern(C) void function() GReserved4;

  extern(C) void function() GReserved5;
}

struct GMemoryInputStreamPrivate;

/**
 * `GMemoryMonitor` will monitor system memory and suggest to the application
 * when to free memory so as to leave more room for other applications.
 * It is implemented on Linux using the
 * [Low Memory Monitor](https://gitlab.freedesktop.org/hadess/low-memory-monitor/)
 * $(LPAREN)[API documentation](https://hadess.pages.freedesktop.org/low-memory-monitor/)$(RPAREN).
 * There is also an implementation for use inside Flatpak sandboxes.
 * Possible actions to take when the signal is received are:
 * - Free caches
 * - Save files that haven’t been looked at in a while to disk, ready to be reopened when needed
 * - Run a garbage collection cycle
 * - Try and compress fragmented allocations
 * - Exit on idle if the process has no reason to stay around
 * - Call [`malloc_trim$(LPAREN)3$(RPAREN)`]$(LPAREN)$(RPAREN)(man:malloc_trim3) to return cached heap pages to
 * the kernel $(LPAREN)if supported by your libc$(RPAREN)
 * Note that some actions may not always improve system performance, and so
 * should be profiled for your application. `malloc_trim$(LPAREN)$(RPAREN)`, for example, may
 * make future heap allocations slower $(LPAREN)due to releasing cached heap pages back
 * to the kernel$(RPAREN).
 * See [Gio] for details on the various warning
 * levels.
 * ```c
 * static void
 * warning_cb $(LPAREN)GMemoryMonitor *m, GMemoryMonitorWarningLevel level$(RPAREN)
 * {
 * g_debug $(LPAREN)"Warning level: %d", level$(RPAREN);
 * if $(LPAREN)warning_level > G_MEMORY_MONITOR_WARNING_LEVEL_LOW$(RPAREN)
 * drop_caches $(LPAREN)$(RPAREN);
 * }
 * static GMemoryMonitor *
 * monitor_low_memory $(LPAREN)void$(RPAREN)
 * {
 * GMemoryMonitor *m;
 * m \= g_memory_monitor_dup_default $(LPAREN)$(RPAREN);
 * g_signal_connect $(LPAREN)G_OBJECT $(LPAREN)m$(RPAREN), "low-memory-warning",
 * G_CALLBACK $(LPAREN)warning_cb$(RPAREN), NULL$(RPAREN);
 * return m;
 * }
 * ```
 * Don’t forget to disconnect the signal@Gio.MemoryMonitor::low-memory-warning
 * signal, and unref the `GMemoryMonitor` itself when exiting.
 */
struct GMemoryMonitor;

/**
 * The virtual function table for #GMemoryMonitor.
 */
struct GMemoryMonitorInterface
{
  /**
   * The parent interface.
   */
  GTypeInterface gIface;

  /**
   * the virtual function pointer for the
   * #GMemoryMonitor::low-memory-warning signal.
   */
  extern(C) void function(GMemoryMonitor* monitor, GMemoryMonitorWarningLevel level) lowMemoryWarning;
}

/**
 * `GMemoryOutputStream` is a class for using arbitrary
 * memory chunks as output for GIO streaming output operations.
 * As of GLib 2.34, `GMemoryOutputStream` trivially implements
 * [Gio.PollableOutputStream]: it always polls as ready.
 */
struct GMemoryOutputStream
{
  GOutputStream parentInstance;

  GMemoryOutputStreamPrivate* priv;
}

struct GMemoryOutputStreamClass
{
  GOutputStreamClass parentClass;

  extern(C) void function() GReserved1;

  extern(C) void function() GReserved2;

  extern(C) void function() GReserved3;

  extern(C) void function() GReserved4;

  extern(C) void function() GReserved5;
}

struct GMemoryOutputStreamPrivate;

/**
 * `GMenu` is a simple implementation of [Gio.MenuModel].
 * You populate a `GMenu` by adding [Gio.MenuItem] instances to it.
 * There are some convenience functions to allow you to directly
 * add items $(LPAREN)avoiding [Gio.MenuItem]$(RPAREN) for the common cases. To add
 * a regular item, use [Gio.Menu.insert]. To add a section, use
 * [Gio.Menu.insertSection]. To add a submenu, use
 * [Gio.Menu.insertSubmenu].
 */
struct GMenu;

/**
 * #GMenuAttributeIter is an opaque structure type.  You must access it
 * using the functions below.
 */
struct GMenuAttributeIter
{
  ObjectC parentInstance;

  GMenuAttributeIterPrivate* priv;
}

struct GMenuAttributeIterClass
{
  GObjectClass parentClass;

  extern(C) bool function(GMenuAttributeIter* iter, const(char*)* outName, VariantC** value) getNext;
}

struct GMenuAttributeIterPrivate;

/**
 * #GMenuItem is an opaque structure type.  You must access it using the
 * functions below.
 */
struct GMenuItem;

/**
 * #GMenuLinkIter is an opaque structure type.  You must access it using
 * the functions below.
 */
struct GMenuLinkIter
{
  ObjectC parentInstance;

  GMenuLinkIterPrivate* priv;
}

struct GMenuLinkIterClass
{
  GObjectClass parentClass;

  extern(C) bool function(GMenuLinkIter* iter, const(char*)* outLink, GMenuModel** value) getNext;
}

struct GMenuLinkIterPrivate;

/**
 * `GMenuModel` represents the contents of a menu — an ordered list of
 * menu items. The items are associated with actions, which can be
 * activated through them. Items can be grouped in sections, and may
 * have submenus associated with them. Both items and sections usually
 * have some representation data, such as labels or icons. The type of
 * the associated action $(LPAREN)ie whether it is stateful, and what kind of
 * state it has$(RPAREN) can influence the representation of the item.
 * The conceptual model of menus in `GMenuModel` is hierarchical:
 * sections and submenus are again represented by `GMenuModel`s.
 * Menus themselves do not define their own roles. Rather, the role
 * of a particular `GMenuModel` is defined by the item that references
 * it $(LPAREN)or, in the case of the ‘root’ menu, is defined by the context
 * in which it is used$(RPAREN).
 * As an example, consider the visible portions of this menu:
 * ## An example menu
 * ![](menu-example.png)
 * There are 8 ‘menus’ visible in the screenshot: one menubar, two
 * submenus and 5 sections:
 * - the toplevel menubar $(LPAREN)containing 4 items$(RPAREN)
 * - the View submenu $(LPAREN)containing 3 sections$(RPAREN)
 * - the first section of the View submenu $(LPAREN)containing 2 items$(RPAREN)
 * - the second section of the View submenu $(LPAREN)containing 1 item$(RPAREN)
 * - the final section of the View submenu $(LPAREN)containing 1 item$(RPAREN)
 * - the Highlight Mode submenu $(LPAREN)containing 2 sections$(RPAREN)
 * - the Sources section $(LPAREN)containing 2 items$(RPAREN)
 * - the Markup section $(LPAREN)containing 2 items$(RPAREN)
 * The [example](#a-menu-example) illustrates the conceptual connection between
 * these 8 menus. Each large block in the figure represents a menu and the
 * smaller blocks within the large block represent items in that menu. Some
 * items contain references to other menus.
 * ## A menu example
 * ![](menu-model.png)
 * Notice that the separators visible in the [example](#an-example-menu)
 * appear nowhere in the [menu model](#a-menu-example). This is because
 * separators are not explicitly represented in the menu model. Instead,
 * a separator is inserted between any two non-empty sections of a menu.
 * Section items can have labels just like any other item. In that case,
 * a display system may show a section header instead of a separator.
 * The motivation for this abstract model of application controls is
 * that modern user interfaces tend to make these controls available
 * outside the application. Examples include global menus, jumplists,
 * dash boards, etc. To support such uses, it is necessary to ‘export’
 * information about actions and their representation in menus, which
 * is exactly what the action group exporter and the menu model exporter do for
 * [Gio.ActionGroup] and [Gio.MenuModel]. The client-side
 * counterparts to make use of the exported information are
 * [Gio.DBusActionGroup] and [Gio.DBusMenuModel].
 * The API of `GMenuModel` is very generic, with iterators for the
 * attributes and links of an item, see
 * [Gio.MenuModel.iterateItemAttributes] and
 * [Gio.MenuModel.iterateItemLinks]. The ‘standard’ attributes and
 * link types have predefined names: `G_MENU_ATTRIBUTE_LABEL`,
 * `G_MENU_ATTRIBUTE_ACTION`, `G_MENU_ATTRIBUTE_TARGET`, `G_MENU_LINK_SECTION`
 * and `G_MENU_LINK_SUBMENU`.
 * Items in a `GMenuModel` represent active controls if they refer to
 * an action that can get activated when the user interacts with the
 * menu item. The reference to the action is encoded by the string ID
 * in the `G_MENU_ATTRIBUTE_ACTION` attribute. An action ID uniquely
 * identifies an action in an action group. Which action group$(LPAREN)s$(RPAREN) provide
 * actions depends on the context in which the menu model is used.
 * E.g. when the model is exported as the application menu of a
 * [`GtkApplication`](https://docs.gtk.org/gtk4/class.Application.html),
 * actions can be application-wide or window-specific $(LPAREN)and thus come from
 * two different action groups$(RPAREN). By convention, the application-wide actions
 * have names that start with `app.`, while the names of window-specific
 * actions start with `win.`.
 * While a wide variety of stateful actions is possible, the following
 * is the minimum that is expected to be supported by all users of exported
 * menu information:
 * - an action with no parameter type and no state
 * - an action with no parameter type and boolean state
 * - an action with string parameter type and string state
 * ## Stateless
 * A stateless action typically corresponds to an ordinary menu item.
 * Selecting such a menu item will activate the action $(LPAREN)with no parameter$(RPAREN).
 * ## Boolean State
 * An action with a boolean state will most typically be used with a ‘toggle’
 * or ‘switch’ menu item. The state can be set directly, but activating the
 * action $(LPAREN)with no parameter$(RPAREN) results in the state being toggled.
 * Selecting a toggle menu item will activate the action. The menu item should
 * be rendered as ‘checked’ when the state is true.
 * ## String Parameter and State
 * Actions with string parameters and state will most typically be used to
 * represent an enumerated choice over the items available for a group of
 * radio menu items. Activating the action with a string parameter is
 * equivalent to setting that parameter as the state.
 * Radio menu items, in addition to being associated with the action, will
 * have a target value. Selecting that menu item will result in activation
 * of the action with the target value as the parameter. The menu item should
 * be rendered as ‘selected’ when the state of the action is equal to the
 * target value of the menu item.
 */
struct GMenuModel
{
  ObjectC parentInstance;

  GMenuModelPrivate* priv;
}

struct GMenuModelClass
{
  GObjectClass parentClass;

  extern(C) bool function(GMenuModel* model) isMutable;

  extern(C) int function(GMenuModel* model) getNItems;

  extern(C) void function(GMenuModel* model, int itemIndex, GHashTable** attributes) getItemAttributes;

  extern(C) GMenuAttributeIter* function(GMenuModel* model, int itemIndex) iterateItemAttributes;

  extern(C) VariantC* function(GMenuModel* model, int itemIndex, const(char)* attribute, const(GVariantType)* expectedType) getItemAttributeValue;

  extern(C) void function(GMenuModel* model, int itemIndex, GHashTable** links) getItemLinks;

  extern(C) GMenuLinkIter* function(GMenuModel* model, int itemIndex) iterateItemLinks;

  extern(C) GMenuModel* function(GMenuModel* model, int itemIndex, const(char)* link) getItemLink;
}

struct GMenuModelPrivate;

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
struct GMount;

/**
 * Interface for implementing operations for mounts.
 */
struct GMountIface
{
  /**
   * The parent interface.
   */
  GTypeInterface gIface;

  /**
   * Changed signal that is emitted when the mount's state has changed.
   */
  extern(C) void function(GMount* mount) changed;

  /**
   * The unmounted signal that is emitted when the #GMount have been unmounted. If the recipient is holding references to the object they should release them so the object can be finalized.
   */
  extern(C) void function(GMount* mount) unmounted;

  /**
   * Gets a #GFile to the root directory of the #GMount.
   */
  extern(C) GFile* function(GMount* mount) getRoot;

  /**
   * Gets a string containing the name of the #GMount.
   */
  extern(C) char* function(GMount* mount) getName;

  /**
   * Gets a #GIcon for the #GMount.
   */
  extern(C) GIcon* function(GMount* mount) getIcon;

  /**
   * Gets the UUID for the #GMount. The reference is typically based on the file system UUID for the mount in question and should be considered an opaque string. Returns %NULL if there is no UUID available.
   */
  extern(C) char* function(GMount* mount) getUuid;

  /**
   * Gets a #GVolume the mount is located on. Returns %NULL if the #GMount is not associated with a #GVolume.
   */
  extern(C) GVolume* function(GMount* mount) getVolume;

  /**
   * Gets a #GDrive the volume of the mount is located on. Returns %NULL if the #GMount is not associated with a #GDrive or a #GVolume. This is convenience method for getting the #GVolume and using that to get the #GDrive.
   */
  extern(C) GDrive* function(GMount* mount) getDrive;

  /**
   * Checks if a #GMount can be unmounted.
   */
  extern(C) bool function(GMount* mount) canUnmount;

  /**
   * Checks if a #GMount can be ejected.
   */
  extern(C) bool function(GMount* mount) canEject;

  /**
   * Starts unmounting a #GMount.
   */
  extern(C) void function(GMount* mount, GMountUnmountFlags flags, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) unmount;

  /**
   * Finishes an unmounting operation.
   */
  extern(C) bool function(GMount* mount, GAsyncResult* result, GError** _err) unmountFinish;

  /**
   * Starts ejecting a #GMount.
   */
  extern(C) void function(GMount* mount, GMountUnmountFlags flags, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) eject;

  /**
   * Finishes an eject operation.
   */
  extern(C) bool function(GMount* mount, GAsyncResult* result, GError** _err) ejectFinish;

  /**
   * Starts remounting a #GMount.
   */
  extern(C) void function(GMount* mount, GMountMountFlags flags, GMountOperation* mountOperation, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) remount;

  /**
   * Finishes a remounting operation.
   */
  extern(C) bool function(GMount* mount, GAsyncResult* result, GError** _err) remountFinish;

  /**
   * Starts guessing the type of the content of a #GMount.
   * See [Gio.Mount.guessContentType] for more information on content
   * type guessing. This operation was added in 2.18.
   */
  extern(C) void function(GMount* mount, bool forceRescan, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) guessContentType;

  /**
   * Finishes a content type guessing operation. Added in 2.18.
   */
  extern(C) char** function(GMount* mount, GAsyncResult* result, GError** _err) guessContentTypeFinish;

  /**
   * Synchronous variant of @guess_content_type. Added in 2.18
   */
  extern(C) char** function(GMount* mount, bool forceRescan, GCancellable* cancellable, GError** _err) guessContentTypeSync;

  /**
   * The ::pre-unmount signal that is emitted when the #GMount will soon be emitted. If the recipient is somehow holding the mount open by keeping an open file on it it should close the file.
   */
  extern(C) void function(GMount* mount) preUnmount;

  /**
   * Starts unmounting a #GMount using a #GMountOperation. Since 2.22.
   */
  extern(C) void function(GMount* mount, GMountUnmountFlags flags, GMountOperation* mountOperation, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) unmountWithOperation;

  /**
   * Finishes an unmounting operation using a #GMountOperation. Since 2.22.
   */
  extern(C) bool function(GMount* mount, GAsyncResult* result, GError** _err) unmountWithOperationFinish;

  /**
   * Starts ejecting a #GMount using a #GMountOperation. Since 2.22.
   */
  extern(C) void function(GMount* mount, GMountUnmountFlags flags, GMountOperation* mountOperation, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) ejectWithOperation;

  /**
   * Finishes an eject operation using a #GMountOperation. Since 2.22.
   */
  extern(C) bool function(GMount* mount, GAsyncResult* result, GError** _err) ejectWithOperationFinish;

  /**
   * Gets a #GFile indication a start location that can be use as the entry point for this mount. Since 2.24.
   */
  extern(C) GFile* function(GMount* mount) getDefaultLocation;

  /**
   * Gets a key used for sorting #GMount instance or %NULL if no such key exists. Since 2.32.
   */
  extern(C) const(char)* function(GMount* mount) getSortKey;

  /**
   * Gets a symbolic #GIcon for the #GMount. Since 2.34.
   */
  extern(C) GIcon* function(GMount* mount) getSymbolicIcon;
}

/**
 * `GMountOperation` provides a mechanism for interacting with the user.
 * It can be used for authenticating mountable operations, such as loop
 * mounting files, hard drive partitions or server locations. It can
 * also be used to ask the user questions or show a list of applications
 * preventing unmount or eject operations from completing.
 * Note that `GMountOperation` is used for more than just [Gio.Mount]
 * objects – for example it is also used in [Gio.Drive.start] and
 * [Gio.Drive.stop].
 * Users should instantiate a subclass of this that implements all the
 * various callbacks to show the required dialogs, such as
 * [`GtkMountOperation`](https://docs.gtk.org/gtk4/class.MountOperation.html).
 * If no user interaction is desired $(LPAREN)for example when automounting
 * filesystems at login time$(RPAREN), usually `NULL` can be passed, see each method
 * taking a `GMountOperation` for details.
 * Throughout the API, the term ‘TCRYPT’ is used to mean ‘compatible with TrueCrypt and VeraCrypt’.
 * [TrueCrypt](https://en.wikipedia.org/wiki/TrueCrypt) is a discontinued system for
 * encrypting file containers, partitions or whole disks, typically used with Windows.
 * [VeraCrypt](https://www.veracrypt.fr/) is a maintained fork of TrueCrypt with various
 * improvements and auditing fixes.
 */
struct GMountOperation
{
  ObjectC parentInstance;

  GMountOperationPrivate* priv;
}

struct GMountOperationClass
{
  GObjectClass parentClass;

  extern(C) void function(GMountOperation* op, const(char)* message, const(char)* defaultUser, const(char)* defaultDomain, GAskPasswordFlags flags) askPassword;

  extern(C) void function(GMountOperation* op, const(char)* message, const(char*)* choices) askQuestion;

  extern(C) void function(GMountOperation* op, GMountOperationResult result) reply;

  extern(C) void function(GMountOperation* op) aborted;

  extern(C) void function(GMountOperation* op, const(char)* message, GArray* processes, const(char*)* choices) showProcesses;

  extern(C) void function(GMountOperation* op, const(char)* message, long timeLeft, long bytesLeft) showUnmountProgress;

  extern(C) void function() GReserved1;

  extern(C) void function() GReserved2;

  extern(C) void function() GReserved3;

  extern(C) void function() GReserved4;

  extern(C) void function() GReserved5;

  extern(C) void function() GReserved6;

  extern(C) void function() GReserved7;

  extern(C) void function() GReserved8;

  extern(C) void function() GReserved9;
}

struct GMountOperationPrivate;

/**
 * A socket address of some unknown native type.
 * This corresponds to a general `struct sockaddr` of a type not otherwise
 * handled by GLib.
 */
struct GNativeSocketAddress
{
  GSocketAddress parentInstance;

  GNativeSocketAddressPrivate* priv;
}

struct GNativeSocketAddressClass
{
  GSocketAddressClass parentClass;
}

struct GNativeSocketAddressPrivate;

struct GNativeVolumeMonitor
{
  GVolumeMonitor parentInstance;
}

struct GNativeVolumeMonitorClass
{
  GVolumeMonitorClass parentClass;

  extern(C) GMount* function(const(char)* mountPath, GCancellable* cancellable) getMountForMountPath;
}

/**
 * `GNetworkAddress` provides an easy way to resolve a hostname and
 * then attempt to connect to that host, handling the possibility of
 * multiple IP addresses and multiple address families.
 * The enumeration results of resolved addresses *may* be cached as long
 * as this object is kept alive which may have unexpected results if
 * alive for too long.
 * See [Gio.SocketConnectable] for an example of using the connectable
 * interface.
 */
struct GNetworkAddress
{
  ObjectC parentInstance;

  GNetworkAddressPrivate* priv;
}

struct GNetworkAddressClass
{
  GObjectClass parentClass;
}

struct GNetworkAddressPrivate;

/**
 * `GNetworkMonitor` provides an easy-to-use cross-platform API
 * for monitoring network connectivity. On Linux, the available
 * implementations are based on the kernel's netlink interface and
 * on NetworkManager.
 * There is also an implementation for use inside Flatpak sandboxes.
 */
struct GNetworkMonitor;

/**
 * The virtual function table for #GNetworkMonitor.
 */
struct GNetworkMonitorInterface
{
  /**
   * The parent interface.
   */
  GTypeInterface gIface;

  /**
   * the virtual function pointer for the
   * GNetworkMonitor::network-changed signal.
   */
  extern(C) void function(GNetworkMonitor* monitor, bool networkAvailable) networkChanged;

  /**
   * the virtual function pointer for [Gio.NetworkMonitor.canReach]
   */
  extern(C) bool function(GNetworkMonitor* monitor, GSocketConnectable* connectable, GCancellable* cancellable, GError** _err) canReach;

  /**
   * the virtual function pointer for
   * [Gio.NetworkMonitor.canReachAsync]
   */
  extern(C) void function(GNetworkMonitor* monitor, GSocketConnectable* connectable, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) canReachAsync;

  /**
   * the virtual function pointer for
   * [Gio.NetworkMonitor.canReachFinish]
   */
  extern(C) bool function(GNetworkMonitor* monitor, GAsyncResult* result, GError** _err) canReachFinish;
}

/**
 * Like [Gio.NetworkAddress] does with hostnames, `GNetworkService`
 * provides an easy way to resolve a SRV record, and then attempt to
 * connect to one of the hosts that implements that service, handling
 * service priority/weighting, multiple IP addresses, and multiple
 * address families.
 * See [Gio.SrvTarget] for more information about SRV records, and see
 * [Gio.SocketConnectable] for an example of using the connectable
 * interface.
 */
struct GNetworkService
{
  ObjectC parentInstance;

  GNetworkServicePrivate* priv;
}

struct GNetworkServiceClass
{
  GObjectClass parentClass;
}

struct GNetworkServicePrivate;

/**
 * `GNotification` is a mechanism for creating a notification to be shown
 * to the user — typically as a pop-up notification presented by the
 * desktop environment shell.
 * The key difference between `GNotification` and other similar APIs is
 * that, if supported by the desktop environment, notifications sent
 * with `GNotification` will persist after the application has exited,
 * and even across system reboots.
 * Since the user may click on a notification while the application is
 * not running, applications using `GNotification` should be able to be
 * started as a D-Bus service, using [Gio.Application].
 * In order for `GNotification` to work, the application must have installed
 * a `.desktop` file. For example:
 * ```
 * [Desktop Entry]
 * Name\=Test Application
 * Comment\=Description of what Test Application does
 * Exec\=gnome-test-application
 * Icon\=org.gnome.TestApplication
 * Terminal\=false
 * Type\=Application
 * Categories\=GNOME;GTK;TestApplication Category;
 * StartupNotify\=true
 * DBusActivatable\=true
 * X-GNOME-UsesNotifications\=true
 * ```
 * The `X-GNOME-UsesNotifications` key indicates to GNOME Control Center
 * that this application uses notifications, so it can be listed in the
 * Control Center’s ‘Notifications’ panel.
 * The `.desktop` file must be named as `org.gnome.TestApplication.desktop`,
 * where `org.gnome.TestApplication` is the ID passed to
 * [Gio.Application.new_].
 * User interaction with a notification $(LPAREN)either the default action, or
 * buttons$(RPAREN) must be associated with actions on the application $(LPAREN)ie:
 * `app.` actions$(RPAREN).  It is not possible to route user interaction
 * through the notification itself, because the object will not exist if
 * the application is autostarted as a result of a notification being
 * clicked.
 * A notification can be sent with [Gio.Application.sendNotification].
 */
struct GNotification;

/**
 * Structure used for scatter/gather data output when sending multiple
 * messages or packets in one go. You generally pass in an array of
 * #GOutputVectors and the operation will use all the buffers as if they
 * were one buffer.
 * If @address is %NULL then the message is sent to the default receiver
 * $(LPAREN)as previously set by [Gio.Socket.connect]$(RPAREN).
 */
struct GOutputMessage
{
  /**
   * a #GSocketAddress, or %NULL
   */
  GSocketAddress* address;

  /**
   * pointer to an array of output vectors
   */
  GOutputVector* vectors;

  /**
   * the number of output vectors pointed to by @vectors.
   */
  uint numVectors;

  /**
   * initialize to 0. Will be set to the number of bytes
   * that have been sent
   */
  uint bytesSent;

  /**
   * a pointer
   * to an array of #GSocketControlMessages, or %NULL.
   */
  GSocketControlMessage** controlMessages;

  /**
   * number of elements in @control_messages.
   */
  uint numControlMessages;
}

/**
 * `GOutputStream` is a base class for implementing streaming output.
 * It has functions to write to a stream $(LPAREN)[Gio.OutputStream.write]$(RPAREN),
 * to close a stream $(LPAREN)[Gio.OutputStream.close]$(RPAREN) and to flush pending
 * writes $(LPAREN)[Gio.OutputStream.flush]$(RPAREN).
 * To copy the content of an input stream to an output stream without
 * manually handling the reads and writes, use [Gio.OutputStream.splice].
 * See the documentation for [Gio.IOStream] for details of thread safety
 * of streaming APIs.
 * All of these functions have async variants too.
 * All classes derived from `GOutputStream` *should* implement synchronous
 * writing, splicing, flushing and closing streams, but *may* implement
 * asynchronous versions.
 */
struct GOutputStream
{
  ObjectC parentInstance;

  GOutputStreamPrivate* priv;
}

struct GOutputStreamClass
{
  GObjectClass parentClass;

  extern(C) ptrdiff_t function(GOutputStream* stream, void* buffer, size_t count, GCancellable* cancellable, GError** _err) writeFn;

  extern(C) ptrdiff_t function(GOutputStream* stream, GInputStream* source, GOutputStreamSpliceFlags flags, GCancellable* cancellable, GError** _err) splice;

  extern(C) bool function(GOutputStream* stream, GCancellable* cancellable, GError** _err) flush;

  extern(C) bool function(GOutputStream* stream, GCancellable* cancellable, GError** _err) closeFn;

  extern(C) void function(GOutputStream* stream, void* buffer, size_t count, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) writeAsync;

  extern(C) ptrdiff_t function(GOutputStream* stream, GAsyncResult* result, GError** _err) writeFinish;

  extern(C) void function(GOutputStream* stream, GInputStream* source, GOutputStreamSpliceFlags flags, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) spliceAsync;

  extern(C) ptrdiff_t function(GOutputStream* stream, GAsyncResult* result, GError** _err) spliceFinish;

  extern(C) void function(GOutputStream* stream, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) flushAsync;

  extern(C) bool function(GOutputStream* stream, GAsyncResult* result, GError** _err) flushFinish;

  extern(C) void function(GOutputStream* stream, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) closeAsync;

  extern(C) bool function(GOutputStream* stream, GAsyncResult* result, GError** _err) closeFinish;

  extern(C) bool function(GOutputStream* stream, const(GOutputVector)* vectors, size_t nVectors, size_t* bytesWritten, GCancellable* cancellable, GError** _err) writevFn;

  extern(C) void function(GOutputStream* stream, const(GOutputVector)* vectors, size_t nVectors, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) writevAsync;

  extern(C) bool function(GOutputStream* stream, GAsyncResult* result, size_t* bytesWritten, GError** _err) writevFinish;

  extern(C) void function() GReserved4;

  extern(C) void function() GReserved5;

  extern(C) void function() GReserved6;

  extern(C) void function() GReserved7;

  extern(C) void function() GReserved8;
}

struct GOutputStreamPrivate;

/**
 * Structure used for scatter/gather data output.
 * You generally pass in an array of #GOutputVectors
 * and the operation will use all the buffers as if they were
 * one buffer.
 */
struct GOutputVector
{
  /**
   * Pointer to a buffer of data to read.
   */
  const(void)* buffer;

  /**
   * the size of @buffer.
   */
  size_t size;
}

/**
 * A `GPermission` represents the status of the caller’s permission to
 * perform a certain action.
 * You can query if the action is currently allowed and if it is
 * possible to acquire the permission so that the action will be allowed
 * in the future.
 * There is also an API to actually acquire the permission and one to
 * release it.
 * As an example, a `GPermission` might represent the ability for the
 * user to write to a [Gio.Settings] object.  This `GPermission` object
 * could then be used to decide if it is appropriate to show a “Click here to
 * unlock” button in a dialog and to provide the mechanism to invoke
 * when that button is clicked.
 */
struct GPermission
{
  ObjectC parentInstance;

  GPermissionPrivate* priv;
}

struct GPermissionClass
{
  GObjectClass parentClass;

  extern(C) bool function(GPermission* permission, GCancellable* cancellable, GError** _err) acquire;

  extern(C) void function(GPermission* permission, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) acquireAsync;

  extern(C) bool function(GPermission* permission, GAsyncResult* result, GError** _err) acquireFinish;

  extern(C) bool function(GPermission* permission, GCancellable* cancellable, GError** _err) release;

  extern(C) void function(GPermission* permission, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) releaseAsync;

  extern(C) bool function(GPermission* permission, GAsyncResult* result, GError** _err) releaseFinish;

  void*[16] reserved;
}

struct GPermissionPrivate;

/**
 * `GPollableInputStream` is implemented by [Gio.InputStream]s that
 * can be polled for readiness to read. This can be used when
 * interfacing with a non-GIO API that expects
 * UNIX-file-descriptor-style asynchronous I/O rather than GIO-style.
 * Some classes may implement `GPollableInputStream` but have only certain
 * instances of that class be pollable. If [Gio.PollableInputStream.canPoll]
 * returns false, then the behavior of other `GPollableInputStream` methods is
 * undefined.
 */
struct GPollableInputStream;

/**
 * The interface for pollable input streams.
 * The default implementation of @can_poll always returns %TRUE.
 * The default implementation of @read_nonblocking calls
 * [Gio.PollableInputStream.isReadable], and then calls
 * [Gio.InputStream.read] if it returns %TRUE. This means you only need
 * to override it if it is possible that your @is_readable
 * implementation may return %TRUE when the stream is not actually
 * readable.
 */
struct GPollableInputStreamInterface
{
  /**
   * The parent interface.
   */
  GTypeInterface gIface;

  /**
   * Checks if the #GPollableInputStream instance is actually pollable
   */
  extern(C) bool function(GPollableInputStream* stream) canPoll;

  /**
   * Checks if the stream is readable
   */
  extern(C) bool function(GPollableInputStream* stream) isReadable;

  /**
   * Creates a #GSource to poll the stream
   */
  extern(C) GSource* function(GPollableInputStream* stream, GCancellable* cancellable) createSource;

  /**
   * Does a non-blocking read or returns
   * %G_IO_ERROR_WOULD_BLOCK
   */
  extern(C) ptrdiff_t function(GPollableInputStream* stream, void* buffer, size_t count, GError** _err) readNonblocking;
}

/**
 * `GPollableOutputStream` is implemented by [Gio.OutputStream]s that
 * can be polled for readiness to write. This can be used when
 * interfacing with a non-GIO API that expects
 * UNIX-file-descriptor-style asynchronous I/O rather than GIO-style.
 * Some classes may implement `GPollableOutputStream` but have only certain
 * instances of that class be pollable. If [Gio.PollableOutputStream.canPoll]
 * returns false, then the behavior of other `GPollableOutputStream` methods is
 * undefined.
 */
struct GPollableOutputStream;

/**
 * The interface for pollable output streams.
 * The default implementation of @can_poll always returns %TRUE.
 * The default implementation of @write_nonblocking calls
 * [Gio.PollableOutputStream.isWritable], and then calls
 * [Gio.OutputStream.write] if it returns %TRUE. This means you only
 * need to override it if it is possible that your @is_writable
 * implementation may return %TRUE when the stream is not actually
 * writable.
 * The default implementation of @writev_nonblocking calls
 * [Gio.PollableOutputStream.writeNonblocking] for each vector, and converts
 * its return value and error $(LPAREN)if set$(RPAREN) to a #GPollableReturn. You should
 * override this where possible to avoid having to allocate a #GError to return
 * %G_IO_ERROR_WOULD_BLOCK.
 */
struct GPollableOutputStreamInterface
{
  /**
   * The parent interface.
   */
  GTypeInterface gIface;

  /**
   * Checks if the #GPollableOutputStream instance is actually pollable
   */
  extern(C) bool function(GPollableOutputStream* stream) canPoll;

  /**
   * Checks if the stream is writable
   */
  extern(C) bool function(GPollableOutputStream* stream) isWritable;

  /**
   * Creates a #GSource to poll the stream
   */
  extern(C) GSource* function(GPollableOutputStream* stream, GCancellable* cancellable) createSource;

  /**
   * Does a non-blocking write or returns
   * %G_IO_ERROR_WOULD_BLOCK
   */
  extern(C) ptrdiff_t function(GPollableOutputStream* stream, void* buffer, size_t count, GError** _err) writeNonblocking;

  /**
   * Does a vectored non-blocking write, or returns
   * %G_POLLABLE_RETURN_WOULD_BLOCK
   */
  extern(C) GPollableReturn function(GPollableOutputStream* stream, const(GOutputVector)* vectors, size_t nVectors, size_t* bytesWritten, GError** _err) writevNonblocking;
}

/**
 * `GPowerProfileMonitor` makes it possible for applications as well as OS
 * components to monitor system power profiles and act upon them. It currently
 * only exports whether the system is in “Power Saver” mode $(LPAREN)known as
 * “Low Power” mode on some systems$(RPAREN).
 * When in “Low Power” mode, it is recommended that applications:
 * - disable automatic downloads;
 * - reduce the rate of refresh from online sources such as calendar or
 * email synchronisation;
 * - reduce the use of expensive visual effects.
 * It is also likely that OS components providing services to applications will
 * lower their own background activity, for the sake of the system.
 * There are a variety of tools that exist for power consumption analysis, but those
 * usually depend on the OS and hardware used. On Linux, one could use `upower` to
 * monitor the battery discharge rate, `powertop` to check on the background activity
 * or activity at all$(RPAREN), `sysprof` to inspect CPU usage, and `intel_gpu_time` to
 * profile GPU usage.
 * Don’t forget to disconnect the [GObject.ObjectG.notify] signal for
 * property@Gio.PowerProfileMonitor:power-saver-enabled, and unref the
 * `GPowerProfileMonitor` itself when exiting.
 */
struct GPowerProfileMonitor;

/**
 * The virtual function table for #GPowerProfileMonitor.
 */
struct GPowerProfileMonitorInterface
{
  /**
   * The parent interface.
   */
  GTypeInterface gIface;
}

/**
 * A `GPropertyAction` is a way to get a [Gio.Action] with a state value
 * reflecting and controlling the value of a [GObject.ObjectG] property.
 * The state of the action will correspond to the value of the property.
 * Changing it will change the property $(LPAREN)assuming the requested value
 * matches the requirements as specified in the [GObject.ParamSpec]$(RPAREN).
 * Only the most common types are presently supported.  Booleans are
 * mapped to booleans, strings to strings, signed/unsigned integers to
 * int32/uint32 and floats and doubles to doubles.
 * If the property is an enum then the state will be string-typed and
 * conversion will automatically be performed between the enum value and
 * ‘nick’ string as per the [GObject.EnumValue] table.
 * Flags types are not currently supported.
 * Properties of object types, boxed types and pointer types are not
 * supported and probably never will be.
 * Properties of [GLib.VariantG] types are not currently supported.
 * If the property is boolean-valued then the action will have a `NULL`
 * parameter type, and activating the action $(LPAREN)with no parameter$(RPAREN) will
 * toggle the value of the property.
 * In all other cases, the parameter type will correspond to the type of
 * the property.
 * The general idea here is to reduce the number of locations where a
 * particular piece of state is kept $(LPAREN)and therefore has to be synchronised
 * between$(RPAREN). `GPropertyAction` does not have a separate state that is kept
 * in sync with the property value — its state is the property value.
 * For example, it might be useful to create a [Gio.Action] corresponding
 * to the `visible-child-name` property of a [`GtkStack`](https://docs.gtk.org/gtk4/class.Stack.html)
 * so that the current page can be switched from a menu.  The active radio
 * indication in the menu is then directly determined from the active page of
 * the `GtkStack`.
 * An anti-example would be binding the `active-id` property on a
 * [`GtkComboBox`](https://docs.gtk.org/gtk4/class.ComboBox.html). This is
 * because the state of the combo box itself is probably uninteresting and is
 * actually being used to control something else.
 * Another anti-example would be to bind to the `visible-child-name`
 * property of a [`GtkStack`](https://docs.gtk.org/gtk4/class.Stack.html) if
 * this value is actually stored in [Gio.Settings].  In that case, the
 * real source of the value is* [Gio.Settings].  If you want
 * a [Gio.Action] to control a setting stored in [Gio.Settings],
 * see [Gio.Settings.createAction] instead, and possibly combine its
 * use with [Gio.Settings.bind].
 */
struct GPropertyAction;

/**
 * A `GProxy` handles connecting to a remote host via a given type of
 * proxy server. It is implemented by the `gio-proxy` extension point.
 * The extensions are named after their proxy protocol name. As an
 * example, a SOCKS5 proxy implementation can be retrieved with the
 * name `socks5` using the function
 * [Gio.IOExtensionPoint.getExtensionByName].
 */
struct GProxy;

/**
 * A [Gio.InetSocketAddress] representing a connection via a proxy server.
 */
struct GProxyAddress
{
  GInetSocketAddress parentInstance;

  GProxyAddressPrivate* priv;
}

/**
 * Class structure for #GProxyAddress.
 */
struct GProxyAddressClass
{
  GInetSocketAddressClass parentClass;
}

/**
 * `GProxyAddressEnumerator` is a wrapper around
 * [Gio.SocketAddressEnumerator] which takes the [Gio.SocketAddress]
 * instances returned by the [Gio.SocketAddressEnumerator]
 * and wraps them in [Gio.ProxyAddress] instances, using the given
 * property@Gio.ProxyAddressEnumerator:proxy-resolver.
 * This enumerator will be returned $(LPAREN)for example, by
 * [Gio.SocketConnectable.enumerate]$(RPAREN) as appropriate when a proxy is
 * configured; there should be no need to manually wrap a
 * [Gio.SocketAddressEnumerator] instance with one.
 */
struct GProxyAddressEnumerator
{
  GSocketAddressEnumerator parentInstance;

  GProxyAddressEnumeratorPrivate* priv;
}

/**
 * Class structure for #GProxyAddressEnumerator.
 */
struct GProxyAddressEnumeratorClass
{
  GSocketAddressEnumeratorClass parentClass;

  extern(C) void function() GReserved1;

  extern(C) void function() GReserved2;

  extern(C) void function() GReserved3;

  extern(C) void function() GReserved4;

  extern(C) void function() GReserved5;

  extern(C) void function() GReserved6;

  extern(C) void function() GReserved7;
}

struct GProxyAddressEnumeratorPrivate;

struct GProxyAddressPrivate;

/**
 * Provides an interface for handling proxy connection and payload.
 */
struct GProxyInterface
{
  /**
   * The parent interface.
   */
  GTypeInterface gIface;

  /**
   * Connect to proxy server and wrap $(LPAREN)if required$(RPAREN) the #connection
   * to handle payload.
   */
  extern(C) GIOStream* function(GProxy* proxy, GIOStream* connection, GProxyAddress* proxyAddress, GCancellable* cancellable, GError** _err) connect;

  /**
   * Same as connect$(LPAREN)$(RPAREN) but asynchronous.
   */
  extern(C) void function(GProxy* proxy, GIOStream* connection, GProxyAddress* proxyAddress, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) connectAsync;

  /**
   * Returns the result of connect_async$(LPAREN)$(RPAREN)
   */
  extern(C) GIOStream* function(GProxy* proxy, GAsyncResult* result, GError** _err) connectFinish;

  /**
   * Returns whether the proxy supports hostname lookups.
   */
  extern(C) bool function(GProxy* proxy) supportsHostname;
}

/**
 * `GProxyResolver` provides synchronous and asynchronous network proxy
 * resolution. `GProxyResolver` is used within [Gio.SocketClient] through
 * the method [Gio.SocketConnectable.proxyEnumerate].
 * Implementations of `GProxyResolver` based on
 * [libproxy](https://github.com/libproxy/libproxy) and GNOME settings can be
 * found in [glib-networking](https://gitlab.gnome.org/GNOME/glib-networking).
 * GIO comes with an implementation for use inside Flatpak portals.
 */
struct GProxyResolver;

/**
 * The virtual function table for #GProxyResolver.
 */
struct GProxyResolverInterface
{
  /**
   * The parent interface.
   */
  GTypeInterface gIface;

  /**
   * the virtual function pointer for [Gio.ProxyResolver.isSupported]
   */
  extern(C) bool function(GProxyResolver* resolver) isSupported;

  /**
   * the virtual function pointer for [Gio.ProxyResolver.lookup]
   */
  extern(C) char** function(GProxyResolver* resolver, const(char)* uri, GCancellable* cancellable, GError** _err) lookup;

  /**
   * the virtual function pointer for
   * [Gio.ProxyResolver.lookupAsync]
   */
  extern(C) void function(GProxyResolver* resolver, const(char)* uri, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) lookupAsync;

  /**
   * the virtual function pointer for
   * [Gio.ProxyResolver.lookupFinish]
   */
  extern(C) char** function(GProxyResolver* resolver, GAsyncResult* result, GError** _err) lookupFinish;
}

/**
 * The `GRemoteActionGroup` interface is implemented by [Gio.ActionGroup]
 * instances that either transmit action invocations to other processes
 * or receive action invocations in the local process from other
 * processes.
 * The interface has `_full` variants of the two
 * methods on [Gio.ActionGroup] used to activate actions:
 * [Gio.ActionGroup.activateAction] and
 * [Gio.ActionGroup.changeActionState]. These variants allow a
 * ‘platform data’ [GLib.VariantG] to be specified: a dictionary providing
 * context for the action invocation $(LPAREN)for example: timestamps, startup
 * notification IDs, etc$(RPAREN).
 * [Gio.DBusActionGroup] implements `GRemoteActionGroup`.  This provides a
 * mechanism to send platform data for action invocations over D-Bus.
 * Additionally, [Gio.DBusConnection.exportActionGroup] will check if
 * the exported [Gio.ActionGroup] implements `GRemoteActionGroup` and use
 * the `_full` variants of the calls if available.  This
 * provides a mechanism by which to receive platform data for action
 * invocations that arrive by way of D-Bus.
 */
struct GRemoteActionGroup;

/**
 * The virtual function table for #GRemoteActionGroup.
 */
struct GRemoteActionGroupInterface
{
  GTypeInterface gIface;

  /**
   * the virtual function pointer for [Gio.RemoteActionGroup.activateActionFull]
   */
  extern(C) void function(GRemoteActionGroup* remote, const(char)* actionName, VariantC* parameter, VariantC* platformData) activateActionFull;

  /**
   * the virtual function pointer for [Gio.RemoteActionGroup.changeActionStateFull]
   */
  extern(C) void function(GRemoteActionGroup* remote, const(char)* actionName, VariantC* value, VariantC* platformData) changeActionStateFull;
}

/**
 * The object that handles DNS resolution. Use [Gio.Resolver.getDefault]
 * to get the default resolver.
 * `GResolver` provides cancellable synchronous and asynchronous DNS
 * resolution, for hostnames $(LPAREN)[Gio.Resolver.lookupByAddress],
 * [Gio.Resolver.lookupByName] and their async variants$(RPAREN) and SRV
 * $(LPAREN)service$(RPAREN) records $(LPAREN)[Gio.Resolver.lookupService]$(RPAREN).
 * [Gio.NetworkAddress] and [Gio.NetworkService] provide wrappers
 * around `GResolver` functionality that also implement
 * [Gio.SocketConnectable], making it easy to connect to a remote
 * host/service.
 * The default resolver $(LPAREN)see [Gio.Resolver.getDefault]$(RPAREN) has a timeout of
 * 30s set on it since GLib 2.78. Earlier versions of GLib did not support
 * resolver timeouts.
 * This is an abstract type; subclasses of it implement different resolvers for
 * different platforms and situations.
 */
struct GResolver
{
  ObjectC parentInstance;

  GResolverPrivate* priv;
}

struct GResolverClass
{
  GObjectClass parentClass;

  extern(C) void function(GResolver* resolver) reload;

  extern(C) GList* function(GResolver* resolver, const(char)* hostname, GCancellable* cancellable, GError** _err) lookupByName;

  extern(C) void function(GResolver* resolver, const(char)* hostname, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) lookupByNameAsync;

  extern(C) GList* function(GResolver* resolver, GAsyncResult* result, GError** _err) lookupByNameFinish;

  extern(C) char* function(GResolver* resolver, GInetAddress* address, GCancellable* cancellable, GError** _err) lookupByAddress;

  extern(C) void function(GResolver* resolver, GInetAddress* address, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) lookupByAddressAsync;

  extern(C) char* function(GResolver* resolver, GAsyncResult* result, GError** _err) lookupByAddressFinish;

  extern(C) GList* function(GResolver* resolver, const(char)* rrname, GCancellable* cancellable, GError** _err) lookupService;

  extern(C) void function(GResolver* resolver, const(char)* rrname, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) lookupServiceAsync;

  extern(C) GList* function(GResolver* resolver, GAsyncResult* result, GError** _err) lookupServiceFinish;

  extern(C) GList* function(GResolver* resolver, const(char)* rrname, GResolverRecordType recordType, GCancellable* cancellable, GError** _err) lookupRecords;

  extern(C) void function(GResolver* resolver, const(char)* rrname, GResolverRecordType recordType, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) lookupRecordsAsync;

  extern(C) GList* function(GResolver* resolver, GAsyncResult* result, GError** _err) lookupRecordsFinish;

  extern(C) void function(GResolver* resolver, const(char)* hostname, GResolverNameLookupFlags flags, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) lookupByNameWithFlagsAsync;

  extern(C) GList* function(GResolver* resolver, GAsyncResult* result, GError** _err) lookupByNameWithFlagsFinish;

  extern(C) GList* function(GResolver* resolver, const(char)* hostname, GResolverNameLookupFlags flags, GCancellable* cancellable, GError** _err) lookupByNameWithFlags;
}

struct GResolverPrivate;

/**
 * Applications and libraries often contain binary or textual data that is
 * really part of the application, rather than user data. For instance
 * [`GtkBuilder`](https://docs.gtk.org/gtk4/class.Builder.html) `.ui` files,
 * splashscreen images, [Gio.Menu] markup XML, CSS files, icons, etc.
 * These are often shipped as files in `\$datadir/appname`, or manually
 * included as literal strings in the code.
 * The `GResource` API and the
 * [`glib-compile-resources`](glib-compile-resources.html) program provide a
 * convenient and efficient alternative to this which has some nice properties.
 * You maintain the files as normal files, so it’s easy to edit them, but during
 * the build the files are combined into a binary bundle that is linked into the
 * executable. This means that loading the resource files are efficient $(LPAREN)as they
 * are already in memory, shared with other instances$(RPAREN) and simple $(LPAREN)no need to
 * check for things like I/O errors or locate the files in the filesystem$(RPAREN). It
 * also makes it easier to create relocatable applications.
 * Resource files can also be marked as compressed. Such files will be included
 * in the resource bundle in a compressed form, but will be automatically
 * uncompressed when the resource is used. This is very useful e.g. for larger
 * text files that are parsed once $(LPAREN)or rarely$(RPAREN) and then thrown away.
 * Resource files can also be marked to be preprocessed, by setting the value of the
 * `preprocess` attribute to a comma-separated list of preprocessing options.
 * The only options currently supported are:
 * - `xml-stripblanks` which will use the [`xmllint`]$(LPAREN)$(RPAREN)(man:xmllint1) command
 * to strip ignorable whitespace from the XML file. For this to work,
 * the `XMLLINT` environment variable must be set to the full path to
 * the xmllint executable, or xmllint must be in the `PATH`; otherwise
 * the preprocessing step is skipped.
 * - `to-pixdata` $(LPAREN)deprecated since gdk-pixbuf 2.32$(RPAREN) which will use the
 * `gdk-pixbuf-pixdata` command to convert images to the [`GdkPixdata`](https://docs.gtk.org/gdk-pixbuf/class.Pixdata.html)
 * format, which allows you to create pixbufs directly using the data inside
 * the resource file, rather than an $(LPAREN)uncompressed$(RPAREN) copy of it. For this, the
 * `gdk-pixbuf-pixdata` program must be in the `PATH`, or the
 * `GDK_PIXBUF_PIXDATA` environment variable must be set to the full path to
 * the `gdk-pixbuf-pixdata` executable; otherwise the resource compiler will
 * abort. `to-pixdata` has been deprecated since gdk-pixbuf 2.32, as
 * `GResource` supports embedding modern image formats just as well. Instead
 * of using it, embed a PNG or SVG file in your `GResource`.
 * - `json-stripblanks` which will use the
 * [`json-glib-format`]$(LPAREN)$(RPAREN)(man:json-glib-format1) command to strip ignorable
 * whitespace from the JSON file. For this to work, the `JSON_GLIB_FORMAT`
 * environment variable must be set to the full path to the
 * `json-glib-format` executable, or it must be in the `PATH`; otherwise the
 * preprocessing step is skipped. In addition, at least version 1.6 of
 * `json-glib-format` is required.
 * Resource files will be exported in the `GResource` namespace using the
 * combination of the given `prefix` and the filename from the `file` element.
 * The `alias` attribute can be used to alter the filename to expose them at a
 * different location in the resource namespace. Typically, this is used to
 * include files from a different source directory without exposing the source
 * directory in the resource namespace, as in the example below.
 * Resource bundles are created by the
 * [`glib-compile-resources`](glib-compile-resources.html) program
 * which takes an XML file that describes the bundle, and a set of files that
 * the XML references. These are combined into a binary resource bundle.
 * An example resource description:
 * ```xml
 * <?xml version\="1.0" encoding\="UTF-8"?>
 * <gresources>
 * <gresource prefix\="/org/gtk/Example">
 * <file>data/splashscreen.png</file>
 * <file compressed\="true">dialog.ui</file>
 * <file preprocess\="xml-stripblanks">menumarkup.xml</file>
 * <file alias\="example.css">data/example.css</file>
 * </gresource>
 * </gresources>
 * ```
 * This will create a resource bundle with the following files:
 * ```
 * /org/gtk/Example/data/splashscreen.png
 * /org/gtk/Example/dialog.ui
 * /org/gtk/Example/menumarkup.xml
 * /org/gtk/Example/example.css
 * ```
 * Note that all resources in the process share the same namespace, so use
 * Java-style path prefixes $(LPAREN)like in the above example$(RPAREN) to avoid conflicts.
 * You can then use [`glib-compile-resources`](glib-compile-resources.html) to
 * compile the XML to a binary bundle that you can load with
 * [Gio.Resource.load]. However, it’s more common to use the
 * `--generate-source` and `--generate-header` arguments to create a source file
 * and header to link directly into your application.
 * This will generate `get_resource$(LPAREN)$(RPAREN)`, `register_resource$(LPAREN)$(RPAREN)` and
 * `unregister_resource$(LPAREN)$(RPAREN)` functions, prefixed by the `--c-name` argument passed
 * to [`glib-compile-resources`](glib-compile-resources.html). `get_resource$(LPAREN)$(RPAREN)`
 * returns the generated `GResource` object. The register and unregister
 * functions register the resource so its files can be accessed using
 * func@Gio.resources_lookup_data.
 * Once a `GResource` has been created and registered all the data in it can be
 * accessed globally in the process by using API calls like
 * func@Gio.resources_open_stream to stream the data or
 * func@Gio.resources_lookup_data to get a direct pointer to the data. You can
 * also use URIs like `resource:///org/gtk/Example/data/splashscreen.png` with
 * [Gio.File] to access the resource data.
 * Some higher-level APIs, such as [`GtkApplication`](https://docs.gtk.org/gtk4/class.Application.html),
 * will automatically load resources from certain well-known paths in the
 * resource namespace as a convenience. See the documentation for those APIs
 * for details.
 * There are two forms of the generated source, the default version uses the
 * compiler support for constructor and destructor functions $(LPAREN)where available$(RPAREN)
 * to automatically create and register the `GResource` on startup or library
 * load time. If you pass `--manual-register`, two functions to
 * register/unregister the resource are created instead. This requires an
 * explicit initialization call in your application/library, but it works on all
 * platforms, even on the minor ones where constructors are not supported.
 * $(LPAREN)Constructor support is available for at least Win32, Mac OS and Linux.$(RPAREN)
 * Note that resource data can point directly into the data segment of e.g. a
 * library, so if you are unloading libraries during runtime you need to be very
 * careful with keeping around pointers to data from a resource, as this goes
 * away when the library is unloaded. However, in practice this is not generally
 * a problem, since most resource accesses are for your own resources, and
 * resource data is often used once, during parsing, and then released.
 * # Overlays
 * When debugging a program or testing a change to an installed version, it is
 * often useful to be able to replace resources in the program or library,
 * without recompiling, for debugging or quick hacking and testing purposes.
 * Since GLib 2.50, it is possible to use the `G_RESOURCE_OVERLAYS` environment
 * variable to selectively overlay resources with replacements from the
 * filesystem.  It is a `G_SEARCHPATH_SEPARATOR`-separated list of substitutions
 * to perform during resource lookups. It is ignored when running in a setuid
 * process.
 * A substitution has the form
 * ```
 * /org/gtk/libgtk\=/home/desrt/gtk-overlay
 * ```
 * The part before the `\=` is the resource subpath for which the overlay
 * applies.  The part after is a filesystem path which contains files and
 * subdirectories as you would like to be loaded as resources with the
 * equivalent names.
 * In the example above, if an application tried to load a resource with the
 * resource path `/org/gtk/libgtk/ui/gtkdialog.ui` then `GResource` would check
 * the filesystem path `/home/desrt/gtk-overlay/ui/gtkdialog.ui`.  If a file was
 * found there, it would be used instead.  This is an overlay, not an outright
 * replacement, which means that if a file is not found at that path, the
 * built-in version will be used instead.  Whiteouts are not currently
 * supported.
 * Substitutions must start with a slash, and must not contain a trailing slash
 * before the `\=`.  The path after the slash should ideally be absolute, but
 * this is not strictly required.  It is possible to overlay the location of a
 * single resource with an individual file.
 */
struct GResource;

/**
 * `GSeekable` is implemented by streams $(LPAREN)implementations of
 * [Gio.InputStream] or [Gio.OutputStream]$(RPAREN) that support seeking.
 * Seekable streams largely fall into two categories: resizable and
 * fixed-size.
 * `GSeekable` on fixed-sized streams is approximately the same as POSIX
 * [`lseek$(LPAREN)$(RPAREN)`]$(LPAREN)$(RPAREN)(man:lseek2) on a block device $(LPAREN)for example: attempting to seek
 * past the end of the device is an error$(RPAREN).  Fixed streams typically cannot be
 * truncated.
 * `GSeekable` on resizable streams is approximately the same as POSIX
 * [`lseek$(LPAREN)$(RPAREN)`]$(LPAREN)$(RPAREN)(man:lseek2) on a normal file.  Seeking past the end and writing
 * data will usually cause the stream to resize by introducing zero bytes.
 */
struct GSeekable;

/**
 * Provides an interface for implementing seekable functionality on I/O Streams.
 */
struct GSeekableIface
{
  /**
   * The parent interface.
   */
  GTypeInterface gIface;

  /**
   * Tells the current location within a stream.
   */
  extern(C) long function(GSeekable* seekable) tell;

  /**
   * Checks if seeking is supported by the stream.
   */
  extern(C) bool function(GSeekable* seekable) canSeek;

  /**
   * Seeks to a location within a stream.
   */
  extern(C) bool function(GSeekable* seekable, long offset, GSeekType type, GCancellable* cancellable, GError** _err) seek;

  /**
   * Checks if truncation is supported by the stream.
   */
  extern(C) bool function(GSeekable* seekable) canTruncate;

  /**
   * Truncates a stream.
   */
  extern(C) bool function(GSeekable* seekable, long offset, GCancellable* cancellable, GError** _err) truncateFn;
}

/**
 * The `GSettings` class provides a convenient API for storing and retrieving
 * application settings.
 * Reads and writes can be considered to be non-blocking.  Reading
 * settings with `GSettings` is typically extremely fast: on
 * approximately the same order of magnitude $(LPAREN)but slower than$(RPAREN) a
 * [GLib.HashTable] lookup.  Writing settings is also extremely fast in
 * terms of time to return to your application, but can be extremely expensive
 * for other threads and other processes.  Many settings backends
 * $(LPAREN)including dconf$(RPAREN) have lazy initialisation which means in the common
 * case of the user using their computer without modifying any settings
 * a lot of work can be avoided.  For dconf, the D-Bus service doesn’t
 * even need to be started in this case.  For this reason, you should
 * only ever modify `GSettings` keys in response to explicit user action.
 * Particular care should be paid to ensure that modifications are not
 * made during startup — for example, when setting the initial value
 * of preferences widgets.  The built-in [Gio.Settings.bind]
 * functionality is careful not to write settings in response to notify signals
 * as a result of modifications that it makes to widgets.
 * When creating a `GSettings` instance, you have to specify a schema
 * that describes the keys in your settings and their types and default
 * values, as well as some other information.
 * Normally, a schema has a fixed path that determines where the settings
 * are stored in the conceptual global tree of settings. However, schemas
 * can also be ‘[relocatable](#relocatable-schemas)’, i.e. not equipped with
 * a fixed path. This is
 * useful e.g. when the schema describes an ‘account’, and you want to be
 * able to store a arbitrary number of accounts.
 * Paths must start with and end with a forward slash character $(LPAREN)`/`$(RPAREN)
 * and must not contain two sequential slash characters.  Paths should
 * be chosen based on a domain name associated with the program or
 * library to which the settings belong.  Examples of paths are
 * `/org/gtk/settings/file-chooser/` and `/ca/desrt/dconf-editor/`.
 * Paths should not start with `/apps/`, `/desktop/` or `/system/` as
 * they often did in GConf.
 * Unlike other configuration systems $(LPAREN)like GConf$(RPAREN), GSettings does not
 * restrict keys to basic types like strings and numbers. GSettings stores
 * values as [GLib.VariantG], and allows any [GLib.VariantType] for
 * keys. Key names are restricted to lowercase characters, numbers and `-`.
 * Furthermore, the names must begin with a lowercase character, must not end
 * with a `-`, and must not contain consecutive dashes.
 * Similar to GConf, the default values in GSettings schemas can be
 * localized, but the localized values are stored in gettext catalogs
 * and looked up with the domain that is specified in the
 * `gettext-domain` attribute of the `<schemalist>` or `<schema>`
 * elements and the category that is specified in the `l10n` attribute of
 * the `<default>` element. The string which is translated includes all text in
 * the `<default>` element, including any surrounding quotation marks.
 * The `l10n` attribute must be set to `messages` or `time`, and sets the
 * [locale category for
 * translation]$(LPAREN)https://www.gnu.org/software/gettext/manual/html_node/Aspects.html#index-locale-categories-1$(RPAREN).
 * The `messages` category should be used by default; use `time` for
 * translatable date or time formats. A translation comment can be added as an
 * XML comment immediately above the `<default>` element — it is recommended to
 * add these comments to aid translators understand the meaning and
 * implications of the default value. An optional translation `context`
 * attribute can be set on the `<default>` element to disambiguate multiple
 * defaults which use the same string.
 * For example:
 * ```xml
 * <!-- Translators: A list of words which are not allowed to be typed, in
 * GVariant serialization syntax.
 * See: https://developer.gnome.org/glib/stable/gvariant-text.html -->
 * <default l10n\='messages' context\='Banned words'>['bad', 'words']</default>
 * ```
 * Translations of default values must remain syntactically valid serialized
 * [GLib.VariantG]s (e.g. retaining any surrounding quotation marks) or
 * runtime errors will occur.
 * GSettings uses schemas in a compact binary form that is created
 * by the [`glib-compile-schemas`](glib-compile-schemas.html)
 * utility. The input is a schema description in an XML format.
 * A DTD for the gschema XML format can be found here:
 * [gschema.dtd](https://gitlab.gnome.org/GNOME/glib/-/blob/HEAD/gio/gschema.dtd)
 * The [`glib-compile-schemas`](glib-compile-schemas.html) tool expects schema
 * files to have the extension `.gschema.xml`.
 * At runtime, schemas are identified by their ID $(LPAREN)as specified in the
 * `id` attribute of the `<schema>` element$(RPAREN). The convention for schema
 * IDs is to use a dotted name, similar in style to a D-Bus bus name,
 * e.g. `org.gnome.SessionManager`. In particular, if the settings are
 * for a specific service that owns a D-Bus bus name, the D-Bus bus name
 * and schema ID should match. For schemas which deal with settings not
 * associated with one named application, the ID should not use
 * StudlyCaps, e.g. `org.gnome.font-rendering`.
 * In addition to [GLib.VariantG] types, keys can have types that have
 * enumerated types. These can be described by a `<choice>`,
 * `<enum>` or `<flags>` element, as seen in the
 * second example below. The underlying type of such a key
 * is string, but you can use [Gio.Settings.getEnum],
 * [Gio.Settings.setEnum], [Gio.Settings.getFlags],
 * [Gio.Settings.setFlags] access the numeric values corresponding to
 * the string value of enum and flags keys.
 * An example for default value:
 * ```xml
 * <schemalist>
 * <schema id\="org.gtk.Test" path\="/org/gtk/Test/" gettext-domain\="test">
 * <key name\="greeting" type\="s">
 * <default l10n\="messages">"Hello, earthlings"</default>
 * <summary>A greeting</summary>
 * <description>
 * Greeting of the invading martians
 * </description>
 * </key>
 * <key name\="box" type\="$(LPAREN)ii$(RPAREN)">
 * <default>$(LPAREN)20,30$(RPAREN)</default>
 * </key>
 * <key name\="empty-string" type\="s">
 * <default>""</default>
 * <summary>Empty strings have to be provided in GVariant form</summary>
 * </key>
 * </schema>
 * </schemalist>
 * ```
 * An example for ranges, choices and enumerated types:
 * ```xml
 * <schemalist>
 * <enum id\="org.gtk.Test.myenum">
 * <value nick\="first" value\="1"/>
 * <value nick\="second" value\="2"/>
 * </enum>
 * <flags id\="org.gtk.Test.myflags">
 * <value nick\="flag1" value\="1"/>
 * <value nick\="flag2" value\="2"/>
 * <value nick\="flag3" value\="4"/>
 * </flags>
 * <schema id\="org.gtk.Test">
 * <key name\="key-with-range" type\="i">
 * <range min\="1" max\="100"/>
 * <default>10</default>
 * </key>
 * <key name\="key-with-choices" type\="s">
 * <choices>
 * <choice value\='Elisabeth'/>
 * <choice value\='Annabeth'/>
 * <choice value\='Joe'/>
 * </choices>
 * <aliases>
 * <alias value\='Anna' target\='Annabeth'/>
 * <alias value\='Beth' target\='Elisabeth'/>
 * </aliases>
 * <default>'Joe'</default>
 * </key>
 * <key name\='enumerated-key' enum\='org.gtk.Test.myenum'>
 * <default>'first'</default>
 * </key>
 * <key name\='flags-key' flags\='org.gtk.Test.myflags'>
 * <default>["flag1","flag2"]</default>
 * </key>
 * </schema>
 * </schemalist>
 * ```
 * ## Vendor overrides
 * Default values are defined in the schemas that get installed by
 * an application. Sometimes, it is necessary for a vendor or distributor
 * to adjust these defaults. Since patching the XML source for the schema
 * is inconvenient and error-prone,
 * [`glib-compile-schemas`](glib-compile-schemas.html) reads so-called ‘vendor
 * override’ files. These are keyfiles in the same directory as the XML
 * schema sources which can override default values. The schema ID serves
 * as the group name in the key file, and the values are expected in
 * serialized [GLib.VariantG] form, as in the following example:
 * ```
 * [org.gtk.Example]
 * key1\='string'
 * key2\=1.5
 * ```
 * `glib-compile-schemas` expects schema files to have the extension
 * `.gschema.override`.
 * ## Binding
 * A very convenient feature of GSettings lets you bind [GObject.ObjectG]
 * properties directly to settings, using [Gio.Settings.bind]. Once a
 * [GObject.ObjectG] property has been bound to a setting, changes on
 * either side are automatically propagated to the other side. GSettings handles
 * details like mapping between [GObject.ObjectG] and [GLib.VariantG]
 * types, and preventing infinite cycles.
 * This makes it very easy to hook up a preferences dialog to the
 * underlying settings. To make this even more convenient, GSettings
 * looks for a boolean property with the name `sensitivity` and
 * automatically binds it to the writability of the bound setting.
 * If this ‘magic’ gets in the way, it can be suppressed with the
 * `G_SETTINGS_BIND_NO_SENSITIVITY` flag.
 * ## Relocatable schemas
 * A relocatable schema is one with no `path` attribute specified on its
 * `<schema>` element. By using [Gio.Settings.newWithPath], a `GSettings`
 * object can be instantiated for a relocatable schema, assigning a path to the
 * instance. Paths passed to [Gio.Settings.newWithPath] will typically be
 * constructed dynamically from a constant prefix plus some form of instance
 * identifier; but they must still be valid GSettings paths. Paths could also
 * be constant and used with a globally installed schema originating from a
 * dependency library.
 * For example, a relocatable schema could be used to store geometry information
 * for different windows in an application. If the schema ID was
 * `org.foo.MyApp.Window`, it could be instantiated for paths
 * `/org/foo/MyApp/main/`, `/org/foo/MyApp/document-1/`,
 * `/org/foo/MyApp/document-2/`, etc. If any of the paths are well-known
 * they can be specified as `<child>` elements in the parent schema, e.g.:
 * ```xml
 * <schema id\="org.foo.MyApp" path\="/org/foo/MyApp/">
 * <child name\="main" schema\="org.foo.MyApp.Window"/>
 * </schema>
 * ```
 * ## Build system integration
 * GSettings comes with autotools integration to simplify compiling and
 * installing schemas. To add GSettings support to an application, add the
 * following to your `configure.ac`:
 * ```
 * GLIB_GSETTINGS
 * ```
 * In the appropriate `Makefile.am`, use the following snippet to compile and
 * install the named schema:
 * ```
 * gsettings_SCHEMAS \= org.foo.MyApp.gschema.xml
 * EXTRA_DIST \= \$$(LPAREN)gsettings_SCHEMAS$(RPAREN)
 * @GSETTINGS_RULES@
 * ```
 * No changes are needed to the build system to mark a schema XML file for
 * translation. Assuming it sets the `gettext-domain` attribute, a schema may
 * be marked for translation by adding it to `POTFILES.in`, assuming gettext
 * 0.19 is in use $(LPAREN)the preferred method for translation$(RPAREN):
 * ```
 * data/org.foo.MyApp.gschema.xml
 * ```
 * Alternatively, if intltool 0.50.1 is in use:
 * ```
 * [type: gettext/gsettings]data/org.foo.MyApp.gschema.xml
 * ```
 * GSettings will use gettext to look up translations for the `<summary>` and
 * `<description>` elements, and also any `<default>` elements which have a
 * `l10n` attribute set. Translations must not be included in the `.gschema.xml`
 * file by the build system, for example by using intltool XML rules with a
 * `.gschema.xml.in` template.
 * If an enumerated type defined in a C header file is to be used in a GSettings
 * schema, it can either be defined manually using an `<enum>` element in the
 * schema XML, or it can be extracted automatically from the C header. This
 * approach is preferred, as it ensures the two representations are always
 * synchronised. To do so, add the following to the relevant `Makefile.am`:
 * ```
 * gsettings_ENUM_NAMESPACE \= org.foo.MyApp
 * gsettings_ENUM_FILES \= my-app-enums.h my-app-misc.h
 * ```
 * `gsettings_ENUM_NAMESPACE` specifies the schema namespace for the enum files,
 * which are specified in `gsettings_ENUM_FILES`. This will generate a
 * `org.foo.MyApp.enums.xml` file containing the extracted enums, which will be
 * automatically included in the schema compilation, install and uninstall
 * rules. It should not be committed to version control or included in
 * `EXTRA_DIST`.
 */
struct GSettings
{
  ObjectC parentInstance;

  GSettingsPrivate* priv;
}

/**
 * The `GSettingsBackend` interface defines a generic interface for
 * non-strictly-typed data that is stored in a hierarchy. To implement
 * an alternative storage backend for [Gio.Settings], you need to
 * implement the `GSettingsBackend` interface and then make it implement the
 * extension point `G_SETTINGS_BACKEND_EXTENSION_POINT_NAME`.
 * The interface defines methods for reading and writing values, a
 * method for determining if writing of certain values will fail
 * $(LPAREN)lockdown$(RPAREN) and a change notification mechanism.
 * The semantics of the interface are very precisely defined and
 * implementations must carefully adhere to the expectations of
 * callers that are documented on each of the interface methods.
 * Some of the `GSettingsBackend` functions accept or return a
 * [GLib.Tree]. These trees always have strings as keys and
 * [GLib.VariantG] as values.
 * The `GSettingsBackend` API is exported to allow third-party
 * implementations, but does not carry the same stability guarantees
 * as the public GIO API. For this reason, you have to define the
 * C preprocessor symbol `G_SETTINGS_ENABLE_BACKEND` before including
 * `gio/gsettingsbackend.h`.
 */
struct GSettingsBackend
{
  ObjectC parentInstance;

  GSettingsBackendPrivate* priv;
}

/**
 * Class structure for #GSettingsBackend.
 */
struct GSettingsBackendClass
{
  GObjectClass parentClass;

  /**
   * virtual method to read a key's value
   */
  extern(C) VariantC* function(GSettingsBackend* backend, const(char)* key, const(GVariantType)* expectedType, bool defaultValue) read;

  /**
   * virtual method to get if a key is writable
   */
  extern(C) bool function(GSettingsBackend* backend, const(char)* key) getWritable;

  /**
   * virtual method to change key's value
   */
  extern(C) bool function(GSettingsBackend* backend, const(char)* key, VariantC* value, void* originTag) write;

  /**
   * virtual method to change a tree of keys
   */
  extern(C) bool function(GSettingsBackend* backend, GTree* tree, void* originTag) writeTree;

  /**
   * virtual method to reset state
   */
  extern(C) void function(GSettingsBackend* backend, const(char)* key, void* originTag) reset;

  /**
   * virtual method to subscribe to key changes
   */
  extern(C) void function(GSettingsBackend* backend, const(char)* name) subscribe;

  /**
   * virtual method to unsubscribe to key changes
   */
  extern(C) void function(GSettingsBackend* backend, const(char)* name) unsubscribe;

  /**
   * virtual method to sync state
   */
  extern(C) void function(GSettingsBackend* backend) sync;

  /**
   * virtual method to get permission of a key
   */
  extern(C) GPermission* function(GSettingsBackend* backend, const(char)* path) getPermission;

  /**
   * virtual method to read user's key value
   */
  extern(C) VariantC* function(GSettingsBackend* backend, const(char)* key, const(GVariantType)* expectedType) readUserValue;

  void*[23] padding;
}

struct GSettingsBackendPrivate;

struct GSettingsClass
{
  GObjectClass parentClass;

  extern(C) void function(GSettings* settings, const(char)* key) writableChanged;

  extern(C) void function(GSettings* settings, const(char)* key) changed;

  extern(C) bool function(GSettings* settings, GQuark key) writableChangeEvent;

  extern(C) bool function(GSettings* settings, const(GQuark)* keys, int nKeys) changeEvent;

  void*[20] padding;
}

struct GSettingsPrivate;

/**
 * The [Gio.SettingsSchemaSource] and `GSettingsSchema` APIs provide a
 * mechanism for advanced control over the loading of schemas and a
 * mechanism for introspecting their content.
 * Plugin loading systems that wish to provide plugins a way to access
 * settings face the problem of how to make the schemas for these
 * settings visible to GSettings.  Typically, a plugin will want to ship
 * the schema along with itself and it won't be installed into the
 * standard system directories for schemas.
 * [Gio.SettingsSchemaSource] provides a mechanism for dealing with this
 * by allowing the creation of a new ‘schema source’ from which schemas can
 * be acquired.  This schema source can then become part of the metadata
 * associated with the plugin and queried whenever the plugin requires
 * access to some settings.
 * Consider the following example:
 * ```c
 * typedef struct
 * {
 * …
 * GSettingsSchemaSource *schema_source;
 * …
 * } Plugin;
 * Plugin *
 * initialise_plugin $(LPAREN)const gchar *dir$(RPAREN)
 * {
 * Plugin *plugin;
 * …
 * plugin->schema_source \=
 * g_settings_schema_source_new_from_directory $(LPAREN)dir,
 * g_settings_schema_source_get_default $(LPAREN)$(RPAREN), FALSE, NULL$(RPAREN);
 * …
 * return plugin;
 * }
 * …
 * GSettings *
 * plugin_get_settings $(LPAREN)Plugin      *plugin,
 * const gchar *schema_id$(RPAREN)
 * {
 * GSettingsSchema *schema;
 * if $(LPAREN)schema_id \=\= NULL$(RPAREN)
 * schema_id \= plugin->identifier;
 * schema \= g_settings_schema_source_lookup $(LPAREN)plugin->schema_source,
 * schema_id, FALSE$(RPAREN);
 * if $(LPAREN)schema \=\= NULL$(RPAREN)
 * {
 * … disable the plugin or abort, etc …
 * }
 * return g_settings_new_full $(LPAREN)schema, NULL, NULL$(RPAREN);
 * }
 * ```
 * The code above shows how hooks should be added to the code that
 * initialises $(LPAREN)or enables$(RPAREN) the plugin to create the schema source and
 * how an API can be added to the plugin system to provide a convenient
 * way for the plugin to access its settings, using the schemas that it
 * ships.
 * From the standpoint of the plugin, it would need to ensure that it
 * ships a gschemas.compiled file as part of itself, and then simply do
 * the following:
 * ```c
 * {
 * GSettings *settings;
 * gint some_value;
 * settings \= plugin_get_settings $(LPAREN)self, NULL$(RPAREN);
 * some_value \= g_settings_get_int $(LPAREN)settings, "some-value"$(RPAREN);
 * …
 * }
 * ```
 * It's also possible that the plugin system expects the schema source
 * files $(LPAREN)ie: `.gschema.xml` files$(RPAREN) instead of a `gschemas.compiled` file.
 * In that case, the plugin loading system must compile the schemas for
 * itself before attempting to create the settings source.
 */
struct GSettingsSchema;

/**
 * #GSettingsSchemaKey is an opaque data structure and can only be accessed
 * using the following functions.
 */
struct GSettingsSchemaKey;

/**
 * This is an opaque structure type.  You may not access it directly.
 */
struct GSettingsSchemaSource;

/**
 * A `GSimpleAction` is the obvious simple implementation of the
 * [Gio.Action] interface. This is the easiest way to create an action for
 * purposes of adding it to a [Gio.SimpleActionGroup].
 */
struct GSimpleAction;

/**
 * `GSimpleActionGroup` is a hash table filled with [Gio.Action] objects,
 * implementing the [Gio.ActionGroup] and [Gio.ActionMap]
 * interfaces.
 */
struct GSimpleActionGroup
{
  ObjectC parentInstance;

  GSimpleActionGroupPrivate* priv;
}

struct GSimpleActionGroupClass
{
  GObjectClass parentClass;

  void*[12] padding;
}

struct GSimpleActionGroupPrivate;

/**
 * As of GLib 2.46, `GSimpleAsyncResult` is deprecated in favor of
 * [Gio.Task], which provides a simpler API.
 * `GSimpleAsyncResult` implements [Gio.AsyncResult].
 * `GSimpleAsyncResult` handles [Gio.AsyncReadyCallback]s, error
 * reporting, operation cancellation and the final state of an operation,
 * completely transparent to the application. Results can be returned
 * as a pointer e.g. for functions that return data that is collected
 * asynchronously, a boolean value for checking the success or failure
 * of an operation, or a `gssize` for operations which return the number
 * of bytes modified by the operation; all of the simple return cases
 * are covered.
 * Most of the time, an application will not need to know of the details
 * of this API; it is handled transparently, and any necessary operations
 * are handled by [Gio.AsyncResult]’s interface. However, if implementing
 * a new GIO module, for writing language bindings, or for complex
 * applications that need better control of how asynchronous operations
 * are completed, it is important to understand this functionality.
 * `GSimpleAsyncResult`s are tagged with the calling function to ensure
 * that asynchronous functions and their finishing functions are used
 * together correctly.
 * To create a new `GSimpleAsyncResult`, call [Gio.SimpleAsyncResult.new_].
 * If the result needs to be created for a `GError`, use
 * [Gio.SimpleAsyncResult.newFromError] or
 * [Gio.SimpleAsyncResult.newTakeError]. If a `GError` is not available
 * $(LPAREN)e.g. the asynchronous operation doesn’t take a `GError` argument$(RPAREN),
 * but the result still needs to be created for an error condition, use
 * [Gio.SimpleAsyncResult.newError] $(LPAREN)or
 * [Gio.SimpleAsyncResult.setErrorVa] if your application or binding
 * requires passing a variable argument list directly$(RPAREN), and the error can then
 * be propagated through the use of
 * [Gio.SimpleAsyncResult.propagateError].
 * An asynchronous operation can be made to ignore a cancellation event by
 * calling [Gio.SimpleAsyncResult.setHandleCancellation] with a
 * `GSimpleAsyncResult` for the operation and `FALSE`. This is useful for
 * operations that are dangerous to cancel, such as close $(LPAREN)which would
 * cause a leak if cancelled before being run$(RPAREN).
 * `GSimpleAsyncResult` can integrate into GLib’s event loop,
 * [GLib.MainLoop], or it can use [GLib.Thread]s.
 * [Gio.SimpleAsyncResult.complete] will finish an I/O task directly
 * from the point where it is called.
 * [Gio.SimpleAsyncResult.completeInIdle] will finish it from an idle
 * handler in the  thread-default main context $(LPAREN)see
 * [GLib.MainContext.pushThreadDefault]$(RPAREN) where the `GSimpleAsyncResult`
 * was created. [Gio.SimpleAsyncResult.runInThread] will run the job in
 * a separate thread and then use
 * [Gio.SimpleAsyncResult.completeInIdle] to deliver the result.
 * To set the results of an asynchronous function,
 * [Gio.SimpleAsyncResult.setOpResGpointer],
 * [Gio.SimpleAsyncResult.setOpResGboolean], and
 * [Gio.SimpleAsyncResult.setOpResGssize]
 * are provided, setting the operation's result to a `gpointer`, `gboolean`, or
 * `gssize`, respectively.
 * Likewise, to get the result of an asynchronous function,
 * [Gio.SimpleAsyncResult.getOpResGpointer],
 * [Gio.SimpleAsyncResult.getOpResGboolean], and
 * [Gio.SimpleAsyncResult.getOpResGssize] are
 * provided, getting the operation’s result as a `gpointer`, `gboolean`, and
 * `gssize`, respectively.
 * For the details of the requirements implementations must respect, see
 * [Gio.AsyncResult].  A typical implementation of an asynchronous
 * operation using `GSimpleAsyncResult` looks something like this:
 * ```c
 * static void
 * baked_cb $(LPAREN)Cake    *cake,
 * gpointer user_data$(RPAREN)
 * {
 * // In this example, this callback is not given a reference to the cake,
 * // so the GSimpleAsyncResult has to take a reference to it.
 * GSimpleAsyncResult *result \= user_data;
 * if $(LPAREN)cake \=\= NULL$(RPAREN)
 * g_simple_async_result_set_error $(LPAREN)result,
 * BAKER_ERRORS,
 * BAKER_ERROR_NO_FLOUR,
 * "Go to the supermarket"$(RPAREN);
 * else
 * g_simple_async_result_set_op_res_gpointer $(LPAREN)result,
 * g_object_ref $(LPAREN)cake$(RPAREN),
 * g_object_unref$(RPAREN);
 * // In this example, we assume that baked_cb is called as a callback from
 * // the mainloop, so it's safe to complete the operation synchronously here.
 * // If, however, _baker_prepare_cake $(LPAREN)$(RPAREN) might call its callback without
 * // first returning to the mainloop — inadvisable, but some APIs do so —
 * // we would need to use [Gio.SimpleAsyncResult.completeInIdle].
 * g_simple_async_result_complete $(LPAREN)result$(RPAREN);
 * g_object_unref $(LPAREN)result$(RPAREN);
 * }
 * void
 * baker_bake_cake_async $(LPAREN)Baker              *self,
 * guint               radius,
 * GAsyncReadyCallback callback,
 * gpointer            user_data$(RPAREN)
 * {
 * GSimpleAsyncResult *simple;
 * Cake               *cake;
 * if $(LPAREN)radius < 3$(RPAREN)
 * {
 * g_simple_async_report_error_in_idle $(LPAREN)G_OBJECT $(LPAREN)self$(RPAREN),
 * callback,
 * user_data,
 * BAKER_ERRORS,
 * BAKER_ERROR_TOO_SMALL,
 * "%ucm radius cakes are silly",
 * radius$(RPAREN);
 * return;
 * }
 * simple \= g_simple_async_result_new $(LPAREN)G_OBJECT $(LPAREN)self$(RPAREN),
 * callback,
 * user_data,
 * baker_bake_cake_async$(RPAREN);
 * cake \= _baker_get_cached_cake $(LPAREN)self, radius$(RPAREN);
 * if $(LPAREN)cake !\= NULL$(RPAREN)
 * {
 * g_simple_async_result_set_op_res_gpointer $(LPAREN)simple,
 * g_object_ref $(LPAREN)cake$(RPAREN),
 * g_object_unref$(RPAREN);
 * g_simple_async_result_complete_in_idle $(LPAREN)simple$(RPAREN);
 * g_object_unref $(LPAREN)simple$(RPAREN);
 * // Drop the reference returned by _baker_get_cached_cake$(LPAREN)$(RPAREN);
 * // the GSimpleAsyncResult has taken its own reference.
 * g_object_unref $(LPAREN)cake$(RPAREN);
 * return;
 * }
 * _baker_prepare_cake $(LPAREN)self, radius, baked_cb, simple$(RPAREN);
 * }
 * Cake *
 * baker_bake_cake_finish $(LPAREN)Baker        *self,
 * GAsyncResult *result,
 * GError      **error$(RPAREN)
 * {
 * GSimpleAsyncResult *simple;
 * Cake               *cake;
 * g_return_val_if_fail $(LPAREN)g_simple_async_result_is_valid $(LPAREN)result,
 * G_OBJECT $(LPAREN)self$(RPAREN),
 * baker_bake_cake_async$(RPAREN),
 * NULL$(RPAREN);
 * simple \= $(LPAREN)GSimpleAsyncResult *$(RPAREN) result;
 * if $(LPAREN)g_simple_async_result_propagate_error $(LPAREN)simple, error$(RPAREN)$(RPAREN)
 * return NULL;
 * cake \= CAKE $(LPAREN)g_simple_async_result_get_op_res_gpointer $(LPAREN)simple$(RPAREN)$(RPAREN);
 * return g_object_ref $(LPAREN)cake$(RPAREN);
 * }
 * ```
 */
struct GSimpleAsyncResult;

struct GSimpleAsyncResultClass;

/**
 * `GSimpleIOStream` creates a [Gio.IOStream] from an arbitrary
 * [Gio.InputStream] and [Gio.OutputStream]. This allows any pair of
 * input and output streams to be used with [Gio.IOStream] methods.
 * This is useful when you obtained a [Gio.InputStream] and a
 * [Gio.OutputStream] by other means, for instance creating them with
 * platform specific methods as
 * [`[Gio.UnixInputStream.new_]`](../gio-unix/ctor.UnixInputStream.new.html)
 * $(LPAREN)from `gio-unix-2.0.pc` / `GioUnix-2.0`$(RPAREN), and you want to
 * take advantage of the methods provided by [Gio.IOStream].
 */
struct GSimpleIOStream;

/**
 * `GSimplePermission` is a trivial implementation of [Gio.Permission]
 * that represents a permission that is either always or never allowed.  The
 * value is given at construction and doesn’t change.
 * Calling [Gio.Permission.acquire] or [Gio.Permission.release]
 * on a `GSimplePermission` will result in errors.
 */
struct GSimplePermission;

/**
 * `GSimpleProxyResolver` is a simple [Gio.ProxyResolver] implementation
 * that handles a single default proxy, multiple URI-scheme-specific
 * proxies, and a list of hosts that proxies should not be used for.
 * `GSimpleProxyResolver` is never the default proxy resolver, but it
 * can be used as the base class for another proxy resolver
 * implementation, or it can be created and used manually, such as
 * with [Gio.SocketClient.setProxyResolver].
 */
struct GSimpleProxyResolver
{
  ObjectC parentInstance;

  GSimpleProxyResolverPrivate* priv;
}

struct GSimpleProxyResolverClass
{
  GObjectClass parentClass;

  extern(C) void function() GReserved1;

  extern(C) void function() GReserved2;

  extern(C) void function() GReserved3;

  extern(C) void function() GReserved4;

  extern(C) void function() GReserved5;
}

struct GSimpleProxyResolverPrivate;

/**
 * A `GSocket` is a low-level networking primitive. It is a more or less
 * direct mapping of the BSD socket API in a portable GObject based API.
 * It supports both the UNIX socket implementations and winsock2 on Windows.
 * `GSocket` is the platform independent base upon which the higher level
 * network primitives are based. Applications are not typically meant to
 * use it directly, but rather through classes like [Gio.SocketClient],
 * [Gio.SocketService] and [Gio.SocketConnection]. However there may
 * be cases where direct use of `GSocket` is useful.
 * `GSocket` implements the [Gio.Initable] interface, so if it is manually
 * constructed by e.g. [GObject.ObjectG.new_] you must call
 * [Gio.Initable.init_] and check the results before using the object.
 * This is done automatically in [Gio.Socket.new_] and
 * [Gio.Socket.newFromFd], so these functions can return `NULL`.
 * Sockets operate in two general modes, blocking or non-blocking. When
 * in blocking mode all operations $(LPAREN)which don’t take an explicit blocking
 * parameter$(RPAREN) block until the requested operation
 * is finished or there is an error. In non-blocking mode all calls that
 * would block return immediately with a `G_IO_ERROR_WOULD_BLOCK` error.
 * To know when a call would successfully run you can call
 * [Gio.Socket.conditionCheck], or [Gio.Socket.conditionWait].
 * You can also use [Gio.Socket.createSource] and attach it to a
 * [GLib.MainContext] to get callbacks when I/O is possible.
 * Note that all sockets are always set to non blocking mode in the system, and
 * blocking mode is emulated in `GSocket`.
 * When working in non-blocking mode applications should always be able to
 * handle getting a `G_IO_ERROR_WOULD_BLOCK` error even when some other
 * function said that I/O was possible. This can easily happen in case
 * of a race condition in the application, but it can also happen for other
 * reasons. For instance, on Windows a socket is always seen as writable
 * until a write returns `G_IO_ERROR_WOULD_BLOCK`.
 * `GSocket`s can be either connection oriented or datagram based.
 * For connection oriented types you must first establish a connection by
 * either connecting to an address or accepting a connection from another
 * address. For connectionless socket types the target/source address is
 * specified or received in each I/O operation.
 * All socket file descriptors are set to be close-on-exec.
 * Note that creating a `GSocket` causes the signal `SIGPIPE` to be
 * ignored for the remainder of the program. If you are writing a
 * command-line utility that uses `GSocket`, you may need to take into
 * account the fact that your program will not automatically be killed
 * if it tries to write to `stdout` after it has been closed.
 * Like most other APIs in GLib, `GSocket` is not inherently thread safe. To use
 * a `GSocket` concurrently from multiple threads, you must implement your own
 * locking.
 * ## Nagle’s algorithm
 * Since GLib 2.80, `GSocket` will automatically set the `TCP_NODELAY` option on
 * all `G_SOCKET_TYPE_STREAM` sockets. This disables
 * [Nagle’s algorithm](https://en.wikipedia.org/wiki/Nagle%27s_algorithm) as it
 * typically does more harm than good on modern networks.
 * If your application needs Nagle’s algorithm enabled, call
 * [Gio.Socket.setOption] after constructing a `GSocket` to enable it:
 * ```c
 * socket \= g_socket_new $(LPAREN)…, G_SOCKET_TYPE_STREAM, …$(RPAREN);
 * if $(LPAREN)socket !\= NULL$(RPAREN)
 * {
 * g_socket_set_option $(LPAREN)socket, IPPROTO_TCP, TCP_NODELAY, FALSE, &local_error$(RPAREN);
 * // handle error if needed
 * }
 * ```
 */
struct GSocket
{
  ObjectC parentInstance;

  GSocketPrivate* priv;
}

/**
 * `GSocketAddress` is the equivalent of
 * [`struct sockaddr`]$(LPAREN)$(RPAREN)(man:sockaddr3type) and its subtypes in the BSD sockets
 * API. This is an abstract class; use [Gio.InetSocketAddress] for
 * internet sockets, or [Gio.UnixSocketAddress] for UNIX domain sockets.
 */
struct GSocketAddress
{
  ObjectC parentInstance;
}

struct GSocketAddressClass
{
  GObjectClass parentClass;

  extern(C) GSocketFamily function(GSocketAddress* address) getFamily;

  extern(C) ptrdiff_t function(GSocketAddress* address) getNativeSize;

  extern(C) bool function(GSocketAddress* address, void* dest, size_t destlen, GError** _err) toNative;
}

/**
 * `GSocketAddressEnumerator` is an enumerator type for
 * [Gio.SocketAddress] instances. It is returned by enumeration functions
 * such as [Gio.SocketConnectable.enumerate], which returns a
 * `GSocketAddressEnumerator` to list each [Gio.SocketAddress] which could
 * be used to connect to that [Gio.SocketConnectable].
 * Enumeration is typically a blocking operation, so the asynchronous methods
 * [Gio.SocketAddressEnumerator.nextAsync] and
 * [Gio.SocketAddressEnumerator.nextFinish] should be used where
 * possible.
 * Each `GSocketAddressEnumerator` can only be enumerated once. Once
 * [Gio.SocketAddressEnumerator.next] has returned `NULL`, further
 * enumeration with that `GSocketAddressEnumerator` is not possible, and it can
 * be unreffed.
 */
struct GSocketAddressEnumerator
{
  ObjectC parentInstance;
}

/**
 * Class structure for #GSocketAddressEnumerator.
 */
struct GSocketAddressEnumeratorClass
{
  GObjectClass parentClass;

  /**
   * Virtual method for [Gio.SocketAddressEnumerator.next].
   */
  extern(C) GSocketAddress* function(GSocketAddressEnumerator* enumerator, GCancellable* cancellable, GError** _err) next;

  /**
   * Virtual method for [Gio.SocketAddressEnumerator.nextAsync].
   */
  extern(C) void function(GSocketAddressEnumerator* enumerator, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) nextAsync;

  /**
   * Virtual method for [Gio.SocketAddressEnumerator.nextFinish].
   */
  extern(C) GSocketAddress* function(GSocketAddressEnumerator* enumerator, GAsyncResult* result, GError** _err) nextFinish;
}

struct GSocketClass
{
  GObjectClass parentClass;

  extern(C) void function() GReserved1;

  extern(C) void function() GReserved2;

  extern(C) void function() GReserved3;

  extern(C) void function() GReserved4;

  extern(C) void function() GReserved5;

  extern(C) void function() GReserved6;

  extern(C) void function() GReserved7;

  extern(C) void function() GReserved8;

  extern(C) void function() GReserved9;

  extern(C) void function() GReserved10;
}

/**
 * `GSocketClient` is a lightweight high-level utility class for connecting to
 * a network host using a connection oriented socket type.
 * You create a `GSocketClient` object, set any options you want, and then
 * call a sync or async connect operation, which returns a
 * [Gio.SocketConnection] subclass on success.
 * The type of the [Gio.SocketConnection] object returned depends on the
 * type of the underlying socket that is in use. For instance, for a TCP/IP
 * connection it will be a [Gio.TcpConnection].
 * As `GSocketClient` is a lightweight object, you don't need to cache it. You
 * can just create a new one any time you need one.
 */
struct GSocketClient
{
  ObjectC parentInstance;

  GSocketClientPrivate* priv;
}

struct GSocketClientClass
{
  GObjectClass parentClass;

  extern(C) void function(GSocketClient* client, GSocketClientEvent event, GSocketConnectable* connectable, GIOStream* connection) event;

  extern(C) void function() GReserved1;

  extern(C) void function() GReserved2;

  extern(C) void function() GReserved3;

  extern(C) void function() GReserved4;
}

struct GSocketClientPrivate;

/**
 * Objects that describe one or more potential socket endpoints
 * implement `GSocketConnectable`. Callers can then use
 * [Gio.SocketConnectable.enumerate] to get a
 * [Gio.SocketAddressEnumerator] to try out each socket address in turn
 * until one succeeds, as shown in the sample code below.
 * ```c
 * MyConnectionType *
 * connect_to_host $(LPAREN)const char    *hostname,
 * guint16        port,
 * GCancellable  *cancellable,
 * GError       **error$(RPAREN)
 * {
 * MyConnection *conn \= NULL;
 * GSocketConnectable *addr;
 * GSocketAddressEnumerator *enumerator;
 * GSocketAddress *sockaddr;
 * GError *conn_error \= NULL;
 * addr \= g_network_address_new $(LPAREN)hostname, port$(RPAREN);
 * enumerator \= g_socket_connectable_enumerate $(LPAREN)addr$(RPAREN);
 * g_object_unref $(LPAREN)addr$(RPAREN);
 * // Try each sockaddr until we succeed. Record the first connection error,
 * // but not any further ones $(LPAREN)since they'll probably be basically the same
 * // as the first$(RPAREN).
 * while $(LPAREN)!conn && $(LPAREN)sockaddr \= g_socket_address_enumerator_next $(LPAREN)enumerator, cancellable, error$(RPAREN)$(RPAREN)
 * {
 * conn \= connect_to_sockaddr $(LPAREN)sockaddr, conn_error ? NULL : &conn_error$(RPAREN);
 * g_object_unref $(LPAREN)sockaddr$(RPAREN);
 * }
 * g_object_unref $(LPAREN)enumerator$(RPAREN);
 * if $(LPAREN)conn$(RPAREN)
 * {
 * if $(LPAREN)conn_error$(RPAREN)
 * {
 * // We couldn't connect to the first address, but we succeeded
 * // in connecting to a later address.
 * g_error_free $(LPAREN)conn_error$(RPAREN);
 * }
 * return conn;
 * }
 * else if $(LPAREN)error$(RPAREN)
 * {
 * /// Either initial lookup failed, or else the caller cancelled us.
 * if $(LPAREN)conn_error$(RPAREN)
 * g_error_free $(LPAREN)conn_error$(RPAREN);
 * return NULL;
 * }
 * else
 * {
 * g_error_propagate $(LPAREN)error, conn_error$(RPAREN);
 * return NULL;
 * }
 * }
 * ```
 */
struct GSocketConnectable;

/**
 * Provides an interface for returning a #GSocketAddressEnumerator
 * and #GProxyAddressEnumerator
 */
struct GSocketConnectableIface
{
  /**
   * The parent interface.
   */
  GTypeInterface gIface;

  /**
   * Creates a #GSocketAddressEnumerator
   */
  extern(C) GSocketAddressEnumerator* function(GSocketConnectable* connectable) enumerate;

  /**
   * Creates a #GProxyAddressEnumerator
   */
  extern(C) GSocketAddressEnumerator* function(GSocketConnectable* connectable) proxyEnumerate;

  /**
   * Format the connectable’s address as a string for debugging.
   * Implementing this is optional. $(LPAREN)Since: 2.48$(RPAREN)
   */
  extern(C) char* function(GSocketConnectable* connectable) toString_;
}

/**
 * `GSocketConnection` is a [Gio.IOStream] for a connected socket. They
 * can be created either by [Gio.SocketClient] when connecting to a host,
 * or by [Gio.SocketListener] when accepting a new client.
 * The type of the `GSocketConnection` object returned from these calls
 * depends on the type of the underlying socket that is in use. For
 * instance, for a TCP/IP connection it will be a [Gio.TcpConnection].
 * Choosing what type of object to construct is done with the socket
 * connection factory, and it is possible for third parties to register
 * custom socket connection types for specific combination of socket
 * family/type/protocol using [Gio.SocketConnection.factoryRegisterType].
 * To close a `GSocketConnection`, use [Gio.IOStream.close]. Closing both
 * substreams of the [Gio.IOStream] separately will not close the
 * underlying [Gio.Socket].
 */
struct GSocketConnection
{
  GIOStream parentInstance;

  GSocketConnectionPrivate* priv;
}

struct GSocketConnectionClass
{
  GIOStreamClass parentClass;

  extern(C) void function() GReserved1;

  extern(C) void function() GReserved2;

  extern(C) void function() GReserved3;

  extern(C) void function() GReserved4;

  extern(C) void function() GReserved5;

  extern(C) void function() GReserved6;
}

struct GSocketConnectionPrivate;

/**
 * A `GSocketControlMessage` is a special-purpose utility message that
 * can be sent to or received from a [Gio.Socket]. These types of
 * messages are often called ‘ancillary data’.
 * The message can represent some sort of special instruction to or
 * information from the socket or can represent a special kind of
 * transfer to the peer $(LPAREN)for example, sending a file descriptor over
 * a UNIX socket$(RPAREN).
 * These messages are sent with [Gio.Socket.sendMessage] and received
 * with [Gio.Socket.receiveMessage].
 * To extend the set of control message that can be sent, subclass this
 * class and override the `get_size`, `get_level`, `get_type` and `serialize`
 * methods.
 * To extend the set of control messages that can be received, subclass
 * this class and implement the `deserialize` method. Also, make sure your
 * class is registered with the [GObject.GType] type system before calling
 * [Gio.Socket.receiveMessage] to read such a message.
 */
struct GSocketControlMessage
{
  ObjectC parentInstance;

  GSocketControlMessagePrivate* priv;
}

/**
 * Class structure for #GSocketControlMessage.
 */
struct GSocketControlMessageClass
{
  GObjectClass parentClass;

  /**
   * gets the size of the message.
   */
  extern(C) size_t function(GSocketControlMessage* message) getSize;

  /**
   * gets the protocol of the message.
   */
  extern(C) int function(GSocketControlMessage* message) getLevel;

  /**
   * gets the protocol specific type of the message.
   */
  extern(C) int function(GSocketControlMessage* message) getType;

  /**
   * Writes out the message data.
   */
  extern(C) void function(GSocketControlMessage* message, void* data) serialize;

  /**
   * Tries to deserialize a message.
   */
  extern(C) GSocketControlMessage* function(int level, int type, size_t size, void* data) deserialize;

  extern(C) void function() GReserved1;

  extern(C) void function() GReserved2;

  extern(C) void function() GReserved3;

  extern(C) void function() GReserved4;

  extern(C) void function() GReserved5;
}

struct GSocketControlMessagePrivate;

/**
 * A `GSocketListener` is an object that keeps track of a set
 * of server sockets and helps you accept sockets from any of the
 * socket, either sync or async.
 * Add addresses and ports to listen on using
 * [Gio.SocketListener.addAddress] and
 * [Gio.SocketListener.addInetPort]. These will be listened on until
 * [Gio.SocketListener.close] is called. Dropping your final reference to
 * the `GSocketListener` will not cause [Gio.SocketListener.close] to be
 * called implicitly, as some references to the `GSocketListener` may be held
 * internally.
 * If you want to implement a network server, also look at
 * [Gio.SocketService] and [Gio.ThreadedSocketService] which are
 * subclasses of `GSocketListener` that make this even easier.
 */
struct GSocketListener
{
  ObjectC parentInstance;

  GSocketListenerPrivate* priv;
}

/**
 * Class structure for #GSocketListener.
 */
struct GSocketListenerClass
{
  GObjectClass parentClass;

  /**
   * virtual method called when the set of socket listened to changes
   */
  extern(C) void function(GSocketListener* listener) changed;

  extern(C) void function(GSocketListener* listener, GSocketListenerEvent event, GSocket* socket) event;

  extern(C) void function() GReserved2;

  extern(C) void function() GReserved3;

  extern(C) void function() GReserved4;

  extern(C) void function() GReserved5;

  extern(C) void function() GReserved6;
}

struct GSocketListenerPrivate;

struct GSocketPrivate;

/**
 * A `GSocketService` is an object that represents a service that
 * is provided to the network or over local sockets.  When a new
 * connection is made to the service the [Gio.SocketService.incoming]
 * signal is emitted.
 * A `GSocketService` is a subclass of [Gio.SocketListener] and you need
 * to add the addresses you want to accept connections on with the
 * [Gio.SocketListener] APIs.
 * There are two options for implementing a network service based on
 * `GSocketService`. The first is to create the service using
 * [Gio.SocketService.new_] and to connect to the
 * [Gio.SocketService.incoming] signal. The second is to subclass
 * `GSocketService` and override the default signal handler implementation.
 * In either case, the handler must immediately return, or else it
 * will block additional incoming connections from being serviced.
 * If you are interested in writing connection handlers that contain
 * blocking code then see [Gio.ThreadedSocketService].
 * The socket service runs on the main loop of the
 * thread-default context $(LPAREN)see
 * [GLib.MainContext.pushThreadDefault]$(RPAREN) of the thread it is
 * created in, and is not threadsafe in general. However, the calls to start and
 * stop the service are thread-safe so these can be used from threads that
 * handle incoming clients.
 */
struct GSocketService
{
  GSocketListener parentInstance;

  GSocketServicePrivate* priv;
}

/**
 * Class structure for #GSocketService.
 */
struct GSocketServiceClass
{
  GSocketListenerClass parentClass;

  /**
   * signal emitted when new connections are accepted
   */
  extern(C) bool function(GSocketService* service, GSocketConnection* connection, ObjectC* sourceObject) incoming;

  extern(C) void function() GReserved1;

  extern(C) void function() GReserved2;

  extern(C) void function() GReserved3;

  extern(C) void function() GReserved4;

  extern(C) void function() GReserved5;

  extern(C) void function() GReserved6;
}

struct GSocketServicePrivate;

/**
 * A single target host/port that a network service is running on.
 * SRV $(LPAREN)service$(RPAREN) records are used by some network protocols to provide
 * service-specific aliasing and load-balancing. For example, XMPP
 * $(LPAREN)Jabber$(RPAREN) uses SRV records to locate the XMPP server for a domain;
 * rather than connecting directly to ‘example.com’ or assuming a
 * specific server hostname like ‘xmpp.example.com’, an XMPP client
 * would look up the `xmpp-client` SRV record for ‘example.com’, and
 * then connect to whatever host was pointed to by that record.
 * You can use [Gio.Resolver.lookupService] or
 * [Gio.Resolver.lookupServiceAsync] to find the `GSrvTarget`s
 * for a given service. However, if you are simply planning to connect
 * to the remote service, you can use [Gio.NetworkService]’s
 * [Gio.SocketConnectable] interface and not need to worry about
 * `GSrvTarget` at all.
 */
struct GSrvTarget;

/**
 * #GStaticResource is an opaque data structure and can only be accessed
 * using the following functions.
 */
struct GStaticResource
{
  const(ubyte)* data;

  size_t dataLen;

  GResource* resource;

  GStaticResource* next;

  void* padding;
}

/**
 * `GSubprocess` allows the creation of and interaction with child
 * processes.
 * Processes can be communicated with using standard GIO-style APIs $(LPAREN)ie:
 * [Gio.InputStream], [Gio.OutputStream]$(RPAREN). There are GIO-style APIs
 * to wait for process termination $(LPAREN)ie: cancellable and with an asynchronous
 * variant$(RPAREN).
 * There is an API to force a process to terminate, as well as a
 * race-free API for sending UNIX signals to a subprocess.
 * One major advantage that GIO brings over the core GLib library is
 * comprehensive API for asynchronous I/O, such
 * [Gio.OutputStream.spliceAsync].  This makes `GSubprocess`
 * significantly more powerful and flexible than equivalent APIs in
 * some other languages such as the `subprocess.py`
 * included with Python.  For example, using `GSubprocess` one could
 * create two child processes, reading standard output from the first,
 * processing it, and writing to the input stream of the second, all
 * without blocking the main loop.
 * A powerful [Gio.Subprocess.communicate] API is provided similar to the
 * `communicate$(LPAREN)$(RPAREN)` method of `subprocess.py`. This enables very easy
 * interaction with a subprocess that has been opened with pipes.
 * `GSubprocess` defaults to tight control over the file descriptors open
 * in the child process, avoiding dangling-FD issues that are caused by
 * a simple `fork$(LPAREN)$(RPAREN)`/`exec$(LPAREN)$(RPAREN)`.  The only open file descriptors in the
 * spawned process are ones that were explicitly specified by the
 * `GSubprocess` API $(LPAREN)unless `G_SUBPROCESS_FLAGS_INHERIT_FDS` was
 * specified$(RPAREN).
 * `GSubprocess` will quickly reap all child processes as they exit,
 * avoiding ‘zombie processes’ remaining around for long periods of
 * time.  [Gio.Subprocess.wait] can be used to wait for this to happen,
 * but it will happen even without the call being explicitly made.
 * As a matter of principle, `GSubprocess` has no API that accepts
 * shell-style space-separated strings.  It will, however, match the
 * typical shell behaviour of searching the `PATH` for executables that do
 * not contain a directory separator in their name. By default, the `PATH`
 * of the current process is used.  You can specify
 * `G_SUBPROCESS_FLAGS_SEARCH_PATH_FROM_ENVP` to use the `PATH` of the
 * launcher environment instead.
 * `GSubprocess` attempts to have a very simple API for most uses $(LPAREN)ie:
 * spawning a subprocess with arguments and support for most typical
 * kinds of input and output redirection$(RPAREN).  See [Gio.Subprocess.new_]. The
 * [Gio.SubprocessLauncher] API is provided for more complicated cases
 * $(LPAREN)advanced types of redirection, environment variable manipulation,
 * change of working directory, child setup functions, etc$(RPAREN).
 * A typical use of `GSubprocess` will involve calling
 * [Gio.Subprocess.new_], followed by [Gio.Subprocess.waitAsync] or
 * [Gio.Subprocess.wait].  After the process exits, the status can be
 * checked using functions such as [Gio.Subprocess.getIfExited] $(LPAREN)which
 * are similar to the familiar `WIFEXITED`-style POSIX macros$(RPAREN).
 */
struct GSubprocess;

/**
 * This class contains a set of options for launching child processes,
 * such as where its standard input and output will be directed, the
 * argument list, the environment, and more.
 * While the [Gio.Subprocess] class has high level functions covering
 * popular cases, use of this class allows access to more advanced
 * options.  It can also be used to launch multiple subprocesses with
 * a similar configuration.
 */
struct GSubprocessLauncher;

/**
 * A `GTask` represents and manages a cancellable ‘task’.
 * ## Asynchronous operations
 * The most common usage of `GTask` is as a [Gio.AsyncResult], to
 * manage data during an asynchronous operation. You call
 * [Gio.Task.new_] in the ‘start’ method, followed by
 * [Gio.Task.setTaskData] and the like if you need to keep some
 * additional data associated with the task, and then pass the
 * task object around through your asynchronous operation.
 * Eventually, you will call a method such as
 * [Gio.Task.returnPointer] or [Gio.Task.returnError], which
 * will save the value you give it and then invoke the task’s callback
 * function in the thread-default main context $(LPAREN)see
 * [GLib.MainContext.pushThreadDefault]$(RPAREN)
 * where it was created $(LPAREN)waiting until the next iteration of the main
 * loop first, if necessary$(RPAREN). The caller will pass the `GTask` back to
 * the operation’s finish function $(LPAREN)as a [Gio.AsyncResult]$(RPAREN), and you can
 * use [Gio.Task.propagatePointer] or the like to extract the
 * return value.
 * Using `GTask` requires the thread-default [GLib.MainContext] from when
 * the `GTask` was constructed to be running at least until the task has
 * completed and its data has been freed.
 * If a `GTask` has been constructed and its callback set, it is an error to
 * not call `g_task_return_*$(LPAREN)$(RPAREN)` on it. GLib will warn at runtime if this happens
 * $(LPAREN)since 2.76$(RPAREN).
 * Here is an example for using `GTask` as a [Gio.AsyncResult]:
 * ```c
 * typedef struct {
 * CakeFrostingType frosting;
 * char *message;
 * } DecorationData;
 * static void
 * decoration_data_free $(LPAREN)DecorationData *decoration$(RPAREN)
 * {
 * g_free $(LPAREN)decoration->message$(RPAREN);
 * g_slice_free $(LPAREN)DecorationData, decoration$(RPAREN);
 * }
 * static void
 * baked_cb $(LPAREN)Cake     *cake,
 * gpointer  user_data$(RPAREN)
 * {
 * GTask *task \= user_data;
 * DecorationData *decoration \= g_task_get_task_data $(LPAREN)task$(RPAREN);
 * GError *error \= NULL;
 * if $(LPAREN)cake \=\= NULL$(RPAREN)
 * {
 * g_task_return_new_error $(LPAREN)task, BAKER_ERROR, BAKER_ERROR_NO_FLOUR,
 * "Go to the supermarket"$(RPAREN);
 * g_object_unref $(LPAREN)task$(RPAREN);
 * return;
 * }
 * if $(LPAREN)!cake_decorate $(LPAREN)cake, decoration->frosting, decoration->message, &error$(RPAREN)$(RPAREN)
 * {
 * g_object_unref $(LPAREN)cake$(RPAREN);
 * // [Gio.Task.returnError] takes ownership of error
 * g_task_return_error $(LPAREN)task, error$(RPAREN);
 * g_object_unref $(LPAREN)task$(RPAREN);
 * return;
 * }
 * g_task_return_pointer $(LPAREN)task, cake, g_object_unref$(RPAREN);
 * g_object_unref $(LPAREN)task$(RPAREN);
 * }
 * void
 * baker_bake_cake_async $(LPAREN)Baker               *self,
 * guint                radius,
 * CakeFlavor           flavor,
 * CakeFrostingType     frosting,
 * const char          *message,
 * GCancellable        *cancellable,
 * GAsyncReadyCallback  callback,
 * gpointer             user_data$(RPAREN)
 * {
 * GTask *task;
 * DecorationData *decoration;
 * Cake  *cake;
 * task \= g_task_new $(LPAREN)self, cancellable, callback, user_data$(RPAREN);
 * if $(LPAREN)radius < 3$(RPAREN)
 * {
 * g_task_return_new_error $(LPAREN)task, BAKER_ERROR, BAKER_ERROR_TOO_SMALL,
 * "%ucm radius cakes are silly",
 * radius$(RPAREN);
 * g_object_unref $(LPAREN)task$(RPAREN);
 * return;
 * }
 * cake \= _baker_get_cached_cake $(LPAREN)self, radius, flavor, frosting, message$(RPAREN);
 * if $(LPAREN)cake !\= NULL$(RPAREN)
 * {
 * // _baker_get_cached_cake$(LPAREN)$(RPAREN) returns a reffed cake
 * g_task_return_pointer $(LPAREN)task, cake, g_object_unref$(RPAREN);
 * g_object_unref $(LPAREN)task$(RPAREN);
 * return;
 * }
 * decoration \= g_slice_new $(LPAREN)DecorationData$(RPAREN);
 * decoration->frosting \= frosting;
 * decoration->message \= g_strdup $(LPAREN)message$(RPAREN);
 * g_task_set_task_data $(LPAREN)task, decoration, $(LPAREN)GDestroyNotify$(RPAREN) decoration_data_free$(RPAREN);
 * _baker_begin_cake $(LPAREN)self, radius, flavor, cancellable, baked_cb, task$(RPAREN);
 * }
 * Cake *
 * baker_bake_cake_finish $(LPAREN)Baker         *self,
 * GAsyncResult  *result,
 * GError       **error$(RPAREN)
 * {
 * g_return_val_if_fail $(LPAREN)g_task_is_valid $(LPAREN)result, self$(RPAREN), NULL$(RPAREN);
 * return g_task_propagate_pointer $(LPAREN)G_TASK $(LPAREN)result$(RPAREN), error$(RPAREN);
 * }
 * ```
 * ## Chained asynchronous operations
 * `GTask` also tries to simplify asynchronous operations that
 * internally chain together several smaller asynchronous
 * operations. [Gio.Task.getCancellable], [Gio.Task.getContext],
 * and [Gio.Task.getPriority] allow you to get back the task’s
 * [Gio.Cancellable], [GLib.MainContext], and
 * [I/O priority](iface.AsyncResult.html#io-priority)
 * when starting a new subtask, so you don’t have to keep track
 * of them yourself. [Gio.Task.attachSource] simplifies the case
 * of waiting for a source to fire $(LPAREN)automatically using the correct
 * [GLib.MainContext] and priority$(RPAREN).
 * Here is an example for chained asynchronous operations:
 * ```c
 * typedef struct {
 * Cake *cake;
 * CakeFrostingType frosting;
 * char *message;
 * } BakingData;
 * static void
 * decoration_data_free $(LPAREN)BakingData *bd$(RPAREN)
 * {
 * if $(LPAREN)bd->cake$(RPAREN)
 * g_object_unref $(LPAREN)bd->cake$(RPAREN);
 * g_free $(LPAREN)bd->message$(RPAREN);
 * g_slice_free $(LPAREN)BakingData, bd$(RPAREN);
 * }
 * static void
 * decorated_cb $(LPAREN)Cake         *cake,
 * GAsyncResult *result,
 * gpointer      user_data$(RPAREN)
 * {
 * GTask *task \= user_data;
 * GError *error \= NULL;
 * if $(LPAREN)!cake_decorate_finish $(LPAREN)cake, result, &error$(RPAREN)$(RPAREN)
 * {
 * g_object_unref $(LPAREN)cake$(RPAREN);
 * g_task_return_error $(LPAREN)task, error$(RPAREN);
 * g_object_unref $(LPAREN)task$(RPAREN);
 * return;
 * }
 * // baking_data_free$(LPAREN)$(RPAREN) will drop its ref on the cake, so we have to
 * // take another here to give to the caller.
 * g_task_return_pointer $(LPAREN)task, g_object_ref $(LPAREN)cake$(RPAREN), g_object_unref$(RPAREN);
 * g_object_unref $(LPAREN)task$(RPAREN);
 * }
 * static gboolean
 * decorator_ready $(LPAREN)gpointer user_data$(RPAREN)
 * {
 * GTask *task \= user_data;
 * BakingData *bd \= g_task_get_task_data $(LPAREN)task$(RPAREN);
 * cake_decorate_async $(LPAREN)bd->cake, bd->frosting, bd->message,
 * g_task_get_cancellable $(LPAREN)task$(RPAREN),
 * decorated_cb, task$(RPAREN);
 * return G_SOURCE_REMOVE;
 * }
 * static void
 * baked_cb $(LPAREN)Cake     *cake,
 * gpointer  user_data$(RPAREN)
 * {
 * GTask *task \= user_data;
 * BakingData *bd \= g_task_get_task_data $(LPAREN)task$(RPAREN);
 * GError *error \= NULL;
 * if $(LPAREN)cake \=\= NULL$(RPAREN)
 * {
 * g_task_return_new_error $(LPAREN)task, BAKER_ERROR, BAKER_ERROR_NO_FLOUR,
 * "Go to the supermarket"$(RPAREN);
 * g_object_unref $(LPAREN)task$(RPAREN);
 * return;
 * }
 * bd->cake \= cake;
 * // Bail out now if the user has already cancelled
 * if $(LPAREN)g_task_return_error_if_cancelled $(LPAREN)task$(RPAREN)$(RPAREN)
 * {
 * g_object_unref $(LPAREN)task$(RPAREN);
 * return;
 * }
 * if $(LPAREN)cake_decorator_available $(LPAREN)cake$(RPAREN)$(RPAREN)
 * decorator_ready $(LPAREN)task$(RPAREN);
 * else
 * {
 * GSource *source;
 * source \= cake_decorator_wait_source_new $(LPAREN)cake$(RPAREN);
 * // Attach @source to @task’s GMainContext and have it call
 * // decorator_ready$(LPAREN)$(RPAREN) when it is ready.
 * g_task_attach_source $(LPAREN)task, source, decorator_ready$(RPAREN);
 * g_source_unref $(LPAREN)source$(RPAREN);
 * }
 * }
 * void
 * baker_bake_cake_async $(LPAREN)Baker               *self,
 * guint                radius,
 * CakeFlavor           flavor,
 * CakeFrostingType     frosting,
 * const char          *message,
 * gint                 priority,
 * GCancellable        *cancellable,
 * GAsyncReadyCallback  callback,
 * gpointer             user_data$(RPAREN)
 * {
 * GTask *task;
 * BakingData *bd;
 * task \= g_task_new $(LPAREN)self, cancellable, callback, user_data$(RPAREN);
 * g_task_set_priority $(LPAREN)task, priority$(RPAREN);
 * bd \= g_slice_new0 $(LPAREN)BakingData$(RPAREN);
 * bd->frosting \= frosting;
 * bd->message \= g_strdup $(LPAREN)message$(RPAREN);
 * g_task_set_task_data $(LPAREN)task, bd, $(LPAREN)GDestroyNotify$(RPAREN) baking_data_free$(RPAREN);
 * _baker_begin_cake $(LPAREN)self, radius, flavor, cancellable, baked_cb, task$(RPAREN);
 * }
 * Cake *
 * baker_bake_cake_finish $(LPAREN)Baker         *self,
 * GAsyncResult  *result,
 * GError       **error$(RPAREN)
 * {
 * g_return_val_if_fail $(LPAREN)g_task_is_valid $(LPAREN)result, self$(RPAREN), NULL$(RPAREN);
 * return g_task_propagate_pointer $(LPAREN)G_TASK $(LPAREN)result$(RPAREN), error$(RPAREN);
 * }
 * ```
 * ## Asynchronous operations from synchronous ones
 * You can use [Gio.Task.runInThread] to turn a synchronous
 * operation into an asynchronous one, by running it in a thread.
 * When it completes, the result will be dispatched to the thread-default main
 * context $(LPAREN)see [GLib.MainContext.pushThreadDefault]$(RPAREN) where the `GTask`
 * was created.
 * Running a task in a thread:
 * ```c
 * typedef struct {
 * guint radius;
 * CakeFlavor flavor;
 * CakeFrostingType frosting;
 * char *message;
 * } CakeData;
 * static void
 * cake_data_free $(LPAREN)CakeData *cake_data$(RPAREN)
 * {
 * g_free $(LPAREN)cake_data->message$(RPAREN);
 * g_slice_free $(LPAREN)CakeData, cake_data$(RPAREN);
 * }
 * static void
 * bake_cake_thread $(LPAREN)GTask         *task,
 * gpointer       source_object,
 * gpointer       task_data,
 * GCancellable  *cancellable$(RPAREN)
 * {
 * Baker *self \= source_object;
 * CakeData *cake_data \= task_data;
 * Cake *cake;
 * GError *error \= NULL;
 * cake \= bake_cake $(LPAREN)baker, cake_data->radius, cake_data->flavor,
 * cake_data->frosting, cake_data->message,
 * cancellable, &error$(RPAREN);
 * if $(LPAREN)cake$(RPAREN)
 * g_task_return_pointer $(LPAREN)task, cake, g_object_unref$(RPAREN);
 * else
 * g_task_return_error $(LPAREN)task, error$(RPAREN);
 * }
 * void
 * baker_bake_cake_async $(LPAREN)Baker               *self,
 * guint                radius,
 * CakeFlavor           flavor,
 * CakeFrostingType     frosting,
 * const char          *message,
 * GCancellable        *cancellable,
 * GAsyncReadyCallback  callback,
 * gpointer             user_data$(RPAREN)
 * {
 * CakeData *cake_data;
 * GTask *task;
 * cake_data \= g_slice_new $(LPAREN)CakeData$(RPAREN);
 * cake_data->radius \= radius;
 * cake_data->flavor \= flavor;
 * cake_data->frosting \= frosting;
 * cake_data->message \= g_strdup $(LPAREN)message$(RPAREN);
 * task \= g_task_new $(LPAREN)self, cancellable, callback, user_data$(RPAREN);
 * g_task_set_task_data $(LPAREN)task, cake_data, $(LPAREN)GDestroyNotify$(RPAREN) cake_data_free$(RPAREN);
 * g_task_run_in_thread $(LPAREN)task, bake_cake_thread$(RPAREN);
 * g_object_unref $(LPAREN)task$(RPAREN);
 * }
 * Cake *
 * baker_bake_cake_finish $(LPAREN)Baker         *self,
 * GAsyncResult  *result,
 * GError       **error$(RPAREN)
 * {
 * g_return_val_if_fail $(LPAREN)g_task_is_valid $(LPAREN)result, self$(RPAREN), NULL$(RPAREN);
 * return g_task_propagate_pointer $(LPAREN)G_TASK $(LPAREN)result$(RPAREN), error$(RPAREN);
 * }
 * ```
 * ## Adding cancellability to uncancellable tasks
 * Finally, [Gio.Task.runInThread] and
 * [Gio.Task.runInThreadSync] can be used to turn an uncancellable
 * operation into a cancellable one. If you call
 * [Gio.Task.setReturnOnCancel], passing `TRUE`, then if the task’s
 * [Gio.Cancellable] is cancelled, it will return control back to the
 * caller immediately, while allowing the task thread to continue running in the
 * background $(LPAREN)and simply discarding its result when it finally does finish$(RPAREN).
 * Provided that the task thread is careful about how it uses
 * locks and other externally-visible resources, this allows you
 * to make ‘GLib-friendly’ asynchronous and cancellable
 * synchronous variants of blocking APIs.
 * Cancelling a task:
 * ```c
 * static void
 * bake_cake_thread $(LPAREN)GTask         *task,
 * gpointer       source_object,
 * gpointer       task_data,
 * GCancellable  *cancellable$(RPAREN)
 * {
 * Baker *self \= source_object;
 * CakeData *cake_data \= task_data;
 * Cake *cake;
 * GError *error \= NULL;
 * cake \= bake_cake $(LPAREN)baker, cake_data->radius, cake_data->flavor,
 * cake_data->frosting, cake_data->message,
 * &error$(RPAREN);
 * if $(LPAREN)error$(RPAREN)
 * {
 * g_task_return_error $(LPAREN)task, error$(RPAREN);
 * return;
 * }
 * // If the task has already been cancelled, then we don’t want to add
 * // the cake to the cake cache. Likewise, we don’t  want to have the
 * // task get cancelled in the middle of updating the cache.
 * // [Gio.Task.setReturnOnCancel] will return %TRUE here if it managed
 * // to disable return-on-cancel, or %FALSE if the task was cancelled
 * // before it could.
 * if $(LPAREN)g_task_set_return_on_cancel $(LPAREN)task, FALSE$(RPAREN)$(RPAREN)
 * {
 * // If the caller cancels at this point, their
 * // GAsyncReadyCallback won’t be invoked until we return,
 * // so we don’t have to worry that this code will run at
 * // the same time as that code does. But if there were
 * // other functions that might look at the cake cache,
 * // then we’d probably need a GMutex here as well.
 * baker_add_cake_to_cache $(LPAREN)baker, cake$(RPAREN);
 * g_task_return_pointer $(LPAREN)task, cake, g_object_unref$(RPAREN);
 * }
 * }
 * void
 * baker_bake_cake_async $(LPAREN)Baker               *self,
 * guint                radius,
 * CakeFlavor           flavor,
 * CakeFrostingType     frosting,
 * const char          *message,
 * GCancellable        *cancellable,
 * GAsyncReadyCallback  callback,
 * gpointer             user_data$(RPAREN)
 * {
 * CakeData *cake_data;
 * GTask *task;
 * cake_data \= g_slice_new $(LPAREN)CakeData$(RPAREN);
 * ...
 * task \= g_task_new $(LPAREN)self, cancellable, callback, user_data$(RPAREN);
 * g_task_set_task_data $(LPAREN)task, cake_data, $(LPAREN)GDestroyNotify$(RPAREN) cake_data_free$(RPAREN);
 * g_task_set_return_on_cancel $(LPAREN)task, TRUE$(RPAREN);
 * g_task_run_in_thread $(LPAREN)task, bake_cake_thread$(RPAREN);
 * }
 * Cake *
 * baker_bake_cake_sync $(LPAREN)Baker               *self,
 * guint                radius,
 * CakeFlavor           flavor,
 * CakeFrostingType     frosting,
 * const char          *message,
 * GCancellable        *cancellable,
 * GError             **error$(RPAREN)
 * {
 * CakeData *cake_data;
 * GTask *task;
 * Cake *cake;
 * cake_data \= g_slice_new $(LPAREN)CakeData$(RPAREN);
 * ...
 * task \= g_task_new $(LPAREN)self, cancellable, NULL, NULL$(RPAREN);
 * g_task_set_task_data $(LPAREN)task, cake_data, $(LPAREN)GDestroyNotify$(RPAREN) cake_data_free$(RPAREN);
 * g_task_set_return_on_cancel $(LPAREN)task, TRUE$(RPAREN);
 * g_task_run_in_thread_sync $(LPAREN)task, bake_cake_thread$(RPAREN);
 * cake \= g_task_propagate_pointer $(LPAREN)task, error$(RPAREN);
 * g_object_unref $(LPAREN)task$(RPAREN);
 * return cake;
 * }
 * ```
 * ## Porting from [Gio.SimpleAsyncResult]
 * `GTask`’s API attempts to be simpler than [Gio.SimpleAsyncResult]’s
 * in several ways:
 * - You can save task-specific data with [Gio.Task.setTaskData], and
 * retrieve it later with [Gio.Task.getTaskData]. This replaces the
 * abuse of [Gio.SimpleAsyncResult.setOpResGpointer] for the same
 * purpose with [Gio.SimpleAsyncResult].
 * - In addition to the task data, `GTask` also keeps track of the
 * [priority](iface.AsyncResult.html#io-priority), [Gio.Cancellable],
 * and [GLib.MainContext] associated with the task, so tasks that
 * consist of a chain of simpler asynchronous operations will have easy access
 * to those values when starting each sub-task.
 * - [Gio.Task.returnErrorIfCancelled] provides simplified
 * handling for cancellation. In addition, cancellation
 * overrides any other `GTask` return value by default, like
 * [Gio.SimpleAsyncResult] does when
 * [Gio.SimpleAsyncResult.setCheckCancellable] is called.
 * $(LPAREN)You can use [Gio.Task.setCheckCancellable] to turn off that
 * behavior.$(RPAREN) On the other hand, [Gio.Task.runInThread]
 * guarantees that it will always run your
 * `task_func`, even if the task’s [Gio.Cancellable]
 * is already cancelled before the task gets a chance to run;
 * you can start your `task_func` with a
 * [Gio.Task.returnErrorIfCancelled] check if you need the
 * old behavior.
 * - The ‘return’ methods $(LPAREN)eg, [Gio.Task.returnPointer]$(RPAREN)
 * automatically cause the task to be ‘completed’ as well, and
 * there is no need to worry about the ‘complete’ vs ‘complete in idle’
 * distinction. $(LPAREN)`GTask` automatically figures out
 * whether the task’s callback can be invoked directly, or
 * if it needs to be sent to another [GLib.MainContext], or delayed
 * until the next iteration of the current [GLib.MainContext].$(RPAREN)
 * - The ‘finish’ functions for `GTask` based operations are generally
 * much simpler than [Gio.SimpleAsyncResult] ones, normally consisting
 * of only a single call to [Gio.Task.propagatePointer] or the like.
 * Since [Gio.Task.propagatePointer] ‘steals’ the return value from
 * the `GTask`, it is not necessary to juggle pointers around to
 * prevent it from being freed twice.
 * - With [Gio.SimpleAsyncResult], it was common to call
 * [Gio.SimpleAsyncResult.propagateError] from the
 * `_finish$(LPAREN)$(RPAREN)` wrapper function, and have
 * virtual method implementations only deal with successful
 * returns. This behavior is deprecated, because it makes it
 * difficult for a subclass to chain to a parent class’s async
 * methods. Instead, the wrapper function should just be a
 * simple wrapper, and the virtual method should call an
 * appropriate `g_task_propagate_` function.
 * Note that wrapper methods can now use
 * [Gio.AsyncResult.legacyPropagateError] to do old-style
 * [Gio.SimpleAsyncResult] error-returning behavior, and
 * [Gio.AsyncResult.isTagged] to check if a result is tagged as
 * having come from the `_async$(LPAREN)$(RPAREN)` wrapper
 * function $(LPAREN)for ‘short-circuit’ results, such as when passing
 * `0` to [Gio.InputStream.readAsync]$(RPAREN).
 * ## Thread-safety considerations
 * Due to some infelicities in the API design, there is a
 * thread-safety concern that users of `GTask` have to be aware of:
 * If the `main` thread drops its last reference to the source object
 * or the task data before the task is finalized, then the finalizers
 * of these objects may be called on the worker thread.
 * This is a problem if the finalizers use non-threadsafe API, and
 * can lead to hard-to-debug crashes. Possible workarounds include:
 * - Clear task data in a signal handler for `notify::completed`
 * - Keep iterating a main context in the main thread and defer
 * dropping the reference to the source object to that main
 * context when the task is finalized
 */
struct GTask;

struct GTaskClass;

/**
 * This is the subclass of [Gio.SocketConnection] that is created
 * for TCP/IP sockets.
 */
struct GTcpConnection
{
  GSocketConnection parentInstance;

  GTcpConnectionPrivate* priv;
}

struct GTcpConnectionClass
{
  GSocketConnectionClass parentClass;
}

struct GTcpConnectionPrivate;

/**
 * A `GTcpWrapperConnection` can be used to wrap a [Gio.IOStream] that is
 * based on a [Gio.Socket], but which is not actually a
 * [Gio.SocketConnection]. This is used by [Gio.SocketClient] so
 * that it can always return a [Gio.SocketConnection], even when the
 * connection it has actually created is not directly a
 * [Gio.SocketConnection].
 */
struct GTcpWrapperConnection
{
  GTcpConnection parentInstance;

  GTcpWrapperConnectionPrivate* priv;
}

struct GTcpWrapperConnectionClass
{
  GTcpConnectionClass parentClass;
}

struct GTcpWrapperConnectionPrivate;

/**
 * A helper class for testing code which uses D-Bus without touching the user’s
 * session bus.
 * Note that `GTestDBus` modifies the user’s environment, calling
 * [`setenv$(LPAREN)$(RPAREN)`]$(LPAREN)$(RPAREN)(man:setenv3). This is not thread-safe, so all `GTestDBus`
 * calls should be completed before threads are spawned, or should have
 * appropriate locking to ensure no access conflicts to environment variables
 * shared between `GTestDBus` and other threads.
 * ## Creating unit tests using `GTestDBus`
 * Testing of D-Bus services can be tricky because normally we only ever run
 * D-Bus services over an existing instance of the D-Bus daemon thus we
 * usually don’t activate D-Bus services that are not yet installed into the
 * target system. The `GTestDBus` object makes this easier for us by taking care
 * of the lower level tasks such as running a private D-Bus daemon and looking
 * up uninstalled services in customizable locations, typically in your source
 * code tree.
 * The first thing you will need is a separate service description file for the
 * D-Bus daemon. Typically a `services` subdirectory of your `tests` directory
 * is a good place to put this file.
 * The service file should list your service along with an absolute path to the
 * uninstalled service executable in your source tree. Using autotools we would
 * achieve this by adding a file such as `my-server.service.in` in the services
 * directory and have it processed by configure.
 * ```
 * [D-BUS Service]
 * Name\=org.gtk.GDBus.Examples.ObjectManager
 * Exec\=@abs_top_builddir@/gio/tests/gdbus-example-objectmanager-server
 * ```
 * You will also need to indicate this service directory in your test
 * fixtures, so you will need to pass the path while compiling your
 * test cases. Typically this is done with autotools with an added
 * preprocessor flag specified to compile your tests such as:
 * ```
 * -DTEST_SERVICES\=\""\$$(LPAREN)abs_top_builddir$(RPAREN)/tests/services"\"
 * ```
 * Once you have a service definition file which is local to your source tree,
 * you can proceed to set up a GTest fixture using the `GTestDBus` scaffolding.
 * An example of a test fixture for D-Bus services can be found
 * here:
 * [gdbus-test-fixture.c](https://gitlab.gnome.org/GNOME/glib/-/blob/HEAD/gio/tests/gdbus-test-fixture.c)
 * Note that these examples only deal with isolating the D-Bus aspect of your
 * service. To successfully run isolated unit tests on your service you may need
 * some additional modifications to your test case fixture. For example; if your
 * service uses [Gio.Settings] and installs a schema then it is important
 * that your test service not load the schema in the ordinary installed location
 * $(LPAREN)chances are that your service and schema files are not yet installed, or
 * worse; there is an older version of the schema file sitting in the install
 * location$(RPAREN).
 * Most of the time we can work around these obstacles using the
 * environment. Since the environment is inherited by the D-Bus daemon
 * created by `GTestDBus` and then in turn inherited by any services the
 * D-Bus daemon activates, using the setup routine for your fixture is
 * a practical place to help sandbox your runtime environment. For the
 * rather typical GSettings case we can work around this by setting
 * `GSETTINGS_SCHEMA_DIR` to the in tree directory holding your schemas
 * in the above `fixture_setup$(LPAREN)$(RPAREN)` routine.
 * The GSettings schemas need to be locally pre-compiled for this to work. This
 * can be achieved by compiling the schemas locally as a step before running
 * test cases, an autotools setup might do the following in the directory
 * holding schemas:
 * ```
 * all-am:
 * \$$(LPAREN)GLIB_COMPILE_SCHEMAS$(RPAREN) .
 * CLEANFILES +\= gschemas.compiled
 * ```
 */
struct GTestDBus;

/**
 * `GThemedIcon` is an implementation of [Gio.Icon] that supports icon
 * themes.
 * `GThemedIcon` contains a list of all of the icons present in an icon
 * theme, so that icons can be looked up quickly. `GThemedIcon` does
 * not provide actual pixmaps for icons, just the icon names.
 * Ideally something like method@Gtk.IconTheme.choose_icon should be used to
 * resolve the list of names so that fallback icons work nicely with
 * themes that inherit other themes.
 */
struct GThemedIcon;

struct GThemedIconClass;

/**
 * #GThreadedResolver is an implementation of #GResolver which calls the libc
 * lookup functions in threads to allow them to run asynchronously.
 */
struct GThreadedResolver;

struct GThreadedResolverClass
{
  GResolverClass parentClass;
}

/**
 * A `GThreadedSocketService` is a simple subclass of [Gio.SocketService]
 * that handles incoming connections by creating a worker thread and
 * dispatching the connection to it by emitting the
 * [Gio.ThreadedSocketService.run] in the new thread.
 * The signal handler may perform blocking I/O and need not return
 * until the connection is closed.
 * The service is implemented using a thread pool, so there is a
 * limited amount of threads available to serve incoming requests.
 * The service automatically stops the [Gio.SocketService] from accepting
 * new connections when all threads are busy.
 * As with [Gio.SocketService], you may connect to
 * [Gio.ThreadedSocketService.run], or subclass and override the default
 * handler.
 */
struct GThreadedSocketService
{
  GSocketService parentInstance;

  GThreadedSocketServicePrivate* priv;
}

struct GThreadedSocketServiceClass
{
  GSocketServiceClass parentClass;

  extern(C) bool function(GThreadedSocketService* service, GSocketConnection* connection, ObjectC* sourceObject) run;

  extern(C) void function() GReserved1;

  extern(C) void function() GReserved2;

  extern(C) void function() GReserved3;

  extern(C) void function() GReserved4;

  extern(C) void function() GReserved5;
}

struct GThreadedSocketServicePrivate;

/**
 * TLS $(LPAREN)Transport Layer Security, aka SSL$(RPAREN) and DTLS backend. This is an
 * internal type used to coordinate the different classes implemented
 * by a TLS backend.
 */
struct GTlsBackend;

/**
 * Provides an interface for describing TLS-related types.
 */
struct GTlsBackendInterface
{
  /**
   * The parent interface.
   */
  GTypeInterface gIface;

  /**
   * returns whether the backend supports TLS.
   */
  extern(C) bool function(GTlsBackend* backend) supportsTls;

  /**
   * returns the #GTlsCertificate implementation type
   */
  extern(C) GType function() getCertificateType;

  /**
   * returns the #GTlsClientConnection implementation type
   */
  extern(C) GType function() getClientConnectionType;

  /**
   * returns the #GTlsServerConnection implementation type
   */
  extern(C) GType function() getServerConnectionType;

  /**
   * returns the #GTlsFileDatabase implementation type.
   */
  extern(C) GType function() getFileDatabaseType;

  /**
   * returns a default #GTlsDatabase instance.
   */
  extern(C) GTlsDatabase* function(GTlsBackend* backend) getDefaultDatabase;

  /**
   * returns whether the backend supports DTLS
   */
  extern(C) bool function(GTlsBackend* backend) supportsDtls;

  /**
   * returns the #GDtlsClientConnection implementation type
   */
  extern(C) GType function() getDtlsClientConnectionType;

  /**
   * returns the #GDtlsServerConnection implementation type
   */
  extern(C) GType function() getDtlsServerConnectionType;
}

/**
 * A certificate used for TLS authentication and encryption.
 * This can represent either a certificate only $(LPAREN)eg, the certificate
 * received by a client from a server$(RPAREN), or the combination of
 * a certificate and a private key $(LPAREN)which is needed when acting as a
 * [Gio.TlsServerConnection]$(RPAREN).
 */
struct GTlsCertificate
{
  ObjectC parentInstance;

  GTlsCertificatePrivate* priv;
}

struct GTlsCertificateClass
{
  GObjectClass parentClass;

  extern(C) GTlsCertificateFlags function(GTlsCertificate* cert, GSocketConnectable* identity, GTlsCertificate* trustedCa) verify;

  void*[8] padding;
}

struct GTlsCertificatePrivate;

/**
 * `GTlsClientConnection` is the client-side subclass of
 * [Gio.TlsConnection], representing a client-side TLS connection.
 */
struct GTlsClientConnection;

/**
 * vtable for a #GTlsClientConnection implementation.
 */
struct GTlsClientConnectionInterface
{
  /**
   * The parent interface.
   */
  GTypeInterface gIface;

  /**
   * Copies session state from one #GTlsClientConnection to another.
   */
  extern(C) void function(GTlsClientConnection* conn, GTlsClientConnection* source) copySessionState;
}

/**
 * `GTlsConnection` is the base TLS connection class type, which wraps
 * a [Gio.IOStream] and provides TLS encryption on top of it. Its
 * subclasses, [Gio.TlsClientConnection] and
 * [Gio.TlsServerConnection], implement client-side and server-side TLS,
 * respectively.
 * For DTLS $(LPAREN)Datagram TLS$(RPAREN) support, see [Gio.DtlsConnection].
 */
struct GTlsConnection
{
  GIOStream parentInstance;

  GTlsConnectionPrivate* priv;
}

/**
 * The class structure for the #GTlsConnection type.
 */
struct GTlsConnectionClass
{
  /**
   * The parent class.
   */
  GIOStreamClass parentClass;

  /**
   * Check whether to accept a certificate.
   */
  extern(C) bool function(GTlsConnection* connection, GTlsCertificate* peerCert, GTlsCertificateFlags errors) acceptCertificate;

  /**
   * Perform a handshake operation.
   */
  extern(C) bool function(GTlsConnection* conn, GCancellable* cancellable, GError** _err) handshake;

  /**
   * Start an asynchronous handshake operation.
   */
  extern(C) void function(GTlsConnection* conn, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) handshakeAsync;

  /**
   * Finish an asynchronous handshake operation.
   */
  extern(C) bool function(GTlsConnection* conn, GAsyncResult* result, GError** _err) handshakeFinish;

  /**
   * Retrieve TLS channel binding data $(LPAREN)Since: 2.66$(RPAREN)
   */
  extern(C) bool function(GTlsConnection* conn, GTlsChannelBindingType type, GByteArray* data, GError** _err) getBindingData;

  /**
   * Get ALPN-negotiated protocol $(LPAREN)Since: 2.70$(RPAREN)
   */
  extern(C) const(char)* function(GTlsConnection* conn) getNegotiatedProtocol;

  void*[6] padding;
}

struct GTlsConnectionPrivate;

/**
 * `GTlsDatabase` is used to look up certificates and other information
 * from a certificate or key store. It is an abstract base class which
 * TLS library specific subtypes override.
 * A `GTlsDatabase` may be accessed from multiple threads by the TLS backend.
 * All implementations are required to be fully thread-safe.
 * Most common client applications will not directly interact with
 * `GTlsDatabase`. It is used internally by [Gio.TlsConnection].
 */
struct GTlsDatabase
{
  ObjectC parentInstance;

  GTlsDatabasePrivate* priv;
}

/**
 * The class for #GTlsDatabase. Derived classes should implement the various
 * virtual methods. _async and _finish methods have a default
 * implementation that runs the corresponding sync method in a thread.
 */
struct GTlsDatabaseClass
{
  GObjectClass parentClass;

  /**
   * Virtual method implementing
   * [Gio.TlsDatabase.verifyChain].
   */
  extern(C) GTlsCertificateFlags function(GTlsDatabase* self, GTlsCertificate* chain, const(char)* purpose, GSocketConnectable* identity, GTlsInteraction* interaction, GTlsDatabaseVerifyFlags flags, GCancellable* cancellable, GError** _err) verifyChain;

  /**
   * Virtual method implementing
   * [Gio.TlsDatabase.verifyChainAsync].
   */
  extern(C) void function(GTlsDatabase* self, GTlsCertificate* chain, const(char)* purpose, GSocketConnectable* identity, GTlsInteraction* interaction, GTlsDatabaseVerifyFlags flags, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) verifyChainAsync;

  /**
   * Virtual method implementing
   * [Gio.TlsDatabase.verifyChainFinish].
   */
  extern(C) GTlsCertificateFlags function(GTlsDatabase* self, GAsyncResult* result, GError** _err) verifyChainFinish;

  /**
   * Virtual method implementing
   * [Gio.TlsDatabase.createCertificateHandle].
   */
  extern(C) char* function(GTlsDatabase* self, GTlsCertificate* certificate) createCertificateHandle;

  /**
   * Virtual method implementing
   * [Gio.TlsDatabase.lookupCertificateForHandle].
   */
  extern(C) GTlsCertificate* function(GTlsDatabase* self, const(char)* handle, GTlsInteraction* interaction, GTlsDatabaseLookupFlags flags, GCancellable* cancellable, GError** _err) lookupCertificateForHandle;

  /**
   * Virtual method implementing
   * [Gio.TlsDatabase.lookupCertificateForHandleAsync].
   */
  extern(C) void function(GTlsDatabase* self, const(char)* handle, GTlsInteraction* interaction, GTlsDatabaseLookupFlags flags, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) lookupCertificateForHandleAsync;

  /**
   * Virtual method implementing
   * [Gio.TlsDatabase.lookupCertificateForHandleFinish].
   */
  extern(C) GTlsCertificate* function(GTlsDatabase* self, GAsyncResult* result, GError** _err) lookupCertificateForHandleFinish;

  /**
   * Virtual method implementing
   * [Gio.TlsDatabase.lookupCertificateIssuer].
   */
  extern(C) GTlsCertificate* function(GTlsDatabase* self, GTlsCertificate* certificate, GTlsInteraction* interaction, GTlsDatabaseLookupFlags flags, GCancellable* cancellable, GError** _err) lookupCertificateIssuer;

  /**
   * Virtual method implementing
   * [Gio.TlsDatabase.lookupCertificateIssuerAsync].
   */
  extern(C) void function(GTlsDatabase* self, GTlsCertificate* certificate, GTlsInteraction* interaction, GTlsDatabaseLookupFlags flags, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) lookupCertificateIssuerAsync;

  /**
   * Virtual method implementing
   * [Gio.TlsDatabase.lookupCertificateIssuerFinish].
   */
  extern(C) GTlsCertificate* function(GTlsDatabase* self, GAsyncResult* result, GError** _err) lookupCertificateIssuerFinish;

  /**
   * Virtual method implementing
   * [Gio.TlsDatabase.lookupCertificatesIssuedBy].
   */
  extern(C) GList* function(GTlsDatabase* self, GByteArray* issuerRawDn, GTlsInteraction* interaction, GTlsDatabaseLookupFlags flags, GCancellable* cancellable, GError** _err) lookupCertificatesIssuedBy;

  /**
   * Virtual method implementing
   * [Gio.TlsDatabase.lookupCertificatesIssuedByAsync].
   */
  extern(C) void function(GTlsDatabase* self, GByteArray* issuerRawDn, GTlsInteraction* interaction, GTlsDatabaseLookupFlags flags, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) lookupCertificatesIssuedByAsync;

  /**
   * Virtual method implementing
   * [Gio.TlsDatabase.lookupCertificatesIssuedByFinish].
   */
  extern(C) GList* function(GTlsDatabase* self, GAsyncResult* result, GError** _err) lookupCertificatesIssuedByFinish;

  void*[16] padding;
}

struct GTlsDatabasePrivate;

/**
 * `GTlsFileDatabase` is implemented by [Gio.TlsDatabase] objects which
 * load their certificate information from a file. It is an interface which
 * TLS library specific subtypes implement.
 */
struct GTlsFileDatabase;

/**
 * Provides an interface for #GTlsFileDatabase implementations.
 */
struct GTlsFileDatabaseInterface
{
  /**
   * The parent interface.
   */
  GTypeInterface gIface;

  void*[8] padding;
}

/**
 * `GTlsInteraction` provides a mechanism for the TLS connection and database
 * code to interact with the user. It can be used to ask the user for passwords.
 * To use a `GTlsInteraction` with a TLS connection use
 * [Gio.TlsConnection.setInteraction].
 * Callers should instantiate a derived class that implements the various
 * interaction methods to show the required dialogs.
 * Callers should use the 'invoke' functions like
 * [Gio.TlsInteraction.invokeAskPassword] to run interaction methods.
 * These functions make sure that the interaction is invoked in the main loop
 * and not in the current thread, if the current thread is not running the
 * main loop.
 * Derived classes can choose to implement whichever interactions methods they’d
 * like to support by overriding those virtual methods in their class
 * initialization function. Any interactions not implemented will return
 * `G_TLS_INTERACTION_UNHANDLED`. If a derived class implements an async method,
 * it must also implement the corresponding finish method.
 */
struct GTlsInteraction
{
  ObjectC parentInstance;

  GTlsInteractionPrivate* priv;
}

/**
 * The class for #GTlsInteraction. Derived classes implement the various
 * virtual interaction methods to handle TLS interactions.
 * Derived classes can choose to implement whichever interactions methods they'd
 * like to support by overriding those virtual methods in their class
 * initialization function. If a derived class implements an async method,
 * it must also implement the corresponding finish method.
 * The synchronous interaction methods should implement to display modal dialogs,
 * and the asynchronous methods to display modeless dialogs.
 * If the user cancels an interaction, then the result should be
 * %G_TLS_INTERACTION_FAILED and the error should be set with a domain of
 * %G_IO_ERROR and code of %G_IO_ERROR_CANCELLED.
 */
struct GTlsInteractionClass
{
  GObjectClass parentClass;

  /**
   * ask for a password synchronously. If the implementation
   * returns %G_TLS_INTERACTION_HANDLED, then the password argument should
   * have been filled in by using [Gio.TlsPassword.setValue] or a similar
   * function.
   */
  extern(C) GTlsInteractionResult function(GTlsInteraction* interaction, GTlsPassword* password, GCancellable* cancellable, GError** _err) askPassword;

  /**
   * ask for a password asynchronously.
   */
  extern(C) void function(GTlsInteraction* interaction, GTlsPassword* password, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) askPasswordAsync;

  /**
   * complete operation to ask for a password asynchronously.
   * If the implementation returns %G_TLS_INTERACTION_HANDLED, then the
   * password argument of the async method should have been filled in by using
   * [Gio.TlsPassword.setValue] or a similar function.
   */
  extern(C) GTlsInteractionResult function(GTlsInteraction* interaction, GAsyncResult* result, GError** _err) askPasswordFinish;

  /**
   * ask for a certificate synchronously. If the
   * implementation returns %G_TLS_INTERACTION_HANDLED, then the connection
   * argument should have been filled in by using
   * [Gio.TlsConnection.setCertificate].
   */
  extern(C) GTlsInteractionResult function(GTlsInteraction* interaction, GTlsConnection* connection, GTlsCertificateRequestFlags flags, GCancellable* cancellable, GError** _err) requestCertificate;

  /**
   * ask for a certificate asynchronously.
   */
  extern(C) void function(GTlsInteraction* interaction, GTlsConnection* connection, GTlsCertificateRequestFlags flags, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) requestCertificateAsync;

  /**
   * complete operation to ask for a certificate
   * asynchronously. If the implementation returns %G_TLS_INTERACTION_HANDLED,
   * then the connection argument of the async method should have been
   * filled in by using [Gio.TlsConnection.setCertificate].
   */
  extern(C) GTlsInteractionResult function(GTlsInteraction* interaction, GAsyncResult* result, GError** _err) requestCertificateFinish;

  void*[21] padding;
}

struct GTlsInteractionPrivate;

/**
 * An abstract interface representing a password used in TLS. Often used in
 * user interaction such as unlocking a key storage token.
 */
struct GTlsPassword
{
  ObjectC parentInstance;

  GTlsPasswordPrivate* priv;
}

/**
 * Class structure for #GTlsPassword.
 */
struct GTlsPasswordClass
{
  GObjectClass parentClass;

  /**
   * virtual method for [Gio.TlsPassword.getValue]
   */
  extern(C) const(ubyte)* function(GTlsPassword* password, size_t* length) getValue;

  /**
   * virtual method for [Gio.TlsPassword.setValue]
   */
  extern(C) void function(GTlsPassword* password, ubyte* value, ptrdiff_t length, GDestroyNotify destroy) setValue;

  /**
   * virtual method for [Gio.TlsPassword.getWarning] if no
   * value has been set using [Gio.TlsPassword.setWarning]
   */
  extern(C) const(char)* function(GTlsPassword* password) getDefaultWarning;

  void*[4] padding;
}

struct GTlsPasswordPrivate;

/**
 * `GTlsServerConnection` is the server-side subclass of
 * [Gio.TlsConnection], representing a server-side TLS connection.
 */
struct GTlsServerConnection;

/**
 * vtable for a #GTlsServerConnection implementation.
 */
struct GTlsServerConnectionInterface
{
  /**
   * The parent interface.
   */
  GTypeInterface gIface;
}

/**
 * This is the subclass of [Gio.SocketConnection] that is created
 * for UNIX domain sockets.
 * It contains functions to do some of the UNIX socket specific
 * functionality like passing file descriptors.
 * Since GLib 2.72, `GUnixConnection` is available on all platforms. It requires
 * underlying system support $(LPAREN)such as Windows 10 with `AF_UNIX`$(RPAREN) at run time.
 * Before GLib 2.72, `<gio/gunixconnection.h>` belonged to the UNIX-specific GIO
 * interfaces, thus you had to use the `gio-unix-2.0.pc` pkg-config file when
 * using it. This is no longer necessary since GLib 2.72.
 */
struct GUnixConnection
{
  GSocketConnection parentInstance;

  GUnixConnectionPrivate* priv;
}

struct GUnixConnectionClass
{
  GSocketConnectionClass parentClass;
}

struct GUnixConnectionPrivate;

/**
 * This [Gio.SocketControlMessage] contains a [Gio.Credentials]
 * instance.  It may be sent using [Gio.Socket.sendMessage] and received
 * using [Gio.Socket.receiveMessage] over UNIX sockets $(LPAREN)ie: sockets in
 * the `G_SOCKET_FAMILY_UNIX` family$(RPAREN).
 * For an easier way to send and receive credentials over
 * stream-oriented UNIX sockets, see
 * [Gio.UnixConnection.sendCredentials] and
 * [Gio.UnixConnection.receiveCredentials]. To receive credentials of
 * a foreign process connected to a socket, use
 * [Gio.Socket.getCredentials].
 * Since GLib 2.72, `GUnixCredentialMessage` is available on all platforms. It
 * requires underlying system support $(LPAREN)such as Windows 10 with `AF_UNIX`$(RPAREN) at run
 * time.
 * Before GLib 2.72, `<gio/gunixcredentialsmessage.h>` belonged to the UNIX-specific
 * GIO interfaces, thus you had to use the `gio-unix-2.0.pc` pkg-config file
 * when using it. This is no longer necessary since GLib 2.72.
 */
struct GUnixCredentialsMessage
{
  GSocketControlMessage parentInstance;

  GUnixCredentialsMessagePrivate* priv;
}

/**
 * Class structure for #GUnixCredentialsMessage.
 */
struct GUnixCredentialsMessageClass
{
  GSocketControlMessageClass parentClass;

  extern(C) void function() GReserved1;

  extern(C) void function() GReserved2;
}

struct GUnixCredentialsMessagePrivate;

/**
 * A `GUnixFDList` contains a list of file descriptors.  It owns the file
 * descriptors that it contains, closing them when finalized.
 * It may be wrapped in a
 * [`GUnixFDMessage`](../gio-unix/class.UnixFDMessage.html) and sent over a
 * [Gio.Socket] in the `G_SOCKET_FAMILY_UNIX` family by using
 * [Gio.Socket.sendMessage] and received using
 * [Gio.Socket.receiveMessage].
 * Before 2.74, `<gio/gunixfdlist.h>` belonged to the UNIX-specific GIO
 * interfaces, thus you had to use the `gio-unix-2.0.pc` pkg-config file when
 * using it.
 * Since 2.74, the API is available for Windows.
 */
struct GUnixFDList
{
  ObjectC parentInstance;

  GUnixFDListPrivate* priv;
}

struct GUnixFDListClass
{
  GObjectClass parentClass;

  extern(C) void function() GReserved1;

  extern(C) void function() GReserved2;

  extern(C) void function() GReserved3;

  extern(C) void function() GReserved4;

  extern(C) void function() GReserved5;
}

struct GUnixFDListPrivate;

/**
 * This [Gio.SocketControlMessage] contains a [Gio.UnixFDList].
 * It may be sent using [Gio.Socket.sendMessage] and received using
 * [Gio.Socket.receiveMessage] over UNIX sockets $(LPAREN)ie: sockets in the
 * `G_SOCKET_FAMILY_UNIX` family$(RPAREN). The file descriptors are copied
 * between processes by the kernel.
 * For an easier way to send and receive file descriptors over
 * stream-oriented UNIX sockets, see [Gio.UnixConnection.sendFd] and
 * [Gio.UnixConnection.receiveFd].
 * Note that `<gio/gunixfdmessage.h>` belongs to the UNIX-specific GIO
 * interfaces, thus you have to use the `gio-unix-2.0.pc` pkg-config
 * file or the `GioUnix-2.0` GIR namespace when using it.
 */
struct GUnixFDMessage
{
  GSocketControlMessage parentInstance;

  GUnixFDMessagePrivate* priv;
}

struct GUnixFDMessageClass
{
  GSocketControlMessageClass parentClass;

  extern(C) void function() GReserved1;

  extern(C) void function() GReserved2;
}

struct GUnixFDMessagePrivate;

/**
 * `GUnixInputStream` implements [Gio.InputStream] for reading from a UNIX
 * file descriptor, including asynchronous operations. $(LPAREN)If the file
 * descriptor refers to a socket or pipe, this will use `poll$(LPAREN)$(RPAREN)` to do
 * asynchronous I/O. If it refers to a regular file, it will fall back
 * to doing asynchronous I/O in another thread.$(RPAREN)
 * Note that `<gio/gunixinputstream.h>` belongs to the UNIX-specific GIO
 * interfaces, thus you have to use the `gio-unix-2.0.pc` pkg-config
 * file or the `GioUnix-2.0` GIR namespace when using it.
 */
struct GUnixInputStream
{
  GInputStream parentInstance;

  GUnixInputStreamPrivate* priv;
}

struct GUnixInputStreamClass
{
  GInputStreamClass parentClass;

  extern(C) void function() GReserved1;

  extern(C) void function() GReserved2;

  extern(C) void function() GReserved3;

  extern(C) void function() GReserved4;

  extern(C) void function() GReserved5;
}

struct GUnixInputStreamPrivate;

/**
 * Defines a Unix mount entry $(LPAREN)e.g. <filename>/media/cdrom</filename>$(RPAREN).
 * This corresponds roughly to a mtab entry.
 */
struct GUnixMountEntry;

/**
 * Watches #GUnixMounts for changes.
 */
struct GUnixMountMonitor;

struct GUnixMountMonitorClass;

/**
 * Defines a Unix mount point $(LPAREN)e.g. <filename>/dev</filename>$(RPAREN).
 * This corresponds roughly to a fstab entry.
 */
struct GUnixMountPoint;

/**
 * `GUnixOutputStream` implements [Gio.OutputStream] for writing to a UNIX
 * file descriptor, including asynchronous operations. $(LPAREN)If the file
 * descriptor refers to a socket or pipe, this will use `poll$(LPAREN)$(RPAREN)` to do
 * asynchronous I/O. If it refers to a regular file, it will fall back
 * to doing asynchronous I/O in another thread.$(RPAREN)
 * Note that `<gio/gunixoutputstream.h>` belongs to the UNIX-specific GIO
 * interfaces, thus you have to use the `gio-unix-2.0.pc` pkg-config file
 * file or the `GioUnix-2.0` GIR namespace when using it.
 */
struct GUnixOutputStream
{
  GOutputStream parentInstance;

  GUnixOutputStreamPrivate* priv;
}

struct GUnixOutputStreamClass
{
  GOutputStreamClass parentClass;

  extern(C) void function() GReserved1;

  extern(C) void function() GReserved2;

  extern(C) void function() GReserved3;

  extern(C) void function() GReserved4;

  extern(C) void function() GReserved5;
}

struct GUnixOutputStreamPrivate;

/**
 * Support for UNIX-domain $(LPAREN)also known as local$(RPAREN) sockets, corresponding to
 * `struct sockaddr_un`.
 * UNIX domain sockets are generally visible in the filesystem.
 * However, some systems support abstract socket names which are not
 * visible in the filesystem and not affected by the filesystem
 * permissions, visibility, etc. Currently this is only supported
 * under Linux. If you attempt to use abstract sockets on other
 * systems, function calls may return `G_IO_ERROR_NOT_SUPPORTED`
 * errors. You can use [Gio.UnixSocketAddress.abstractNamesSupported]
 * to see if abstract names are supported.
 * Since GLib 2.72, `GUnixSocketAddress` is available on all platforms. It
 * requires underlying system support $(LPAREN)such as Windows 10 with `AF_UNIX`$(RPAREN) at
 * run time.
 * Before GLib 2.72, `<gio/gunixsocketaddress.h>` belonged to the UNIX-specific
 * GIO interfaces, thus you had to use the `gio-unix-2.0.pc` pkg-config file
 * when using it. This is no longer necessary since GLib 2.72.
 */
struct GUnixSocketAddress
{
  GSocketAddress parentInstance;

  GUnixSocketAddressPrivate* priv;
}

struct GUnixSocketAddressClass
{
  GSocketAddressClass parentClass;
}

struct GUnixSocketAddressPrivate;

/**
 * Entry point for using GIO functionality.
 */
struct GVfs
{
  ObjectC parentInstance;
}

struct GVfsClass
{
  GObjectClass parentClass;

  extern(C) bool function(GVfs* vfs) isActive;

  extern(C) GFile* function(GVfs* vfs, const(char)* path) getFileForPath;

  extern(C) GFile* function(GVfs* vfs, const(char)* uri) getFileForUri;

  extern(C) const(char*)* function(GVfs* vfs) getSupportedUriSchemes;

  extern(C) GFile* function(GVfs* vfs, const(char)* parseName) parseName;

  extern(C) void function(GVfs* vfs, const(char)* filename, ulong device, GFileAttributeMatcher* attributeMatcher, GFileInfo* info, GCancellable* cancellable, void** extraData, GDestroyNotify* freeExtraData) localFileAddInfo;

  extern(C) void function(GVfs* vfs, GFileAttributeInfoList* list) addWritableNamespaces;

  extern(C) bool function(GVfs* vfs, const(char)* filename, GFileInfo* info, GFileQueryInfoFlags flags, GCancellable* cancellable, GError** _err) localFileSetAttributes;

  extern(C) void function(GVfs* vfs, const(char)* filename) localFileRemoved;

  extern(C) void function(GVfs* vfs, const(char)* source, const(char)* dest) localFileMoved;

  extern(C) GIcon* function(GVfs* vfs, VariantC* value) deserializeIcon;

  extern(C) void function() GReserved1;

  extern(C) void function() GReserved2;

  extern(C) void function() GReserved3;

  extern(C) void function() GReserved4;

  extern(C) void function() GReserved5;

  extern(C) void function() GReserved6;
}

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
struct GVolume;

/**
 * Interface for implementing operations for mountable volumes.
 */
struct GVolumeIface
{
  /**
   * The parent interface.
   */
  GTypeInterface gIface;

  /**
   * Changed signal that is emitted when the volume's state has changed.
   */
  extern(C) void function(GVolume* volume) changed;

  /**
   * The removed signal that is emitted when the #GVolume have been removed. If the recipient is holding references to the object they should release them so the object can be finalized.
   */
  extern(C) void function(GVolume* volume) removed;

  /**
   * Gets a string containing the name of the #GVolume.
   */
  extern(C) char* function(GVolume* volume) getName;

  /**
   * Gets a #GIcon for the #GVolume.
   */
  extern(C) GIcon* function(GVolume* volume) getIcon;

  /**
   * Gets the UUID for the #GVolume. The reference is typically based on the file system UUID for the mount in question and should be considered an opaque string. Returns %NULL if there is no UUID available.
   */
  extern(C) char* function(GVolume* volume) getUuid;

  /**
   * Gets a #GDrive the volume is located on. Returns %NULL if the #GVolume is not associated with a #GDrive.
   */
  extern(C) GDrive* function(GVolume* volume) getDrive;

  /**
   * Gets a #GMount representing the mounted volume. Returns %NULL if the #GVolume is not mounted.
   */
  extern(C) GMount* function(GVolume* volume) getMount;

  /**
   * Returns %TRUE if the #GVolume can be mounted.
   */
  extern(C) bool function(GVolume* volume) canMount;

  /**
   * Checks if a #GVolume can be ejected.
   */
  extern(C) bool function(GVolume* volume) canEject;

  /**
   * Mounts a given #GVolume.
   * #GVolume implementations must emit the #GMountOperation::aborted
   * signal before completing a mount operation that is aborted while
   * awaiting input from the user through a #GMountOperation instance.
   */
  extern(C) void function(GVolume* volume, GMountMountFlags flags, GMountOperation* mountOperation, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) mountFn;

  /**
   * Finishes a mount operation.
   */
  extern(C) bool function(GVolume* volume, GAsyncResult* result, GError** _err) mountFinish;

  /**
   * Ejects a given #GVolume.
   */
  extern(C) void function(GVolume* volume, GMountUnmountFlags flags, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) eject;

  /**
   * Finishes an eject operation.
   */
  extern(C) bool function(GVolume* volume, GAsyncResult* result, GError** _err) ejectFinish;

  /**
   * Returns the [identifier](#volume-identifiers) of the given kind, or %NULL if
   * the #GVolume doesn't have one.
   */
  extern(C) char* function(GVolume* volume, const(char)* kind) getIdentifier;

  /**
   * Returns an array strings listing the kinds
   * of [identifiers](#volume-identifiers) which the #GVolume has.
   */
  extern(C) char** function(GVolume* volume) enumerateIdentifiers;

  /**
   * Returns %TRUE if the #GVolume should be automatically mounted.
   */
  extern(C) bool function(GVolume* volume) shouldAutomount;

  /**
   * Returns the activation root for the #GVolume if it is known in advance or %NULL if
   * it is not known.
   */
  extern(C) GFile* function(GVolume* volume) getActivationRoot;

  /**
   * Starts ejecting a #GVolume using a #GMountOperation. Since 2.22.
   */
  extern(C) void function(GVolume* volume, GMountUnmountFlags flags, GMountOperation* mountOperation, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData) ejectWithOperation;

  /**
   * Finishes an eject operation using a #GMountOperation. Since 2.22.
   */
  extern(C) bool function(GVolume* volume, GAsyncResult* result, GError** _err) ejectWithOperationFinish;

  /**
   * Gets a key used for sorting #GVolume instance or %NULL if no such key exists. Since 2.32.
   */
  extern(C) const(char)* function(GVolume* volume) getSortKey;

  /**
   * Gets a symbolic #GIcon for the #GVolume. Since 2.34.
   */
  extern(C) GIcon* function(GVolume* volume) getSymbolicIcon;
}

/**
 * `GVolumeMonitor` is for listing the user interesting devices and volumes
 * on the computer. In other words, what a file selector or file manager
 * would show in a sidebar.
 * `GVolumeMonitor` is not
 * thread-default-context aware $(LPAREN)see
 * [GLib.MainContext.pushThreadDefault]$(RPAREN), and so should not be used
 * other than from the main thread, with no thread-default-context active.
 * In order to receive updates about volumes and mounts monitored through GVFS,
 * a main loop must be running.
 */
struct GVolumeMonitor
{
  ObjectC parentInstance;

  void* priv;
}

struct GVolumeMonitorClass
{
  GObjectClass parentClass;

  extern(C) void function(GVolumeMonitor* volumeMonitor, GVolume* volume) volumeAdded;

  extern(C) void function(GVolumeMonitor* volumeMonitor, GVolume* volume) volumeRemoved;

  extern(C) void function(GVolumeMonitor* volumeMonitor, GVolume* volume) volumeChanged;

  extern(C) void function(GVolumeMonitor* volumeMonitor, GMount* mount) mountAdded;

  extern(C) void function(GVolumeMonitor* volumeMonitor, GMount* mount) mountRemoved;

  extern(C) void function(GVolumeMonitor* volumeMonitor, GMount* mount) mountPreUnmount;

  extern(C) void function(GVolumeMonitor* volumeMonitor, GMount* mount) mountChanged;

  extern(C) void function(GVolumeMonitor* volumeMonitor, GDrive* drive) driveConnected;

  extern(C) void function(GVolumeMonitor* volumeMonitor, GDrive* drive) driveDisconnected;

  extern(C) void function(GVolumeMonitor* volumeMonitor, GDrive* drive) driveChanged;

  extern(C) bool function() isSupported;

  extern(C) GList* function(GVolumeMonitor* volumeMonitor) getConnectedDrives;

  extern(C) GList* function(GVolumeMonitor* volumeMonitor) getVolumes;

  extern(C) GList* function(GVolumeMonitor* volumeMonitor) getMounts;

  extern(C) GVolume* function(GVolumeMonitor* volumeMonitor, const(char)* uuid) getVolumeForUuid;

  extern(C) GMount* function(GVolumeMonitor* volumeMonitor, const(char)* uuid) getMountForUuid;

  extern(C) GVolume* function(GMount* mount, GVolumeMonitor* volumeMonitor) adoptOrphanMount;

  extern(C) void function(GVolumeMonitor* volumeMonitor, GDrive* drive) driveEjectButton;

  extern(C) void function(GVolumeMonitor* volumeMonitor, GDrive* drive) driveStopButton;

  extern(C) void function() GReserved1;

  extern(C) void function() GReserved2;

  extern(C) void function() GReserved3;

  extern(C) void function() GReserved4;

  extern(C) void function() GReserved5;

  extern(C) void function() GReserved6;
}

/**
 * `GZlibCompressor` is an implementation of [Gio.Converter] that
 * compresses data using zlib.
 */
struct GZlibCompressor;

struct GZlibCompressorClass
{
  GObjectClass parentClass;
}

/**
 * `GZlibDecompressor` is an implementation of [Gio.Converter] that
 * decompresses data compressed with zlib.
 */
struct GZlibDecompressor;

struct GZlibDecompressorClass
{
  GObjectClass parentClass;
}

alias extern(C) void function(ObjectC* sourceObject, GAsyncResult* res, void* data) GAsyncReadyCallback;

alias extern(C) void function(GDBusConnection* connection, const(char)* name, void* userData) GBusAcquiredCallback;

alias extern(C) void function(GDBusConnection* connection, const(char)* name, void* userData) GBusNameAcquiredCallback;

alias extern(C) void function(GDBusConnection* connection, const(char)* name, const(char)* nameOwner, void* userData) GBusNameAppearedCallback;

alias extern(C) void function(GDBusConnection* connection, const(char)* name, void* userData) GBusNameLostCallback;

alias extern(C) void function(GDBusConnection* connection, const(char)* name, void* userData) GBusNameVanishedCallback;

alias extern(C) bool function(GCancellable* cancellable, void* data) GCancellableSourceFunc;

alias extern(C) VariantC* function(GDBusConnection* connection, const(char)* sender, const(char)* objectPath, const(char)* interfaceName, const(char)* propertyName, GError** error, void* userData) GDBusInterfaceGetPropertyFunc;

alias extern(C) void function(GDBusConnection* connection, const(char)* sender, const(char)* objectPath, const(char)* interfaceName, const(char)* methodName, VariantC* parameters, GDBusMethodInvocation* invocation, void* userData) GDBusInterfaceMethodCallFunc;

alias extern(C) bool function(GDBusConnection* connection, const(char)* sender, const(char)* objectPath, const(char)* interfaceName, const(char)* propertyName, VariantC* value, GError** error, void* userData) GDBusInterfaceSetPropertyFunc;

alias extern(C) GDBusMessage* function(GDBusConnection* connection, GDBusMessage* message, bool incoming, void* userData) GDBusMessageFilterFunction;

alias extern(C) GType function(GDBusObjectManagerClient* manager, const(char)* objectPath, const(char)* interfaceName, void* data) GDBusProxyTypeFunc;

alias extern(C) void function(GDBusConnection* connection, const(char)* senderName, const(char)* objectPath, const(char)* interfaceName, const(char)* signalName, VariantC* parameters, void* userData) GDBusSignalCallback;

alias extern(C) const(GDBusInterfaceVTable)* function(GDBusConnection* connection, const(char)* sender, const(char)* objectPath, const(char)* interfaceName, const(char)* node, void** outUserData, void* userData) GDBusSubtreeDispatchFunc;

alias extern(C) char** function(GDBusConnection* connection, const(char)* sender, const(char)* objectPath, void* userData) GDBusSubtreeEnumerateFunc;

alias extern(C) GDBusInterfaceInfo** function(GDBusConnection* connection, const(char)* sender, const(char)* objectPath, const(char)* node, void* userData) GDBusSubtreeIntrospectFunc;

alias extern(C) bool function(GDatagramBased* datagramBased, GIOCondition condition, void* data) GDatagramBasedSourceFunc;

alias extern(C) void function(GDesktopAppInfo* appinfo, GPid pid, void* userData) GDesktopAppLaunchCallback;

alias extern(C) void function(bool reporting, ulong currentSize, ulong numDirs, ulong numFiles, void* data) GFileMeasureProgressCallback;

alias extern(C) void function(long currentNumBytes, long totalNumBytes, void* data) GFileProgressCallback;

alias extern(C) bool function(const(char)* fileContents, long fileSize, void* callbackData) GFileReadMoreCallback;

alias extern(C) bool function(GIOSchedulerJob* job, GCancellable* cancellable, void* data) GIOSchedulerJobFunc;

alias extern(C) bool function(ObjectC* pollableStream, void* data) GPollableSourceFunc;

alias extern(C) void* function(void* data, size_t size) GReallocFunc;

alias extern(C) bool function(GValue* value, VariantC* variant, void* userData) GSettingsBindGetMapping;

alias extern(C) VariantC* function(const(GValue)* value, const(GVariantType)* expectedType, void* userData) GSettingsBindSetMapping;

alias extern(C) bool function(VariantC* value, void** result, void* userData) GSettingsGetMapping;

alias extern(C) void function(GSimpleAsyncResult* res, ObjectC* object, GCancellable* cancellable) GSimpleAsyncThreadFunc;

alias extern(C) bool function(GSocket* socket, GIOCondition condition, void* data) GSocketSourceFunc;

alias extern(C) void function(GTask* task, ObjectC* sourceObject, void* taskData, GCancellable* cancellable) GTaskThreadFunc;

alias extern(C) GFile* function(GVfs* vfs, const(char)* identifier, void* userData) GVfsFileLookupFunc;

