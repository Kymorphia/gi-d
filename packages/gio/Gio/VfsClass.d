module Gio.VfsClass;

import GLib.Types;
import GLib.c.functions;
import GObject.ObjectClass;
import GObject.Types;
import Gid.Gid;
import Gio.Cancellable;
import Gio.File;
import Gio.FileAttributeInfoList;
import Gio.FileAttributeMatcher;
import Gio.FileInfo;
import Gio.Types;
import Gio.Vfs;
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
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GVfsClass))
  {
    return cast(T*)&cInstance;
  }

  @property ObjectClass parentClass()
  {
    return new ObjectClass(cast(GObjectClass*)&cPtr!GVfsClass.parentClass);
  }

  alias IsActiveFuncType = extern(C) bool function(GVfs* vfs);

  @property IsActiveFuncType isActive()
  {
    return cPtr!GVfsClass.isActive;
  }

  alias GetFileForPathFuncType = extern(C) GFile* function(GVfs* vfs, const(char)* path);

  @property GetFileForPathFuncType getFileForPath()
  {
    return cPtr!GVfsClass.getFileForPath;
  }

  alias GetFileForUriFuncType = extern(C) GFile* function(GVfs* vfs, const(char)* uri);

  @property GetFileForUriFuncType getFileForUri()
  {
    return cPtr!GVfsClass.getFileForUri;
  }

  alias GetSupportedUriSchemesFuncType = extern(C) const(char*)* function(GVfs* vfs);

  @property GetSupportedUriSchemesFuncType getSupportedUriSchemes()
  {
    return cPtr!GVfsClass.getSupportedUriSchemes;
  }

  alias ParseNameFuncType = extern(C) GFile* function(GVfs* vfs, const(char)* parseName);

  @property ParseNameFuncType parseName()
  {
    return cPtr!GVfsClass.parseName;
  }

  alias LocalFileAddInfoFuncType = extern(C) void function(GVfs* vfs, const(char)* filename, ulong device, GFileAttributeMatcher* attributeMatcher, GFileInfo* info, GCancellable* cancellable, void** extraData, GDestroyNotify* freeExtraData);

  @property LocalFileAddInfoFuncType localFileAddInfo()
  {
    return cPtr!GVfsClass.localFileAddInfo;
  }

  alias AddWritableNamespacesFuncType = extern(C) void function(GVfs* vfs, GFileAttributeInfoList* list);

  @property AddWritableNamespacesFuncType addWritableNamespaces()
  {
    return cPtr!GVfsClass.addWritableNamespaces;
  }

  alias LocalFileSetAttributesFuncType = extern(C) bool function(GVfs* vfs, const(char)* filename, GFileInfo* info, GFileQueryInfoFlags flags, GCancellable* cancellable, GError** _err);

  @property LocalFileSetAttributesFuncType localFileSetAttributes()
  {
    return cPtr!GVfsClass.localFileSetAttributes;
  }

  alias LocalFileRemovedFuncType = extern(C) void function(GVfs* vfs, const(char)* filename);

  @property LocalFileRemovedFuncType localFileRemoved()
  {
    return cPtr!GVfsClass.localFileRemoved;
  }

  alias LocalFileMovedFuncType = extern(C) void function(GVfs* vfs, const(char)* source, const(char)* dest);

  @property LocalFileMovedFuncType localFileMoved()
  {
    return cPtr!GVfsClass.localFileMoved;
  }
}
