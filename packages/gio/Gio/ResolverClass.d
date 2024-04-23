module Gio.ResolverClass;

import GLib.List;
import GLib.Types;
import GLib.Variant;
import GLib.c.functions;
import GObject.ObjectClass;
import GObject.Types;
import Gid.Gid;
import Gio.AsyncResult;
import Gio.Cancellable;
import Gio.InetAddress;
import Gio.Resolver;
import Gio.SrvTarget;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

class ResolverClass
{
  GResolverClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.ResolverClass");

    cInstance = *cast(GResolverClass*)ptr;

    if (ownedRef)
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GResolverClass))
  {
    return cast(T*)&cInstance;
  }

  @property ObjectClass parentClass()
  {
    return new ObjectClass(cast(GObjectClass*)&cPtr!GResolverClass.parentClass);
  }

  alias ReloadFuncType = extern(C) void function(GResolver* resolver);

  @property ReloadFuncType reload()
  {
    return cPtr!GResolverClass.reload;
  }

  alias LookupByNameFuncType = extern(C) GList* function(GResolver* resolver, const(char)* hostname, GCancellable* cancellable, GError** _err);

  @property LookupByNameFuncType lookupByName()
  {
    return cPtr!GResolverClass.lookupByName;
  }

  alias LookupByNameAsyncFuncType = extern(C) void function(GResolver* resolver, const(char)* hostname, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property LookupByNameAsyncFuncType lookupByNameAsync()
  {
    return cPtr!GResolverClass.lookupByNameAsync;
  }

  alias LookupByNameFinishFuncType = extern(C) GList* function(GResolver* resolver, GAsyncResult* result, GError** _err);

  @property LookupByNameFinishFuncType lookupByNameFinish()
  {
    return cPtr!GResolverClass.lookupByNameFinish;
  }

  alias LookupByAddressFuncType = extern(C) char* function(GResolver* resolver, GInetAddress* address, GCancellable* cancellable, GError** _err);

  @property LookupByAddressFuncType lookupByAddress()
  {
    return cPtr!GResolverClass.lookupByAddress;
  }

  alias LookupByAddressAsyncFuncType = extern(C) void function(GResolver* resolver, GInetAddress* address, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property LookupByAddressAsyncFuncType lookupByAddressAsync()
  {
    return cPtr!GResolverClass.lookupByAddressAsync;
  }

  alias LookupByAddressFinishFuncType = extern(C) char* function(GResolver* resolver, GAsyncResult* result, GError** _err);

  @property LookupByAddressFinishFuncType lookupByAddressFinish()
  {
    return cPtr!GResolverClass.lookupByAddressFinish;
  }

  alias LookupServiceAsyncFuncType = extern(C) void function(GResolver* resolver, const(char)* rrname, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property LookupServiceAsyncFuncType lookupServiceAsync()
  {
    return cPtr!GResolverClass.lookupServiceAsync;
  }

  alias LookupServiceFinishFuncType = extern(C) GList* function(GResolver* resolver, GAsyncResult* result, GError** _err);

  @property LookupServiceFinishFuncType lookupServiceFinish()
  {
    return cPtr!GResolverClass.lookupServiceFinish;
  }

  alias LookupRecordsFuncType = extern(C) GList* function(GResolver* resolver, const(char)* rrname, GResolverRecordType recordType, GCancellable* cancellable, GError** _err);

  @property LookupRecordsFuncType lookupRecords()
  {
    return cPtr!GResolverClass.lookupRecords;
  }

  alias LookupRecordsAsyncFuncType = extern(C) void function(GResolver* resolver, const(char)* rrname, GResolverRecordType recordType, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property LookupRecordsAsyncFuncType lookupRecordsAsync()
  {
    return cPtr!GResolverClass.lookupRecordsAsync;
  }

  alias LookupRecordsFinishFuncType = extern(C) GList* function(GResolver* resolver, GAsyncResult* result, GError** _err);

  @property LookupRecordsFinishFuncType lookupRecordsFinish()
  {
    return cPtr!GResolverClass.lookupRecordsFinish;
  }

  alias LookupByNameWithFlagsAsyncFuncType = extern(C) void function(GResolver* resolver, const(char)* hostname, GResolverNameLookupFlags flags, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property LookupByNameWithFlagsAsyncFuncType lookupByNameWithFlagsAsync()
  {
    return cPtr!GResolverClass.lookupByNameWithFlagsAsync;
  }

  alias LookupByNameWithFlagsFinishFuncType = extern(C) GList* function(GResolver* resolver, GAsyncResult* result, GError** _err);

  @property LookupByNameWithFlagsFinishFuncType lookupByNameWithFlagsFinish()
  {
    return cPtr!GResolverClass.lookupByNameWithFlagsFinish;
  }

  alias LookupByNameWithFlagsFuncType = extern(C) GList* function(GResolver* resolver, const(char)* hostname, GResolverNameLookupFlags flags, GCancellable* cancellable, GError** _err);

  @property LookupByNameWithFlagsFuncType lookupByNameWithFlags()
  {
    return cPtr!GResolverClass.lookupByNameWithFlags;
  }
}
