module Gio.InputStreamClass;

import GObject.ObjectClass;
import Gid.gid;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

class InputStreamClass
{
  GInputStreamClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.InputStreamClass");

    cInstance = *cast(GInputStreamClass*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property ObjectClass parentClass()
  {
    return new ObjectClass(cast(GObjectClass*)&(cast(GInputStreamClass*)cPtr).parentClass);
  }

  alias ReadFnFuncType = extern(C) ptrdiff_t function(GInputStream* stream, void* buffer, size_t count, GCancellable* cancellable, GError** _err);

  @property ReadFnFuncType readFn()
  {
    return (cast(GInputStreamClass*)cPtr).readFn;
  }

  alias SkipFuncType = extern(C) ptrdiff_t function(GInputStream* stream, size_t count, GCancellable* cancellable, GError** _err);

  @property SkipFuncType skip()
  {
    return (cast(GInputStreamClass*)cPtr).skip;
  }

  alias CloseFnFuncType = extern(C) bool function(GInputStream* stream, GCancellable* cancellable, GError** _err);

  @property CloseFnFuncType closeFn()
  {
    return (cast(GInputStreamClass*)cPtr).closeFn;
  }

  alias ReadAsyncFuncType = extern(C) void function(GInputStream* stream, void* buffer, size_t count, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property ReadAsyncFuncType readAsync()
  {
    return (cast(GInputStreamClass*)cPtr).readAsync;
  }

  alias ReadFinishFuncType = extern(C) ptrdiff_t function(GInputStream* stream, GAsyncResult* result, GError** _err);

  @property ReadFinishFuncType readFinish()
  {
    return (cast(GInputStreamClass*)cPtr).readFinish;
  }

  alias SkipAsyncFuncType = extern(C) void function(GInputStream* stream, size_t count, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property SkipAsyncFuncType skipAsync()
  {
    return (cast(GInputStreamClass*)cPtr).skipAsync;
  }

  alias SkipFinishFuncType = extern(C) ptrdiff_t function(GInputStream* stream, GAsyncResult* result, GError** _err);

  @property SkipFinishFuncType skipFinish()
  {
    return (cast(GInputStreamClass*)cPtr).skipFinish;
  }

  alias CloseAsyncFuncType = extern(C) void function(GInputStream* stream, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property CloseAsyncFuncType closeAsync()
  {
    return (cast(GInputStreamClass*)cPtr).closeAsync;
  }

  alias CloseFinishFuncType = extern(C) bool function(GInputStream* stream, GAsyncResult* result, GError** _err);

  @property CloseFinishFuncType closeFinish()
  {
    return (cast(GInputStreamClass*)cPtr).closeFinish;
  }
}
