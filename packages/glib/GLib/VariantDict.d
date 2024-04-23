module GLib.VariantDict;

import GLib.Boxed;
import GLib.Types;
import GLib.Variant;
import GLib.VariantType;
import GLib.c.functions;
import GLib.c.types;
import Gid.Gid;

/**
 * #GVariantDict is a mutable interface to #GVariant dictionaries.
 *
 * It can be used for doing a sequence of dictionary lookups in an
 * efficient way on an existing #GVariant dictionary or it can be used
 * to construct new dictionaries with a hashtable-like interface.  It
 * can also be used for taking existing dictionaries and modifying them
 * in order to create new ones.
 *
 * #GVariantDict can only be used with %G_VARIANT_TYPE_VARDICT
 * dictionaries.
 *
 * It is possible to use #GVariantDict allocated on the stack or on the
 * heap.  When using a stack-allocated #GVariantDict, you begin with a
 * call to g_variant_dict_init() and free the resources with a call to
 * g_variant_dict_clear().
 *
 * Heap-allocated #GVariantDict follows normal refcounting rules: you
 * allocate it with g_variant_dict_new() and use g_variant_dict_ref()
 * and g_variant_dict_unref().
 *
 * g_variant_dict_end() is used to convert the #GVariantDict back into a
 * dictionary-type #GVariant.  When used with stack-allocated instances,
 * this also implicitly frees all associated memory, but for
 * heap-allocated instances, you must still call g_variant_dict_unref()
 * afterwards.
 *
 * You will typically want to use a heap-allocated #GVariantDict when
 * you expose it as part of an API.  For most other uses, the
 * stack-allocated form will be more convenient.
 *
 * Consider the following two examples that do the same thing in each
 * style: take an existing dictionary and look up the "count" uint32
 * key, adding 1 to it if it is found, or returning an error if the
 * key is not found.  Each returns the new dictionary as a floating
 * #GVariant.
 *
 * ## Using a stack-allocated GVariantDict
 *
 * |[<!-- language="C" -->
 * GVariant *
 * add_to_count (GVariant  *orig,
 * GError   **error)
 * {
 * GVariantDict dict;
 * guint32 count;
 *
 * g_variant_dict_init (&dict, orig);
 * if (!g_variant_dict_lookup (&dict, "count", "u", &count))
 * {
 * g_set_error (...);
 * g_variant_dict_clear (&dict);
 * return NULL;
 * }
 *
 * g_variant_dict_insert (&dict, "count", "u", count + 1);
 *
 * return g_variant_dict_end (&dict);
 * }
 * ]|
 *
 * ## Using heap-allocated GVariantDict
 *
 * |[<!-- language="C" -->
 * GVariant *
 * add_to_count (GVariant  *orig,
 * GError   **error)
 * {
 * GVariantDict *dict;
 * GVariant *result;
 * guint32 count;
 *
 * dict = g_variant_dict_new (orig);
 *
 * if (g_variant_dict_lookup (dict, "count", "u", &count))
 * {
 * g_variant_dict_insert (dict, "count", "u", count + 1);
 * result = g_variant_dict_end (dict);
 * }
 * else
 * {
 * g_set_error (...);
 * result = NULL;
 * }
 *
 * g_variant_dict_unref (dict);
 *
 * return result;
 * }
 * ]|
 */
class VariantDict : Boxed
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  T* cPtr(T)(bool makeCopy = false)
  if (is(T == GVariantDict))
  {
    return makeCopy ? copy_!T : cast(T*)cInstancePtr;
  }

  static GType getType()
  {
    return g_variant_dict_get_type();
  }

  /**
   * a #GVariantDict
   */
  this(Variant fromAsv)
  {
    GVariantDict* _cretval;
    _cretval = g_variant_dict_new(fromAsv ? fromAsv.cPtr!GVariant : null);
    this(_cretval, true);
  }

  /**
   * Releases all memory associated with a #GVariantDict without freeing
   * the #GVariantDict structure itself.
   *
   * It typically only makes sense to do this on a stack-allocated
   * #GVariantDict if you want to abort building the value part-way
   * through.  This function need not be called if you call
   * g_variant_dict_end() and it also doesn't need to be called on dicts
   * allocated with g_variant_dict_new (see g_variant_dict_unref() for
   * that).
   *
   * It is valid to call this function on either an initialised
   * #GVariantDict or one that was previously cleared by an earlier call
   * to g_variant_dict_clear() but it is not valid to call this function
   * on uninitialised memory.
   */
  void clear()
  {
    g_variant_dict_clear(cPtr!GVariantDict);
  }

  /**
   * %TRUE if @key is in @dict
   */
  bool contains(string key)
  {
    bool _retval;
    const(char)* _key = key.toCString(false);
    _retval = g_variant_dict_contains(cPtr!GVariantDict, _key);
    return _retval;
  }

  /**
   * a new, floating, #GVariant
   */
  Variant end()
  {
    GVariant* _cretval;
    _cretval = g_variant_dict_end(cPtr!GVariantDict);
    Variant _retval = new Variant(cast(GVariant*)_cretval, false);
    return _retval;
  }

  /**
   * Inserts (or replaces) a key in a #GVariantDict.
   *
   * @value is consumed if it is floating.
   */
  void insertValue(string key, Variant value)
  {
    const(char)* _key = key.toCString(false);
    g_variant_dict_insert_value(cPtr!GVariantDict, _key, value ? value.cPtr!GVariant : null);
  }

  /**
   * the value of the dictionary key, or %NULL
   */
  Variant lookupValue(string key, VariantType expectedType)
  {
    GVariant* _cretval;
    const(char)* _key = key.toCString(false);
    _cretval = g_variant_dict_lookup_value(cPtr!GVariantDict, _key, expectedType ? expectedType.cPtr!GVariantType : null);
    Variant _retval = new Variant(cast(GVariant*)_cretval, true);
    return _retval;
  }

  /**
   * %TRUE if the key was found and removed
   */
  bool remove(string key)
  {
    bool _retval;
    const(char)* _key = key.toCString(false);
    _retval = g_variant_dict_remove(cPtr!GVariantDict, _key);
    return _retval;
  }
}
