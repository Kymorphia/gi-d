module Gio.DBusObjectManager;

import GLib.List;
import GObject.DClosure;
import GObject.ObjectG;
import GObject.Types;
import Gid.gid;
import Gio.DBusInterface;
import Gio.DBusInterfaceT;
import Gio.DBusObject;
import Gio.DBusObjectT;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * The `GDBusObjectManager` type is the base type for service- and
 * client-side implementations of the standardized
 * [`org.freedesktop.DBus.ObjectManager`](http://dbus.freedesktop.org/doc/dbus-specification.html#standard-interfaces-objectmanager)
 * interface.
 * See [Gio.DBusObjectManagerClient] for the client-side implementation
 * and [Gio.DBusObjectManagerServer] for the service-side implementation.
 */
interface DBusObjectManager
{

  static GType getType()
  {
    return g_dbus_object_manager_get_type();
  }

  /**
   * Gets the interface proxy for interface_name at object_path, if
   * any.
   * Params:
   *   objectPath = Object path to look up.
   *   interfaceName = D-Bus interface name to look up.
   * Returns: A #GDBusInterface instance or %NULL. Free
   *   with [GObject.ObjectG.unref].
   */
  DBusInterface getInterface(string objectPath, string interfaceName);

  /**
   * Gets the #GDBusObject at object_path, if any.
   * Params:
   *   objectPath = Object path to look up.
   * Returns: A #GDBusObject or %NULL. Free with
   *   [GObject.ObjectG.unref].
   */
  DBusObject getObject(string objectPath);

  /**
   * Gets the object path that manager is for.
   * Returns: A string owned by manager. Do not free.
   */
  string getObjectPath();

  /**
   * Gets all #GDBusObject objects known to manager.
   * Returns: A list of
   *   #GDBusObject objects. The returned list should be freed with
   *   [GLib.List.free] after each element has been freed with
   *   [GObject.ObjectG.unref].
   */
  List!(DBusObject, GDBusObject) getObjects();

  /**
   * Emitted when interface is added to object.
   * This signal exists purely as a convenience to avoid having to
   * connect signals to all objects managed by manager.
   * Params
   *   object = The #GDBusObject on which an interface was added.
   *   interface_ = The #GDBusInterface that was added.
   *   dBusObjectManager = the instance the signal is connected to
   */
  alias InterfaceAddedCallback = void delegate(DBusObject object, DBusInterface interface_, DBusObjectManager dBusObjectManager);

  /**
   * Connect to InterfaceAdded signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectInterfaceAdded(InterfaceAddedCallback dlg, ConnectFlags flags = ConnectFlags.Default);

  /**
   * Emitted when interface has been removed from object.
   * This signal exists purely as a convenience to avoid having to
   * connect signals to all objects managed by manager.
   * Params
   *   object = The #GDBusObject on which an interface was removed.
   *   interface_ = The #GDBusInterface that was removed.
   *   dBusObjectManager = the instance the signal is connected to
   */
  alias InterfaceRemovedCallback = void delegate(DBusObject object, DBusInterface interface_, DBusObjectManager dBusObjectManager);

  /**
   * Connect to InterfaceRemoved signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectInterfaceRemoved(InterfaceRemovedCallback dlg, ConnectFlags flags = ConnectFlags.Default);

  /**
   * Emitted when object is added to manager.
   * Params
   *   object = The #GDBusObject that was added.
   *   dBusObjectManager = the instance the signal is connected to
   */
  alias ObjectAddedCallback = void delegate(DBusObject object, DBusObjectManager dBusObjectManager);

  /**
   * Connect to ObjectAdded signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectObjectAdded(ObjectAddedCallback dlg, ConnectFlags flags = ConnectFlags.Default);

  /**
   * Emitted when object is removed from manager.
   * Params
   *   object = The #GDBusObject that was removed.
   *   dBusObjectManager = the instance the signal is connected to
   */
  alias ObjectRemovedCallback = void delegate(DBusObject object, DBusObjectManager dBusObjectManager);

  /**
   * Connect to ObjectRemoved signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectObjectRemoved(ObjectRemovedCallback dlg, ConnectFlags flags = ConnectFlags.Default);
}
