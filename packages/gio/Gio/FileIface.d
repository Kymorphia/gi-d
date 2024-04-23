module Gio.FileIface;

import GLib.c.functions;
import GObject.TypeInterface;
import GObject.Types;
import Gid.Gid;
import Gio.AsyncResult;
import Gio.Cancellable;
import Gio.File;
import Gio.FileAttributeInfoList;
import Gio.FileEnumerator;
import Gio.FileIOStream;
import Gio.FileInfo;
import Gio.FileInputStream;
import Gio.FileMonitor;
import Gio.FileOutputStream;
import Gio.Mount;
import Gio.MountOperation;
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
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GFileIface))
  {
    return cast(T*)&cInstance;
  }

  @property TypeInterface gIface()
  {
    return new TypeInterface(cast(GTypeInterface*)&cPtr!GFileIface.gIface);
  }

  alias DupFuncType = extern(C) GFile* function(GFile* file);

  @property DupFuncType dup()
  {
    return cPtr!GFileIface.dup;
  }

  alias HashFuncType = extern(C) uint function(GFile* file);

  @property HashFuncType hash()
  {
    return cPtr!GFileIface.hash;
  }

  alias EqualFuncType = extern(C) bool function(GFile* file1, GFile* file2);

  @property EqualFuncType equal()
  {
    return cPtr!GFileIface.equal;
  }

  alias IsNativeFuncType = extern(C) bool function(GFile* file);

  @property IsNativeFuncType isNative()
  {
    return cPtr!GFileIface.isNative;
  }

  alias HasUriSchemeFuncType = extern(C) bool function(GFile* file, const(char)* uriScheme);

  @property HasUriSchemeFuncType hasUriScheme()
  {
    return cPtr!GFileIface.hasUriScheme;
  }

  alias GetUriSchemeFuncType = extern(C) char* function(GFile* file);

  @property GetUriSchemeFuncType getUriScheme()
  {
    return cPtr!GFileIface.getUriScheme;
  }

  alias GetBasenameFuncType = extern(C) char* function(GFile* file);

  @property GetBasenameFuncType getBasename()
  {
    return cPtr!GFileIface.getBasename;
  }

  alias GetPathFuncType = extern(C) char* function(GFile* file);

  @property GetPathFuncType getPath()
  {
    return cPtr!GFileIface.getPath;
  }

  alias GetUriFuncType = extern(C) char* function(GFile* file);

  @property GetUriFuncType getUri()
  {
    return cPtr!GFileIface.getUri;
  }

  alias GetParseNameFuncType = extern(C) char* function(GFile* file);

  @property GetParseNameFuncType getParseName()
  {
    return cPtr!GFileIface.getParseName;
  }

  alias GetParentFuncType = extern(C) GFile* function(GFile* file);

  @property GetParentFuncType getParent()
  {
    return cPtr!GFileIface.getParent;
  }

  alias PrefixMatchesFuncType = extern(C) bool function(GFile* prefix, GFile* file);

  @property PrefixMatchesFuncType prefixMatches()
  {
    return cPtr!GFileIface.prefixMatches;
  }

  alias GetRelativePathFuncType = extern(C) char* function(GFile* parent, GFile* descendant);

  @property GetRelativePathFuncType getRelativePath()
  {
    return cPtr!GFileIface.getRelativePath;
  }

  alias ResolveRelativePathFuncType = extern(C) GFile* function(GFile* file, const(char)* relativePath);

  @property ResolveRelativePathFuncType resolveRelativePath()
  {
    return cPtr!GFileIface.resolveRelativePath;
  }

  alias GetChildForDisplayNameFuncType = extern(C) GFile* function(GFile* file, const(char)* displayName, GError** _err);

  @property GetChildForDisplayNameFuncType getChildForDisplayName()
  {
    return cPtr!GFileIface.getChildForDisplayName;
  }

  alias EnumerateChildrenFuncType = extern(C) GFileEnumerator* function(GFile* file, const(char)* attributes, GFileQueryInfoFlags flags, GCancellable* cancellable, GError** _err);

  @property EnumerateChildrenFuncType enumerateChildren()
  {
    return cPtr!GFileIface.enumerateChildren;
  }

  alias EnumerateChildrenAsyncFuncType = extern(C) void function(GFile* file, const(char)* attributes, GFileQueryInfoFlags flags, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property EnumerateChildrenAsyncFuncType enumerateChildrenAsync()
  {
    return cPtr!GFileIface.enumerateChildrenAsync;
  }

  alias EnumerateChildrenFinishFuncType = extern(C) GFileEnumerator* function(GFile* file, GAsyncResult* res, GError** _err);

  @property EnumerateChildrenFinishFuncType enumerateChildrenFinish()
  {
    return cPtr!GFileIface.enumerateChildrenFinish;
  }

  alias QueryInfoFuncType = extern(C) GFileInfo* function(GFile* file, const(char)* attributes, GFileQueryInfoFlags flags, GCancellable* cancellable, GError** _err);

  @property QueryInfoFuncType queryInfo()
  {
    return cPtr!GFileIface.queryInfo;
  }

  alias QueryInfoAsyncFuncType = extern(C) void function(GFile* file, const(char)* attributes, GFileQueryInfoFlags flags, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property QueryInfoAsyncFuncType queryInfoAsync()
  {
    return cPtr!GFileIface.queryInfoAsync;
  }

  alias QueryInfoFinishFuncType = extern(C) GFileInfo* function(GFile* file, GAsyncResult* res, GError** _err);

  @property QueryInfoFinishFuncType queryInfoFinish()
  {
    return cPtr!GFileIface.queryInfoFinish;
  }

  alias QueryFilesystemInfoFuncType = extern(C) GFileInfo* function(GFile* file, const(char)* attributes, GCancellable* cancellable, GError** _err);

  @property QueryFilesystemInfoFuncType queryFilesystemInfo()
  {
    return cPtr!GFileIface.queryFilesystemInfo;
  }

  alias QueryFilesystemInfoAsyncFuncType = extern(C) void function(GFile* file, const(char)* attributes, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property QueryFilesystemInfoAsyncFuncType queryFilesystemInfoAsync()
  {
    return cPtr!GFileIface.queryFilesystemInfoAsync;
  }

  alias QueryFilesystemInfoFinishFuncType = extern(C) GFileInfo* function(GFile* file, GAsyncResult* res, GError** _err);

  @property QueryFilesystemInfoFinishFuncType queryFilesystemInfoFinish()
  {
    return cPtr!GFileIface.queryFilesystemInfoFinish;
  }

  alias FindEnclosingMountFuncType = extern(C) GMount* function(GFile* file, GCancellable* cancellable, GError** _err);

  @property FindEnclosingMountFuncType findEnclosingMount()
  {
    return cPtr!GFileIface.findEnclosingMount;
  }

  alias FindEnclosingMountAsyncFuncType = extern(C) void function(GFile* file, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property FindEnclosingMountAsyncFuncType findEnclosingMountAsync()
  {
    return cPtr!GFileIface.findEnclosingMountAsync;
  }

  alias FindEnclosingMountFinishFuncType = extern(C) GMount* function(GFile* file, GAsyncResult* res, GError** _err);

  @property FindEnclosingMountFinishFuncType findEnclosingMountFinish()
  {
    return cPtr!GFileIface.findEnclosingMountFinish;
  }

  alias SetDisplayNameFuncType = extern(C) GFile* function(GFile* file, const(char)* displayName, GCancellable* cancellable, GError** _err);

  @property SetDisplayNameFuncType setDisplayName()
  {
    return cPtr!GFileIface.setDisplayName;
  }

  alias SetDisplayNameAsyncFuncType = extern(C) void function(GFile* file, const(char)* displayName, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property SetDisplayNameAsyncFuncType setDisplayNameAsync()
  {
    return cPtr!GFileIface.setDisplayNameAsync;
  }

  alias SetDisplayNameFinishFuncType = extern(C) GFile* function(GFile* file, GAsyncResult* res, GError** _err);

  @property SetDisplayNameFinishFuncType setDisplayNameFinish()
  {
    return cPtr!GFileIface.setDisplayNameFinish;
  }

  alias QuerySettableAttributesFuncType = extern(C) GFileAttributeInfoList* function(GFile* file, GCancellable* cancellable, GError** _err);

  @property QuerySettableAttributesFuncType querySettableAttributes()
  {
    return cPtr!GFileIface.querySettableAttributes;
  }

  alias QuerySettableAttributesAsyncFuncType = extern(C) void function();

  @property QuerySettableAttributesAsyncFuncType QuerySettableAttributesAsync()
  {
    return cPtr!GFileIface.QuerySettableAttributesAsync;
  }

  alias QuerySettableAttributesFinishFuncType = extern(C) void function();

  @property QuerySettableAttributesFinishFuncType QuerySettableAttributesFinish()
  {
    return cPtr!GFileIface.QuerySettableAttributesFinish;
  }

  alias QueryWritableNamespacesFuncType = extern(C) GFileAttributeInfoList* function(GFile* file, GCancellable* cancellable, GError** _err);

  @property QueryWritableNamespacesFuncType queryWritableNamespaces()
  {
    return cPtr!GFileIface.queryWritableNamespaces;
  }

  alias QueryWritableNamespacesAsyncFuncType = extern(C) void function();

  @property QueryWritableNamespacesAsyncFuncType QueryWritableNamespacesAsync()
  {
    return cPtr!GFileIface.QueryWritableNamespacesAsync;
  }

  alias QueryWritableNamespacesFinishFuncType = extern(C) void function();

  @property QueryWritableNamespacesFinishFuncType QueryWritableNamespacesFinish()
  {
    return cPtr!GFileIface.QueryWritableNamespacesFinish;
  }

  alias SetAttributeFuncType = extern(C) bool function(GFile* file, const(char)* attribute, GFileAttributeType type, void* valueP, GFileQueryInfoFlags flags, GCancellable* cancellable, GError** _err);

  @property SetAttributeFuncType setAttribute()
  {
    return cPtr!GFileIface.setAttribute;
  }

  alias SetAttributesFromInfoFuncType = extern(C) bool function(GFile* file, GFileInfo* info, GFileQueryInfoFlags flags, GCancellable* cancellable, GError** _err);

  @property SetAttributesFromInfoFuncType setAttributesFromInfo()
  {
    return cPtr!GFileIface.setAttributesFromInfo;
  }

  alias SetAttributesAsyncFuncType = extern(C) void function(GFile* file, GFileInfo* info, GFileQueryInfoFlags flags, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property SetAttributesAsyncFuncType setAttributesAsync()
  {
    return cPtr!GFileIface.setAttributesAsync;
  }

  alias SetAttributesFinishFuncType = extern(C) bool function(GFile* file, GAsyncResult* result, GFileInfo** info, GError** _err);

  @property SetAttributesFinishFuncType setAttributesFinish()
  {
    return cPtr!GFileIface.setAttributesFinish;
  }

  alias ReadFnFuncType = extern(C) GFileInputStream* function(GFile* file, GCancellable* cancellable, GError** _err);

  @property ReadFnFuncType readFn()
  {
    return cPtr!GFileIface.readFn;
  }

  alias ReadAsyncFuncType = extern(C) void function(GFile* file, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property ReadAsyncFuncType readAsync()
  {
    return cPtr!GFileIface.readAsync;
  }

  alias ReadFinishFuncType = extern(C) GFileInputStream* function(GFile* file, GAsyncResult* res, GError** _err);

  @property ReadFinishFuncType readFinish()
  {
    return cPtr!GFileIface.readFinish;
  }

  alias AppendToFuncType = extern(C) GFileOutputStream* function(GFile* file, GFileCreateFlags flags, GCancellable* cancellable, GError** _err);

  @property AppendToFuncType appendTo()
  {
    return cPtr!GFileIface.appendTo;
  }

  alias AppendToAsyncFuncType = extern(C) void function(GFile* file, GFileCreateFlags flags, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property AppendToAsyncFuncType appendToAsync()
  {
    return cPtr!GFileIface.appendToAsync;
  }

  alias AppendToFinishFuncType = extern(C) GFileOutputStream* function(GFile* file, GAsyncResult* res, GError** _err);

  @property AppendToFinishFuncType appendToFinish()
  {
    return cPtr!GFileIface.appendToFinish;
  }

  alias CreateFuncType = extern(C) GFileOutputStream* function(GFile* file, GFileCreateFlags flags, GCancellable* cancellable, GError** _err);

  @property CreateFuncType create()
  {
    return cPtr!GFileIface.create;
  }

  alias CreateAsyncFuncType = extern(C) void function(GFile* file, GFileCreateFlags flags, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property CreateAsyncFuncType createAsync()
  {
    return cPtr!GFileIface.createAsync;
  }

  alias CreateFinishFuncType = extern(C) GFileOutputStream* function(GFile* file, GAsyncResult* res, GError** _err);

  @property CreateFinishFuncType createFinish()
  {
    return cPtr!GFileIface.createFinish;
  }

  alias ReplaceFuncType = extern(C) GFileOutputStream* function(GFile* file, const(char)* etag, bool makeBackup, GFileCreateFlags flags, GCancellable* cancellable, GError** _err);

  @property ReplaceFuncType replace()
  {
    return cPtr!GFileIface.replace;
  }

  alias ReplaceAsyncFuncType = extern(C) void function(GFile* file, const(char)* etag, bool makeBackup, GFileCreateFlags flags, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property ReplaceAsyncFuncType replaceAsync()
  {
    return cPtr!GFileIface.replaceAsync;
  }

  alias ReplaceFinishFuncType = extern(C) GFileOutputStream* function(GFile* file, GAsyncResult* res, GError** _err);

  @property ReplaceFinishFuncType replaceFinish()
  {
    return cPtr!GFileIface.replaceFinish;
  }

  alias DeleteFileFuncType = extern(C) bool function(GFile* file, GCancellable* cancellable, GError** _err);

  @property DeleteFileFuncType deleteFile()
  {
    return cPtr!GFileIface.deleteFile;
  }

  alias DeleteFileAsyncFuncType = extern(C) void function(GFile* file, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property DeleteFileAsyncFuncType deleteFileAsync()
  {
    return cPtr!GFileIface.deleteFileAsync;
  }

  alias DeleteFileFinishFuncType = extern(C) bool function(GFile* file, GAsyncResult* result, GError** _err);

  @property DeleteFileFinishFuncType deleteFileFinish()
  {
    return cPtr!GFileIface.deleteFileFinish;
  }

  alias TrashFuncType = extern(C) bool function(GFile* file, GCancellable* cancellable, GError** _err);

  @property TrashFuncType trash()
  {
    return cPtr!GFileIface.trash;
  }

  alias TrashAsyncFuncType = extern(C) void function(GFile* file, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property TrashAsyncFuncType trashAsync()
  {
    return cPtr!GFileIface.trashAsync;
  }

  alias TrashFinishFuncType = extern(C) bool function(GFile* file, GAsyncResult* result, GError** _err);

  @property TrashFinishFuncType trashFinish()
  {
    return cPtr!GFileIface.trashFinish;
  }

  alias MakeDirectoryFuncType = extern(C) bool function(GFile* file, GCancellable* cancellable, GError** _err);

  @property MakeDirectoryFuncType makeDirectory()
  {
    return cPtr!GFileIface.makeDirectory;
  }

  alias MakeDirectoryAsyncFuncType = extern(C) void function(GFile* file, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property MakeDirectoryAsyncFuncType makeDirectoryAsync()
  {
    return cPtr!GFileIface.makeDirectoryAsync;
  }

  alias MakeDirectoryFinishFuncType = extern(C) bool function(GFile* file, GAsyncResult* result, GError** _err);

  @property MakeDirectoryFinishFuncType makeDirectoryFinish()
  {
    return cPtr!GFileIface.makeDirectoryFinish;
  }

  alias MakeSymbolicLinkFuncType = extern(C) bool function(GFile* file, const(char)* symlinkValue, GCancellable* cancellable, GError** _err);

  @property MakeSymbolicLinkFuncType makeSymbolicLink()
  {
    return cPtr!GFileIface.makeSymbolicLink;
  }

  alias MakeSymbolicLinkAsyncFuncType = extern(C) void function(GFile* file, const(char)* symlinkValue, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property MakeSymbolicLinkAsyncFuncType makeSymbolicLinkAsync()
  {
    return cPtr!GFileIface.makeSymbolicLinkAsync;
  }

  alias MakeSymbolicLinkFinishFuncType = extern(C) bool function(GFile* file, GAsyncResult* result, GError** _err);

  @property MakeSymbolicLinkFinishFuncType makeSymbolicLinkFinish()
  {
    return cPtr!GFileIface.makeSymbolicLinkFinish;
  }

  alias CopyFuncType = extern(C) bool function(GFile* source, GFile* destination, GFileCopyFlags flags, GCancellable* cancellable, GFileProgressCallback progressCallback, void* progressCallbackData, GError** _err);

  @property CopyFuncType copy()
  {
    return cPtr!GFileIface.copy;
  }

  alias CopyAsyncFuncType = extern(C) void function(GFile* source, GFile* destination, GFileCopyFlags flags, int ioPriority, GCancellable* cancellable, GFileProgressCallback progressCallback, void* progressCallbackData, GAsyncReadyCallback callback, void* userData);

  @property CopyAsyncFuncType copyAsync()
  {
    return cPtr!GFileIface.copyAsync;
  }

  alias CopyFinishFuncType = extern(C) bool function(GFile* file, GAsyncResult* res, GError** _err);

  @property CopyFinishFuncType copyFinish()
  {
    return cPtr!GFileIface.copyFinish;
  }

  alias MoveFuncType = extern(C) bool function(GFile* source, GFile* destination, GFileCopyFlags flags, GCancellable* cancellable, GFileProgressCallback progressCallback, void* progressCallbackData, GError** _err);

  @property MoveFuncType move()
  {
    return cPtr!GFileIface.move;
  }

  alias MoveAsyncFuncType = extern(C) void function(GFile* source, GFile* destination, GFileCopyFlags flags, int ioPriority, GCancellable* cancellable, GFileProgressCallback progressCallback, void* progressCallbackData, GAsyncReadyCallback callback, void* userData);

  @property MoveAsyncFuncType moveAsync()
  {
    return cPtr!GFileIface.moveAsync;
  }

  alias MoveFinishFuncType = extern(C) bool function(GFile* file, GAsyncResult* result, GError** _err);

  @property MoveFinishFuncType moveFinish()
  {
    return cPtr!GFileIface.moveFinish;
  }

  alias MountMountableFuncType = extern(C) void function(GFile* file, GMountMountFlags flags, GMountOperation* mountOperation, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property MountMountableFuncType mountMountable()
  {
    return cPtr!GFileIface.mountMountable;
  }

  alias MountMountableFinishFuncType = extern(C) GFile* function(GFile* file, GAsyncResult* result, GError** _err);

  @property MountMountableFinishFuncType mountMountableFinish()
  {
    return cPtr!GFileIface.mountMountableFinish;
  }

  alias UnmountMountableFuncType = extern(C) void function(GFile* file, GMountUnmountFlags flags, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property UnmountMountableFuncType unmountMountable()
  {
    return cPtr!GFileIface.unmountMountable;
  }

  alias UnmountMountableFinishFuncType = extern(C) bool function(GFile* file, GAsyncResult* result, GError** _err);

  @property UnmountMountableFinishFuncType unmountMountableFinish()
  {
    return cPtr!GFileIface.unmountMountableFinish;
  }

  alias EjectMountableFuncType = extern(C) void function(GFile* file, GMountUnmountFlags flags, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property EjectMountableFuncType ejectMountable()
  {
    return cPtr!GFileIface.ejectMountable;
  }

  alias EjectMountableFinishFuncType = extern(C) bool function(GFile* file, GAsyncResult* result, GError** _err);

  @property EjectMountableFinishFuncType ejectMountableFinish()
  {
    return cPtr!GFileIface.ejectMountableFinish;
  }

  alias MountEnclosingVolumeFuncType = extern(C) void function(GFile* location, GMountMountFlags flags, GMountOperation* mountOperation, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property MountEnclosingVolumeFuncType mountEnclosingVolume()
  {
    return cPtr!GFileIface.mountEnclosingVolume;
  }

  alias MountEnclosingVolumeFinishFuncType = extern(C) bool function(GFile* location, GAsyncResult* result, GError** _err);

  @property MountEnclosingVolumeFinishFuncType mountEnclosingVolumeFinish()
  {
    return cPtr!GFileIface.mountEnclosingVolumeFinish;
  }

  alias MonitorDirFuncType = extern(C) GFileMonitor* function(GFile* file, GFileMonitorFlags flags, GCancellable* cancellable, GError** _err);

  @property MonitorDirFuncType monitorDir()
  {
    return cPtr!GFileIface.monitorDir;
  }

  alias MonitorFileFuncType = extern(C) GFileMonitor* function(GFile* file, GFileMonitorFlags flags, GCancellable* cancellable, GError** _err);

  @property MonitorFileFuncType monitorFile()
  {
    return cPtr!GFileIface.monitorFile;
  }

  alias OpenReadwriteFuncType = extern(C) GFileIOStream* function(GFile* file, GCancellable* cancellable, GError** _err);

  @property OpenReadwriteFuncType openReadwrite()
  {
    return cPtr!GFileIface.openReadwrite;
  }

  alias OpenReadwriteAsyncFuncType = extern(C) void function(GFile* file, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property OpenReadwriteAsyncFuncType openReadwriteAsync()
  {
    return cPtr!GFileIface.openReadwriteAsync;
  }

  alias OpenReadwriteFinishFuncType = extern(C) GFileIOStream* function(GFile* file, GAsyncResult* res, GError** _err);

  @property OpenReadwriteFinishFuncType openReadwriteFinish()
  {
    return cPtr!GFileIface.openReadwriteFinish;
  }

  alias CreateReadwriteFuncType = extern(C) GFileIOStream* function(GFile* file, GFileCreateFlags flags, GCancellable* cancellable, GError** _err);

  @property CreateReadwriteFuncType createReadwrite()
  {
    return cPtr!GFileIface.createReadwrite;
  }

  alias CreateReadwriteAsyncFuncType = extern(C) void function(GFile* file, GFileCreateFlags flags, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property CreateReadwriteAsyncFuncType createReadwriteAsync()
  {
    return cPtr!GFileIface.createReadwriteAsync;
  }

  alias CreateReadwriteFinishFuncType = extern(C) GFileIOStream* function(GFile* file, GAsyncResult* res, GError** _err);

  @property CreateReadwriteFinishFuncType createReadwriteFinish()
  {
    return cPtr!GFileIface.createReadwriteFinish;
  }

  alias ReplaceReadwriteFuncType = extern(C) GFileIOStream* function(GFile* file, const(char)* etag, bool makeBackup, GFileCreateFlags flags, GCancellable* cancellable, GError** _err);

  @property ReplaceReadwriteFuncType replaceReadwrite()
  {
    return cPtr!GFileIface.replaceReadwrite;
  }

  alias ReplaceReadwriteAsyncFuncType = extern(C) void function(GFile* file, const(char)* etag, bool makeBackup, GFileCreateFlags flags, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property ReplaceReadwriteAsyncFuncType replaceReadwriteAsync()
  {
    return cPtr!GFileIface.replaceReadwriteAsync;
  }

  alias ReplaceReadwriteFinishFuncType = extern(C) GFileIOStream* function(GFile* file, GAsyncResult* res, GError** _err);

  @property ReplaceReadwriteFinishFuncType replaceReadwriteFinish()
  {
    return cPtr!GFileIface.replaceReadwriteFinish;
  }

  alias StartMountableFuncType = extern(C) void function(GFile* file, GDriveStartFlags flags, GMountOperation* startOperation, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property StartMountableFuncType startMountable()
  {
    return cPtr!GFileIface.startMountable;
  }

  alias StartMountableFinishFuncType = extern(C) bool function(GFile* file, GAsyncResult* result, GError** _err);

  @property StartMountableFinishFuncType startMountableFinish()
  {
    return cPtr!GFileIface.startMountableFinish;
  }

  alias StopMountableFuncType = extern(C) void function(GFile* file, GMountUnmountFlags flags, GMountOperation* mountOperation, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property StopMountableFuncType stopMountable()
  {
    return cPtr!GFileIface.stopMountable;
  }

  alias StopMountableFinishFuncType = extern(C) bool function(GFile* file, GAsyncResult* result, GError** _err);

  @property StopMountableFinishFuncType stopMountableFinish()
  {
    return cPtr!GFileIface.stopMountableFinish;
  }

  @property bool supportsThreadContexts()
  {
    return cPtr!GFileIface.supportsThreadContexts;
  }

  alias UnmountMountableWithOperationFuncType = extern(C) void function(GFile* file, GMountUnmountFlags flags, GMountOperation* mountOperation, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property UnmountMountableWithOperationFuncType unmountMountableWithOperation()
  {
    return cPtr!GFileIface.unmountMountableWithOperation;
  }

  alias UnmountMountableWithOperationFinishFuncType = extern(C) bool function(GFile* file, GAsyncResult* result, GError** _err);

  @property UnmountMountableWithOperationFinishFuncType unmountMountableWithOperationFinish()
  {
    return cPtr!GFileIface.unmountMountableWithOperationFinish;
  }

  alias EjectMountableWithOperationFuncType = extern(C) void function(GFile* file, GMountUnmountFlags flags, GMountOperation* mountOperation, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property EjectMountableWithOperationFuncType ejectMountableWithOperation()
  {
    return cPtr!GFileIface.ejectMountableWithOperation;
  }

  alias EjectMountableWithOperationFinishFuncType = extern(C) bool function(GFile* file, GAsyncResult* result, GError** _err);

  @property EjectMountableWithOperationFinishFuncType ejectMountableWithOperationFinish()
  {
    return cPtr!GFileIface.ejectMountableWithOperationFinish;
  }

  alias PollMountableFuncType = extern(C) void function(GFile* file, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property PollMountableFuncType pollMountable()
  {
    return cPtr!GFileIface.pollMountable;
  }

  alias PollMountableFinishFuncType = extern(C) bool function(GFile* file, GAsyncResult* result, GError** _err);

  @property PollMountableFinishFuncType pollMountableFinish()
  {
    return cPtr!GFileIface.pollMountableFinish;
  }

  alias MeasureDiskUsageFinishFuncType = extern(C) bool function(GFile* file, GAsyncResult* result, ulong* diskUsage, ulong* numDirs, ulong* numFiles, GError** _err);

  @property MeasureDiskUsageFinishFuncType measureDiskUsageFinish()
  {
    return cPtr!GFileIface.measureDiskUsageFinish;
  }
}
