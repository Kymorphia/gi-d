module Gio.DBusObject;

import GLib.List;
import GObject.DClosure;
import GObject.ObjectG;
import GObject.Types;
import Gid.gid;
import Gio.DBusInterface;
import Gio.DBusInterfaceT;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * The `GDBusObject` type is the base type for D-Bus objects on both
 * the service side $(LPAREN)see [Gio.DBusObjectSkeleton]$(RPAREN) and the client side
 * $(LPAREN)see [Gio.DBusObjectProxy]$(RPAREN). It is essentially just a container of
 * interfaces.
 */
interface DBusObject
{

  static GType getType()
  {
    return g_dbus_object_get_type();
  }

  /**
   * Gets the D-Bus interface with name interface_name associated with
   * object, if any.
   * Params:
   *   interfaceName = A D-Bus interface name.
   * Returns: %NULL if not found, otherwise a
   *   #GDBusInterface that must be freed with [GObject.ObjectG.unref].
   */
  DBusInterface getInterface(string interfaceName);

  /**
   * Gets the D-Bus interfaces associated with object.
   * Returns: A list of #GDBusInterface instances.
   *   The returned list must be freed by [GLib.List.free] after each element has been freed
   *   with [GObject.ObjectG.unref].
   */
  List!(DBusInterface, GDBusInterface) getInterfaces();

  /**
   * Gets the object path for object.
   * Returns: A string owned by object. Do not free.
   */
  string getObjectPath();

  /**
   * Emitted when interface is added to object.
   * Params
   *   interface_ = The #GDBusInterface that was added.
   *   dBusObject = the instance the signal is connected to
   */
  alias InterfaceAddedCallback = void delegate(DBusInterface interface_, DBusObject dBusObject);

  /**
   * Connect to InterfaceAdded signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectInterfaceAdded(InterfaceAddedCallback dlg, ConnectFlags flags = ConnectFlags.Default);

  /**
   * Emitted when interface is removed from object.
   * Params
   *   interface_ = The #GDBusInterface that was removed.
   *   dBusObject = the instance the signal is connected to
   */
  alias InterfaceRemovedCallback = void delegate(DBusInterface interface_, DBusObject dBusObject);

  /**
   * Connect to InterfaceRemoved signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectInterfaceRemoved(InterfaceRemovedCallback dlg, ConnectFlags flags = ConnectFlags.Default);
}
