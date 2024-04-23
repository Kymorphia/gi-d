module Gio.DBusInterface;

import GObject.ObjectG;
import Gid.Gid;
import Gio.DBusInterfaceInfo;
import Gio.DBusObject;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * The #GDBusInterface type is the base type for D-Bus interfaces both
 * on the service side (see #GDBusInterfaceSkeleton) and client side
 * (see #GDBusProxy).
 */
interface DBusInterface
{

  static GType getType()
  {
    return g_dbus_interface_get_type();
  }

  /**
   * A #GDBusObject or %NULL. The returned
   * reference should be freed with g_object_unref().
   */
  DBusObject getObject();

  /**
   * A #GDBusInterfaceInfo. Do not free.
   */
  DBusInterfaceInfo getInfo();

  /**
   * Sets the #GDBusObject for @interface_ to @object.
   *
   * Note that @interface_ will hold a weak reference to @object.
   */
  void setObject(DBusObject object);
}
