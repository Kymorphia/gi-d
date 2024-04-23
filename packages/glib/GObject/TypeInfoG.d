module GObject.TypeInfoG;

import GLib.c.functions;
import GObject.TypeClass;
import GObject.TypeInstance;
import GObject.TypeValueTable;
import GObject.Types;
import GObject.c.functions;
import GObject.c.types;
import Gid.Gid;

/**
 * This structure is used to provide the type system with the information
 * required to initialize and destruct (finalize) a type's class and
 * its instances.
 *
 * The initialized structure is passed to the g_type_register_static() function
 * (or is copied into the provided #GTypeInfo structure in the
 * g_type_plugin_complete_type_info()). The type system will perform a deep
 * copy of this structure, so its memory does not need to be persistent
 * across invocation of g_type_register_static().
 */
class TypeInfoG
{
  GTypeInfo cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for GObject.TypeInfoG");

    cInstance = *cast(GTypeInfo*)ptr;

    if (ownedRef)
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GTypeInfo))
  {
    return cast(T*)&cInstance;
  }

  @property ushort classSize()
  {
    return cPtr!GTypeInfo.classSize;
  }

  @property void classSize(ushort propval)
  {
    cPtr!GTypeInfo.classSize = propval;
  }

  @property GBaseInitFunc baseInit()
  {
    return cPtr!GTypeInfo.baseInit;
  }

  @property void baseInit(GBaseInitFunc propval)
  {
    cPtr!GTypeInfo.baseInit = propval;
  }

  @property GBaseFinalizeFunc baseFinalize()
  {
    return cPtr!GTypeInfo.baseFinalize;
  }

  @property void baseFinalize(GBaseFinalizeFunc propval)
  {
    cPtr!GTypeInfo.baseFinalize = propval;
  }

  @property GClassInitFunc classInit()
  {
    return cPtr!GTypeInfo.classInit;
  }

  @property void classInit(GClassInitFunc propval)
  {
    cPtr!GTypeInfo.classInit = propval;
  }

  @property GClassFinalizeFunc classFinalize()
  {
    return cPtr!GTypeInfo.classFinalize;
  }

  @property void classFinalize(GClassFinalizeFunc propval)
  {
    cPtr!GTypeInfo.classFinalize = propval;
  }

  @property ushort instanceSize()
  {
    return cPtr!GTypeInfo.instanceSize;
  }

  @property void instanceSize(ushort propval)
  {
    cPtr!GTypeInfo.instanceSize = propval;
  }

  @property ushort nPreallocs()
  {
    return cPtr!GTypeInfo.nPreallocs;
  }

  @property void nPreallocs(ushort propval)
  {
    cPtr!GTypeInfo.nPreallocs = propval;
  }

  @property GInstanceInitFunc instanceInit()
  {
    return cPtr!GTypeInfo.instanceInit;
  }

  @property void instanceInit(GInstanceInitFunc propval)
  {
    cPtr!GTypeInfo.instanceInit = propval;
  }

  @property TypeValueTable valueTable()
  {
    return new TypeValueTable(cast(GTypeValueTable*)cPtr!GTypeInfo.valueTable);
  }
}
