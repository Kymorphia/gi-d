module GLib.Cond;

import GLib.Mutex;
import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.gid;

/**
 * The #GCond struct is an opaque data structure that represents a
 * condition. Threads can block on a #GCond if they find a certain
 * condition to be false. If other threads change the state of this
 * condition they signal the #GCond, and that causes the waiting
 * threads to be woken up.
 * Consider the following example of a shared variable.  One or more
 * threads can wait for data to be published to the variable and when
 * another thread publishes the data, it can signal one of the waiting
 * threads to wake up to collect the data.
 * Here is an example for using GCond to block a thread until a condition
 * is satisfied:
 * |[<!-- language\="C" -->
 * gpointer current_data \= NULL;
 * GMutex data_mutex;
 * GCond data_cond;
 * void
 * push_data $(LPAREN)gpointer data$(RPAREN)
 * {
 * g_mutex_lock $(LPAREN)&data_mutex$(RPAREN);
 * current_data \= data;
 * g_cond_signal $(LPAREN)&data_cond$(RPAREN);
 * g_mutex_unlock $(LPAREN)&data_mutex$(RPAREN);
 * }
 * gpointer
 * pop_data $(LPAREN)void$(RPAREN)
 * {
 * gpointer data;
 * g_mutex_lock $(LPAREN)&data_mutex$(RPAREN);
 * while $(LPAREN)!current_data$(RPAREN)
 * g_cond_wait $(LPAREN)&data_cond, &data_mutex$(RPAREN);
 * data \= current_data;
 * current_data \= NULL;
 * g_mutex_unlock $(LPAREN)&data_mutex$(RPAREN);
 * return data;
 * }
 * ]|
 * Whenever a thread calls pop_data$(LPAREN)$(RPAREN) now, it will wait until
 * current_data is non-%NULL, i.e. until some other thread
 * has called push_data$(LPAREN)$(RPAREN).
 * The example shows that use of a condition variable must always be
 * paired with a mutex.  Without the use of a mutex, there would be a
 * race between the check of @current_data by the while loop in
 * pop_data$(LPAREN)$(RPAREN) and waiting. Specifically, another thread could set
 * @current_data after the check, and signal the cond $(LPAREN)with nobody
 * waiting on it$(RPAREN) before the first thread goes to sleep. #GCond is
 * specifically useful for its ability to release the mutex and go
 * to sleep atomically.
 * It is also important to use the [GLib.Cond.wait] and [GLib.Cond.waitUntil]
 * functions only inside a loop which checks for the condition to be
 * true.  See [GLib.Cond.wait] for an explanation of why the condition may
 * not be true even after it returns.
 * If a #GCond is allocated in static storage then it can be used
 * without initialisation.  Otherwise, you should call [GLib.Cond.init_]
 * on it and [GLib.Cond.clear] when done.
 * A #GCond should only be accessed via the g_cond_ functions.
 */
class Cond
{
  GCond cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for GLib.Cond");

