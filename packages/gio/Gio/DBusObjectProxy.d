module Gio.DBusObjectProxy;

import GObject.ObjectG;
import GObject.Types;
import Gid.Gid;
import Gio.DBusConnection;
import Gio.DBusObject;
import Gio.DBusObjectT;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * A #GDBusObjectProxy is an object used to represent a remote object
 * with one or more D-Bus interfaces. Normally, you don't instantiate
 * a #GDBusObjectProxy yourself - typically #GDBusObjectManagerClient
 * is used to obtain it.
 */
class DBusObjectProxy : ObjectG, DBusObject
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_dbus_object_proxy_get_type();
  }

  mixin DBusObjectT!GDBusObjectProxy;

  /**
   * a new #GDBusObjectProxy
   */
  this(DBusConnection connection, string objectPath)
  {
    GDBusObjectProxy* _cretval;
    const(char)* _objectPath = objectPath.toCString(false);
    _cretval = g_dbus_object_proxy_new(connection ? connection.cPtr!GDBusConnection : null, _objectPath);
    this(_cretval, true);
  }

  /**
   * A #GDBusConnection. Do not free, the
   * object is owned by @proxy.
   */
  DBusConnection getConnection()
  {
    GDBusConnection* _cretval;
    _cretval = g_dbus_object_proxy_get_connection(cPtr!GDBusObjectProxy);
    DBusConnection _retval = ObjectG.getDObject!DBusConnection(cast(GDBusConnection*)_cretval, false);
    return _retval;
  }
}
