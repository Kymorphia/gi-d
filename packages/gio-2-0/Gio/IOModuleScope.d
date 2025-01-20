module Gio.IOModuleScope;

import Gid.gid;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * Represents a scope for loading IO modules. A scope can be used for blocking
 * duplicate modules, or blocking a module you don't want to load.
 * The scope can be used with [Gio.Global.ioModulesLoadAllInDirectoryWithScope]
 * or [Gio.Global.ioModulesScanAllInDirectoryWithScope].
 */
class IOModuleScope
{
  GIOModuleScope* cInstancePtr;
  bool owned;

  this(void* ptr, bool owned = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.IOModuleScope");

    cInstancePtr = cast(GIOModuleScope*)ptr;

    this.owned = owned;
  }

  void* cPtr()
  {
    return cast(void*)cInstancePtr;
  }

  /**
   * Block modules with the given basename from being loaded when
   * this scope is used with [Gio.Global.ioModulesScanAllInDirectoryWithScope]
   * or [Gio.Global.ioModulesLoadAllInDirectoryWithScope].
   * Params:
   *   basename = the basename to block
   */
  void block(string basename)
  {
    const(char)* _basename = basename.toCString(false);
    g_io_module_scope_block(cast(GIOModuleScope*)cPtr, _basename);
  }
}
