module Gio.IOExtension;

import GObject.Types;
import Gid.gid;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * #GIOExtension is an opaque data structure and can only be accessed
 * using the following functions.
 */
class IOExtension
{
  GIOExtension* cInstancePtr;
  bool owned;

  this(void* ptr, bool owned = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.IOExtension");

    cInstancePtr = cast(GIOExtension*)ptr;

    this.owned = owned;
  }

  void* cPtr()
  {
    return cast(void*)cInstancePtr;
  }

  /**
   * Gets the name under which extension was registered.
   * Note that the same type may be registered as extension
   * for multiple extension points, under different names.
   * Returns: the name of extension.
   */
  string getName()
  {
    const(char)* _cretval;
    _cretval = g_io_extension_get_name(cast(GIOExtension*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Gets the priority with which extension was registered.
   * Returns: the priority of extension
   */
  int getPriority()
  {
    int _retval;
    _retval = g_io_extension_get_priority(cast(GIOExtension*)cPtr);
    return _retval;
  }

  /**
   * Gets the type associated with extension.
   * Returns: the type of extension
   */
  GType getType()
  {
    GType _retval;
    _retval = g_io_extension_get_type(cast(GIOExtension*)cPtr);
    return _retval;
  }
}
