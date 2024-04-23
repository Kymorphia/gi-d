module Gio.InputStreamClass;

import GLib.c.functions;
import GObject.ObjectClass;
import GObject.Types;
import Gid.Gid;
import Gio.AsyncResult;
import Gio.Cancellable;
import Gio.InputStream;
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
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GInputStreamClass))
  {
    return cast(T*)&cInstance;
  }

  @property ObjectClass parentClass()
  {
    return new ObjectClass(cast(GObjectClass*)&cPtr!GInputStreamClass.parentClass);
  }

  alias ReadFnFuncType = extern(C) ptrdiff_t function(GInputStream* stream, void* buffer, size_t count, GCancellable* cancellable, GError** _err);

  @property ReadFnFuncType readFn()
  {
    return cPtr!GInputStreamClass.readFn;
  }

  alias SkipFuncType = extern(C) ptrdiff_t function(GInputStream* stream, size_t count, GCancellable* cancellable, GError** _err);

  @property SkipFuncType skip()
  {
    return cPtr!GInputStreamClass.skip;
  }

  alias CloseFnFuncType = extern(C) bool function(GInputStream* stream, GCancellable* cancellable, GError** _err);

  @property CloseFnFuncType closeFn()
  {
    return cPtr!GInputStreamClass.closeFn;
  }

  alias ReadAsyncFuncType = extern(C) void function(GInputStream* stream, void* buffer, size_t count, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property ReadAsyncFuncType readAsync()
  {
    return cPtr!GInputStreamClass.readAsync;
  }

  alias ReadFinishFuncType = extern(C) ptrdiff_t function(GInputStream* stream, GAsyncResult* result, GError** _err);

  @property ReadFinishFuncType readFinish()
  {
    return cPtr!GInputStreamClass.readFinish;
  }

  alias SkipAsyncFuncType = extern(C) void function(GInputStream* stream, size_t count, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property SkipAsyncFuncType skipAsync()
  {
    return cPtr!GInputStreamClass.skipAsync;
  }

  alias SkipFinishFuncType = extern(C) ptrdiff_t function(GInputStream* stream, GAsyncResult* result, GError** _err);

  @property SkipFinishFuncType skipFinish()
  {
    return cPtr!GInputStreamClass.skipFinish;
  }

  alias CloseAsyncFuncType = extern(C) void function(GInputStream* stream, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property CloseAsyncFuncType closeAsync()
  {
    return cPtr!GInputStreamClass.closeAsync;
  }

  alias CloseFinishFuncType = extern(C) bool function(GInputStream* stream, GAsyncResult* result, GError** _err);

  @property CloseFinishFuncType closeFinish()
  {
    return cPtr!GInputStreamClass.closeFinish;
  }
}
