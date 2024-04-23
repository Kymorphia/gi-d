module GObject.ValueArray;

import GLib.Boxed;
import GLib.Types;
import GObject.Types;
import GObject.Value;
import GObject.c.functions;
import GObject.c.types;
import Gid.Gid;

/**
 * A #GValueArray contains an array of #GValue elements.
 */
class ValueArray : Boxed
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  T* cPtr(T)(bool makeCopy = false)
  if (is(T == GValueArray))
  {
    return makeCopy ? copy_!T : cast(T*)cInstancePtr;
  }

  static GType getType()
  {
    return g_value_array_get_type();
  }

  @property uint nValues()
  {
    return cPtr!GValueArray.nValues;
  }

  @property void nValues(uint propval)
  {
    cPtr!GValueArray.nValues = propval;
  }

  @property Value values()
  {
    return new Value(cast(GValue*)cPtr!GValueArray.values);
  }

  /**
   * a newly allocated #GValueArray with 0 values
   */
  this(uint nPrealloced)
  {
    GValueArray* _cretval;
    _cretval = g_value_array_new(nPrealloced);
    this(_cretval, true);
  }

  /**
   * the #GValueArray passed in as @value_array
   */
  ValueArray append(Value value)
  {
    GValueArray* _cretval;
    _cretval = g_value_array_append(cPtr!GValueArray, value ? value.cPtr!GValue : null);
    ValueArray _retval = new ValueArray(cast(GValueArray*)_cretval, false);
    return _retval;
  }

  /**
   * Newly allocated copy of #GValueArray
   */
  ValueArray copy()
  {
    GValueArray* _cretval;
    _cretval = g_value_array_copy(cPtr!GValueArray);
    ValueArray _retval = new ValueArray(cast(GValueArray*)_cretval, true);
    return _retval;
  }

  /**
   * pointer to a value at @index_ in @value_array
   */
  Value getNth(uint index)
  {
    GValue* _cretval;
    _cretval = g_value_array_get_nth(cPtr!GValueArray, index);
    Value _retval = new Value(cast(GValue*)_cretval, false);
    return _retval;
  }

  /**
   * the #GValueArray passed in as @value_array
   */
  ValueArray insert(uint index, Value value)
  {
    GValueArray* _cretval;
    _cretval = g_value_array_insert(cPtr!GValueArray, index, value ? value.cPtr!GValue : null);
    ValueArray _retval = new ValueArray(cast(GValueArray*)_cretval, false);
    return _retval;
  }

  /**
   * the #GValueArray passed in as @value_array
   */
  ValueArray prepend(Value value)
  {
    GValueArray* _cretval;
    _cretval = g_value_array_prepend(cPtr!GValueArray, value ? value.cPtr!GValue : null);
    ValueArray _retval = new ValueArray(cast(GValueArray*)_cretval, false);
    return _retval;
  }

  /**
   * the #GValueArray passed in as @value_array
   */
  ValueArray remove(uint index)
  {
    GValueArray* _cretval;
    _cretval = g_value_array_remove(cPtr!GValueArray, index);
    ValueArray _retval = new ValueArray(cast(GValueArray*)_cretval, false);
    return _retval;
  }

  /**
   * the #GValueArray passed in as @value_array
   */
  ValueArray sort(CompareDataFunc compareFunc)
  {
    static CompareDataFunc _static_compareFunc;

    extern(C) int _compareFuncCallback(const(void)* a, const(void)* b, void* userData)
    {
      int _retval = _static_compareFunc(a, b);
      return _retval;
    }

    _static_compareFunc = compareFunc;
    GValueArray* _cretval;
    ptrFreezeGC(cast(void*)&compareFunc);
    _cretval = g_value_array_sort_with_data(cPtr!GValueArray, &_compareFuncCallback, cast(void*)&compareFunc);
    _static_compareFunc = null;
    ValueArray _retval = new ValueArray(cast(GValueArray*)_cretval, false);
    return _retval;
  }
}
