module Gio.DBusActionGroup;

import GObject.ObjectG;
import GObject.Types;
import Gid.Gid;
import Gio.ActionGroup;
import Gio.ActionGroupT;
import Gio.DBusConnection;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * #GDBusActionGroup is an implementation of the #GActionGroup
 * interface that can be used as a proxy for an action group
 * that is exported over D-Bus with g_dbus_connection_export_action_group().
 */
class DBusActionGroup : ObjectG, ActionGroup
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_dbus_action_group_get_type();
  }

  mixin ActionGroupT!GDBusActionGroup;

  /**
   * a #GDBusActionGroup
   */
  static DBusActionGroup get(DBusConnection connection, string busName, string objectPath)
  {
    GDBusActionGroup* _cretval;
    const(char)* _busName = busName.toCString(false);
    const(char)* _objectPath = objectPath.toCString(false);
    _cretval = g_dbus_action_group_get(connection ? connection.cPtr!GDBusConnection : null, _busName, _objectPath);
    DBusActionGroup _retval = ObjectG.getDObject!DBusActionGroup(cast(GDBusActionGroup*)_cretval, true);
    return _retval;
  }
}
