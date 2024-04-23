module Gio.MountOperationClass;

import GLib.ArrayG;
import GLib.Types;
import GLib.c.functions;
import GObject.ObjectClass;
import GObject.Types;
import Gid.Gid;
import Gio.MountOperation;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

class MountOperationClass
{
  GMountOperationClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.MountOperationClass");

    cInstance = *cast(GMountOperationClass*)ptr;

    if (ownedRef)
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GMountOperationClass))
  {
    return cast(T*)&cInstance;
  }

  @property ObjectClass parentClass()
  {
    return new ObjectClass(cast(GObjectClass*)&cPtr!GMountOperationClass.parentClass);
  }

  alias AskPasswordFuncType = extern(C) void function(GMountOperation* op, const(char)* message, const(char)* defaultUser, const(char)* defaultDomain, GAskPasswordFlags flags);

  @property AskPasswordFuncType askPassword()
  {
    return cPtr!GMountOperationClass.askPassword;
  }

  alias AskQuestionFuncType = extern(C) void function(GMountOperation* op, const(char)* message, const(char*)* choices);

  @property AskQuestionFuncType askQuestion()
  {
    return cPtr!GMountOperationClass.askQuestion;
  }

  alias ReplyFuncType = extern(C) void function(GMountOperation* op, GMountOperationResult result);

  @property ReplyFuncType reply()
  {
    return cPtr!GMountOperationClass.reply;
  }

  alias AbortedFuncType = extern(C) void function(GMountOperation* op);

  @property AbortedFuncType aborted()
  {
    return cPtr!GMountOperationClass.aborted;
  }

  alias ShowProcessesFuncType = extern(C) void function(GMountOperation* op, const(char)* message, GArray* processes, const(char*)* choices);

  @property ShowProcessesFuncType showProcesses()
  {
    return cPtr!GMountOperationClass.showProcesses;
  }

  alias ShowUnmountProgressFuncType = extern(C) void function(GMountOperation* op, const(char)* message, long timeLeft, long bytesLeft);

  @property ShowUnmountProgressFuncType showUnmountProgress()
  {
    return cPtr!GMountOperationClass.showUnmountProgress;
  }
}
