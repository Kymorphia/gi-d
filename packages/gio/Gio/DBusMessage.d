module Gio.DBusMessage;

import GLib.ErrorG;
import GLib.Types;
import GLib.Variant;
import GObject.ObjectG;
import GObject.Types;
import Gid.Gid;
import Gio.Types;
import Gio.UnixFDList;
import Gio.c.functions;
import Gio.c.types;

/**
 * A type for representing D-Bus messages that can be sent or received
 * on a #GDBusConnection.
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

  /**
   * A #GDBusMessage. Free with g_object_unref().
   */
  this()
  {
    GDBusMessage* _cretval;
    _cretval = g_dbus_message_new();
    this(_cretval, true);
  }

  /**
   * A new #GDBusMessage or %NULL if @error is set. Free with
   * g_object_unref().
   */
  static DBusMessage newFromBlob(ubyte[] blob, DBusCapabilityFlags capabilities)
  {
    GDBusMessage* _cretval;
    auto _blob = cast(ubyte*)blob.ptr;
    GError *_err;
    _cretval = g_dbus_message_new_from_blob(_blob, blob ? cast(size_t)blob.length : 0, capabilities, &_err);
    if (_err)
      throw new ErrorG(_err);
    DBusMessage _retval = ObjectG.getDObject!DBusMessage(cast(GDBusMessage*)_cretval, true);
    return _retval;
  }

  /**
   * A #GDBusMessage. Free with g_object_unref().
   */
  static DBusMessage newMethodCall(string name, string path, string interface_, string method)
  {
    GDBusMessage* _cretval;
    const(char)* _name = name.toCString(false);
    const(char)* _path = path.toCString(false);
    const(char)* _interface_ = interface_.toCString(false);
    const(char)* _method = method.toCString(false);
    _cretval = g_dbus_message_new_method_call(_name, _path, _interface_, _method);
    DBusMessage _retval = ObjectG.getDObject!DBusMessage(cast(GDBusMessage*)_cretval, true);
    return _retval;
  }

  /**
   * A #GDBusMessage. Free with g_object_unref().
   */
  static DBusMessage newSignal(string path, string interface_, string signal)
  {
    GDBusMessage* _cretval;
    const(char)* _path = path.toCString(false);
    const(char)* _interface_ = interface_.toCString(false);
    const(char)* _signal = signal.toCString(false);
    _cretval = g_dbus_message_new_signal(_path, _interface_, _signal);
    DBusMessage _retval = ObjectG.getDObject!DBusMessage(cast(GDBusMessage*)_cretval, true);
    return _retval;
  }

  /**
   * Number of bytes needed or -1 if @error is set (e.g. if
   * @blob contains invalid data or not enough data is available to
   * determine the size).
   */
  static ptrdiff_t bytesNeeded(ubyte[] blob)
  {
    ptrdiff_t _retval;
    auto _blob = cast(ubyte*)blob.ptr;
    GError *_err;
    _retval = g_dbus_message_bytes_needed(_blob, blob ? cast(size_t)blob.length : 0, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * A new #GDBusMessage or %NULL if @error is set.
   * Free with g_object_unref().
   */
  DBusMessage copy()
  {
    GDBusMessage* _cretval;
    GError *_err;
    _cretval = g_dbus_message_copy(cPtr!GDBusMessage, &_err);
    if (_err)
      throw new ErrorG(_err);
    DBusMessage _retval = ObjectG.getDObject!DBusMessage(cast(GDBusMessage*)_cretval, true);
    return _retval;
  }

  /**
   * The string item or %NULL if the first item in the body of
   * @message is not a string.
   */
  string getArg0()
  {
    const(char)* _cretval;
    _cretval = g_dbus_message_get_arg0(cPtr!GDBusMessage);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * A #GVariant or %NULL if the body is
   * empty. Do not free, it is owned by @message.
   */
  Variant getBody()
  {
    GVariant* _cretval;
    _cretval = g_dbus_message_get_body(cPtr!GDBusMessage);
    Variant _retval = new Variant(cast(GVariant*)_cretval, false);
    return _retval;
  }

  /**
   * The byte order.
   */
  DBusMessageByteOrder getByteOrder()
  {
    GDBusMessageByteOrder _cretval;
    _cretval = g_dbus_message_get_byte_order(cPtr!GDBusMessage);
    DBusMessageByteOrder _retval = cast(DBusMessageByteOrder)_cretval;
    return _retval;
  }

  /**
   * The value.
   */
  string getDestination()
  {
    const(char)* _cretval;
    _cretval = g_dbus_message_get_destination(cPtr!GDBusMessage);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * The value.
   */
  string getErrorName()
  {
    const(char)* _cretval;
    _cretval = g_dbus_message_get_error_name(cPtr!GDBusMessage);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Flags that are set (typically values from the #GDBusMessageFlags enumeration bitwise ORed together).
   */
  DBusMessageFlags getFlags()
  {
    GDBusMessageFlags _cretval;
    _cretval = g_dbus_message_get_flags(cPtr!GDBusMessage);
    DBusMessageFlags _retval = cast(DBusMessageFlags)_cretval;
    return _retval;
  }

  /**
   * A #GVariant with the value if the header was found, %NULL
   * otherwise. Do not free, it is owned by @message.
   */
  Variant getHeader(DBusMessageHeaderField headerField)
  {
    GVariant* _cretval;
    _cretval = g_dbus_message_get_header(cPtr!GDBusMessage, headerField);
    Variant _retval = new Variant(cast(GVariant*)_cretval, false);
    return _retval;
  }

  /**
   * An array of header fields
   * terminated by %G_DBUS_MESSAGE_HEADER_FIELD_INVALID.  Each element
   * is a #guchar. Free with g_free().
   */
  ubyte[] getHeaderFields()
  {
    ubyte* _cretval;
    _cretval = g_dbus_message_get_header_fields(cPtr!GDBusMessage);
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
   * The value.
   */
  string getInterface()
  {
    const(char)* _cretval;
    _cretval = g_dbus_message_get_interface(cPtr!GDBusMessage);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * %TRUE if @message is locked, %FALSE otherwise.
   */
  bool getLocked()
  {
    bool _retval;
    _retval = g_dbus_message_get_locked(cPtr!GDBusMessage);
    return _retval;
  }

  /**
   * The value.
   */
  string getMember()
  {
    const(char)* _cretval;
    _cretval = g_dbus_message_get_member(cPtr!GDBusMessage);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * A 8-bit unsigned integer (typically a value from the #GDBusMessageType enumeration).
   */
  DBusMessageType getMessageType()
  {
    GDBusMessageType _cretval;
    _cretval = g_dbus_message_get_message_type(cPtr!GDBusMessage);
    DBusMessageType _retval = cast(DBusMessageType)_cretval;
    return _retval;
  }

  /**
   * The value.
   */
  uint getNumUnixFds()
  {
    uint _retval;
    _retval = g_dbus_message_get_num_unix_fds(cPtr!GDBusMessage);
    return _retval;
  }

  /**
   * The value.
   */
  string getPath()
  {
    const(char)* _cretval;
    _cretval = g_dbus_message_get_path(cPtr!GDBusMessage);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * The value.
   */
  uint getReplySerial()
  {
    uint _retval;
    _retval = g_dbus_message_get_reply_serial(cPtr!GDBusMessage);
    return _retval;
  }

  /**
   * The value.
   */
  string getSender()
  {
    const(char)* _cretval;
    _cretval = g_dbus_message_get_sender(cPtr!GDBusMessage);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * A #guint32.
   */
  uint getSerial()
  {
    uint _retval;
    _retval = g_dbus_message_get_serial(cPtr!GDBusMessage);
    return _retval;
  }

  /**
   * The value.
   */
  string getSignature()
  {
    const(char)* _cretval;
    _cretval = g_dbus_message_get_signature(cPtr!GDBusMessage);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * A #GUnixFDList or %NULL if no file descriptors are
   * associated. Do not free, this object is owned by @message.
   */
  UnixFDList getUnixFdList()
  {
    GUnixFDList* _cretval;
    _cretval = g_dbus_message_get_unix_fd_list(cPtr!GDBusMessage);
    UnixFDList _retval = ObjectG.getDObject!UnixFDList(cast(GUnixFDList*)_cretval, false);
    return _retval;
  }

  /**
   * If @message is locked, does nothing. Otherwise locks the message.
   */
  void lock()
  {
    g_dbus_message_lock(cPtr!GDBusMessage);
  }

  /**
   * A #GDBusMessage. Free with g_object_unref().
   */
  DBusMessage newMethodErrorLiteral(string errorName, string errorMessage)
  {
    GDBusMessage* _cretval;
    const(char)* _errorName = errorName.toCString(false);
    const(char)* _errorMessage = errorMessage.toCString(false);
    _cretval = g_dbus_message_new_method_error_literal(cPtr!GDBusMessage, _errorName, _errorMessage);
    DBusMessage _retval = ObjectG.getDObject!DBusMessage(cast(GDBusMessage*)_cretval, true);
    return _retval;
  }

  /**
   * #GDBusMessage. Free with g_object_unref().
   */
  DBusMessage newMethodReply()
  {
    GDBusMessage* _cretval;
    _cretval = g_dbus_message_new_method_reply(cPtr!GDBusMessage);
    DBusMessage _retval = ObjectG.getDObject!DBusMessage(cast(GDBusMessage*)_cretval, true);
    return _retval;
  }

  /**
   * A string that should be freed with g_free().
   */
  string print(uint indent)
  {
    char* _cretval;
    _cretval = g_dbus_message_print(cPtr!GDBusMessage, indent);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * Sets the body @message. As a side-effect the
   * %G_DBUS_MESSAGE_HEADER_FIELD_SIGNATURE header field is set to the
   * type string of @body (or cleared if @body is %NULL).
   *
   * If @body is floating, @message assumes ownership of @body.
   */
  void setBody(Variant body_)
  {
    g_dbus_message_set_body(cPtr!GDBusMessage, body_ ? body_.cPtr!GVariant : null);
  }

  /**
   * Sets the byte order of @message.
   */
  void setByteOrder(DBusMessageByteOrder byteOrder)
  {
    g_dbus_message_set_byte_order(cPtr!GDBusMessage, byteOrder);
  }

  /**
   * Convenience setter for the %G_DBUS_MESSAGE_HEADER_FIELD_DESTINATION header field.
   */
  void setDestination(string value)
  {
    const(char)* _value = value.toCString(false);
    g_dbus_message_set_destination(cPtr!GDBusMessage, _value);
  }

  /**
   * Convenience setter for the %G_DBUS_MESSAGE_HEADER_FIELD_ERROR_NAME header field.
   */
  void setErrorName(string value)
  {
    const(char)* _value = value.toCString(false);
    g_dbus_message_set_error_name(cPtr!GDBusMessage, _value);
  }

  /**
   * Sets the flags to set on @message.
   */
  void setFlags(DBusMessageFlags flags)
  {
    g_dbus_message_set_flags(cPtr!GDBusMessage, flags);
  }

  /**
   * Sets a header field on @message.
   *
   * If @value is floating, @message assumes ownership of @value.
   */
  void setHeader(DBusMessageHeaderField headerField, Variant value)
  {
    g_dbus_message_set_header(cPtr!GDBusMessage, headerField, value ? value.cPtr!GVariant : null);
  }

  /**
   * Convenience setter for the %G_DBUS_MESSAGE_HEADER_FIELD_INTERFACE header field.
   */
  void setInterface(string value)
  {
    const(char)* _value = value.toCString(false);
    g_dbus_message_set_interface(cPtr!GDBusMessage, _value);
  }

  /**
   * Convenience setter for the %G_DBUS_MESSAGE_HEADER_FIELD_MEMBER header field.
   */
  void setMember(string value)
  {
    const(char)* _value = value.toCString(false);
    g_dbus_message_set_member(cPtr!GDBusMessage, _value);
  }

  /**
   * Sets @message to be of @type.
   */
  void setMessageType(DBusMessageType type)
  {
    g_dbus_message_set_message_type(cPtr!GDBusMessage, type);
  }

  /**
   * Convenience setter for the %G_DBUS_MESSAGE_HEADER_FIELD_NUM_UNIX_FDS header field.
   */
  void setNumUnixFds(uint value)
  {
    g_dbus_message_set_num_unix_fds(cPtr!GDBusMessage, value);
  }

  /**
   * Convenience setter for the %G_DBUS_MESSAGE_HEADER_FIELD_PATH header field.
   */
  void setPath(string value)
  {
    const(char)* _value = value.toCString(false);
    g_dbus_message_set_path(cPtr!GDBusMessage, _value);
  }

  /**
   * Convenience setter for the %G_DBUS_MESSAGE_HEADER_FIELD_REPLY_SERIAL header field.
   */
  void setReplySerial(uint value)
  {
    g_dbus_message_set_reply_serial(cPtr!GDBusMessage, value);
  }

  /**
   * Convenience setter for the %G_DBUS_MESSAGE_HEADER_FIELD_SENDER header field.
   */
  void setSender(string value)
  {
    const(char)* _value = value.toCString(false);
    g_dbus_message_set_sender(cPtr!GDBusMessage, _value);
  }

  /**
   * Sets the serial for @message.
   */
  void setSerial(uint serial)
  {
    g_dbus_message_set_serial(cPtr!GDBusMessage, serial);
  }

  /**
   * Convenience setter for the %G_DBUS_MESSAGE_HEADER_FIELD_SIGNATURE header field.
   */
  void setSignature(string value)
  {
    const(char)* _value = value.toCString(false);
    g_dbus_message_set_signature(cPtr!GDBusMessage, _value);
  }

  /**
   * Sets the UNIX file descriptors associated with @message. As a
   * side-effect the %G_DBUS_MESSAGE_HEADER_FIELD_NUM_UNIX_FDS header
   * field is set to the number of fds in @fd_list (or cleared if
   * @fd_list is %NULL).
   *
   * This method is only available on UNIX.
   *
   * When designing D-Bus APIs that are intended to be interoperable,
   * please note that non-GDBus implementations of D-Bus can usually only
   * access file descriptors if they are referenced by a value of type
   * %G_VARIANT_TYPE_HANDLE in the body of the message.
   */
  void setUnixFdList(UnixFDList fdList)
  {
    g_dbus_message_set_unix_fd_list(cPtr!GDBusMessage, fdList ? fdList.cPtr!GUnixFDList : null);
  }

  /**
   * A pointer to a
   * valid binary D-Bus message of @out_size bytes generated by @message
   * or %NULL if @error is set. Free with g_free().
   */
  ubyte[] toBlob(DBusCapabilityFlags capabilities)
  {
    ubyte* _cretval;
    size_t _cretlength;
    GError *_err;
    _cretval = g_dbus_message_to_blob(cPtr!GDBusMessage, &_cretlength, capabilities, &_err);
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
   * %TRUE if @error was set, %FALSE otherwise.
   */
  bool toGerror()
  {
    bool _retval;
    GError *_err;
    _retval = g_dbus_message_to_gerror(cPtr!GDBusMessage, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }
}
