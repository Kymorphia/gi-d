module Gio.FileEnumeratorClass;

import GLib.List;
import GLib.Types;
import GLib.c.functions;
import GObject.ObjectClass;
import GObject.Types;
import Gid.Gid;
import Gio.AsyncResult;
import Gio.Cancellable;
import Gio.FileEnumerator;
import Gio.FileInfo;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

class FileEnumeratorClass
{
  GFileEnumeratorClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.FileEnumeratorClass");

    cInstance = *cast(GFileEnumeratorClass*)ptr;

    if (ownedRef)
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GFileEnumeratorClass))
  {
    return cast(T*)&cInstance;
  }

  @property ObjectClass parentClass()
  {
    return new ObjectClass(cast(GObjectClass*)&cPtr!GFileEnumeratorClass.parentClass);
  }

  alias NextFileFuncType = extern(C) GFileInfo* function(GFileEnumerator* enumerator, GCancellable* cancellable, GError** _err);

  @property NextFileFuncType nextFile()
  {
    return cPtr!GFileEnumeratorClass.nextFile;
  }

  alias CloseFnFuncType = extern(C) bool function(GFileEnumerator* enumerator, GCancellable* cancellable, GError** _err);

  @property CloseFnFuncType closeFn()
  {
    return cPtr!GFileEnumeratorClass.closeFn;
  }

  alias NextFilesAsyncFuncType = extern(C) void function(GFileEnumerator* enumerator, int numFiles, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property NextFilesAsyncFuncType nextFilesAsync()
  {
    return cPtr!GFileEnumeratorClass.nextFilesAsync;
  }

  alias NextFilesFinishFuncType = extern(C) GList* function(GFileEnumerator* enumerator, GAsyncResult* result, GError** _err);

  @property NextFilesFinishFuncType nextFilesFinish()
  {
    return cPtr!GFileEnumeratorClass.nextFilesFinish;
  }

  alias CloseAsyncFuncType = extern(C) void function(GFileEnumerator* enumerator, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property CloseAsyncFuncType closeAsync()
  {
    return cPtr!GFileEnumeratorClass.closeAsync;
  }

  alias CloseFinishFuncType = extern(C) bool function(GFileEnumerator* enumerator, GAsyncResult* result, GError** _err);

  @property CloseFinishFuncType closeFinish()
  {
    return cPtr!GFileEnumeratorClass.closeFinish;
  }
}
