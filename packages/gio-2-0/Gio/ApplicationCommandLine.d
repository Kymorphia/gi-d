module Gio.ApplicationCommandLine;

import GLib.VariantDict;
import GLib.VariantG;
import GObject.ObjectG;
import Gid.gid;
import Gio.File;
import Gio.FileT;
import Gio.InputStream;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * `GApplicationCommandLine` represents a command-line invocation of
 * an application.
 * It is created by [Gio.Application] and emitted
 * in the signal@Gio.Application::command-line signal and virtual function.
 * The class contains the list of arguments that the program was invoked
 * with. It is also possible to query if the commandline invocation was
 * local $(LPAREN)ie: the current process is running in direct response to the
 * invocation$(RPAREN) or remote $(LPAREN)ie: some other process forwarded the
 * commandline to this process$(RPAREN).
 * The `GApplicationCommandLine` object can provide the @argc and @argv
 * parameters for use with the [GLib.OptionContext] command-line parsing API,
 * with the [Gio.ApplicationCommandLine.getArguments] function. See
 * [gapplication-example-cmdline3.c][gapplication-example-cmdline3]
 * for an example.
 * The exit status of the originally-invoked process may be set and
 * messages can be printed to stdout or stderr of that process.
 * For remote invocation, the originally-invoked process exits when
 * [Gio.ApplicationCommandLine.done] method is called. This method is
 * also automatically called when the object is disposed.
 * The main use for `GApplicationCommandLine` $(LPAREN)and the
 * signal@Gio.Application::command-line signal$(RPAREN) is 'Emacs server' like use cases:
 * You can set the `EDITOR` environment variable to have e.g. git use
 * your favourite editor to edit commit messages, and if you already
 * have an instance of the editor running, the editing will happen
 * in the running instance, instead of opening a new one. An important
 * aspect of this use case is that the process that gets started by git
 * does not return until the editing is done.
 * Normally, the commandline is completely handled in the
 * signal@Gio.Application::command-line handler. The launching instance exits
 * once the signal handler in the primary instance has returned, and
 * the return value of the signal handler becomes the exit status
 * of the launching instance.
 * ```c
 * static int
 * command_line $(LPAREN)GApplication            *application,
 * GApplicationCommandLine *cmdline$(RPAREN)
 * {
 * gchar **argv;
 * gint argc;
 * gint i;
 * argv \= g_application_command_line_get_arguments $(LPAREN)cmdline, &argc$(RPAREN);
 * g_application_command_line_print $(LPAREN)cmdline,
 * "This text is written back\n"
 * "to stdout of the caller\n"$(RPAREN);
 * for $(LPAREN)i \= 0; i < argc; i++$(RPAREN)
 * g_print $(LPAREN)"argument %d: %s\n", i, argv[i]$(RPAREN);
 * g_strfreev $(LPAREN)argv$(RPAREN);
 * return 0;
 * }
 * ```
 * The complete example can be found here:
 * [gapplication-example-cmdline.c](https://gitlab.gnome.org/GNOME/glib/-/blob/HEAD/gio/tests/gapplication-example-cmdline.c)
 * In more complicated cases, the handling of the commandline can be
 * split between the launcher and the primary instance.
 * ```c
 * static gboolean
 * test_local_cmdline $(LPAREN)GApplication   *application,
 * gchar        ***arguments,
 * gint           *exit_status$(RPAREN)
 * {
 * gint i, j;
 * gchar **argv;
 * argv \= *arguments;
 * if $(LPAREN)argv[0] \=\= NULL$(RPAREN)
 * {
 * *exit_status \= 0;
 * return FALSE;
 * }
 * i \= 1;
 * while $(LPAREN)argv[i]$(RPAREN)
 * {
 * if $(LPAREN)g_str_has_prefix $(LPAREN)argv[i], "--local-"$(RPAREN)$(RPAREN)
 * {
 * g_print $(LPAREN)"handling argument %s locally\n", argv[i]$(RPAREN);
 * g_free $(LPAREN)argv[i]$(RPAREN);
 * for $(LPAREN)j \= i; argv[j]; j++$(RPAREN)
 * argv[j] \= argv[j + 1];
 * }
 * else
 * {
 * g_print $(LPAREN)"not handling argument %s locally\n", argv[i]$(RPAREN);
 * i++;
 * }
 * }
 * *exit_status \= 0;
 * return FALSE;
 * }
 * static void
 * test_application_class_init $(LPAREN)TestApplicationClass *class$(RPAREN)
 * {
 * G_APPLICATION_CLASS $(LPAREN)class$(RPAREN)->local_command_line \= test_local_cmdline;
 * ...
 * }
 * ```
 * In this example of split commandline handling, options that start
 * with `--local-` are handled locally, all other options are passed
 * to the signal@Gio.Application::command-line handler which runs in the primary
 * instance.
 * The complete example can be found here:
 * [gapplication-example-cmdline2.c](https://gitlab.gnome.org/GNOME/glib/-/blob/HEAD/gio/tests/gapplication-example-cmdline2.c)
 * If handling the commandline requires a lot of work, it may be better to defer it.
 * ```c
 * static gboolean
 * my_cmdline_handler $(LPAREN)gpointer data$(RPAREN)
 * {
 * GApplicationCommandLine *cmdline \= data;
 * // do the heavy lifting in an idle
 * g_application_command_line_set_exit_status $(LPAREN)cmdline, 0$(RPAREN);
 * g_object_unref $(LPAREN)cmdline$(RPAREN); // this releases the application
 * return G_SOURCE_REMOVE;
 * }
 * static int
 * command_line $(LPAREN)GApplication            *application,
 * GApplicationCommandLine *cmdline$(RPAREN)
 * {
 * // keep the application running until we are done with this commandline
 * g_application_hold $(LPAREN)application$(RPAREN);
 * g_object_set_data_full $(LPAREN)G_OBJECT $(LPAREN)cmdline$(RPAREN),
 * "application", application,
 * $(LPAREN)GDestroyNotify$(RPAREN)g_application_release$(RPAREN);
 * g_object_ref $(LPAREN)cmdline$(RPAREN);
 * g_idle_add $(LPAREN)my_cmdline_handler, cmdline$(RPAREN);
 * return 0;
 * }
 * ```
 * In this example the commandline is not completely handled before
 * the signal@Gio.Application::command-line handler returns. Instead, we keep
 * a reference to the `GApplicationCommandLine` object and handle it
 * later $(LPAREN)in this example, in an idle$(RPAREN). Note that it is necessary to
 * hold the application until you are done with the commandline.
 * The complete example can be found here:
 * [gapplication-example-cmdline3.c](https://gitlab.gnome.org/GNOME/glib/-/blob/HEAD/gio/tests/gapplication-example-cmdline3.c)
 */
class ApplicationCommandLine : ObjectG
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
    return g_application_command_line_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a #GFile corresponding to a filename that was given as part
   * of the invocation of cmdline.
   * This differs from [Gio.File.newForCommandlineArg] in that it
   * resolves relative pathnames using the current working directory of
   * the invoking process rather than the local process.
   * Params:
   *   arg = an argument from cmdline
   * Returns: a new #GFile
   */
  File createFileForArg(string arg)
  {
    GFile* _cretval;
    const(char)* _arg = arg.toCString(false);
    _cretval = g_application_command_line_create_file_for_arg(cast(GApplicationCommandLine*)cPtr, _arg);
    auto _retval = _cretval ? ObjectG.getDObject!File(cast(GFile*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Signals that command line processing is completed.
   * For remote invocation, it causes the invoking process to terminate.
   * For local invocation, it does nothing.
   * This method should be called in the signalGio.Application::command-line
   * handler, after the exit status is set and all messages are printed.
   * After this call, [Gio.ApplicationCommandLine.setExitStatus] has no effect.
   * Subsequent calls to this method are no-ops.
   * This method is automatically called when the #GApplicationCommandLine
   * object is disposed — so you can omit the call in non-garbage collected
   * languages.
   */
  void done()
  {
    g_application_command_line_done(cast(GApplicationCommandLine*)cPtr);
  }

  /**
   * Gets the list of arguments that was passed on the command line.
   * The strings in the array may contain non-UTF-8 data on UNIX $(LPAREN)such as
   * filenames or arguments given in the system locale$(RPAREN) but are always in
   * UTF-8 on Windows.
   * If you wish to use the return value with #GOptionContext, you must
   * use [GLib.OptionContext.parseStrv].
   * The return value is %NULL-terminated and should be freed using
   * [GLib.Global.strfreev].
   * Returns: the string array containing the arguments $(LPAREN)the argv$(RPAREN)
   */
  string[] getArguments()
  {
    char** _cretval;
    int _cretlength;
    _cretval = g_application_command_line_get_arguments(cast(GApplicationCommandLine*)cPtr, &_cretlength);
    string[] _retval;

    if (_cretval)
    {
      _retval = new string[_cretlength];
      foreach (i; 0 .. _cretlength)
        _retval[i] = _cretval[i].fromCString(true);
    }
    return _retval;
  }

  /**
   * Gets the working directory of the command line invocation.
   * The string may contain non-utf8 data.
   * It is possible that the remote application did not send a working
   * directory, so this may be %NULL.
   * The return value should not be modified or freed and is valid for as
   * long as cmdline exists.
   * Returns: the current directory, or %NULL
   */
  string getCwd()
  {
    const(char)* _cretval;
    _cretval = g_application_command_line_get_cwd(cast(GApplicationCommandLine*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Gets the contents of the 'environ' variable of the command line
   * invocation, as would be returned by [GLib.Global.getEnviron], ie as a
   * %NULL-terminated list of strings in the form 'NAME\=VALUE'.
   * The strings may contain non-utf8 data.
   * The remote application usually does not send an environment.  Use
   * %G_APPLICATION_SEND_ENVIRONMENT to affect that.  Even with this flag
   * set it is possible that the environment is still not available $(LPAREN)due
   * to invocation messages from other applications$(RPAREN).
   * The return value should not be modified or freed and is valid for as
   * long as cmdline exists.
   * See [Gio.ApplicationCommandLine.getenv] if you are only interested
   * in the value of a single environment variable.
   * Returns: the environment strings, or %NULL if they were not sent
   */
  string[] getEnviron()
  {
    const(char*)* _cretval;
    _cretval = g_application_command_line_get_environ(cast(GApplicationCommandLine*)cPtr);
    string[] _retval;

    if (_cretval)
    {
      uint _cretlength;
      for (; _cretval[_cretlength] !is null; _cretlength++)
        break;
      _retval = new string[_cretlength];
      foreach (i; 0 .. _cretlength)
        _retval[i] = _cretval[i].fromCString(false);
    }
    return _retval;
  }

  /**
   * Gets the exit status of cmdline.  See
   * [Gio.ApplicationCommandLine.setExitStatus] for more information.
   * Returns: the exit status
   */
  int getExitStatus()
  {
    int _retval;
    _retval = g_application_command_line_get_exit_status(cast(GApplicationCommandLine*)cPtr);
    return _retval;
  }

  /**
   * Determines if cmdline represents a remote invocation.
   * Returns: %TRUE if the invocation was remote
   */
  bool getIsRemote()
  {
    bool _retval;
    _retval = g_application_command_line_get_is_remote(cast(GApplicationCommandLine*)cPtr);
    return _retval;
  }

  /**
   * Gets the options that were passed to g_application_command_line$(LPAREN)$(RPAREN).
   * If you did not override local_command_line$(LPAREN)$(RPAREN) then these are the same
   * options that were parsed according to the #GOptionEntrys added to the
   * application with [Gio.Application.addMainOptionEntries] and possibly
   * modified from your GApplication::handle-local-options handler.
   * If no options were sent then an empty dictionary is returned so that
   * you don't need to check for %NULL.
   * The data has been passed via an untrusted external process, so the types of
   * all values must be checked before being used.
   * Returns: a #GVariantDict with the options
   */
  VariantDict getOptionsDict()
  {
    GVariantDict* _cretval;
    _cretval = g_application_command_line_get_options_dict(cast(GApplicationCommandLine*)cPtr);
    auto _retval = _cretval ? new VariantDict(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the platform data associated with the invocation of cmdline.
   * This is a #GVariant dictionary containing information about the
   * context in which the invocation occurred.  It typically contains
   * information like the current working directory and the startup
   * notification ID.
   * It comes from an untrusted external process and hence the types of all
   * values must be validated before being used.
   * For local invocation, it will be %NULL.
   * Returns: the platform data, or %NULL
   */
  VariantG getPlatformData()
  {
    VariantC* _cretval;
    _cretval = g_application_command_line_get_platform_data(cast(GApplicationCommandLine*)cPtr);
    auto _retval = _cretval ? new VariantG(cast(VariantC*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Gets the stdin of the invoking process.
   * The #GInputStream can be used to read data passed to the standard
   * input of the invoking process.
   * This doesn't work on all platforms.  Presently, it is only available
   * on UNIX when using a D-Bus daemon capable of passing file descriptors.
   * If stdin is not available then %NULL will be returned.  In the
   * future, support may be expanded to other platforms.
   * You must only call this function once per commandline invocation.
   * Returns: a #GInputStream for stdin
   */
  InputStream getStdin()
  {
    GInputStream* _cretval;
    _cretval = g_application_command_line_get_stdin(cast(GApplicationCommandLine*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!InputStream(cast(GInputStream*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Gets the value of a particular environment variable of the command
   * line invocation, as would be returned by [GLib.Global.getenv].  The strings may
   * contain non-utf8 data.
   * The remote application usually does not send an environment.  Use
   * %G_APPLICATION_SEND_ENVIRONMENT to affect that.  Even with this flag
   * set it is possible that the environment is still not available $(LPAREN)due
   * to invocation messages from other applications$(RPAREN).
   * The return value should not be modified or freed and is valid for as
   * long as cmdline exists.
   * Params:
   *   name = the environment variable to get
   * Returns: the value of the variable, or %NULL if unset or unsent
   */
  string getenv(string name)
  {
    const(char)* _cretval;
    const(char)* _name = name.toCString(false);
    _cretval = g_application_command_line_getenv(cast(GApplicationCommandLine*)cPtr, _name);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Prints a message using the stdout print handler in the invoking process.
   * Unlike [Gio.ApplicationCommandLine.print], message is not a `printf()`-style
   * format string. Use this function if message contains text you don't have
   * control over, that could include `printf$(LPAREN)$(RPAREN)` escape sequences.
   * Params:
   *   message = the message
   */
  void printLiteral(string message)
  {
    const(char)* _message = message.toCString(false);
    g_application_command_line_print_literal(cast(GApplicationCommandLine*)cPtr, _message);
  }

  /**
   * Prints a message using the stderr print handler in the invoking process.
   * Unlike [Gio.ApplicationCommandLine.printerr], message is not
   * a `printf$(LPAREN)$(RPAREN)`-style format string. Use this function if message contains text
   * you don't have control over, that could include `printf$(LPAREN)$(RPAREN)` escape sequences.
   * Params:
   *   message = the message
   */
  void printerrLiteral(string message)
  {
    const(char)* _message = message.toCString(false);
    g_application_command_line_printerr_literal(cast(GApplicationCommandLine*)cPtr, _message);
  }

  /**
   * Sets the exit status that will be used when the invoking process
   * exits.
   * The return value of the #GApplication::command-line signal is
   * passed to this function when the handler returns.  This is the usual
   * way of setting the exit status.
   * In the event that you want the remote invocation to continue running
   * and want to decide on the exit status in the future, you can use this
   * call.  For the case of a remote invocation, the remote process will
   * typically exit when the last reference is dropped on cmdline.  The
   * exit status of the remote process will be equal to the last value
   * that was set with this function.
   * In the case that the commandline invocation is local, the situation
   * is slightly more complicated.  If the commandline invocation results
   * in the mainloop running $(LPAREN)ie: because the use-count of the application
   * increased to a non-zero value$(RPAREN) then the application is considered to
   * have been 'successful' in a certain sense, and the exit status is
   * always zero.  If the application use count is zero, though, the exit
   * status of the local #GApplicationCommandLine is used.
   * This method is a no-op if [Gio.ApplicationCommandLine.done] has
   * been called.
   * Params:
   *   exitStatus = the exit status
   */
  void setExitStatus(int exitStatus)
  {
    g_application_command_line_set_exit_status(cast(GApplicationCommandLine*)cPtr, exitStatus);
  }
}
