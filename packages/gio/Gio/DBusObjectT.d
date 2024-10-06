module Gio.DBusObjectT;

public import GLib.List;
public import GObject.DClosure;
public import GObject.ObjectG;
public import GObject.Types;
public import Gid.gid;
public import Gio.DBusInterface;
public import Gio.DBusInterfaceT;
public import Gio.Types;
public import Gio.c.functions;
public import Gio.c.types;

/**
 * The `GDBusObject` type is the base type for D-Bus objects on both
 * the service side $(LPAREN)see [Gio.DBusObjectSkeleton]$(RPAREN) and the client side
 * $(LPAREN)see [Gio.DBusObjectProxy]$(RPAREN). It is essentially just a container of
 * interfaces.
 */
template DBusObjectT(TStruct)
{

  /**
   * Gets the D-Bus interface with name interface_name associated with
   * object, if any.
   * Params:
   *   interfaceName = A D-Bus interface name.
   * Returns: %NULL if not found, otherwise a
   *   #GDBusInterface that must be freed with [GObject.ObjectG.unref].
   */
  override DBusInterface getInterface(string interfaceName)
  {
    GDBusInterface* _cretval;
    const(char)* _interfaceName = interfaceName.toCString(false);
    _cretval = g_dbus_object_get_interface(cast(GDBusObject*)cPtr, _interfaceName);
    auto _retval = _cretval ? ObjectG.getDObject!DBusInterface(cast(GDBusInterface*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Gets the D-Bus interfaces associated with object.
   * Returns: A list of #GDBusInterface instances.
   *   The returned list must be freed by [GLib.List.free] after each element has been freed
   *   with [GObject.ObjectG.unref].
   */
  override List!(DBusInterface, GDBusInterface) getInterfaces()
  {
    GList* _cretval;
    _cretval = g_dbus_object_get_interfaces(cast(GDBusObject*)cPtr);
    List!(DBusInterface, GDBusInterface) _retval = new List!(DBusInterface, GDBusInterface)(cast(GList*)_cretval, GidOwnership.Full);
    return _retval;
  }

  /**
   * Gets the object path for object.
   * Returns: A string owned by object. Do not free.
   */
  override string getObjectPath()
  {
    const(char)* _cretval;
    _cretval = g_dbus_object_get_object_path(cast(GDBusObject*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

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
  ulong connectInterfaceAdded(InterfaceAddedCallback dlg, ConnectFlags flags = ConnectFlags.Default)
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
  ulong connectInterfaceRemoved(InterfaceRemovedCallback dlg, ConnectFlags flags = ConnectFlags.Default)
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
