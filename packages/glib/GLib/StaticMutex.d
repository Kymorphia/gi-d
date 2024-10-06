module GLib.StaticMutex;

import GLib.Mutex;
import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.gid;

/**
 * A #GStaticMutex works like a #GMutex.
 * Prior to GLib 2.32, GStaticMutex had the significant advantage
 * that it doesn't need to be created at run-time, but can be defined
 * at compile-time. Since 2.32, #GMutex can be statically allocated
 * as well, and GStaticMutex has been deprecated.
 * Here is a version of our give_me_next_number$(LPAREN)$(RPAREN) example using
 * a GStaticMutex:
 * |[
 * int
 * give_me_next_number $(LPAREN)void$(RPAREN)
 * {
 * static int current_number \= 0;
 * int ret_val;
 * static GStaticMutex mutex \= G_STATIC_MUTEX_INIT;
 * g_static_mutex_lock $(LPAREN)&mutex$(RPAREN);
 * ret_val \= current_number \= calc_next_number $(LPAREN)current_number$(RPAREN);
 * g_static_mutex_unlock $(LPAREN)&mutex$(RPAREN);
 * return ret_val;
 * }
 * ]|
 * Sometimes you would like to dynamically create a mutex. If you don't
 * want to require prior calling to [GLib.Thread.init_], because your code
 * should also be usable in non-threaded programs, you are not able to
 * use [GLib.Mutex.new_] and thus #GMutex, as that requires a prior call to
 * [GLib.Thread.init_]. In these cases you can also use a #GStaticMutex.
 * It must be initialized with [GLib.StaticMutex.init_] before using it
 * and freed with with [GLib.StaticMutex.free] when not needed anymore to
 * free up any allocated resources.
 * Even though #GStaticMutex is not opaque, it should only be used with
 * the following functions, as it is defined differently on different
 * platforms.
 * All of the g_static_mutex_* functions apart from
 * g_static_mutex_get_mutex$(LPAREN)$(RPAREN) can also be used even if [GLib.Thread.init_]
 * has not yet been called. Then they do nothing, apart from
 * g_static_mutex_trylock$(LPAREN)$(RPAREN) which does nothing but returning %TRUE.
 * All of the g_static_mutex_* functions are actually macros. Apart from
 * taking their addresses, you can however use them as if they were
 * functions.
 */
class StaticMutex
{
  GStaticMutex cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for GLib.StaticMutex");

    cInstance = *cast(GStaticMutex*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property Mutex mutex()
  {
    return new Mutex(cast(GMutex*)(cast(GStaticMutex*)cPtr).mutex);
  }

  Mutex getMutexImpl()
  {
    GMutex* _cretval;
    _cretval = g_static_mutex_get_mutex_impl(cast(GStaticMutex*)cPtr);
    auto _retval = _cretval ? new Mutex(cast(GMutex*)_cretval) : null;
    return _retval;
  }
}
