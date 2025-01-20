module GLib.Private;

import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.gid;

/**
 * The #GPrivate struct is an opaque data structure to represent a
 * thread-local data key. It is approximately equivalent to the
 * pthread_setspecific$(LPAREN)$(RPAREN)/pthread_getspecific$(LPAREN)$(RPAREN) APIs on POSIX and to
 * TlsSetValue$(LPAREN)$(RPAREN)/TlsGetValue$(LPAREN)$(RPAREN) on Windows.
 * If you don't already know why you might want this functionality,
 * then you probably don't need it.
 * #GPrivate is a very limited resource $(LPAREN)as far as 128 per program,
 * shared between all libraries$(RPAREN). It is also not possible to destroy a
 * #GPrivate after it has been used. As such, it is only ever acceptable
 * to use #GPrivate in static scope, and even then sparingly so.
 * See G_PRIVATE_INIT$(LPAREN)$(RPAREN) for a couple of examples.
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
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  /**
   * Returns the current value of the thread local variable key.
   * If the value has not yet been set in this thread, %NULL is returned.
   * Values are never copied between threads $(LPAREN)when a new thread is
   * created, for example$(RPAREN).
   * Returns: the thread-local value
   */
  void* get()
  {
    void* _retval;
    _retval = g_private_get(cast(GPrivate*)cPtr);
    return _retval;
  }

  /**
   * Sets the thread local variable key to have the value value in the
   * current thread.
   * This function differs from [GLib.Private.set] in the following way: if
   * the previous value was non-%NULL then the #GDestroyNotify handler for
   * key is run on it.
   * Params:
   *   value = the new value
   */
  void replace(void* value)
  {
    g_private_replace(cast(GPrivate*)cPtr, value);
  }

  /**
   * Sets the thread local variable key to have the value value in the
   * current thread.
   * This function differs from [GLib.Private.replace] in the following way:
   * the #GDestroyNotify for key is not called on the old value.
   * Params:
   *   value = the new value
   */
  void set(void* value)
  {
    g_private_set(cast(GPrivate*)cPtr, value);
  }
}
