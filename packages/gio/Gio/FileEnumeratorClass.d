module Gio.FileEnumeratorClass;

import GObject.ObjectClass;
import Gid.gid;
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
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property ObjectClass parentClass()
  {
    return new ObjectClass(cast(GObjectClass*)&(cast(GFileEnumeratorClass*)cPtr).parentClass);
  }

  alias NextFileFuncType = extern(C) GFileInfo* function(GFileEnumerator* enumerator, GCancellable* cancellable, GError** _err);

  @property NextFileFuncType nextFile()
  {
    return (cast(GFileEnumeratorClass*)cPtr).nextFile;
  }

  alias CloseFnFuncType = extern(C) bool function(GFileEnumerator* enumerator, GCancellable* cancellable, GError** _err);

  @property CloseFnFuncType closeFn()
  {
    return (cast(GFileEnumeratorClass*)cPtr).closeFn;
  }

  alias NextFilesAsyncFuncType = extern(C) void function(GFileEnumerator* enumerator, int numFiles, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property NextFilesAsyncFuncType nextFilesAsync()
  {
    return (cast(GFileEnumeratorClass*)cPtr).nextFilesAsync;
  }

  alias NextFilesFinishFuncType = extern(C) GList* function(GFileEnumerator* enumerator, GAsyncResult* result, GError** _err);

  @property NextFilesFinishFuncType nextFilesFinish()
  {
    return (cast(GFileEnumeratorClass*)cPtr).nextFilesFinish;
  }

  alias CloseAsyncFuncType = extern(C) void function(GFileEnumerator* enumerator, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property CloseAsyncFuncType closeAsync()
  {
    return (cast(GFileEnumeratorClass*)cPtr).closeAsync;
  }

  alias CloseFinishFuncType = extern(C) bool function(GFileEnumerator* enumerator, GAsyncResult* result, GError** _err);

  @property CloseFinishFuncType closeFinish()
  {
    return (cast(GFileEnumeratorClass*)cPtr).closeFinish;
  }
}
