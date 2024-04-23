module Gio.IOExtensionPoint;

import GLib.List;
import GLib.Types;
import GObject.Types;
import Gid.Gid;
import Gio.IOExtension;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * #GIOExtensionPoint is an opaque data structure and can only be accessed
 * using the following functions.
 */
class IOExtensionPoint
{
  GIOExtensionPoint* cInstancePtr;
  bool owned;

  this(void* ptr, bool owned = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.IOExtensionPoint");

    cInstancePtr = cast(GIOExtensionPoint*)ptr;

    this.owned = owned;
  }

  T* cPtr(T)()
  if (is(T == GIOExtensionPoint))
  {
    return cast(T*)cInstancePtr;
  }

  /**
   * the #GIOExtension for @extension_point that has the
   * given name, or %NULL if there is no extension with that name
   */
  IOExtension getExtensionByName(string name)
  {
    GIOExtension* _cretval;
    const(char)* _name = name.toCString(false);
    _cretval = g_io_extension_point_get_extension_by_name(cPtr!GIOExtensionPoint, _name);
    IOExtension _retval = new IOExtension(cast(GIOExtension*)_cretval, false);
    return _retval;
  }

  /**
   * a #GList of
   * #GIOExtensions. The list is owned by GIO and should not be
   * modified.
   */
  List!(IOExtension, GIOExtension*) getExtensions()
  {
    GList* _cretval;
    _cretval = g_io_extension_point_get_extensions(cPtr!GIOExtensionPoint);
    List!(IOExtension, GIOExtension*) _retval = _cretval ? new List!(IOExtension, GIOExtension*)(_cretval, GidOwnership.None) : null;
    return _retval;
  }

  /**
   * the #GType that all implementations must have,
   * or %G_TYPE_INVALID if the extension point has no required type
   */
  GType getRequiredType()
  {
    GType _retval;
    _retval = g_io_extension_point_get_required_type(cPtr!GIOExtensionPoint);
    return _retval;
  }

  /**
   * Sets the required type for @extension_point to @type.
   * All implementations must henceforth have this type.
   */
  void setRequiredType(GType type)
  {
    g_io_extension_point_set_required_type(cPtr!GIOExtensionPoint, type);
  }

  /**
   * a #GIOExtension object for #GType
   */
  static IOExtension implement(string extensionPointName, GType type, string extensionName, int priority)
  {
    GIOExtension* _cretval;
    const(char)* _extensionPointName = extensionPointName.toCString(false);
    const(char)* _extensionName = extensionName.toCString(false);
    _cretval = g_io_extension_point_implement(_extensionPointName, type, _extensionName, priority);
    IOExtension _retval = new IOExtension(cast(GIOExtension*)_cretval, false);
    return _retval;
  }

  /**
   * the #GIOExtensionPoint, or %NULL if there
   * is no registered extension point with the given name.
   */
  static IOExtensionPoint lookup(string name)
  {
    GIOExtensionPoint* _cretval;
    const(char)* _name = name.toCString(false);
    _cretval = g_io_extension_point_lookup(_name);
    IOExtensionPoint _retval = new IOExtensionPoint(cast(GIOExtensionPoint*)_cretval, false);
    return _retval;
  }

  /**
   * the new #GIOExtensionPoint. This object is
   * owned by GIO and should not be freed.
   */
  static IOExtensionPoint register(string name)
  {
    GIOExtensionPoint* _cretval;
    const(char)* _name = name.toCString(false);
    _cretval = g_io_extension_point_register(_name);
    IOExtensionPoint _retval = new IOExtensionPoint(cast(GIOExtensionPoint*)_cretval, false);
    return _retval;
  }
}