    cInstance = *cast(GCond*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  /**
   * If threads are waiting for cond, all of them are unblocked.
   * If no threads are waiting for cond, this function has no effect.
   * It is good practice to lock the same mutex as the waiting threads
   * while calling this function, though not required.
   */
  void broadcast()
  {
    g_cond_broadcast(cast(GCond*)cPtr);
  }

  /**
   * Frees the resources allocated to a #GCond with [GLib.Cond.init_].
   * This function should not be used with a #GCond that has been
   * statically allocated.
   * Calling [GLib.Cond.clear] for a #GCond on which threads are
   * blocking leads to undefined behaviour.
   */
  void clear()
  {
    g_cond_clear(cast(GCond*)cPtr);
  }

  /**
   * Initialises a #GCond so that it can be used.
   * This function is useful to initialise a #GCond that has been
   * allocated as part of a larger structure.  It is not necessary to
   * initialise a #GCond that has been statically allocated.
   * To undo the effect of [GLib.Cond.init_] when a #GCond is no longer
   * needed, use [GLib.Cond.clear].
   * Calling [GLib.Cond.init_] on an already-initialised #GCond leads
   * to undefined behaviour.
   */
  void init_()
  {
    g_cond_init(cast(GCond*)cPtr);
  }

  /**
   * If threads are waiting for cond, at least one of them is unblocked.
   * If no threads are waiting for cond, this function has no effect.
   * It is good practice to hold the same lock as the waiting thread
   * while calling this function, though not required.
   */
  void signal()
  {
    g_cond_signal(cast(GCond*)cPtr);
  }

  /**
   * Atomically releases mutex and waits until cond is signalled.
   * When this function returns, mutex is locked again and owned by the
   * calling thread.
   * When using condition variables, it is possible that a spurious wakeup
   * may occur $(LPAREN)ie: [GLib.Cond.wait] returns even though [GLib.Cond.signal] was
   * not called$(RPAREN).  It's also possible that a stolen wakeup may occur.
   * This is when [GLib.Cond.signal] is called, but another thread acquires
   * mutex before this thread and modifies the state of the program in
   * such a way that when [GLib.Cond.wait] is able to return, the expected
   * condition is no longer met.
   * For this reason, [GLib.Cond.wait] must always be used in a loop.  See
   * the documentation for #GCond for a complete example.
   * Params:
   *   mutex = a #GMutex that is currently locked
   */
  void wait(Mutex mutex)
  {
    g_cond_wait(cast(GCond*)cPtr, mutex ? cast(GMutex*)mutex.cPtr : null);
  }

  /**
   * Waits until either cond is signalled or end_time has passed.
   * As with [GLib.Cond.wait] it is possible that a spurious or stolen wakeup
   * could occur.  For that reason, waiting on a condition variable should
   * always be in a loop, based on an explicitly-checked predicate.
   * %TRUE is returned if the condition variable was signalled $(LPAREN)or in the
   * case of a spurious wakeup$(RPAREN).  %FALSE is returned if end_time has
   * passed.
   * The following code shows how to correctly perform a timed wait on a
   * condition variable $(LPAREN)extending the example presented in the
   * documentation for #GCond$(RPAREN):
   * |[<!-- language\="C" -->
   * gpointer
   * pop_data_timed $(LPAREN)void$(RPAREN)
   * {
   * gint64 end_time;
   * gpointer data;
   * g_mutex_lock $(LPAREN)&data_mutex$(RPAREN);
   * end_time \= g_get_monotonic_time $(LPAREN)$(RPAREN) + 5 * G_TIME_SPAN_SECOND;
   * while $(LPAREN)!current_data$(RPAREN)
   * if $(LPAREN)!g_cond_wait_until $(LPAREN)&data_cond, &data_mutex, end_time$(RPAREN)$(RPAREN)
   * {
   * // timeout has passed.
   * g_mutex_unlock $(LPAREN)&data_mutex$(RPAREN);
   * return NULL;
   * }
   * // there is data for us
   * data \= current_data;
   * current_data \= NULL;
   * g_mutex_unlock $(LPAREN)&data_mutex$(RPAREN);
   * return data;
   * }
   * ]|
   * Notice that the end time is calculated once, before entering the
   * loop and reused.  This is the motivation behind the use of absolute
   * time on this API -- if a relative time of 5 seconds were passed
   * directly to the call and a spurious wakeup occurred, the program would
   * have to start over waiting again $(LPAREN)which would lead to a total wait
   * time of more than 5 seconds$(RPAREN).
   * Params:
   *   mutex = a #GMutex that is currently locked
   *   endTime = the monotonic time to wait until
   * Returns: %TRUE on a signal, %FALSE on a timeout
   */
  bool waitUntil(Mutex mutex, long endTime)
  {
    bool _retval;
    _retval = g_cond_wait_until(cast(GCond*)cPtr, mutex ? cast(GMutex*)mutex.cPtr : null, endTime);
    return _retval;
  }
}
