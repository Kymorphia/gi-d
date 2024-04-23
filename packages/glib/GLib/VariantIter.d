module GLib.VariantIter;

import GLib.Types;
import GLib.Variant;
import GLib.c.functions;
import GLib.c.types;
import Gid.Gid;

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
      g_free(ptr);
  }

  ~this()
  {
    g_variant_iter_free(&cInstance);
  }

  T* cPtr(T)()
  if (is(T == GVariantIter))
  {
    return cast(T*)&cInstance;
  }

  /**
   * the number of children in the container
   */
  size_t nChildren()
  {
    size_t _retval;
    _retval = g_variant_iter_n_children(cPtr!GVariantIter);
    return _retval;
  }

  /**
   * a #GVariant, or %NULL
   */
  Variant nextValue()
  {
    GVariant* _cretval;
    _cretval = g_variant_iter_next_value(cPtr!GVariantIter);
    Variant _retval = new Variant(cast(GVariant*)_cretval, true);
    return _retval;
  }
}
