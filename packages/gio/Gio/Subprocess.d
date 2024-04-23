module Gio.Subprocess;

import GLib.Bytes;
import GLib.ErrorG;
import GLib.Types;
import GObject.ObjectG;
import GObject.Types;
import Gid.Gid;
import Gio.AsyncResult;
import Gio.Cancellable;
import Gio.Initable;
import Gio.InitableT;
import Gio.InputStream;
import Gio.OutputStream;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * #GSubprocess allows the creation of and interaction with child
 * processes.
 *
 * Processes can be communicated with using standard GIO-style APIs (ie:
 * #GInputStream, #GOutputStream).  There are GIO-style APIs to wait for
 * process termination (ie: cancellable and with an asynchronous
 * variant).
 *
 * There is an API to force a process to terminate, as well as a
 * race-free API for sending UNIX signals to a subprocess.
 *
 * One major advantage that GIO brings over the core GLib library is
 * comprehensive API for asynchronous I/O, such
 * g_output_stream_splice_async().  This makes GSubprocess
 * significantly more powerful and flexible than equivalent APIs in
 * some other languages such as the `subprocess.py`
 * included with Python.  For example, using #GSubprocess one could
 * create two child processes, reading standard output from the first,
 * processing it, and writing to the input stream of the second, all
 * without blocking the main loop.
 *
 * A powerful g_subprocess_communicate() API is provided similar to the
 * `communicate()` method of `subprocess.py`. This enables very easy
 * interaction with a subprocess that has been opened with pipes.
 *
 * #GSubprocess defaults to tight control over the file descriptors open
 * in the child process, avoiding dangling-fd issues that are caused by
 * a simple fork()/exec().  The only open file descriptors in the
 * spawned process are ones that were explicitly specified by the
 * #GSubprocess API (unless %G_SUBPROCESS_FLAGS_INHERIT_FDS was
 * specified).
 *
 * #GSubprocess will quickly reap all child processes as they exit,
 * avoiding "zombie processes" remaining around for long periods of
 * time.  g_subprocess_wait() can be used to wait for this to happen,
 * but it will happen even without the call being explicitly made.
 *
 * As a matter of principle, #GSubprocess has no API that accepts
 * shell-style space-separated strings.  It will, however, match the
 * typical shell behaviour of searching the PATH for executables that do
 * not contain a directory separator in their name. By default, the `PATH`
 * of the current process is used.  You can specify
 * %G_SUBPROCESS_FLAGS_SEARCH_PATH_FROM_ENVP to use the `PATH` of the
 * launcher environment instead.
 *
 * #GSubprocess attempts to have a very simple API for most uses (ie:
 * spawning a subprocess with arguments and support for most typical
 * kinds of input and output redirection).  See g_subprocess_new(). The
 * #GSubprocessLauncher API is provided for more complicated cases
 * (advanced types of redirection, environment variable manipulation,
 * change of working directory, child setup functions, etc).
 *
 * A typical use of #GSubprocess will involve calling
 * g_subprocess_new(), followed by g_subprocess_wait_async() or
 * g_subprocess_wait().  After the process exits, the status can be
 * checked using functions such as g_subprocess_get_if_exited() (which
 * are similar to the familiar WIFEXITED-style POSIX macros).
 */
