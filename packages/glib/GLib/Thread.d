module GLib.Thread;

import GLib.Boxed;
import GLib.ErrorG;
import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.gid;

/**
 * The #GThread struct represents a running thread. This struct
 * is returned by [GLib.Thread.new_] or [GLib.Thread.tryNew]. You can
 * obtain the #GThread struct representing the current thread by
 * calling [GLib.Thread.self].
 * GThread is refcounted, see [GLib.Thread.ref_] and [GLib.Thread.unref].
 * The thread represented by it holds a reference while it is running,
 * and [GLib.Thread.join] consumes the reference that it is given, so
 * it is normally not necessary to manage GThread references
 * explicitly.
 * The structure is opaque -- none of its fields may be directly
 * accessed.
 */
class Thread : Boxed
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  void* cPtr(bool makeCopy = false)
  {
    return makeCopy ? copy_ : cInstancePtr;
  }

  static GType getType()
  {
    return g_thread_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * This function creates a new thread. The new thread starts by invoking
   * func with the argument data. The thread will run until func returns
   * or until [GLib.Thread.exit] is called from the new thread. The return value
   * of func becomes the return value of the thread, which can be obtained
   * with [GLib.Thread.join].
   * The name can be useful for discriminating threads in a debugger.
   * It is not used for other purposes and does not have to be unique.
   * Some systems restrict the length of name to 16 bytes.
   * If the thread can not be created the program aborts. See
   * [GLib.Thread.tryNew] if you want to attempt to deal with failures.
   * If you are using threads to offload $(LPAREN)potentially many$(RPAREN) short-lived tasks,
   * #GThreadPool may be more appropriate than manually spawning and tracking
   * multiple #GThreads.
   * To free the struct returned by this function, use [GLib.Thread.unref].
   * Note that [GLib.Thread.join] implicitly unrefs the #GThread as well.
   * New threads by default inherit their scheduler policy $(LPAREN)POSIX$(RPAREN) or thread
   * priority $(LPAREN)Windows$(RPAREN) of the thread creating the new thread.
   * This behaviour changed in GLib 2.64: before threads on Windows were not
   * inheriting the thread priority but were spawned with the default priority.
   * Starting with GLib 2.64 the behaviour is now consistent between Windows and
   * POSIX and all threads inherit their parent thread's priority.
   * Params:
   *   name = an $(LPAREN)optional$(RPAREN) name for the new thread
   *   func = a function to execute in the new thread
   * Returns: the new #GThread
   */
  this(string name, ThreadFunc func)
  {
    extern(C) void* _funcCallback(void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(ThreadFunc*)data;

      void* _retval = (*_dlg)();
      return _retval;
    }

    GThread* _cretval;
    const(char)* _name = name.toCString(false);
    auto _func = freezeDelegate(cast(void*)&func);
    _cretval = g_thread_new(_name, &_funcCallback, _func);
    this(_cretval, true);
  }

  /**
   * This function is the same as [GLib.Thread.new_] except that
   * it allows for the possibility of failure.
   * If a thread can not be created $(LPAREN)due to resource limits$(RPAREN),
   * error is set and %NULL is returned.
   * Params:
   *   name = an $(LPAREN)optional$(RPAREN) name for the new thread
   *   func = a function to execute in the new thread
   * Returns: the new #GThread, or %NULL if an error occurred
   */
  static Thread tryNew(string name, ThreadFunc func)
  {
    extern(C) void* _funcCallback(void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(ThreadFunc*)data;

      void* _retval = (*_dlg)();
      return _retval;
    }

    GThread* _cretval;
    const(char)* _name = name.toCString(false);
    auto _func = freezeDelegate(cast(void*)&func);
    GError *_err;
    _cretval = g_thread_try_new(_name, &_funcCallback, _func, &_err);
    if (_err)
      throw new ThreadException(_err);
    auto _retval = _cretval ? new Thread(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Waits until thread finishes, i.e. the function func, as
   * given to [GLib.Thread.new_], returns or [GLib.Thread.exit] is called.
   * If thread has already terminated, then [GLib.Thread.join]
   * returns immediately.
   * Any thread can wait for any other thread by calling [GLib.Thread.join],
   * not just its 'creator'. Calling [GLib.Thread.join] from multiple threads
   * for the same thread leads to undefined behaviour.
   * The value returned by func or given to [GLib.Thread.exit] is
   * returned by this function.
   * [GLib.Thread.join] consumes the reference to the passed-in thread.
   * This will usually cause the #GThread struct and associated resources
   * to be freed. Use [GLib.Thread.ref_] to obtain an extra reference if you
   * want to keep the GThread alive beyond the [GLib.Thread.join] call.
   * Returns: the return value of the thread
   */
  void* join()
  {
    void* _retval;
    _retval = g_thread_join(cast(GThread*)cPtr);
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
   * If another thread is waiting for us using [GLib.Thread.join] then the
   * waiting thread will be woken up and get retval as the return value
   * of [GLib.Thread.join].
   * Calling [GLib.Thread.exit] with a parameter retval is equivalent to
   * returning retval from the function func, as given to [GLib.Thread.new_].
   * You must only call [GLib.Thread.exit] from a thread that you created
   * yourself with [GLib.Thread.new_] or related APIs. You must not call
   * this function from a thread created with another threading library
   * or or from within a #GThreadPool.
   * Params:
   *   retval = the return value of this thread
   */
  static void exit(void* retval)
  {
    g_thread_exit(retval);
  }

  /**
   * This function returns the #GThread corresponding to the
   * current thread. Note that this function does not increase
   * the reference count of the returned struct.
   * This function will return a #GThread even for threads that
   * were not created by GLib $(LPAREN)i.e. those created by other threading
   * APIs$(RPAREN). This may be useful for thread identification purposes
   * $(LPAREN)i.e. comparisons$(RPAREN) but you must not use GLib functions $(LPAREN)such
   * as [GLib.Thread.join]$(RPAREN) on these threads.
   * Returns: the #GThread representing the current thread
   */
  static Thread self()
  {
    GThread* _cretval;
    _cretval = g_thread_self();
    auto _retval = _cretval ? new Thread(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Causes the calling thread to voluntarily relinquish the CPU, so
   * that other threads can run.
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
