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
import GObject.Types;
import GObject.Value;
import Gid.Gid;
import Gio.AsyncResult;
import Gio.Cancellable;
import Gio.DBusConnection;
import Gio.File;
import Gio.IOModule;
import Gio.IOModuleScope;
import Gio.IOSchedulerJob;
import Gio.IOStream;
import Gio.Icon;
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
 * Asynchronously connects to the message bus specified by @bus_type.
 *
 * When the operation is finished, @callback will be invoked. You can
 * then call g_bus_get_finish() to get the result of the operation.
 *
 * This is an asynchronous failable function. See g_bus_get_sync() for
 * the synchronous version.
 */
void busGet(BusType busType, Cancellable cancellable, AsyncReadyCallback callback)
{
  extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
  {
    ptrThawGC(data);

    (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
  }

  ptrFreezeGC(cast(void*)&callback);
  g_bus_get(busType, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
}

/**
 * a #GDBusConnection or %NULL if @error is set.
 * Free with g_object_unref().
 */
DBusConnection busGetFinish(AsyncResult res)
{
  GDBusConnection* _cretval;
  GError *_err;
  _cretval = g_bus_get_finish(res ? (cast(ObjectG)res).cPtr!GAsyncResult : null, &_err);
  if (_err)
    throw new ErrorG(_err);
  DBusConnection _retval = ObjectG.getDObject!DBusConnection(cast(GDBusConnection*)_cretval, true);
  return _retval;
}

/**
 * a #GDBusConnection or %NULL if @error is set.
 * Free with g_object_unref().
 */
DBusConnection busGetSync(BusType busType, Cancellable cancellable)
{
  GDBusConnection* _cretval;
  GError *_err;
  _cretval = g_bus_get_sync(busType, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
  if (_err)
    throw new ErrorG(_err);
  DBusConnection _retval = ObjectG.getDObject!DBusConnection(cast(GDBusConnection*)_cretval, true);
  return _retval;
}

/**
 * an identifier (never 0) that can be used with
 * g_bus_unown_name() to stop owning the name.
 */
uint busOwnNameOnConnection(DBusConnection connection, string name, BusNameOwnerFlags flags, Closure nameAcquiredClosure, Closure nameLostClosure)
{
  uint _retval;
  const(char)* _name = name.toCString(false);
  _retval = g_bus_own_name_on_connection_with_closures(connection ? connection.cPtr!GDBusConnection : null, _name, flags, nameAcquiredClosure ? nameAcquiredClosure.cPtr!GClosure : null, nameLostClosure ? nameLostClosure.cPtr!GClosure : null);
  return _retval;
}

/**
 * an identifier (never 0) that can be used with
 * g_bus_unown_name() to stop owning the name.
 */
uint busOwnName(BusType busType, string name, BusNameOwnerFlags flags, Closure busAcquiredClosure, Closure nameAcquiredClosure, Closure nameLostClosure)
{
  uint _retval;
  const(char)* _name = name.toCString(false);
  _retval = g_bus_own_name_with_closures(busType, _name, flags, busAcquiredClosure ? busAcquiredClosure.cPtr!GClosure : null, nameAcquiredClosure ? nameAcquiredClosure.cPtr!GClosure : null, nameLostClosure ? nameLostClosure.cPtr!GClosure : null);
  return _retval;
}

/**
 * Stops owning a name.
 *
 * Note that there may still be D-Bus traffic to process (relating to owning
 * and unowning the name) in the current thread-default #GMainContext after
 * this function has returned. You should continue to iterate the #GMainContext
 * until the #GDestroyNotify function passed to g_bus_own_name() is called, in
 * order to avoid memory leaks through callbacks queued on the #GMainContext
 * after it’s stopped being iterated.
 */
void busUnownName(uint ownerId)
{
  g_bus_unown_name(ownerId);
}

/**
 * Stops watching a name.
 *
 * Note that there may still be D-Bus traffic to process (relating to watching
 * and unwatching the name) in the current thread-default #GMainContext after
 * this function has returned. You should continue to iterate the #GMainContext
 * until the #GDestroyNotify function passed to g_bus_watch_name() is called, in
 * order to avoid memory leaks through callbacks queued on the #GMainContext
 * after it’s stopped being iterated.
 */
void busUnwatchName(uint watcherId)
{
  g_bus_unwatch_name(watcherId);
}

/**
 * An identifier (never 0) that can be used with
 * g_bus_unwatch_name() to stop watching the name.
 */
uint busWatchNameOnConnection(DBusConnection connection, string name, BusNameWatcherFlags flags, Closure nameAppearedClosure, Closure nameVanishedClosure)
{
  uint _retval;
  const(char)* _name = name.toCString(false);
  _retval = g_bus_watch_name_on_connection_with_closures(connection ? connection.cPtr!GDBusConnection : null, _name, flags, nameAppearedClosure ? nameAppearedClosure.cPtr!GClosure : null, nameVanishedClosure ? nameVanishedClosure.cPtr!GClosure : null);
  return _retval;
}

/**
 * An identifier (never 0) that can be used with
 * g_bus_unwatch_name() to stop watching the name.
 */
uint busWatchName(BusType busType, string name, BusNameWatcherFlags flags, Closure nameAppearedClosure, Closure nameVanishedClosure)
{
  uint _retval;
  const(char)* _name = name.toCString(false);
  _retval = g_bus_watch_name_with_closures(busType, _name, flags, nameAppearedClosure ? nameAppearedClosure.cPtr!GClosure : null, nameVanishedClosure ? nameVanishedClosure.cPtr!GClosure : null);
  return _retval;
}

/**
 * %TRUE if the file type corresponds to a type that
 * can be executable, %FALSE otherwise.
 */
bool contentTypeCanBeExecutable(string type)
{
  bool _retval;
  const(char)* _type = type.toCString(false);
  _retval = g_content_type_can_be_executable(_type);
  return _retval;
}

/**
 * %TRUE if the two strings are identical or equivalent,
 * %FALSE otherwise.
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
 * Newly allocated string with content type or
 * %NULL. Free with g_free()
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
 * a short description of the content type @type. Free the
 * returned string with g_free()
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
 * the registered generic icon name for the given @type,
 * or %NULL if unknown. Free with g_free()
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
 * #GIcon corresponding to the content type. Free the returned
 * object with g_object_unref()
 */
Icon contentTypeGetIcon(string type)
{
  GIcon* _cretval;
  const(char)* _type = type.toCString(false);
  _cretval = g_content_type_get_icon(_type);
  Icon _retval = ObjectG.getDObject!Icon(cast(GIcon*)_cretval, true);
  return _retval;
}

/**
 * %NULL-terminated list of
 * directories to load MIME data from, including any `mime/` subdirectory,
 * and with the first directory to try listed first
 */
string[] contentTypeGetMimeDirs()
{
  const(char*)* _cretval;
  _cretval = g_content_type_get_mime_dirs();
  string[] _retval;

  if (_cretval)
  {
    uint _cretlength;
    for (; _cretval[_cretlength] != null; _cretlength++)
      break;
    _retval = new string[_cretlength];
    foreach (i; 0 .. _cretlength)
      _retval[i] = _cretval[i].fromCString(false);
  }
  return _retval;
}

/**
 * the registered mime type for the
 * given @type, or %NULL if unknown; free with g_free().
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
 * symbolic #GIcon corresponding to the content type.
 * Free the returned object with g_object_unref()
 */
Icon contentTypeGetSymbolicIcon(string type)
{
  GIcon* _cretval;
  const(char)* _type = type.toCString(false);
  _cretval = g_content_type_get_symbolic_icon(_type);
  Icon _retval = ObjectG.getDObject!Icon(cast(GIcon*)_cretval, true);
  return _retval;
}

/**
 * a string indicating a guessed content type for the
 * given data. Free with g_free()
 */
string contentTypeGuess(string filename, ubyte[] data, out bool resultUncertain)
{
  char* _cretval;
  const(char)* _filename = filename.toCString(false);
  auto _data = cast(const(ubyte)*)data.ptr;
  _cretval = g_content_type_guess(_filename, _data, data ? cast(size_t)data.length : 0, cast(bool*)&resultUncertain);
  string _retval = _cretval.fromCString(true);
  return _retval;
}

/**
 * an %NULL-terminated
 * array of zero or more content types. Free with g_strfreev()
 */
string[] contentTypeGuessForTree(File root)
{
  char** _cretval;
  _cretval = g_content_type_guess_for_tree(root ? (cast(ObjectG)root).cPtr!GFile : null);
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
 * %TRUE if @type is a kind of @supertype,
 * %FALSE otherwise.
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
 * %TRUE if @type is a kind of @mime_type,
 * %FALSE otherwise.
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
 * %TRUE if the type is the unknown type.
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
 * If @dirs is %NULL, the directories used are the default:
 *
 * - the `mime` subdirectory of the directory in `$XDG_DATA_HOME`
 * - the `mime` subdirectory of every directory in `$XDG_DATA_DIRS`
 *
 * This function is intended to be used when writing tests that depend on
 * information stored in the MIME database, in order to control the data.
 *
 * Typically, in case your tests use %G_TEST_OPTION_ISOLATE_DIRS, but they
 * depend on the system’s MIME database, you should call this function
 * with @dirs set to %NULL before calling g_test_init(), for instance:
 *
 * |[<!-- language="C" -->
 * // Load MIME data from the system
 * g_content_type_set_mime_dirs (NULL);
 * // Isolate the environment
 * g_test_init (&argc, &argv, G_TEST_OPTION_ISOLATE_DIRS, NULL);
 *
 * …
 *
 * return g_test_run ();
 * ]|
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
 * list of the registered
 * content types
 */
List!(string, char*) contentTypesGetRegistered()
{
  GList* _cretval;
  _cretval = g_content_types_get_registered();
  List!(string, char*) _retval = _cretval ? new List!(string, char*)(_cretval, GidOwnership.Full) : null;
  return _retval;
}

/**
 * a copy of @string with all
 * non-optionally-escaped bytes escaped
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
 * a valid D-Bus address string for @bus_type or
 * %NULL if @error is set
 */
string dbusAddressGetForBusSync(BusType busType, Cancellable cancellable)
{
  char* _cretval;
  GError *_err;
  _cretval = g_dbus_address_get_for_bus_sync(busType, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
  if (_err)
    throw new ErrorG(_err);
  string _retval = _cretval.fromCString(true);
  return _retval;
}

/**
 * Asynchronously connects to an endpoint specified by @address and
 * sets up the connection so it is in a state to run the client-side
 * of the D-Bus authentication conversation. @address must be in the
 * [D-Bus address format](https://dbus.freedesktop.org/doc/dbus-specification.html#addresses).
 *
 * When the operation is finished, @callback will be invoked. You can
 * then call g_dbus_address_get_stream_finish() to get the result of
 * the operation.
 *
 * This is an asynchronous failable function. See
 * g_dbus_address_get_stream_sync() for the synchronous version.
 */
void dbusAddressGetStream(string address, Cancellable cancellable, AsyncReadyCallback callback)
{
  extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
  {
    ptrThawGC(data);

    (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
  }

  const(char)* _address = address.toCString(false);
  ptrFreezeGC(cast(void*)&callback);
  g_dbus_address_get_stream(_address, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
}

/**
 * A #GIOStream or %NULL if @error is set.
 */
IOStream dbusAddressGetStreamFinish(AsyncResult res, out string outGuid)
{
  GIOStream* _cretval;
  char* _outGuid;
  GError *_err;
  _cretval = g_dbus_address_get_stream_finish(res ? (cast(ObjectG)res).cPtr!GAsyncResult : null, &_outGuid, &_err);
  if (_err)
    throw new ErrorG(_err);
  IOStream _retval = ObjectG.getDObject!IOStream(cast(GIOStream*)_cretval, true);
  outGuid = _outGuid.fromCString(true);
  return _retval;
}

/**
 * A #GIOStream or %NULL if @error is set.
 */
IOStream dbusAddressGetStreamSync(string address, out string outGuid, Cancellable cancellable)
{
  GIOStream* _cretval;
  const(char)* _address = address.toCString(false);
  char* _outGuid;
  GError *_err;
  _cretval = g_dbus_address_get_stream_sync(_address, &_outGuid, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
  if (_err)
    throw new ErrorG(_err);
  IOStream _retval = ObjectG.getDObject!IOStream(cast(GIOStream*)_cretval, true);
  outGuid = _outGuid.fromCString(true);
  return _retval;
}

/**
 * an escaped version of @s. Free with g_free().
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
 * an escaped version of @bytes. Free with g_free().
 */
string dbusEscapeObjectPathBytestring(ubyte[] bytes)
{
  char* _cretval;
  auto _bytes = cast(const(ubyte)*)(bytes ~ 0).ptr;
  _cretval = g_dbus_escape_object_path_bytestring(_bytes);
  string _retval = _cretval.fromCString(true);
  return _retval;
}

/**
 * A valid D-Bus GUID. Free with g_free().
 */
string dbusGenerateGuid()
{
  char* _cretval;
  _cretval = g_dbus_generate_guid();
  string _retval = _cretval.fromCString(true);
  return _retval;
}

/**
 * A #GVariant (never floating) of
 * #GVariantType @type holding the data from @gvalue or an empty #GVariant
 * in case of failure. Free with g_variant_unref().
 */
Variant dbusGvalueToGvariant(Value gvalue, VariantType type)
{
  GVariant* _cretval;
  _cretval = g_dbus_gvalue_to_gvariant(gvalue ? gvalue.cPtr!GValue : null, type ? type.cPtr!GVariantType : null);
  Variant _retval = new Variant(cast(GVariant*)_cretval, true);
  return _retval;
}

/**
 * %TRUE if @string is a valid D-Bus address, %FALSE otherwise.
 */
bool dbusIsAddress(string string_)
{
  bool _retval;
  const(char)* _string_ = string_.toCString(false);
  _retval = g_dbus_is_address(_string_);
  return _retval;
}

/**
 * %TRUE if valid, %FALSE otherwise.
 */
bool dbusIsErrorName(string string_)
{
  bool _retval;
  const(char)* _string_ = string_.toCString(false);
  _retval = g_dbus_is_error_name(_string_);
  return _retval;
}

/**
 * %TRUE if @string is a GUID, %FALSE otherwise.
 */
bool dbusIsGuid(string string_)
{
  bool _retval;
  const(char)* _string_ = string_.toCString(false);
  _retval = g_dbus_is_guid(_string_);
  return _retval;
}

/**
 * %TRUE if valid, %FALSE otherwise.
 */
bool dbusIsInterfaceName(string string_)
{
  bool _retval;
  const(char)* _string_ = string_.toCString(false);
  _retval = g_dbus_is_interface_name(_string_);
  return _retval;
}

/**
 * %TRUE if valid, %FALSE otherwise.
 */
bool dbusIsMemberName(string string_)
{
  bool _retval;
  const(char)* _string_ = string_.toCString(false);
  _retval = g_dbus_is_member_name(_string_);
  return _retval;
}

/**
 * %TRUE if valid, %FALSE otherwise.
 */
bool dbusIsName(string string_)
{
  bool _retval;
  const(char)* _string_ = string_.toCString(false);
  _retval = g_dbus_is_name(_string_);
  return _retval;
}

/**
 * %TRUE if @string is a valid D-Bus address that is
 * supported by this library, %FALSE if @error is set.
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
 * %TRUE if valid, %FALSE otherwise.
 */
bool dbusIsUniqueName(string string_)
{
  bool _retval;
  const(char)* _string_ = string_.toCString(false);
  _retval = g_dbus_is_unique_name(_string_);
  return _retval;
}

/**
 * an
 * unescaped version of @s, or %NULL if @s is not a string returned
 * from g_dbus_escape_object_path(). Free with g_free().
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
 * #GIOErrorEnum value for the given errno.h error number.
 */
IOErrorEnum ioErrorFromErrno(int errNo)
{
  GIOErrorEnum _cretval;
  _cretval = g_io_error_from_errno(errNo);
  IOErrorEnum _retval = cast(IOErrorEnum)_cretval;
  return _retval;
}

/**
 * #GIOErrorEnum value for the given #GFileError error value.
 */
IOErrorEnum ioErrorFromFileError(FileError fileError)
{
  GIOErrorEnum _cretval;
  _cretval = g_io_error_from_file_error(fileError);
  IOErrorEnum _retval = cast(IOErrorEnum)_cretval;
  return _retval;
}

/**
 * a #GQuark.
 */
Quark ioErrorQuark()
{
  Quark _retval;
  _retval = g_io_error_quark();
  return _retval;
}

/**
 * a list of #GIOModules loaded
 * from the directory,
 * All the modules are loaded into memory, if you want to
 * unload them (enabling on-demand loading) you must call
 * g_type_module_unuse() on all the modules. Free the list
 * with g_list_free().
 */
List!(IOModule, GIOModule*) ioModulesLoadAllInDirectory(string dirname)
{
  GList* _cretval;
  const(char)* _dirname = dirname.toCString(false);
  _cretval = g_io_modules_load_all_in_directory(_dirname);
  List!(IOModule, GIOModule*) _retval = _cretval ? new List!(IOModule, GIOModule*)(_cretval, GidOwnership.Full) : null;
  return _retval;
}

/**
 * a list of #GIOModules loaded
 * from the directory,
 * All the modules are loaded into memory, if you want to
 * unload them (enabling on-demand loading) you must call
 * g_type_module_unuse() on all the modules. Free the list
 * with g_list_free().
 */
List!(IOModule, GIOModule*) ioModulesLoadAllInDirectoryWithScope(string dirname, IOModuleScope scope_)
{
  GList* _cretval;
  const(char)* _dirname = dirname.toCString(false);
  _cretval = g_io_modules_load_all_in_directory_with_scope(_dirname, scope_ ? scope_.cPtr!GIOModuleScope : null);
  List!(IOModule, GIOModule*) _retval = _cretval ? new List!(IOModule, GIOModule*)(_cretval, GidOwnership.Full) : null;
  return _retval;
}

/**
 * Scans all the modules in the specified directory, ensuring that
 * any extension point implemented by a module is registered.
 *
 * This may not actually load and initialize all the types in each
 * module, some modules may be lazily loaded and initialized when
 * an extension point it implements is used with e.g.
 * g_io_extension_point_get_extensions() or
 * g_io_extension_point_get_extension_by_name().
 *
 * If you need to guarantee that all types are loaded in all the modules,
 * use g_io_modules_load_all_in_directory().
 */
void ioModulesScanAllInDirectory(string dirname)
{
  const(char)* _dirname = dirname.toCString(false);
  g_io_modules_scan_all_in_directory(_dirname);
}

/**
 * Scans all the modules in the specified directory, ensuring that
 * any extension point implemented by a module is registered.
 *
 * This may not actually load and initialize all the types in each
 * module, some modules may be lazily loaded and initialized when
 * an extension point it implements is used with e.g.
 * g_io_extension_point_get_extensions() or
 * g_io_extension_point_get_extension_by_name().
 *
 * If you need to guarantee that all types are loaded in all the modules,
 * use g_io_modules_load_all_in_directory().
 */
void ioModulesScanAllInDirectoryWithScope(string dirname, IOModuleScope scope_)
{
  const(char)* _dirname = dirname.toCString(false);
  g_io_modules_scan_all_in_directory_with_scope(_dirname, scope_ ? scope_.cPtr!GIOModuleScope : null);
}

/**
 * Cancels all cancellable I/O jobs.
 *
 * A job is cancellable if a #GCancellable was passed into
 * g_io_scheduler_push_job().
 */
void ioSchedulerCancelAllJobs()
{
  g_io_scheduler_cancel_all_jobs();
}

/**
 * Schedules the I/O job to run in another thread.
 *
 * @notify will be called on @user_data after @job_func has returned,
 * regardless whether the job was cancelled or has run to completion.
 *
 * If @cancellable is not %NULL, it can be used to cancel the I/O job
 * by calling g_cancellable_cancel() or by calling
 * g_io_scheduler_cancel_all_jobs().
 */
void ioSchedulerPushJob(IOSchedulerJobFunc jobFunc, int ioPriority, Cancellable cancellable)
{
  extern(C) bool _jobFuncCallback(GIOSchedulerJob* job, GCancellable* cancellable, void* data)
  {
    bool _retval = (*(cast(IOSchedulerJobFunc*)data))(job ? new IOSchedulerJob(job, false) : null, cancellable ? ObjectG.getDObject!Cancellable(cancellable, false) : null);
    return _retval;
  }

  ptrFreezeGC(cast(void*)&jobFunc);
  g_io_scheduler_push_job(&_jobFuncCallback, cast(void*)&jobFunc, &ptrThawDestroyNotify, ioPriority, cancellable ? cancellable.cPtr!GCancellable : null);
}

/**
 * a keyfile-backed #GSettingsBackend
 */
SettingsBackend keyfileSettingsBackendNew(string filename, string rootPath, string rootGroup)
{
  GSettingsBackend* _cretval;
  const(char)* _filename = filename.toCString(false);
  const(char)* _rootPath = rootPath.toCString(false);
  const(char)* _rootGroup = rootGroup.toCString(false);
  _cretval = g_keyfile_settings_backend_new(_filename, _rootPath, _rootGroup);
  SettingsBackend _retval = ObjectG.getDObject!SettingsBackend(cast(GSettingsBackend*)_cretval, true);
  return _retval;
}

/**
 * a newly created #GSettingsBackend
 */
SettingsBackend memorySettingsBackendNew()
{
  GSettingsBackend* _cretval;
  _cretval = g_memory_settings_backend_new();
  SettingsBackend _retval = ObjectG.getDObject!SettingsBackend(cast(GSettingsBackend*)_cretval, true);
  return _retval;
}

/**
 * Initializes the platform networking libraries (eg, on Windows, this
 * calls WSAStartup()). GLib will call this itself if it is needed, so
 * you only need to call it if you directly call system networking
 * functions (without calling any GLib networking functions first).
 */
void networkingInit()
{
  g_networking_init();
}

/**
 * a newly created #GSettingsBackend
 */
SettingsBackend nullSettingsBackendNew()
{
  GSettingsBackend* _cretval;
  _cretval = g_null_settings_backend_new();
  SettingsBackend _retval = ObjectG.getDObject!SettingsBackend(cast(GSettingsBackend*)_cretval, true);
  return _retval;
}

/**
 * the new #GSource.
 */
Source pollableSourceNew(ObjectG pollableStream)
{
  GSource* _cretval;
  _cretval = g_pollable_source_new(pollableStream ? pollableStream.cPtr!ObjectC : null);
  Source _retval = new Source(cast(GSource*)_cretval, true);
  return _retval;
}

/**
 * the new #GSource.
 */
Source pollableSourceNewFull(ObjectG pollableStream, Source childSource, Cancellable cancellable)
{
  GSource* _cretval;
  _cretval = g_pollable_source_new_full(pollableStream ? pollableStream.cPtr!ObjectC : null, childSource ? childSource.cPtr!GSource : null, cancellable ? cancellable.cPtr!GCancellable : null);
  Source _retval = new Source(cast(GSource*)_cretval, true);
  return _retval;
}

/**
 * the number of bytes read, or -1 on error.
 */
ptrdiff_t pollableStreamRead(InputStream stream, ubyte[] buffer, bool blocking, Cancellable cancellable)
{
  ptrdiff_t _retval;
  auto _buffer = cast(void*)buffer.ptr;
  GError *_err;
  _retval = g_pollable_stream_read(stream ? stream.cPtr!GInputStream : null, _buffer, buffer ? cast(size_t)buffer.length : 0, blocking, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
  if (_err)
    throw new ErrorG(_err);
  return _retval;
}

/**
 * the number of bytes written, or -1 on error.
 */
ptrdiff_t pollableStreamWrite(OutputStream stream, ubyte[] buffer, bool blocking, Cancellable cancellable)
{
  ptrdiff_t _retval;
  auto _buffer = cast(void*)buffer.ptr;
  GError *_err;
  _retval = g_pollable_stream_write(stream ? stream.cPtr!GOutputStream : null, _buffer, buffer ? cast(size_t)buffer.length : 0, blocking, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
  if (_err)
    throw new ErrorG(_err);
  return _retval;
}

/**
 * %TRUE on success, %FALSE if there was an error
 */
bool pollableStreamWriteAll(OutputStream stream, ubyte[] buffer, bool blocking, out size_t bytesWritten, Cancellable cancellable)
{
  bool _retval;
  auto _buffer = cast(void*)buffer.ptr;
  GError *_err;
  _retval = g_pollable_stream_write_all(stream ? stream.cPtr!GOutputStream : null, _buffer, buffer ? cast(size_t)buffer.length : 0, blocking, cast(size_t*)&bytesWritten, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
  if (_err)
    throw new ErrorG(_err);
  return _retval;
}

/**
 * an array of constant strings
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
    for (; _cretval[_cretlength] != null; _cretlength++)
      break;
    _retval = new string[_cretlength];
    foreach (i; 0 .. _cretlength)
      _retval[i] = _cretval[i].fromCString(true);
  }
  return _retval;
}

/**
 * %TRUE if the file was found. %FALSE if there were errors
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
 * #GBytes or %NULL on error.
 * Free the returned object with g_bytes_unref()
 */
Bytes resourcesLookupData(string path, ResourceLookupFlags lookupFlags)
{
  GBytes* _cretval;
  const(char)* _path = path.toCString(false);
  GError *_err;
  _cretval = g_resources_lookup_data(_path, lookupFlags, &_err);
  if (_err)
    throw new ErrorG(_err);
  Bytes _retval = new Bytes(cast(GBytes*)_cretval, true);
  return _retval;
}

/**
 * #GInputStream or %NULL on error.
 * Free the returned object with g_object_unref()
 */
InputStream resourcesOpenStream(string path, ResourceLookupFlags lookupFlags)
{
  GInputStream* _cretval;
  const(char)* _path = path.toCString(false);
  GError *_err;
  _cretval = g_resources_open_stream(_path, lookupFlags, &_err);
  if (_err)
    throw new ErrorG(_err);
  InputStream _retval = ObjectG.getDObject!InputStream(cast(GInputStream*)_cretval, true);
  return _retval;
}

/**
 * Registers the resource with the process-global set of resources.
 * Once a resource is registered the files in it can be accessed
 * with the global resource lookup functions like g_resources_lookup_data().
 */
void resourcesRegister(Resource resource)
{
  g_resources_register(resource ? resource.cPtr!GResource : null);
}

/**
 * Unregisters the resource from the process-global set of resources.
 */
void resourcesUnregister(Resource resource)
{
  g_resources_unregister(resource ? resource.cPtr!GResource : null);
}

/**
 * Reports an error in an idle function. Similar to
 * g_simple_async_report_error_in_idle(), but takes a #GError rather
 * than building a new one.
 */
void simpleAsyncReportGerrorInIdle(ObjectG object, AsyncReadyCallback callback, ErrorG error)
{
  extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
  {
    ptrThawGC(data);

    (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
  }

  ptrFreezeGC(cast(void*)&callback);
  g_simple_async_report_gerror_in_idle(object ? object.cPtr!ObjectC : null, &_callbackCallback, cast(void*)&callback, error ? error.cPtr!GError : null);
}

/**
 * %TRUE if @mount_path is considered an implementation detail
 * of the OS.
 */
bool unixIsMountPathSystemInternal(string mountPath)
{
  bool _retval;
  const(char)* _mountPath = mountPath.toCString(false);
  _retval = g_unix_is_mount_path_system_internal(_mountPath);
  return _retval;
}

/**
 * %TRUE if @device_path is considered an implementation detail of
 * the OS.
 */
bool unixIsSystemDevicePath(string devicePath)
{
  bool _retval;
  const(char)* _devicePath = devicePath.toCString(false);
  _retval = g_unix_is_system_device_path(_devicePath);
  return _retval;
}

/**
 * %TRUE if @fs_type is considered an implementation detail of the OS.
 */
bool unixIsSystemFsType(string fsType)
{
  bool _retval;
  const(char)* _fsType = fsType.toCString(false);
  _retval = g_unix_is_system_fs_type(_fsType);
  return _retval;
}

/**
 * a #GUnixMountEntry.
 */
UnixMountEntry unixMountAt(string mountPath, out ulong timeRead)
{
  GUnixMountEntry* _cretval;
  const(char)* _mountPath = mountPath.toCString(false);
  _cretval = g_unix_mount_at(_mountPath, cast(ulong*)&timeRead);
  UnixMountEntry _retval = new UnixMountEntry(cast(GUnixMountEntry*)_cretval, true);
  return _retval;
}

/**
 * 1, 0 or -1 if @mount1 is greater than, equal to,
 * or less than @mount2, respectively.
 */
int unixMountCompare(UnixMountEntry mount1, UnixMountEntry mount2)
{
  int _retval;
  _retval = g_unix_mount_compare(mount1 ? mount1.cPtr!GUnixMountEntry : null, mount2 ? mount2.cPtr!GUnixMountEntry : null);
  return _retval;
}

/**
 * a new #GUnixMountEntry
 */
UnixMountEntry unixMountCopy(UnixMountEntry mountEntry)
{
  GUnixMountEntry* _cretval;
  _cretval = g_unix_mount_copy(mountEntry ? mountEntry.cPtr!GUnixMountEntry : null);
  UnixMountEntry _retval = new UnixMountEntry(cast(GUnixMountEntry*)_cretval, true);
  return _retval;
}

/**
 * a #GUnixMountEntry.
 */
UnixMountEntry unixMountFor(string filePath, out ulong timeRead)
{
  GUnixMountEntry* _cretval;
  const(char)* _filePath = filePath.toCString(false);
  _cretval = g_unix_mount_for(_filePath, cast(ulong*)&timeRead);
  UnixMountEntry _retval = new UnixMountEntry(cast(GUnixMountEntry*)_cretval, true);
  return _retval;
}

/**
 * Frees a unix mount.
 */
void unixMountFree(UnixMountEntry mountEntry)
{
  g_unix_mount_free(mountEntry ? mountEntry.cPtr!GUnixMountEntry : null);
}

/**
 * a string containing the device path.
 */
string unixMountGetDevicePath(UnixMountEntry mountEntry)
{
  const(char)* _cretval;
  _cretval = g_unix_mount_get_device_path(mountEntry ? mountEntry.cPtr!GUnixMountEntry : null);
  string _retval = _cretval.fromCString(false);
  return _retval;
}

/**
 * a string containing the file system type.
 */
string unixMountGetFsType(UnixMountEntry mountEntry)
{
  const(char)* _cretval;
  _cretval = g_unix_mount_get_fs_type(mountEntry ? mountEntry.cPtr!GUnixMountEntry : null);
  string _retval = _cretval.fromCString(false);
  return _retval;
}

/**
 * the mount path for @mount_entry.
 */
string unixMountGetMountPath(UnixMountEntry mountEntry)
{
  const(char)* _cretval;
  _cretval = g_unix_mount_get_mount_path(mountEntry ? mountEntry.cPtr!GUnixMountEntry : null);
  string _retval = _cretval.fromCString(false);
  return _retval;
}

/**
 * a string containing the options, or %NULL if not
 * available.
 */
string unixMountGetOptions(UnixMountEntry mountEntry)
{
  const(char)* _cretval;
  _cretval = g_unix_mount_get_options(mountEntry ? mountEntry.cPtr!GUnixMountEntry : null);
  string _retval = _cretval.fromCString(false);
  return _retval;
}

/**
 * a string containing the root, or %NULL if not supported.
 */
string unixMountGetRootPath(UnixMountEntry mountEntry)
{
  const(char)* _cretval;
  _cretval = g_unix_mount_get_root_path(mountEntry ? mountEntry.cPtr!GUnixMountEntry : null);
  string _retval = _cretval.fromCString(false);
  return _retval;
}

/**
 * %TRUE if @mount_entry is deemed to be ejectable.
 */
bool unixMountGuessCanEject(UnixMountEntry mountEntry)
{
  bool _retval;
  _retval = g_unix_mount_guess_can_eject(mountEntry ? mountEntry.cPtr!GUnixMountEntry : null);
  return _retval;
}

/**
 * a #GIcon
 */
Icon unixMountGuessIcon(UnixMountEntry mountEntry)
{
  GIcon* _cretval;
  _cretval = g_unix_mount_guess_icon(mountEntry ? mountEntry.cPtr!GUnixMountEntry : null);
  Icon _retval = ObjectG.getDObject!Icon(cast(GIcon*)_cretval, true);
  return _retval;
}

/**
 * A newly allocated string that must
 * be freed with g_free()
 */
string unixMountGuessName(UnixMountEntry mountEntry)
{
  char* _cretval;
  _cretval = g_unix_mount_guess_name(mountEntry ? mountEntry.cPtr!GUnixMountEntry : null);
  string _retval = _cretval.fromCString(true);
  return _retval;
}

/**
 * %TRUE if @mount_entry is deemed to be displayable.
 */
bool unixMountGuessShouldDisplay(UnixMountEntry mountEntry)
{
  bool _retval;
  _retval = g_unix_mount_guess_should_display(mountEntry ? mountEntry.cPtr!GUnixMountEntry : null);
  return _retval;
}

/**
 * a #GIcon
 */
Icon unixMountGuessSymbolicIcon(UnixMountEntry mountEntry)
{
  GIcon* _cretval;
  _cretval = g_unix_mount_guess_symbolic_icon(mountEntry ? mountEntry.cPtr!GUnixMountEntry : null);
  Icon _retval = ObjectG.getDObject!Icon(cast(GIcon*)_cretval, true);
  return _retval;
}

/**
 * %TRUE if @mount_entry is read only.
 */
bool unixMountIsReadonly(UnixMountEntry mountEntry)
{
  bool _retval;
  _retval = g_unix_mount_is_readonly(mountEntry ? mountEntry.cPtr!GUnixMountEntry : null);
  return _retval;
}

/**
 * %TRUE if the unix mount is for a system path.
 */
bool unixMountIsSystemInternal(UnixMountEntry mountEntry)
{
  bool _retval;
  _retval = g_unix_mount_is_system_internal(mountEntry ? mountEntry.cPtr!GUnixMountEntry : null);
  return _retval;
}

/**
 * %TRUE if the mount points have changed since @time.
 */
bool unixMountPointsChangedSince(ulong time)
{
  bool _retval;
  _retval = g_unix_mount_points_changed_since(time);
  return _retval;
}

/**
 * a #GList of the UNIX mountpoints.
 */
List!(UnixMountPoint, GUnixMountPoint*) unixMountPointsGet(out ulong timeRead)
{
  GList* _cretval;
  _cretval = g_unix_mount_points_get(cast(ulong*)&timeRead);
  List!(UnixMountPoint, GUnixMountPoint*) _retval = _cretval ? new List!(UnixMountPoint, GUnixMountPoint*)(_cretval, GidOwnership.Full) : null;
  return _retval;
}

/**
 * %TRUE if the mounts have changed since @time.
 */
bool unixMountsChangedSince(ulong time)
{
  bool _retval;
  _retval = g_unix_mounts_changed_since(time);
  return _retval;
}

/**
 * a #GList of the UNIX mounts.
 */
List!(UnixMountEntry, GUnixMountEntry*) unixMountsGet(out ulong timeRead)
{
  GList* _cretval;
  _cretval = g_unix_mounts_get(cast(ulong*)&timeRead);
  List!(UnixMountEntry, GUnixMountEntry*) _retval = _cretval ? new List!(UnixMountEntry, GUnixMountEntry*)(_cretval, GidOwnership.Full) : null;
  return _retval;
}
