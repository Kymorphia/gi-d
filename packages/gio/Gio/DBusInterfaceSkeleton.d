module Gio.DBusInterfaceSkeleton;

import GLib.ErrorG;
import GLib.List;
import GLib.Types;
import GLib.Variant;
import GObject.DClosure;
import GObject.ObjectG;
import GObject.Types;
import Gid.Gid;
import Gio.DBusConnection;
import Gio.DBusInterface;
import Gio.DBusInterfaceInfo;
import Gio.DBusInterfaceT;
import Gio.DBusInterfaceVTable;
import Gio.DBusMethodInvocation;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * Abstract base class for D-Bus interfaces on the service side.
 */
class DBusInterfaceSkeleton : ObjectG, DBusInterface
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_dbus_interface_skeleton_get_type();
  }

  mixin DBusInterfaceT!GDBusInterfaceSkeleton;

  /**
   * %TRUE if the interface was exported on @connection, otherwise %FALSE with
   * @error set.
   */
  bool export_(DBusConnection connection, string objectPath)
  {
    bool _retval;
    const(char)* _objectPath = objectPath.toCString(false);
    GError *_err;
    _retval = g_dbus_interface_skeleton_export(cPtr!GDBusInterfaceSkeleton, connection ? connection.cPtr!GDBusConnection : null, _objectPath, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * If @interface_ has outstanding changes, request for these changes to be
   * emitted immediately.
   *
   * For example, an exported D-Bus interface may queue up property
   * changes and emit the
   * `org.freedesktop.DBus.Properties.PropertiesChanged`
   * signal later (e.g. in an idle handler). This technique is useful
   * for collapsing multiple property changes into one.
   */
  void flush()
  {
    g_dbus_interface_skeleton_flush(cPtr!GDBusInterfaceSkeleton);
  }

  /**
   * A #GDBusConnection or %NULL if @interface_ is
   * not exported anywhere. Do not free, the object belongs to @interface_.
   */
  DBusConnection getConnection()
  {
    GDBusConnection* _cretval;
    _cretval = g_dbus_interface_skeleton_get_connection(cPtr!GDBusInterfaceSkeleton);
    DBusConnection _retval = ObjectG.getDObject!DBusConnection(cast(GDBusConnection*)_cretval, false);
    return _retval;
  }

  /**
   * A list of
   * all the connections that @interface_ is exported on. The returned
   * list should be freed with g_list_free() after each element has
   * been freed with g_object_unref().
   */
  List!(DBusConnection, GDBusConnection*) getConnections()
  {
    GList* _cretval;
    _cretval = g_dbus_interface_skeleton_get_connections(cPtr!GDBusInterfaceSkeleton);
    List!(DBusConnection, GDBusConnection*) _retval = _cretval ? new List!(DBusConnection, GDBusConnection*)(_cretval, GidOwnership.Full) : null;
    return _retval;
  }

  /**
   * One or more flags from the #GDBusInterfaceSkeletonFlags enumeration.
   */
  DBusInterfaceSkeletonFlags getFlags()
  {
    GDBusInterfaceSkeletonFlags _cretval;
    _cretval = g_dbus_interface_skeleton_get_flags(cPtr!GDBusInterfaceSkeleton);
    DBusInterfaceSkeletonFlags _retval = cast(DBusInterfaceSkeletonFlags)_cretval;
    return _retval;
  }

  /**
   * A #GDBusInterfaceInfo (never %NULL). Do not free.
   */
  DBusInterfaceInfo getInfo()
  {
    GDBusInterfaceInfo* _cretval;
    _cretval = g_dbus_interface_skeleton_get_info(cPtr!GDBusInterfaceSkeleton);
    DBusInterfaceInfo _retval = new DBusInterfaceInfo(cast(GDBusInterfaceInfo*)_cretval, false);
    return _retval;
  }

  /**
   * A string owned by @interface_ or %NULL if @interface_ is not exported
   * anywhere. Do not free, the string belongs to @interface_.
   */
  string getObjectPath()
  {
    const(char)* _cretval;
    _cretval = g_dbus_interface_skeleton_get_object_path(cPtr!GDBusInterfaceSkeleton);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * A #GVariant of type
   * ['a{sv}'][G-VARIANT-TYPE-VARDICT:CAPS].
   * Free with g_variant_unref().
   */
  Variant getProperties()
  {
    GVariant* _cretval;
    _cretval = g_dbus_interface_skeleton_get_properties(cPtr!GDBusInterfaceSkeleton);
    Variant _retval = new Variant(cast(GVariant*)_cretval, true);
    return _retval;
  }

  /**
   * the vtable of the D-Bus interface implemented by the skeleton
   */
  DBusInterfaceVTable getVtable()
  {
    GDBusInterfaceVTable* _cretval;
    _cretval = g_dbus_interface_skeleton_get_vtable(cPtr!GDBusInterfaceSkeleton);
    DBusInterfaceVTable _retval = new DBusInterfaceVTable(cast(GDBusInterfaceVTable*)_cretval);
    return _retval;
  }

  /**
   * %TRUE if @interface_ is exported on @connection, %FALSE otherwise.
   */
  bool hasConnection(DBusConnection connection)
  {
    bool _retval;
    _retval = g_dbus_interface_skeleton_has_connection(cPtr!GDBusInterfaceSkeleton, connection ? connection.cPtr!GDBusConnection : null);
    return _retval;
  }

  /**
   * Sets flags describing what the behavior of @skeleton should be.
   */
  void setFlags(DBusInterfaceSkeletonFlags flags)
  {
    g_dbus_interface_skeleton_set_flags(cPtr!GDBusInterfaceSkeleton, flags);
  }

  /**
   * Stops exporting @interface_ on all connections it is exported on.
   *
   * To unexport @interface_ from only a single connection, use
   * g_dbus_interface_skeleton_unexport_from_connection()
   */
  void unexport()
  {
    g_dbus_interface_skeleton_unexport(cPtr!GDBusInterfaceSkeleton);
  }

  /**
   * Stops exporting @interface_ on @connection.
   *
   * To stop exporting on all connections the interface is exported on,
   * use g_dbus_interface_skeleton_unexport().
   */
  void unexportFromConnection(DBusConnection connection)
  {
    g_dbus_interface_skeleton_unexport_from_connection(cPtr!GDBusInterfaceSkeleton, connection ? connection.cPtr!GDBusConnection : null);
  }

  /**
   * %TRUE if the call is authorized, %FALSE otherwise.
   */
  ulong connectGAuthorizeMethod(bool delegate(DBusMethodInvocation invocation, DBusInterfaceSkeleton dBusInterfaceSkeleton) dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      bool _retval;
      auto dBusInterfaceSkeleton = getVal!DBusInterfaceSkeleton(_paramVals);
      auto invocation = getVal!DBusMethodInvocation(&_paramVals[1]);
      _retval = _dgClosure.dlg(invocation, dBusInterfaceSkeleton);
      setVal!bool(_returnValue, _retval);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("g-authorize-method", closure, (flags & ConnectFlags.After) != 0);
  }
}
