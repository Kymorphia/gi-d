module Gio.FileIOStreamClass;

import GLib.Types;
import GLib.c.functions;
import Gid.Gid;
import Gio.AsyncResult;
import Gio.Cancellable;
import Gio.FileIOStream;
import Gio.FileInfo;
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
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GFileIOStreamClass))
  {
    return cast(T*)&cInstance;
  }

  @property IOStreamClass parentClass()
  {
    return new IOStreamClass(cast(GIOStreamClass*)&cPtr!GFileIOStreamClass.parentClass);
  }

  alias TellFuncType = extern(C) long function(GFileIOStream* stream);

  @property TellFuncType tell()
  {
    return cPtr!GFileIOStreamClass.tell;
  }

  alias CanSeekFuncType = extern(C) bool function(GFileIOStream* stream);

  @property CanSeekFuncType canSeek()
  {
    return cPtr!GFileIOStreamClass.canSeek;
  }

  alias SeekFuncType = extern(C) bool function(GFileIOStream* stream, long offset, GSeekType type, GCancellable* cancellable, GError** _err);

  @property SeekFuncType seek()
  {
    return cPtr!GFileIOStreamClass.seek;
  }

  alias CanTruncateFuncType = extern(C) bool function(GFileIOStream* stream);

  @property CanTruncateFuncType canTruncate()
  {
    return cPtr!GFileIOStreamClass.canTruncate;
  }

  alias TruncateFnFuncType = extern(C) bool function(GFileIOStream* stream, long size, GCancellable* cancellable, GError** _err);

  @property TruncateFnFuncType truncateFn()
  {
    return cPtr!GFileIOStreamClass.truncateFn;
  }

  alias QueryInfoFuncType = extern(C) GFileInfo* function(GFileIOStream* stream, const(char)* attributes, GCancellable* cancellable, GError** _err);

  @property QueryInfoFuncType queryInfo()
  {
    return cPtr!GFileIOStreamClass.queryInfo;
  }

  alias QueryInfoAsyncFuncType = extern(C) void function(GFileIOStream* stream, const(char)* attributes, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property QueryInfoAsyncFuncType queryInfoAsync()
  {
    return cPtr!GFileIOStreamClass.queryInfoAsync;
  }

  alias QueryInfoFinishFuncType = extern(C) GFileInfo* function(GFileIOStream* stream, GAsyncResult* result, GError** _err);

  @property QueryInfoFinishFuncType queryInfoFinish()
  {
    return cPtr!GFileIOStreamClass.queryInfoFinish;
  }

  alias GetEtagFuncType = extern(C) char* function(GFileIOStream* stream);

  @property GetEtagFuncType getEtag()
  {
    return cPtr!GFileIOStreamClass.getEtag;
  }
}
