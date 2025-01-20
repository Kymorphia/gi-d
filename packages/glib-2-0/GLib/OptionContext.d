module GLib.OptionContext;

import GLib.OptionGroup;
import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.gid;

/**
 * A `GOptionContext` struct defines which options
 * are accepted by the commandline option parser. The struct has only private
 * fields and should not be directly accessed.
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

  void* cPtr()
  {
    return cast(void*)cInstancePtr;
  }

  /**
   * Adds a #GOptionGroup to the context, so that parsing with context
   * will recognize the options in the group. Note that this will take
   * ownership of the group and thus the group should not be freed.
   * Params:
   *   group = the group to add
   */
  void addGroup(OptionGroup group)
  {
    g_option_context_add_group(cast(GOptionContext*)cPtr, group ? cast(GOptionGroup*)group.cPtr(true) : null);
  }

  /**
   * A convenience function which creates a main group if it doesn't
   * exist, adds the entries to it and sets the translation domain.
   * Params:
   *   entries = a %NULL-terminated array of #GOptionEntrys
   *   translationDomain = a translation domain to use for translating
   *     the `--help` output for the options in entries
   *     with gettext$(LPAREN)$(RPAREN), or %NULL
   */
  void addMainEntries(OptionEntry[] entries, string translationDomain)
  {
    auto _entries = cast(const(GOptionEntry)*)(entries ~ GOptionEntry.init).ptr;
    const(char)* _translationDomain = translationDomain.toCString(false);
    g_option_context_add_main_entries(cast(GOptionContext*)cPtr, _entries, _translationDomain);
  }

  /**
   * Returns the description. See [GLib.OptionContext.setDescription].
   * Returns: the description
   */
  string getDescription()
  {
    const(char)* _cretval;
    _cretval = g_option_context_get_description(cast(GOptionContext*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Returns a formatted, translated help text for the given context.
   * To obtain the text produced by `--help`, call
   * `g_option_context_get_help $(LPAREN)context, TRUE, NULL$(RPAREN)`.
   * To obtain the text produced by `--help-all`, call
   * `g_option_context_get_help $(LPAREN)context, FALSE, NULL$(RPAREN)`.
   * To obtain the help text for an option group, call
   * `g_option_context_get_help $(LPAREN)context, FALSE, group$(RPAREN)`.
   * Params:
   *   mainHelp = if %TRUE, only include the main group
   *   group = the #GOptionGroup to create help for, or %NULL
   * Returns: A newly allocated string containing the help text
   */
  string getHelp(bool mainHelp, OptionGroup group)
  {
    char* _cretval;
    _cretval = g_option_context_get_help(cast(GOptionContext*)cPtr, mainHelp, group ? cast(GOptionGroup*)group.cPtr(false) : null);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * Returns whether automatic `--help` generation
   * is turned on for context. See [GLib.OptionContext.setHelpEnabled].
   * Returns: %TRUE if automatic help generation is turned on.
   */
  bool getHelpEnabled()
  {
    bool _retval;
    _retval = g_option_context_get_help_enabled(cast(GOptionContext*)cPtr);
    return _retval;
  }

  /**
   * Returns whether unknown options are ignored or not. See
   * [GLib.OptionContext.setIgnoreUnknownOptions].
   * Returns: %TRUE if unknown options are ignored.
   */
  bool getIgnoreUnknownOptions()
  {
    bool _retval;
    _retval = g_option_context_get_ignore_unknown_options(cast(GOptionContext*)cPtr);
    return _retval;
  }

  /**
   * Returns a pointer to the main group of context.
   * Returns: the main group of context, or %NULL if
   *   context doesn't have a main group. Note that group belongs to
   *   context and should not be modified or freed.
   */
  OptionGroup getMainGroup()
  {
    GOptionGroup* _cretval;
    _cretval = g_option_context_get_main_group(cast(GOptionContext*)cPtr);
    auto _retval = _cretval ? new OptionGroup(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns whether strict POSIX code is enabled.
   * See [GLib.OptionContext.setStrictPosix] for more information.
   * Returns: %TRUE if strict POSIX is enabled, %FALSE otherwise.
   */
  bool getStrictPosix()
  {
    bool _retval;
    _retval = g_option_context_get_strict_posix(cast(GOptionContext*)cPtr);
    return _retval;
  }

  /**
   * Returns the summary. See [GLib.OptionContext.setSummary].
   * Returns: the summary
   */
  string getSummary()
  {
    const(char)* _cretval;
    _cretval = g_option_context_get_summary(cast(GOptionContext*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Adds a string to be displayed in `--help` output after the list
   * of options. This text often includes a bug reporting address.
   * Note that the summary is translated $(LPAREN)see
   * [GLib.OptionContext.setTranslateFunc]$(RPAREN).
   * Params:
   *   description = a string to be shown in `--help` output
   *     after the list of options, or %NULL
   */
  void setDescription(string description)
  {
    const(char)* _description = description.toCString(false);
    g_option_context_set_description(cast(GOptionContext*)cPtr, _description);
  }

  /**
   * Enables or disables automatic generation of `--help` output.
   * By default, [GLib.OptionContext.parse] recognizes `--help`, `-h`,
   * `-?`, `--help-all` and `--help-groupname` and creates suitable
   * output to stdout.
   * Params:
   *   helpEnabled = %TRUE to enable `--help`, %FALSE to disable it
   */
  void setHelpEnabled(bool helpEnabled)
  {
    g_option_context_set_help_enabled(cast(GOptionContext*)cPtr, helpEnabled);
  }

  /**
   * Sets whether to ignore unknown options or not. If an argument is
   * ignored, it is left in the argv array after parsing. By default,
   * [GLib.OptionContext.parse] treats unknown options as error.
   * This setting does not affect non-option arguments $(LPAREN)i.e. arguments
   * which don't start with a dash$(RPAREN). But note that GOption cannot reliably
   * determine whether a non-option belongs to a preceding unknown option.
   * Params:
   *   ignoreUnknown = %TRUE to ignore unknown options, %FALSE to produce
   *     an error when unknown options are met
   */
  void setIgnoreUnknownOptions(bool ignoreUnknown)
  {
    g_option_context_set_ignore_unknown_options(cast(GOptionContext*)cPtr, ignoreUnknown);
  }

  /**
   * Sets a #GOptionGroup as main group of the context.
   * This has the same effect as calling [GLib.OptionContext.addGroup],
   * the only difference is that the options in the main group are
   * treated differently when generating `--help` output.
   * Params:
   *   group = the group to set as main group
   */
  void setMainGroup(OptionGroup group)
  {
    g_option_context_set_main_group(cast(GOptionContext*)cPtr, group ? cast(GOptionGroup*)group.cPtr(true) : null);
  }

  /**
   * Sets strict POSIX mode.
   * By default, this mode is disabled.
   * In strict POSIX mode, the first non-argument parameter encountered
   * $(LPAREN)eg: filename$(RPAREN) terminates argument processing.  Remaining arguments
   * are treated as non-options and are not attempted to be parsed.
   * If strict POSIX mode is disabled then parsing is done in the GNU way
   * where option arguments can be freely mixed with non-options.
   * As an example, consider "ls foo -l".  With GNU style parsing, this
   * will list "foo" in long mode.  In strict POSIX style, this will list
   * the files named "foo" and "-l".
   * It may be useful to force strict POSIX mode when creating "verb
   * style" command line tools.  For example, the "gsettings" command line
   * tool supports the global option "--schemadir" as well as many
   * subcommands $(LPAREN)"get", "set", etc.$(RPAREN) which each have their own set of
   * arguments.  Using strict POSIX mode will allow parsing the global
   * options up to the verb name while leaving the remaining options to be
   * parsed by the relevant subcommand $(LPAREN)which can be determined by
   * examining the verb name, which should be present in argv[1] after
   * parsing$(RPAREN).
   * Params:
   *   strictPosix = the new value
   */
  void setStrictPosix(bool strictPosix)
  {
    g_option_context_set_strict_posix(cast(GOptionContext*)cPtr, strictPosix);
  }

  /**
   * Adds a string to be displayed in `--help` output before the list
   * of options. This is typically a summary of the program functionality.
   * Note that the summary is translated $(LPAREN)see
   * [GLib.OptionContext.setTranslateFunc] and
   * [GLib.OptionContext.setTranslationDomain]$(RPAREN).
   * Params:
   *   summary = a string to be shown in `--help` output
   *     before the list of options, or %NULL
   */
  void setSummary(string summary)
  {
    const(char)* _summary = summary.toCString(false);
    g_option_context_set_summary(cast(GOptionContext*)cPtr, _summary);
  }

  /**
   * Sets the function which is used to translate the contexts
   * user-visible strings, for `--help` output. If func is %NULL,
   * strings are not translated.
   * Note that option groups have their own translation functions,
   * this function only affects the parameter_string $(LPAREN)see [GLib.OptionContext.new_]$(RPAREN),
   * the summary $(LPAREN)see [GLib.OptionContext.setSummary]$(RPAREN) and the description
   * $(LPAREN)see [GLib.OptionContext.setDescription]$(RPAREN).
   * If you are using gettext$(LPAREN)$(RPAREN), you only need to set the translation
   * domain, see [GLib.OptionContext.setTranslationDomain].
   * Params:
   *   func = the #GTranslateFunc, or %NULL
   */
  void setTranslateFunc(TranslateFunc func)
  {
    extern(C) const(char)* _funcCallback(const(char)* str, void* data)
    {
      string _dretval;
      auto _dlg = cast(TranslateFunc*)data;
      string _str = str.fromCString(false);

      _dretval = (*_dlg)(_str);
      const(char)* _retval = _dretval.toCString(false);

      return _retval;
    }

    auto _func = freezeDelegate(cast(void*)&func);
    g_option_context_set_translate_func(cast(GOptionContext*)cPtr, &_funcCallback, _func, &thawDelegate);
  }

  /**
   * A convenience function to use gettext$(LPAREN)$(RPAREN) for translating
   * user-visible strings.
   * Params:
   *   domain = the domain to use
   */
  void setTranslationDomain(string domain)
  {
    const(char)* _domain = domain.toCString(false);
    g_option_context_set_translation_domain(cast(GOptionContext*)cPtr, _domain);
  }
}
