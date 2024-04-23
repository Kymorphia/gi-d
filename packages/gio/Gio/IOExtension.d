module Gio.IOExtension;

import GObject.Types;
import Gid.Gid;
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

  T* cPtr(T)()
  if (is(T == GIOExtension))
  {
    return cast(T*)cInstancePtr;
  }

  /**
   * the name of @extension.
   */
  string getName()
  {
    const(char)* _cretval;
    _cretval = g_io_extension_get_name(cPtr!GIOExtension);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * the priority of @extension
   */
  int getPriority()
  {
    int _retval;
    _retval = g_io_extension_get_priority(cPtr!GIOExtension);
    return _retval;
  }

  /**
   * the type of @extension
   */
  GType getType()
  {
    GType _retval;
    _retval = g_io_extension_get_type(cPtr!GIOExtension);
    return _retval;
  }
}
