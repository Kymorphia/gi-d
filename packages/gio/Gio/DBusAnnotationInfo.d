module Gio.DBusAnnotationInfo;

import GLib.Boxed;
import Gid.gid;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * Information about an annotation.
 */
class DBusAnnotationInfo : Boxed
{

  this()
  {
    super(safeMalloc(GDBusAnnotationInfo.sizeof), true);
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
    return g_dbus_annotation_info_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  @property int refCount()
  {
    return (cast(GDBusAnnotationInfo*)cPtr).refCount;
  }

  @property void refCount(int propval)
  {
    (cast(GDBusAnnotationInfo*)cPtr).refCount = propval;
  }

  @property string key()
  {
    return (cast(GDBusAnnotationInfo*)cPtr).key.fromCString(false);
  }

  @property void key(string propval)
  {
    safeFree(cast(void*)(cast(GDBusAnnotationInfo*)cPtr).key);
    (cast(GDBusAnnotationInfo*)cPtr).key = propval.toCString(true);
  }

  @property string value()
  {
    return (cast(GDBusAnnotationInfo*)cPtr).value.fromCString(false);
  }

  @property void value(string propval)
  {
    safeFree(cast(void*)(cast(GDBusAnnotationInfo*)cPtr).value);
    (cast(GDBusAnnotationInfo*)cPtr).value = propval.toCString(true);
  }

  /**
   * Looks up the value of an annotation.
   * The cost of this function is O$(LPAREN)n$(RPAREN) in number of annotations.
   * Params:
   *   annotations = A %NULL-terminated array of annotations or %NULL.
   *   name = The name of the annotation to look up.
   * Returns: The value or %NULL if not found. Do not free, it is owned by annotations.
   */
  static string lookup(DBusAnnotationInfo[] annotations, string name)
  {
    const(char)* _cretval;
    GDBusAnnotationInfo*[] _tmpannotations;
    foreach (obj; annotations)
      _tmpannotations ~= cast(GDBusAnnotationInfo*)obj.cPtr;
    _tmpannotations.length++;
    GDBusAnnotationInfo** _annotations = _tmpannotations.ptr;

    const(char)* _name = name.toCString(false);
    _cretval = g_dbus_annotation_info_lookup(_annotations, _name);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }
}
