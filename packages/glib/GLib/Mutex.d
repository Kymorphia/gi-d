module GLib.Mutex;

import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.gid;

/**
 * The #GMutex struct is an opaque data structure to represent a mutex
 * $(LPAREN)mutual exclusion$(RPAREN). It can be used to protect data against shared
 * access.
 * Take for example the following function:
 * |[<!-- language\="C" -->
 * int
 * give_me_next_number $(LPAREN)void$(RPAREN)
 * {
 * static int current_number \= 0;
 * // now do a very complicated calculation to calculate the new
 * // number, this might for example be a random number generator
 * current_number \= calc_next_number $(LPAREN)current_number$(RPAREN);
 * return current_number;
 * }
 * ]|
 * It is easy to see that this won't work in a multi-threaded
 * application. There current_number must be protected against shared
 * access. A #GMutex can be used as a solution to this problem:
 * |[<!-- language\="C" -->
 * int
 * give_me_next_number $(LPAREN)void$(RPAREN)
 * {
 * static GMutex mutex;
 * static int current_number \= 0;
 * int ret_val;
 * g_mutex_lock $(LPAREN)&mutex$(RPAREN);
 * ret_val \= current_number \= calc_next_number $(LPAREN)current_number$(RPAREN);
 * g_mutex_unlock $(LPAREN)&mutex$(RPAREN);
 * return ret_val;
 * }
 * ]|
 * Notice that the #GMutex is not initialised to any particular value.
 * Its placement in static storage ensures that it will be initialised
 * to all-zeros, which is appropriate.
 * If a #GMutex is placed in other contexts $(LPAREN)eg: embedded in a struct$(RPAREN)
 * then it must be explicitly initialised using [GLib.Mutex.init_].
 * A #GMutex should only be accessed via g_mutex_ functions.
 */
class Mutex
{
  GMutex cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for GLib.Mutex");

    cInstance = *cast(GMutex*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  /**
   * Frees the resources allocated to a mutex with [GLib.Mutex.init_].
   * This function should not be used with a #GMutex that has been
   * statically allocated.
   * Calling [GLib.Mutex.clear] on a locked mutex leads to undefined
   * behaviour.
   */
  void clear()
  {
    g_mutex_clear(cast(GMutex*)cPtr);
  }

  /**
   * Initializes a #GMutex so that it can be used.
   * This function is useful to initialize a mutex that has been
   * allocated on the stack, or as part of a larger structure.
   * It is not necessary to initialize a mutex that has been
   * statically allocated.
   * |[<!-- language\="C" -->
   * typedef struct {
   * GMutex m;
   * ...
   * } Blob;
   * Blob *b;
   * b \= g_new $(LPAREN)Blob, 1$(RPAREN);
   * g_mutex_init $(LPAREN)&b->m$(RPAREN);
   * ]|
   * To undo the effect of [GLib.Mutex.init_] when a mutex is no longer
   * needed, use [GLib.Mutex.clear].
   * Calling [GLib.Mutex.init_] on an already initialized #GMutex leads
   * to undefined behaviour.
   */
  void init_()
  {
    g_mutex_init(cast(GMutex*)cPtr);
  }

  /**
   * Locks mutex. If mutex is already locked by another thread, the
   * current thread will block until mutex is unlocked by the other
   * thread.
   * #GMutex is neither guaranteed to be recursive nor to be
   * non-recursive.  As such, calling [GLib.Mutex.lock] on a #GMutex that has
   * already been locked by the same thread results in undefined behaviour
   * $(LPAREN)including but not limited to deadlocks$(RPAREN).
   */
  void lock()
  {
    g_mutex_lock(cast(GMutex*)cPtr);
  }

  /**
   * Tries to lock mutex. If mutex is already locked by another thread,
   * it immediately returns %FALSE. Otherwise it locks mutex and returns
   * %TRUE.
   * #GMutex is neither guaranteed to be recursive nor to be
   * non-recursive.  As such, calling [GLib.Mutex.lock] on a #GMutex that has
   * already been locked by the same thread results in undefined behaviour
   * $(LPAREN)including but not limited to deadlocks or arbitrary return values$(RPAREN).
   * Returns: %TRUE if mutex could be locked
   */
  bool trylock()
  {
    bool _retval;
    _retval = g_mutex_trylock(cast(GMutex*)cPtr);
    return _retval;
  }

  /**
   * Unlocks mutex. If another thread is blocked in a [GLib.Mutex.lock]
   * call for mutex, it will become unblocked and can lock mutex itself.
   * Calling [GLib.Mutex.unlock] on a mutex that is not locked by the
   * current thread leads to undefined behaviour.
   */
  void unlock()
  {
    g_mutex_unlock(cast(GMutex*)cPtr);
  }
}
