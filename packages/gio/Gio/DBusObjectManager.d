module Gio.DBusObjectManager;

import GLib.List;
import GLib.Types;
import GObject.DClosure;
import GObject.ObjectG;
import GObject.Types;
import Gid.Gid;
import Gio.DBusInterface;
import Gio.DBusObject;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * The #GDBusObjectManager type is the base type for service- and
 * client-side implementations of the standardized
 * [org.freedesktop.DBus.ObjectManager](http://dbus.freedesktop.org/doc/dbus-specification.html#standard-interfaces-objectmanager)
 * interface.
 *
 * See #GDBusObjectManagerClient for the client-side implementation
 * and #GDBusObjectManagerServer for the service-side implementation.
 */
interface DBusObjectManager
{

  static GType getType()
  {
    return g_dbus_object_manager_get_type();
  }

  /**
   * A #GDBusInterface instance or %NULL. Free
   * with g_object_unref().
   */
  DBusInterface getInterface(string objectPath, string interfaceName);

  /**
   * A #GDBusObject or %NULL. Free with
   * g_object_unref().
   */
  DBusObject getObject(string objectPath);

  /**
   * A string owned by @manager. Do not free.
   */
  string getObjectPath();

  /**
   * A list of
   * #GDBusObject objects. The returned list should be freed with
   * g_list_free() after each element has been freed with
   * g_object_unref().
   */
  List!(DBusObject, GDBusObject*) getObjects();

  /**
   * Emitted when @interface is added to @object.
   *
   * This signal exists purely as a convenience to avoid having to
   * connect signals to all objects managed by @manager.
   */
  ulong connectInterfaceAdded(void delegate(DBusObject object, DBusInterface interface_, DBusObjectManager dBusObjectManager) dlg, ConnectFlags flags = ConnectFlags.Default);

  /**
   * Emitted when @interface has been removed from @object.
   *
   * This signal exists purely as a convenience to avoid having to
   * connect signals to all objects managed by @manager.
   */
  ulong connectInterfaceRemoved(void delegate(DBusObject object, DBusInterface interface_, DBusObjectManager dBusObjectManager) dlg, ConnectFlags flags = ConnectFlags.Default);

  /**
   * Emitted when @object is added to @manager.
   */
  ulong connectObjectAdded(void delegate(DBusObject object, DBusObjectManager dBusObjectManager) dlg, ConnectFlags flags = ConnectFlags.Default);

  /**
   * Emitted when @object is removed from @manager.
   */
  ulong connectObjectRemoved(void delegate(DBusObject object, DBusObjectManager dBusObjectManager) dlg, ConnectFlags flags = ConnectFlags.Default);
}
