module Gio.DBusInterfaceInfo;

import GLib.Boxed;
import GLib.String;
import Gid.gid;
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

  this()
  {
    super(safeMalloc(GDBusInterfaceInfo.sizeof), true);
  }

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  void* cPtr(bool makeCopy = false)
  {
    return makeCopy ? copy_ : cInstancePtr;
  }

  static GType getType()
  {
    return g_dbus_interface_info_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  @property int refCount()
  {
    return (cast(GDBusInterfaceInfo*)cPtr).refCount;
  }

  @property void refCount(int propval)
  {
    (cast(GDBusInterfaceInfo*)cPtr).refCount = propval;
  }

  @property string name()
  {
    return (cast(GDBusInterfaceInfo*)cPtr).name.fromCString(false);
  }

  @property void name(string propval)
  {
    safeFree(cast(void*)(cast(GDBusInterfaceInfo*)cPtr).name);
    (cast(GDBusInterfaceInfo*)cPtr).name = propval.toCString(true);
  }

  /**
   * Builds a lookup-cache to speed up
   * [Gio.DBusInterfaceInfo.lookupMethod],
   * [Gio.DBusInterfaceInfo.lookupSignal] and
   * [Gio.DBusInterfaceInfo.lookupProperty].
   * If this has already been called with info, the existing cache is
   * used and its use count is increased.
   * Note that info cannot be modified until
   * [Gio.DBusInterfaceInfo.cacheRelease] is called.
   */
  void cacheBuild()
  {
    g_dbus_interface_info_cache_build(cast(GDBusInterfaceInfo*)cPtr);
  }

  /**
   * Decrements the usage count for the cache for info built by
   * [Gio.DBusInterfaceInfo.cacheBuild] (if any) and frees the
   * resources used by the cache if the usage count drops to zero.
   */
  void cacheRelease()
  {
    g_dbus_interface_info_cache_release(cast(GDBusInterfaceInfo*)cPtr);
  }

  /**
   * Appends an XML representation of info $(LPAREN)and its children$(RPAREN) to string_builder.
   * This function is typically used for generating introspection XML
   * documents at run-time for handling the
   * `org.freedesktop.DBus.Introspectable.Introspect`
   * method.
   * Params:
   *   indent = Indentation level.
   *   stringBuilder = A #GString to to append XML data to.
   */
  void generateXml(uint indent, String stringBuilder)
  {
    g_dbus_interface_info_generate_xml(cast(GDBusInterfaceInfo*)cPtr, indent, stringBuilder ? cast(GString*)stringBuilder.cPtr(false) : null);
  }

  /**
   * Looks up information about a method.
   * The cost of this function is O$(LPAREN)n$(RPAREN) in number of methods unless
   * [Gio.DBusInterfaceInfo.cacheBuild] has been used on info.
   * Params:
   *   name = A D-Bus method name $(LPAREN)typically in CamelCase$(RPAREN)
   * Returns: A #GDBusMethodInfo or %NULL if not found. Do not free, it is owned by info.
   */
  DBusMethodInfo lookupMethod(string name)
  {
    GDBusMethodInfo* _cretval;
    const(char)* _name = name.toCString(false);
    _cretval = g_dbus_interface_info_lookup_method(cast(GDBusInterfaceInfo*)cPtr, _name);
    auto _retval = _cretval ? new DBusMethodInfo(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Looks up information about a property.
   * The cost of this function is O$(LPAREN)n$(RPAREN) in number of properties unless
   * [Gio.DBusInterfaceInfo.cacheBuild] has been used on info.
   * Params:
   *   name = A D-Bus property name $(LPAREN)typically in CamelCase$(RPAREN).
   * Returns: A #GDBusPropertyInfo or %NULL if not found. Do not free, it is owned by info.
   */
  DBusPropertyInfo lookupProperty(string name)
  {
    GDBusPropertyInfo* _cretval;
    const(char)* _name = name.toCString(false);
    _cretval = g_dbus_interface_info_lookup_property(cast(GDBusInterfaceInfo*)cPtr, _name);
    auto _retval = _cretval ? new DBusPropertyInfo(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Looks up information about a signal.
   * The cost of this function is O$(LPAREN)n$(RPAREN) in number of signals unless
   * [Gio.DBusInterfaceInfo.cacheBuild] has been used on info.
   * Params:
   *   name = A D-Bus signal name $(LPAREN)typically in CamelCase$(RPAREN)
   * Returns: A #GDBusSignalInfo or %NULL if not found. Do not free, it is owned by info.
   */
  DBusSignalInfo lookupSignal(string name)
  {
    GDBusSignalInfo* _cretval;
    const(char)* _name = name.toCString(false);
    _cretval = g_dbus_interface_info_lookup_signal(cast(GDBusInterfaceInfo*)cPtr, _name);
    auto _retval = _cretval ? new DBusSignalInfo(cast(void*)_cretval, false) : null;
    return _retval;
  }
}
