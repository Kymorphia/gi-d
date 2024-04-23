module Gio.FilenameCompleter;

import GObject.DClosure;
import GObject.ObjectG;
import GObject.Types;
import Gid.Gid;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * Completes partial file and directory names given a partial string by
 * looking in the file system for clues. Can return a list of possible
 * completion strings for widget implementations.
 */
class FilenameCompleter : ObjectG
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_filename_completer_get_type();
  }

  /**
   * a #GFilenameCompleter.
   */
  this()
  {
    GFilenameCompleter* _cretval;
    _cretval = g_filename_completer_new();
    this(_cretval, true);
  }

  /**
   * a completed string, or %NULL if no
   * completion exists. This string is not owned by GIO, so remember to g_free()
   * it when finished.
   */
  string getCompletionSuffix(string initialText)
  {
    char* _cretval;
    const(char)* _initialText = initialText.toCString(false);
    _cretval = g_filename_completer_get_completion_suffix(cPtr!GFilenameCompleter, _initialText);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * array of strings with possible completions for @initial_text.
   * This array must be freed by g_strfreev() when finished.
   */
  string[] getCompletions(string initialText)
  {
    char** _cretval;
    const(char)* _initialText = initialText.toCString(false);
    _cretval = g_filename_completer_get_completions(cPtr!GFilenameCompleter, _initialText);
    string[] _retval;

    if (_cretval)
    {
      uint _cretlength;
      for (; _cretval[_cretlength] != null; _cretlength++)
        break;
      _retval = new string[_cretlength];
      foreach (i; 0 .. _cretlength)
        _retval[i] = _cretval[i].fromCString(true);
    }
    return _retval;
  }

  /**
   * If @dirs_only is %TRUE, @completer will only
   * complete directory names, and not file names.
   */
  void setDirsOnly(bool dirsOnly)
  {
    g_filename_completer_set_dirs_only(cPtr!GFilenameCompleter, dirsOnly);
  }

  /**
   * Emitted when the file name completion information comes available.
   */
  ulong connectGotCompletionData(void delegate(FilenameCompleter filenameCompleter) dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto filenameCompleter = getVal!FilenameCompleter(_paramVals);
      _dgClosure.dlg(filenameCompleter);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("got-completion-data", closure, (flags & ConnectFlags.After) != 0);
  }
}
