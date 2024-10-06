module Gio.DBusInterfaceT;

public import GObject.ObjectG;
public import Gid.gid;
public import Gio.DBusInterfaceInfo;
public import Gio.DBusObject;
public import Gio.DBusObjectT;
public import Gio.Types;
public import Gio.c.functions;
public import Gio.c.types;

/**
 * Base type for D-Bus interfaces.
 * The `GDBusInterface` type is the base type for D-Bus interfaces both
 * on the service side $(LPAREN)see [Gio.DBusInterfaceSkeleton]$(RPAREN) and client side
 * $(LPAREN)see [Gio.DBusProxy]$(RPAREN).
 */
template DBusInterfaceT(TStruct)
{

  /**
   * Gets the #GDBusObject that interface_ belongs to, if any.
   * Returns: A #GDBusObject or %NULL. The returned
   *   reference should be freed with [GObject.ObjectG.unref].
   */
  override DBusObject getObject()
  {
    GDBusObject* _cretval;
    _cretval = g_dbus_interface_dup_object(cast(GDBusInterface*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!DBusObject(cast(GDBusObject*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Gets D-Bus introspection information for the D-Bus interface
   * implemented by interface_.
   * Returns: A #GDBusInterfaceInfo. Do not free.
   */
  override DBusInterfaceInfo getInfo()
  {
    GDBusInterfaceInfo* _cretval;
    _cretval = g_dbus_interface_get_info(cast(GDBusInterface*)cPtr);
    auto _retval = _cretval ? new DBusInterfaceInfo(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Sets the #GDBusObject for interface_ to object.
   * Note that interface_ will hold a weak reference to object.
   * Params:
   *   object = A #GDBusObject or %NULL.
   */
  override void setObject(DBusObject object)
  {
    g_dbus_interface_set_object(cast(GDBusInterface*)cPtr, object ? cast(GDBusObject*)(cast(ObjectG)object).cPtr(false) : null);
  }
}
