module GLib.OptionGroup;

import GLib.Boxed;
import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.gid;

/**
 * A `GOptionGroup` struct defines the options in a single
 * group. The struct has only private fields and should not be directly accessed.
 * All options in a group share the same translation function. Libraries which
 * need to parse commandline options are expected to provide a function for
 * getting a `GOptionGroup` holding their options, which
 * the application can then add to its #GOptionContext.
 */
class OptionGroup : Boxed
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
    return g_option_group_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  this(string name, string description, string helpDescription)
  {
    GOptionGroup* _cretval;
    const(char)* _name = name.toCString(false);
    const(char)* _description = description.toCString(false);
    const(char)* _helpDescription = helpDescription.toCString(false);
    _cretval = g_option_group_new(_name, _description, _helpDescription, null, null);
    this(&_cretval, true);
  }


  /**
   * Adds the options specified in entries to group.
   * Params:
   *   entries = a %NULL-terminated array of #GOptionEntrys
   */
  void addEntries(OptionEntry[] entries)
  {
    auto _entries = cast(const(GOptionEntry)*)(entries ~ GOptionEntry.init).ptr;
    g_option_group_add_entries(cast(GOptionGroup*)cPtr, _entries);
  }

  /**
   * Sets the function which is used to translate user-visible strings,
   * for `--help` output. Different groups can use different
   * #GTranslateFuncs. If func is %NULL, strings are not translated.
   * If you are using gettext$(LPAREN)$(RPAREN), you only need to set the translation
   * domain, see [GLib.OptionGroup.setTranslationDomain].
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
    g_option_group_set_translate_func(cast(GOptionGroup*)cPtr, &_funcCallback, _func, &thawDelegate);
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
    g_option_group_set_translation_domain(cast(GOptionGroup*)cPtr, _domain);
  }
}
