module GModule.Types;

import GModule.Module;
import GModule.c.types;
import Gid.Gid;


// Enums
alias ModuleError = GModuleError;
alias ModuleFlags = GModuleFlags;

// Callbacks
alias ModuleCheckInit = string delegate(Module module_);
alias ModuleUnload = void delegate(Module module_);
