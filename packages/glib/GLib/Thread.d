module GLib.Thread;

import GLib.Boxed;
import GLib.ErrorG;
import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.Gid;

/**
 * The #GThread struct represents a running thread. This struct
 * is returned by g_thread_new() or g_thread_try_new(). You can
 * obtain the #GThread struct representing the current thread by
 * calling g_thread_self().
 *
 * GThread is refcounted, see g_thread_ref() and g_thread_unref().
 * The thread represented by it holds a reference while it is running,
 * and g_thread_join() consumes the reference that it is given, so
 * it is normally not necessary to manage GThread references
 * explicitly.
 *
 * The structure is opaque -- none of its fields may be directly
 * accessed.
 */
class Thread : Boxed
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  T* cPtr(T)(bool makeCopy = false)
  if (is(T == GThread))
  {
    return makeCopy ? copy_!T : cast(T*)cInstancePtr;
  }

  static GType getType()
  {
    return g_thread_get_type();
  }

  /**
   * the new #GThread
   */
  this(string name, ThreadFunc func)
  {
    extern(C) void* _funcCallback(void* data)
    {
      ptrThawGC(data);

      void* _retval = (*(cast(ThreadFunc*)data))();
      return _retval;
    }

    GThread* _cretval;
    const(char)* _name = name.toCString(false);
    ptrFreezeGC(cast(void*)&func);
    _cretval = g_thread_new(_name, &_funcCallback, cast(void*)&func);
    this(_cretval, true);
  }

  /**
   * the new #GThread, or %NULL if an error occurred
   */
  static Thread tryNew(string name, ThreadFunc func)
  {
    extern(C) void* _funcCallback(void* data)
    {
      ptrThawGC(data);

      void* _retval = (*(cast(ThreadFunc*)data))();
      return _retval;
    }

    GThread* _cretval;
    const(char)* _name = name.toCString(false);
    ptrFreezeGC(cast(void*)&func);
    GError *_err;
    _cretval = g_thread_try_new(_name, &_funcCallback, cast(void*)&func, &_err);
    if (_err)
      throw new ThreadException(_err);
    Thread _retval = new Thread(cast(GThread*)_cretval, true);
    return _retval;
  }

  /**
   * the return value of the thread
   */
  void* join()
  {
    void* _retval;
    _retval = g_thread_join(cPtr!GThread);
    return _retval;
  }

  static Quark errorQuark()
  {
    Quark _retval;
    _retval = g_thread_error_quark();
    return _retval;
  }

  /**
   * Terminates the current thread.
   *
   * If another thread is waiting for us using g_thread_join() then the
   * waiting thread will be woken up and get @retval as the return value
   * of g_thread_join().
   *
   * Calling g_thread_exit() with a parameter @retval is equivalent to
   * returning @retval from the function @func, as given to g_thread_new().
   *
   * You must only call g_thread_exit() from a thread that you created
   * yourself with g_thread_new() or related APIs. You must not call
   * this function from a thread created with another threading library
   * or or from within a #GThreadPool.
   */
  static void exit(void* retval)
  {
    g_thread_exit(retval);
  }

  /**
   * the #GThread representing the current thread
   */
  static Thread self()
  {
    GThread* _cretval;
    _cretval = g_thread_self();
    Thread _retval = new Thread(cast(GThread*)_cretval, false);
    return _retval;
  }

  /**
   * Causes the calling thread to voluntarily relinquish the CPU, so
   * that other threads can run.
   *
   * This function is often used as a method to make busy wait less evil.
   */
  static void yield()
  {
    g_thread_yield();
  }
}

class ThreadException : ErrorG
{
  this(GError* err)
  {
    super(err);
  }

  this(Code code, string msg)
  {
    super(Thread.errorQuark, cast(int)code, msg);
  }

  alias Code = GThreadError;
}
