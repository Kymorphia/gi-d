module GObject.TypeInstance;

import GLib.c.functions;
import GObject.Types;
import GObject.c.functions;
import GObject.c.types;
import Gid.Gid;

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
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GTypeInstance))
  {
    return cast(T*)&cInstance;
  }

  void* getPrivate(GType privateType)
  {
    void* _retval;
    _retval = g_type_instance_get_private(cPtr!GTypeInstance, privateType);
    return _retval;
  }
}
