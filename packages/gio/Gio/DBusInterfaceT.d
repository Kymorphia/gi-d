module Gio.DBusInterfaceT;

public import GObject.ObjectG;
public import Gid.Gid;
public import Gio.DBusInterfaceInfo;
public import Gio.DBusObject;
public import Gio.Types;
public import Gio.c.functions;
public import Gio.c.types;

/**
 * The #GDBusInterface type is the base type for D-Bus interfaces both
 * on the service side (see #GDBusInterfaceSkeleton) and client side
 * (see #GDBusProxy).
 */
template DBusInterfaceT(TStruct)
{

  /**
   * A #GDBusObject or %NULL. The returned
   * reference should be freed with g_object_unref().
   */
  override DBusObject getObject()
  {
    GDBusObject* _cretval;
    _cretval = g_dbus_interface_dup_object(cPtr!GDBusInterface);
    DBusObject _retval = ObjectG.getDObject!DBusObject(cast(GDBusObject*)_cretval, true);
    return _retval;
  }

  /**
   * A #GDBusInterfaceInfo. Do not free.
   */
  override DBusInterfaceInfo getInfo()
  {
    GDBusInterfaceInfo* _cretval;
    _cretval = g_dbus_interface_get_info(cPtr!GDBusInterface);
    DBusInterfaceInfo _retval = new DBusInterfaceInfo(cast(GDBusInterfaceInfo*)_cretval, false);
    return _retval;
  }

  /**
   * Sets the #GDBusObject for @interface_ to @object.
   *
   * Note that @interface_ will hold a weak reference to @object.
   */
  override void setObject(DBusObject object)
  {
    g_dbus_interface_set_object(cPtr!GDBusInterface, object ? (cast(ObjectG)object).cPtr!GDBusObject : null);
  }
}
