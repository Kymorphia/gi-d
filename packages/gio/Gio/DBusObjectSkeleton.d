module Gio.DBusObjectSkeleton;

import GObject.DClosure;
import GObject.ObjectG;
import GObject.Types;
import Gid.gid;
import Gio.DBusInterfaceSkeleton;
import Gio.DBusMethodInvocation;
import Gio.DBusObject;
import Gio.DBusObjectT;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * A `GDBusObjectSkeleton` instance is essentially a group of D-Bus
 * interfaces. The set of exported interfaces on the object may be
 * dynamic and change at runtime.
 * This type is intended to be used with [Gio.DBusObjectManager].
 */
class DBusObjectSkeleton : ObjectG, DBusObject
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
    return g_dbus_object_skeleton_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin DBusObjectT!GDBusObjectSkeleton;

  /**
   * Creates a new #GDBusObjectSkeleton.
   * Params:
   *   objectPath = An object path.
   * Returns: A #GDBusObjectSkeleton. Free with [GObject.ObjectG.unref].
   */
  this(string objectPath)
  {
    GDBusObjectSkeleton* _cretval;
    const(char)* _objectPath = objectPath.toCString(false);
    _cretval = g_dbus_object_skeleton_new(_objectPath);
    this(_cretval, true);
  }

  /**
   * Adds interface_ to object.
   * If object already contains a #GDBusInterfaceSkeleton with the same
   * interface name, it is removed before interface_ is added.
   * Note that object takes its own reference on interface_ and holds
   * it until removed.
   * Params:
   *   interface_ = A #GDBusInterfaceSkeleton.
   */
  void addInterface(DBusInterfaceSkeleton interface_)
  {
    g_dbus_object_skeleton_add_interface(cast(GDBusObjectSkeleton*)cPtr, interface_ ? cast(GDBusInterfaceSkeleton*)interface_.cPtr(false) : null);
  }

  /**
   * This method simply calls [Gio.DBusInterfaceSkeleton.flush] on all
   * interfaces belonging to object. See that method for when flushing
   * is useful.
   */
  void flush()
  {
    g_dbus_object_skeleton_flush(cast(GDBusObjectSkeleton*)cPtr);
  }

  /**
   * Removes interface_ from object.
   * Params:
   *   interface_ = A #GDBusInterfaceSkeleton.
   */
  void removeInterface(DBusInterfaceSkeleton interface_)
  {
    g_dbus_object_skeleton_remove_interface(cast(GDBusObjectSkeleton*)cPtr, interface_ ? cast(GDBusInterfaceSkeleton*)interface_.cPtr(false) : null);
  }

  /**
   * Removes the #GDBusInterface with interface_name from object.
   * If no D-Bus interface of the given interface exists, this function
   * does nothing.
   * Params:
   *   interfaceName = A D-Bus interface name.
   */
  void removeInterfaceByName(string interfaceName)
  {
    const(char)* _interfaceName = interfaceName.toCString(false);
    g_dbus_object_skeleton_remove_interface_by_name(cast(GDBusObjectSkeleton*)cPtr, _interfaceName);
  }

  /**
   * Sets the object path for object.
   * Params:
   *   objectPath = A valid D-Bus object path.
   */
  void setObjectPath(string objectPath)
  {
    const(char)* _objectPath = objectPath.toCString(false);
    g_dbus_object_skeleton_set_object_path(cast(GDBusObjectSkeleton*)cPtr, _objectPath);
  }

  /**
   * Emitted when a method is invoked by a remote caller and used to
   * determine if the method call is authorized.
   * This signal is like #GDBusInterfaceSkeleton's
   * #GDBusInterfaceSkeleton::g-authorize-method signal,
   * except that it is for the enclosing object.
   * The default class handler just returns %TRUE.
   * Params
   *   interface_ = The #GDBusInterfaceSkeleton that invocation is for.
   *   invocation = A #GDBusMethodInvocation.
   *   dBusObjectSkeleton = the instance the signal is connected to
   * Returns: %TRUE if the call is authorized, %FALSE otherwise.
   */
  alias AuthorizeMethodCallback = bool delegate(DBusInterfaceSkeleton interface_, DBusMethodInvocation invocation, DBusObjectSkeleton dBusObjectSkeleton);

  /**
   * Connect to AuthorizeMethod signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectAuthorizeMethod(AuthorizeMethodCallback dlg, ConnectFlags flags = ConnectFlags.Default)
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
