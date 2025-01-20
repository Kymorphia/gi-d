module GLib.RecMutex;

import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.gid;

/**
 * The GRecMutex struct is an opaque data structure to represent a
 * recursive mutex. It is similar to a #GMutex with the difference
 * that it is possible to lock a GRecMutex multiple times in the same
 * thread without deadlock. When doing so, care has to be taken to
 * unlock the recursive mutex as often as it has been locked.
 * If a #GRecMutex is allocated in static storage then it can be used
 * without initialisation.  Otherwise, you should call
 * [GLib.RecMutex.init_] on it and [GLib.RecMutex.clear] when done.
 * A GRecMutex should only be accessed with the
 * g_rec_mutex_ functions.
 */
class RecMutex
{
  GRecMutex cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for GLib.RecMutex");

    cInstance = *cast(GRecMutex*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  /**
   * Frees the resources allocated to a recursive mutex with
   * [GLib.RecMutex.init_].
   * This function should not be used with a #GRecMutex that has been
   * statically allocated.
   * Calling [GLib.RecMutex.clear] on a locked recursive mutex leads
   * to undefined behaviour.
   */
  void clear()
  {
    g_rec_mutex_clear(cast(GRecMutex*)cPtr);
  }

  /**
   * Initializes a #GRecMutex so that it can be used.
   * This function is useful to initialize a recursive mutex
   * that has been allocated on the stack, or as part of a larger
   * structure.
   * It is not necessary to initialise a recursive mutex that has been
   * statically allocated.
   * |[<!-- language\="C" -->
   * typedef struct {
   * GRecMutex m;
   * ...
   * } Blob;
   * Blob *b;
   * b \= g_new $(LPAREN)Blob, 1$(RPAREN);
   * g_rec_mutex_init $(LPAREN)&b->m$(RPAREN);
   * ]|
   * Calling [GLib.RecMutex.init_] on an already initialized #GRecMutex
   * leads to undefined behaviour.
   * To undo the effect of [GLib.RecMutex.init_] when a recursive mutex
   * is no longer needed, use [GLib.RecMutex.clear].
   */
  void init_()
  {
    g_rec_mutex_init(cast(GRecMutex*)cPtr);
  }

  /**
   * Locks rec_mutex. If rec_mutex is already locked by another
   * thread, the current thread will block until rec_mutex is
   * unlocked by the other thread. If rec_mutex is already locked
   * by the current thread, the 'lock count' of rec_mutex is increased.
   * The mutex will only become available again when it is unlocked
   * as many times as it has been locked.
   */
  void lock()
  {
    g_rec_mutex_lock(cast(GRecMutex*)cPtr);
  }

  /**
   * Tries to lock rec_mutex. If rec_mutex is already locked
   * by another thread, it immediately returns %FALSE. Otherwise
   * it locks rec_mutex and returns %TRUE.
   * Returns: %TRUE if rec_mutex could be locked
   */
  bool trylock()
  {
    bool _retval;
    _retval = g_rec_mutex_trylock(cast(GRecMutex*)cPtr);
    return _retval;
  }

  /**
   * Unlocks rec_mutex. If another thread is blocked in a
   * [GLib.RecMutex.lock] call for rec_mutex, it will become unblocked
   * and can lock rec_mutex itself.
   * Calling [GLib.RecMutex.unlock] on a recursive mutex that is not
   * locked by the current thread leads to undefined behaviour.
   */
  void unlock()
  {
    g_rec_mutex_unlock(cast(GRecMutex*)cPtr);
  }
}
