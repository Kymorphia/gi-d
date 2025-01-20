module Gio.FileIOStreamClass;

import Gid.gid;
import Gio.IOStreamClass;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

class FileIOStreamClass
{
  GFileIOStreamClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.FileIOStreamClass");

    cInstance = *cast(GFileIOStreamClass*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property IOStreamClass parentClass()
  {
    return new IOStreamClass(cast(GIOStreamClass*)&(cast(GFileIOStreamClass*)cPtr).parentClass);
  }

  alias TellFuncType = extern(C) long function(GFileIOStream* stream);

  @property TellFuncType tell()
  {
    return (cast(GFileIOStreamClass*)cPtr).tell;
  }

  alias CanSeekFuncType = extern(C) bool function(GFileIOStream* stream);

  @property CanSeekFuncType canSeek()
  {
    return (cast(GFileIOStreamClass*)cPtr).canSeek;
  }

  alias SeekFuncType = extern(C) bool function(GFileIOStream* stream, long offset, GSeekType type, GCancellable* cancellable, GError** _err);

  @property SeekFuncType seek()
  {
    return (cast(GFileIOStreamClass*)cPtr).seek;
  }

  alias CanTruncateFuncType = extern(C) bool function(GFileIOStream* stream);

  @property CanTruncateFuncType canTruncate()
  {
    return (cast(GFileIOStreamClass*)cPtr).canTruncate;
  }

  alias TruncateFnFuncType = extern(C) bool function(GFileIOStream* stream, long size, GCancellable* cancellable, GError** _err);

  @property TruncateFnFuncType truncateFn()
  {
    return (cast(GFileIOStreamClass*)cPtr).truncateFn;
  }

  alias QueryInfoFuncType = extern(C) GFileInfo* function(GFileIOStream* stream, const(char)* attributes, GCancellable* cancellable, GError** _err);

  @property QueryInfoFuncType queryInfo()
  {
    return (cast(GFileIOStreamClass*)cPtr).queryInfo;
  }

  alias QueryInfoAsyncFuncType = extern(C) void function(GFileIOStream* stream, const(char)* attributes, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property QueryInfoAsyncFuncType queryInfoAsync()
  {
    return (cast(GFileIOStreamClass*)cPtr).queryInfoAsync;
  }

  alias QueryInfoFinishFuncType = extern(C) GFileInfo* function(GFileIOStream* stream, GAsyncResult* result, GError** _err);

  @property QueryInfoFinishFuncType queryInfoFinish()
  {
    return (cast(GFileIOStreamClass*)cPtr).queryInfoFinish;
  }

  alias GetEtagFuncType = extern(C) char* function(GFileIOStream* stream);

  @property GetEtagFuncType getEtag()
  {
    return (cast(GFileIOStreamClass*)cPtr).getEtag;
  }
}
