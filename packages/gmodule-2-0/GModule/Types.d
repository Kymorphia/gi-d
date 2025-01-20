module GModule.Types;

import GModule.Module;
import GModule.c.functions;
import GModule.c.types;
import Gid.gid;


// Enums
alias ModuleError = GModuleError;
alias ModuleFlags = GModuleFlags;

// Callbacks
alias ModuleCheckInit = string delegate(Module module_);
alias ModuleUnload = void delegate(Module module_);

enum MODULE_IMPL_AR = 7;


enum MODULE_IMPL_DL = 1;


enum MODULE_IMPL_NONE = 0;


enum MODULE_IMPL_WIN32 = 3;

