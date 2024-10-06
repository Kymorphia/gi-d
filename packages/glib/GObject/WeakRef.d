module GObject.WeakRef;

import GObject.Types;
import GObject.c.functions;
import GObject.c.types;
import Gid.gid;

/**
 * A structure containing a weak reference to a #GObject.
 * A `GWeakRef` can either be empty $(LPAREN)i.e. point to %NULL$(RPAREN), or point to an
 * object for as long as at least one "strong" reference to that object
 * exists. Before the object's #GObjectClass.dispose method is called,
 * every #GWeakRef associated with becomes empty $(LPAREN)i.e. points to %NULL$(RPAREN).
 * Like #GValue, #GWeakRef can be statically allocated, stack- or
 * heap-allocated, or embedded in larger structures.
 * Unlike [GObject.ObjectG.weakRef] and [GObject.ObjectG.addWeakPointer], this weak
 * reference is thread-safe: converting a weak pointer to a reference is
 * atomic with respect to invalidation of weak pointers to destroyed
 * objects.
 * If the object's #GObjectClass.dispose method results in additional
 * references to the object being held $(LPAREN)‘re-referencing’$(RPAREN), any #GWeakRefs taken
 * before it was disposed will continue to point to %NULL.  Any #GWeakRefs taken
 * during disposal and after re-referencing, or after disposal has returned due
 * to the re-referencing, will continue to point to the object until its refcount
 * goes back to zero, at which point they too will be invalidated.
 * It is invalid to take a #GWeakRef on an object during #GObjectClass.dispose
 * without first having or creating a strong reference to the object.
 */
class WeakRef
{
  GWeakRef cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for GObject.WeakRef");

    cInstance = *cast(GWeakRef*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }
}
