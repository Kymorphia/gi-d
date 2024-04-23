module GLib.Mutex;

import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.Gid;

/**
 * The #GMutex struct is an opaque data structure to represent a mutex
 * (mutual exclusion). It can be used to protect data against shared
 * access.
 *
 * Take for example the following function:
 * |[<!-- language="C" -->
 * int
 * give_me_next_number (void)
 * {
 * static int current_number = 0;
 *
 * // now do a very complicated calculation to calculate the new
 * // number, this might for example be a random number generator
 * current_number = calc_next_number (current_number);
 *
 * return current_number;
 * }
 * ]|
 * It is easy to see that this won't work in a multi-threaded
 * application. There current_number must be protected against shared
 * access. A #GMutex can be used as a solution to this problem:
 * |[<!-- language="C" -->
 * int
 * give_me_next_number (void)
 * {
 * static GMutex mutex;
 * static int current_number = 0;
 * int ret_val;
 *
 * g_mutex_lock (&mutex);
 * ret_val = current_number = calc_next_number (current_number);
 * g_mutex_unlock (&mutex);
 *
 * return ret_val;
 * }
 * ]|
 * Notice that the #GMutex is not initialised to any particular value.
 * Its placement in static storage ensures that it will be initialised
 * to all-zeros, which is appropriate.
 *
 * If a #GMutex is placed in other contexts (eg: embedded in a struct)
 * then it must be explicitly initialised using g_mutex_init().
 *
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
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GMutex))
  {
    return cast(T*)&cInstance;
  }

  /**
   * Frees the resources allocated to a mutex with g_mutex_init().
   *
   * This function should not be used with a #GMutex that has been
   * statically allocated.
   *
   * Calling g_mutex_clear() on a locked mutex leads to undefined
   * behaviour.
   */
  void clear()
  {
    g_mutex_clear(cPtr!GMutex);
  }

  /**
   * Initializes a #GMutex so that it can be used.
   *
   * This function is useful to initialize a mutex that has been
   * allocated on the stack, or as part of a larger structure.
   * It is not necessary to initialize a mutex that has been
   * statically allocated.
   *
   * |[<!-- language="C" -->
   * typedef struct {
   * GMutex m;
   * ...
   * } Blob;
   *
   * Blob *b;
   *
   * b = g_new (Blob, 1);
   * g_mutex_init (&b->m);
   * ]|
   *
   * To undo the effect of g_mutex_init() when a mutex is no longer
   * needed, use g_mutex_clear().
   *
   * Calling g_mutex_init() on an already initialized #GMutex leads
   * to undefined behaviour.
   */
  void init_()
  {
    g_mutex_init(cPtr!GMutex);
  }

  /**
   * Locks @mutex. If @mutex is already locked by another thread, the
   * current thread will block until @mutex is unlocked by the other
   * thread.
   *
   * #GMutex is neither guaranteed to be recursive nor to be
   * non-recursive.  As such, calling g_mutex_lock() on a #GMutex that has
   * already been locked by the same thread results in undefined behaviour
   * (including but not limited to deadlocks).
   */
  void lock()
  {
    g_mutex_lock(cPtr!GMutex);
  }

  /**
   * %TRUE if @mutex could be locked
   */
  bool trylock()
  {
    bool _retval;
    _retval = g_mutex_trylock(cPtr!GMutex);
    return _retval;
  }

  /**
   * Unlocks @mutex. If another thread is blocked in a g_mutex_lock()
   * call for @mutex, it will become unblocked and can lock @mutex itself.
   *
   * Calling g_mutex_unlock() on a mutex that is not locked by the
   * current thread leads to undefined behaviour.
   */
  void unlock()
  {
    g_mutex_unlock(cPtr!GMutex);
  }
}
