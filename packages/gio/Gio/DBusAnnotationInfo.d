module Gio.DBusAnnotationInfo;

import GLib.Boxed;
import GLib.Types;
import GLib.c.functions;
import Gid.Gid;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * Information about an annotation.
 */
class DBusAnnotationInfo : Boxed
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  T* cPtr(T)(bool makeCopy = false)
  if (is(T == GDBusAnnotationInfo))
  {
    return makeCopy ? copy_!T : cast(T*)cInstancePtr;
  }

  static GType getType()
  {
    return g_dbus_annotation_info_get_type();
  }

  @property int refCount()
  {
    return cPtr!GDBusAnnotationInfo.refCount;
  }

  @property void refCount(int propval)
  {
    cPtr!GDBusAnnotationInfo.refCount = propval;
  }

  @property string key()
  {
    return cPtr!GDBusAnnotationInfo.key.fromCString(false);
  }

  @property void key(string propval)
  {
    g_free(cast(void*)cPtr!GDBusAnnotationInfo.key);
    cPtr!GDBusAnnotationInfo.key = propval.toCString(true);
  }

  @property string value()
  {
    return cPtr!GDBusAnnotationInfo.value.fromCString(false);
  }

  @property void value(string propval)
  {
    g_free(cast(void*)cPtr!GDBusAnnotationInfo.value);
    cPtr!GDBusAnnotationInfo.value = propval.toCString(true);
  }

  /**
   * The value or %NULL if not found. Do not free, it is owned by @annotations.
   */
  static string lookup(DBusAnnotationInfo[] annotations, string name)
  {
    const(char)* _cretval;
    GDBusAnnotationInfo*[] _tmpannotations;
    foreach (obj; annotations)
      _tmpannotations ~= obj.cPtr!GDBusAnnotationInfo;
    _tmpannotations.length++;
    GDBusAnnotationInfo** _annotations = _tmpannotations.ptr;

    const(char)* _name = name.toCString(false);
    _cretval = g_dbus_annotation_info_lookup(_annotations, _name);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }
}
