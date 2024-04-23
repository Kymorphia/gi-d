module GLib.OptionGroup;

import GLib.Boxed;
import GLib.OptionEntry;
import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.Gid;

/**
 * A `GOptionGroup` struct defines the options in a single
 * group. The struct has only private fields and should not be directly accessed.
 *
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

  T* cPtr(T)(bool makeCopy = false)
  if (is(T == GOptionGroup))
  {
    return makeCopy ? copy_!T : cast(T*)cInstancePtr;
  }

  static GType getType()
  {
    return g_option_group_get_type();
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
   * Adds the options specified in @entries to @group.
   */
  void addEntries(OptionEntry[] entries)
  {
    GOptionEntry[] _tmpentries;
    foreach (obj; entries)
      _tmpentries ~= obj.cInstance;
    _tmpentries ~= GOptionEntry();
    const(GOptionEntry)* _entries = _tmpentries.ptr;
    g_option_group_add_entries(cPtr!GOptionGroup, _entries);
  }

  /**
   * Sets the function which is used to translate user-visible strings,
   * for `--help` output. Different groups can use different
   * #GTranslateFuncs. If @func is %NULL, strings are not translated.
   *
   * If you are using gettext(), you only need to set the translation
   * domain, see g_option_group_set_translation_domain().
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
    g_option_group_set_translate_func(cPtr!GOptionGroup, &_funcCallback, cast(void*)&func, &ptrThawDestroyNotify);
  }

  /**
   * A convenience function to use gettext() for translating
   * user-visible strings.
   */
  void setTranslationDomain(string domain)
  {
    const(char)* _domain = domain.toCString(false);
    g_option_group_set_translation_domain(cPtr!GOptionGroup, _domain);
  }
}
