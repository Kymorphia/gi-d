module Gio.DBusMessage;

import GLib.ErrorG;
import GLib.Variant;
import GObject.ObjectG;
import Gid.gid;
import Gio.Types;
import Gio.UnixFDList;
import Gio.c.functions;
import Gio.c.types;

/**
 * A type for representing D-Bus messages that can be sent or received
 * on a [Gio.DBusConnection].
 */
class DBusMessage : ObjectG
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_dbus_message_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new empty #GDBusMessage.
   * Returns: A #GDBusMessage. Free with [GObject.ObjectG.unref].
   */
  this()
  {
    GDBusMessage* _cretval;
    _cretval = g_dbus_message_new();
    this(_cretval, true);
  }

  /**
   * Creates a new #GDBusMessage from the data stored at blob. The byte
   * order that the message was in can be retrieved using
   * [Gio.DBusMessage.getByteOrder].
   * If the blob cannot be parsed, contains invalid fields, or contains invalid
   * headers, %G_IO_ERROR_INVALID_ARGUMENT will be returned.
   * Params:
   *   blob = A blob representing a binary D-Bus message.
   *   capabilities = A #GDBusCapabilityFlags describing what protocol features are supported.
   * Returns: A new #GDBusMessage or %NULL if error is set. Free with
   *   [GObject.ObjectG.unref].
   */
  static DBusMessage newFromBlob(ubyte[] blob, DBusCapabilityFlags capabilities)
  {
    GDBusMessage* _cretval;
    size_t _blobLen;
    if (blob)
      _blobLen = cast(size_t)blob.length;

    auto _blob = cast(ubyte*)blob.ptr;
    GError *_err;
    _cretval = g_dbus_message_new_from_blob(_blob, _blobLen, capabilities, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = _cretval ? ObjectG.getDObject!DBusMessage(cast(GDBusMessage*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Creates a new #GDBusMessage for a method call.
   * Params:
   *   name = A valid D-Bus name or %NULL.
   *   path = A valid object path.
   *   interface_ = A valid D-Bus interface name or %NULL.
   *   method = A valid method name.
   * Returns: A #GDBusMessage. Free with [GObject.ObjectG.unref].
   */
  static DBusMessage newMethodCall(string name, string path, string interface_, string method)
  {
    GDBusMessage* _cretval;
    const(char)* _name = name.toCString(false);
    const(char)* _path = path.toCString(false);
    const(char)* _interface_ = interface_.toCString(false);
    const(char)* _method = method.toCString(false);
    _cretval = g_dbus_message_new_method_call(_name, _path, _interface_, _method);
    auto _retval = _cretval ? ObjectG.getDObject!DBusMessage(cast(GDBusMessage*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Creates a new #GDBusMessage for a signal emission.
   * Params:
   *   path = A valid object path.
   *   interface_ = A valid D-Bus interface name.
   *   signal = A valid signal name.
   * Returns: A #GDBusMessage. Free with [GObject.ObjectG.unref].
   */
  static DBusMessage newSignal(string path, string interface_, string signal)
  {
    GDBusMessage* _cretval;
    const(char)* _path = path.toCString(false);
    const(char)* _interface_ = interface_.toCString(false);
    const(char)* _signal = signal.toCString(false);
    _cretval = g_dbus_message_new_signal(_path, _interface_, _signal);
    auto _retval = _cretval ? ObjectG.getDObject!DBusMessage(cast(GDBusMessage*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Utility function to calculate how many bytes are needed to
   * completely deserialize the D-Bus message stored at blob.
   * Params:
   *   blob = A blob representing a binary D-Bus message.
   * Returns: Number of bytes needed or -1 if error is set $(LPAREN)e.g. if
   *   blob contains invalid data or not enough data is available to
   *   determine the size$(RPAREN).
   */
  static ptrdiff_t bytesNeeded(ubyte[] blob)
  {
    ptrdiff_t _retval;
    size_t _blobLen;
    if (blob)
      _blobLen = cast(size_t)blob.length;

    auto _blob = cast(ubyte*)blob.ptr;
    GError *_err;
    _retval = g_dbus_message_bytes_needed(_blob, _blobLen, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Copies message. The copy is a deep copy and the returned
   * #GDBusMessage is completely identical except that it is guaranteed
   * to not be locked.
   * This operation can fail if e.g. message contains file descriptors
   * and the per-process or system-wide open files limit is reached.
   * Returns: A new #GDBusMessage or %NULL if error is set.
   *   Free with [GObject.ObjectG.unref].
   */
  DBusMessage copy()
  {
    GDBusMessage* _cretval;
    GError *_err;
    _cretval = g_dbus_message_copy(cast(GDBusMessage*)cPtr, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = _cretval ? ObjectG.getDObject!DBusMessage(cast(GDBusMessage*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Convenience to get the first item in the body of message.
   * See [Gio.DBusMessage.getArg0Path] for returning object-path-typed
   * arg0 values.
   * Returns: The string item or %NULL if the first item in the body of
   *   message is not a string.
   */
  string getArg0()
  {
    const(char)* _cretval;
    _cretval = g_dbus_message_get_arg0(cast(GDBusMessage*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Convenience to get the first item in the body of message.
   * See [Gio.DBusMessage.getArg0] for returning string-typed arg0 values.
   * Returns: The object path item or `NULL` if the first item in the
   *   body of message is not an object path.
   */
  string getArg0Path()
  {
    const(char)* _cretval;
    _cretval = g_dbus_message_get_arg0_path(cast(GDBusMessage*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Gets the body of a message.
   * Returns: A #GVariant or %NULL if the body is
   *   empty. Do not free, it is owned by message.
   */
  Variant getBody()
  {
    GVariant* _cretval;
    _cretval = g_dbus_message_get_body(cast(GDBusMessage*)cPtr);
    auto _retval = _cretval ? new Variant(cast(GVariant*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the byte order of message.
   * Returns: The byte order.
   */
  DBusMessageByteOrder getByteOrder()
  {
    GDBusMessageByteOrder _cretval;
    _cretval = g_dbus_message_get_byte_order(cast(GDBusMessage*)cPtr);
    DBusMessageByteOrder _retval = cast(DBusMessageByteOrder)_cretval;
    return _retval;
  }

  /**
   * Convenience getter for the %G_DBUS_MESSAGE_HEADER_FIELD_DESTINATION header field.
   * Returns: The value.
   */
  string getDestination()
  {
    const(char)* _cretval;
    _cretval = g_dbus_message_get_destination(cast(GDBusMessage*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Convenience getter for the %G_DBUS_MESSAGE_HEADER_FIELD_ERROR_NAME header field.
   * Returns: The value.
   */
  string getErrorName()
  {
    const(char)* _cretval;
    _cretval = g_dbus_message_get_error_name(cast(GDBusMessage*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Gets the flags for message.
   * Returns: Flags that are set $(LPAREN)typically values from the #GDBusMessageFlags enumeration bitwise ORed together$(RPAREN).
   */
  DBusMessageFlags getFlags()
  {
    GDBusMessageFlags _cretval;
    _cretval = g_dbus_message_get_flags(cast(GDBusMessage*)cPtr);
    DBusMessageFlags _retval = cast(DBusMessageFlags)_cretval;
    return _retval;
  }

  /**
   * Gets a header field on message.
   * The caller is responsible for checking the type of the returned #GVariant
   * matches what is expected.
   * Params:
   *   headerField = A 8-bit unsigned integer $(LPAREN)typically a value from the #GDBusMessageHeaderField enumeration$(RPAREN)
   * Returns: A #GVariant with the value if the header was found, %NULL
   *   otherwise. Do not free, it is owned by message.
   */
  Variant getHeader(DBusMessageHeaderField headerField)
  {
    GVariant* _cretval;
    _cretval = g_dbus_message_get_header(cast(GDBusMessage*)cPtr, headerField);
    auto _retval = _cretval ? new Variant(cast(GVariant*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets an array of all header fields on message that are set.
   * Returns: An array of header fields
   *   terminated by %G_DBUS_MESSAGE_HEADER_FIELD_INVALID.  Each element
   *   is a #guchar. Free with [GLib.Global.gfree].
   */
  ubyte[] getHeaderFields()
  {
    ubyte* _cretval;
    _cretval = g_dbus_message_get_header_fields(cast(GDBusMessage*)cPtr);
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
   * Convenience getter for the %G_DBUS_MESSAGE_HEADER_FIELD_INTERFACE header field.
   * Returns: The value.
   */
  string getInterface()
  {
    const(char)* _cretval;
    _cretval = g_dbus_message_get_interface(cast(GDBusMessage*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Checks whether message is locked. To monitor changes to this
   * value, conncet to the #GObject::notify signal to listen for changes
   * on the #GDBusMessage:locked property.
   * Returns: %TRUE if message is locked, %FALSE otherwise.
   */
  bool getLocked()
  {
    bool _retval;
    _retval = g_dbus_message_get_locked(cast(GDBusMessage*)cPtr);
    return _retval;
  }

  /**
   * Convenience getter for the %G_DBUS_MESSAGE_HEADER_FIELD_MEMBER header field.
   * Returns: The value.
   */
  string getMember()
  {
    const(char)* _cretval;
    _cretval = g_dbus_message_get_member(cast(GDBusMessage*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Gets the type of message.
   * Returns: A 8-bit unsigned integer $(LPAREN)typically a value from the #GDBusMessageType enumeration$(RPAREN).
   */
  DBusMessageType getMessageType()
  {
    GDBusMessageType _cretval;
    _cretval = g_dbus_message_get_message_type(cast(GDBusMessage*)cPtr);
    DBusMessageType _retval = cast(DBusMessageType)_cretval;
    return _retval;
  }

  /**
   * Convenience getter for the %G_DBUS_MESSAGE_HEADER_FIELD_NUM_UNIX_FDS header field.
   * Returns: The value.
   */
  uint getNumUnixFds()
  {
    uint _retval;
    _retval = g_dbus_message_get_num_unix_fds(cast(GDBusMessage*)cPtr);
    return _retval;
  }

  /**
   * Convenience getter for the %G_DBUS_MESSAGE_HEADER_FIELD_PATH header field.
   * Returns: The value.
   */
  string getPath()
  {
    const(char)* _cretval;
    _cretval = g_dbus_message_get_path(cast(GDBusMessage*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Convenience getter for the %G_DBUS_MESSAGE_HEADER_FIELD_REPLY_SERIAL header field.
   * Returns: The value.
   */
  uint getReplySerial()
  {
    uint _retval;
    _retval = g_dbus_message_get_reply_serial(cast(GDBusMessage*)cPtr);
    return _retval;
  }

  /**
   * Convenience getter for the %G_DBUS_MESSAGE_HEADER_FIELD_SENDER header field.
   * Returns: The value.
   */
  string getSender()
  {
    const(char)* _cretval;
    _cretval = g_dbus_message_get_sender(cast(GDBusMessage*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Gets the serial for message.
   * Returns: A #guint32.
   */
  uint getSerial()
  {
    uint _retval;
    _retval = g_dbus_message_get_serial(cast(GDBusMessage*)cPtr);
    return _retval;
  }

  /**
   * Convenience getter for the %G_DBUS_MESSAGE_HEADER_FIELD_SIGNATURE header field.
   * This will always be non-%NULL, but may be an empty string.
   * Returns: The value.
   */
  string getSignature()
  {
    const(char)* _cretval;
    _cretval = g_dbus_message_get_signature(cast(GDBusMessage*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Gets the UNIX file descriptors associated with message, if any.
   * This method is only available on UNIX.
   * The file descriptors normally correspond to %G_VARIANT_TYPE_HANDLE
   * values in the body of the message. For example,
   * if [GLib.Variant.getHandle] returns 5, that is intended to be a reference
   * to the file descriptor that can be accessed by
   * `g_unix_fd_list_get $(LPAREN)list, 5, ...$(RPAREN)`.
   * Returns: A #GUnixFDList or %NULL if no file descriptors are
   *   associated. Do not free, this object is owned by message.
   */
  UnixFDList getUnixFdList()
  {
    GUnixFDList* _cretval;
    _cretval = g_dbus_message_get_unix_fd_list(cast(GDBusMessage*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!UnixFDList(cast(GUnixFDList*)_cretval, false) : null;
    return _retval;
  }

  /**
   * If message is locked, does nothing. Otherwise locks the message.
   */
  void lock()
  {
    g_dbus_message_lock(cast(GDBusMessage*)cPtr);
  }

  /**
   * Creates a new #GDBusMessage that is an error reply to method_call_message.
   * Params:
   *   errorName = A valid D-Bus error name.
   *   errorMessage = The D-Bus error message.
   * Returns: A #GDBusMessage. Free with [GObject.ObjectG.unref].
   */
  DBusMessage newMethodErrorLiteral(string errorName, string errorMessage)
  {
    GDBusMessage* _cretval;
    const(char)* _errorName = errorName.toCString(false);
    const(char)* _errorMessage = errorMessage.toCString(false);
    _cretval = g_dbus_message_new_method_error_literal(cast(GDBusMessage*)cPtr, _errorName, _errorMessage);
    auto _retval = _cretval ? ObjectG.getDObject!DBusMessage(cast(GDBusMessage*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Creates a new #GDBusMessage that is a reply to method_call_message.
   * Returns: #GDBusMessage. Free with [GObject.ObjectG.unref].
   */
  DBusMessage newMethodReply()
  {
    GDBusMessage* _cretval;
    _cretval = g_dbus_message_new_method_reply(cast(GDBusMessage*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!DBusMessage(cast(GDBusMessage*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Produces a human-readable multi-line description of message.
   * The contents of the description has no ABI guarantees, the contents
   * and formatting is subject to change at any time. Typical output
   * looks something like this:
   * ```
   * Flags:   none
   * Version: 0
   * Serial:  4
   * Headers:
   * path -> objectpath '/org/gtk/GDBus/TestObject'
   * interface -> 'org.gtk.GDBus.TestInterface'
   * member -> 'GimmeStdout'
   * destination -> ':1.146'
   * Body: $(LPAREN)$(RPAREN)
   * UNIX File Descriptors:
   * $(LPAREN)none$(RPAREN)
   * ```
   * or
   * ```
   * Flags:   no-reply-expected
   * Version: 0
   * Serial:  477
   * Headers:
   * reply-serial -> uint32 4
   * destination -> ':1.159'
   * sender -> ':1.146'
   * num-unix-fds -> uint32 1
   * Body: $(LPAREN)$(RPAREN)
   * UNIX File Descriptors:
   * fd 12: dev\=0:10,mode\=020620,ino\=5,uid\=500,gid\=5,rdev\=136:2,size\=0,atime\=1273085037,mtime\=1273085851,ctime\=1272982635
   * ```
   * Params:
   *   indent = Indentation level.
   * Returns: A string that should be freed with funcGLib.free.
   */
  string print(uint indent)
  {
    char* _cretval;
    _cretval = g_dbus_message_print(cast(GDBusMessage*)cPtr, indent);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * Sets the body message. As a side-effect the
   * %G_DBUS_MESSAGE_HEADER_FIELD_SIGNATURE header field is set to the
   * type string of body $(LPAREN)or cleared if body is %NULL$(RPAREN).
   * If body is floating, message assumes ownership of body.
   * Params:
   *   body_ = Either %NULL or a #GVariant that is a tuple.
   */
  void setBody(Variant body_)
  {
    g_dbus_message_set_body(cast(GDBusMessage*)cPtr, body_ ? cast(GVariant*)body_.cPtr(false) : null);
  }

  /**
   * Sets the byte order of message.
   * Params:
   *   byteOrder = The byte order.
   */
  void setByteOrder(DBusMessageByteOrder byteOrder)
  {
    g_dbus_message_set_byte_order(cast(GDBusMessage*)cPtr, byteOrder);
  }

  /**
   * Convenience setter for the %G_DBUS_MESSAGE_HEADER_FIELD_DESTINATION header field.
   * Params:
   *   value = The value to set.
   */
  void setDestination(string value)
  {
    const(char)* _value = value.toCString(false);
    g_dbus_message_set_destination(cast(GDBusMessage*)cPtr, _value);
  }

  /**
   * Convenience setter for the %G_DBUS_MESSAGE_HEADER_FIELD_ERROR_NAME header field.
   * Params:
   *   value = The value to set.
   */
  void setErrorName(string value)
  {
    const(char)* _value = value.toCString(false);
    g_dbus_message_set_error_name(cast(GDBusMessage*)cPtr, _value);
  }

  /**
   * Sets the flags to set on message.
   * Params:
   *   flags = Flags for message that are set $(LPAREN)typically values from the #GDBusMessageFlags
   *     enumeration bitwise ORed together$(RPAREN).
   */
  void setFlags(DBusMessageFlags flags)
  {
    g_dbus_message_set_flags(cast(GDBusMessage*)cPtr, flags);
  }

  /**
   * Sets a header field on message.
   * If value is floating, message assumes ownership of value.
   * Params:
   *   headerField = A 8-bit unsigned integer $(LPAREN)typically a value from the #GDBusMessageHeaderField enumeration$(RPAREN)
   *   value = A #GVariant to set the header field or %NULL to clear the header field.
   */
  void setHeader(DBusMessageHeaderField headerField, Variant value)
  {
    g_dbus_message_set_header(cast(GDBusMessage*)cPtr, headerField, value ? cast(GVariant*)value.cPtr(false) : null);
  }

  /**
   * Convenience setter for the %G_DBUS_MESSAGE_HEADER_FIELD_INTERFACE header field.
   * Params:
   *   value = The value to set.
   */
  void setInterface(string value)
  {
    const(char)* _value = value.toCString(false);
    g_dbus_message_set_interface(cast(GDBusMessage*)cPtr, _value);
  }

  /**
   * Convenience setter for the %G_DBUS_MESSAGE_HEADER_FIELD_MEMBER header field.
   * Params:
   *   value = The value to set.
   */
  void setMember(string value)
  {
    const(char)* _value = value.toCString(false);
    g_dbus_message_set_member(cast(GDBusMessage*)cPtr, _value);
  }

  /**
   * Sets message to be of type.
   * Params:
   *   type = A 8-bit unsigned integer $(LPAREN)typically a value from the #GDBusMessageType enumeration$(RPAREN).
   */
  void setMessageType(DBusMessageType type)
  {
    g_dbus_message_set_message_type(cast(GDBusMessage*)cPtr, type);
  }

  /**
   * Convenience setter for the %G_DBUS_MESSAGE_HEADER_FIELD_NUM_UNIX_FDS header field.
   * Params:
   *   value = The value to set.
   */
  void setNumUnixFds(uint value)
  {
    g_dbus_message_set_num_unix_fds(cast(GDBusMessage*)cPtr, value);
  }

  /**
   * Convenience setter for the %G_DBUS_MESSAGE_HEADER_FIELD_PATH header field.
   * Params:
   *   value = The value to set.
   */
  void setPath(string value)
  {
    const(char)* _value = value.toCString(false);
    g_dbus_message_set_path(cast(GDBusMessage*)cPtr, _value);
  }

  /**
   * Convenience setter for the %G_DBUS_MESSAGE_HEADER_FIELD_REPLY_SERIAL header field.
   * Params:
   *   value = The value to set.
   */
  void setReplySerial(uint value)
  {
    g_dbus_message_set_reply_serial(cast(GDBusMessage*)cPtr, value);
  }

  /**
   * Convenience setter for the %G_DBUS_MESSAGE_HEADER_FIELD_SENDER header field.
   * Params:
   *   value = The value to set.
   */
  void setSender(string value)
  {
    const(char)* _value = value.toCString(false);
    g_dbus_message_set_sender(cast(GDBusMessage*)cPtr, _value);
  }

  /**
   * Sets the serial for message.
   * Params:
   *   serial = A #guint32.
   */
  void setSerial(uint serial)
  {
    g_dbus_message_set_serial(cast(GDBusMessage*)cPtr, serial);
  }

  /**
   * Convenience setter for the %G_DBUS_MESSAGE_HEADER_FIELD_SIGNATURE header field.
   * Params:
   *   value = The value to set.
   */
  void setSignature(string value)
  {
    const(char)* _value = value.toCString(false);
    g_dbus_message_set_signature(cast(GDBusMessage*)cPtr, _value);
  }

  /**
   * Sets the UNIX file descriptors associated with message. As a
   * side-effect the %G_DBUS_MESSAGE_HEADER_FIELD_NUM_UNIX_FDS header
   * field is set to the number of fds in fd_list $(LPAREN)or cleared if
   * fd_list is %NULL$(RPAREN).
   * This method is only available on UNIX.
   * When designing D-Bus APIs that are intended to be interoperable,
   * please note that non-GDBus implementations of D-Bus can usually only
   * access file descriptors if they are referenced by a value of type
   * %G_VARIANT_TYPE_HANDLE in the body of the message.
   * Params:
   *   fdList = A #GUnixFDList or %NULL.
   */
  void setUnixFdList(UnixFDList fdList)
  {
    g_dbus_message_set_unix_fd_list(cast(GDBusMessage*)cPtr, fdList ? cast(GUnixFDList*)fdList.cPtr(false) : null);
  }

  /**
   * Serializes message to a blob. The byte order returned by
   * [Gio.DBusMessage.getByteOrder] will be used.
   * Params:
   *   capabilities = A #GDBusCapabilityFlags describing what protocol features are supported.
   * Returns: A pointer to a
   *   valid binary D-Bus message of out_size bytes generated by message
   *   or %NULL if error is set. Free with [GLib.Global.gfree].
   */
  ubyte[] toBlob(DBusCapabilityFlags capabilities)
  {
    ubyte* _cretval;
    size_t _cretlength;
    GError *_err;
    _cretval = g_dbus_message_to_blob(cast(GDBusMessage*)cPtr, &_cretlength, capabilities, &_err);
    if (_err)
      throw new ErrorG(_err);
    ubyte[] _retval;

    if (_cretval)
    {
      _retval = cast(ubyte[] )_cretval[0 .. _cretlength];
    }
    return _retval;
  }

  /**
   * If message is not of type %G_DBUS_MESSAGE_TYPE_ERROR does
   * nothing and returns %FALSE.
   * Otherwise this method encodes the error in message as a #GError
   * using g_dbus_error_set_dbus_error$(LPAREN)$(RPAREN) using the information in the
   * %G_DBUS_MESSAGE_HEADER_FIELD_ERROR_NAME header field of message as
   * well as the first string item in message's body.
   * Returns: %TRUE if error was set, %FALSE otherwise.
   */
  bool toGerror()
  {
    bool _retval;
    GError *_err;
    _retval = g_dbus_message_to_gerror(cast(GDBusMessage*)cPtr, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }
}
