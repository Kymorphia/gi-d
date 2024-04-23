module Gio.BufferedInputStreamClass;

import GLib.c.functions;
import Gid.Gid;
import Gio.AsyncResult;
import Gio.BufferedInputStream;
import Gio.Cancellable;
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
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GBufferedInputStreamClass))
  {
    return cast(T*)&cInstance;
  }

  @property FilterInputStreamClass parentClass()
  {
    return new FilterInputStreamClass(cast(GFilterInputStreamClass*)&cPtr!GBufferedInputStreamClass.parentClass);
  }

  alias FillFuncType = extern(C) ptrdiff_t function(GBufferedInputStream* stream, ptrdiff_t count, GCancellable* cancellable, GError** _err);

  @property FillFuncType fill()
  {
    return cPtr!GBufferedInputStreamClass.fill;
  }

  alias FillAsyncFuncType = extern(C) void function(GBufferedInputStream* stream, ptrdiff_t count, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property FillAsyncFuncType fillAsync()
  {
    return cPtr!GBufferedInputStreamClass.fillAsync;
  }

  alias FillFinishFuncType = extern(C) ptrdiff_t function(GBufferedInputStream* stream, GAsyncResult* result, GError** _err);

  @property FillFinishFuncType fillFinish()
  {
    return cPtr!GBufferedInputStreamClass.fillFinish;
  }
}
