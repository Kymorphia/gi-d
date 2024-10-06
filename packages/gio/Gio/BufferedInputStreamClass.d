module Gio.BufferedInputStreamClass;

import Gid.gid;
import Gio.FilterInputStreamClass;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

class BufferedInputStreamClass
{
  GBufferedInputStreamClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.BufferedInputStreamClass");

    cInstance = *cast(GBufferedInputStreamClass*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property FilterInputStreamClass parentClass()
  {
    return new FilterInputStreamClass(cast(GFilterInputStreamClass*)&(cast(GBufferedInputStreamClass*)cPtr).parentClass);
  }

  alias FillFuncType = extern(C) ptrdiff_t function(GBufferedInputStream* stream, ptrdiff_t count, GCancellable* cancellable, GError** _err);

  @property FillFuncType fill()
  {
    return (cast(GBufferedInputStreamClass*)cPtr).fill;
  }

  alias FillAsyncFuncType = extern(C) void function(GBufferedInputStream* stream, ptrdiff_t count, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property FillAsyncFuncType fillAsync()
  {
    return (cast(GBufferedInputStreamClass*)cPtr).fillAsync;
  }

  alias FillFinishFuncType = extern(C) ptrdiff_t function(GBufferedInputStream* stream, GAsyncResult* result, GError** _err);

  @property FillFinishFuncType fillFinish()
  {
    return (cast(GBufferedInputStreamClass*)cPtr).fillFinish;
  }
}
