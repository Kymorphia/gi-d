module Gio.IOModule;

import GObject.ObjectG;
import GObject.TypeModule;
import GObject.TypePlugin;
import GObject.TypePluginT;
import GObject.Types;
import Gid.Gid;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * Provides an interface and default functions for loading and unloading
 * modules. This is used internally to make GIO extensible, but can also
 * be used by others to implement module loading.
 */
class IOModule : TypeModule, TypePlugin
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_io_module_get_type();
  }

  mixin TypePluginT!GIOModule;

  /**
   * a #GIOModule from given @filename,
   * or %NULL on error.
   */
  this(string filename)
  {
    GIOModule* _cretval;
    const(char)* _filename = filename.toCString(false);
    _cretval = g_io_module_new(_filename);
    this(_cretval, true);
  }

  /**
   * A %NULL-terminated array of strings,
   * listing the supported extension points of the module. The array
   * must be suitable for freeing with g_strfreev().
   */
  static string[] query()
  {
    char** _cretval;
    _cretval = g_io_module_query();
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
}
