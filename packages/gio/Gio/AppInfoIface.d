module Gio.AppInfoIface;

import GLib.List;
import GLib.Types;
import GLib.c.functions;
import GObject.TypeInterface;
import GObject.Types;
import Gid.Gid;
import Gio.AppInfo;
import Gio.AppLaunchContext;
import Gio.AsyncResult;
import Gio.Cancellable;
import Gio.File;
import Gio.Icon;
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
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GAppInfoIface))
  {
    return cast(T*)&cInstance;
  }

  @property TypeInterface gIface()
  {
    return new TypeInterface(cast(GTypeInterface*)&cPtr!GAppInfoIface.gIface);
  }

  alias DupFuncType = extern(C) GAppInfo* function(GAppInfo* appinfo);

  @property DupFuncType dup()
  {
    return cPtr!GAppInfoIface.dup;
  }

  alias EqualFuncType = extern(C) bool function(GAppInfo* appinfo1, GAppInfo* appinfo2);

  @property EqualFuncType equal()
  {
    return cPtr!GAppInfoIface.equal;
  }

  alias GetIdFuncType = extern(C) const(char)* function(GAppInfo* appinfo);

  @property GetIdFuncType getId()
  {
    return cPtr!GAppInfoIface.getId;
  }

  alias GetNameFuncType = extern(C) const(char)* function(GAppInfo* appinfo);

  @property GetNameFuncType getName()
  {
    return cPtr!GAppInfoIface.getName;
  }

  alias GetDescriptionFuncType = extern(C) const(char)* function(GAppInfo* appinfo);

  @property GetDescriptionFuncType getDescription()
  {
    return cPtr!GAppInfoIface.getDescription;
  }

  alias GetExecutableFuncType = extern(C) const(char)* function(GAppInfo* appinfo);

  @property GetExecutableFuncType getExecutable()
  {
    return cPtr!GAppInfoIface.getExecutable;
  }

  alias GetIconFuncType = extern(C) GIcon* function(GAppInfo* appinfo);

  @property GetIconFuncType getIcon()
  {
    return cPtr!GAppInfoIface.getIcon;
  }

  alias LaunchFuncType = extern(C) bool function(GAppInfo* appinfo, GList* files, GAppLaunchContext* context, GError** _err);

  @property LaunchFuncType launch()
  {
    return cPtr!GAppInfoIface.launch;
  }

  alias SupportsUrisFuncType = extern(C) bool function(GAppInfo* appinfo);

  @property SupportsUrisFuncType supportsUris()
  {
    return cPtr!GAppInfoIface.supportsUris;
  }

  alias SupportsFilesFuncType = extern(C) bool function(GAppInfo* appinfo);

  @property SupportsFilesFuncType supportsFiles()
  {
    return cPtr!GAppInfoIface.supportsFiles;
  }

  alias LaunchUrisFuncType = extern(C) bool function(GAppInfo* appinfo, GList* uris, GAppLaunchContext* context, GError** _err);

  @property LaunchUrisFuncType launchUris()
  {
    return cPtr!GAppInfoIface.launchUris;
  }

  alias ShouldShowFuncType = extern(C) bool function(GAppInfo* appinfo);

  @property ShouldShowFuncType shouldShow()
  {
    return cPtr!GAppInfoIface.shouldShow;
  }

  alias SetAsDefaultForTypeFuncType = extern(C) bool function(GAppInfo* appinfo, const(char)* contentType, GError** _err);

  @property SetAsDefaultForTypeFuncType setAsDefaultForType()
  {
    return cPtr!GAppInfoIface.setAsDefaultForType;
  }

  alias SetAsDefaultForExtensionFuncType = extern(C) bool function(GAppInfo* appinfo, const(char)* extension, GError** _err);

  @property SetAsDefaultForExtensionFuncType setAsDefaultForExtension()
  {
    return cPtr!GAppInfoIface.setAsDefaultForExtension;
  }

  alias AddSupportsTypeFuncType = extern(C) bool function(GAppInfo* appinfo, const(char)* contentType, GError** _err);

  @property AddSupportsTypeFuncType addSupportsType()
  {
    return cPtr!GAppInfoIface.addSupportsType;
  }

  alias CanRemoveSupportsTypeFuncType = extern(C) bool function(GAppInfo* appinfo);

  @property CanRemoveSupportsTypeFuncType canRemoveSupportsType()
  {
    return cPtr!GAppInfoIface.canRemoveSupportsType;
  }

  alias RemoveSupportsTypeFuncType = extern(C) bool function(GAppInfo* appinfo, const(char)* contentType, GError** _err);

  @property RemoveSupportsTypeFuncType removeSupportsType()
  {
    return cPtr!GAppInfoIface.removeSupportsType;
  }

  alias CanDeleteFuncType = extern(C) bool function(GAppInfo* appinfo);

  @property CanDeleteFuncType canDelete()
  {
    return cPtr!GAppInfoIface.canDelete;
  }

  alias DoDeleteFuncType = extern(C) bool function(GAppInfo* appinfo);

  @property DoDeleteFuncType doDelete()
  {
    return cPtr!GAppInfoIface.doDelete;
  }

  alias GetCommandlineFuncType = extern(C) const(char)* function(GAppInfo* appinfo);

  @property GetCommandlineFuncType getCommandline()
  {
    return cPtr!GAppInfoIface.getCommandline;
  }

  alias GetDisplayNameFuncType = extern(C) const(char)* function(GAppInfo* appinfo);

  @property GetDisplayNameFuncType getDisplayName()
  {
    return cPtr!GAppInfoIface.getDisplayName;
  }

  alias SetAsLastUsedForTypeFuncType = extern(C) bool function(GAppInfo* appinfo, const(char)* contentType, GError** _err);

  @property SetAsLastUsedForTypeFuncType setAsLastUsedForType()
  {
    return cPtr!GAppInfoIface.setAsLastUsedForType;
  }

  alias GetSupportedTypesFuncType = extern(C) const(char*)* function(GAppInfo* appinfo);

  @property GetSupportedTypesFuncType getSupportedTypes()
  {
    return cPtr!GAppInfoIface.getSupportedTypes;
  }

  alias LaunchUrisAsyncFuncType = extern(C) void function(GAppInfo* appinfo, GList* uris, GAppLaunchContext* context, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property LaunchUrisAsyncFuncType launchUrisAsync()
  {
    return cPtr!GAppInfoIface.launchUrisAsync;
  }

  alias LaunchUrisFinishFuncType = extern(C) bool function(GAppInfo* appinfo, GAsyncResult* result, GError** _err);

  @property LaunchUrisFinishFuncType launchUrisFinish()
  {
    return cPtr!GAppInfoIface.launchUrisFinish;
  }
}
