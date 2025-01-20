module Gio.Resolver;

import GLib.ErrorG;
import GLib.List;
import GLib.Variant;
import GObject.DClosure;
import GObject.ObjectG;
import Gid.gid;
import Gio.AsyncResult;
import Gio.AsyncResultT;
import Gio.Cancellable;
import Gio.InetAddress;
import Gio.SrvTarget;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * The object that handles DNS resolution. Use [Gio.Resolver.getDefault]
 * to get the default resolver.
 * `GResolver` provides cancellable synchronous and asynchronous DNS
 * resolution, for hostnames $(LPAREN)[Gio.Resolver.lookupByAddress],
 * [Gio.Resolver.lookupByName] and their async variants$(RPAREN) and SRV
 * $(LPAREN)service$(RPAREN) records $(LPAREN)[Gio.Resolver.lookupService]$(RPAREN).
 * [Gio.NetworkAddress] and [Gio.NetworkService] provide wrappers
 * around `GResolver` functionality that also implement
 * [Gio.SocketConnectable], making it easy to connect to a remote
 * host/service.
 * The default resolver $(LPAREN)see [Gio.Resolver.getDefault]$(RPAREN) has a timeout of
 * 30s set on it since GLib 2.78. Earlier versions of GLib did not support
 * resolver timeouts.
 * This is an abstract type; subclasses of it implement different resolvers for
 * different platforms and situations.
 */
class Resolver : ObjectG
{

