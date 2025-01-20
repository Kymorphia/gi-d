module Gio.DBusMenuModel;

import GObject.ObjectG;
import Gid.gid;
import Gio.DBusConnection;
import Gio.MenuModel;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * `GDBusMenuModel` is an implementation of [Gio.MenuModel] that can be
 * used as a proxy for a menu model that is exported over D-Bus with
 * [Gio.DBusConnection.exportMenuModel].
 */
class DBusMenuModel : MenuModel
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
    return g_dbus_menu_model_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Obtains a #GDBusMenuModel for the menu model which is exported
   * at the given bus_name and object_path.
   * The thread default main context is taken at the time of this call.
   * All signals on the menu model $(LPAREN)and any linked models$(RPAREN) are reported
   * with respect to this context.  All calls on the returned menu model
   * $(LPAREN)and linked models$(RPAREN) must also originate from this same context, with
   * the thread default main context unchanged.
   * Params:
   *   connection = a #GDBusConnection
   *   busName = the bus name which exports the menu model
   *     or %NULL if connection is not a message bus connection
   *   objectPath = the object path at which the menu model is exported
   * Returns: a #GDBusMenuModel object. Free with
   *   [GObject.ObjectG.unref].
   */
  static DBusMenuModel get(DBusConnection connection, string busName, string objectPath)
  {
    GDBusMenuModel* _cretval;
    const(char)* _busName = busName.toCString(false);
    const(char)* _objectPath = objectPath.toCString(false);
    _cretval = g_dbus_menu_model_get(connection ? cast(GDBusConnection*)connection.cPtr(false) : null, _busName, _objectPath);
    auto _retval = _cretval ? ObjectG.getDObject!DBusMenuModel(cast(GDBusMenuModel*)_cretval, true) : null;
    return _retval;
  }
}
