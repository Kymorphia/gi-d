module Gio.VfsClass;

import GObject.ObjectClass;
import Gid.gid;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

class VfsClass
{
  GVfsClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.VfsClass");

    cInstance = *cast(GVfsClass*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property ObjectClass parentClass()
  {
    return new ObjectClass(cast(GObjectClass*)&(cast(GVfsClass*)cPtr).parentClass);
  }

  alias IsActiveFuncType = extern(C) bool function(GVfs* vfs);

  @property IsActiveFuncType isActive()
  {
    return (cast(GVfsClass*)cPtr).isActive;
  }

  alias GetFileForPathFuncType = extern(C) GFile* function(GVfs* vfs, const(char)* path);

  @property GetFileForPathFuncType getFileForPath()
  {
    return (cast(GVfsClass*)cPtr).getFileForPath;
  }

  alias GetFileForUriFuncType = extern(C) GFile* function(GVfs* vfs, const(char)* uri);

  @property GetFileForUriFuncType getFileForUri()
  {
    return (cast(GVfsClass*)cPtr).getFileForUri;
  }

  alias GetSupportedUriSchemesFuncType = extern(C) const(char*)* function(GVfs* vfs);

  @property GetSupportedUriSchemesFuncType getSupportedUriSchemes()
  {
    return (cast(GVfsClass*)cPtr).getSupportedUriSchemes;
  }

  alias ParseNameFuncType = extern(C) GFile* function(GVfs* vfs, const(char)* parseName);

  @property ParseNameFuncType parseName()
  {
    return (cast(GVfsClass*)cPtr).parseName;
  }

  alias LocalFileAddInfoFuncType = extern(C) void function(GVfs* vfs, const(char)* filename, ulong device, GFileAttributeMatcher* attributeMatcher, GFileInfo* info, GCancellable* cancellable, void** extraData, GDestroyNotify* freeExtraData);

  @property LocalFileAddInfoFuncType localFileAddInfo()
  {
    return (cast(GVfsClass*)cPtr).localFileAddInfo;
  }

  alias AddWritableNamespacesFuncType = extern(C) void function(GVfs* vfs, GFileAttributeInfoList* list);

  @property AddWritableNamespacesFuncType addWritableNamespaces()
  {
    return (cast(GVfsClass*)cPtr).addWritableNamespaces;
  }

  alias LocalFileSetAttributesFuncType = extern(C) bool function(GVfs* vfs, const(char)* filename, GFileInfo* info, GFileQueryInfoFlags flags, GCancellable* cancellable, GError** _err);

  @property LocalFileSetAttributesFuncType localFileSetAttributes()
  {
    return (cast(GVfsClass*)cPtr).localFileSetAttributes;
  }

  alias LocalFileRemovedFuncType = extern(C) void function(GVfs* vfs, const(char)* filename);

  @property LocalFileRemovedFuncType localFileRemoved()
  {
    return (cast(GVfsClass*)cPtr).localFileRemoved;
  }

  alias LocalFileMovedFuncType = extern(C) void function(GVfs* vfs, const(char)* source, const(char)* dest);

  @property LocalFileMovedFuncType localFileMoved()
  {
    return (cast(GVfsClass*)cPtr).localFileMoved;
  }
}
