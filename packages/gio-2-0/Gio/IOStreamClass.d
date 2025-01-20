module Gio.IOStreamClass;

import GObject.ObjectClass;
import Gid.gid;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

class IOStreamClass
{
  GIOStreamClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.IOStreamClass");

    cInstance = *cast(GIOStreamClass*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property ObjectClass parentClass()
  {
    return new ObjectClass(cast(GObjectClass*)&(cast(GIOStreamClass*)cPtr).parentClass);
  }

  alias GetInputStreamFuncType = extern(C) GInputStream* function(GIOStream* stream);

  @property GetInputStreamFuncType getInputStream()
  {
    return (cast(GIOStreamClass*)cPtr).getInputStream;
  }

  alias GetOutputStreamFuncType = extern(C) GOutputStream* function(GIOStream* stream);

  @property GetOutputStreamFuncType getOutputStream()
  {
    return (cast(GIOStreamClass*)cPtr).getOutputStream;
  }

  alias CloseFnFuncType = extern(C) bool function(GIOStream* stream, GCancellable* cancellable, GError** _err);

  @property CloseFnFuncType closeFn()
  {
    return (cast(GIOStreamClass*)cPtr).closeFn;
  }

  alias CloseAsyncFuncType = extern(C) void function(GIOStream* stream, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property CloseAsyncFuncType closeAsync()
  {
    return (cast(GIOStreamClass*)cPtr).closeAsync;
  }

  alias CloseFinishFuncType = extern(C) bool function(GIOStream* stream, GAsyncResult* result, GError** _err);

  @property CloseFinishFuncType closeFinish()
  {
    return (cast(GIOStreamClass*)cPtr).closeFinish;
  }
}