  this()
  {
  }

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_resolver_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Gets the default #GResolver. You should unref it when you are done
   * with it. #GResolver may use its reference count as a hint about how
   * many threads it should allocate for concurrent DNS resolutions.
   * Returns: the default #GResolver.
   */
  static Resolver getDefault()
  {
    GResolver* _cretval;
    _cretval = g_resolver_get_default();
    auto _retval = _cretval ? ObjectG.getDObject!Resolver(cast(GResolver*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Get the timeout applied to all resolver lookups. See #GResolver:timeout.
   * Returns: the resolver timeout, in milliseconds, or `0` for no timeout
   */
  uint getTimeout()
  {
    uint _retval;
    _retval = g_resolver_get_timeout(cast(GResolver*)cPtr);
    return _retval;
  }

  /**
   * Synchronously reverse-resolves address to determine its
   * associated hostname.
   * If the DNS resolution fails, error $(LPAREN)if non-%NULL$(RPAREN) will be set to
   * a value from #GResolverError.
   * If cancellable is non-%NULL, it can be used to cancel the
   * operation, in which case error $(LPAREN)if non-%NULL$(RPAREN) will be set to
   * %G_IO_ERROR_CANCELLED.
   * Params:
   *   address = the address to reverse-resolve
   *   cancellable = a #GCancellable, or %NULL
   * Returns: a hostname $(LPAREN)either ASCII-only, or in ASCII-encoded
   *   form$(RPAREN), or %NULL on error.
   */
  string lookupByAddress(InetAddress address, Cancellable cancellable)
  {
    char* _cretval;
    GError *_err;
    _cretval = g_resolver_lookup_by_address(cast(GResolver*)cPtr, address ? cast(GInetAddress*)address.cPtr(false) : null, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * Begins asynchronously reverse-resolving address to determine its
   * associated hostname, and eventually calls callback, which must
   * call [Gio.Resolver.lookupByAddressFinish] to get the final result.
   * Params:
   *   address = the address to reverse-resolve
   *   cancellable = a #GCancellable, or %NULL
   *   callback = callback to call after resolution completes
   */
  void lookupByAddressAsync(InetAddress address, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(AsyncReadyCallback*)data;

      (*_dlg)(sourceObject ? ObjectG.getDObject!ObjectG(cast(void*)sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(cast(void*)res, false) : null);
    }

    auto _callback = freezeDelegate(cast(void*)&callback);
    g_resolver_lookup_by_address_async(cast(GResolver*)cPtr, address ? cast(GInetAddress*)address.cPtr(false) : null, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_callbackCallback, _callback);
  }

  /**
   * Retrieves the result of a previous call to
   * [Gio.Resolver.lookupByAddressAsync].
   * If the DNS resolution failed, error $(LPAREN)if non-%NULL$(RPAREN) will be set to
   * a value from #GResolverError. If the operation was cancelled,
   * error will be set to %G_IO_ERROR_CANCELLED.
   * Params:
   *   result = the result passed to your #GAsyncReadyCallback
   * Returns: a hostname $(LPAREN)either ASCII-only, or in ASCII-encoded
   *   form$(RPAREN), or %NULL on error.
   */
  string lookupByAddressFinish(AsyncResult result)
  {
    char* _cretval;
    GError *_err;
    _cretval = g_resolver_lookup_by_address_finish(cast(GResolver*)cPtr, result ? cast(GAsyncResult*)(cast(ObjectG)result).cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * Synchronously resolves hostname to determine its associated IP
   * address$(LPAREN)es$(RPAREN). hostname may be an ASCII-only or UTF-8 hostname, or
   * the textual form of an IP address $(LPAREN)in which case this just becomes
   * a wrapper around [Gio.InetAddress.newFromString]$(RPAREN).
   * On success, [Gio.Resolver.lookupByName] will return a non-empty #GList of
   * #GInetAddress, sorted in order of preference and guaranteed to not
   * contain duplicates. That is, if using the result to connect to
   * hostname, you should attempt to connect to the first address
   * first, then the second if the first fails, etc. If you are using
   * the result to listen on a socket, it is appropriate to add each
   * result using e.g. [Gio.SocketListener.addAddress].
   * If the DNS resolution fails, error $(LPAREN)if non-%NULL$(RPAREN) will be set to a
   * value from #GResolverError and %NULL will be returned.
   * If cancellable is non-%NULL, it can be used to cancel the
   * operation, in which case error $(LPAREN)if non-%NULL$(RPAREN) will be set to
   * %G_IO_ERROR_CANCELLED.
   * If you are planning to connect to a socket on the resolved IP
   * address, it may be easier to create a #GNetworkAddress and use its
   * #GSocketConnectable interface.
   * Params:
   *   hostname = the hostname to look up
   *   cancellable = a #GCancellable, or %NULL
   * Returns: a non-empty #GList
   *   of #GInetAddress, or %NULL on error. You
   *   must unref each of the addresses and free the list when you are
   *   done with it. $(LPAREN)You can use [Gio.Resolver.freeAddresses] to do this.$(RPAREN)
   */
  List!(InetAddress) lookupByName(string hostname, Cancellable cancellable)
  {
    GList* _cretval;
    const(char)* _hostname = hostname.toCString(false);
    GError *_err;
    _cretval = g_resolver_lookup_by_name(cast(GResolver*)cPtr, _hostname, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    List!(InetAddress) _retval = new List!(InetAddress)(cast(GList*)_cretval, GidOwnership.Full);
    return _retval;
  }

  /**
   * Begins asynchronously resolving hostname to determine its
   * associated IP address$(LPAREN)es$(RPAREN), and eventually calls callback, which
   * must call [Gio.Resolver.lookupByNameFinish] to get the result.
   * See [Gio.Resolver.lookupByName] for more details.
   * Params:
   *   hostname = the hostname to look up the address of
   *   cancellable = a #GCancellable, or %NULL
   *   callback = callback to call after resolution completes
   */
  void lookupByNameAsync(string hostname, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(AsyncReadyCallback*)data;

      (*_dlg)(sourceObject ? ObjectG.getDObject!ObjectG(cast(void*)sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(cast(void*)res, false) : null);
    }

    const(char)* _hostname = hostname.toCString(false);
    auto _callback = freezeDelegate(cast(void*)&callback);
    g_resolver_lookup_by_name_async(cast(GResolver*)cPtr, _hostname, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_callbackCallback, _callback);
  }

  /**
   * Retrieves the result of a call to
   * [Gio.Resolver.lookupByNameAsync].
   * If the DNS resolution failed, error $(LPAREN)if non-%NULL$(RPAREN) will be set to
   * a value from #GResolverError. If the operation was cancelled,
   * error will be set to %G_IO_ERROR_CANCELLED.
   * Params:
   *   result = the result passed to your #GAsyncReadyCallback
   * Returns: a #GList
   *   of #GInetAddress, or %NULL on error. See [Gio.Resolver.lookupByName]
   *   for more details.
   */
  List!(InetAddress) lookupByNameFinish(AsyncResult result)
  {
    GList* _cretval;
    GError *_err;
    _cretval = g_resolver_lookup_by_name_finish(cast(GResolver*)cPtr, result ? cast(GAsyncResult*)(cast(ObjectG)result).cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    List!(InetAddress) _retval = new List!(InetAddress)(cast(GList*)_cretval, GidOwnership.Full);
    return _retval;
  }

  /**
   * This differs from [Gio.Resolver.lookupByName] in that you can modify
   * the lookup behavior with flags. For example this can be used to limit
   * results with %G_RESOLVER_NAME_LOOKUP_FLAGS_IPV4_ONLY.
   * Params:
   *   hostname = the hostname to look up
   *   flags = extra #GResolverNameLookupFlags for the lookup
   *   cancellable = a #GCancellable, or %NULL
   * Returns: a non-empty #GList
   *   of #GInetAddress, or %NULL on error. You
   *   must unref each of the addresses and free the list when you are
   *   done with it. $(LPAREN)You can use [Gio.Resolver.freeAddresses] to do this.$(RPAREN)
   */
  List!(InetAddress) lookupByNameWithFlags(string hostname, ResolverNameLookupFlags flags, Cancellable cancellable)
  {
    GList* _cretval;
    const(char)* _hostname = hostname.toCString(false);
    GError *_err;
    _cretval = g_resolver_lookup_by_name_with_flags(cast(GResolver*)cPtr, _hostname, flags, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    List!(InetAddress) _retval = new List!(InetAddress)(cast(GList*)_cretval, GidOwnership.Full);
    return _retval;
  }

  /**
   * Begins asynchronously resolving hostname to determine its
   * associated IP address$(LPAREN)es$(RPAREN), and eventually calls callback, which
   * must call [Gio.Resolver.lookupByNameWithFlagsFinish] to get the result.
   * See [Gio.Resolver.lookupByName] for more details.
   * Params:
   *   hostname = the hostname to look up the address of
   *   flags = extra #GResolverNameLookupFlags for the lookup
   *   cancellable = a #GCancellable, or %NULL
   *   callback = callback to call after resolution completes
   */
  void lookupByNameWithFlagsAsync(string hostname, ResolverNameLookupFlags flags, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(AsyncReadyCallback*)data;

      (*_dlg)(sourceObject ? ObjectG.getDObject!ObjectG(cast(void*)sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(cast(void*)res, false) : null);
    }

    const(char)* _hostname = hostname.toCString(false);
    auto _callback = freezeDelegate(cast(void*)&callback);
    g_resolver_lookup_by_name_with_flags_async(cast(GResolver*)cPtr, _hostname, flags, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_callbackCallback, _callback);
  }

  /**
   * Retrieves the result of a call to
   * [Gio.Resolver.lookupByNameWithFlagsAsync].
   * If the DNS resolution failed, error $(LPAREN)if non-%NULL$(RPAREN) will be set to
   * a value from #GResolverError. If the operation was cancelled,
   * error will be set to %G_IO_ERROR_CANCELLED.
   * Params:
   *   result = the result passed to your #GAsyncReadyCallback
   * Returns: a #GList
   *   of #GInetAddress, or %NULL on error. See [Gio.Resolver.lookupByName]
   *   for more details.
   */
  List!(InetAddress) lookupByNameWithFlagsFinish(AsyncResult result)
  {
    GList* _cretval;
    GError *_err;
    _cretval = g_resolver_lookup_by_name_with_flags_finish(cast(GResolver*)cPtr, result ? cast(GAsyncResult*)(cast(ObjectG)result).cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    List!(InetAddress) _retval = new List!(InetAddress)(cast(GList*)_cretval, GidOwnership.Full);
    return _retval;
  }

  /**
   * Synchronously performs a DNS record lookup for the given rrname and returns
   * a list of records as #GVariant tuples. See #GResolverRecordType for
   * information on what the records contain for each record_type.
   * If the DNS resolution fails, error $(LPAREN)if non-%NULL$(RPAREN) will be set to
   * a value from #GResolverError and %NULL will be returned.
   * If cancellable is non-%NULL, it can be used to cancel the
   * operation, in which case error $(LPAREN)if non-%NULL$(RPAREN) will be set to
   * %G_IO_ERROR_CANCELLED.
   * Params:
   *   rrname = the DNS name to look up the record for
   *   recordType = the type of DNS record to look up
   *   cancellable = a #GCancellable, or %NULL
   * Returns: a non-empty #GList of
   *   #GVariant, or %NULL on error. You must free each of the records and the list
   *   when you are done with it. $(LPAREN)You can use [GLib.List.freeFull] with
   *   [GLib.Variant.unref] to do this.$(RPAREN)
   */
  List!(Variant) lookupRecords(string rrname, ResolverRecordType recordType, Cancellable cancellable)
  {
    GList* _cretval;
    const(char)* _rrname = rrname.toCString(false);
    GError *_err;
    _cretval = g_resolver_lookup_records(cast(GResolver*)cPtr, _rrname, recordType, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    List!(Variant) _retval = new List!(Variant)(cast(GList*)_cretval, GidOwnership.Full);
    return _retval;
  }

  /**
   * Begins asynchronously performing a DNS lookup for the given
   * rrname, and eventually calls callback, which must call
   * [Gio.Resolver.lookupRecordsFinish] to get the final result. See
   * [Gio.Resolver.lookupRecords] for more details.
   * Params:
   *   rrname = the DNS name to look up the record for
   *   recordType = the type of DNS record to look up
   *   cancellable = a #GCancellable, or %NULL
   *   callback = callback to call after resolution completes
   */
  void lookupRecordsAsync(string rrname, ResolverRecordType recordType, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(AsyncReadyCallback*)data;

      (*_dlg)(sourceObject ? ObjectG.getDObject!ObjectG(cast(void*)sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(cast(void*)res, false) : null);
    }

    const(char)* _rrname = rrname.toCString(false);
    auto _callback = freezeDelegate(cast(void*)&callback);
    g_resolver_lookup_records_async(cast(GResolver*)cPtr, _rrname, recordType, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_callbackCallback, _callback);
  }

  /**
   * Retrieves the result of a previous call to
   * [Gio.Resolver.lookupRecordsAsync]. Returns a non-empty list of records as
   * #GVariant tuples. See #GResolverRecordType for information on what the
   * records contain.
   * If the DNS resolution failed, error $(LPAREN)if non-%NULL$(RPAREN) will be set to
   * a value from #GResolverError. If the operation was cancelled,
   * error will be set to %G_IO_ERROR_CANCELLED.
   * Params:
   *   result = the result passed to your #GAsyncReadyCallback
   * Returns: a non-empty #GList of
   *   #GVariant, or %NULL on error. You must free each of the records and the list
   *   when you are done with it. $(LPAREN)You can use [GLib.List.freeFull] with
   *   [GLib.Variant.unref] to do this.$(RPAREN)
   */
  List!(Variant) lookupRecordsFinish(AsyncResult result)
  {
    GList* _cretval;
    GError *_err;
    _cretval = g_resolver_lookup_records_finish(cast(GResolver*)cPtr, result ? cast(GAsyncResult*)(cast(ObjectG)result).cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    List!(Variant) _retval = new List!(Variant)(cast(GList*)_cretval, GidOwnership.Full);
    return _retval;
  }

  /**
   * Synchronously performs a DNS SRV lookup for the given service and
   * protocol in the given domain and returns an array of #GSrvTarget.
   * domain may be an ASCII-only or UTF-8 hostname. Note also that the
   * service and protocol arguments do not include the leading underscore
   * that appears in the actual DNS entry.
   * On success, [Gio.Resolver.lookupService] will return a non-empty #GList of
   * #GSrvTarget, sorted in order of preference. $(LPAREN)That is, you should
   * attempt to connect to the first target first, then the second if
   * the first fails, etc.$(RPAREN)
   * If the DNS resolution fails, error $(LPAREN)if non-%NULL$(RPAREN) will be set to
   * a value from #GResolverError and %NULL will be returned.
   * If cancellable is non-%NULL, it can be used to cancel the
   * operation, in which case error $(LPAREN)if non-%NULL$(RPAREN) will be set to
   * %G_IO_ERROR_CANCELLED.
   * If you are planning to connect to the service, it is usually easier
   * to create a #GNetworkService and use its #GSocketConnectable
   * interface.
   * Params:
   *   service = the service type to look up $(LPAREN)eg, "ldap"$(RPAREN)
   *   protocol = the networking protocol to use for service $(LPAREN)eg, "tcp"$(RPAREN)
   *   domain = the DNS domain to look up the service in
   *   cancellable = a #GCancellable, or %NULL
   * Returns: a non-empty #GList of
   *   #GSrvTarget, or %NULL on error. You must free each of the targets and the
   *   list when you are done with it. $(LPAREN)You can use [Gio.Resolver.freeTargets] to do
   *   this.$(RPAREN)
   */
  List!(SrvTarget) lookupService(string service, string protocol, string domain, Cancellable cancellable)
  {
    GList* _cretval;
    const(char)* _service = service.toCString(false);
    const(char)* _protocol = protocol.toCString(false);
    const(char)* _domain = domain.toCString(false);
    GError *_err;
    _cretval = g_resolver_lookup_service(cast(GResolver*)cPtr, _service, _protocol, _domain, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    List!(SrvTarget) _retval = new List!(SrvTarget)(cast(GList*)_cretval, GidOwnership.Full);
    return _retval;
  }

  /**
   * Begins asynchronously performing a DNS SRV lookup for the given
   * service and protocol in the given domain, and eventually calls
   * callback, which must call [Gio.Resolver.lookupServiceFinish] to
   * get the final result. See [Gio.Resolver.lookupService] for more
   * details.
   * Params:
   *   service = the service type to look up $(LPAREN)eg, "ldap"$(RPAREN)
   *   protocol = the networking protocol to use for service $(LPAREN)eg, "tcp"$(RPAREN)
   *   domain = the DNS domain to look up the service in
   *   cancellable = a #GCancellable, or %NULL
   *   callback = callback to call after resolution completes
   */
  void lookupServiceAsync(string service, string protocol, string domain, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(AsyncReadyCallback*)data;

      (*_dlg)(sourceObject ? ObjectG.getDObject!ObjectG(cast(void*)sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(cast(void*)res, false) : null);
    }

    const(char)* _service = service.toCString(false);
    const(char)* _protocol = protocol.toCString(false);
    const(char)* _domain = domain.toCString(false);
    auto _callback = freezeDelegate(cast(void*)&callback);
    g_resolver_lookup_service_async(cast(GResolver*)cPtr, _service, _protocol, _domain, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_callbackCallback, _callback);
  }

  /**
   * Retrieves the result of a previous call to
   * [Gio.Resolver.lookupServiceAsync].
   * If the DNS resolution failed, error $(LPAREN)if non-%NULL$(RPAREN) will be set to
   * a value from #GResolverError. If the operation was cancelled,
   * error will be set to %G_IO_ERROR_CANCELLED.
   * Params:
   *   result = the result passed to your #GAsyncReadyCallback
   * Returns: a non-empty #GList of
   *   #GSrvTarget, or %NULL on error. See [Gio.Resolver.lookupService] for more
   *   details.
   */
  List!(SrvTarget) lookupServiceFinish(AsyncResult result)
  {
    GList* _cretval;
    GError *_err;
    _cretval = g_resolver_lookup_service_finish(cast(GResolver*)cPtr, result ? cast(GAsyncResult*)(cast(ObjectG)result).cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    List!(SrvTarget) _retval = new List!(SrvTarget)(cast(GList*)_cretval, GidOwnership.Full);
    return _retval;
  }

  /**
   * Sets resolver to be the application's default resolver $(LPAREN)reffing
   * resolver, and unreffing the previous default resolver, if any$(RPAREN).
   * Future calls to [Gio.Resolver.getDefault] will return this resolver.
   * This can be used if an application wants to perform any sort of DNS
   * caching or "pinning"; it can implement its own #GResolver that
   * calls the original default resolver for DNS operations, and
   * implements its own cache policies on top of that, and then set
   * itself as the default resolver for all later code to use.
   */
  void setDefault()
  {
    g_resolver_set_default(cast(GResolver*)cPtr);
  }

  /**
   * Set the timeout applied to all resolver lookups. See #GResolver:timeout.
   * Params:
   *   timeoutMs = timeout in milliseconds, or `0` for no timeouts
   */
  void setTimeout(uint timeoutMs)
  {
    g_resolver_set_timeout(cast(GResolver*)cPtr, timeoutMs);
  }

  /**
   * Emitted when the resolver notices that the system resolver
   * configuration has changed.
   *   resolver = the instance the signal is connected to
   */
  alias ReloadCallback = void delegate(Resolver resolver);

  /**
   * Connect to Reload signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectReload(ReloadCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto resolver = getVal!Resolver(_paramVals);
      _dgClosure.dlg(resolver);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("reload", closure, after);
  }
}
