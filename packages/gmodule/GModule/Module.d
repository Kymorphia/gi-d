module GModule.Module;

import GLib.ErrorG;
import GLib.Types;
import GModule.Types;
import GModule.c.functions;
import GModule.c.types;
import Gid.Gid;

/**
 * The #GModule struct is an opaque data structure to represent a
 * [dynamically-loaded module][glib-Dynamic-Loading-of-Modules].
 * It should only be accessed via the following functions.
 */
class Module
{
  ModuleC* cInstancePtr;
  bool owned;

  this(void* ptr, bool owned = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for GModule.Module");

    cInstancePtr = cast(ModuleC*)ptr;

    this.owned = owned;
  }

  T* cPtr(T)()
  if (is(T == ModuleC))
  {
    return cast(T*)cInstancePtr;
  }

  /**
   * %TRUE on success
   */
  bool close()
  {
    bool _retval;
    _retval = g_module_close(cPtr!ModuleC);
    return _retval;
  }

  /**
   * Ensures that a module will never be unloaded.
   * Any future g_module_close() calls on the module will be ignored.
   */
  void makeResident()
  {
    g_module_make_resident(cPtr!ModuleC);
  }

  /**
   * the filename of the module
   */
  string name()
  {
    const(char)* _cretval;
    _cretval = g_module_name(cPtr!ModuleC);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * %TRUE on success
   */
  bool symbol(string symbolName, out void* symbol)
  {
    bool _retval;
    const(char)* _symbolName = symbolName.toCString(false);
    _retval = g_module_symbol(cPtr!ModuleC, _symbolName, cast(void**)&symbol);
    return _retval;
  }

  /**
   * the complete path of the module, including the standard library
   * prefix and suffix. This should be freed when no longer needed
   */
  static string buildPath(string directory, string moduleName)
  {
    char* _cretval;
    const(char)* _directory = directory.toCString(false);
    const(char)* _moduleName = moduleName.toCString(false);
    _cretval = g_module_build_path(_directory, _moduleName);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * a string describing the last module error
   */
  static string error()
  {
    const(char)* _cretval;
    _cretval = g_module_error();
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  static Quark errorQuark()
  {
    Quark _retval;
    _retval = g_module_error_quark();
    return _retval;
  }

  /**
   * %TRUE if modules are supported
   */
  static bool supported()
  {
    bool _retval;
    _retval = g_module_supported();
    return _retval;
  }
}

class ModuleException : ErrorG
{
  this(GError* err)
  {
    super(err);
  }

  this(Code code, string msg)
  {
    super(Module.errorQuark, cast(int)code, msg);
  }

  alias Code = GModuleError;
}
