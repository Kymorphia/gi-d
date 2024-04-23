module GLib.Private;

import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.Gid;

/**
 * The #GPrivate struct is an opaque data structure to represent a
 * thread-local data key. It is approximately equivalent to the
 * pthread_setspecific()/pthread_getspecific() APIs on POSIX and to
 * TlsSetValue()/TlsGetValue() on Windows.
 *
 * If you don't already know why you might want this functionality,
 * then you probably don't need it.
 *
 * #GPrivate is a very limited resource (as far as 128 per program,
 * shared between all libraries). It is also not possible to destroy a
 * #GPrivate after it has been used. As such, it is only ever acceptable
 * to use #GPrivate in static scope, and even then sparingly so.
 *
 * See G_PRIVATE_INIT() for a couple of examples.
 *
 * The #GPrivate structure should be considered opaque.  It should only
 * be accessed via the g_private_ functions.
 */
class Private
{
  GPrivate cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for GLib.Private");

    cInstance = *cast(GPrivate*)ptr;

    if (ownedRef)
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GPrivate))
  {
    return cast(T*)&cInstance;
  }

  /**
   * the thread-local value
   */
  void* get()
  {
    void* _retval;
    _retval = g_private_get(cPtr!GPrivate);
    return _retval;
  }

  /**
   * Sets the thread local variable @key to have the value @value in the
   * current thread.
   *
   * This function differs from g_private_set() in the following way: if
   * the previous value was non-%NULL then the #GDestroyNotify handler for
   * @key is run on it.
   */
  void replace(void* value)
  {
    g_private_replace(cPtr!GPrivate, value);
  }

  /**
   * Sets the thread local variable @key to have the value @value in the
   * current thread.
   *
   * This function differs from g_private_replace() in the following way:
   * the #GDestroyNotify for @key is not called on the old value.
   */
  void set(void* value)
  {
    g_private_set(cPtr!GPrivate, value);
  }
}
