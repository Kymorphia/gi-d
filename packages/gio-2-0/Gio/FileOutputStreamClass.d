module Gio.FileOutputStreamClass;

import Gid.gid;
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
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property OutputStreamClass parentClass()
  {
    return new OutputStreamClass(cast(GOutputStreamClass*)&(cast(GFileOutputStreamClass*)cPtr).parentClass);
  }

  alias TellFuncType = extern(C) long function(GFileOutputStream* stream);

  @property TellFuncType tell()
  {
    return (cast(GFileOutputStreamClass*)cPtr).tell;
  }

  alias CanSeekFuncType = extern(C) bool function(GFileOutputStream* stream);

  @property CanSeekFuncType canSeek()
  {
    return (cast(GFileOutputStreamClass*)cPtr).canSeek;
  }

  alias SeekFuncType = extern(C) bool function(GFileOutputStream* stream, long offset, GSeekType type, GCancellable* cancellable, GError** _err);

  @property SeekFuncType seek()
  {
    return (cast(GFileOutputStreamClass*)cPtr).seek;
  }

  alias CanTruncateFuncType = extern(C) bool function(GFileOutputStream* stream);

  @property CanTruncateFuncType canTruncate()
  {
    return (cast(GFileOutputStreamClass*)cPtr).canTruncate;
  }

  alias TruncateFnFuncType = extern(C) bool function(GFileOutputStream* stream, long size, GCancellable* cancellable, GError** _err);

  @property TruncateFnFuncType truncateFn()
  {
    return (cast(GFileOutputStreamClass*)cPtr).truncateFn;
  }

  alias QueryInfoFuncType = extern(C) GFileInfo* function(GFileOutputStream* stream, const(char)* attributes, GCancellable* cancellable, GError** _err);

  @property QueryInfoFuncType queryInfo()
  {
    return (cast(GFileOutputStreamClass*)cPtr).queryInfo;
  }

  alias QueryInfoAsyncFuncType = extern(C) void function(GFileOutputStream* stream, const(char)* attributes, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property QueryInfoAsyncFuncType queryInfoAsync()
  {
    return (cast(GFileOutputStreamClass*)cPtr).queryInfoAsync;
  }

  alias QueryInfoFinishFuncType = extern(C) GFileInfo* function(GFileOutputStream* stream, GAsyncResult* result, GError** _err);

  @property QueryInfoFinishFuncType queryInfoFinish()
  {
    return (cast(GFileOutputStreamClass*)cPtr).queryInfoFinish;
  }

  alias GetEtagFuncType = extern(C) char* function(GFileOutputStream* stream);

  @property GetEtagFuncType getEtag()
  {
    return (cast(GFileOutputStreamClass*)cPtr).getEtag;
  }
}
