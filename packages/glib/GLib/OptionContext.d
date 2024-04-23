module GLib.OptionContext;

import GLib.OptionEntry;
import GLib.OptionGroup;
import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.Gid;

/**
 * The GOption commandline parser is intended to be a simpler replacement
 * for the popt library. It supports short and long commandline options,
 * as shown in the following example:
 *
 * `testtreemodel -r 1 --max-size 20 --rand --display=:1.0 -vb -- file1 file2`
 *
 * The example demonstrates a number of features of the GOption
 * commandline parser:
 *
 * - Options can be single letters, prefixed by a single dash.
 *
 * - Multiple short options can be grouped behind a single dash.
 *
 * - Long options are prefixed by two consecutive dashes.
 *
 * - Options can have an extra argument, which can be a number, a string or
 * a filename. For long options, the extra argument can be appended with
 * an equals sign after the option name, which is useful if the extra
 * argument starts with a dash, which would otherwise cause it to be
 * interpreted as another option.
 *
 * - Non-option arguments are returned to the application as rest arguments.
 *
 * - An argument consisting solely of two dashes turns off further parsing,
 * any remaining arguments (even those starting with a dash) are returned
 * to the application as rest arguments.
 *
 * Another important feature of GOption is that it can automatically
 * generate nicely formatted help output. Unless it is explicitly turned
 * off with g_option_context_set_help_enabled(), GOption will recognize
 * the `--help`, `-?`, `--help-all` and `--help-groupname` options
 * (where `groupname` is the name of a #GOptionGroup) and write a text
 * similar to the one shown in the following example to stdout.
 *
 * |[
 * Usage:
 * testtreemodel [OPTION...] - test tree model performance
 *
 * Help Options:
 * -h, --help               Show help options
 * --help-all               Show all help options
 * --help-gtk               Show GTK Options
 *
 * Application Options:
 * -r, --repeats=N          Average over N repetitions
 * -m, --max-size=M         Test up to 2^M items
 * --display=DISPLAY        X display to use
 * -v, --verbose            Be verbose
 * -b, --beep               Beep when done
 * --rand                   Randomize the data
 * ]|
 *
 * GOption groups options in #GOptionGroups, which makes it easy to
 * incorporate options from multiple sources. The intended use for this is
 * to let applications collect option groups from the libraries it uses,
 * add them to their #GOptionContext, and parse all options by a single call
 * to g_option_context_parse(). See gtk_get_option_group() for an example.
 *
 * If an option is declared to be of type string or filename, GOption takes
 * care of converting it to the right encoding; strings are returned in
 * UTF-8, filenames are returned in the GLib filename encoding. Note that
 * this only works if setlocale() has been called before
 * g_option_context_parse().
 *
 * Here is a complete example of setting up GOption to parse the example
 * commandline above and produce the example help output.
 * |[<!-- language="C" -->
 * static gint repeats = 2;
 * static gint max_size = 8;
 * static gboolean verbose = FALSE;
 * static gboolean beep = FALSE;
 * static gboolean randomize = FALSE;
 *
 * static GOptionEntry entries[] =
 * {
 * { "repeats", 'r', 0, G_OPTION_ARG_INT, &repeats, "Average over N repetitions", "N" },
 * { "max-size", 'm', 0, G_OPTION_ARG_INT, &max_size, "Test up to 2^M items", "M" },
 * { "verbose", 'v', 0, G_OPTION_ARG_NONE, &verbose, "Be verbose", NULL },
 * { "beep", 'b', 0, G_OPTION_ARG_NONE, &beep, "Beep when done", NULL },
 * { "rand", 0, 0, G_OPTION_ARG_NONE, &randomize, "Randomize the data", NULL },
 * G_OPTION_ENTRY_NULL
 * };
 *
 * int
 * main (int argc, char *argv[])
 * {
 * GError *error = NULL;
 * GOptionContext *context;
 *
 * context = g_option_context_new ("- test tree model performance");
 * g_option_context_add_main_entries (context, entries, GETTEXT_PACKAGE);
 * g_option_context_add_group (context, gtk_get_option_group (TRUE));
 * if (!g_option_context_parse (context, &argc, &argv, &error))
 * {
 * g_print ("option parsing failed: %s\n", error->message);
 * exit (1);
 * }
 *
 * ...
 *
 * }
 * ]|
 *
 * On UNIX systems, the argv that is passed to main() has no particular
 * encoding, even to the extent that different parts of it may have
 * different encodings.  In general, normal arguments and flags will be
 * in the current locale and filenames should be considered to be opaque
 * byte strings.  Proper use of %G_OPTION_ARG_FILENAME vs
 * %G_OPTION_ARG_STRING is therefore important.
 *
 * Note that on Windows, filenames do have an encoding, but using
 * #GOptionContext with the argv as passed to main() will result in a
 * program that can only accept commandline arguments with characters
 * from the system codepage.  This can cause problems when attempting to
 * deal with filenames containing Unicode characters that fall outside
 * of the codepage.
 *
 * A solution to this is to use g_win32_get_command_line() and
 * g_option_context_parse_strv() which will properly handle full Unicode
 * filenames.  If you are using #GApplication, this is done
 * automatically for you.
 *
 * The following example shows how you can use #GOptionContext directly
 * in order to correctly deal with Unicode filenames on Windows:
 *
 * |[<!-- language="C" -->
 * int
 * main (int argc, char **argv)
 * {
 * GError *error = NULL;
 * GOptionContext *context;
 * gchar **args;
 *
 * #ifdef G_OS_WIN32
 * args = g_win32_get_command_line ();
 * #else
 * args = g_strdupv (argv);
 * #endif
 *
 * // set up context
 *
 * if (!g_option_context_parse_strv (context, &args, &error))
 * {
 * // error happened
 * }
 *
 * ...
 *
 * g_strfreev (args);
 *
 * ...
 * }
 * ]|
 */
