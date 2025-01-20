module Gio.Global;

import GLib.Bytes;
import GLib.ErrorG;
import GLib.List;
import GLib.Source;
import GLib.Types;
import GLib.Variant;
import GLib.VariantType;
import GObject.Closure;
import GObject.ObjectG;
import GObject.Value;
import Gid.gid;
import Gio.AsyncResult;
import Gio.AsyncResultT;
import Gio.Cancellable;
import Gio.DBusConnection;
import Gio.File;
import Gio.FileT;
import Gio.IOModule;
import Gio.IOModuleScope;
import Gio.IOSchedulerJob;
import Gio.IOStream;
import Gio.Icon;
import Gio.IconT;
import Gio.InputStream;
import Gio.OutputStream;
import Gio.Resource;
import Gio.SettingsBackend;
import Gio.Types;
import Gio.UnixMountEntry;
import Gio.UnixMountPoint;
import Gio.c.functions;
import Gio.c.types;


/**
 * Asynchronously connects to the message bus specified by bus_type.
 * When the operation is finished, callback will be invoked. You can
 * then call [Gio.Global.busGetFinish] to get the result of the operation.
 * This is an asynchronous failable function. See [Gio.Global.busGetSync] for
 * the synchronous version.
 * Params:
 *   busType = a #GBusType
 *   cancellable = a #GCancellable or %NULL
 *   callback = a #GAsyncReadyCallback to call when the request is satisfied
 */
