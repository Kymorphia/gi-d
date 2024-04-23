module Gio.FileInputStreamClass;

import GLib.Types;
import GLib.c.functions;
import Gid.Gid;
import Gio.AsyncResult;
import Gio.Cancellable;
import Gio.FileInfo;
import Gio.FileInputStream;
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
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GFileInputStreamClass))
  {
    return cast(T*)&cInstance;
  }

  @property InputStreamClass parentClass()
  {
    return new InputStreamClass(cast(GInputStreamClass*)&cPtr!GFileInputStreamClass.parentClass);
  }

  alias TellFuncType = extern(C) long function(GFileInputStream* stream);

  @property TellFuncType tell()
  {
    return cPtr!GFileInputStreamClass.tell;
  }

  alias CanSeekFuncType = extern(C) bool function(GFileInputStream* stream);

  @property CanSeekFuncType canSeek()
  {
    return cPtr!GFileInputStreamClass.canSeek;
  }

  alias SeekFuncType = extern(C) bool function(GFileInputStream* stream, long offset, GSeekType type, GCancellable* cancellable, GError** _err);

  @property SeekFuncType seek()
  {
    return cPtr!GFileInputStreamClass.seek;
  }

  alias QueryInfoFuncType = extern(C) GFileInfo* function(GFileInputStream* stream, const(char)* attributes, GCancellable* cancellable, GError** _err);

  @property QueryInfoFuncType queryInfo()
  {
    return cPtr!GFileInputStreamClass.queryInfo;
  }

  alias QueryInfoAsyncFuncType = extern(C) void function(GFileInputStream* stream, const(char)* attributes, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property QueryInfoAsyncFuncType queryInfoAsync()
  {
    return cPtr!GFileInputStreamClass.queryInfoAsync;
  }

  alias QueryInfoFinishFuncType = extern(C) GFileInfo* function(GFileInputStream* stream, GAsyncResult* result, GError** _err);

  @property QueryInfoFinishFuncType queryInfoFinish()
  {
    return cPtr!GFileInputStreamClass.queryInfoFinish;
  }
}
