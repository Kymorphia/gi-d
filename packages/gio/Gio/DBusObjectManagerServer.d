module Gio.DBusObjectManagerServer;

import GObject.ObjectG;
import Gid.gid;
import Gio.DBusConnection;
import Gio.DBusObjectManager;
import Gio.DBusObjectManagerT;
import Gio.DBusObjectSkeleton;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

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
class DBusObjectManagerServer : ObjectG, DBusObjectManager
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
    return g_dbus_object_manager_server_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin DBusObjectManagerT!GDBusObjectManagerServer;

  /**
   * Creates a new #GDBusObjectManagerServer object.
   * The returned server isn't yet exported on any connection. To do so,
   * use [Gio.DBusObjectManagerServer.setConnection]. Normally you
   * want to export all of your objects before doing so to avoid
   * [InterfacesAdded](http://dbus.freedesktop.org/doc/dbus-specification.html#standard-interfaces-objectmanager)
   * signals being emitted.
   * Params:
   *   objectPath = The object path to export the manager object at.
   * Returns: A #GDBusObjectManagerServer object. Free with [GObject.ObjectG.unref].
   */
  this(string objectPath)
  {
    GDBusObjectManagerServer* _cretval;
    const(char)* _objectPath = objectPath.toCString(false);
    _cretval = g_dbus_object_manager_server_new(_objectPath);
    this(_cretval, true);
  }

  /**
   * Exports object on manager.
   * If there is already a #GDBusObject exported at the object path,
   * then the old object is removed.
   * The object path for object must be in the hierarchy rooted by the
   * object path for manager.
   * Note that manager will take a reference on object for as long as
   * it is exported.
   * Params:
   *   object = A #GDBusObjectSkeleton.
   */
  void export_(DBusObjectSkeleton object)
  {
    g_dbus_object_manager_server_export(cast(GDBusObjectManagerServer*)cPtr, object ? cast(GDBusObjectSkeleton*)object.cPtr(false) : null);
  }

  /**
   * Like [Gio.DBusObjectManagerServer.export_] but appends a string of
   * the form _N $(LPAREN)with N being a natural number$(RPAREN) to object's object path
   * if an object with the given path already exists. As such, the
   * #GDBusObjectProxy:g-object-path property of object may be modified.
   * Params:
   *   object = An object.
   */
  void exportUniquely(DBusObjectSkeleton object)
  {
    g_dbus_object_manager_server_export_uniquely(cast(GDBusObjectManagerServer*)cPtr, object ? cast(GDBusObjectSkeleton*)object.cPtr(false) : null);
  }

  /**
   * Gets the #GDBusConnection used by manager.
   * Returns: A #GDBusConnection object or %NULL if
   *   manager isn't exported on a connection. The returned object should
   *   be freed with [GObject.ObjectG.unref].
   */
  DBusConnection getConnection()
  {
    GDBusConnection* _cretval;
    _cretval = g_dbus_object_manager_server_get_connection(cast(GDBusObjectManagerServer*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!DBusConnection(cast(GDBusConnection*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Returns whether object is currently exported on manager.
   * Params:
   *   object = An object.
   * Returns: %TRUE if object is exported
   */
  bool isExported(DBusObjectSkeleton object)
  {
    bool _retval;
    _retval = g_dbus_object_manager_server_is_exported(cast(GDBusObjectManagerServer*)cPtr, object ? cast(GDBusObjectSkeleton*)object.cPtr(false) : null);
    return _retval;
  }

  /**
   * Exports all objects managed by manager on connection. If
   * connection is %NULL, stops exporting objects.
   * Params:
   *   connection = A #GDBusConnection or %NULL.
   */
  void setConnection(DBusConnection connection)
  {
    g_dbus_object_manager_server_set_connection(cast(GDBusObjectManagerServer*)cPtr, connection ? cast(GDBusConnection*)connection.cPtr(false) : null);
  }

  /**
   * If manager has an object at path, removes the object. Otherwise
   * does nothing.
   * Note that object_path must be in the hierarchy rooted by the
   * object path for manager.
   * Params:
   *   objectPath = An object path.
   * Returns: %TRUE if object at object_path was removed, %FALSE otherwise.
   */
  bool unexport(string objectPath)
  {
    bool _retval;
    const(char)* _objectPath = objectPath.toCString(false);
    _retval = g_dbus_object_manager_server_unexport(cast(GDBusObjectManagerServer*)cPtr, _objectPath);
    return _retval;
  }
}
