module Gio.ResolverClass;

import GObject.ObjectClass;
import Gid.gid;
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
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property ObjectClass parentClass()
  {
    return new ObjectClass(cast(GObjectClass*)&(cast(GResolverClass*)cPtr).parentClass);
  }

  alias ReloadFuncType = extern(C) void function(GResolver* resolver);

  @property ReloadFuncType reload()
  {
    return (cast(GResolverClass*)cPtr).reload;
  }

  alias LookupByNameFuncType = extern(C) GList* function(GResolver* resolver, const(char)* hostname, GCancellable* cancellable, GError** _err);

  @property LookupByNameFuncType lookupByName()
  {
    return (cast(GResolverClass*)cPtr).lookupByName;
  }

  alias LookupByNameAsyncFuncType = extern(C) void function(GResolver* resolver, const(char)* hostname, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property LookupByNameAsyncFuncType lookupByNameAsync()
  {
    return (cast(GResolverClass*)cPtr).lookupByNameAsync;
  }

  alias LookupByNameFinishFuncType = extern(C) GList* function(GResolver* resolver, GAsyncResult* result, GError** _err);

  @property LookupByNameFinishFuncType lookupByNameFinish()
  {
    return (cast(GResolverClass*)cPtr).lookupByNameFinish;
  }

  alias LookupByAddressFuncType = extern(C) char* function(GResolver* resolver, GInetAddress* address, GCancellable* cancellable, GError** _err);

  @property LookupByAddressFuncType lookupByAddress()
  {
    return (cast(GResolverClass*)cPtr).lookupByAddress;
  }

  alias LookupByAddressAsyncFuncType = extern(C) void function(GResolver* resolver, GInetAddress* address, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property LookupByAddressAsyncFuncType lookupByAddressAsync()
  {
    return (cast(GResolverClass*)cPtr).lookupByAddressAsync;
  }

  alias LookupByAddressFinishFuncType = extern(C) char* function(GResolver* resolver, GAsyncResult* result, GError** _err);

  @property LookupByAddressFinishFuncType lookupByAddressFinish()
  {
    return (cast(GResolverClass*)cPtr).lookupByAddressFinish;
  }

  alias LookupServiceAsyncFuncType = extern(C) void function(GResolver* resolver, const(char)* rrname, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property LookupServiceAsyncFuncType lookupServiceAsync()
  {
    return (cast(GResolverClass*)cPtr).lookupServiceAsync;
  }

  alias LookupServiceFinishFuncType = extern(C) GList* function(GResolver* resolver, GAsyncResult* result, GError** _err);

  @property LookupServiceFinishFuncType lookupServiceFinish()
  {
    return (cast(GResolverClass*)cPtr).lookupServiceFinish;
  }

  alias LookupRecordsFuncType = extern(C) GList* function(GResolver* resolver, const(char)* rrname, GResolverRecordType recordType, GCancellable* cancellable, GError** _err);

  @property LookupRecordsFuncType lookupRecords()
  {
    return (cast(GResolverClass*)cPtr).lookupRecords;
  }

  alias LookupRecordsAsyncFuncType = extern(C) void function(GResolver* resolver, const(char)* rrname, GResolverRecordType recordType, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property LookupRecordsAsyncFuncType lookupRecordsAsync()
  {
    return (cast(GResolverClass*)cPtr).lookupRecordsAsync;
  }

  alias LookupRecordsFinishFuncType = extern(C) GList* function(GResolver* resolver, GAsyncResult* result, GError** _err);

  @property LookupRecordsFinishFuncType lookupRecordsFinish()
  {
    return (cast(GResolverClass*)cPtr).lookupRecordsFinish;
  }

  alias LookupByNameWithFlagsAsyncFuncType = extern(C) void function(GResolver* resolver, const(char)* hostname, GResolverNameLookupFlags flags, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property LookupByNameWithFlagsAsyncFuncType lookupByNameWithFlagsAsync()
  {
    return (cast(GResolverClass*)cPtr).lookupByNameWithFlagsAsync;
  }

  alias LookupByNameWithFlagsFinishFuncType = extern(C) GList* function(GResolver* resolver, GAsyncResult* result, GError** _err);

  @property LookupByNameWithFlagsFinishFuncType lookupByNameWithFlagsFinish()
  {
    return (cast(GResolverClass*)cPtr).lookupByNameWithFlagsFinish;
  }

  alias LookupByNameWithFlagsFuncType = extern(C) GList* function(GResolver* resolver, const(char)* hostname, GResolverNameLookupFlags flags, GCancellable* cancellable, GError** _err);

  @property LookupByNameWithFlagsFuncType lookupByNameWithFlags()
  {
    return (cast(GResolverClass*)cPtr).lookupByNameWithFlags;
  }
}
