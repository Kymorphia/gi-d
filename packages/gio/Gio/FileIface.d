module Gio.FileIface;

import GObject.TypeInterface;
import Gid.gid;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * An interface for writing VFS file handles.
 */
class FileIface
{
  GFileIface cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.FileIface");

    cInstance = *cast(GFileIface*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property TypeInterface gIface()
  {
    return new TypeInterface(cast(GTypeInterface*)&(cast(GFileIface*)cPtr).gIface);
  }

  alias DupFuncType = extern(C) GFile* function(GFile* file);

  @property DupFuncType dup()
  {
    return (cast(GFileIface*)cPtr).dup;
  }

  alias HashFuncType = extern(C) uint function(GFile* file);

  @property HashFuncType hash()
  {
    return (cast(GFileIface*)cPtr).hash;
  }

  alias EqualFuncType = extern(C) bool function(GFile* file1, GFile* file2);

  @property EqualFuncType equal()
  {
    return (cast(GFileIface*)cPtr).equal;
  }

  alias IsNativeFuncType = extern(C) bool function(GFile* file);

  @property IsNativeFuncType isNative()
  {
    return (cast(GFileIface*)cPtr).isNative;
  }

  alias HasUriSchemeFuncType = extern(C) bool function(GFile* file, const(char)* uriScheme);

  @property HasUriSchemeFuncType hasUriScheme()
  {
    return (cast(GFileIface*)cPtr).hasUriScheme;
  }

  alias GetUriSchemeFuncType = extern(C) char* function(GFile* file);

  @property GetUriSchemeFuncType getUriScheme()
  {
    return (cast(GFileIface*)cPtr).getUriScheme;
  }

  alias GetBasenameFuncType = extern(C) char* function(GFile* file);

  @property GetBasenameFuncType getBasename()
  {
    return (cast(GFileIface*)cPtr).getBasename;
  }

  alias GetPathFuncType = extern(C) char* function(GFile* file);

  @property GetPathFuncType getPath()
  {
    return (cast(GFileIface*)cPtr).getPath;
  }

  alias GetUriFuncType = extern(C) char* function(GFile* file);

  @property GetUriFuncType getUri()
  {
    return (cast(GFileIface*)cPtr).getUri;
  }

  alias GetParseNameFuncType = extern(C) char* function(GFile* file);

  @property GetParseNameFuncType getParseName()
  {
    return (cast(GFileIface*)cPtr).getParseName;
  }

  alias GetParentFuncType = extern(C) GFile* function(GFile* file);

  @property GetParentFuncType getParent()
  {
    return (cast(GFileIface*)cPtr).getParent;
  }

  alias PrefixMatchesFuncType = extern(C) bool function(GFile* prefix, GFile* file);

  @property PrefixMatchesFuncType prefixMatches()
  {
    return (cast(GFileIface*)cPtr).prefixMatches;
  }

  alias GetRelativePathFuncType = extern(C) char* function(GFile* parent, GFile* descendant);

  @property GetRelativePathFuncType getRelativePath()
  {
    return (cast(GFileIface*)cPtr).getRelativePath;
  }

  alias ResolveRelativePathFuncType = extern(C) GFile* function(GFile* file, const(char)* relativePath);

  @property ResolveRelativePathFuncType resolveRelativePath()
  {
    return (cast(GFileIface*)cPtr).resolveRelativePath;
  }

  alias GetChildForDisplayNameFuncType = extern(C) GFile* function(GFile* file, const(char)* displayName, GError** _err);

  @property GetChildForDisplayNameFuncType getChildForDisplayName()
  {
    return (cast(GFileIface*)cPtr).getChildForDisplayName;
  }

  alias EnumerateChildrenFuncType = extern(C) GFileEnumerator* function(GFile* file, const(char)* attributes, GFileQueryInfoFlags flags, GCancellable* cancellable, GError** _err);

  @property EnumerateChildrenFuncType enumerateChildren()
  {
    return (cast(GFileIface*)cPtr).enumerateChildren;
  }

  alias EnumerateChildrenAsyncFuncType = extern(C) void function(GFile* file, const(char)* attributes, GFileQueryInfoFlags flags, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property EnumerateChildrenAsyncFuncType enumerateChildrenAsync()
  {
    return (cast(GFileIface*)cPtr).enumerateChildrenAsync;
  }

  alias EnumerateChildrenFinishFuncType = extern(C) GFileEnumerator* function(GFile* file, GAsyncResult* res, GError** _err);

  @property EnumerateChildrenFinishFuncType enumerateChildrenFinish()
  {
    return (cast(GFileIface*)cPtr).enumerateChildrenFinish;
  }

  alias QueryInfoFuncType = extern(C) GFileInfo* function(GFile* file, const(char)* attributes, GFileQueryInfoFlags flags, GCancellable* cancellable, GError** _err);

  @property QueryInfoFuncType queryInfo()
  {
    return (cast(GFileIface*)cPtr).queryInfo;
  }

  alias QueryInfoAsyncFuncType = extern(C) void function(GFile* file, const(char)* attributes, GFileQueryInfoFlags flags, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property QueryInfoAsyncFuncType queryInfoAsync()
  {
    return (cast(GFileIface*)cPtr).queryInfoAsync;
  }

  alias QueryInfoFinishFuncType = extern(C) GFileInfo* function(GFile* file, GAsyncResult* res, GError** _err);

  @property QueryInfoFinishFuncType queryInfoFinish()
  {
    return (cast(GFileIface*)cPtr).queryInfoFinish;
  }

  alias QueryFilesystemInfoFuncType = extern(C) GFileInfo* function(GFile* file, const(char)* attributes, GCancellable* cancellable, GError** _err);

  @property QueryFilesystemInfoFuncType queryFilesystemInfo()
  {
    return (cast(GFileIface*)cPtr).queryFilesystemInfo;
  }

  alias QueryFilesystemInfoAsyncFuncType = extern(C) void function(GFile* file, const(char)* attributes, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property QueryFilesystemInfoAsyncFuncType queryFilesystemInfoAsync()
  {
    return (cast(GFileIface*)cPtr).queryFilesystemInfoAsync;
  }

  alias QueryFilesystemInfoFinishFuncType = extern(C) GFileInfo* function(GFile* file, GAsyncResult* res, GError** _err);

  @property QueryFilesystemInfoFinishFuncType queryFilesystemInfoFinish()
  {
    return (cast(GFileIface*)cPtr).queryFilesystemInfoFinish;
  }

  alias FindEnclosingMountFuncType = extern(C) GMount* function(GFile* file, GCancellable* cancellable, GError** _err);

  @property FindEnclosingMountFuncType findEnclosingMount()
  {
    return (cast(GFileIface*)cPtr).findEnclosingMount;
  }

  alias FindEnclosingMountAsyncFuncType = extern(C) void function(GFile* file, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property FindEnclosingMountAsyncFuncType findEnclosingMountAsync()
  {
    return (cast(GFileIface*)cPtr).findEnclosingMountAsync;
  }

  alias FindEnclosingMountFinishFuncType = extern(C) GMount* function(GFile* file, GAsyncResult* res, GError** _err);

  @property FindEnclosingMountFinishFuncType findEnclosingMountFinish()
  {
    return (cast(GFileIface*)cPtr).findEnclosingMountFinish;
  }

  alias SetDisplayNameFuncType = extern(C) GFile* function(GFile* file, const(char)* displayName, GCancellable* cancellable, GError** _err);

  @property SetDisplayNameFuncType setDisplayName()
  {
    return (cast(GFileIface*)cPtr).setDisplayName;
  }

  alias SetDisplayNameAsyncFuncType = extern(C) void function(GFile* file, const(char)* displayName, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property SetDisplayNameAsyncFuncType setDisplayNameAsync()
  {
    return (cast(GFileIface*)cPtr).setDisplayNameAsync;
  }

  alias SetDisplayNameFinishFuncType = extern(C) GFile* function(GFile* file, GAsyncResult* res, GError** _err);

  @property SetDisplayNameFinishFuncType setDisplayNameFinish()
  {
    return (cast(GFileIface*)cPtr).setDisplayNameFinish;
  }

  alias QuerySettableAttributesFuncType = extern(C) GFileAttributeInfoList* function(GFile* file, GCancellable* cancellable, GError** _err);

  @property QuerySettableAttributesFuncType querySettableAttributes()
  {
    return (cast(GFileIface*)cPtr).querySettableAttributes;
  }

  alias QuerySettableAttributesAsyncFuncType = extern(C) void function();

  @property QuerySettableAttributesAsyncFuncType QuerySettableAttributesAsync()
  {
    return (cast(GFileIface*)cPtr).QuerySettableAttributesAsync;
  }

  alias QuerySettableAttributesFinishFuncType = extern(C) void function();

  @property QuerySettableAttributesFinishFuncType QuerySettableAttributesFinish()
  {
    return (cast(GFileIface*)cPtr).QuerySettableAttributesFinish;
  }

  alias QueryWritableNamespacesFuncType = extern(C) GFileAttributeInfoList* function(GFile* file, GCancellable* cancellable, GError** _err);

  @property QueryWritableNamespacesFuncType queryWritableNamespaces()
  {
    return (cast(GFileIface*)cPtr).queryWritableNamespaces;
  }

  alias QueryWritableNamespacesAsyncFuncType = extern(C) void function();

  @property QueryWritableNamespacesAsyncFuncType QueryWritableNamespacesAsync()
  {
    return (cast(GFileIface*)cPtr).QueryWritableNamespacesAsync;
  }

  alias QueryWritableNamespacesFinishFuncType = extern(C) void function();

  @property QueryWritableNamespacesFinishFuncType QueryWritableNamespacesFinish()
  {
    return (cast(GFileIface*)cPtr).QueryWritableNamespacesFinish;
  }

  alias SetAttributeFuncType = extern(C) bool function(GFile* file, const(char)* attribute, GFileAttributeType type, void* valueP, GFileQueryInfoFlags flags, GCancellable* cancellable, GError** _err);

  @property SetAttributeFuncType setAttribute()
  {
    return (cast(GFileIface*)cPtr).setAttribute;
  }

  alias SetAttributesFromInfoFuncType = extern(C) bool function(GFile* file, GFileInfo* info, GFileQueryInfoFlags flags, GCancellable* cancellable, GError** _err);

  @property SetAttributesFromInfoFuncType setAttributesFromInfo()
  {
    return (cast(GFileIface*)cPtr).setAttributesFromInfo;
  }

  alias SetAttributesAsyncFuncType = extern(C) void function(GFile* file, GFileInfo* info, GFileQueryInfoFlags flags, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property SetAttributesAsyncFuncType setAttributesAsync()
  {
    return (cast(GFileIface*)cPtr).setAttributesAsync;
  }

  alias SetAttributesFinishFuncType = extern(C) bool function(GFile* file, GAsyncResult* result, GFileInfo** info, GError** _err);

  @property SetAttributesFinishFuncType setAttributesFinish()
  {
    return (cast(GFileIface*)cPtr).setAttributesFinish;
  }

  alias ReadFnFuncType = extern(C) GFileInputStream* function(GFile* file, GCancellable* cancellable, GError** _err);

  @property ReadFnFuncType readFn()
  {
    return (cast(GFileIface*)cPtr).readFn;
  }

  alias ReadAsyncFuncType = extern(C) void function(GFile* file, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property ReadAsyncFuncType readAsync()
  {
    return (cast(GFileIface*)cPtr).readAsync;
  }

  alias ReadFinishFuncType = extern(C) GFileInputStream* function(GFile* file, GAsyncResult* res, GError** _err);

  @property ReadFinishFuncType readFinish()
  {
    return (cast(GFileIface*)cPtr).readFinish;
  }

  alias AppendToFuncType = extern(C) GFileOutputStream* function(GFile* file, GFileCreateFlags flags, GCancellable* cancellable, GError** _err);

  @property AppendToFuncType appendTo()
  {
    return (cast(GFileIface*)cPtr).appendTo;
  }

  alias AppendToAsyncFuncType = extern(C) void function(GFile* file, GFileCreateFlags flags, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property AppendToAsyncFuncType appendToAsync()
  {
    return (cast(GFileIface*)cPtr).appendToAsync;
  }

  alias AppendToFinishFuncType = extern(C) GFileOutputStream* function(GFile* file, GAsyncResult* res, GError** _err);

  @property AppendToFinishFuncType appendToFinish()
  {
    return (cast(GFileIface*)cPtr).appendToFinish;
  }

  alias CreateFuncType = extern(C) GFileOutputStream* function(GFile* file, GFileCreateFlags flags, GCancellable* cancellable, GError** _err);

  @property CreateFuncType create()
  {
    return (cast(GFileIface*)cPtr).create;
  }

  alias CreateAsyncFuncType = extern(C) void function(GFile* file, GFileCreateFlags flags, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property CreateAsyncFuncType createAsync()
  {
    return (cast(GFileIface*)cPtr).createAsync;
  }

  alias CreateFinishFuncType = extern(C) GFileOutputStream* function(GFile* file, GAsyncResult* res, GError** _err);

  @property CreateFinishFuncType createFinish()
  {
    return (cast(GFileIface*)cPtr).createFinish;
  }

  alias ReplaceFuncType = extern(C) GFileOutputStream* function(GFile* file, const(char)* etag, bool makeBackup, GFileCreateFlags flags, GCancellable* cancellable, GError** _err);

  @property ReplaceFuncType replace()
  {
    return (cast(GFileIface*)cPtr).replace;
  }

  alias ReplaceAsyncFuncType = extern(C) void function(GFile* file, const(char)* etag, bool makeBackup, GFileCreateFlags flags, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property ReplaceAsyncFuncType replaceAsync()
  {
    return (cast(GFileIface*)cPtr).replaceAsync;
  }

  alias ReplaceFinishFuncType = extern(C) GFileOutputStream* function(GFile* file, GAsyncResult* res, GError** _err);

  @property ReplaceFinishFuncType replaceFinish()
  {
    return (cast(GFileIface*)cPtr).replaceFinish;
  }

  alias DeleteFileFuncType = extern(C) bool function(GFile* file, GCancellable* cancellable, GError** _err);

  @property DeleteFileFuncType deleteFile()
  {
    return (cast(GFileIface*)cPtr).deleteFile;
  }

  alias DeleteFileAsyncFuncType = extern(C) void function(GFile* file, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property DeleteFileAsyncFuncType deleteFileAsync()
  {
    return (cast(GFileIface*)cPtr).deleteFileAsync;
  }

  alias DeleteFileFinishFuncType = extern(C) bool function(GFile* file, GAsyncResult* result, GError** _err);

  @property DeleteFileFinishFuncType deleteFileFinish()
  {
    return (cast(GFileIface*)cPtr).deleteFileFinish;
  }

  alias TrashFuncType = extern(C) bool function(GFile* file, GCancellable* cancellable, GError** _err);

  @property TrashFuncType trash()
  {
    return (cast(GFileIface*)cPtr).trash;
  }

  alias TrashAsyncFuncType = extern(C) void function(GFile* file, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property TrashAsyncFuncType trashAsync()
  {
    return (cast(GFileIface*)cPtr).trashAsync;
  }

  alias TrashFinishFuncType = extern(C) bool function(GFile* file, GAsyncResult* result, GError** _err);

  @property TrashFinishFuncType trashFinish()
  {
    return (cast(GFileIface*)cPtr).trashFinish;
  }

  alias MakeDirectoryFuncType = extern(C) bool function(GFile* file, GCancellable* cancellable, GError** _err);

  @property MakeDirectoryFuncType makeDirectory()
  {
    return (cast(GFileIface*)cPtr).makeDirectory;
  }

  alias MakeDirectoryAsyncFuncType = extern(C) void function(GFile* file, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property MakeDirectoryAsyncFuncType makeDirectoryAsync()
  {
    return (cast(GFileIface*)cPtr).makeDirectoryAsync;
  }

  alias MakeDirectoryFinishFuncType = extern(C) bool function(GFile* file, GAsyncResult* result, GError** _err);

  @property MakeDirectoryFinishFuncType makeDirectoryFinish()
  {
    return (cast(GFileIface*)cPtr).makeDirectoryFinish;
  }

  alias MakeSymbolicLinkFuncType = extern(C) bool function(GFile* file, const(char)* symlinkValue, GCancellable* cancellable, GError** _err);

  @property MakeSymbolicLinkFuncType makeSymbolicLink()
  {
    return (cast(GFileIface*)cPtr).makeSymbolicLink;
  }

  alias MakeSymbolicLinkAsyncFuncType = extern(C) void function(GFile* file, const(char)* symlinkValue, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property MakeSymbolicLinkAsyncFuncType makeSymbolicLinkAsync()
  {
    return (cast(GFileIface*)cPtr).makeSymbolicLinkAsync;
  }

  alias MakeSymbolicLinkFinishFuncType = extern(C) bool function(GFile* file, GAsyncResult* result, GError** _err);

  @property MakeSymbolicLinkFinishFuncType makeSymbolicLinkFinish()
  {
    return (cast(GFileIface*)cPtr).makeSymbolicLinkFinish;
  }

  alias CopyFuncType = extern(C) bool function(GFile* source, GFile* destination, GFileCopyFlags flags, GCancellable* cancellable, GFileProgressCallback progressCallback, void* progressCallbackData, GError** _err);

  @property CopyFuncType copy()
  {
    return (cast(GFileIface*)cPtr).copy;
  }

  alias CopyAsyncFuncType = extern(C) void function(GFile* source, GFile* destination, GFileCopyFlags flags, int ioPriority, GCancellable* cancellable, GFileProgressCallback progressCallback, void* progressCallbackData, GAsyncReadyCallback callback, void* userData);

  @property CopyAsyncFuncType copyAsync()
  {
    return (cast(GFileIface*)cPtr).copyAsync;
  }

  alias CopyFinishFuncType = extern(C) bool function(GFile* file, GAsyncResult* res, GError** _err);

  @property CopyFinishFuncType copyFinish()
  {
    return (cast(GFileIface*)cPtr).copyFinish;
  }

  alias MoveFuncType = extern(C) bool function(GFile* source, GFile* destination, GFileCopyFlags flags, GCancellable* cancellable, GFileProgressCallback progressCallback, void* progressCallbackData, GError** _err);

  @property MoveFuncType move()
  {
    return (cast(GFileIface*)cPtr).move;
  }

  alias MoveAsyncFuncType = extern(C) void function(GFile* source, GFile* destination, GFileCopyFlags flags, int ioPriority, GCancellable* cancellable, GFileProgressCallback progressCallback, void* progressCallbackData, GAsyncReadyCallback callback, void* userData);

  @property MoveAsyncFuncType moveAsync()
  {
    return (cast(GFileIface*)cPtr).moveAsync;
  }

  alias MoveFinishFuncType = extern(C) bool function(GFile* file, GAsyncResult* result, GError** _err);

  @property MoveFinishFuncType moveFinish()
  {
    return (cast(GFileIface*)cPtr).moveFinish;
  }

  alias MountMountableFuncType = extern(C) void function(GFile* file, GMountMountFlags flags, GMountOperation* mountOperation, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property MountMountableFuncType mountMountable()
  {
    return (cast(GFileIface*)cPtr).mountMountable;
  }

  alias MountMountableFinishFuncType = extern(C) GFile* function(GFile* file, GAsyncResult* result, GError** _err);

  @property MountMountableFinishFuncType mountMountableFinish()
  {
    return (cast(GFileIface*)cPtr).mountMountableFinish;
  }

  alias UnmountMountableFuncType = extern(C) void function(GFile* file, GMountUnmountFlags flags, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property UnmountMountableFuncType unmountMountable()
  {
    return (cast(GFileIface*)cPtr).unmountMountable;
  }

  alias UnmountMountableFinishFuncType = extern(C) bool function(GFile* file, GAsyncResult* result, GError** _err);

  @property UnmountMountableFinishFuncType unmountMountableFinish()
  {
    return (cast(GFileIface*)cPtr).unmountMountableFinish;
  }

  alias EjectMountableFuncType = extern(C) void function(GFile* file, GMountUnmountFlags flags, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property EjectMountableFuncType ejectMountable()
  {
    return (cast(GFileIface*)cPtr).ejectMountable;
  }

  alias EjectMountableFinishFuncType = extern(C) bool function(GFile* file, GAsyncResult* result, GError** _err);

  @property EjectMountableFinishFuncType ejectMountableFinish()
  {
    return (cast(GFileIface*)cPtr).ejectMountableFinish;
  }

  alias MountEnclosingVolumeFuncType = extern(C) void function(GFile* location, GMountMountFlags flags, GMountOperation* mountOperation, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property MountEnclosingVolumeFuncType mountEnclosingVolume()
  {
    return (cast(GFileIface*)cPtr).mountEnclosingVolume;
  }

  alias MountEnclosingVolumeFinishFuncType = extern(C) bool function(GFile* location, GAsyncResult* result, GError** _err);

  @property MountEnclosingVolumeFinishFuncType mountEnclosingVolumeFinish()
  {
    return (cast(GFileIface*)cPtr).mountEnclosingVolumeFinish;
  }

  alias MonitorDirFuncType = extern(C) GFileMonitor* function(GFile* file, GFileMonitorFlags flags, GCancellable* cancellable, GError** _err);

  @property MonitorDirFuncType monitorDir()
  {
    return (cast(GFileIface*)cPtr).monitorDir;
  }

  alias MonitorFileFuncType = extern(C) GFileMonitor* function(GFile* file, GFileMonitorFlags flags, GCancellable* cancellable, GError** _err);

  @property MonitorFileFuncType monitorFile()
  {
    return (cast(GFileIface*)cPtr).monitorFile;
  }

  alias OpenReadwriteFuncType = extern(C) GFileIOStream* function(GFile* file, GCancellable* cancellable, GError** _err);

  @property OpenReadwriteFuncType openReadwrite()
  {
    return (cast(GFileIface*)cPtr).openReadwrite;
  }

  alias OpenReadwriteAsyncFuncType = extern(C) void function(GFile* file, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property OpenReadwriteAsyncFuncType openReadwriteAsync()
  {
    return (cast(GFileIface*)cPtr).openReadwriteAsync;
  }

  alias OpenReadwriteFinishFuncType = extern(C) GFileIOStream* function(GFile* file, GAsyncResult* res, GError** _err);

  @property OpenReadwriteFinishFuncType openReadwriteFinish()
  {
    return (cast(GFileIface*)cPtr).openReadwriteFinish;
  }

  alias CreateReadwriteFuncType = extern(C) GFileIOStream* function(GFile* file, GFileCreateFlags flags, GCancellable* cancellable, GError** _err);

  @property CreateReadwriteFuncType createReadwrite()
  {
    return (cast(GFileIface*)cPtr).createReadwrite;
  }

  alias CreateReadwriteAsyncFuncType = extern(C) void function(GFile* file, GFileCreateFlags flags, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property CreateReadwriteAsyncFuncType createReadwriteAsync()
  {
    return (cast(GFileIface*)cPtr).createReadwriteAsync;
  }

  alias CreateReadwriteFinishFuncType = extern(C) GFileIOStream* function(GFile* file, GAsyncResult* res, GError** _err);

  @property CreateReadwriteFinishFuncType createReadwriteFinish()
  {
    return (cast(GFileIface*)cPtr).createReadwriteFinish;
  }

  alias ReplaceReadwriteFuncType = extern(C) GFileIOStream* function(GFile* file, const(char)* etag, bool makeBackup, GFileCreateFlags flags, GCancellable* cancellable, GError** _err);

  @property ReplaceReadwriteFuncType replaceReadwrite()
  {
    return (cast(GFileIface*)cPtr).replaceReadwrite;
  }

  alias ReplaceReadwriteAsyncFuncType = extern(C) void function(GFile* file, const(char)* etag, bool makeBackup, GFileCreateFlags flags, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property ReplaceReadwriteAsyncFuncType replaceReadwriteAsync()
  {
    return (cast(GFileIface*)cPtr).replaceReadwriteAsync;
  }

  alias ReplaceReadwriteFinishFuncType = extern(C) GFileIOStream* function(GFile* file, GAsyncResult* res, GError** _err);

  @property ReplaceReadwriteFinishFuncType replaceReadwriteFinish()
  {
    return (cast(GFileIface*)cPtr).replaceReadwriteFinish;
  }

  alias StartMountableFuncType = extern(C) void function(GFile* file, GDriveStartFlags flags, GMountOperation* startOperation, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property StartMountableFuncType startMountable()
  {
    return (cast(GFileIface*)cPtr).startMountable;
  }

  alias StartMountableFinishFuncType = extern(C) bool function(GFile* file, GAsyncResult* result, GError** _err);

  @property StartMountableFinishFuncType startMountableFinish()
  {
    return (cast(GFileIface*)cPtr).startMountableFinish;
  }

  alias StopMountableFuncType = extern(C) void function(GFile* file, GMountUnmountFlags flags, GMountOperation* mountOperation, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property StopMountableFuncType stopMountable()
  {
    return (cast(GFileIface*)cPtr).stopMountable;
  }

  alias StopMountableFinishFuncType = extern(C) bool function(GFile* file, GAsyncResult* result, GError** _err);

  @property StopMountableFinishFuncType stopMountableFinish()
  {
    return (cast(GFileIface*)cPtr).stopMountableFinish;
  }

  @property bool supportsThreadContexts()
  {
    return (cast(GFileIface*)cPtr).supportsThreadContexts;
  }

  alias UnmountMountableWithOperationFuncType = extern(C) void function(GFile* file, GMountUnmountFlags flags, GMountOperation* mountOperation, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property UnmountMountableWithOperationFuncType unmountMountableWithOperation()
  {
    return (cast(GFileIface*)cPtr).unmountMountableWithOperation;
  }

  alias UnmountMountableWithOperationFinishFuncType = extern(C) bool function(GFile* file, GAsyncResult* result, GError** _err);

  @property UnmountMountableWithOperationFinishFuncType unmountMountableWithOperationFinish()
  {
    return (cast(GFileIface*)cPtr).unmountMountableWithOperationFinish;
  }

  alias EjectMountableWithOperationFuncType = extern(C) void function(GFile* file, GMountUnmountFlags flags, GMountOperation* mountOperation, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property EjectMountableWithOperationFuncType ejectMountableWithOperation()
  {
    return (cast(GFileIface*)cPtr).ejectMountableWithOperation;
  }

  alias EjectMountableWithOperationFinishFuncType = extern(C) bool function(GFile* file, GAsyncResult* result, GError** _err);

  @property EjectMountableWithOperationFinishFuncType ejectMountableWithOperationFinish()
  {
    return (cast(GFileIface*)cPtr).ejectMountableWithOperationFinish;
  }

  alias PollMountableFuncType = extern(C) void function(GFile* file, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property PollMountableFuncType pollMountable()
  {
    return (cast(GFileIface*)cPtr).pollMountable;
  }

  alias PollMountableFinishFuncType = extern(C) bool function(GFile* file, GAsyncResult* result, GError** _err);

  @property PollMountableFinishFuncType pollMountableFinish()
  {
    return (cast(GFileIface*)cPtr).pollMountableFinish;
  }

  alias MeasureDiskUsageFuncType = extern(C) bool function(GFile* file, GFileMeasureFlags flags, GCancellable* cancellable, GFileMeasureProgressCallback progressCallback, void* progressData, ulong* diskUsage, ulong* numDirs, ulong* numFiles, GError** _err);

  @property MeasureDiskUsageFuncType measureDiskUsage()
  {
    return (cast(GFileIface*)cPtr).measureDiskUsage;
  }

  alias MeasureDiskUsageFinishFuncType = extern(C) bool function(GFile* file, GAsyncResult* result, ulong* diskUsage, ulong* numDirs, ulong* numFiles, GError** _err);

  @property MeasureDiskUsageFinishFuncType measureDiskUsageFinish()
  {
    return (cast(GFileIface*)cPtr).measureDiskUsageFinish;
  }
}
