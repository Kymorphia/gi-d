module Gio.DBusNodeInfo;

import GLib.Boxed;
import GLib.ErrorG;
import GLib.String;
import GLib.Types;
import GLib.c.functions;
import Gid.Gid;
import Gio.DBusInterfaceInfo;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * Information about nodes in a remote object hierarchy.
 */
class DBusNodeInfo : Boxed
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  T* cPtr(T)(bool makeCopy = false)
  if (is(T == GDBusNodeInfo))
  {
    return makeCopy ? copy_!T : cast(T*)cInstancePtr;
  }

  static GType getType()
  {
    return g_dbus_node_info_get_type();
  }

  @property int refCount()
  {
    return cPtr!GDBusNodeInfo.refCount;
  }

  @property void refCount(int propval)
  {
    cPtr!GDBusNodeInfo.refCount = propval;
  }

  @property string path()
  {
    return cPtr!GDBusNodeInfo.path.fromCString(false);
  }

  @property void path(string propval)
  {
    g_free(cast(void*)cPtr!GDBusNodeInfo.path);
    cPtr!GDBusNodeInfo.path = propval.toCString(true);
  }

  /**
   * A #GDBusNodeInfo structure or %NULL if @error is set. Free
   * with g_dbus_node_info_unref().
   */
  static DBusNodeInfo newForXml(string xmlData)
  {
    GDBusNodeInfo* _cretval;
    const(char)* _xmlData = xmlData.toCString(false);
    GError *_err;
    _cretval = g_dbus_node_info_new_for_xml(_xmlData, &_err);
    if (_err)
      throw new ErrorG(_err);
    DBusNodeInfo _retval = new DBusNodeInfo(cast(GDBusNodeInfo*)_cretval, true);
    return _retval;
  }

  /**
   * Appends an XML representation of @info (and its children) to @string_builder.
   *
   * This function is typically used for generating introspection XML documents at run-time for
   * handling the `org.freedesktop.DBus.Introspectable.Introspect`  method.
   */
  void generateXml(uint indent, String stringBuilder)
  {
    g_dbus_node_info_generate_xml(cPtr!GDBusNodeInfo, indent, stringBuilder ? stringBuilder.cPtr!GString : null);
  }

  /**
   * A #GDBusInterfaceInfo or %NULL if not found. Do not free, it is owned by @info.
   */
  DBusInterfaceInfo lookupInterface(string name)
  {
    GDBusInterfaceInfo* _cretval;
    const(char)* _name = name.toCString(false);
    _cretval = g_dbus_node_info_lookup_interface(cPtr!GDBusNodeInfo, _name);
    DBusInterfaceInfo _retval = new DBusInterfaceInfo(cast(GDBusInterfaceInfo*)_cretval, false);
    return _retval;
  }
}
