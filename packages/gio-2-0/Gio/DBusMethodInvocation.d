module Gio.DBusMethodInvocation;

import GLib.ErrorG;
import GLib.Types;
import GLib.VariantG;
import GObject.ObjectG;
import Gid.gid;
import Gio.DBusConnection;
import Gio.DBusMessage;
import Gio.DBusMethodInfo;
import Gio.DBusPropertyInfo;
import Gio.Types;
import Gio.UnixFDList;
import Gio.c.functions;
import Gio.c.types;

/**
 * Instances of the `GDBusMethodInvocation` class are used when
 * handling D-Bus method calls. It provides a way to asynchronously
 * return results and errors.
 * The normal way to obtain a `GDBusMethodInvocation` object is to receive
 * it as an argument to the `handle_method_call$(LPAREN)$(RPAREN)` function in a
 * [Gio.DBusInterfaceVTable] that was passed to
 * [Gio.DBusConnection.registerObject].
 */
class DBusMethodInvocation : ObjectG
{

  this()
  {
  }

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_dbus_method_invocation_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Gets the #GDBusConnection the method was invoked on.
   * Returns: A #GDBusConnection. Do not free, it is owned by invocation.
   */
  DBusConnection getConnection()
  {
    GDBusConnection* _cretval;
    _cretval = g_dbus_method_invocation_get_connection(cast(GDBusMethodInvocation*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!DBusConnection(cast(GDBusConnection*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the name of the D-Bus interface the method was invoked on.
   * If this method call is a property Get, Set or GetAll call that has
   * been redirected to the method call handler then
   * "org.freedesktop.DBus.Properties" will be returned.  See
   * #GDBusInterfaceVTable for more information.
   * Returns: A string. Do not free, it is owned by invocation.
   */
  string getInterfaceName()
  {
    const(char)* _cretval;
    _cretval = g_dbus_method_invocation_get_interface_name(cast(GDBusMethodInvocation*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Gets the #GDBusMessage for the method invocation. This is useful if
   * you need to use low-level protocol features, such as UNIX file
   * descriptor passing, that cannot be properly expressed in the
   * #GVariant API.
   * See this [server][gdbus-server] and [client][gdbus-unix-fd-client]
   * for an example of how to use this low-level API to send and receive
   * UNIX file descriptors.
   * Returns: #GDBusMessage. Do not free, it is owned by invocation.
   */
  DBusMessage getMessage()
  {
    GDBusMessage* _cretval;
    _cretval = g_dbus_method_invocation_get_message(cast(GDBusMethodInvocation*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!DBusMessage(cast(GDBusMessage*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets information about the method call, if any.
   * If this method invocation is a property Get, Set or GetAll call that
   * has been redirected to the method call handler then %NULL will be
   * returned.  See [Gio.DBusMethodInvocation.getPropertyInfo] and
   * #GDBusInterfaceVTable for more information.
   * Returns: A #GDBusMethodInfo or %NULL. Do not free, it is owned by invocation.
   */
  DBusMethodInfo getMethodInfo()
  {
    const(GDBusMethodInfo)* _cretval;
    _cretval = g_dbus_method_invocation_get_method_info(cast(GDBusMethodInvocation*)cPtr);
    auto _retval = _cretval ? new DBusMethodInfo(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the name of the method that was invoked.
   * Returns: A string. Do not free, it is owned by invocation.
   */
  string getMethodName()
  {
    const(char)* _cretval;
    _cretval = g_dbus_method_invocation_get_method_name(cast(GDBusMethodInvocation*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Gets the object path the method was invoked on.
   * Returns: A string. Do not free, it is owned by invocation.
   */
  string getObjectPath()
  {
    const(char)* _cretval;
    _cretval = g_dbus_method_invocation_get_object_path(cast(GDBusMethodInvocation*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Gets the parameters of the method invocation. If there are no input
   * parameters then this will return a GVariant with 0 children rather than NULL.
   * Returns: A #GVariant tuple. Do not unref this because it is owned by invocation.
   */
  VariantG getParameters()
  {
    VariantC* _cretval;
    _cretval = g_dbus_method_invocation_get_parameters(cast(GDBusMethodInvocation*)cPtr);
    auto _retval = _cretval ? new VariantG(cast(VariantC*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets information about the property that this method call is for, if
   * any.
   * This will only be set in the case of an invocation in response to a
   * property Get or Set call that has been directed to the method call
   * handler for an object on account of its property_get$(LPAREN)$(RPAREN) or
   * property_set$(LPAREN)$(RPAREN) vtable pointers being unset.
   * See #GDBusInterfaceVTable for more information.
   * If the call was GetAll, %NULL will be returned.
   * Returns: a #GDBusPropertyInfo or %NULL
   */
  DBusPropertyInfo getPropertyInfo()
  {
    const(GDBusPropertyInfo)* _cretval;
    _cretval = g_dbus_method_invocation_get_property_info(cast(GDBusMethodInvocation*)cPtr);
    auto _retval = _cretval ? new DBusPropertyInfo(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the bus name that invoked the method.
   * Returns: A string. Do not free, it is owned by invocation.
   */
  string getSender()
  {
    const(char)* _cretval;
    _cretval = g_dbus_method_invocation_get_sender(cast(GDBusMethodInvocation*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Finishes handling a D-Bus method call by returning an error.
   * This method will take ownership of invocation. See
   * #GDBusInterfaceVTable for more information about the ownership of
   * invocation.
   * Params:
   *   errorName = A valid D-Bus error name.
   *   errorMessage = A valid D-Bus error message.
   */
  void returnDbusError(string errorName, string errorMessage)
  {
    const(char)* _errorName = errorName.toCString(false);
    const(char)* _errorMessage = errorMessage.toCString(false);
    g_dbus_method_invocation_return_dbus_error(cast(GDBusMethodInvocation*)cPtr, _errorName, _errorMessage);
  }

  /**
   * Like [Gio.DBusMethodInvocation.returnError] but without printf()-style formatting.
   * This method will take ownership of invocation. See
   * #GDBusInterfaceVTable for more information about the ownership of
   * invocation.
   * Params:
   *   domain = A #GQuark for the #GError error domain.
   *   code = The error code.
   *   message = The error message.
   */
  void returnErrorLiteral(Quark domain, int code, string message)
  {
    const(char)* _message = message.toCString(false);
    g_dbus_method_invocation_return_error_literal(cast(GDBusMethodInvocation*)cPtr, domain, code, _message);
  }

  /**
   * Like [Gio.DBusMethodInvocation.returnError] but takes a #GError
   * instead of the error domain, error code and message.
   * This method will take ownership of invocation. See
   * #GDBusInterfaceVTable for more information about the ownership of
   * invocation.
   * Params:
   *   error = A #GError.
   */
  void returnGerror(ErrorG error)
  {
    g_dbus_method_invocation_return_gerror(cast(GDBusMethodInvocation*)cPtr, error ? cast(GError*)error.cPtr : null);
  }

  /**
   * Finishes handling a D-Bus method call by returning parameters.
   * If the parameters GVariant is floating, it is consumed.
   * It is an error if parameters is not of the right format: it must be a tuple
   * containing the out-parameters of the D-Bus method. Even if the method has a
   * single out-parameter, it must be contained in a tuple. If the method has no
   * out-parameters, parameters may be %NULL or an empty tuple.
   * |[<!-- language\="C" -->
   * GDBusMethodInvocation *invocation \= some_invocation;
   * g_autofree gchar *result_string \= NULL;
   * g_autoptr $(LPAREN)GError$(RPAREN) error \= NULL;
   * result_string \= calculate_result $(LPAREN)&error$(RPAREN);
   * if $(LPAREN)error !\= NULL$(RPAREN)
   * g_dbus_method_invocation_return_gerror $(LPAREN)invocation, error$(RPAREN);
   * else
   * g_dbus_method_invocation_return_value $(LPAREN)invocation,
   * g_variant_new $(LPAREN)"$(LPAREN)s$(RPAREN)", result_string$(RPAREN)$(RPAREN);
   * // Do not free invocation here; returning a value does that
   * ]|
   * This method will take ownership of invocation. See
   * #GDBusInterfaceVTable for more information about the ownership of
   * invocation.
   * Since 2.48, if the method call requested for a reply not to be sent
   * then this call will sink parameters and free invocation, but
   * otherwise do nothing $(LPAREN)as per the recommendations of the D-Bus
   * specification$(RPAREN).
   * Params:
   *   parameters = A #GVariant tuple with out parameters for the method or %NULL if not passing any parameters.
   */
  void returnValue(VariantG parameters)
  {
    g_dbus_method_invocation_return_value(cast(GDBusMethodInvocation*)cPtr, parameters ? cast(VariantC*)parameters.cPtr(false) : null);
  }

  /**
   * Like [Gio.DBusMethodInvocation.returnValue] but also takes a #GUnixFDList.
   * This method is only available on UNIX.
   * This method will take ownership of invocation. See
   * #GDBusInterfaceVTable for more information about the ownership of
   * invocation.
   * Params:
   *   parameters = A #GVariant tuple with out parameters for the method or %NULL if not passing any parameters.
   *   fdList = A #GUnixFDList or %NULL.
   */
  void returnValueWithUnixFdList(VariantG parameters, UnixFDList fdList)
  {
    g_dbus_method_invocation_return_value_with_unix_fd_list(cast(GDBusMethodInvocation*)cPtr, parameters ? cast(VariantC*)parameters.cPtr(false) : null, fdList ? cast(GUnixFDList*)fdList.cPtr(false) : null);
  }
}
