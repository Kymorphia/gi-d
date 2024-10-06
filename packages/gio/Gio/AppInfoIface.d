module Gio.AppInfoIface;

import GObject.TypeInterface;
import Gid.gid;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * Application Information interface, for operating system portability.
 */
class AppInfoIface
{
  GAppInfoIface cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.AppInfoIface");

    cInstance = *cast(GAppInfoIface*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property TypeInterface gIface()
  {
    return new TypeInterface(cast(GTypeInterface*)&(cast(GAppInfoIface*)cPtr).gIface);
  }

  alias DupFuncType = extern(C) GAppInfo* function(GAppInfo* appinfo);

  @property DupFuncType dup()
  {
    return (cast(GAppInfoIface*)cPtr).dup;
  }

  alias EqualFuncType = extern(C) bool function(GAppInfo* appinfo1, GAppInfo* appinfo2);

  @property EqualFuncType equal()
  {
    return (cast(GAppInfoIface*)cPtr).equal;
  }

  alias GetIdFuncType = extern(C) const(char)* function(GAppInfo* appinfo);

  @property GetIdFuncType getId()
  {
    return (cast(GAppInfoIface*)cPtr).getId;
  }

  alias GetNameFuncType = extern(C) const(char)* function(GAppInfo* appinfo);

  @property GetNameFuncType getName()
  {
    return (cast(GAppInfoIface*)cPtr).getName;
  }

  alias GetDescriptionFuncType = extern(C) const(char)* function(GAppInfo* appinfo);

  @property GetDescriptionFuncType getDescription()
  {
    return (cast(GAppInfoIface*)cPtr).getDescription;
  }

  alias GetExecutableFuncType = extern(C) const(char)* function(GAppInfo* appinfo);

  @property GetExecutableFuncType getExecutable()
  {
    return (cast(GAppInfoIface*)cPtr).getExecutable;
  }

  alias GetIconFuncType = extern(C) GIcon* function(GAppInfo* appinfo);

  @property GetIconFuncType getIcon()
  {
    return (cast(GAppInfoIface*)cPtr).getIcon;
  }

  alias LaunchFuncType = extern(C) bool function(GAppInfo* appinfo, GList* files, GAppLaunchContext* context, GError** _err);

  @property LaunchFuncType launch()
  {
    return (cast(GAppInfoIface*)cPtr).launch;
  }

  alias SupportsUrisFuncType = extern(C) bool function(GAppInfo* appinfo);

  @property SupportsUrisFuncType supportsUris()
  {
    return (cast(GAppInfoIface*)cPtr).supportsUris;
  }

  alias SupportsFilesFuncType = extern(C) bool function(GAppInfo* appinfo);

  @property SupportsFilesFuncType supportsFiles()
  {
    return (cast(GAppInfoIface*)cPtr).supportsFiles;
  }

  alias LaunchUrisFuncType = extern(C) bool function(GAppInfo* appinfo, GList* uris, GAppLaunchContext* context, GError** _err);

  @property LaunchUrisFuncType launchUris()
  {
    return (cast(GAppInfoIface*)cPtr).launchUris;
  }

  alias ShouldShowFuncType = extern(C) bool function(GAppInfo* appinfo);

  @property ShouldShowFuncType shouldShow()
  {
    return (cast(GAppInfoIface*)cPtr).shouldShow;
  }

  alias SetAsDefaultForTypeFuncType = extern(C) bool function(GAppInfo* appinfo, const(char)* contentType, GError** _err);

  @property SetAsDefaultForTypeFuncType setAsDefaultForType()
  {
    return (cast(GAppInfoIface*)cPtr).setAsDefaultForType;
  }

  alias SetAsDefaultForExtensionFuncType = extern(C) bool function(GAppInfo* appinfo, const(char)* extension, GError** _err);

  @property SetAsDefaultForExtensionFuncType setAsDefaultForExtension()
  {
    return (cast(GAppInfoIface*)cPtr).setAsDefaultForExtension;
  }

  alias AddSupportsTypeFuncType = extern(C) bool function(GAppInfo* appinfo, const(char)* contentType, GError** _err);

  @property AddSupportsTypeFuncType addSupportsType()
  {
    return (cast(GAppInfoIface*)cPtr).addSupportsType;
  }

  alias CanRemoveSupportsTypeFuncType = extern(C) bool function(GAppInfo* appinfo);

  @property CanRemoveSupportsTypeFuncType canRemoveSupportsType()
  {
    return (cast(GAppInfoIface*)cPtr).canRemoveSupportsType;
  }

  alias RemoveSupportsTypeFuncType = extern(C) bool function(GAppInfo* appinfo, const(char)* contentType, GError** _err);

  @property RemoveSupportsTypeFuncType removeSupportsType()
  {
    return (cast(GAppInfoIface*)cPtr).removeSupportsType;
  }

  alias CanDeleteFuncType = extern(C) bool function(GAppInfo* appinfo);

  @property CanDeleteFuncType canDelete()
  {
    return (cast(GAppInfoIface*)cPtr).canDelete;
  }

  alias DoDeleteFuncType = extern(C) bool function(GAppInfo* appinfo);

  @property DoDeleteFuncType doDelete()
  {
    return (cast(GAppInfoIface*)cPtr).doDelete;
  }

  alias GetCommandlineFuncType = extern(C) const(char)* function(GAppInfo* appinfo);

  @property GetCommandlineFuncType getCommandline()
  {
    return (cast(GAppInfoIface*)cPtr).getCommandline;
  }

  alias GetDisplayNameFuncType = extern(C) const(char)* function(GAppInfo* appinfo);

  @property GetDisplayNameFuncType getDisplayName()
  {
    return (cast(GAppInfoIface*)cPtr).getDisplayName;
  }

  alias SetAsLastUsedForTypeFuncType = extern(C) bool function(GAppInfo* appinfo, const(char)* contentType, GError** _err);

  @property SetAsLastUsedForTypeFuncType setAsLastUsedForType()
  {
    return (cast(GAppInfoIface*)cPtr).setAsLastUsedForType;
  }

  alias GetSupportedTypesFuncType = extern(C) const(char*)* function(GAppInfo* appinfo);

  @property GetSupportedTypesFuncType getSupportedTypes()
  {
    return (cast(GAppInfoIface*)cPtr).getSupportedTypes;
  }

  alias LaunchUrisAsyncFuncType = extern(C) void function(GAppInfo* appinfo, GList* uris, GAppLaunchContext* context, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property LaunchUrisAsyncFuncType launchUrisAsync()
  {
    return (cast(GAppInfoIface*)cPtr).launchUrisAsync;
  }

  alias LaunchUrisFinishFuncType = extern(C) bool function(GAppInfo* appinfo, GAsyncResult* result, GError** _err);

  @property LaunchUrisFinishFuncType launchUrisFinish()
  {
    return (cast(GAppInfoIface*)cPtr).launchUrisFinish;
  }
}