class Subprocess : ObjectG, Initable
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_subprocess_get_type();
  }

  mixin InitableT!GSubprocess;

  /**
   * A newly created #GSubprocess, or %NULL on error (and @error
   * will be set)
   */
  static Subprocess new_(string[] argv, SubprocessFlags flags)
  {
    GSubprocess* _cretval;
    char*[] _tmpargv;
    foreach (s; argv)
      _tmpargv ~= s.toCString(false);
    _tmpargv ~= null;
    const(char*)* _argv = _tmpargv.ptr;

    GError *_err;
    _cretval = g_subprocess_newv(_argv, flags, &_err);
    if (_err)
      throw new ErrorG(_err);
    Subprocess _retval = ObjectG.getDObject!Subprocess(cast(GSubprocess*)_cretval, true);
    return _retval;
  }

  /**
   * %TRUE if successful
   */
  bool communicate(Bytes stdinBuf, Cancellable cancellable, out Bytes stdoutBuf, out Bytes stderrBuf)
  {
    bool _retval;
    GBytes* _stdoutBuf;
    GBytes* _stderrBuf;
    GError *_err;
    _retval = g_subprocess_communicate(cPtr!GSubprocess, stdinBuf ? stdinBuf.cPtr!GBytes : null, cancellable ? cancellable.cPtr!GCancellable : null, &_stdoutBuf, &_stderrBuf, &_err);
    if (_err)
      throw new ErrorG(_err);
    stdoutBuf = new Bytes(cast(void*)_stdoutBuf, true);
    stderrBuf = new Bytes(cast(void*)_stderrBuf, true);
    return _retval;
  }

  /**
   * Asynchronous version of g_subprocess_communicate().  Complete
   * invocation with g_subprocess_communicate_finish().
   */
  void communicateAsync(Bytes stdinBuf, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    ptrFreezeGC(cast(void*)&callback);
    g_subprocess_communicate_async(cPtr!GSubprocess, stdinBuf ? stdinBuf.cPtr!GBytes : null, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * Complete an invocation of g_subprocess_communicate_async().
   */
  bool communicateFinish(AsyncResult result, out Bytes stdoutBuf, out Bytes stderrBuf)
  {
    bool _retval;
    GBytes* _stdoutBuf;
    GBytes* _stderrBuf;
    GError *_err;
    _retval = g_subprocess_communicate_finish(cPtr!GSubprocess, result ? (cast(ObjectG)result).cPtr!GAsyncResult : null, &_stdoutBuf, &_stderrBuf, &_err);
    if (_err)
      throw new ErrorG(_err);
    stdoutBuf = new Bytes(cast(void*)_stdoutBuf, true);
    stderrBuf = new Bytes(cast(void*)_stderrBuf, true);
    return _retval;
  }

  /**
   * Like g_subprocess_communicate(), but validates the output of the
   * process as UTF-8, and returns it as a regular NUL terminated string.
   *
   * On error, @stdout_buf and @stderr_buf will be set to undefined values and
   * should not be used.
   */
  bool communicateUtf8(string stdinBuf, Cancellable cancellable, out string stdoutBuf, out string stderrBuf)
  {
    bool _retval;
    const(char)* _stdinBuf = stdinBuf.toCString(false);
    char* _stdoutBuf;
    char* _stderrBuf;
    GError *_err;
    _retval = g_subprocess_communicate_utf8(cPtr!GSubprocess, _stdinBuf, cancellable ? cancellable.cPtr!GCancellable : null, &_stdoutBuf, &_stderrBuf, &_err);
    if (_err)
      throw new ErrorG(_err);
    stdoutBuf = _stdoutBuf.fromCString(true);
    stderrBuf = _stderrBuf.fromCString(true);
    return _retval;
  }

  /**
   * Asynchronous version of g_subprocess_communicate_utf8().  Complete
   * invocation with g_subprocess_communicate_utf8_finish().
   */
  void communicateUtf8Async(string stdinBuf, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    const(char)* _stdinBuf = stdinBuf.toCString(false);
    ptrFreezeGC(cast(void*)&callback);
    g_subprocess_communicate_utf8_async(cPtr!GSubprocess, _stdinBuf, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * Complete an invocation of g_subprocess_communicate_utf8_async().
   */
  bool communicateUtf8Finish(AsyncResult result, out string stdoutBuf, out string stderrBuf)
  {
    bool _retval;
    char* _stdoutBuf;
    char* _stderrBuf;
    GError *_err;
    _retval = g_subprocess_communicate_utf8_finish(cPtr!GSubprocess, result ? (cast(ObjectG)result).cPtr!GAsyncResult : null, &_stdoutBuf, &_stderrBuf, &_err);
    if (_err)
      throw new ErrorG(_err);
    stdoutBuf = _stdoutBuf.fromCString(true);
    stderrBuf = _stderrBuf.fromCString(true);
    return _retval;
  }

  /**
   * Use an operating-system specific method to attempt an immediate,
   * forceful termination of the process.  There is no mechanism to
   * determine whether or not the request itself was successful;
   * however, you can use g_subprocess_wait() to monitor the status of
   * the process after calling this function.
   *
   * On Unix, this function sends %SIGKILL.
   */
  void forceExit()
  {
    g_subprocess_force_exit(cPtr!GSubprocess);
  }

  /**
   * the exit status
   */
  int getExitStatus()
  {
    int _retval;
    _retval = g_subprocess_get_exit_status(cPtr!GSubprocess);
    return _retval;
  }

  /**
   * the subprocess identifier, or %NULL if the subprocess
   * has terminated
   */
  string getIdentifier()
  {
    const(char)* _cretval;
    _cretval = g_subprocess_get_identifier(cPtr!GSubprocess);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * %TRUE if the case of a normal exit
   */
  bool getIfExited()
  {
    bool _retval;
    _retval = g_subprocess_get_if_exited(cPtr!GSubprocess);
    return _retval;
  }

  /**
   * %TRUE if the case of termination due to a signal
   */
  bool getIfSignaled()
  {
    bool _retval;
    _retval = g_subprocess_get_if_signaled(cPtr!GSubprocess);
    return _retval;
  }

  /**
   * the (meaningless) waitpid() exit status from the kernel
   */
  int getStatus()
  {
    int _retval;
    _retval = g_subprocess_get_status(cPtr!GSubprocess);
    return _retval;
  }

  /**
   * the stderr pipe
   */
  InputStream getStderrPipe()
  {
    GInputStream* _cretval;
    _cretval = g_subprocess_get_stderr_pipe(cPtr!GSubprocess);
    InputStream _retval = ObjectG.getDObject!InputStream(cast(GInputStream*)_cretval, false);
    return _retval;
  }

  /**
   * the stdout pipe
   */
  OutputStream getStdinPipe()
  {
    GOutputStream* _cretval;
    _cretval = g_subprocess_get_stdin_pipe(cPtr!GSubprocess);
    OutputStream _retval = ObjectG.getDObject!OutputStream(cast(GOutputStream*)_cretval, false);
    return _retval;
  }

  /**
   * the stdout pipe
   */
  InputStream getStdoutPipe()
  {
    GInputStream* _cretval;
    _cretval = g_subprocess_get_stdout_pipe(cPtr!GSubprocess);
    InputStream _retval = ObjectG.getDObject!InputStream(cast(GInputStream*)_cretval, false);
    return _retval;
  }

  /**
   * %TRUE if the process exited cleanly with a exit status of 0
   */
  bool getSuccessful()
  {
    bool _retval;
    _retval = g_subprocess_get_successful(cPtr!GSubprocess);
    return _retval;
  }

  /**
   * the signal causing termination
   */
  int getTermSig()
  {
    int _retval;
    _retval = g_subprocess_get_term_sig(cPtr!GSubprocess);
    return _retval;
  }

  /**
   * Sends the UNIX signal @signal_num to the subprocess, if it is still
   * running.
   *
   * This API is race-free.  If the subprocess has terminated, it will not
   * be signalled.
   *
   * This API is not available on Windows.
   */
  void sendSignal(int signalNum)
  {
    g_subprocess_send_signal(cPtr!GSubprocess, signalNum);
  }

  /**
   * %TRUE on success, %FALSE if @cancellable was cancelled
   */
  bool wait(Cancellable cancellable)
  {
    bool _retval;
    GError *_err;
    _retval = g_subprocess_wait(cPtr!GSubprocess, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Wait for the subprocess to terminate.
   *
   * This is the asynchronous version of g_subprocess_wait().
   */
  void waitAsync(Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    ptrFreezeGC(cast(void*)&callback);
    g_subprocess_wait_async(cPtr!GSubprocess, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * %TRUE on success, %FALSE if process exited abnormally, or
   * @cancellable was cancelled
   */
  bool waitCheck(Cancellable cancellable)
  {
    bool _retval;
    GError *_err;
    _retval = g_subprocess_wait_check(cPtr!GSubprocess, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Combines g_subprocess_wait_async() with g_spawn_check_wait_status().
   *
   * This is the asynchronous version of g_subprocess_wait_check().
   */
  void waitCheckAsync(Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    ptrFreezeGC(cast(void*)&callback);
    g_subprocess_wait_check_async(cPtr!GSubprocess, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * %TRUE if successful, or %FALSE with @error set
   */
  bool waitCheckFinish(AsyncResult result)
  {
    bool _retval;
    GError *_err;
    _retval = g_subprocess_wait_check_finish(cPtr!GSubprocess, result ? (cast(ObjectG)result).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * %TRUE if successful, or %FALSE with @error set
   */
  bool waitFinish(AsyncResult result)
  {
    bool _retval;
    GError *_err;
    _retval = g_subprocess_wait_finish(cPtr!GSubprocess, result ? (cast(ObjectG)result).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }
}
