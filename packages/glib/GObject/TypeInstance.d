module GObject.TypeInstance;

import GObject.Types;
import GObject.c.functions;
import GObject.c.types;
import Gid.gid;

/**
 * An opaque structure used as the base of all type instances.
 */
class TypeInstance
{
  GTypeInstance cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for GObject.TypeInstance");

    cInstance = *cast(GTypeInstance*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  void* getPrivate(GType privateType)
  {
    void* _retval;
    _retval = g_type_instance_get_private(cast(GTypeInstance*)cPtr, privateType);
    return _retval;
  }
}
