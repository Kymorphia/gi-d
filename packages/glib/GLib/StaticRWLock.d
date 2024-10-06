module GLib.StaticRWLock;

import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.gid;

/**
 * The #GStaticRWLock struct represents a read-write lock. A read-write
 * lock can be used for protecting data that some portions of code only
 * read from, while others also write. In such situations it is
 * desirable that several readers can read at once, whereas of course
 * only one writer may write at a time.
 * Take a look at the following example:
 * |[
 * GStaticRWLock rwlock \= G_STATIC_RW_LOCK_INIT;
 * GPtrArray *array;
 * gpointer
 * my_array_get $(LPAREN)guint index$(RPAREN)
 * {
 * gpointer retval \= NULL;
 * if $(LPAREN)!array$(RPAREN)
 * return NULL;
 * g_static_rw_lock_reader_lock $(LPAREN)&rwlock$(RPAREN);
 * if $(LPAREN)index < array->len$(RPAREN)
 * retval \= g_ptr_array_index $(LPAREN)array, index$(RPAREN);
 * g_static_rw_lock_reader_unlock $(LPAREN)&rwlock$(RPAREN);
 * return retval;
 * }
 * void
 * my_array_set $(LPAREN)guint index, gpointer data$(RPAREN)
 * {
 * g_static_rw_lock_writer_lock $(LPAREN)&rwlock$(RPAREN);
 * if $(LPAREN)!array$(RPAREN)
 * array \= g_ptr_array_new $(LPAREN)$(RPAREN);
 * if $(LPAREN)index >\= array->len$(RPAREN)
 * g_ptr_array_set_size $(LPAREN)array, index + 1$(RPAREN);
 * g_ptr_array_index $(LPAREN)array, index$(RPAREN) \= data;
 * g_static_rw_lock_writer_unlock $(LPAREN)&rwlock$(RPAREN);
 * }
 * ]|
 * This example shows an array which can be accessed by many readers
 * $(LPAREN)the my_array_get$(LPAREN)$(RPAREN) function$(RPAREN) simultaneously, whereas the writers
 * $(LPAREN)the my_array_set$(LPAREN)$(RPAREN) function$(RPAREN) will only be allowed once at a time
 * and only if no readers currently access the array. This is because
 * of the potentially dangerous resizing of the array. Using these
 * functions is fully multi-thread safe now.
 * Most of the time, writers should have precedence over readers. That
 * means, for this implementation, that as soon as a writer wants to
 * lock the data, no other reader is allowed to lock the data, whereas,
 * of course, the readers that already have locked the data are allowed
 * to finish their operation. As soon as the last reader unlocks the
 * data, the writer will lock it.
 * Even though #GStaticRWLock is not opaque, it should only be used
 * with the following functions.
 * All of the g_static_rw_lock_* functions can be used even if
 * [GLib.Thread.init_] has not been called. Then they do nothing, apart
 * from g_static_rw_lock_*_trylock, which does nothing but returning %TRUE.
 * A read-write lock has a higher overhead than a mutex. For example, both
 * [GLib.StaticRWLock.readerLock] and [GLib.StaticRWLock.readerUnlock] have
 * to lock and unlock a #GStaticMutex, so it takes at least twice the time
 * to lock and unlock a #GStaticRWLock that it does to lock and unlock a
 * #GStaticMutex. So only data structures that are accessed by multiple
 * readers, and which keep the lock for a considerable time justify a
 * #GStaticRWLock. The above example most probably would fare better with a
 * #GStaticMutex.

 * Deprecated: Use a #GRWLock instead
 */
class StaticRWLock
{
  GStaticRWLock cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for GLib.StaticRWLock");

    cInstance = *cast(GStaticRWLock*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }
}
