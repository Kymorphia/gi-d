module GObject.ValueArray;

import GLib.Boxed;
import GLib.Types;
import GObject.Types;
import GObject.Value;
import GObject.c.functions;
import GObject.c.types;
import Gid.gid;

/**
 * A `GValueArray` is a container structure to hold an array of generic values.
 * The prime purpose of a `GValueArray` is for it to be used as an
 * object property that holds an array of values. A `GValueArray` wraps
 * an array of `GValue` elements in order for it to be used as a boxed
 * type through `G_TYPE_VALUE_ARRAY`.
 * `GValueArray` is deprecated in favour of `GArray` since GLib 2.32.
 * It is possible to create a `GArray` that behaves like a `GValueArray`
 * by using the size of `GValue` as the element size, and by setting
 * [GObject.Value.unset] as the clear function using
 * [GLib.Array.setClearFunc], for instance, the following code:
 * ```c
 * GValueArray *array \= g_value_array_new $(LPAREN)10$(RPAREN);
 * ```
 * can be replaced by:
 * ```c
 * GArray *array \= g_array_sized_new $(LPAREN)FALSE, TRUE, sizeof $(LPAREN)GValue$(RPAREN), 10$(RPAREN);
 * g_array_set_clear_func $(LPAREN)array, $(LPAREN)GDestroyNotify$(RPAREN) g_value_unset$(RPAREN);
 * ```

 * Deprecated: Use `GArray` instead, if possible for the given use case,
 *   as described above.
 */
class ValueArray : Boxed
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  void* cPtr(bool makeCopy = false)
  {
    return makeCopy ? copy_ : cInstancePtr;
  }

  static GType getType()
  {
    return g_value_array_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  @property uint nValues()
  {
    return (cast(GValueArray*)cPtr).nValues;
  }

  @property void nValues(uint propval)
  {
    (cast(GValueArray*)cPtr).nValues = propval;
  }

  @property Value values()
  {
    return new Value(cast(GValue*)(cast(GValueArray*)cPtr).values);
  }

  /**
   * Allocate and initialize a new #GValueArray, optionally preserve space
   * for n_prealloced elements. New arrays always contain 0 elements,
   * regardless of the value of n_prealloced.
   * Params:
   *   nPrealloced = number of values to preallocate space for
   * Returns: a newly allocated #GValueArray with 0 values

   * Deprecated: Use #GArray and [GLib.Array.sizedNew] instead.
   */
  this(uint nPrealloced)
  {
    GValueArray* _cretval;
    _cretval = g_value_array_new(nPrealloced);
    this(_cretval, true);
  }

  /**
   * Insert a copy of value as last element of value_array. If value is
   * %NULL, an uninitialized value is appended.
   * Params:
   *   value = #GValue to copy into #GValueArray, or %NULL
   * Returns: the #GValueArray passed in as value_array

   * Deprecated: Use #GArray and g_array_append_val$(LPAREN)$(RPAREN) instead.
   */
  ValueArray append(Value value)
  {
    GValueArray* _cretval;
    _cretval = g_value_array_append(cast(GValueArray*)cPtr, value ? cast(GValue*)value.cPtr(false) : null);
    auto _retval = _cretval ? new ValueArray(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Construct an exact copy of a #GValueArray by duplicating all its
   * contents.
   * Returns: Newly allocated copy of #GValueArray

   * Deprecated: Use #GArray and [GLib.Array.ref_] instead.
   */
  ValueArray copy()
  {
    GValueArray* _cretval;
    _cretval = g_value_array_copy(cast(GValueArray*)cPtr);
    auto _retval = _cretval ? new ValueArray(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Return a pointer to the value at index_ containd in value_array.
   * Params:
   *   index = index of the value of interest
   * Returns: pointer to a value at index_ in value_array

   * Deprecated: Use g_array_index$(LPAREN)$(RPAREN) instead.
   */
  Value getNth(uint index)
  {
    GValue* _cretval;
    _cretval = g_value_array_get_nth(cast(GValueArray*)cPtr, index);
    auto _retval = _cretval ? new Value(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Insert a copy of value at specified position into value_array. If value
   * is %NULL, an uninitialized value is inserted.
   * Params:
   *   index = insertion position, must be <\= value_array->;n_values
   *   value = #GValue to copy into #GValueArray, or %NULL
   * Returns: the #GValueArray passed in as value_array

   * Deprecated: Use #GArray and g_array_insert_val$(LPAREN)$(RPAREN) instead.
   */
  ValueArray insert(uint index, Value value)
  {
    GValueArray* _cretval;
    _cretval = g_value_array_insert(cast(GValueArray*)cPtr, index, value ? cast(GValue*)value.cPtr(false) : null);
    auto _retval = _cretval ? new ValueArray(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Insert a copy of value as first element of value_array. If value is
   * %NULL, an uninitialized value is prepended.
   * Params:
   *   value = #GValue to copy into #GValueArray, or %NULL
   * Returns: the #GValueArray passed in as value_array

   * Deprecated: Use #GArray and g_array_prepend_val$(LPAREN)$(RPAREN) instead.
   */
  ValueArray prepend(Value value)
  {
    GValueArray* _cretval;
    _cretval = g_value_array_prepend(cast(GValueArray*)cPtr, value ? cast(GValue*)value.cPtr(false) : null);
    auto _retval = _cretval ? new ValueArray(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Remove the value at position index_ from value_array.
   * Params:
   *   index = position of value to remove, which must be less than
   *     value_array->n_values
   * Returns: the #GValueArray passed in as value_array

   * Deprecated: Use #GArray and [GLib.Array.removeIndex] instead.
   */
  ValueArray remove(uint index)
  {
    GValueArray* _cretval;
    _cretval = g_value_array_remove(cast(GValueArray*)cPtr, index);
    auto _retval = _cretval ? new ValueArray(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Sort value_array using compare_func to compare the elements according
   * to the semantics of #GCompareDataFunc.
   * The current implementation uses the same sorting algorithm as standard
   * C qsort$(LPAREN)$(RPAREN) function.
   * Params:
   *   compareFunc = function to compare elements
   * Returns: the #GValueArray passed in as value_array

   * Deprecated: Use #GArray and [GLib.Array.sortWithData].
   */
  ValueArray sort(CompareDataFunc compareFunc)
  {
    extern(C) int _compareFuncCallback(const(void)* a, const(void)* b, void* userData)
    {
      auto _dlg = cast(CompareDataFunc*)userData;

      int _retval = (*_dlg)(a, b);
      return _retval;
    }

    GValueArray* _cretval;
    auto _compareFunc = cast(void*)&compareFunc;
    _cretval = g_value_array_sort_with_data(cast(GValueArray*)cPtr, &_compareFuncCallback, _compareFunc);
    auto _retval = _cretval ? new ValueArray(cast(void*)_cretval, false) : null;
    return _retval;
  }
}
