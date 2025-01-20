module GObject.TypeQuery;

import GObject.Types;
import GObject.c.functions;
import GObject.c.types;
import Gid.gid;

/**
 * A structure holding information for a specific type.
 * See also: [GObject.Global.typeQuery]
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
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property GType type()
  {
    return (cast(GTypeQuery*)cPtr).type;
  }

  @property void type(GType propval)
  {
    (cast(GTypeQuery*)cPtr).type = propval;
  }

  @property string typeName()
  {
    return (cast(GTypeQuery*)cPtr).typeName.fromCString(false);
  }

  @property void typeName(string propval)
  {
    safeFree(cast(void*)(cast(GTypeQuery*)cPtr).typeName);
    (cast(GTypeQuery*)cPtr).typeName = propval.toCString(true);
  }

  @property uint classSize()
  {
    return (cast(GTypeQuery*)cPtr).classSize;
  }

  @property void classSize(uint propval)
  {
    (cast(GTypeQuery*)cPtr).classSize = propval;
  }

  @property uint instanceSize()
  {
    return (cast(GTypeQuery*)cPtr).instanceSize;
  }

  @property void instanceSize(uint propval)
  {
    (cast(GTypeQuery*)cPtr).instanceSize = propval;
  }
}
