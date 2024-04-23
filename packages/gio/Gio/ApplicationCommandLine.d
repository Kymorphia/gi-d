module Gio.ApplicationCommandLine;

import GLib.Types;
import GLib.Variant;
import GLib.VariantDict;
import GObject.ObjectG;
import GObject.Types;
import Gid.Gid;
import Gio.File;
import Gio.InputStream;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * #GApplicationCommandLine represents a command-line invocation of
 * an application.  It is created by #GApplication and emitted
 * in the #GApplication::command-line signal and virtual function.
 *
 * The class contains the list of arguments that the program was invoked
 * with.  It is also possible to query if the commandline invocation was
 * local (ie: the current process is running in direct response to the
 * invocation) or remote (ie: some other process forwarded the
 * commandline to this process).
 *
 * The GApplicationCommandLine object can provide the @argc and @argv
 * parameters for use with the #GOptionContext command-line parsing API,
 * with the g_application_command_line_get_arguments() function. See
 * [gapplication-example-cmdline3.c][gapplication-example-cmdline3]
 * for an example.
 *
 * The exit status of the originally-invoked process may be set and
 * messages can be printed to stdout or stderr of that process.  The
 * lifecycle of the originally-invoked process is tied to the lifecycle
 * of this object (ie: the process exits when the last reference is
 * dropped).
 *
 * The main use for #GApplicationCommandLine (and the
 * #GApplication::command-line signal) is 'Emacs server' like use cases:
 * You can set the `EDITOR` environment variable to have e.g. git use
 * your favourite editor to edit commit messages, and if you already
 * have an instance of the editor running, the editing will happen
 * in the running instance, instead of opening a new one. An important
 * aspect of this use case is that the process that gets started by git
 * does not return until the editing is done.
 *
 * Normally, the commandline is completely handled in the
 * #GApplication::command-line handler. The launching instance exits
 * once the signal handler in the primary instance has returned, and
 * the return value of the signal handler becomes the exit status
 * of the launching instance.
 * |[<!-- language="C" -->
 * static int
 * command_line (GApplication            *application,
 * GApplicationCommandLine *cmdline)
 * {
 * gchar **argv;
 * gint argc;
 * gint i;
 *
 * argv = g_application_command_line_get_arguments (cmdline, &argc);
 *
 * g_application_command_line_print (cmdline,
 * "This text is written back\n"
 * "to stdout of the caller\n");
 *
 * for (i = 0; i < argc; i++)
 * g_print ("argument %d: %s\n", i, argv[i]);
 *
 * g_strfreev (argv);
 *
 * return 0;
 * }
 * ]|
 * The complete example can be found here:
 * [gapplication-example-cmdline.c](https://gitlab.gnome.org/GNOME/glib/-/blob/HEAD/gio/tests/gapplication-example-cmdline.c)
 *
 * In more complicated cases, the handling of the commandline can be
 * split between the launcher and the primary instance.
 * |[<!-- language="C" -->
 * static gboolean
 * test_local_cmdline (GApplication   *application,
 * gchar        ***arguments,
 * gint           *exit_status)
 * {
 * gint i, j;
 * gchar **argv;
 *
 * argv = *arguments;
 *
 * if (argv[0] == NULL)
 * {
 * *exit_status = 0;
 * return FALSE;
 * }
 *
 * i = 1;
 * while (argv[i])
 * {
 * if (g_str_has_prefix (argv[i], "--local-"))
 * {
 * g_print ("handling argument %s locally\n", argv[i]);
 * g_free (argv[i]);
 * for (j = i; argv[j]; j++)
 * argv[j] = argv[j + 1];
 * }
 * else
 * {
 * g_print ("not handling argument %s locally\n", argv[i]);
 * i++;
 * }
 * }
 *
 * *exit_status = 0;
 *
 * return FALSE;
 * }
 *
 * static void
 * test_application_class_init (TestApplicationClass *class)
 * {
 * G_APPLICATION_CLASS (class)->local_command_line = test_local_cmdline;
 *
 * ...
 * }
 * ]|
 * In this example of split commandline handling, options that start
 * with `--local-` are handled locally, all other options are passed
 * to the #GApplication::command-line handler which runs in the primary
 * instance.
 *
 * The complete example can be found here:
 * [gapplication-example-cmdline2.c](https://gitlab.gnome.org/GNOME/glib/-/blob/HEAD/gio/tests/gapplication-example-cmdline2.c)
 *
 * If handling the commandline requires a lot of work, it may
 * be better to defer it.
 * |[<!-- language="C" -->
 * static gboolean
 * my_cmdline_handler (gpointer data)
 * {
 * GApplicationCommandLine *cmdline = data;
 *
 * // do the heavy lifting in an idle
 *
 * g_application_command_line_set_exit_status (cmdline, 0);
 * g_object_unref (cmdline); // this releases the application
 *
 * return G_SOURCE_REMOVE;
 * }
 *
 * static int
 * command_line (GApplication            *application,
 * GApplicationCommandLine *cmdline)
 * {
 * // keep the application running until we are done with this commandline
 * g_application_hold (application);
 *
 * g_object_set_data_full (G_OBJECT (cmdline),
 * "application", application,
 * (GDestroyNotify)g_application_release);
 *
 * g_object_ref (cmdline);
 * g_idle_add (my_cmdline_handler, cmdline);
 *
 * return 0;
 * }
 * ]|
 * In this example the commandline is not completely handled before
 * the #GApplication::command-line handler returns. Instead, we keep
 * a reference to the #GApplicationCommandLine object and handle it
 * later (in this example, in an idle). Note that it is necessary to
 * hold the application until you are done with the commandline.
 *
 * The complete example can be found here:
 * [gapplication-example-cmdline3.c](https://gitlab.gnome.org/GNOME/glib/-/blob/HEAD/gio/tests/gapplication-example-cmdline3.c)
 */
class ApplicationCommandLine : ObjectG
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_application_command_line_get_type();
  }

  /**
   * a new #GFile
   */
  File createFileForArg(string arg)
  {
    GFile* _cretval;
    const(char)* _arg = arg.toCString(false);
    _cretval = g_application_command_line_create_file_for_arg(cPtr!GApplicationCommandLine, _arg);
    File _retval = ObjectG.getDObject!File(cast(GFile*)_cretval, true);
    return _retval;
  }

  /**
   * the string array containing the arguments (the argv)
   */
  string[] getArguments()
  {
    char** _cretval;
    int _cretlength;
    _cretval = g_application_command_line_get_arguments(cPtr!GApplicationCommandLine, &_cretlength);
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
   * the current directory, or %NULL
   */
  string getCwd()
  {
    const(char)* _cretval;
    _cretval = g_application_command_line_get_cwd(cPtr!GApplicationCommandLine);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * the environment strings, or %NULL if they were not sent
   */
  string[] getEnviron()
  {
    const(char*)* _cretval;
    _cretval = g_application_command_line_get_environ(cPtr!GApplicationCommandLine);
    string[] _retval;

    if (_cretval)
    {
      uint _cretlength;
      for (; _cretval[_cretlength] != null; _cretlength++)
        break;
      _retval = new string[_cretlength];
      foreach (i; 0 .. _cretlength)
        _retval[i] = _cretval[i].fromCString(false);
    }
    return _retval;
  }

  /**
   * the exit status
   */
  int getExitStatus()
  {
    int _retval;
    _retval = g_application_command_line_get_exit_status(cPtr!GApplicationCommandLine);
    return _retval;
  }

  /**
   * %TRUE if the invocation was remote
   */
  bool getIsRemote()
  {
    bool _retval;
    _retval = g_application_command_line_get_is_remote(cPtr!GApplicationCommandLine);
    return _retval;
  }

  /**
   * a #GVariantDict with the options
   */
  VariantDict getOptionsDict()
  {
    GVariantDict* _cretval;
    _cretval = g_application_command_line_get_options_dict(cPtr!GApplicationCommandLine);
    VariantDict _retval = new VariantDict(cast(GVariantDict*)_cretval, false);
    return _retval;
  }

  /**
   * the platform data, or %NULL
   */
  Variant getPlatformData()
  {
    GVariant* _cretval;
    _cretval = g_application_command_line_get_platform_data(cPtr!GApplicationCommandLine);
    Variant _retval = new Variant(cast(GVariant*)_cretval, true);
    return _retval;
  }

  /**
   * a #GInputStream for stdin
   */
  InputStream getStdin()
  {
    GInputStream* _cretval;
    _cretval = g_application_command_line_get_stdin(cPtr!GApplicationCommandLine);
    InputStream _retval = ObjectG.getDObject!InputStream(cast(GInputStream*)_cretval, true);
    return _retval;
  }

  /**
   * the value of the variable, or %NULL if unset or unsent
   */
  string getenv(string name)
  {
    const(char)* _cretval;
    const(char)* _name = name.toCString(false);
    _cretval = g_application_command_line_getenv(cPtr!GApplicationCommandLine, _name);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Sets the exit status that will be used when the invoking process
   * exits.
   *
   * The return value of the #GApplication::command-line signal is
   * passed to this function when the handler returns.  This is the usual
   * way of setting the exit status.
   *
   * In the event that you want the remote invocation to continue running
   * and want to decide on the exit status in the future, you can use this
   * call.  For the case of a remote invocation, the remote process will
   * typically exit when the last reference is dropped on @cmdline.  The
   * exit status of the remote process will be equal to the last value
   * that was set with this function.
   *
   * In the case that the commandline invocation is local, the situation
   * is slightly more complicated.  If the commandline invocation results
   * in the mainloop running (ie: because the use-count of the application
   * increased to a non-zero value) then the application is considered to
   * have been 'successful' in a certain sense, and the exit status is
   * always zero.  If the application use count is zero, though, the exit
   * status of the local #GApplicationCommandLine is used.
   */
  void setExitStatus(int exitStatus)
  {
    g_application_command_line_set_exit_status(cPtr!GApplicationCommandLine, exitStatus);
  }
}
