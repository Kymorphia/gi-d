module GObject.TypeInfoG;

import GObject.TypeValueTable;
import GObject.Types;
import GObject.c.functions;
import GObject.c.types;
import Gid.gid;

/**
 * This structure is used to provide the type system with the information
 * required to initialize and destruct $(LPAREN)finalize$(RPAREN) a type's class and
 * its instances.
 * The initialized structure is passed to the [GObject.Global.typeRegisterStatic] function
 * $(LPAREN)or is copied into the provided #GTypeInfo structure in the
 * [GObject.TypePlugin.completeTypeInfo]$(RPAREN). The type system will perform a deep
 * copy of this structure, so its memory does not need to be persistent
 * across invocation of [GObject.Global.typeRegisterStatic].
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
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property ushort classSize()
  {
    return (cast(GTypeInfo*)cPtr).classSize;
  }

  @property void classSize(ushort propval)
  {
    (cast(GTypeInfo*)cPtr).classSize = propval;
  }

  @property GBaseInitFunc baseInit()
  {
    return (cast(GTypeInfo*)cPtr).baseInit;
  }

  @property void baseInit(GBaseInitFunc propval)
  {
    (cast(GTypeInfo*)cPtr).baseInit = propval;
  }

  @property GBaseFinalizeFunc baseFinalize()
  {
    return (cast(GTypeInfo*)cPtr).baseFinalize;
  }

  @property void baseFinalize(GBaseFinalizeFunc propval)
  {
    (cast(GTypeInfo*)cPtr).baseFinalize = propval;
  }

  @property GClassInitFunc classInit()
  {
    return (cast(GTypeInfo*)cPtr).classInit;
  }

  @property void classInit(GClassInitFunc propval)
  {
    (cast(GTypeInfo*)cPtr).classInit = propval;
  }

  @property GClassFinalizeFunc classFinalize()
  {
    return (cast(GTypeInfo*)cPtr).classFinalize;
  }

  @property void classFinalize(GClassFinalizeFunc propval)
  {
    (cast(GTypeInfo*)cPtr).classFinalize = propval;
  }

  @property ushort instanceSize()
  {
    return (cast(GTypeInfo*)cPtr).instanceSize;
  }

  @property void instanceSize(ushort propval)
  {
    (cast(GTypeInfo*)cPtr).instanceSize = propval;
  }

  @property ushort nPreallocs()
  {
    return (cast(GTypeInfo*)cPtr).nPreallocs;
  }

  @property void nPreallocs(ushort propval)
  {
    (cast(GTypeInfo*)cPtr).nPreallocs = propval;
  }

  @property GInstanceInitFunc instanceInit()
  {
    return (cast(GTypeInfo*)cPtr).instanceInit;
  }

  @property void instanceInit(GInstanceInitFunc propval)
  {
    (cast(GTypeInfo*)cPtr).instanceInit = propval;
  }

  @property TypeValueTable valueTable()
  {
    return new TypeValueTable(cast(GTypeValueTable*)(cast(GTypeInfo*)cPtr).valueTable);
  }
}
