module GLib.VariantIter;

import GLib.Types;
import GLib.Variant;
import GLib.c.functions;
import GLib.c.types;
import Gid.gid;

/**
 * #GVariantIter is an opaque data structure and can only be accessed
 * using the following functions.
 */
class VariantIter
{
  GVariantIter cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for GLib.VariantIter");

    cInstance = *cast(GVariantIter*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  ~this()
  {
    g_variant_iter_free(&cInstance);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  /**
   * Queries the number of child items in the container that we are
   * iterating over.  This is the total number of items -- not the number
   * of items remaining.
   * This function might be useful for preallocation of arrays.
   * Returns: the number of children in the container
   */
  size_t nChildren()
  {
    size_t _retval;
    _retval = g_variant_iter_n_children(cast(GVariantIter*)cPtr);
    return _retval;
  }

  /**
   * Gets the next item in the container.  If no more items remain then
   * %NULL is returned.
   * Use [GLib.Variant.unref] to drop your reference on the return value when
   * you no longer need it.
   * Here is an example for iterating with [GLib.VariantIter.nextValue]:
   * |[<!-- language\="C" -->
   * // recursively iterate a container
   * void
   * iterate_container_recursive $(LPAREN)GVariant *container$(RPAREN)
   * {
   * GVariantIter iter;
   * GVariant *child;
   * g_variant_iter_init $(LPAREN)&iter, container$(RPAREN);
   * while $(LPAREN)$(LPAREN)child \= g_variant_iter_next_value $(LPAREN)&iter$(RPAREN)$(RPAREN)$(RPAREN)
   * {
   * g_print $(LPAREN)"type '%s'\n", g_variant_get_type_string $(LPAREN)child$(RPAREN)$(RPAREN);
   * if $(LPAREN)g_variant_is_container $(LPAREN)child$(RPAREN)$(RPAREN)
   * iterate_container_recursive $(LPAREN)child$(RPAREN);
   * g_variant_unref $(LPAREN)child$(RPAREN);
   * }
   * }
   * ]|
   * Returns: a #GVariant, or %NULL
   */
  Variant nextValue()
  {
    GVariant* _cretval;
    _cretval = g_variant_iter_next_value(cast(GVariantIter*)cPtr);
    auto _retval = _cretval ? new Variant(cast(GVariant*)_cretval, true) : null;
    return _retval;
  }
}
