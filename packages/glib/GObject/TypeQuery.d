module GObject.TypeQuery;

import GLib.c.functions;
import GObject.Types;
import GObject.c.functions;
import GObject.c.types;
import Gid.Gid;

/**
 * A structure holding information for a specific type.
 *
 * See also: g_type_query()
 */
class TypeQuery
{
  GTypeQuery cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for GObject.TypeQuery");

    cInstance = *cast(GTypeQuery*)ptr;

    if (ownedRef)
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GTypeQuery))
  {
    return cast(T*)&cInstance;
  }

  @property GType type()
  {
    return cPtr!GTypeQuery.type;
  }

  @property void type(GType propval)
  {
    cPtr!GTypeQuery.type = propval;
  }

  @property string typeName()
  {
    return cPtr!GTypeQuery.typeName.fromCString(false);
  }

  @property void typeName(string propval)
  {
    g_free(cast(void*)cPtr!GTypeQuery.typeName);
    cPtr!GTypeQuery.typeName = propval.toCString(true);
  }

  @property uint classSize()
  {
    return cPtr!GTypeQuery.classSize;
  }

  @property void classSize(uint propval)
  {
    cPtr!GTypeQuery.classSize = propval;
  }

  @property uint instanceSize()
  {
    return cPtr!GTypeQuery.instanceSize;
  }

  @property void instanceSize(uint propval)
  {
    cPtr!GTypeQuery.instanceSize = propval;
  }
}
