module Gio.DBusObjectSkeleton;

import GObject.DClosure;
import GObject.ObjectG;
import GObject.Types;
import Gid.Gid;
import Gio.DBusInterfaceSkeleton;
import Gio.DBusMethodInvocation;
import Gio.DBusObject;
import Gio.DBusObjectT;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * A #GDBusObjectSkeleton instance is essentially a group of D-Bus
 * interfaces. The set of exported interfaces on the object may be
 * dynamic and change at runtime.
 *
 * This type is intended to be used with #GDBusObjectManager.
 */
class DBusObjectSkeleton : ObjectG, DBusObject
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_dbus_object_skeleton_get_type();
  }

  mixin DBusObjectT!GDBusObjectSkeleton;

  /**
   * A #GDBusObjectSkeleton. Free with g_object_unref().
   */
  this(string objectPath)
  {
    GDBusObjectSkeleton* _cretval;
    const(char)* _objectPath = objectPath.toCString(false);
    _cretval = g_dbus_object_skeleton_new(_objectPath);
    this(_cretval, true);
  }

  /**
   * Adds @interface_ to @object.
   *
   * If @object already contains a #GDBusInterfaceSkeleton with the same
   * interface name, it is removed before @interface_ is added.
   *
   * Note that @object takes its own reference on @interface_ and holds
   * it until removed.
   */
  void addInterface(DBusInterfaceSkeleton interface_)
  {
    g_dbus_object_skeleton_add_interface(cPtr!GDBusObjectSkeleton, interface_ ? interface_.cPtr!GDBusInterfaceSkeleton : null);
  }

  /**
   * This method simply calls g_dbus_interface_skeleton_flush() on all
   * interfaces belonging to @object. See that method for when flushing
   * is useful.
   */
  void flush()
  {
    g_dbus_object_skeleton_flush(cPtr!GDBusObjectSkeleton);
  }

  /**
   * Removes @interface_ from @object.
   */
  void removeInterface(DBusInterfaceSkeleton interface_)
  {
    g_dbus_object_skeleton_remove_interface(cPtr!GDBusObjectSkeleton, interface_ ? interface_.cPtr!GDBusInterfaceSkeleton : null);
  }

  /**
   * Removes the #GDBusInterface with @interface_name from @object.
   *
   * If no D-Bus interface of the given interface exists, this function
   * does nothing.
   */
  void removeInterfaceByName(string interfaceName)
  {
    const(char)* _interfaceName = interfaceName.toCString(false);
    g_dbus_object_skeleton_remove_interface_by_name(cPtr!GDBusObjectSkeleton, _interfaceName);
  }

  /**
   * Sets the object path for @object.
   */
  void setObjectPath(string objectPath)
  {
    const(char)* _objectPath = objectPath.toCString(false);
    g_dbus_object_skeleton_set_object_path(cPtr!GDBusObjectSkeleton, _objectPath);
  }

  /**
   * %TRUE if the call is authorized, %FALSE otherwise.
   */
  ulong connectAuthorizeMethod(bool delegate(DBusInterfaceSkeleton interface_, DBusMethodInvocation invocation, DBusObjectSkeleton dBusObjectSkeleton) dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 3, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      bool _retval;
      auto dBusObjectSkeleton = getVal!DBusObjectSkeleton(_paramVals);
      auto interface_ = getVal!DBusInterfaceSkeleton(&_paramVals[1]);
      auto invocation = getVal!DBusMethodInvocation(&_paramVals[2]);
      _retval = _dgClosure.dlg(interface_, invocation, dBusObjectSkeleton);
      setVal!bool(_returnValue, _retval);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("authorize-method", closure, (flags & ConnectFlags.After) != 0);
  }
}
