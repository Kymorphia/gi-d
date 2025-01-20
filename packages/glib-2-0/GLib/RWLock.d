module GLib.RWLock;

import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.gid;

/**
 * The GRWLock struct is an opaque data structure to represent a
 * reader-writer lock. It is similar to a #GMutex in that it allows
 * multiple threads to coordinate access to a shared resource.
 * The difference to a mutex is that a reader-writer lock discriminates
 * between read-only $(LPAREN)'reader'$(RPAREN) and full $(LPAREN)'writer'$(RPAREN) access. While only
 * one thread at a time is allowed write access $(LPAREN)by holding the 'writer'
 * lock via [GLib.RWLock.writerLock]$(RPAREN), multiple threads can gain
 * simultaneous read-only access $(LPAREN)by holding the 'reader' lock via
 * [GLib.RWLock.readerLock]$(RPAREN).
 * It is unspecified whether readers or writers have priority in acquiring the
 * lock when a reader already holds the lock and a writer is queued to acquire
 * it.
 * Here is an example for an array with access functions:
 * |[<!-- language\="C" -->
 * GRWLock lock;
 * GPtrArray *array;
 * gpointer
 * my_array_get $(LPAREN)guint index$(RPAREN)
 * {
 * gpointer retval \= NULL;
 * if $(LPAREN)!array$(RPAREN)
 * return NULL;
 * g_rw_lock_reader_lock $(LPAREN)&lock$(RPAREN);
 * if $(LPAREN)index < array->len$(RPAREN)
 * retval \= g_ptr_array_index $(LPAREN)array, index$(RPAREN);
 * g_rw_lock_reader_unlock $(LPAREN)&lock$(RPAREN);
 * return retval;
 * }
 * void
 * my_array_set $(LPAREN)guint index, gpointer data$(RPAREN)
 * {
 * g_rw_lock_writer_lock $(LPAREN)&lock$(RPAREN);
 * if $(LPAREN)!array$(RPAREN)
 * array \= g_ptr_array_new $(LPAREN)$(RPAREN);
 * if $(LPAREN)index >\= array->len$(RPAREN)
 * g_ptr_array_set_size $(LPAREN)array, index+1$(RPAREN);
 * g_ptr_array_index $(LPAREN)array, index$(RPAREN) \= data;
 * g_rw_lock_writer_unlock $(LPAREN)&lock$(RPAREN);
 * }
 * ]|
 * This example shows an array which can be accessed by many readers
 * $(LPAREN)the my_array_get$(LPAREN)$(RPAREN) function$(RPAREN) simultaneously, whereas the writers
 * $(LPAREN)the my_array_set$(LPAREN)$(RPAREN) function$(RPAREN) will only be allowed one at a time
 * and only if no readers currently access the array. This is because
 * of the potentially dangerous resizing of the array. Using these
 * functions is fully multi-thread safe now.
 * If a #GRWLock is allocated in static storage then it can be used
 * without initialisation.  Otherwise, you should call
 * [GLib.RWLock.init_] on it and [GLib.RWLock.clear] when done.
 * A GRWLock should only be accessed with the g_rw_lock_ functions.
 */
class RWLock
{
  GRWLock cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for GLib.RWLock");

    cInstance = *cast(GRWLock*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  /**
   * Frees the resources allocated to a lock with [GLib.RWLock.init_].
   * This function should not be used with a #GRWLock that has been
   * statically allocated.
   * Calling [GLib.RWLock.clear] when any thread holds the lock
   * leads to undefined behaviour.
   */
  void clear()
  {
    g_rw_lock_clear(cast(GRWLock*)cPtr);
  }

  /**
   * Initializes a #GRWLock so that it can be used.
   * This function is useful to initialize a lock that has been
   * allocated on the stack, or as part of a larger structure.  It is not
   * necessary to initialise a reader-writer lock that has been statically
   * allocated.
   * |[<!-- language\="C" -->
   * typedef struct {
   * GRWLock l;
   * ...
   * } Blob;
   * Blob *b;
   * b \= g_new $(LPAREN)Blob, 1$(RPAREN);
   * g_rw_lock_init $(LPAREN)&b->l$(RPAREN);
   * ]|
   * To undo the effect of [GLib.RWLock.init_] when a lock is no longer
   * needed, use [GLib.RWLock.clear].
   * Calling [GLib.RWLock.init_] on an already initialized #GRWLock leads
   * to undefined behaviour.
   */
  void init_()
  {
    g_rw_lock_init(cast(GRWLock*)cPtr);
  }

  /**
   * Obtain a read lock on rw_lock. If another thread currently holds
   * the write lock on rw_lock, the current thread will block until the
   * write lock was $(LPAREN)held and$(RPAREN) released. If another thread does not hold
   * the write lock, but is waiting for it, it is implementation defined
   * whether the reader or writer will block. Read locks can be taken
   * recursively.
   * Calling [GLib.RWLock.readerLock] while the current thread already
   * owns a write lock leads to undefined behaviour. Read locks however
   * can be taken recursively, in which case you need to make sure to
   * call [GLib.RWLock.readerUnlock] the same amount of times.
   * It is implementation-defined how many read locks are allowed to be
   * held on the same lock simultaneously. If the limit is hit,
   * or if a deadlock is detected, a critical warning will be emitted.
   */
  void readerLock()
  {
    g_rw_lock_reader_lock(cast(GRWLock*)cPtr);
  }

  /**
   * Tries to obtain a read lock on rw_lock and returns %TRUE if
   * the read lock was successfully obtained. Otherwise it
   * returns %FALSE.
   * Returns: %TRUE if rw_lock could be locked
   */
  bool readerTrylock()
  {
    bool _retval;
    _retval = g_rw_lock_reader_trylock(cast(GRWLock*)cPtr);
    return _retval;
  }

  /**
   * Release a read lock on rw_lock.
   * Calling [GLib.RWLock.readerUnlock] on a lock that is not held
   * by the current thread leads to undefined behaviour.
   */
  void readerUnlock()
  {
    g_rw_lock_reader_unlock(cast(GRWLock*)cPtr);
  }

  /**
   * Obtain a write lock on rw_lock. If another thread currently holds
   * a read or write lock on rw_lock, the current thread will block
   * until all other threads have dropped their locks on rw_lock.
   * Calling [GLib.RWLock.writerLock] while the current thread already
   * owns a read or write lock on rw_lock leads to undefined behaviour.
   */
  void writerLock()
  {
    g_rw_lock_writer_lock(cast(GRWLock*)cPtr);
  }

  /**
   * Tries to obtain a write lock on rw_lock. If another thread
   * currently holds a read or write lock on rw_lock, it immediately
   * returns %FALSE.
   * Otherwise it locks rw_lock and returns %TRUE.
   * Returns: %TRUE if rw_lock could be locked
   */
  bool writerTrylock()
  {
    bool _retval;
    _retval = g_rw_lock_writer_trylock(cast(GRWLock*)cPtr);
    return _retval;
  }

  /**
   * Release a write lock on rw_lock.
   * Calling [GLib.RWLock.writerUnlock] on a lock that is not held
   * by the current thread leads to undefined behaviour.
   */
  void writerUnlock()
  {
    g_rw_lock_writer_unlock(cast(GRWLock*)cPtr);
  }
}
