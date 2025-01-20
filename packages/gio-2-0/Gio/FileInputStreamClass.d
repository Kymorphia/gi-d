module Gio.FileInputStreamClass;

import Gid.gid;
import Gio.InputStreamClass;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

class FileInputStreamClass
{
  GFileInputStreamClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.FileInputStreamClass");

    cInstance = *cast(GFileInputStreamClass*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property InputStreamClass parentClass()
  {
    return new InputStreamClass(cast(GInputStreamClass*)&(cast(GFileInputStreamClass*)cPtr).parentClass);
  }

  alias TellFuncType = extern(C) long function(GFileInputStream* stream);

  @property TellFuncType tell()
  {
    return (cast(GFileInputStreamClass*)cPtr).tell;
  }

  alias CanSeekFuncType = extern(C) bool function(GFileInputStream* stream);

  @property CanSeekFuncType canSeek()
  {
    return (cast(GFileInputStreamClass*)cPtr).canSeek;
  }

  alias SeekFuncType = extern(C) bool function(GFileInputStream* stream, long offset, GSeekType type, GCancellable* cancellable, GError** _err);

  @property SeekFuncType seek()
  {
    return (cast(GFileInputStreamClass*)cPtr).seek;
  }

  alias QueryInfoFuncType = extern(C) GFileInfo* function(GFileInputStream* stream, const(char)* attributes, GCancellable* cancellable, GError** _err);

  @property QueryInfoFuncType queryInfo()
  {
    return (cast(GFileInputStreamClass*)cPtr).queryInfo;
  }

  alias QueryInfoAsyncFuncType = extern(C) void function(GFileInputStream* stream, const(char)* attributes, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property QueryInfoAsyncFuncType queryInfoAsync()
  {
    return (cast(GFileInputStreamClass*)cPtr).queryInfoAsync;
  }

  alias QueryInfoFinishFuncType = extern(C) GFileInfo* function(GFileInputStream* stream, GAsyncResult* result, GError** _err);

  @property QueryInfoFinishFuncType queryInfoFinish()
  {
    return (cast(GFileInputStreamClass*)cPtr).queryInfoFinish;
  }
}
