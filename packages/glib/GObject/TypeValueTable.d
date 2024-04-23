module GObject.TypeValueTable;

import GLib.c.functions;
import GObject.Types;
import GObject.Value;
import GObject.c.functions;
import GObject.c.types;
import Gid.Gid;

/**
 * The #GTypeValueTable provides the functions required by the #GValue
 * implementation, to serve as a container for values of a type.
 */
class TypeValueTable
{
  GTypeValueTable cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for GObject.TypeValueTable");

    cInstance = *cast(GTypeValueTable*)ptr;

    if (ownedRef)
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GTypeValueTable))
  {
    return cast(T*)&cInstance;
  }

  @property GTypeValueInitFunc valueInit()
  {
    return cPtr!GTypeValueTable.valueInit;
  }

  @property void valueInit(GTypeValueInitFunc propval)
  {
    cPtr!GTypeValueTable.valueInit = propval;
  }

  @property GTypeValueFreeFunc valueFree()
  {
    return cPtr!GTypeValueTable.valueFree;
  }

  @property void valueFree(GTypeValueFreeFunc propval)
  {
    cPtr!GTypeValueTable.valueFree = propval;
  }

  @property GTypeValuePeekPointerFunc valuePeekPointer()
  {
    return cPtr!GTypeValueTable.valuePeekPointer;
  }

  @property void valuePeekPointer(GTypeValuePeekPointerFunc propval)
  {
    cPtr!GTypeValueTable.valuePeekPointer = propval;
  }

  @property string collectFormat()
  {
    return cPtr!GTypeValueTable.collectFormat.fromCString(false);
  }

  @property void collectFormat(string propval)
  {
    g_free(cast(void*)cPtr!GTypeValueTable.collectFormat);
    cPtr!GTypeValueTable.collectFormat = propval.toCString(true);
  }

  @property GTypeValueCollectFunc collectValue()
  {
    return cPtr!GTypeValueTable.collectValue;
  }

  @property void collectValue(GTypeValueCollectFunc propval)
  {
    cPtr!GTypeValueTable.collectValue = propval;
  }

  @property string lcopyFormat()
  {
    return cPtr!GTypeValueTable.lcopyFormat.fromCString(false);
  }

  @property void lcopyFormat(string propval)
  {
    g_free(cast(void*)cPtr!GTypeValueTable.lcopyFormat);
    cPtr!GTypeValueTable.lcopyFormat = propval.toCString(true);
  }

  @property GTypeValueLCopyFunc lcopyValue()
  {
    return cPtr!GTypeValueTable.lcopyValue;
  }

  @property void lcopyValue(GTypeValueLCopyFunc propval)
  {
    cPtr!GTypeValueTable.lcopyValue = propval;
  }
}
