module Gio.DBusObjectManagerT;

public import GLib.List;
public import GLib.Types;
public import GObject.DClosure;
public import GObject.ObjectG;
public import GObject.Types;
public import Gid.Gid;
public import Gio.DBusInterface;
public import Gio.DBusObject;
public import Gio.Types;
public import Gio.c.functions;
public import Gio.c.types;

/**
 * The #GDBusObjectManager type is the base type for service- and
 * client-side implementations of the standardized
 * [org.freedesktop.DBus.ObjectManager](http://dbus.freedesktop.org/doc/dbus-specification.html#standard-interfaces-objectmanager)
 * interface.
 *
 * See #GDBusObjectManagerClient for the client-side implementation
 * and #GDBusObjectManagerServer for the service-side implementation.
 */
template DBusObjectManagerT(TStruct)
{

  /**
   * A #GDBusInterface instance or %NULL. Free
   * with g_object_unref().
   */
  override DBusInterface getInterface(string objectPath, string interfaceName)
  {
    GDBusInterface* _cretval;
    const(char)* _objectPath = objectPath.toCString(false);
    const(char)* _interfaceName = interfaceName.toCString(false);
    _cretval = g_dbus_object_manager_get_interface(cPtr!GDBusObjectManager, _objectPath, _interfaceName);
    DBusInterface _retval = ObjectG.getDObject!DBusInterface(cast(GDBusInterface*)_cretval, true);
    return _retval;
  }

  /**
   * A #GDBusObject or %NULL. Free with
   * g_object_unref().
   */
  override DBusObject getObject(string objectPath)
  {
    GDBusObject* _cretval;
    const(char)* _objectPath = objectPath.toCString(false);
    _cretval = g_dbus_object_manager_get_object(cPtr!GDBusObjectManager, _objectPath);
    DBusObject _retval = ObjectG.getDObject!DBusObject(cast(GDBusObject*)_cretval, true);
    return _retval;
  }

  /**
   * A string owned by @manager. Do not free.
   */
  override string getObjectPath()
  {
    const(char)* _cretval;
    _cretval = g_dbus_object_manager_get_object_path(cPtr!GDBusObjectManager);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * A list of
   * #GDBusObject objects. The returned list should be freed with
   * g_list_free() after each element has been freed with
   * g_object_unref().
   */
  override List!(DBusObject, GDBusObject*) getObjects()
  {
    GList* _cretval;
    _cretval = g_dbus_object_manager_get_objects(cPtr!GDBusObjectManager);
    List!(DBusObject, GDBusObject*) _retval = _cretval ? new List!(DBusObject, GDBusObject*)(_cretval, GidOwnership.Full) : null;
    return _retval;
  }

  /**
   * Emitted when @interface is added to @object.
   *
   * This signal exists purely as a convenience to avoid having to
   * connect signals to all objects managed by @manager.
   */
  ulong connectInterfaceAdded(void delegate(DBusObject object, DBusInterface interface_, DBusObjectManager dBusObjectManager) dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 3, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto dBusObjectManager = getVal!DBusObjectManager(_paramVals);
      auto object = getVal!DBusObject(&_paramVals[1]);
      auto interface_ = getVal!DBusInterface(&_paramVals[2]);
      _dgClosure.dlg(object, interface_, dBusObjectManager);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("interface-added", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * Emitted when @interface has been removed from @object.
   *
   * This signal exists purely as a convenience to avoid having to
   * connect signals to all objects managed by @manager.
   */
  ulong connectInterfaceRemoved(void delegate(DBusObject object, DBusInterface interface_, DBusObjectManager dBusObjectManager) dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 3, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto dBusObjectManager = getVal!DBusObjectManager(_paramVals);
      auto object = getVal!DBusObject(&_paramVals[1]);
      auto interface_ = getVal!DBusInterface(&_paramVals[2]);
      _dgClosure.dlg(object, interface_, dBusObjectManager);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("interface-removed", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * Emitted when @object is added to @manager.
   */
  ulong connectObjectAdded(void delegate(DBusObject object, DBusObjectManager dBusObjectManager) dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto dBusObjectManager = getVal!DBusObjectManager(_paramVals);
      auto object = getVal!DBusObject(&_paramVals[1]);
      _dgClosure.dlg(object, dBusObjectManager);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("object-added", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * Emitted when @object is removed from @manager.
   */
  ulong connectObjectRemoved(void delegate(DBusObject object, DBusObjectManager dBusObjectManager) dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto dBusObjectManager = getVal!DBusObjectManager(_paramVals);
      auto object = getVal!DBusObject(&_paramVals[1]);
      _dgClosure.dlg(object, dBusObjectManager);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("object-removed", closure, (flags & ConnectFlags.After) != 0);
  }
}
