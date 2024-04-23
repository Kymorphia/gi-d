module Gio.DBusMethodInvocation;

import GLib.ErrorG;
import GLib.Types;
import GLib.Variant;
import GObject.ObjectG;
import GObject.Types;
import Gid.Gid;
import Gio.DBusConnection;
import Gio.DBusMessage;
import Gio.DBusMethodInfo;
import Gio.DBusPropertyInfo;
import Gio.Types;
import Gio.UnixFDList;
import Gio.c.functions;
import Gio.c.types;

/**
 * Instances of the #GDBusMethodInvocation class are used when
 * handling D-Bus method calls. It provides a way to asynchronously
 * return results and errors.
 *
 * The normal way to obtain a #GDBusMethodInvocation object is to receive
 * it as an argument to the handle_method_call() function in a
 * #GDBusInterfaceVTable that was passed to g_dbus_connection_register_object().
 */
class DBusMethodInvocation : ObjectG
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_dbus_method_invocation_get_type();
  }

  /**
   * A #GDBusConnection. Do not free, it is owned by @invocation.
   */
  DBusConnection getConnection()
  {
    GDBusConnection* _cretval;
    _cretval = g_dbus_method_invocation_get_connection(cPtr!GDBusMethodInvocation);
    DBusConnection _retval = ObjectG.getDObject!DBusConnection(cast(GDBusConnection*)_cretval, false);
    return _retval;
  }

  /**
   * A string. Do not free, it is owned by @invocation.
   */
  string getInterfaceName()
  {
    const(char)* _cretval;
    _cretval = g_dbus_method_invocation_get_interface_name(cPtr!GDBusMethodInvocation);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * #GDBusMessage. Do not free, it is owned by @invocation.
   */
  DBusMessage getMessage()
  {
    GDBusMessage* _cretval;
    _cretval = g_dbus_method_invocation_get_message(cPtr!GDBusMethodInvocation);
    DBusMessage _retval = ObjectG.getDObject!DBusMessage(cast(GDBusMessage*)_cretval, false);
    return _retval;
  }

  /**
   * A #GDBusMethodInfo or %NULL. Do not free, it is owned by @invocation.
   */
  DBusMethodInfo getMethodInfo()
  {
    const(GDBusMethodInfo)* _cretval;
    _cretval = g_dbus_method_invocation_get_method_info(cPtr!GDBusMethodInvocation);
    DBusMethodInfo _retval = new DBusMethodInfo(cast(GDBusMethodInfo*)_cretval, false);
    return _retval;
  }

  /**
   * A string. Do not free, it is owned by @invocation.
   */
  string getMethodName()
  {
    const(char)* _cretval;
    _cretval = g_dbus_method_invocation_get_method_name(cPtr!GDBusMethodInvocation);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * A string. Do not free, it is owned by @invocation.
   */
  string getObjectPath()
  {
    const(char)* _cretval;
    _cretval = g_dbus_method_invocation_get_object_path(cPtr!GDBusMethodInvocation);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * A #GVariant tuple. Do not unref this because it is owned by @invocation.
   */
  Variant getParameters()
  {
    GVariant* _cretval;
    _cretval = g_dbus_method_invocation_get_parameters(cPtr!GDBusMethodInvocation);
    Variant _retval = new Variant(cast(GVariant*)_cretval, false);
    return _retval;
  }

  /**
   * a #GDBusPropertyInfo or %NULL
   */
  DBusPropertyInfo getPropertyInfo()
  {
    const(GDBusPropertyInfo)* _cretval;
    _cretval = g_dbus_method_invocation_get_property_info(cPtr!GDBusMethodInvocation);
    DBusPropertyInfo _retval = new DBusPropertyInfo(cast(GDBusPropertyInfo*)_cretval, false);
    return _retval;
  }

  /**
   * A string. Do not free, it is owned by @invocation.
   */
  string getSender()
  {
    const(char)* _cretval;
    _cretval = g_dbus_method_invocation_get_sender(cPtr!GDBusMethodInvocation);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Finishes handling a D-Bus method call by returning an error.
   *
   * This method will take ownership of @invocation. See
   * #GDBusInterfaceVTable for more information about the ownership of
   * @invocation.
   */
  void returnDbusError(string errorName, string errorMessage)
  {
    const(char)* _errorName = errorName.toCString(false);
    const(char)* _errorMessage = errorMessage.toCString(false);
    g_dbus_method_invocation_return_dbus_error(cPtr!GDBusMethodInvocation, _errorName, _errorMessage);
  }

  /**
   * Like g_dbus_method_invocation_return_error() but without printf()-style formatting.
   *
   * This method will take ownership of @invocation. See
   * #GDBusInterfaceVTable for more information about the ownership of
   * @invocation.
   */
  void returnErrorLiteral(Quark domain, int code, string message)
  {
    const(char)* _message = message.toCString(false);
    g_dbus_method_invocation_return_error_literal(cPtr!GDBusMethodInvocation, domain, code, _message);
  }

  /**
   * Like g_dbus_method_invocation_return_error() but takes a #GError
   * instead of the error domain, error code and message.
   *
   * This method will take ownership of @invocation. See
   * #GDBusInterfaceVTable for more information about the ownership of
   * @invocation.
   */
  void returnGerror(ErrorG error)
  {
    g_dbus_method_invocation_return_gerror(cPtr!GDBusMethodInvocation, error ? error.cPtr!GError : null);
  }

  /**
   * Finishes handling a D-Bus method call by returning @parameters.
   * If the @parameters GVariant is floating, it is consumed.
   *
   * It is an error if @parameters is not of the right format: it must be a tuple
   * containing the out-parameters of the D-Bus method. Even if the method has a
   * single out-parameter, it must be contained in a tuple. If the method has no
   * out-parameters, @parameters may be %NULL or an empty tuple.
   *
   * |[<!-- language="C" -->
   * GDBusMethodInvocation *invocation = some_invocation;
   * g_autofree gchar *result_string = NULL;
   * g_autoptr (GError) error = NULL;
   *
   * result_string = calculate_result (&error);
   *
   * if (error != NULL)
   * g_dbus_method_invocation_return_gerror (invocation, error);
   * else
   * g_dbus_method_invocation_return_value (invocation,
   * g_variant_new ("(s)", result_string));
   *
   * // Do not free @invocation here; returning a value does that
   * ]|
   *
   * This method will take ownership of @invocation. See
   * #GDBusInterfaceVTable for more information about the ownership of
   * @invocation.
   *
   * Since 2.48, if the method call requested for a reply not to be sent
   * then this call will sink @parameters and free @invocation, but
   * otherwise do nothing (as per the recommendations of the D-Bus
   * specification).
   */
  void returnValue(Variant parameters)
  {
    g_dbus_method_invocation_return_value(cPtr!GDBusMethodInvocation, parameters ? parameters.cPtr!GVariant : null);
  }

  /**
   * Like g_dbus_method_invocation_return_value() but also takes a #GUnixFDList.
   *
   * This method is only available on UNIX.
   *
   * This method will take ownership of @invocation. See
   * #GDBusInterfaceVTable for more information about the ownership of
   * @invocation.
   */
  void returnValueWithUnixFdList(Variant parameters, UnixFDList fdList)
  {
    g_dbus_method_invocation_return_value_with_unix_fd_list(cPtr!GDBusMethodInvocation, parameters ? parameters.cPtr!GVariant : null, fdList ? fdList.cPtr!GUnixFDList : null);
  }
}