class OptionContext
{
  GOptionContext* cInstancePtr;
  bool owned;

  this(void* ptr, bool owned = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for GLib.OptionContext");

    cInstancePtr = cast(GOptionContext*)ptr;

    this.owned = owned;
  }

  ~this()
  {
    if (owned)
      g_option_context_free(cInstancePtr);
  }

  T* cPtr(T)()
  if (is(T == GOptionContext))
  {
    return cast(T*)cInstancePtr;
  }

  /**
   * Adds a #GOptionGroup to the @context, so that parsing with @context
   * will recognize the options in the group. Note that this will take
   * ownership of the @group and thus the @group should not be freed.
   */
  void addGroup(OptionGroup group)
  {
    g_option_context_add_group(cPtr!GOptionContext, group ? group.cPtr!GOptionGroup : null);
  }

  /**
   * A convenience function which creates a main group if it doesn't
   * exist, adds the @entries to it and sets the translation domain.
   */
  void addMainEntries(OptionEntry[] entries, string translationDomain)
  {
    GOptionEntry[] _tmpentries;
    foreach (obj; entries)
      _tmpentries ~= obj.cInstance;
    _tmpentries ~= GOptionEntry();
    const(GOptionEntry)* _entries = _tmpentries.ptr;

    const(char)* _translationDomain = translationDomain.toCString(false);
    g_option_context_add_main_entries(cPtr!GOptionContext, _entries, _translationDomain);
  }

