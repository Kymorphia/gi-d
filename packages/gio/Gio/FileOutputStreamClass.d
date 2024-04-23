module Gio.FileOutputStreamClass;

import GLib.Types;
import GLib.c.functions;
import Gid.Gid;
import Gio.AsyncResult;
import Gio.Cancellable;
import Gio.FileInfo;
import Gio.FileOutputStream;
import Gio.OutputStreamClass;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

class FileOutputStreamClass
{
  GFileOutputStreamClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.FileOutputStreamClass");

    cInstance = *cast(GFileOutputStreamClass*)ptr;

    if (ownedRef)
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GFileOutputStreamClass))
  {
    return cast(T*)&cInstance;
  }

  @property OutputStreamClass parentClass()
  {
    return new OutputStreamClass(cast(GOutputStreamClass*)&cPtr!GFileOutputStreamClass.parentClass);
  }

  alias TellFuncType = extern(C) long function(GFileOutputStream* stream);

  @property TellFuncType tell()
  {
    return cPtr!GFileOutputStreamClass.tell;
  }

  alias CanSeekFuncType = extern(C) bool function(GFileOutputStream* stream);

  @property CanSeekFuncType canSeek()
  {
    return cPtr!GFileOutputStreamClass.canSeek;
  }

  alias SeekFuncType = extern(C) bool function(GFileOutputStream* stream, long offset, GSeekType type, GCancellable* cancellable, GError** _err);

  @property SeekFuncType seek()
  {
    return cPtr!GFileOutputStreamClass.seek;
  }

  alias CanTruncateFuncType = extern(C) bool function(GFileOutputStream* stream);

  @property CanTruncateFuncType canTruncate()
  {
    return cPtr!GFileOutputStreamClass.canTruncate;
  }

  alias TruncateFnFuncType = extern(C) bool function(GFileOutputStream* stream, long size, GCancellable* cancellable, GError** _err);

  @property TruncateFnFuncType truncateFn()
  {
    return cPtr!GFileOutputStreamClass.truncateFn;
  }

  alias QueryInfoFuncType = extern(C) GFileInfo* function(GFileOutputStream* stream, const(char)* attributes, GCancellable* cancellable, GError** _err);

  @property QueryInfoFuncType queryInfo()
  {
    return cPtr!GFileOutputStreamClass.queryInfo;
  }

  alias QueryInfoAsyncFuncType = extern(C) void function(GFileOutputStream* stream, const(char)* attributes, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property QueryInfoAsyncFuncType queryInfoAsync()
  {
    return cPtr!GFileOutputStreamClass.queryInfoAsync;
  }

  alias QueryInfoFinishFuncType = extern(C) GFileInfo* function(GFileOutputStream* stream, GAsyncResult* result, GError** _err);

  @property QueryInfoFinishFuncType queryInfoFinish()
  {
    return cPtr!GFileOutputStreamClass.queryInfoFinish;
  }

  alias GetEtagFuncType = extern(C) char* function(GFileOutputStream* stream);

  @property GetEtagFuncType getEtag()
  {
    return cPtr!GFileOutputStreamClass.getEtag;
  }
}
