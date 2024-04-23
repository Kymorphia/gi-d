module Gio.DBusObjectT;

public import GLib.List;
public import GLib.Types;
public import GObject.DClosure;
public import GObject.ObjectG;
public import GObject.Types;
public import Gid.Gid;
public import Gio.DBusInterface;
public import Gio.Types;
public import Gio.c.functions;
public import Gio.c.types;

/**
 * The #GDBusObject type is the base type for D-Bus objects on both
 * the service side (see #GDBusObjectSkeleton) and the client side
 * (see #GDBusObjectProxy). It is essentially just a container of
 * interfaces.
 */
template DBusObjectT(TStruct)
{

  /**
   * %NULL if not found, otherwise a
   * #GDBusInterface that must be freed with g_object_unref().
   */
  override DBusInterface getInterface(string interfaceName)
  {
    GDBusInterface* _cretval;
    const(char)* _interfaceName = interfaceName.toCString(false);
    _cretval = g_dbus_object_get_interface(cPtr!GDBusObject, _interfaceName);
    DBusInterface _retval = ObjectG.getDObject!DBusInterface(cast(GDBusInterface*)_cretval, true);
    return _retval;
  }

  /**
   * A list of #GDBusInterface instances.
   * The returned list must be freed by g_list_free() after each element has been freed
   * with g_object_unref().
   */
  override List!(DBusInterface, GDBusInterface*) getInterfaces()
  {
    GList* _cretval;
    _cretval = g_dbus_object_get_interfaces(cPtr!GDBusObject);
    List!(DBusInterface, GDBusInterface*) _retval = _cretval ? new List!(DBusInterface, GDBusInterface*)(_cretval, GidOwnership.Full) : null;
    return _retval;
  }

  /**
   * A string owned by @object. Do not free.
   */
  override string getObjectPath()
  {
    const(char)* _cretval;
    _cretval = g_dbus_object_get_object_path(cPtr!GDBusObject);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Emitted when @interface is added to @object.
   */
  ulong connectInterfaceAdded(void delegate(DBusInterface interface_, DBusObject dBusObject) dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto dBusObject = getVal!DBusObject(_paramVals);
      auto interface_ = getVal!DBusInterface(&_paramVals[1]);
      _dgClosure.dlg(interface_, dBusObject);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("interface-added", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * Emitted when @interface is removed from @object.
   */
  ulong connectInterfaceRemoved(void delegate(DBusInterface interface_, DBusObject dBusObject) dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto dBusObject = getVal!DBusObject(_paramVals);
      auto interface_ = getVal!DBusInterface(&_paramVals[1]);
      _dgClosure.dlg(interface_, dBusObject);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("interface-removed", closure, (flags & ConnectFlags.After) != 0);
  }
}