void busGet(BusType busType, Cancellable cancellable, AsyncReadyCallback callback)
{
  extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
  {
    ptrThawGC(data);
    auto _dlg = cast(AsyncReadyCallback*)data;

    (*_dlg)(sourceObject ? ObjectG.getDObject!ObjectG(cast(void*)sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(cast(void*)res, false) : null);
  }

  auto _callback = freezeDelegate(cast(void*)&callback);
  g_bus_get(busType, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_callbackCallback, _callback);
}

/**
 * Finishes an operation started with [Gio.Global.busGet].
 * The returned object is a singleton, that is, shared with other
 * callers of [Gio.Global.busGet] and [Gio.Global.busGetSync] for bus_type. In the
 * event that you need a private message bus connection, use
 * [Gio.Global.dbusAddressGetForBusSync] and
 * [Gio.DBusConnection.newForAddress] with
 * G_DBUS_CONNECTION_FLAGS_AUTHENTICATION_CLIENT and
 * G_DBUS_CONNECTION_FLAGS_MESSAGE_BUS_CONNECTION flags.
 * Note that the returned #GDBusConnection object will $(LPAREN)usually$(RPAREN) have
 * the #GDBusConnection:exit-on-close property set to %TRUE.
 * Params:
 *   res = a #GAsyncResult obtained from the #GAsyncReadyCallback passed
 *     to [Gio.Global.busGet]
 * Returns: a #GDBusConnection or %NULL if error is set.
 *   Free with [GObject.ObjectG.unref].
 */
DBusConnection busGetFinish(AsyncResult res)
{
  GDBusConnection* _cretval;
  GError *_err;
  _cretval = g_bus_get_finish(res ? cast(GAsyncResult*)(cast(ObjectG)res).cPtr(false) : null, &_err);
  if (_err)
    throw new ErrorG(_err);
  auto _retval = _cretval ? ObjectG.getDObject!DBusConnection(cast(GDBusConnection*)_cretval, true) : null;
  return _retval;
}

/**
 * Synchronously connects to the message bus specified by bus_type.
 * Note that the returned object may shared with other callers,
 * e.g. if two separate parts of a process calls this function with
 * the same bus_type, they will share the same object.
 * This is a synchronous failable function. See [Gio.Global.busGet] and
 * [Gio.Global.busGetFinish] for the asynchronous version.
 * The returned object is a singleton, that is, shared with other
 * callers of [Gio.Global.busGet] and [Gio.Global.busGetSync] for bus_type. In the
 * event that you need a private message bus connection, use
 * [Gio.Global.dbusAddressGetForBusSync] and
 * [Gio.DBusConnection.newForAddress] with
 * G_DBUS_CONNECTION_FLAGS_AUTHENTICATION_CLIENT and
 * G_DBUS_CONNECTION_FLAGS_MESSAGE_BUS_CONNECTION flags.
 * Note that the returned #GDBusConnection object will $(LPAREN)usually$(RPAREN) have
 * the #GDBusConnection:exit-on-close property set to %TRUE.
 * Params:
 *   busType = a #GBusType
 *   cancellable = a #GCancellable or %NULL
 * Returns: a #GDBusConnection or %NULL if error is set.
 *   Free with [GObject.ObjectG.unref].
 */
DBusConnection busGetSync(BusType busType, Cancellable cancellable)
{
  GDBusConnection* _cretval;
  GError *_err;
  _cretval = g_bus_get_sync(busType, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_err);
  if (_err)
    throw new ErrorG(_err);
  auto _retval = _cretval ? ObjectG.getDObject!DBusConnection(cast(GDBusConnection*)_cretval, true) : null;
  return _retval;
}

/**
 * Version of [Gio.Global.busOwnNameOnConnection] using closures instead of
 * callbacks for easier binding in other languages.
 * Params:
 *   connection = a #GDBusConnection
 *   name = the well-known name to own
 *   flags = a set of flags from the #GBusNameOwnerFlags enumeration
 *   nameAcquiredClosure = #GClosure to invoke when name is
 *     acquired or %NULL
 *   nameLostClosure = #GClosure to invoke when name is lost
 *     or %NULL
 * Returns: an identifier $(LPAREN)never 0$(RPAREN) that can be used with
 *   [Gio.Global.busUnownName] to stop owning the name.
 */
uint busOwnNameOnConnection(DBusConnection connection, string name, BusNameOwnerFlags flags, Closure nameAcquiredClosure, Closure nameLostClosure)
{
  uint _retval;
  const(char)* _name = name.toCString(false);
  _retval = g_bus_own_name_on_connection_with_closures(connection ? cast(GDBusConnection*)connection.cPtr(false) : null, _name, flags, nameAcquiredClosure ? cast(GClosure*)nameAcquiredClosure.cPtr(false) : null, nameLostClosure ? cast(GClosure*)nameLostClosure.cPtr(false) : null);
  return _retval;
}

/**
 * Version of [Gio.Global.busOwnName] using closures instead of callbacks for
 * easier binding in other languages.
 * Params:
 *   busType = the type of bus to own a name on
 *   name = the well-known name to own
 *   flags = a set of flags from the #GBusNameOwnerFlags enumeration
 *   busAcquiredClosure = #GClosure to invoke when connected to
 *     the bus of type bus_type or %NULL
 *   nameAcquiredClosure = #GClosure to invoke when name is
 *     acquired or %NULL
 *   nameLostClosure = #GClosure to invoke when name is lost or
 *     %NULL
 * Returns: an identifier $(LPAREN)never 0$(RPAREN) that can be used with
 *   [Gio.Global.busUnownName] to stop owning the name.
 */
uint busOwnName(BusType busType, string name, BusNameOwnerFlags flags, Closure busAcquiredClosure, Closure nameAcquiredClosure, Closure nameLostClosure)
{
  uint _retval;
  const(char)* _name = name.toCString(false);
  _retval = g_bus_own_name_with_closures(busType, _name, flags, busAcquiredClosure ? cast(GClosure*)busAcquiredClosure.cPtr(false) : null, nameAcquiredClosure ? cast(GClosure*)nameAcquiredClosure.cPtr(false) : null, nameLostClosure ? cast(GClosure*)nameLostClosure.cPtr(false) : null);
  return _retval;
}

/**
 * Stops owning a name.
 * Note that there may still be D-Bus traffic to process $(LPAREN)relating to owning
 * and unowning the name$(RPAREN) in the current thread-default #GMainContext after
 * this function has returned. You should continue to iterate the #GMainContext
 * until the #GDestroyNotify function passed to [Gio.Global.busOwnName] is called, in
 * order to avoid memory leaks through callbacks queued on the #GMainContext
 * after it’s stopped being iterated.
 * Params:
 *   ownerId = an identifier obtained from [Gio.Global.busOwnName]
 */
void busUnownName(uint ownerId)
{
  g_bus_unown_name(ownerId);
}

/**
 * Stops watching a name.
 * Note that there may still be D-Bus traffic to process $(LPAREN)relating to watching
 * and unwatching the name$(RPAREN) in the current thread-default #GMainContext after
 * this function has returned. You should continue to iterate the #GMainContext
 * until the #GDestroyNotify function passed to [Gio.Global.busWatchName] is called, in
 * order to avoid memory leaks through callbacks queued on the #GMainContext
 * after it’s stopped being iterated.
 * Params:
 *   watcherId = An identifier obtained from [Gio.Global.busWatchName]
 */
void busUnwatchName(uint watcherId)
{
  g_bus_unwatch_name(watcherId);
}

/**
 * Version of [Gio.Global.busWatchNameOnConnection] using closures instead of callbacks for
 * easier binding in other languages.
 * Params:
 *   connection = A #GDBusConnection.
 *   name = The name $(LPAREN)well-known or unique$(RPAREN) to watch.
 *   flags = Flags from the #GBusNameWatcherFlags enumeration.
 *   nameAppearedClosure = #GClosure to invoke when name is known
 *     to exist or %NULL.
 *   nameVanishedClosure = #GClosure to invoke when name is known
 *     to not exist or %NULL.
 * Returns: An identifier $(LPAREN)never 0$(RPAREN) that can be used with
 *   [Gio.Global.busUnwatchName] to stop watching the name.
 */
uint busWatchNameOnConnection(DBusConnection connection, string name, BusNameWatcherFlags flags, Closure nameAppearedClosure, Closure nameVanishedClosure)
{
  uint _retval;
  const(char)* _name = name.toCString(false);
  _retval = g_bus_watch_name_on_connection_with_closures(connection ? cast(GDBusConnection*)connection.cPtr(false) : null, _name, flags, nameAppearedClosure ? cast(GClosure*)nameAppearedClosure.cPtr(false) : null, nameVanishedClosure ? cast(GClosure*)nameVanishedClosure.cPtr(false) : null);
  return _retval;
}

/**
 * Version of [Gio.Global.busWatchName] using closures instead of callbacks for
 * easier binding in other languages.
 * Params:
 *   busType = The type of bus to watch a name on.
 *   name = The name $(LPAREN)well-known or unique$(RPAREN) to watch.
 *   flags = Flags from the #GBusNameWatcherFlags enumeration.
 *   nameAppearedClosure = #GClosure to invoke when name is known
 *     to exist or %NULL.
 *   nameVanishedClosure = #GClosure to invoke when name is known
 *     to not exist or %NULL.
 * Returns: An identifier $(LPAREN)never 0$(RPAREN) that can be used with
 *   [Gio.Global.busUnwatchName] to stop watching the name.
 */
uint busWatchName(BusType busType, string name, BusNameWatcherFlags flags, Closure nameAppearedClosure, Closure nameVanishedClosure)
{
  uint _retval;
  const(char)* _name = name.toCString(false);
  _retval = g_bus_watch_name_with_closures(busType, _name, flags, nameAppearedClosure ? cast(GClosure*)nameAppearedClosure.cPtr(false) : null, nameVanishedClosure ? cast(GClosure*)nameVanishedClosure.cPtr(false) : null);
  return _retval;
}

/**
 * Checks if a content type can be executable. Note that for instance
 * things like text files can be executables $(LPAREN)i.e. scripts and batch files$(RPAREN).
 * Params:
 *   type = a content type string
 * Returns: %TRUE if the file type corresponds to a type that
 *   can be executable, %FALSE otherwise.
 */
bool contentTypeCanBeExecutable(string type)
{
  bool _retval;
  const(char)* _type = type.toCString(false);
  _retval = g_content_type_can_be_executable(_type);
  return _retval;
}

/**
 * Compares two content types for equality.
 * Params:
 *   type1 = a content type string
 *   type2 = a content type string
 * Returns: %TRUE if the two strings are identical or equivalent,
 *   %FALSE otherwise.
 */
bool contentTypeEquals(string type1, string type2)
{
  bool _retval;
  const(char)* _type1 = type1.toCString(false);
  const(char)* _type2 = type2.toCString(false);
  _retval = g_content_type_equals(_type1, _type2);
  return _retval;
}

/**
 * Tries to find a content type based on the mime type name.
 * Params:
 *   mimeType = a mime type string
 * Returns: Newly allocated string with content type or
 *   %NULL. Free with [GLib.Global.gfree]
 */
string contentTypeFromMimeType(string mimeType)
{
  char* _cretval;
  const(char)* _mimeType = mimeType.toCString(false);
  _cretval = g_content_type_from_mime_type(_mimeType);
  string _retval = _cretval.fromCString(true);
  return _retval;
}

/**
 * Gets the human readable description of the content type.
 * Params:
 *   type = a content type string
 * Returns: a short description of the content type type. Free the
 *   returned string with [GLib.Global.gfree]
 */
string contentTypeGetDescription(string type)
{
  char* _cretval;
  const(char)* _type = type.toCString(false);
  _cretval = g_content_type_get_description(_type);
  string _retval = _cretval.fromCString(true);
  return _retval;
}

/**
 * Gets the generic icon name for a content type.
 * See the
 * [shared-mime-info](http://www.freedesktop.org/wiki/Specifications/shared-mime-info-spec)
 * specification for more on the generic icon name.
 * Params:
 *   type = a content type string
 * Returns: the registered generic icon name for the given type,
 *   or %NULL if unknown. Free with [GLib.Global.gfree]
 */
string contentTypeGetGenericIconName(string type)
{
  char* _cretval;
  const(char)* _type = type.toCString(false);
  _cretval = g_content_type_get_generic_icon_name(_type);
  string _retval = _cretval.fromCString(true);
  return _retval;
}

/**
 * Gets the icon for a content type.
 * Params:
 *   type = a content type string
 * Returns: #GIcon corresponding to the content type. Free the returned
 *   object with [GObject.ObjectG.unref]
 */
Icon contentTypeGetIcon(string type)
{
  GIcon* _cretval;
  const(char)* _type = type.toCString(false);
  _cretval = g_content_type_get_icon(_type);
  auto _retval = _cretval ? ObjectG.getDObject!Icon(cast(GIcon*)_cretval, true) : null;
  return _retval;
}

/**
 * Get the list of directories which MIME data is loaded from. See
 * [Gio.Global.contentTypeSetMimeDirs] for details.
 * Returns: %NULL-terminated list of
 *   directories to load MIME data from, including any `mime/` subdirectory,
 *   and with the first directory to try listed first
 */
string[] contentTypeGetMimeDirs()
{
  const(char*)* _cretval;
  _cretval = g_content_type_get_mime_dirs();
  string[] _retval;

  if (_cretval)
  {
    uint _cretlength;
    for (; _cretval[_cretlength] !is null; _cretlength++)
      break;
    _retval = new string[_cretlength];
    foreach (i; 0 .. _cretlength)
      _retval[i] = _cretval[i].fromCString(false);
  }
  return _retval;
}

/**
 * Gets the mime type for the content type, if one is registered.
 * Params:
 *   type = a content type string
 * Returns: the registered mime type for the
 *   given type, or %NULL if unknown; free with [GLib.Global.gfree].
 */
string contentTypeGetMimeType(string type)
{
  char* _cretval;
  const(char)* _type = type.toCString(false);
  _cretval = g_content_type_get_mime_type(_type);
  string _retval = _cretval.fromCString(true);
  return _retval;
}

/**
 * Gets the symbolic icon for a content type.
 * Params:
 *   type = a content type string
 * Returns: symbolic #GIcon corresponding to the content type.
 *   Free the returned object with [GObject.ObjectG.unref]
 */
Icon contentTypeGetSymbolicIcon(string type)
{
  GIcon* _cretval;
  const(char)* _type = type.toCString(false);
  _cretval = g_content_type_get_symbolic_icon(_type);
  auto _retval = _cretval ? ObjectG.getDObject!Icon(cast(GIcon*)_cretval, true) : null;
  return _retval;
}

/**
 * Guesses the content type based on example data. If the function is
 * uncertain, result_uncertain will be set to %TRUE. Either filename
 * or data may be %NULL, in which case the guess will be based solely
 * on the other argument.
 * Params:
 *   filename = a path, or %NULL
 *   data = a stream of data, or %NULL
 *   resultUncertain = return location for the certainty
 *     of the result, or %NULL
 * Returns: a string indicating a guessed content type for the
 *   given data. Free with [GLib.Global.gfree]
 */
string contentTypeGuess(string filename, ubyte[] data, out bool resultUncertain)
{
  char* _cretval;
  const(char)* _filename = filename.toCString(false);
  size_t _dataSize;
  if (data)
    _dataSize = cast(size_t)data.length;

  auto _data = cast(const(ubyte)*)data.ptr;
  _cretval = g_content_type_guess(_filename, _data, _dataSize, cast(bool*)&resultUncertain);
  string _retval = _cretval.fromCString(true);
  return _retval;
}

/**
 * Tries to guess the type of the tree with root root, by
 * looking at the files it contains. The result is an array
 * of content types, with the best guess coming first.
 * The types returned all have the form x-content/foo, e.g.
 * x-content/audio-cdda $(LPAREN)for audio CDs$(RPAREN) or x-content/image-dcf
 * $(LPAREN)for a camera memory card$(RPAREN). See the
 * [shared-mime-info](http://www.freedesktop.org/wiki/Specifications/shared-mime-info-spec)
 * specification for more on x-content types.
 * This function is useful in the implementation of
 * [Gio.Mount.guessContentType].
 * Params:
 *   root = the root of the tree to guess a type for
 * Returns: an %NULL-terminated
 *   array of zero or more content types. Free with [GLib.Global.strfreev]
 */
string[] contentTypeGuessForTree(File root)
{
  char** _cretval;
  _cretval = g_content_type_guess_for_tree(root ? cast(GFile*)(cast(ObjectG)root).cPtr(false) : null);
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
 * Determines if type is a subset of supertype.
 * Params:
 *   type = a content type string
 *   supertype = a content type string
 * Returns: %TRUE if type is a kind of supertype,
 *   %FALSE otherwise.
 */
bool contentTypeIsA(string type, string supertype)
{
  bool _retval;
  const(char)* _type = type.toCString(false);
  const(char)* _supertype = supertype.toCString(false);
  _retval = g_content_type_is_a(_type, _supertype);
  return _retval;
}

/**
 * Determines if type is a subset of mime_type.
 * Convenience wrapper around [Gio.Global.contentTypeIsA].
 * Params:
 *   type = a content type string
 *   mimeType = a mime type string
 * Returns: %TRUE if type is a kind of mime_type,
 *   %FALSE otherwise.
 */
bool contentTypeIsMimeType(string type, string mimeType)
{
  bool _retval;
  const(char)* _type = type.toCString(false);
  const(char)* _mimeType = mimeType.toCString(false);
  _retval = g_content_type_is_mime_type(_type, _mimeType);
  return _retval;
}

/**
 * Checks if the content type is the generic "unknown" type.
 * On UNIX this is the "application/octet-stream" mimetype,
 * while on win32 it is "*" and on OSX it is a dynamic type
 * or octet-stream.
 * Params:
 *   type = a content type string
 * Returns: %TRUE if the type is the unknown type.
 */
bool contentTypeIsUnknown(string type)
{
  bool _retval;
  const(char)* _type = type.toCString(false);
  _retval = g_content_type_is_unknown(_type);
  return _retval;
}

/**
 * Set the list of directories used by GIO to load the MIME database.
 * If dirs is %NULL, the directories used are the default:
 * - the `mime` subdirectory of the directory in `\$XDG_DATA_HOME`
 * - the `mime` subdirectory of every directory in `\$XDG_DATA_DIRS`
 * This function is intended to be used when writing tests that depend on
 * information stored in the MIME database, in order to control the data.
 * Typically, in case your tests use %G_TEST_OPTION_ISOLATE_DIRS, but they
 * depend on the system’s MIME database, you should call this function
 * with dirs set to %NULL before calling [GLib.Global.testInit], for instance:
 * |[<!-- language\="C" -->
 * // Load MIME data from the system
 * g_content_type_set_mime_dirs $(LPAREN)NULL$(RPAREN);
 * // Isolate the environment
 * g_test_init $(LPAREN)&argc, &argv, G_TEST_OPTION_ISOLATE_DIRS, NULL$(RPAREN);
 * …
 * return g_test_run $(LPAREN)$(RPAREN);
 * ]|
 * Params:
 *   dirs = %NULL-terminated list of
 *     directories to load MIME data from, including any `mime/` subdirectory,
 *     and with the first directory to try listed first
 */
void contentTypeSetMimeDirs(string[] dirs)
{
  char*[] _tmpdirs;
  foreach (s; dirs)
    _tmpdirs ~= s.toCString(false);
  _tmpdirs ~= null;
  const(char*)* _dirs = _tmpdirs.ptr;
  g_content_type_set_mime_dirs(_dirs);
}

/**
 * Gets a list of strings containing all the registered content types
 * known to the system. The list and its data should be freed using
 * `g_list_free_full $(LPAREN)list, g_free$(RPAREN)`.
 * Returns: list of the registered
 *   content types
 */
List!(string) contentTypesGetRegistered()
{
  GList* _cretval;
  _cretval = g_content_types_get_registered();
  List!(string) _retval = new List!(string)(cast(GList*)_cretval, GidOwnership.Full);
  return _retval;
}

/**
 * Escape string so it can appear in a D-Bus address as the value
 * part of a key-value pair.
 * For instance, if string is `/run/bus-for-:0`,
 * this function would return `/run/bus-for-%3A0`,
 * which could be used in a D-Bus address like
 * `unix:nonce-tcp:host\=127.0.0.1,port\=42,noncefile\=/run/bus-for-%3A0`.
 * Params:
 *   string_ = an unescaped string to be included in a D-Bus address
 *     as the value in a key-value pair
 * Returns: a copy of string with all
 *   non-optionally-escaped bytes escaped
 */
string dbusAddressEscapeValue(string string_)
{
  char* _cretval;
  const(char)* _string_ = string_.toCString(false);
  _cretval = g_dbus_address_escape_value(_string_);
  string _retval = _cretval.fromCString(true);
  return _retval;
}

/**
 * Synchronously looks up the D-Bus address for the well-known message
 * bus instance specified by bus_type. This may involve using various
 * platform specific mechanisms.
 * The returned address will be in the
 * [D-Bus address format](https://dbus.freedesktop.org/doc/dbus-specification.html#addresses).
 * Params:
 *   busType = a #GBusType
 *   cancellable = a #GCancellable or %NULL
 * Returns: a valid D-Bus address string for bus_type or
 *   %NULL if error is set
 */
string dbusAddressGetForBusSync(BusType busType, Cancellable cancellable)
{
  char* _cretval;
  GError *_err;
  _cretval = g_dbus_address_get_for_bus_sync(busType, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_err);
  if (_err)
    throw new ErrorG(_err);
  string _retval = _cretval.fromCString(true);
  return _retval;
}

/**
 * Asynchronously connects to an endpoint specified by address and
 * sets up the connection so it is in a state to run the client-side
 * of the D-Bus authentication conversation. address must be in the
 * [D-Bus address format](https://dbus.freedesktop.org/doc/dbus-specification.html#addresses).
 * When the operation is finished, callback will be invoked. You can
 * then call [Gio.Global.dbusAddressGetStreamFinish] to get the result of
 * the operation.
 * This is an asynchronous failable function. See
 * [Gio.Global.dbusAddressGetStreamSync] for the synchronous version.
 * Params:
 *   address = A valid D-Bus address.
 *   cancellable = A #GCancellable or %NULL.
 *   callback = A #GAsyncReadyCallback to call when the request is satisfied.
 */
void dbusAddressGetStream(string address, Cancellable cancellable, AsyncReadyCallback callback)
{
  extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
  {
    ptrThawGC(data);
    auto _dlg = cast(AsyncReadyCallback*)data;

    (*_dlg)(sourceObject ? ObjectG.getDObject!ObjectG(cast(void*)sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(cast(void*)res, false) : null);
  }

  const(char)* _address = address.toCString(false);
  auto _callback = freezeDelegate(cast(void*)&callback);
  g_dbus_address_get_stream(_address, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_callbackCallback, _callback);
}

/**
 * Finishes an operation started with [Gio.Global.dbusAddressGetStream].
 * A server is not required to set a GUID, so out_guid may be set to %NULL
 * even on success.
 * Params:
 *   res = A #GAsyncResult obtained from the GAsyncReadyCallback passed to [Gio.Global.dbusAddressGetStream].
 *   outGuid = %NULL or return location to store the GUID extracted from address, if any.
 * Returns: A #GIOStream or %NULL if error is set.
 */
IOStream dbusAddressGetStreamFinish(AsyncResult res, out string outGuid)
{
  GIOStream* _cretval;
  char* _outGuid;
  GError *_err;
  _cretval = g_dbus_address_get_stream_finish(res ? cast(GAsyncResult*)(cast(ObjectG)res).cPtr(false) : null, &_outGuid, &_err);
  if (_err)
    throw new ErrorG(_err);
  auto _retval = _cretval ? ObjectG.getDObject!IOStream(cast(GIOStream*)_cretval, true) : null;
  outGuid = _outGuid.fromCString(true);
  return _retval;
}

/**
 * Synchronously connects to an endpoint specified by address and
 * sets up the connection so it is in a state to run the client-side
 * of the D-Bus authentication conversation. address must be in the
 * [D-Bus address format](https://dbus.freedesktop.org/doc/dbus-specification.html#addresses).
 * A server is not required to set a GUID, so out_guid may be set to %NULL
 * even on success.
 * This is a synchronous failable function. See
 * [Gio.Global.dbusAddressGetStream] for the asynchronous version.
 * Params:
 *   address = A valid D-Bus address.
 *   outGuid = %NULL or return location to store the GUID extracted from address, if any.
 *   cancellable = A #GCancellable or %NULL.
 * Returns: A #GIOStream or %NULL if error is set.
 */
IOStream dbusAddressGetStreamSync(string address, out string outGuid, Cancellable cancellable)
{
  GIOStream* _cretval;
  const(char)* _address = address.toCString(false);
  char* _outGuid;
  GError *_err;
  _cretval = g_dbus_address_get_stream_sync(_address, &_outGuid, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_err);
  if (_err)
    throw new ErrorG(_err);
  auto _retval = _cretval ? ObjectG.getDObject!IOStream(cast(GIOStream*)_cretval, true) : null;
  outGuid = _outGuid.fromCString(true);
  return _retval;
}

/**
 * This is a language binding friendly version of [Gio.Global.dbusEscapeObjectPathBytestring].
 * Params:
 *   s = the string to escape
 * Returns: an escaped version of s. Free with [GLib.Global.gfree].
 */
string dbusEscapeObjectPath(string s)
{
  char* _cretval;
  const(char)* _s = s.toCString(false);
  _cretval = g_dbus_escape_object_path(_s);
  string _retval = _cretval.fromCString(true);
  return _retval;
}

/**
 * Escapes bytes for use in a D-Bus object path component.
 * bytes is an array of zero or more nonzero bytes in an
 * unspecified encoding, followed by a single zero byte.
 * The escaping method consists of replacing all non-alphanumeric
 * characters $(LPAREN)see g_ascii_isalnum$(LPAREN)$(RPAREN)$(RPAREN) with their hexadecimal value
 * preceded by an underscore $(LPAREN)`_`$(RPAREN). For example:
 * `foo.bar.baz` will become `foo_2ebar_2ebaz`.
 * This method is appropriate to use when the input is nearly
 * a valid object path component but is not when your input
 * is far from being a valid object path component.
 * Other escaping algorithms are also valid to use with
 * D-Bus object paths.
 * This can be reversed with [Gio.Global.dbusUnescapeObjectPath].
 * Params:
 *   bytes = the string of bytes to escape
 * Returns: an escaped version of bytes. Free with [GLib.Global.gfree].
 */
string dbusEscapeObjectPathBytestring(ubyte[] bytes)
{
  char* _cretval;
  auto _bytes = cast(const(ubyte)*)(bytes ~ ubyte.init).ptr;
  _cretval = g_dbus_escape_object_path_bytestring(_bytes);
  string _retval = _cretval.fromCString(true);
  return _retval;
}

/**
 * Generate a D-Bus GUID that can be used with
 * e.g. [Gio.DBusConnection.new_].
 * See the
 * [D-Bus specification](https://dbus.freedesktop.org/doc/dbus-specification.html#uuids)
 * regarding what strings are valid D-Bus GUIDs. The specification refers to
 * these as ‘UUIDs’ whereas GLib $(LPAREN)for historical reasons$(RPAREN) refers to them as
 * ‘GUIDs’. The terms are interchangeable.
 * Note that D-Bus GUIDs do not follow
 * [RFC 4122](https://datatracker.ietf.org/doc/html/rfc4122).
 * Returns: A valid D-Bus GUID. Free with [GLib.Global.gfree].
 */
string dbusGenerateGuid()
{
  char* _cretval;
  _cretval = g_dbus_generate_guid();
  string _retval = _cretval.fromCString(true);
  return _retval;
}

/**
 * Converts a #GValue to a #GVariant of the type indicated by the type
 * parameter.
 * The conversion is using the following rules:
 * - `G_TYPE_STRING`: 's', 'o', 'g' or 'ay'
 * - `G_TYPE_STRV`: 'as', 'ao' or 'aay'
 * - `G_TYPE_BOOLEAN`: 'b'
 * - `G_TYPE_UCHAR`: 'y'
 * - `G_TYPE_INT`: 'i', 'n'
 * - `G_TYPE_UINT`: 'u', 'q'
 * - `G_TYPE_INT64`: 'x'
 * - `G_TYPE_UINT64`: 't'
 * - `G_TYPE_DOUBLE`: 'd'
 * - `G_TYPE_VARIANT`: Any #GVariantType
 * This can fail if e.g. gvalue is of type %G_TYPE_STRING and type
 * is 'i', i.e. %G_VARIANT_TYPE_INT32. It will also fail for any #GType
 * $(LPAREN)including e.g. %G_TYPE_OBJECT and %G_TYPE_BOXED derived-types$(RPAREN) not
 * in the table above.
 * Note that if gvalue is of type %G_TYPE_VARIANT and its value is
 * %NULL, the empty #GVariant instance $(LPAREN)never %NULL$(RPAREN) for type is
 * returned $(LPAREN)e.g. 0 for scalar types, the empty string for string types,
 * '/' for object path types, the empty array for any array type and so on$(RPAREN).
 * See the [Gio.Global.dbusGvariantToGvalue] function for how to convert a
 * #GVariant to a #GValue.
 * Params:
 *   gvalue = A #GValue to convert to a #GVariant
 *   type = A #GVariantType
 * Returns: A #GVariant $(LPAREN)never floating$(RPAREN) of
 *   #GVariantType type holding the data from gvalue or an empty #GVariant
 *   in case of failure. Free with [GLib.Variant.unref].
 */
Variant dbusGvalueToGvariant(Value gvalue, VariantType type)
{
  GVariant* _cretval;
  _cretval = g_dbus_gvalue_to_gvariant(gvalue ? cast(GValue*)gvalue.cPtr(false) : null, type ? cast(GVariantType*)type.cPtr(false) : null);
  auto _retval = _cretval ? new Variant(cast(GVariant*)_cretval, true) : null;
  return _retval;
}

/**
 * Converts a #GVariant to a #GValue. If value is floating, it is consumed.
 * The rules specified in the [Gio.Global.dbusGvalueToGvariant] function are
 * used - this function is essentially its reverse form. So, a #GVariant
 * containing any basic or string array type will be converted to a #GValue
 * containing a basic value or string array. Any other #GVariant $(LPAREN)handle,
 * variant, tuple, dict entry$(RPAREN) will be converted to a #GValue containing that
 * #GVariant.
 * The conversion never fails - a valid #GValue is always returned in
 * out_gvalue.
 * Params:
 *   value = A #GVariant.
 *   outGvalue = Return location pointing to a zero-filled $(LPAREN)uninitialized$(RPAREN) #GValue.
 */
void dbusGvariantToGvalue(Variant value, out Value outGvalue)
{
  GValue _outGvalue;
  g_dbus_gvariant_to_gvalue(value ? cast(GVariant*)value.cPtr(false) : null, &_outGvalue);
  outGvalue = new Value(cast(void*)&_outGvalue, false);
}

/**
 * Checks if string is a
 * [D-Bus address](https://dbus.freedesktop.org/doc/dbus-specification.html#addresses).
 * This doesn't check if string is actually supported by #GDBusServer
 * or #GDBusConnection - use [Gio.Global.dbusIsSupportedAddress] to do more
 * checks.
 * Params:
 *   string_ = A string.
 * Returns: %TRUE if string is a valid D-Bus address, %FALSE otherwise.
 */
bool dbusIsAddress(string string_)
{
  bool _retval;
  const(char)* _string_ = string_.toCString(false);
  _retval = g_dbus_is_address(_string_);
  return _retval;
}

/**
 * Check whether string is a valid D-Bus error name.
 * This function returns the same result as [Gio.Global.dbusIsInterfaceName],
 * because D-Bus error names are defined to have exactly the
 * same syntax as interface names.
 * Params:
 *   string_ = The string to check.
 * Returns: %TRUE if valid, %FALSE otherwise.
 */
bool dbusIsErrorName(string string_)
{
  bool _retval;
  const(char)* _string_ = string_.toCString(false);
  _retval = g_dbus_is_error_name(_string_);
  return _retval;
}

/**
 * Checks if string is a D-Bus GUID.
 * See the documentation for [Gio.Global.dbusGenerateGuid] for more information about
 * the format of a GUID.
 * Params:
 *   string_ = The string to check.
 * Returns: %TRUE if string is a GUID, %FALSE otherwise.
 */
bool dbusIsGuid(string string_)
{
  bool _retval;
  const(char)* _string_ = string_.toCString(false);
  _retval = g_dbus_is_guid(_string_);
  return _retval;
}

/**
 * Checks if string is a valid D-Bus interface name.
 * Params:
 *   string_ = The string to check.
 * Returns: %TRUE if valid, %FALSE otherwise.
 */
bool dbusIsInterfaceName(string string_)
{
  bool _retval;
  const(char)* _string_ = string_.toCString(false);
  _retval = g_dbus_is_interface_name(_string_);
  return _retval;
}

/**
 * Checks if string is a valid D-Bus member $(LPAREN)e.g. signal or method$(RPAREN) name.
 * Params:
 *   string_ = The string to check.
 * Returns: %TRUE if valid, %FALSE otherwise.
 */
bool dbusIsMemberName(string string_)
{
  bool _retval;
  const(char)* _string_ = string_.toCString(false);
  _retval = g_dbus_is_member_name(_string_);
  return _retval;
}

/**
 * Checks if string is a valid D-Bus bus name $(LPAREN)either unique or well-known$(RPAREN).
 * Params:
 *   string_ = The string to check.
 * Returns: %TRUE if valid, %FALSE otherwise.
 */
bool dbusIsName(string string_)
{
  bool _retval;
  const(char)* _string_ = string_.toCString(false);
  _retval = g_dbus_is_name(_string_);
  return _retval;
}

/**
 * Like [Gio.Global.dbusIsAddress] but also checks if the library supports the
 * transports in string and that key/value pairs for each transport
 * are valid. See the specification of the
 * [D-Bus address format](https://dbus.freedesktop.org/doc/dbus-specification.html#addresses).
 * Params:
 *   string_ = A string.
 * Returns: %TRUE if string is a valid D-Bus address that is
 *   supported by this library, %FALSE if error is set.
 */
bool dbusIsSupportedAddress(string string_)
{
  bool _retval;
  const(char)* _string_ = string_.toCString(false);
  GError *_err;
  _retval = g_dbus_is_supported_address(_string_, &_err);
  if (_err)
    throw new ErrorG(_err);
  return _retval;
}

/**
 * Checks if string is a valid D-Bus unique bus name.
 * Params:
 *   string_ = The string to check.
 * Returns: %TRUE if valid, %FALSE otherwise.
 */
bool dbusIsUniqueName(string string_)
{
  bool _retval;
  const(char)* _string_ = string_.toCString(false);
  _retval = g_dbus_is_unique_name(_string_);
  return _retval;
}

/**
 * Unescapes an string that was previously escaped with
 * [Gio.Global.dbusEscapeObjectPath]. If the string is in a format that could
 * not have been returned by [Gio.Global.dbusEscapeObjectPath], this function
 * returns %NULL.
 * Encoding alphanumeric characters which do not need to be
 * encoded is not allowed $(LPAREN)e.g `_63` is not valid, the string
 * should contain `c` instead$(RPAREN).
 * Params:
 *   s = the string to unescape
 * Returns: an
 *   unescaped version of s, or %NULL if s is not a string returned
 *   from [Gio.Global.dbusEscapeObjectPath]. Free with [GLib.Global.gfree].
 */
ubyte[] dbusUnescapeObjectPath(string s)
{
  ubyte* _cretval;
  const(char)* _s = s.toCString(false);
  _cretval = g_dbus_unescape_object_path(_s);
  ubyte[] _retval;

  if (_cretval)
  {
    uint _cretlength;
    for (; _cretval[_cretlength] != 0; _cretlength++)
      break;
    _retval = cast(ubyte[] )_cretval[0 .. _cretlength];
  }
  return _retval;
}

/**
 * Converts `errno.h` error codes into GIO error codes.
 * The fallback value %G_IO_ERROR_FAILED is returned for error codes not
 * currently handled $(LPAREN)but note that future GLib releases may return a more
 * specific value instead$(RPAREN).
 * As `errno` is global and may be modified by intermediate function
 * calls, you should save its value immediately after the call returns,
 * and use the saved value instead of `errno`:
 * |[<!-- language\="C" -->
 * int saved_errno;
 * ret \= read $(LPAREN)blah$(RPAREN);
 * saved_errno \= errno;
 * g_io_error_from_errno $(LPAREN)saved_errno$(RPAREN);
 * ]|
 * Params:
 *   errNo = Error number as defined in errno.h.
 * Returns: #GIOErrorEnum value for the given `errno.h` error number
 */
IOErrorEnum ioErrorFromErrno(int errNo)
{
  GIOErrorEnum _cretval;
  _cretval = g_io_error_from_errno(errNo);
  IOErrorEnum _retval = cast(IOErrorEnum)_cretval;
  return _retval;
}

/**
 * Converts #GFileError error codes into GIO error codes.
 * Params:
 *   fileError = a #GFileError.
 * Returns: #GIOErrorEnum value for the given #GFileError error value.
 */
IOErrorEnum ioErrorFromFileError(FileError fileError)
{
  GIOErrorEnum _cretval;
  _cretval = g_io_error_from_file_error(fileError);
  IOErrorEnum _retval = cast(IOErrorEnum)_cretval;
  return _retval;
}

/**
 * Gets the GIO Error Quark.
 * Returns: a #GQuark.
 */
Quark ioErrorQuark()
{
  Quark _retval;
  _retval = g_io_error_quark();
  return _retval;
}

/**
 * Loads all the modules in the specified directory.
 * If don't require all modules to be initialized $(LPAREN)and thus registering
 * all gtypes$(RPAREN) then you can use [Gio.Global.ioModulesScanAllInDirectory]
 * which allows delayed/lazy loading of modules.
 * Params:
 *   dirname = pathname for a directory containing modules
 *     to load.
 * Returns: a list of #GIOModules loaded
 *   from the directory,
 *   All the modules are loaded into memory, if you want to
 *   unload them $(LPAREN)enabling on-demand loading$(RPAREN) you must call
 *   [GObject.TypeModule.unuse] on all the modules. Free the list
 *   with [GLib.List.free].
 */
List!(IOModule) ioModulesLoadAllInDirectory(string dirname)
{
  GList* _cretval;
  const(char)* _dirname = dirname.toCString(false);
  _cretval = g_io_modules_load_all_in_directory(_dirname);
  List!(IOModule) _retval = new List!(IOModule)(cast(GList*)_cretval, GidOwnership.Full);
  return _retval;
}

/**
 * Loads all the modules in the specified directory.
 * If don't require all modules to be initialized $(LPAREN)and thus registering
 * all gtypes$(RPAREN) then you can use [Gio.Global.ioModulesScanAllInDirectory]
 * which allows delayed/lazy loading of modules.
 * Params:
 *   dirname = pathname for a directory containing modules
 *     to load.
 *   scope_ = a scope to use when scanning the modules.
 * Returns: a list of #GIOModules loaded
 *   from the directory,
 *   All the modules are loaded into memory, if you want to
 *   unload them $(LPAREN)enabling on-demand loading$(RPAREN) you must call
 *   [GObject.TypeModule.unuse] on all the modules. Free the list
 *   with [GLib.List.free].
 */
List!(IOModule) ioModulesLoadAllInDirectoryWithScope(string dirname, IOModuleScope scope_)
{
  GList* _cretval;
  const(char)* _dirname = dirname.toCString(false);
  _cretval = g_io_modules_load_all_in_directory_with_scope(_dirname, scope_ ? cast(GIOModuleScope*)scope_.cPtr : null);
  List!(IOModule) _retval = new List!(IOModule)(cast(GList*)_cretval, GidOwnership.Full);
  return _retval;
}

/**
 * Scans all the modules in the specified directory, ensuring that
 * any extension point implemented by a module is registered.
 * This may not actually load and initialize all the types in each
 * module, some modules may be lazily loaded and initialized when
 * an extension point it implements is used with e.g.
 * [Gio.IOExtensionPoint.getExtensions] or
 * [Gio.IOExtensionPoint.getExtensionByName].
 * If you need to guarantee that all types are loaded in all the modules,
 * use [Gio.Global.ioModulesLoadAllInDirectory].
 * Params:
 *   dirname = pathname for a directory containing modules
 *     to scan.
 */
void ioModulesScanAllInDirectory(string dirname)
{
  const(char)* _dirname = dirname.toCString(false);
  g_io_modules_scan_all_in_directory(_dirname);
}

/**
 * Scans all the modules in the specified directory, ensuring that
 * any extension point implemented by a module is registered.
 * This may not actually load and initialize all the types in each
 * module, some modules may be lazily loaded and initialized when
 * an extension point it implements is used with e.g.
 * [Gio.IOExtensionPoint.getExtensions] or
 * [Gio.IOExtensionPoint.getExtensionByName].
 * If you need to guarantee that all types are loaded in all the modules,
 * use [Gio.Global.ioModulesLoadAllInDirectory].
 * Params:
 *   dirname = pathname for a directory containing modules
 *     to scan.
 *   scope_ = a scope to use when scanning the modules
 */
void ioModulesScanAllInDirectoryWithScope(string dirname, IOModuleScope scope_)
{
  const(char)* _dirname = dirname.toCString(false);
  g_io_modules_scan_all_in_directory_with_scope(_dirname, scope_ ? cast(GIOModuleScope*)scope_.cPtr : null);
}

/**
 * Cancels all cancellable I/O jobs.
 * A job is cancellable if a #GCancellable was passed into
 * [Gio.Global.ioSchedulerPushJob].

 * Deprecated: You should never call this function, since you don't
 *   know how other libraries in your program might be making use of
 *   gioscheduler.
 */
void ioSchedulerCancelAllJobs()
{
  g_io_scheduler_cancel_all_jobs();
}

/**
 * Schedules the I/O job to run in another thread.
 * notify will be called on user_data after job_func has returned,
 * regardless whether the job was cancelled or has run to completion.
 * If cancellable is not %NULL, it can be used to cancel the I/O job
 * by calling [Gio.Cancellable.cancel] or by calling
 * [Gio.Global.ioSchedulerCancelAllJobs].
 * Params:
 *   jobFunc = a #GIOSchedulerJobFunc.
 *   ioPriority = the [I/O priority][io-priority]
 *     of the request.
 *   cancellable = optional #GCancellable object, %NULL to ignore.

 * Deprecated: use #GThreadPool or [Gio.Task.runInThread]
 */
void ioSchedulerPushJob(IOSchedulerJobFunc jobFunc, int ioPriority, Cancellable cancellable)
{
  extern(C) bool _jobFuncCallback(GIOSchedulerJob* job, GCancellable* cancellable, void* data)
  {
    auto _dlg = cast(IOSchedulerJobFunc*)data;

    bool _retval = (*_dlg)(job ? new IOSchedulerJob(cast(void*)job, false) : null, cancellable ? ObjectG.getDObject!Cancellable(cast(void*)cancellable, false) : null);
    return _retval;
  }

  auto _jobFunc = freezeDelegate(cast(void*)&jobFunc);
  g_io_scheduler_push_job(&_jobFuncCallback, _jobFunc, &thawDelegate, ioPriority, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null);
}

/**
 * Creates a keyfile-backed #GSettingsBackend.
 * The filename of the keyfile to use is given by filename.
 * All settings read to or written from the backend must fall under the
 * path given in root_path $(LPAREN)which must start and end with a slash and
 * not contain two consecutive slashes$(RPAREN).  root_path may be "/".
 * If root_group is non-%NULL then it specifies the name of the keyfile
 * group used for keys that are written directly below root_path.  For
 * example, if root_path is "/apps/example/" and root_group is
 * "toplevel", then settings the key "/apps/example/enabled" to a value
 * of %TRUE will cause the following to appear in the keyfile:
 * |[
 * [toplevel]
 * enabled\=true
 * ]|
 * If root_group is %NULL then it is not permitted to store keys
 * directly below the root_path.
 * For keys not stored directly below root_path $(LPAREN)ie: in a sub-path$(RPAREN),
 * the name of the subpath $(LPAREN)with the final slash stripped$(RPAREN) is used as
 * the name of the keyfile group.  To continue the example, if
 * "/apps/example/profiles/default/font-size" were set to
 * 12 then the following would appear in the keyfile:
 * |[
 * [profiles/default]
 * font-size\=12
 * ]|
 * The backend will refuse writes $(LPAREN)and return writability as being
 * %FALSE$(RPAREN) for keys outside of root_path and, in the event that
 * root_group is %NULL, also for keys directly under root_path.
 * Writes will also be refused if the backend detects that it has the
 * inability to rewrite the keyfile $(LPAREN)ie: the containing directory is not
 * writable$(RPAREN).
 * There is no checking done for your key namespace clashing with the
 * syntax of the key file format.  For example, if you have '[' or ']'
 * characters in your path names or '\=' in your key names you may be in
 * trouble.
 * The backend reads default values from a keyfile called `defaults` in
 * the directory specified by the #GKeyfileSettingsBackend:defaults-dir property,
 * and a list of locked keys from a text file with the name `locks` in
 * the same location.
 * Params:
 *   filename = the filename of the keyfile
 *   rootPath = the path under which all settings keys appear
 *   rootGroup = the group name corresponding to
 *     root_path, or %NULL
 * Returns: a keyfile-backed #GSettingsBackend
 */
SettingsBackend keyfileSettingsBackendNew(string filename, string rootPath, string rootGroup)
{
  GSettingsBackend* _cretval;
  const(char)* _filename = filename.toCString(false);
  const(char)* _rootPath = rootPath.toCString(false);
  const(char)* _rootGroup = rootGroup.toCString(false);
  _cretval = g_keyfile_settings_backend_new(_filename, _rootPath, _rootGroup);
  auto _retval = _cretval ? ObjectG.getDObject!SettingsBackend(cast(GSettingsBackend*)_cretval, true) : null;
  return _retval;
}

/**
 * Creates a memory-backed #GSettingsBackend.
 * This backend allows changes to settings, but does not write them
 * to any backing storage, so the next time you run your application,
 * the memory backend will start out with the default values again.
 * Returns: a newly created #GSettingsBackend
 */
SettingsBackend memorySettingsBackendNew()
{
  GSettingsBackend* _cretval;
  _cretval = g_memory_settings_backend_new();
  auto _retval = _cretval ? ObjectG.getDObject!SettingsBackend(cast(GSettingsBackend*)_cretval, true) : null;
  return _retval;
}

/**
 * Initializes the platform networking libraries $(LPAREN)eg, on Windows, this
 * calls WSAStartup$(LPAREN)$(RPAREN)$(RPAREN). GLib will call this itself if it is needed, so
 * you only need to call it if you directly call system networking
 * functions $(LPAREN)without calling any GLib networking functions first$(RPAREN).
 */
void networkingInit()
{
  g_networking_init();
}

/**
 * Creates a readonly #GSettingsBackend.
 * This backend does not allow changes to settings, so all settings
 * will always have their default values.
 * Returns: a newly created #GSettingsBackend
 */
SettingsBackend nullSettingsBackendNew()
{
  GSettingsBackend* _cretval;
  _cretval = g_null_settings_backend_new();
  auto _retval = _cretval ? ObjectG.getDObject!SettingsBackend(cast(GSettingsBackend*)_cretval, true) : null;
  return _retval;
}

/**
 * Utility method for #GPollableInputStream and #GPollableOutputStream
 * implementations. Creates a new #GSource that expects a callback of
 * type #GPollableSourceFunc. The new source does not actually do
 * anything on its own; use [GLib.Source.addChildSource] to add other
 * sources to it to cause it to trigger.
 * Params:
 *   pollableStream = the stream associated with the new source
 * Returns: the new #GSource.
 */
Source pollableSourceNew(ObjectG pollableStream)
{
  GSource* _cretval;
  _cretval = g_pollable_source_new(pollableStream ? cast(ObjectC*)pollableStream.cPtr(false) : null);
  auto _retval = _cretval ? new Source(cast(void*)_cretval, true) : null;
  return _retval;
}

/**
 * Utility method for #GPollableInputStream and #GPollableOutputStream
 * implementations. Creates a new #GSource, as with
 * [Gio.Global.pollableSourceNew], but also attaching child_source $(LPAREN)with a
 * dummy callback$(RPAREN), and cancellable, if they are non-%NULL.
 * Params:
 *   pollableStream = the stream associated with the
 *     new source
 *   childSource = optional child source to attach
 *   cancellable = optional #GCancellable to attach
 * Returns: the new #GSource.
 */
Source pollableSourceNewFull(ObjectG pollableStream, Source childSource, Cancellable cancellable)
{
  GSource* _cretval;
  _cretval = g_pollable_source_new_full(pollableStream ? cast(ObjectC*)pollableStream.cPtr(false) : null, childSource ? cast(GSource*)childSource.cPtr(false) : null, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null);
  auto _retval = _cretval ? new Source(cast(void*)_cretval, true) : null;
  return _retval;
}

/**
 * Tries to read from stream, as with [Gio.InputStream.read] $(LPAREN)if
 * blocking is %TRUE$(RPAREN) or [Gio.PollableInputStream.readNonblocking]
 * $(LPAREN)if blocking is %FALSE$(RPAREN). This can be used to more easily share
 * code between blocking and non-blocking implementations of a method.
 * If blocking is %FALSE, then stream must be a
 * #GPollableInputStream for which [Gio.PollableInputStream.canPoll]
 * returns %TRUE, or else the behavior is undefined. If blocking is
 * %TRUE, then stream does not need to be a #GPollableInputStream.
 * Params:
 *   stream = a #GInputStream
 *   buffer = a buffer to
 *     read data into
 *   blocking = whether to do blocking I/O
 *   cancellable = optional #GCancellable object, %NULL to ignore.
 * Returns: the number of bytes read, or -1 on error.
 */
ptrdiff_t pollableStreamRead(InputStream stream, ubyte[] buffer, bool blocking, Cancellable cancellable)
{
  ptrdiff_t _retval;
  size_t _count;
  if (buffer)
    _count = cast(size_t)buffer.length;

  auto _buffer = cast(void*)buffer.ptr;
  GError *_err;
  _retval = g_pollable_stream_read(stream ? cast(GInputStream*)stream.cPtr(false) : null, _buffer, _count, blocking, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_err);
  if (_err)
    throw new ErrorG(_err);
  return _retval;
}

/**
 * Tries to write to stream, as with [Gio.OutputStream.write] $(LPAREN)if
 * blocking is %TRUE$(RPAREN) or [Gio.PollableOutputStream.writeNonblocking]
 * $(LPAREN)if blocking is %FALSE$(RPAREN). This can be used to more easily share
 * code between blocking and non-blocking implementations of a method.
 * If blocking is %FALSE, then stream must be a
 * #GPollableOutputStream for which
 * [Gio.PollableOutputStream.canPoll] returns %TRUE or else the
 * behavior is undefined. If blocking is %TRUE, then stream does not
 * need to be a #GPollableOutputStream.
 * Params:
 *   stream = a #GOutputStream.
 *   buffer = the buffer
 *     containing the data to write.
 *   blocking = whether to do blocking I/O
 *   cancellable = optional #GCancellable object, %NULL to ignore.
 * Returns: the number of bytes written, or -1 on error.
 */
ptrdiff_t pollableStreamWrite(OutputStream stream, ubyte[] buffer, bool blocking, Cancellable cancellable)
{
  ptrdiff_t _retval;
  size_t _count;
  if (buffer)
    _count = cast(size_t)buffer.length;

  auto _buffer = cast(void*)buffer.ptr;
  GError *_err;
  _retval = g_pollable_stream_write(stream ? cast(GOutputStream*)stream.cPtr(false) : null, _buffer, _count, blocking, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_err);
  if (_err)
    throw new ErrorG(_err);
  return _retval;
}

/**
 * Tries to write count bytes to stream, as with
 * [Gio.OutputStream.writeAll], but using [Gio.Global.pollableStreamWrite]
 * rather than [Gio.OutputStream.write].
 * On a successful write of count bytes, %TRUE is returned, and
 * bytes_written is set to count.
 * If there is an error during the operation $(LPAREN)including
 * %G_IO_ERROR_WOULD_BLOCK in the non-blocking case$(RPAREN), %FALSE is
 * returned and error is set to indicate the error status,
 * bytes_written is updated to contain the number of bytes written
 * into the stream before the error occurred.
 * As with [Gio.Global.pollableStreamWrite], if blocking is %FALSE, then
 * stream must be a #GPollableOutputStream for which
 * [Gio.PollableOutputStream.canPoll] returns %TRUE or else the
 * behavior is undefined. If blocking is %TRUE, then stream does not
 * need to be a #GPollableOutputStream.
 * Params:
 *   stream = a #GOutputStream.
 *   buffer = the buffer
 *     containing the data to write.
 *   blocking = whether to do blocking I/O
 *   bytesWritten = location to store the number of bytes that was
 *     written to the stream
 *   cancellable = optional #GCancellable object, %NULL to ignore.
 * Returns: %TRUE on success, %FALSE if there was an error
 */
bool pollableStreamWriteAll(OutputStream stream, ubyte[] buffer, bool blocking, out size_t bytesWritten, Cancellable cancellable)
{
  bool _retval;
  size_t _count;
  if (buffer)
    _count = cast(size_t)buffer.length;

  auto _buffer = cast(void*)buffer.ptr;
  GError *_err;
  _retval = g_pollable_stream_write_all(stream ? cast(GOutputStream*)stream.cPtr(false) : null, _buffer, _count, blocking, cast(size_t*)&bytesWritten, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_err);
  if (_err)
    throw new ErrorG(_err);
  return _retval;
}

/**
 * Returns all the names of children at the specified path in the set of
 * globally registered resources.
 * The return result is a %NULL terminated list of strings which should
 * be released with [GLib.Global.strfreev].
 * lookup_flags controls the behaviour of the lookup.
 * Params:
 *   path = A pathname inside the resource
 *   lookupFlags = A #GResourceLookupFlags
 * Returns: an array of constant strings
 */
string[] resourcesEnumerateChildren(string path, ResourceLookupFlags lookupFlags)
{
  char** _cretval;
  const(char)* _path = path.toCString(false);
  GError *_err;
  _cretval = g_resources_enumerate_children(_path, lookupFlags, &_err);
  if (_err)
    throw new ErrorG(_err);
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
 * Looks for a file at the specified path in the set of
 * globally registered resources and if found returns information about it.
 * lookup_flags controls the behaviour of the lookup.
 * Params:
 *   path = A pathname inside the resource
 *   lookupFlags = A #GResourceLookupFlags
 *   size = a location to place the length of the contents of the file,
 *     or %NULL if the length is not needed
 *   flags = a location to place the #GResourceFlags about the file,
 *     or %NULL if the flags are not needed
 * Returns: %TRUE if the file was found. %FALSE if there were errors
 */
bool resourcesGetInfo(string path, ResourceLookupFlags lookupFlags, out size_t size, out uint flags)
{
  bool _retval;
  const(char)* _path = path.toCString(false);
  GError *_err;
  _retval = g_resources_get_info(_path, lookupFlags, cast(size_t*)&size, cast(uint*)&flags, &_err);
  if (_err)
    throw new ErrorG(_err);
  return _retval;
}

/**
 * Looks for a file at the specified path in the set of
 * globally registered resources and returns a #GBytes that
 * lets you directly access the data in memory.
 * The data is always followed by a zero byte, so you
 * can safely use the data as a C string. However, that byte
 * is not included in the size of the GBytes.
 * For uncompressed resource files this is a pointer directly into
 * the resource bundle, which is typically in some readonly data section
 * in the program binary. For compressed files we allocate memory on
 * the heap and automatically uncompress the data.
 * lookup_flags controls the behaviour of the lookup.
 * Params:
 *   path = A pathname inside the resource
 *   lookupFlags = A #GResourceLookupFlags
 * Returns: #GBytes or %NULL on error.
 *   Free the returned object with [GLib.Bytes.unref]
 */
Bytes resourcesLookupData(string path, ResourceLookupFlags lookupFlags)
{
  GBytes* _cretval;
  const(char)* _path = path.toCString(false);
  GError *_err;
  _cretval = g_resources_lookup_data(_path, lookupFlags, &_err);
  if (_err)
    throw new ErrorG(_err);
  auto _retval = _cretval ? new Bytes(cast(void*)_cretval, true) : null;
  return _retval;
}

/**
 * Looks for a file at the specified path in the set of
 * globally registered resources and returns a #GInputStream
 * that lets you read the data.
 * lookup_flags controls the behaviour of the lookup.
 * Params:
 *   path = A pathname inside the resource
 *   lookupFlags = A #GResourceLookupFlags
 * Returns: #GInputStream or %NULL on error.
 *   Free the returned object with [GObject.ObjectG.unref]
 */
InputStream resourcesOpenStream(string path, ResourceLookupFlags lookupFlags)
{
  GInputStream* _cretval;
  const(char)* _path = path.toCString(false);
  GError *_err;
  _cretval = g_resources_open_stream(_path, lookupFlags, &_err);
  if (_err)
    throw new ErrorG(_err);
  auto _retval = _cretval ? ObjectG.getDObject!InputStream(cast(GInputStream*)_cretval, true) : null;
  return _retval;
}

/**
 * Registers the resource with the process-global set of resources.
 * Once a resource is registered the files in it can be accessed
 * with the global resource lookup functions like [Gio.Global.resourcesLookupData].
 * Params:
 *   resource = A #GResource
 */
void resourcesRegister(Resource resource)
{
  g_resources_register(resource ? cast(GResource*)resource.cPtr(false) : null);
}

/**
 * Unregisters the resource from the process-global set of resources.
 * Params:
 *   resource = A #GResource
 */
void resourcesUnregister(Resource resource)
{
  g_resources_unregister(resource ? cast(GResource*)resource.cPtr(false) : null);
}

/**
 * Reports an error in an idle function. Similar to
 * [Gio.Global.simpleAsyncReportErrorInIdle], but takes a #GError rather
 * than building a new one.
 * Params:
 *   object = a #GObject, or %NULL
 *   callback = a #GAsyncReadyCallback.
 *   error = the #GError to report

 * Deprecated: Use [Gio.Task.reportError].
 */
void simpleAsyncReportGerrorInIdle(ObjectG object, AsyncReadyCallback callback, ErrorG error)
{
  extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
  {
    ptrThawGC(data);
    auto _dlg = cast(AsyncReadyCallback*)data;

    (*_dlg)(sourceObject ? ObjectG.getDObject!ObjectG(cast(void*)sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(cast(void*)res, false) : null);
  }

  auto _callback = freezeDelegate(cast(void*)&callback);
  g_simple_async_report_gerror_in_idle(object ? cast(ObjectC*)object.cPtr(false) : null, &_callbackCallback, _callback, error ? cast(GError*)error.cPtr : null);
}

/**
 * Determines if mount_path is considered an implementation of the
 * OS. This is primarily used for hiding mountable and mounted volumes
 * that only are used in the OS and has little to no relevance to the
 * casual user.
 * Params:
 *   mountPath = a mount path, e.g. `/media/disk` or `/usr`
 * Returns: %TRUE if mount_path is considered an implementation detail
 *   of the OS.
 */
bool unixIsMountPathSystemInternal(string mountPath)
{
  bool _retval;
  const(char)* _mountPath = mountPath.toCString(false);
  _retval = g_unix_is_mount_path_system_internal(_mountPath);
  return _retval;
}

/**
 * Determines if device_path is considered a block device path which is only
 * used in implementation of the OS. This is primarily used for hiding
 * mounted volumes that are intended as APIs for programs to read, and system
 * administrators at a shell; rather than something that should, for example,
 * appear in a GUI. For example, the Linux `/proc` filesystem.
 * The list of device paths considered ‘system’ ones may change over time.
 * Params:
 *   devicePath = a device path, e.g. `/dev/loop0` or `nfsd`
 * Returns: %TRUE if device_path is considered an implementation detail of
 *   the OS.
 */
bool unixIsSystemDevicePath(string devicePath)
{
  bool _retval;
  const(char)* _devicePath = devicePath.toCString(false);
  _retval = g_unix_is_system_device_path(_devicePath);
  return _retval;
}

/**
 * Determines if fs_type is considered a type of file system which is only
 * used in implementation of the OS. This is primarily used for hiding
 * mounted volumes that are intended as APIs for programs to read, and system
 * administrators at a shell; rather than something that should, for example,
 * appear in a GUI. For example, the Linux `/proc` filesystem.
 * The list of file system types considered ‘system’ ones may change over time.
 * Params:
 *   fsType = a file system type, e.g. `procfs` or `tmpfs`
 * Returns: %TRUE if fs_type is considered an implementation detail of the OS.
 */
bool unixIsSystemFsType(string fsType)
{
  bool _retval;
  const(char)* _fsType = fsType.toCString(false);
  _retval = g_unix_is_system_fs_type(_fsType);
  return _retval;
}

/**
 * Gets a #GUnixMountEntry for a given mount path. If time_read
 * is set, it will be filled with a unix timestamp for checking
 * if the mounts have changed since with [Gio.Global.unixMountsChangedSince].
 * If more mounts have the same mount path, the last matching mount
 * is returned.
 * This will return %NULL if there is no mount point at mount_path.
 * Params:
 *   mountPath = path for a possible unix mount.
 *   timeRead = guint64 to contain a timestamp.
 * Returns: a #GUnixMountEntry.
 */
UnixMountEntry unixMountAt(string mountPath, out ulong timeRead)
{
  GUnixMountEntry* _cretval;
  const(char)* _mountPath = mountPath.toCString(false);
  _cretval = g_unix_mount_at(_mountPath, cast(ulong*)&timeRead);
  auto _retval = _cretval ? new UnixMountEntry(cast(void*)_cretval, true) : null;
  return _retval;
}

/**
 * Compares two unix mounts.
 * Params:
 *   mount1 = first #GUnixMountEntry to compare.
 *   mount2 = second #GUnixMountEntry to compare.
 * Returns: 1, 0 or -1 if mount1 is greater than, equal to,
 *   or less than mount2, respectively.
 */
int unixMountCompare(UnixMountEntry mount1, UnixMountEntry mount2)
{
  int _retval;
  _retval = g_unix_mount_compare(mount1 ? cast(GUnixMountEntry*)mount1.cPtr(false) : null, mount2 ? cast(GUnixMountEntry*)mount2.cPtr(false) : null);
  return _retval;
}

/**
 * Makes a copy of mount_entry.
 * Params:
 *   mountEntry = a #GUnixMountEntry.
 * Returns: a new #GUnixMountEntry
 */
UnixMountEntry unixMountCopy(UnixMountEntry mountEntry)
{
  GUnixMountEntry* _cretval;
  _cretval = g_unix_mount_copy(mountEntry ? cast(GUnixMountEntry*)mountEntry.cPtr(false) : null);
  auto _retval = _cretval ? new UnixMountEntry(cast(void*)_cretval, true) : null;
  return _retval;
}

/**
 * Gets a #GUnixMountEntry for a given file path. If time_read
 * is set, it will be filled with a unix timestamp for checking
 * if the mounts have changed since with [Gio.Global.unixMountsChangedSince].
 * If more mounts have the same mount path, the last matching mount
 * is returned.
 * This will return %NULL if looking up the mount entry fails, if
 * file_path doesn’t exist or there is an I/O error.
 * Params:
 *   filePath = file path on some unix mount.
 *   timeRead = guint64 to contain a timestamp.
 * Returns: a #GUnixMountEntry.
 */
UnixMountEntry unixMountFor(string filePath, out ulong timeRead)
{
  GUnixMountEntry* _cretval;
  const(char)* _filePath = filePath.toCString(false);
  _cretval = g_unix_mount_for(_filePath, cast(ulong*)&timeRead);
  auto _retval = _cretval ? new UnixMountEntry(cast(void*)_cretval, true) : null;
  return _retval;
}

/**
 * Frees a unix mount.
 * Params:
 *   mountEntry = a #GUnixMountEntry.
 */
void unixMountFree(UnixMountEntry mountEntry)
{
  g_unix_mount_free(mountEntry ? cast(GUnixMountEntry*)mountEntry.cPtr(false) : null);
}

/**
 * Gets the device path for a unix mount.
 * Params:
 *   mountEntry = a #GUnixMount.
 * Returns: a string containing the device path.
 */
string unixMountGetDevicePath(UnixMountEntry mountEntry)
{
  const(char)* _cretval;
  _cretval = g_unix_mount_get_device_path(mountEntry ? cast(GUnixMountEntry*)mountEntry.cPtr(false) : null);
  string _retval = _cretval.fromCString(false);
  return _retval;
}

/**
 * Gets the filesystem type for the unix mount.
 * Params:
 *   mountEntry = a #GUnixMount.
 * Returns: a string containing the file system type.
 */
string unixMountGetFsType(UnixMountEntry mountEntry)
{
  const(char)* _cretval;
  _cretval = g_unix_mount_get_fs_type(mountEntry ? cast(GUnixMountEntry*)mountEntry.cPtr(false) : null);
  string _retval = _cretval.fromCString(false);
  return _retval;
}

/**
 * Gets the mount path for a unix mount.
 * Params:
 *   mountEntry = input #GUnixMountEntry to get the mount path for.
 * Returns: the mount path for mount_entry.
 */
string unixMountGetMountPath(UnixMountEntry mountEntry)
{
  const(char)* _cretval;
  _cretval = g_unix_mount_get_mount_path(mountEntry ? cast(GUnixMountEntry*)mountEntry.cPtr(false) : null);
  string _retval = _cretval.fromCString(false);
  return _retval;
}

/**
 * Gets a comma-separated list of mount options for the unix mount. For example,
 * `rw,relatime,seclabel,data\=ordered`.
 * This is similar to [Gio.UnixMountPoint.getOptions], but it takes
 * a #GUnixMountEntry as an argument.
 * Params:
 *   mountEntry = a #GUnixMountEntry.
 * Returns: a string containing the options, or %NULL if not
 *   available.
 */
string unixMountGetOptions(UnixMountEntry mountEntry)
{
  const(char)* _cretval;
  _cretval = g_unix_mount_get_options(mountEntry ? cast(GUnixMountEntry*)mountEntry.cPtr(false) : null);
  string _retval = _cretval.fromCString(false);
  return _retval;
}

/**
 * Gets the root of the mount within the filesystem. This is useful e.g. for
 * mounts created by bind operation, or btrfs subvolumes.
 * For example, the root path is equal to "/" for mount created by
 * "mount /dev/sda1 /mnt/foo" and "/bar" for
 * "mount --bind /mnt/foo/bar /mnt/bar".
 * Params:
 *   mountEntry = a #GUnixMountEntry.
 * Returns: a string containing the root, or %NULL if not supported.
 */
string unixMountGetRootPath(UnixMountEntry mountEntry)
{
  const(char)* _cretval;
  _cretval = g_unix_mount_get_root_path(mountEntry ? cast(GUnixMountEntry*)mountEntry.cPtr(false) : null);
  string _retval = _cretval.fromCString(false);
  return _retval;
}

/**
 * Guesses whether a Unix mount can be ejected.
 * Params:
 *   mountEntry = a #GUnixMountEntry
 * Returns: %TRUE if mount_entry is deemed to be ejectable.
 */
bool unixMountGuessCanEject(UnixMountEntry mountEntry)
{
  bool _retval;
  _retval = g_unix_mount_guess_can_eject(mountEntry ? cast(GUnixMountEntry*)mountEntry.cPtr(false) : null);
  return _retval;
}

/**
 * Guesses the icon of a Unix mount.
 * Params:
 *   mountEntry = a #GUnixMountEntry
 * Returns: a #GIcon
 */
Icon unixMountGuessIcon(UnixMountEntry mountEntry)
{
  GIcon* _cretval;
  _cretval = g_unix_mount_guess_icon(mountEntry ? cast(GUnixMountEntry*)mountEntry.cPtr(false) : null);
  auto _retval = _cretval ? ObjectG.getDObject!Icon(cast(GIcon*)_cretval, true) : null;
  return _retval;
}

/**
 * Guesses the name of a Unix mount.
 * The result is a translated string.
 * Params:
 *   mountEntry = a #GUnixMountEntry
 * Returns: A newly allocated string that must
 *   be freed with [GLib.Global.gfree]
 */
string unixMountGuessName(UnixMountEntry mountEntry)
{
  char* _cretval;
  _cretval = g_unix_mount_guess_name(mountEntry ? cast(GUnixMountEntry*)mountEntry.cPtr(false) : null);
  string _retval = _cretval.fromCString(true);
  return _retval;
}

/**
 * Guesses whether a Unix mount should be displayed in the UI.
 * Params:
 *   mountEntry = a #GUnixMountEntry
 * Returns: %TRUE if mount_entry is deemed to be displayable.
 */
bool unixMountGuessShouldDisplay(UnixMountEntry mountEntry)
{
  bool _retval;
  _retval = g_unix_mount_guess_should_display(mountEntry ? cast(GUnixMountEntry*)mountEntry.cPtr(false) : null);
  return _retval;
}

/**
 * Guesses the symbolic icon of a Unix mount.
 * Params:
 *   mountEntry = a #GUnixMountEntry
 * Returns: a #GIcon
 */
Icon unixMountGuessSymbolicIcon(UnixMountEntry mountEntry)
{
  GIcon* _cretval;
  _cretval = g_unix_mount_guess_symbolic_icon(mountEntry ? cast(GUnixMountEntry*)mountEntry.cPtr(false) : null);
  auto _retval = _cretval ? ObjectG.getDObject!Icon(cast(GIcon*)_cretval, true) : null;
  return _retval;
}

/**
 * Checks if a unix mount is mounted read only.
 * Params:
 *   mountEntry = a #GUnixMount.
 * Returns: %TRUE if mount_entry is read only.
 */
bool unixMountIsReadonly(UnixMountEntry mountEntry)
{
  bool _retval;
  _retval = g_unix_mount_is_readonly(mountEntry ? cast(GUnixMountEntry*)mountEntry.cPtr(false) : null);
  return _retval;
}

/**
 * Checks if a Unix mount is a system mount. This is the Boolean OR of
 * [Gio.Global.unixIsSystemFsType], [Gio.Global.unixIsSystemDevicePath] and
 * [Gio.Global.unixIsMountPathSystemInternal] on mount_entry’s properties.
 * The definition of what a ‘system’ mount entry is may change over time as new
 * file system types and device paths are ignored.
 * Params:
 *   mountEntry = a #GUnixMount.
 * Returns: %TRUE if the unix mount is for a system path.
 */
bool unixMountIsSystemInternal(UnixMountEntry mountEntry)
{
  bool _retval;
  _retval = g_unix_mount_is_system_internal(mountEntry ? cast(GUnixMountEntry*)mountEntry.cPtr(false) : null);
  return _retval;
}

/**
 * Checks if the unix mount points have changed since a given unix time.
 * Params:
 *   time = guint64 to contain a timestamp.
 * Returns: %TRUE if the mount points have changed since time.
 */
bool unixMountPointsChangedSince(ulong time)
{
  bool _retval;
  _retval = g_unix_mount_points_changed_since(time);
  return _retval;
}

/**
 * Gets a #GList of #GUnixMountPoint containing the unix mount points.
 * If time_read is set, it will be filled with the mount timestamp,
 * allowing for checking if the mounts have changed with
 * [Gio.Global.unixMountPointsChangedSince].
 * Params:
 *   timeRead = guint64 to contain a timestamp.
 * Returns: a #GList of the UNIX mountpoints.
 */
List!(UnixMountPoint) unixMountPointsGet(out ulong timeRead)
{
  GList* _cretval;
  _cretval = g_unix_mount_points_get(cast(ulong*)&timeRead);
  List!(UnixMountPoint) _retval = new List!(UnixMountPoint)(cast(GList*)_cretval, GidOwnership.Full);
  return _retval;
}

/**
 * Checks if the unix mounts have changed since a given unix time.
 * Params:
 *   time = guint64 to contain a timestamp.
 * Returns: %TRUE if the mounts have changed since time.
 */
bool unixMountsChangedSince(ulong time)
{
  bool _retval;
  _retval = g_unix_mounts_changed_since(time);
  return _retval;
}

/**
 * Gets a #GList of #GUnixMountEntry containing the unix mounts.
 * If time_read is set, it will be filled with the mount
 * timestamp, allowing for checking if the mounts have changed
 * with [Gio.Global.unixMountsChangedSince].
 * Params:
 *   timeRead = guint64 to contain a timestamp, or %NULL
 * Returns: a #GList of the UNIX mounts.
 */
List!(UnixMountEntry) unixMountsGet(out ulong timeRead)
{
  GList* _cretval;
  _cretval = g_unix_mounts_get(cast(ulong*)&timeRead);
  List!(UnixMountEntry) _retval = new List!(UnixMountEntry)(cast(GList*)_cretval, GidOwnership.Full);
  return _retval;
}
