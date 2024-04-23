module Gio.DBusObject;

import GLib.List;
import GLib.Types;
import GObject.DClosure;
import GObject.ObjectG;
import GObject.Types;
import Gid.Gid;
import Gio.DBusInterface;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * The #GDBusObject type is the base type for D-Bus objects on both
 * the service side (see #GDBusObjectSkeleton) and the client side
 * (see #GDBusObjectProxy). It is essentially just a container of
 * interfaces.
 */
interface DBusObject
{

  static GType getType()
  {
    return g_dbus_object_get_type();
  }

  /**
   * %NULL if not found, otherwise a
   * #GDBusInterface that must be freed with g_object_unref().
   */
  DBusInterface getInterface(string interfaceName);

  /**
   * A list of #GDBusInterface instances.
   * The returned list must be freed by g_list_free() after each element has been freed
   * with g_object_unref().
   */
  List!(DBusInterface, GDBusInterface*) getInterfaces();

  /**
   * A string owned by @object. Do not free.
   */
  string getObjectPath();

  /**
   * Emitted when @interface is added to @object.
   */
  ulong connectInterfaceAdded(void delegate(DBusInterface interface_, DBusObject dBusObject) dlg, ConnectFlags flags = ConnectFlags.Default);

  /**
   * Emitted when @interface is removed from @object.
   */
  ulong connectInterfaceRemoved(void delegate(DBusInterface interface_, DBusObject dBusObject) dlg, ConnectFlags flags = ConnectFlags.Default);
}