  /**
   * the description
   */
  string getDescription()
  {
    const(char)* _cretval;
    _cretval = g_option_context_get_description(cPtr!GOptionContext);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * A newly allocated string containing the help text
   */
  string getHelp(bool mainHelp, OptionGroup group)
  {
    char* _cretval;
    _cretval = g_option_context_get_help(cPtr!GOptionContext, mainHelp, group ? group.cPtr!GOptionGroup : null);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * %TRUE if automatic help generation is turned on.
   */
  bool getHelpEnabled()
  {
    bool _retval;
    _retval = g_option_context_get_help_enabled(cPtr!GOptionContext);
    return _retval;
  }

  /**
   * %TRUE if unknown options are ignored.
   */
  bool getIgnoreUnknownOptions()
  {
    bool _retval;
    _retval = g_option_context_get_ignore_unknown_options(cPtr!GOptionContext);
    return _retval;
  }

  /**
   * the main group of @context, or %NULL if
   * @context doesn't have a main group. Note that group belongs to
   * @context and should not be modified or freed.
   */
  OptionGroup getMainGroup()
  {
    GOptionGroup* _cretval;
    _cretval = g_option_context_get_main_group(cPtr!GOptionContext);
    OptionGroup _retval = new OptionGroup(cast(GOptionGroup*)_cretval, false);
    return _retval;
  }

  /**
   * %TRUE if strict POSIX is enabled, %FALSE otherwise.
   */
  bool getStrictPosix()
  {
    bool _retval;
    _retval = g_option_context_get_strict_posix(cPtr!GOptionContext);
    return _retval;
  }

  /**
   * the summary
   */
  string getSummary()
  {
    const(char)* _cretval;
    _cretval = g_option_context_get_summary(cPtr!GOptionContext);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Adds a string to be displayed in `--help` output after the list
   * of options. This text often includes a bug reporting address.
   *
   * Note that the summary is translated (see
   * g_option_context_set_translate_func()).
   */
  void setDescription(string description)
  {
    const(char)* _description = description.toCString(false);
    g_option_context_set_description(cPtr!GOptionContext, _description);
  }

  /**
   * Enables or disables automatic generation of `--help` output.
   * By default, g_option_context_parse() recognizes `--help`, `-h`,
   * `-?`, `--help-all` and `--help-groupname` and creates suitable
   * output to stdout.
   */
  void setHelpEnabled(bool helpEnabled)
  {
    g_option_context_set_help_enabled(cPtr!GOptionContext, helpEnabled);
  }

  /**
   * Sets whether to ignore unknown options or not. If an argument is
   * ignored, it is left in the @argv array after parsing. By default,
   * g_option_context_parse() treats unknown options as error.
   *
   * This setting does not affect non-option arguments (i.e. arguments
   * which don't start with a dash). But note that GOption cannot reliably
   * determine whether a non-option belongs to a preceding unknown option.
   */
  void setIgnoreUnknownOptions(bool ignoreUnknown)
  {
    g_option_context_set_ignore_unknown_options(cPtr!GOptionContext, ignoreUnknown);
  }

  /**
   * Sets a #GOptionGroup as main group of the @context.
   * This has the same effect as calling g_option_context_add_group(),
   * the only difference is that the options in the main group are
   * treated differently when generating `--help` output.
   */
  void setMainGroup(OptionGroup group)
  {
    g_option_context_set_main_group(cPtr!GOptionContext, group ? group.cPtr!GOptionGroup : null);
  }

  /**
   * Sets strict POSIX mode.
   *
   * By default, this mode is disabled.
   *
   * In strict POSIX mode, the first non-argument parameter encountered
   * (eg: filename) terminates argument processing.  Remaining arguments
   * are treated as non-options and are not attempted to be parsed.
   *
   * If strict POSIX mode is disabled then parsing is done in the GNU way
   * where option arguments can be freely mixed with non-options.
   *
   * As an example, consider "ls foo -l".  With GNU style parsing, this
   * will list "foo" in long mode.  In strict POSIX style, this will list
   * the files named "foo" and "-l".
   *
   * It may be useful to force strict POSIX mode when creating "verb
   * style" command line tools.  For example, the "gsettings" command line
   * tool supports the global option "--schemadir" as well as many
   * subcommands ("get", "set", etc.) which each have their own set of
   * arguments.  Using strict POSIX mode will allow parsing the global
   * options up to the verb name while leaving the remaining options to be
   * parsed by the relevant subcommand (which can be determined by
   * examining the verb name, which should be present in argv[1] after
   * parsing).
   */
  void setStrictPosix(bool strictPosix)
  {
    g_option_context_set_strict_posix(cPtr!GOptionContext, strictPosix);
  }

  /**
   * Adds a string to be displayed in `--help` output before the list
   * of options. This is typically a summary of the program functionality.
   *
   * Note that the summary is translated (see
   * g_option_context_set_translate_func() and
   * g_option_context_set_translation_domain()).
   */
  void setSummary(string summary)
  {
    const(char)* _summary = summary.toCString(false);
    g_option_context_set_summary(cPtr!GOptionContext, _summary);
  }

  /**
   * Sets the function which is used to translate the contexts
   * user-visible strings, for `--help` output. If @func is %NULL,
   * strings are not translated.
   *
   * Note that option groups have their own translation functions,
   * this function only affects the @parameter_string (see g_option_context_new()),
   * the summary (see g_option_context_set_summary()) and the description
   * (see g_option_context_set_description()).
   *
   * If you are using gettext(), you only need to set the translation
   * domain, see g_option_context_set_translation_domain().
   */
  void setTranslateFunc(TranslateFunc func)
  {
    extern(C) const(char)* _funcCallback(const(char)* str, void* data)
    {
      string _dretval;
      string _str = str.fromCString(false);

      _dretval = (*(cast(TranslateFunc*)data))(_str);
      const(char)* _retval = _dretval.toCString(false);

      return _retval;
    }

    ptrFreezeGC(cast(void*)&func);
    g_option_context_set_translate_func(cPtr!GOptionContext, &_funcCallback, cast(void*)&func, &ptrThawDestroyNotify);
  }

  /**
   * A convenience function to use gettext() for translating
   * user-visible strings.
   */
  void setTranslationDomain(string domain)
  {
    const(char)* _domain = domain.toCString(false);
    g_option_context_set_translation_domain(cPtr!GOptionContext, _domain);
  }
}
