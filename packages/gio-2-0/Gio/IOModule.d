module Gio.IOModule;

import GObject.TypeModule;
import GObject.TypePlugin;
import GObject.TypePluginT;
import Gid.gid;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * Provides an interface and default functions for loading and unloading
 * modules. This is used internally to make GIO extensible, but can also
 * be used by others to implement module loading.
 */
class IOModule : TypeModule
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
    return g_io_module_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new GIOModule that will load the specific
   * shared library when in use.
   * Params:
   *   filename = filename of the shared library module.
   * Returns: a #GIOModule from given filename,
   *   or %NULL on error.
   */
  this(string filename)
  {
    GIOModule* _cretval;
    const(char)* _filename = filename.toCString(false);
    _cretval = g_io_module_new(_filename);
    this(_cretval, true);
  }

  /**
   * Optional API for GIO modules to implement.
   * Should return a list of all the extension points that may be
   * implemented in this module.
   * This method will not be called in normal use, however it may be
   * called when probing existing modules and recording which extension
   * points that this model is used for. This means we won't have to
   * load and initialize this module unless its needed.
   * If this function is not implemented by the module the module will
   * always be loaded, initialized and then unloaded on application
   * startup so that it can register its extension points during init.
   * Note that a module need not actually implement all the extension
   * points that [Gio.IOModule.query] returns, since the exact list of
   * extension may depend on runtime issues. However all extension
   * points actually implemented must be returned by [Gio.IOModule.query]
   * $(LPAREN)if defined$(RPAREN).
   * When installing a module that implements [Gio.IOModule.query] you must
   * run gio-querymodules in order to build the cache files required for
   * lazy loading.
   * Since 2.56, this function should be named `g_io_<modulename>_query`, where
   * `modulename` is the plugin’s filename with the `lib` or `libgio` prefix and
   * everything after the first dot removed, and with `-` replaced with `_`
   * throughout. For example, `libgiognutls-helper.so` becomes `gnutls_helper`.
   * Using the new symbol names avoids name clashes when building modules
   * statically. The old symbol names continue to be supported, but cannot be used
   * for static builds.
   * Returns: A %NULL-terminated array of strings,
   *   listing the supported extension points of the module. The array
   *   must be suitable for freeing with [GLib.Global.strfreev].
   */
  static string[] query()
  {
    char** _cretval;
    _cretval = g_io_module_query();
    string[] _retval;

    if (_cretval)
    {
      uint _cretlength;
      for (; _cretval[_cretlength] !is null; _cretlength++)
        break;
      _retval = new string[_cretlength];
      foreach (i; 0 .. _cretlength)
        _retval[i] = _cretval[i].fromCString(true);
    }
    return _retval;
  }
}
