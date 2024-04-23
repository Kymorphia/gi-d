module Gio.DBusMenuModel;

import GObject.ObjectG;
import Gid.Gid;
import Gio.DBusConnection;
import Gio.MenuModel;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * #GDBusMenuModel is an implementation of #GMenuModel that can be used
 * as a proxy for a menu model that is exported over D-Bus with
 * g_dbus_connection_export_menu_model().
 */
class DBusMenuModel : MenuModel
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_dbus_menu_model_get_type();
  }

  /**
   * a #GDBusMenuModel object. Free with
   * g_object_unref().
   */
  static DBusMenuModel get(DBusConnection connection, string busName, string objectPath)
  {
    GDBusMenuModel* _cretval;
    const(char)* _busName = busName.toCString(false);
    const(char)* _objectPath = objectPath.toCString(false);
    _cretval = g_dbus_menu_model_get(connection ? connection.cPtr!GDBusConnection : null, _busName, _objectPath);
    DBusMenuModel _retval = ObjectG.getDObject!DBusMenuModel(cast(GDBusMenuModel*)_cretval, true);
    return _retval;
  }
}
