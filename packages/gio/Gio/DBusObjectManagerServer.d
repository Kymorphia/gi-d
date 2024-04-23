module Gio.DBusObjectManagerServer;

import GObject.ObjectG;
import GObject.Types;
import Gid.Gid;
import Gio.DBusConnection;
import Gio.DBusObjectManager;
import Gio.DBusObjectManagerT;
import Gio.DBusObjectSkeleton;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * #GDBusObjectManagerServer is used to export #GDBusObject instances using
 * the standardized
 * [org.freedesktop.DBus.ObjectManager](http://dbus.freedesktop.org/doc/dbus-specification.html#standard-interfaces-objectmanager)
 * interface. For example, remote D-Bus clients can get all objects
 * and properties in a single call. Additionally, any change in the
 * object hierarchy is broadcast using signals. This means that D-Bus
 * clients can keep caches up to date by only listening to D-Bus
 * signals.
 *
 * The recommended path to export an object manager at is the path form of the
 * well-known name of a D-Bus service, or below. For example, if a D-Bus service
 * is available at the well-known name `net.example.ExampleService1`, the object
 * manager should typically be exported at `/net/example/ExampleService1`, or
 * below (to allow for multiple object managers in a service).
 *
 * It is supported, but not recommended, to export an object manager at the root
 * path, `/`.
 *
 * See #GDBusObjectManagerClient for the client-side code that is
 * intended to be used with #GDBusObjectManagerServer or any D-Bus
 * object implementing the org.freedesktop.DBus.ObjectManager
 * interface.
 */
class DBusObjectManagerServer : ObjectG, DBusObjectManager
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_dbus_object_manager_server_get_type();
  }

  mixin DBusObjectManagerT!GDBusObjectManagerServer;

  /**
   * A #GDBusObjectManagerServer object. Free with g_object_unref().
   */
  this(string objectPath)
  {
    GDBusObjectManagerServer* _cretval;
    const(char)* _objectPath = objectPath.toCString(false);
    _cretval = g_dbus_object_manager_server_new(_objectPath);
    this(_cretval, true);
  }

  /**
   * Exports @object on @manager.
   *
   * If there is already a #GDBusObject exported at the object path,
   * then the old object is removed.
   *
   * The object path for @object must be in the hierarchy rooted by the
   * object path for @manager.
   *
   * Note that @manager will take a reference on @object for as long as
   * it is exported.
   */
  void export_(DBusObjectSkeleton object)
  {
    g_dbus_object_manager_server_export(cPtr!GDBusObjectManagerServer, object ? object.cPtr!GDBusObjectSkeleton : null);
  }

  /**
   * Like g_dbus_object_manager_server_export() but appends a string of
   * the form _N (with N being a natural number) to @object's object path
   * if an object with the given path already exists. As such, the
   * #GDBusObjectProxy:g-object-path property of @object may be modified.
   */
  void exportUniquely(DBusObjectSkeleton object)
  {
    g_dbus_object_manager_server_export_uniquely(cPtr!GDBusObjectManagerServer, object ? object.cPtr!GDBusObjectSkeleton : null);
  }

  /**
   * A #GDBusConnection object or %NULL if
   * @manager isn't exported on a connection. The returned object should
   * be freed with g_object_unref().
   */
  DBusConnection getConnection()
  {
    GDBusConnection* _cretval;
    _cretval = g_dbus_object_manager_server_get_connection(cPtr!GDBusObjectManagerServer);
    DBusConnection _retval = ObjectG.getDObject!DBusConnection(cast(GDBusConnection*)_cretval, true);
    return _retval;
  }

  /**
   * %TRUE if @object is exported
   */
  bool isExported(DBusObjectSkeleton object)
  {
    bool _retval;
    _retval = g_dbus_object_manager_server_is_exported(cPtr!GDBusObjectManagerServer, object ? object.cPtr!GDBusObjectSkeleton : null);
    return _retval;
  }

  /**
   * Exports all objects managed by @manager on @connection. If
   * @connection is %NULL, stops exporting objects.
   */
  void setConnection(DBusConnection connection)
  {
    g_dbus_object_manager_server_set_connection(cPtr!GDBusObjectManagerServer, connection ? connection.cPtr!GDBusConnection : null);
  }

  /**
   * %TRUE if object at @object_path was removed, %FALSE otherwise.
   */
  bool unexport(string objectPath)
  {
    bool _retval;
    const(char)* _objectPath = objectPath.toCString(false);
    _retval = g_dbus_object_manager_server_unexport(cPtr!GDBusObjectManagerServer, _objectPath);
    return _retval;
  }
}
