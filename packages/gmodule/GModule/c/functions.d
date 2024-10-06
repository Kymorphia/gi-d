module GModule.c.functions;

import GModule.c.types;
public import GLib.c.types;

version(Windows)
  private immutable LIBS = ["libgmodule-2.0-0.dll;gmodule-2.0-0.dll;gmodule-2.dll"];
version(OSX)
  private immutable LIBS = ["libgmodule-2.0.0.dylib"];
else
  private immutable LIBS = ["libgmodule-2.0.so.0"];

__gshared extern(C)
{
  // Module
  bool function(ModuleC* module_) c_g_module_close;
  void function(ModuleC* module_) c_g_module_make_resident;
  const(char)* function(ModuleC* module_) c_g_module_name;
  bool function(ModuleC* module_, const(char)* symbolName, void** symbol) c_g_module_symbol;
  char* function(const(char)* directory, const(char)* moduleName) c_g_module_build_path;
  const(char)* function() c_g_module_error;
  GQuark function() c_g_module_error_quark;
  ModuleC* function(const(char)* fileName, GModuleFlags flags) c_g_module_open;
  ModuleC* function(const(char)* fileName, GModuleFlags flags, GError** _err) c_g_module_open_full;
  bool function() c_g_module_supported;
}

// Module
alias g_module_close = c_g_module_close;
alias g_module_make_resident = c_g_module_make_resident;
alias g_module_name = c_g_module_name;
alias g_module_symbol = c_g_module_symbol;
alias g_module_build_path = c_g_module_build_path;
alias g_module_error = c_g_module_error;
alias g_module_error_quark = c_g_module_error_quark;
alias g_module_open = c_g_module_open;
alias g_module_open_full = c_g_module_open_full;
alias g_module_supported = c_g_module_supported;

shared static this()
{
  // Module
  link(g_module_close, "g_module_close");
  link(g_module_make_resident, "g_module_make_resident");
  link(g_module_name, "g_module_name");
  link(g_module_symbol, "g_module_symbol");
  link(g_module_build_path, "g_module_build_path");
  link(g_module_error, "g_module_error");
  link(g_module_error_quark, "g_module_error_quark");
  link(g_module_open, "g_module_open");
  link(g_module_open_full, "g_module_open_full");
  link(g_module_supported, "g_module_supported");
}

import core.sys.posix.dlfcn : dlerror, dlopen, dlsym, RTLD_GLOBAL, RTLD_NOW;
import std.string : fromStringz, toStringz;

private void link(T)(ref T funcPtr, string symbol)
{
  foreach (lib; LIBS)
  {
  if (auto handle = dlopen(cast(char*)toStringz(lib), RTLD_GLOBAL | RTLD_NOW))
  {
  if (auto symPtr = dlsym(handle, cast(char*)toStringz(symbol)))
  {
  funcPtr = cast(T)symPtr;
  return;
  }
  }
  else
  throw new Error("Failed to load library '" ~ lib ~ "': " ~ dlerror().fromStringz.idup);
  }

  funcPtr = cast(T)&symbolNotFound;
}

private void symbolNotFound()
{
  throw new Error("Attempted to execute a dynamic library function which was not found");
}
