module Gio.SubprocessLauncher;

import GLib.ErrorG;
import GObject.ObjectG;
import Gid.gid;
import Gio.Subprocess;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * This class contains a set of options for launching child processes,
 * such as where its standard input and output will be directed, the
 * argument list, the environment, and more.
 * While the [Gio.Subprocess] class has high level functions covering
 * popular cases, use of this class allows access to more advanced
 * options.  It can also be used to launch multiple subprocesses with
 * a similar configuration.
 */
class SubprocessLauncher : ObjectG
{

  this()
  {
  }

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_subprocess_launcher_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new #GSubprocessLauncher.
   * The launcher is created with the default options.  A copy of the
   * environment of the calling process is made at the time of this call
   * and will be used as the environment that the process is launched in.
   * Params:
   *   flags = #GSubprocessFlags
   * Returns:
   */
  this(SubprocessFlags flags)
  {
    GSubprocessLauncher* _cretval;
    _cretval = g_subprocess_launcher_new(flags);
    this(_cretval, true);
  }

  /**
   * Closes all the file descriptors previously passed to the object with
   * [Gio.SubprocessLauncher.takeFd], [Gio.SubprocessLauncher.takeStderrFd], etc.
   * After calling this method, any subsequent calls to [Gio.SubprocessLauncher.spawn] or [Gio.SubprocessLauncher.spawnv] will
   * return %G_IO_ERROR_CLOSED. This method is idempotent if
   * called more than once.
   * This function is called automatically when the #GSubprocessLauncher
   * is disposed, but is provided separately so that garbage collected
   * language bindings can call it earlier to guarantee when FDs are closed.
   */
  void close()
  {
    g_subprocess_launcher_close(cast(GSubprocessLauncher*)cPtr);
  }

