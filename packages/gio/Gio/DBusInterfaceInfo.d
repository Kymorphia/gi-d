module Gio.DBusInterfaceInfo;

import GLib.Boxed;
import GLib.String;
import GLib.Types;
import GLib.c.functions;
import Gid.Gid;
import Gio.DBusMethodInfo;
import Gio.DBusPropertyInfo;
import Gio.DBusSignalInfo;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * Information about a D-Bus interface.
 */
class DBusInterfaceInfo : Boxed
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  T* cPtr(T)(bool makeCopy = false)
  if (is(T == GDBusInterfaceInfo))
  {
    return makeCopy ? copy_!T : cast(T*)cInstancePtr;
  }

  static GType getType()
  {
    return g_dbus_interface_info_get_type();
  }

  @property int refCount()
  {
    return cPtr!GDBusInterfaceInfo.refCount;
  }

  @property void refCount(int propval)
  {
    cPtr!GDBusInterfaceInfo.refCount = propval;
  }

  @property string name()
  {
    return cPtr!GDBusInterfaceInfo.name.fromCString(false);
  }

  @property void name(string propval)
  {
    g_free(cast(void*)cPtr!GDBusInterfaceInfo.name);
    cPtr!GDBusInterfaceInfo.name = propval.toCString(true);
  }

  /**
   * Builds a lookup-cache to speed up
   * g_dbus_interface_info_lookup_method(),
   * g_dbus_interface_info_lookup_signal() and
   * g_dbus_interface_info_lookup_property().
   *
   * If this has already been called with @info, the existing cache is
   * used and its use count is increased.
   *
   * Note that @info cannot be modified until
   * g_dbus_interface_info_cache_release() is called.
   */
  void cacheBuild()
  {
    g_dbus_interface_info_cache_build(cPtr!GDBusInterfaceInfo);
  }

  /**
   * Decrements the usage count for the cache for @info built by
   * g_dbus_interface_info_cache_build() (if any) and frees the
   * resources used by the cache if the usage count drops to zero.
   */
  void cacheRelease()
  {
    g_dbus_interface_info_cache_release(cPtr!GDBusInterfaceInfo);
  }

  /**
   * Appends an XML representation of @info (and its children) to @string_builder.
   *
   * This function is typically used for generating introspection XML
   * documents at run-time for handling the
   * `org.freedesktop.DBus.Introspectable.Introspect`
   * method.
   */
  void generateXml(uint indent, String stringBuilder)
  {
    g_dbus_interface_info_generate_xml(cPtr!GDBusInterfaceInfo, indent, stringBuilder ? stringBuilder.cPtr!GString : null);
  }

  /**
   * A #GDBusMethodInfo or %NULL if not found. Do not free, it is owned by @info.
   */
  DBusMethodInfo lookupMethod(string name)
  {
    GDBusMethodInfo* _cretval;
    const(char)* _name = name.toCString(false);
    _cretval = g_dbus_interface_info_lookup_method(cPtr!GDBusInterfaceInfo, _name);
    DBusMethodInfo _retval = new DBusMethodInfo(cast(GDBusMethodInfo*)_cretval, false);
    return _retval;
  }

  /**
   * A #GDBusPropertyInfo or %NULL if not found. Do not free, it is owned by @info.
   */
  DBusPropertyInfo lookupProperty(string name)
  {
    GDBusPropertyInfo* _cretval;
    const(char)* _name = name.toCString(false);
    _cretval = g_dbus_interface_info_lookup_property(cPtr!GDBusInterfaceInfo, _name);
    DBusPropertyInfo _retval = new DBusPropertyInfo(cast(GDBusPropertyInfo*)_cretval, false);
    return _retval;
  }

  /**
   * A #GDBusSignalInfo or %NULL if not found. Do not free, it is owned by @info.
   */
  DBusSignalInfo lookupSignal(string name)
  {
    GDBusSignalInfo* _cretval;
    const(char)* _name = name.toCString(false);
    _cretval = g_dbus_interface_info_lookup_signal(cPtr!GDBusInterfaceInfo, _name);
    DBusSignalInfo _retval = new DBusSignalInfo(cast(GDBusSignalInfo*)_cretval, false);
    return _retval;
  }
}
