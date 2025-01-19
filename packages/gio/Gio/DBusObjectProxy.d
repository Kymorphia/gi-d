module Gio.DBusObjectProxy;

import GObject.ObjectG;
import Gid.gid;
import Gio.DBusConnection;
import Gio.DBusObject;
import Gio.DBusObjectT;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * A `GDBusObjectProxy` is an object used to represent a remote object
 * with one or more D-Bus interfaces. Normally, you don’t instantiate
 * a `GDBusObjectProxy` yourself — typically [Gio.DBusObjectManagerClient]
 * is used to obtain it.
 */
class DBusObjectProxy : ObjectG, DBusObject
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
    return g_dbus_object_proxy_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin DBusObjectT!();

  /**
   * Creates a new #GDBusObjectProxy for the given connection and
   * object path.
   * Params:
   *   connection = a #GDBusConnection
   *   objectPath = the object path
   * Returns: a new #GDBusObjectProxy
   */
  this(DBusConnection connection, string objectPath)
  {
    GDBusObjectProxy* _cretval;
    const(char)* _objectPath = objectPath.toCString(false);
    _cretval = g_dbus_object_proxy_new(connection ? cast(GDBusConnection*)connection.cPtr(false) : null, _objectPath);
    this(_cretval, true);
  }

  /**
   * Gets the connection that proxy is for.
   * Returns: A #GDBusConnection. Do not free, the
   *   object is owned by proxy.
   */
  DBusConnection getConnection()
  {
    GDBusConnection* _cretval;
    _cretval = g_dbus_object_proxy_get_connection(cast(GDBusObjectProxy*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!DBusConnection(cast(GDBusConnection*)_cretval, false) : null;
    return _retval;
  }
}