  /**
   * Returns the value of the environment variable variable in the
   * environment of processes launched from this launcher.
   * On UNIX, the returned string can be an arbitrary byte string.
   * On Windows, it will be UTF-8.
   * Params:
   *   variable = the environment variable to get
   * Returns: the value of the environment variable,
   *   %NULL if unset
   */
  string getenv(string variable)
  {
    const(char)* _cretval;
    const(char)* _variable = variable.toCString(false);
    _cretval = g_subprocess_launcher_getenv(cast(GSubprocessLauncher*)cPtr, _variable);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Sets the current working directory that processes will be launched
   * with.
   * By default processes are launched with the current working directory
   * of the launching process at the time of launch.
   * Params:
   *   cwd = the cwd for launched processes
   */
  void setCwd(string cwd)
  {
    const(char)* _cwd = cwd.toCString(false);
    g_subprocess_launcher_set_cwd(cast(GSubprocessLauncher*)cPtr, _cwd);
  }

  /**
   * Replace the entire environment of processes launched from this
   * launcher with the given 'environ' variable.
   * Typically you will build this variable by using [GLib.Global.listenv] to copy
   * the process 'environ' and using the functions [GLib.Global.environSetenv],
   * [GLib.Global.environUnsetenv], etc.
   * As an alternative, you can use [Gio.SubprocessLauncher.setenv],
   * [Gio.SubprocessLauncher.unsetenv], etc.
   * Pass an empty array to set an empty environment. Pass %NULL to inherit the
   * parent process’ environment. As of GLib 2.54, the parent process’ environment
   * will be copied when [Gio.SubprocessLauncher.setEnviron] is called.
   * Previously, it was copied when the subprocess was executed. This means the
   * copied environment may now be modified $(LPAREN)using [Gio.SubprocessLauncher.setenv],
   * etc.$(RPAREN) before launching the subprocess.
   * On UNIX, all strings in this array can be arbitrary byte strings.
   * On Windows, they should be in UTF-8.
   * Params:
   *   env = the replacement environment
   */
  void setEnviron(string[] env)
  {
    char*[] _tmpenv;
    foreach (s; env)
      _tmpenv ~= s.toCString(false);
    _tmpenv ~= null;
    char** _env = _tmpenv.ptr;
    g_subprocess_launcher_set_environ(cast(GSubprocessLauncher*)cPtr, _env);
  }

  /**
   * Sets the flags on the launcher.
   * The default flags are %G_SUBPROCESS_FLAGS_NONE.
   * You may not set flags that specify conflicting options for how to
   * handle a particular stdio stream $(LPAREN)eg: specifying both
   * %G_SUBPROCESS_FLAGS_STDIN_PIPE and
   * %G_SUBPROCESS_FLAGS_STDIN_INHERIT$(RPAREN).
   * You may also not set a flag that conflicts with a previous call to a
   * function like [Gio.SubprocessLauncher.setStdinFilePath] or
   * [Gio.SubprocessLauncher.takeStdoutFd].
   * Params:
   *   flags = #GSubprocessFlags
   */
  void setFlags(SubprocessFlags flags)
  {
    g_subprocess_launcher_set_flags(cast(GSubprocessLauncher*)cPtr, flags);
  }

  /**
   * Sets the file path to use as the stderr for spawned processes.
   * If path is %NULL then any previously given path is unset.
   * The file will be created or truncated when the process is spawned, as
   * would be the case if using '2>' at the shell.
   * If you want to send both stdout and stderr to the same file then use
   * %G_SUBPROCESS_FLAGS_STDERR_MERGE.
   * You may not set a stderr file path if a stderr fd is already set or
   * if the launcher flags contain any flags directing stderr elsewhere.
   * This feature is only available on UNIX.
   * Params:
   *   path = a filename or %NULL
   */
  void setStderrFilePath(string path)
  {
    const(char)* _path = path.toCString(false);
    g_subprocess_launcher_set_stderr_file_path(cast(GSubprocessLauncher*)cPtr, _path);
  }

  /**
   * Sets the file path to use as the stdin for spawned processes.
   * If path is %NULL then any previously given path is unset.
   * The file must exist or spawning the process will fail.
   * You may not set a stdin file path if a stdin fd is already set or if
   * the launcher flags contain any flags directing stdin elsewhere.
   * This feature is only available on UNIX.
   * Params:
   *   path = a filename or %NULL
   */
  void setStdinFilePath(string path)
  {
    const(char)* _path = path.toCString(false);
    g_subprocess_launcher_set_stdin_file_path(cast(GSubprocessLauncher*)cPtr, _path);
  }

  /**
   * Sets the file path to use as the stdout for spawned processes.
   * If path is %NULL then any previously given path is unset.
   * The file will be created or truncated when the process is spawned, as
   * would be the case if using '>' at the shell.
   * You may not set a stdout file path if a stdout fd is already set or
   * if the launcher flags contain any flags directing stdout elsewhere.
   * This feature is only available on UNIX.
   * Params:
   *   path = a filename or %NULL
   */
  void setStdoutFilePath(string path)
  {
    const(char)* _path = path.toCString(false);
    g_subprocess_launcher_set_stdout_file_path(cast(GSubprocessLauncher*)cPtr, _path);
  }

  /**
   * Sets the environment variable variable in the environment of
   * processes launched from this launcher.
   * On UNIX, both the variable's name and value can be arbitrary byte
   * strings, except that the variable's name cannot contain '\='.
   * On Windows, they should be in UTF-8.
   * Params:
   *   variable = the environment variable to set,
   *     must not contain '\='
   *   value = the new value for the variable
   *   overwrite = whether to change the variable if it already exists
   */
  void setenv(string variable, string value, bool overwrite)
  {
    const(char)* _variable = variable.toCString(false);
    const(char)* _value = value.toCString(false);
    g_subprocess_launcher_setenv(cast(GSubprocessLauncher*)cPtr, _variable, _value, overwrite);
  }

  /**
   * Creates a #GSubprocess given a provided array of arguments.
   * Params:
   *   argv = Command line arguments
   * Returns: A new #GSubprocess, or %NULL on error $(LPAREN)and error will be set$(RPAREN)
   */
  Subprocess spawnv(string[] argv)
  {
    GSubprocess* _cretval;
    const(char)*[] _tmpargv;
    foreach (s; argv)
      _tmpargv ~= s.toCString(false);
    _tmpargv ~= null;
    const(char*)* _argv = _tmpargv.ptr;

    GError *_err;
    _cretval = g_subprocess_launcher_spawnv(cast(GSubprocessLauncher*)cPtr, _argv, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = _cretval ? ObjectG.getDObject!Subprocess(cast(GSubprocess*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Transfer an arbitrary file descriptor from parent process to the
   * child.  This function takes ownership of the source_fd; it will be closed
   * in the parent when self is freed.
   * By default, all file descriptors from the parent will be closed.
   * This function allows you to create $(LPAREN)for example$(RPAREN) a custom `pipe$(LPAREN)$(RPAREN)` or
   * `socketpair$(LPAREN)$(RPAREN)` before launching the process, and choose the target
   * descriptor in the child.
   * An example use case is GNUPG, which has a command line argument
   * `--passphrase-fd` providing a file descriptor number where it expects
   * the passphrase to be written.
   * Params:
   *   sourceFd = File descriptor in parent process
   *   targetFd = Target descriptor for child process
   */
  void takeFd(int sourceFd, int targetFd)
  {
    g_subprocess_launcher_take_fd(cast(GSubprocessLauncher*)cPtr, sourceFd, targetFd);
  }

  /**
   * Sets the file descriptor to use as the stderr for spawned processes.
   * If fd is -1 then any previously given fd is unset.
   * Note that the default behaviour is to pass stderr through to the
   * stderr of the parent process.
   * The passed fd belongs to the #GSubprocessLauncher.  It will be
   * automatically closed when the launcher is finalized.  The file
   * descriptor will also be closed on the child side when executing the
   * spawned process.
   * You may not set a stderr fd if a stderr file path is already set or
   * if the launcher flags contain any flags directing stderr elsewhere.
   * This feature is only available on UNIX.
   * Params:
   *   fd = a file descriptor, or -1
   */
  void takeStderrFd(int fd)
  {
    g_subprocess_launcher_take_stderr_fd(cast(GSubprocessLauncher*)cPtr, fd);
  }

  /**
   * Sets the file descriptor to use as the stdin for spawned processes.
   * If fd is -1 then any previously given fd is unset.
   * Note that if your intention is to have the stdin of the calling
   * process inherited by the child then %G_SUBPROCESS_FLAGS_STDIN_INHERIT
   * is a better way to go about doing that.
   * The passed fd is noted but will not be touched in the current
   * process.  It is therefore necessary that it be kept open by the
   * caller until the subprocess is spawned.  The file descriptor will
   * also not be explicitly closed on the child side, so it must be marked
   * O_CLOEXEC if that's what you want.
   * You may not set a stdin fd if a stdin file path is already set or if
   * the launcher flags contain any flags directing stdin elsewhere.
   * This feature is only available on UNIX.
   * Params:
   *   fd = a file descriptor, or -1
   */
  void takeStdinFd(int fd)
  {
    g_subprocess_launcher_take_stdin_fd(cast(GSubprocessLauncher*)cPtr, fd);
  }

  /**
   * Sets the file descriptor to use as the stdout for spawned processes.
   * If fd is -1 then any previously given fd is unset.
   * Note that the default behaviour is to pass stdout through to the
   * stdout of the parent process.
   * The passed fd is noted but will not be touched in the current
   * process.  It is therefore necessary that it be kept open by the
   * caller until the subprocess is spawned.  The file descriptor will
   * also not be explicitly closed on the child side, so it must be marked
   * O_CLOEXEC if that's what you want.
   * You may not set a stdout fd if a stdout file path is already set or
   * if the launcher flags contain any flags directing stdout elsewhere.
   * This feature is only available on UNIX.
   * Params:
   *   fd = a file descriptor, or -1
   */
  void takeStdoutFd(int fd)
  {
    g_subprocess_launcher_take_stdout_fd(cast(GSubprocessLauncher*)cPtr, fd);
  }

  /**
   * Removes the environment variable variable from the environment of
   * processes launched from this launcher.
   * On UNIX, the variable's name can be an arbitrary byte string not
   * containing '\='. On Windows, it should be in UTF-8.
   * Params:
   *   variable = the environment variable to unset,
   *     must not contain '\='
   */
  void unsetenv(string variable)
  {
    const(char)* _variable = variable.toCString(false);
    g_subprocess_launcher_unsetenv(cast(GSubprocessLauncher*)cPtr, _variable);
  }
}
