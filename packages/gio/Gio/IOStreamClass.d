module Gio.IOStreamClass;

import GLib.c.functions;
import GObject.ObjectClass;
import GObject.Types;
import Gid.Gid;
import Gio.AsyncResult;
import Gio.Cancellable;
import Gio.IOStream;
import Gio.InputStream;
import Gio.OutputStream;
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
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GIOStreamClass))
  {
    return cast(T*)&cInstance;
  }

  @property ObjectClass parentClass()
  {
    return new ObjectClass(cast(GObjectClass*)&cPtr!GIOStreamClass.parentClass);
  }

  alias GetInputStreamFuncType = extern(C) GInputStream* function(GIOStream* stream);

  @property GetInputStreamFuncType getInputStream()
  {
    return cPtr!GIOStreamClass.getInputStream;
  }

  alias GetOutputStreamFuncType = extern(C) GOutputStream* function(GIOStream* stream);

  @property GetOutputStreamFuncType getOutputStream()
  {
    return cPtr!GIOStreamClass.getOutputStream;
  }

  alias CloseFnFuncType = extern(C) bool function(GIOStream* stream, GCancellable* cancellable, GError** _err);

  @property CloseFnFuncType closeFn()
  {
    return cPtr!GIOStreamClass.closeFn;
  }

  alias CloseAsyncFuncType = extern(C) void function(GIOStream* stream, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property CloseAsyncFuncType closeAsync()
  {
    return cPtr!GIOStreamClass.closeAsync;
  }

  alias CloseFinishFuncType = extern(C) bool function(GIOStream* stream, GAsyncResult* result, GError** _err);

  @property CloseFinishFuncType closeFinish()
  {
    return cPtr!GIOStreamClass.closeFinish;
  }
}
