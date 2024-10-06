module Gio.OutputStreamClass;

import GObject.ObjectClass;
import Gid.gid;
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
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property ObjectClass parentClass()
  {
    return new ObjectClass(cast(GObjectClass*)&(cast(GOutputStreamClass*)cPtr).parentClass);
  }

  alias WriteFnFuncType = extern(C) ptrdiff_t function(GOutputStream* stream, void* buffer, size_t count, GCancellable* cancellable, GError** _err);

  @property WriteFnFuncType writeFn()
  {
    return (cast(GOutputStreamClass*)cPtr).writeFn;
  }

  alias SpliceFuncType = extern(C) ptrdiff_t function(GOutputStream* stream, GInputStream* source, GOutputStreamSpliceFlags flags, GCancellable* cancellable, GError** _err);

  @property SpliceFuncType splice()
  {
    return (cast(GOutputStreamClass*)cPtr).splice;
  }

  alias FlushFuncType = extern(C) bool function(GOutputStream* stream, GCancellable* cancellable, GError** _err);

  @property FlushFuncType flush()
  {
    return (cast(GOutputStreamClass*)cPtr).flush;
  }

  alias CloseFnFuncType = extern(C) bool function(GOutputStream* stream, GCancellable* cancellable, GError** _err);

  @property CloseFnFuncType closeFn()
  {
    return (cast(GOutputStreamClass*)cPtr).closeFn;
  }

  alias WriteAsyncFuncType = extern(C) void function(GOutputStream* stream, void* buffer, size_t count, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property WriteAsyncFuncType writeAsync()
  {
    return (cast(GOutputStreamClass*)cPtr).writeAsync;
  }

  alias WriteFinishFuncType = extern(C) ptrdiff_t function(GOutputStream* stream, GAsyncResult* result, GError** _err);

  @property WriteFinishFuncType writeFinish()
  {
    return (cast(GOutputStreamClass*)cPtr).writeFinish;
  }

  alias SpliceAsyncFuncType = extern(C) void function(GOutputStream* stream, GInputStream* source, GOutputStreamSpliceFlags flags, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property SpliceAsyncFuncType spliceAsync()
  {
    return (cast(GOutputStreamClass*)cPtr).spliceAsync;
  }

  alias SpliceFinishFuncType = extern(C) ptrdiff_t function(GOutputStream* stream, GAsyncResult* result, GError** _err);

  @property SpliceFinishFuncType spliceFinish()
  {
    return (cast(GOutputStreamClass*)cPtr).spliceFinish;
  }

  alias FlushAsyncFuncType = extern(C) void function(GOutputStream* stream, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property FlushAsyncFuncType flushAsync()
  {
    return (cast(GOutputStreamClass*)cPtr).flushAsync;
  }

  alias FlushFinishFuncType = extern(C) bool function(GOutputStream* stream, GAsyncResult* result, GError** _err);

  @property FlushFinishFuncType flushFinish()
  {
    return (cast(GOutputStreamClass*)cPtr).flushFinish;
  }

  alias CloseAsyncFuncType = extern(C) void function(GOutputStream* stream, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property CloseAsyncFuncType closeAsync()
  {
    return (cast(GOutputStreamClass*)cPtr).closeAsync;
  }

  alias CloseFinishFuncType = extern(C) bool function(GOutputStream* stream, GAsyncResult* result, GError** _err);

  @property CloseFinishFuncType closeFinish()
  {
    return (cast(GOutputStreamClass*)cPtr).closeFinish;
  }

  alias WritevFnFuncType = extern(C) bool function(GOutputStream* stream, const(GOutputVector)* vectors, size_t nVectors, size_t* bytesWritten, GCancellable* cancellable, GError** _err);

  @property WritevFnFuncType writevFn()
  {
    return (cast(GOutputStreamClass*)cPtr).writevFn;
  }

  alias WritevAsyncFuncType = extern(C) void function(GOutputStream* stream, const(GOutputVector)* vectors, size_t nVectors, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property WritevAsyncFuncType writevAsync()
  {
    return (cast(GOutputStreamClass*)cPtr).writevAsync;
  }

  alias WritevFinishFuncType = extern(C) bool function(GOutputStream* stream, GAsyncResult* result, size_t* bytesWritten, GError** _err);

  @property WritevFinishFuncType writevFinish()
  {
    return (cast(GOutputStreamClass*)cPtr).writevFinish;
  }
}
