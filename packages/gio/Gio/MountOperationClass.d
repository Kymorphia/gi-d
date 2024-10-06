module Gio.MountOperationClass;

import GObject.ObjectClass;
import Gid.gid;
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
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property ObjectClass parentClass()
  {
    return new ObjectClass(cast(GObjectClass*)&(cast(GMountOperationClass*)cPtr).parentClass);
  }

  alias AskPasswordFuncType = extern(C) void function(GMountOperation* op, const(char)* message, const(char)* defaultUser, const(char)* defaultDomain, GAskPasswordFlags flags);

  @property AskPasswordFuncType askPassword()
  {
    return (cast(GMountOperationClass*)cPtr).askPassword;
  }

  alias AskQuestionFuncType = extern(C) void function(GMountOperation* op, const(char)* message, const(char*)* choices);

  @property AskQuestionFuncType askQuestion()
  {
    return (cast(GMountOperationClass*)cPtr).askQuestion;
  }

  alias ReplyFuncType = extern(C) void function(GMountOperation* op, GMountOperationResult result);

  @property ReplyFuncType reply()
  {
    return (cast(GMountOperationClass*)cPtr).reply;
  }

  alias AbortedFuncType = extern(C) void function(GMountOperation* op);

  @property AbortedFuncType aborted()
  {
    return (cast(GMountOperationClass*)cPtr).aborted;
  }

  alias ShowProcessesFuncType = extern(C) void function(GMountOperation* op, const(char)* message, GArray* processes, const(char*)* choices);

  @property ShowProcessesFuncType showProcesses()
  {
    return (cast(GMountOperationClass*)cPtr).showProcesses;
  }

  alias ShowUnmountProgressFuncType = extern(C) void function(GMountOperation* op, const(char)* message, long timeLeft, long bytesLeft);

  @property ShowUnmountProgressFuncType showUnmountProgress()
  {
    return (cast(GMountOperationClass*)cPtr).showUnmountProgress;
  }
}
