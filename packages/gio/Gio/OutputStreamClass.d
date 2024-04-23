module Gio.OutputStreamClass;

import GLib.c.functions;
import GObject.ObjectClass;
import GObject.Types;
import Gid.Gid;
import Gio.AsyncResult;
import Gio.Cancellable;
import Gio.InputStream;
import Gio.OutputStream;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

class OutputStreamClass
{
  GOutputStreamClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.OutputStreamClass");

    cInstance = *cast(GOutputStreamClass*)ptr;

    if (ownedRef)
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GOutputStreamClass))
  {
    return cast(T*)&cInstance;
  }

  @property ObjectClass parentClass()
  {
    return new ObjectClass(cast(GObjectClass*)&cPtr!GOutputStreamClass.parentClass);
  }

  alias WriteFnFuncType = extern(C) ptrdiff_t function(GOutputStream* stream, void* buffer, size_t count, GCancellable* cancellable, GError** _err);

  @property WriteFnFuncType writeFn()
  {
    return cPtr!GOutputStreamClass.writeFn;
  }

  alias SpliceFuncType = extern(C) ptrdiff_t function(GOutputStream* stream, GInputStream* source, GOutputStreamSpliceFlags flags, GCancellable* cancellable, GError** _err);

  @property SpliceFuncType splice()
  {
    return cPtr!GOutputStreamClass.splice;
  }

  alias FlushFuncType = extern(C) bool function(GOutputStream* stream, GCancellable* cancellable, GError** _err);

  @property FlushFuncType flush()
  {
    return cPtr!GOutputStreamClass.flush;
  }

  alias CloseFnFuncType = extern(C) bool function(GOutputStream* stream, GCancellable* cancellable, GError** _err);

  @property CloseFnFuncType closeFn()
  {
    return cPtr!GOutputStreamClass.closeFn;
  }

  alias WriteAsyncFuncType = extern(C) void function(GOutputStream* stream, void* buffer, size_t count, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property WriteAsyncFuncType writeAsync()
  {
    return cPtr!GOutputStreamClass.writeAsync;
  }

  alias WriteFinishFuncType = extern(C) ptrdiff_t function(GOutputStream* stream, GAsyncResult* result, GError** _err);

  @property WriteFinishFuncType writeFinish()
  {
    return cPtr!GOutputStreamClass.writeFinish;
  }

  alias SpliceAsyncFuncType = extern(C) void function(GOutputStream* stream, GInputStream* source, GOutputStreamSpliceFlags flags, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property SpliceAsyncFuncType spliceAsync()
  {
    return cPtr!GOutputStreamClass.spliceAsync;
  }

  alias SpliceFinishFuncType = extern(C) ptrdiff_t function(GOutputStream* stream, GAsyncResult* result, GError** _err);

  @property SpliceFinishFuncType spliceFinish()
  {
    return cPtr!GOutputStreamClass.spliceFinish;
  }

  alias FlushAsyncFuncType = extern(C) void function(GOutputStream* stream, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property FlushAsyncFuncType flushAsync()
  {
    return cPtr!GOutputStreamClass.flushAsync;
  }

  alias FlushFinishFuncType = extern(C) bool function(GOutputStream* stream, GAsyncResult* result, GError** _err);

  @property FlushFinishFuncType flushFinish()
  {
    return cPtr!GOutputStreamClass.flushFinish;
  }

  alias CloseAsyncFuncType = extern(C) void function(GOutputStream* stream, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property CloseAsyncFuncType closeAsync()
  {
    return cPtr!GOutputStreamClass.closeAsync;
  }

  alias CloseFinishFuncType = extern(C) bool function(GOutputStream* stream, GAsyncResult* result, GError** _err);

  @property CloseFinishFuncType closeFinish()
  {
    return cPtr!GOutputStreamClass.closeFinish;
  }

  alias WritevFnFuncType = extern(C) bool function(GOutputStream* stream, const(GOutputVector)* vectors, size_t nVectors, size_t* bytesWritten, GCancellable* cancellable, GError** _err);

  @property WritevFnFuncType writevFn()
  {
    return cPtr!GOutputStreamClass.writevFn;
  }

  alias WritevAsyncFuncType = extern(C) void function(GOutputStream* stream, const(GOutputVector)* vectors, size_t nVectors, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property WritevAsyncFuncType writevAsync()
  {
    return cPtr!GOutputStreamClass.writevAsync;
  }

  alias WritevFinishFuncType = extern(C) bool function(GOutputStream* stream, GAsyncResult* result, size_t* bytesWritten, GError** _err);

  @property WritevFinishFuncType writevFinish()
  {
    return cPtr!GOutputStreamClass.writevFinish;
  }
}
