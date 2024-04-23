module Gio.Resolver;

import GLib.ErrorG;
import GLib.List;
import GLib.Types;
import GLib.Variant;
import GObject.DClosure;
import GObject.ObjectG;
import GObject.Types;
import Gid.Gid;
import Gio.AsyncResult;
import Gio.Cancellable;
import Gio.InetAddress;
import Gio.SrvTarget;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * #GResolver provides cancellable synchronous and asynchronous DNS
 * resolution, for hostnames (g_resolver_lookup_by_address(),
 * g_resolver_lookup_by_name() and their async variants) and SRV
 * (service) records (g_resolver_lookup_service()).
 *
 * #GNetworkAddress and #GNetworkService provide wrappers around
 * #GResolver functionality that also implement #GSocketConnectable,
 * making it easy to connect to a remote host/service.
 *
 * The default resolver (see g_resolver_get_default()) has a timeout of 30s set
 * on it since GLib 2.78. Earlier versions of GLib did not support resolver
 * timeouts.
 */
class Resolver : ObjectG
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_resolver_get_type();
  }

  /**
   * the default #GResolver.
   */
  static Resolver getDefault()
  {
    GResolver* _cretval;
    _cretval = g_resolver_get_default();
    Resolver _retval = ObjectG.getDObject!Resolver(cast(GResolver*)_cretval, true);
    return _retval;
  }

  /**
   * the resolver timeout, in milliseconds, or `0` for no timeout
   */
  uint getTimeout()
  {
    uint _retval;
    _retval = g_resolver_get_timeout(cPtr!GResolver);
    return _retval;
  }

  /**
   * a hostname (either ASCII-only, or in ASCII-encoded
   * form), or %NULL on error.
   */
  string lookupByAddress(InetAddress address, Cancellable cancellable)
  {
    char* _cretval;
    GError *_err;
    _cretval = g_resolver_lookup_by_address(cPtr!GResolver, address ? address.cPtr!GInetAddress : null, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * Begins asynchronously reverse-resolving @address to determine its
   * associated hostname, and eventually calls @callback, which must
   * call g_resolver_lookup_by_address_finish() to get the final result.
   */
  void lookupByAddressAsync(InetAddress address, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    ptrFreezeGC(cast(void*)&callback);
    g_resolver_lookup_by_address_async(cPtr!GResolver, address ? address.cPtr!GInetAddress : null, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * a hostname (either ASCII-only, or in ASCII-encoded
   * form), or %NULL on error.
   */
  string lookupByAddressFinish(AsyncResult result)
  {
    char* _cretval;
    GError *_err;
    _cretval = g_resolver_lookup_by_address_finish(cPtr!GResolver, result ? (cast(ObjectG)result).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * a non-empty #GList
   * of #GInetAddress, or %NULL on error. You
   * must unref each of the addresses and free the list when you are
   * done with it. (You can use g_resolver_free_addresses() to do this.)
   */
  List!(InetAddress, GInetAddress*) lookupByName(string hostname, Cancellable cancellable)
  {
    GList* _cretval;
    const(char)* _hostname = hostname.toCString(false);
    GError *_err;
    _cretval = g_resolver_lookup_by_name(cPtr!GResolver, _hostname, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    List!(InetAddress, GInetAddress*) _retval = _cretval ? new List!(InetAddress, GInetAddress*)(_cretval, GidOwnership.Full) : null;
    return _retval;
  }

  /**
   * Begins asynchronously resolving @hostname to determine its
   * associated IP address(es), and eventually calls @callback, which
   * must call g_resolver_lookup_by_name_finish() to get the result.
   * See g_resolver_lookup_by_name() for more details.
   */
  void lookupByNameAsync(string hostname, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    const(char)* _hostname = hostname.toCString(false);
    ptrFreezeGC(cast(void*)&callback);
    g_resolver_lookup_by_name_async(cPtr!GResolver, _hostname, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * a #GList
   * of #GInetAddress, or %NULL on error. See g_resolver_lookup_by_name()
   * for more details.
   */
  List!(InetAddress, GInetAddress*) lookupByNameFinish(AsyncResult result)
  {
    GList* _cretval;
    GError *_err;
    _cretval = g_resolver_lookup_by_name_finish(cPtr!GResolver, result ? (cast(ObjectG)result).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    List!(InetAddress, GInetAddress*) _retval = _cretval ? new List!(InetAddress, GInetAddress*)(_cretval, GidOwnership.Full) : null;
    return _retval;
  }

  /**
   * a non-empty #GList
   * of #GInetAddress, or %NULL on error. You
   * must unref each of the addresses and free the list when you are
   * done with it. (You can use g_resolver_free_addresses() to do this.)
   */
  List!(InetAddress, GInetAddress*) lookupByNameWithFlags(string hostname, ResolverNameLookupFlags flags, Cancellable cancellable)
  {
    GList* _cretval;
    const(char)* _hostname = hostname.toCString(false);
    GError *_err;
    _cretval = g_resolver_lookup_by_name_with_flags(cPtr!GResolver, _hostname, flags, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    List!(InetAddress, GInetAddress*) _retval = _cretval ? new List!(InetAddress, GInetAddress*)(_cretval, GidOwnership.Full) : null;
    return _retval;
  }

  /**
   * Begins asynchronously resolving @hostname to determine its
   * associated IP address(es), and eventually calls @callback, which
   * must call g_resolver_lookup_by_name_with_flags_finish() to get the result.
   * See g_resolver_lookup_by_name() for more details.
   */
  void lookupByNameWithFlagsAsync(string hostname, ResolverNameLookupFlags flags, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    const(char)* _hostname = hostname.toCString(false);
    ptrFreezeGC(cast(void*)&callback);
    g_resolver_lookup_by_name_with_flags_async(cPtr!GResolver, _hostname, flags, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * a #GList
   * of #GInetAddress, or %NULL on error. See g_resolver_lookup_by_name()
   * for more details.
   */
  List!(InetAddress, GInetAddress*) lookupByNameWithFlagsFinish(AsyncResult result)
  {
    GList* _cretval;
    GError *_err;
    _cretval = g_resolver_lookup_by_name_with_flags_finish(cPtr!GResolver, result ? (cast(ObjectG)result).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    List!(InetAddress, GInetAddress*) _retval = _cretval ? new List!(InetAddress, GInetAddress*)(_cretval, GidOwnership.Full) : null;
    return _retval;
  }

  /**
   * a non-empty #GList of
   * #GVariant, or %NULL on error. You must free each of the records and the list
   * when you are done with it. (You can use g_list_free_full() with
   * g_variant_unref() to do this.)
   */
  List!(Variant, GVariant*) lookupRecords(string rrname, ResolverRecordType recordType, Cancellable cancellable)
  {
    GList* _cretval;
    const(char)* _rrname = rrname.toCString(false);
    GError *_err;
    _cretval = g_resolver_lookup_records(cPtr!GResolver, _rrname, recordType, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    List!(Variant, GVariant*) _retval = _cretval ? new List!(Variant, GVariant*)(_cretval, GidOwnership.Full) : null;
    return _retval;
  }

  /**
   * Begins asynchronously performing a DNS lookup for the given
   * @rrname, and eventually calls @callback, which must call
   * g_resolver_lookup_records_finish() to get the final result. See
   * g_resolver_lookup_records() for more details.
   */
  void lookupRecordsAsync(string rrname, ResolverRecordType recordType, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    const(char)* _rrname = rrname.toCString(false);
    ptrFreezeGC(cast(void*)&callback);
    g_resolver_lookup_records_async(cPtr!GResolver, _rrname, recordType, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * a non-empty #GList of
   * #GVariant, or %NULL on error. You must free each of the records and the list
   * when you are done with it. (You can use g_list_free_full() with
   * g_variant_unref() to do this.)
   */
  List!(Variant, GVariant*) lookupRecordsFinish(AsyncResult result)
  {
    GList* _cretval;
    GError *_err;
    _cretval = g_resolver_lookup_records_finish(cPtr!GResolver, result ? (cast(ObjectG)result).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    List!(Variant, GVariant*) _retval = _cretval ? new List!(Variant, GVariant*)(_cretval, GidOwnership.Full) : null;
    return _retval;
  }

  /**
   * a non-empty #GList of
   * #GSrvTarget, or %NULL on error. You must free each of the targets and the
   * list when you are done with it. (You can use g_resolver_free_targets() to do
   * this.)
   */
  List!(SrvTarget, GSrvTarget*) lookupService(string service, string protocol, string domain, Cancellable cancellable)
  {
    GList* _cretval;
    const(char)* _service = service.toCString(false);
    const(char)* _protocol = protocol.toCString(false);
    const(char)* _domain = domain.toCString(false);
    GError *_err;
    _cretval = g_resolver_lookup_service(cPtr!GResolver, _service, _protocol, _domain, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    List!(SrvTarget, GSrvTarget*) _retval = _cretval ? new List!(SrvTarget, GSrvTarget*)(_cretval, GidOwnership.Full) : null;
    return _retval;
  }

  /**
   * Begins asynchronously performing a DNS SRV lookup for the given
   * @service and @protocol in the given @domain, and eventually calls
   * @callback, which must call g_resolver_lookup_service_finish() to
   * get the final result. See g_resolver_lookup_service() for more
   * details.
   */
  void lookupServiceAsync(string service, string protocol, string domain, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    const(char)* _service = service.toCString(false);
    const(char)* _protocol = protocol.toCString(false);
    const(char)* _domain = domain.toCString(false);
    ptrFreezeGC(cast(void*)&callback);
    g_resolver_lookup_service_async(cPtr!GResolver, _service, _protocol, _domain, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * a non-empty #GList of
   * #GSrvTarget, or %NULL on error. See g_resolver_lookup_service() for more
   * details.
   */
  List!(SrvTarget, GSrvTarget*) lookupServiceFinish(AsyncResult result)
  {
    GList* _cretval;
    GError *_err;
    _cretval = g_resolver_lookup_service_finish(cPtr!GResolver, result ? (cast(ObjectG)result).cPtr!GAsyncResult : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    List!(SrvTarget, GSrvTarget*) _retval = _cretval ? new List!(SrvTarget, GSrvTarget*)(_cretval, GidOwnership.Full) : null;
    return _retval;
  }

  /**
   * Sets @resolver to be the application's default resolver (reffing
   * @resolver, and unreffing the previous default resolver, if any).
   * Future calls to g_resolver_get_default() will return this resolver.
   *
   * This can be used if an application wants to perform any sort of DNS
   * caching or "pinning"; it can implement its own #GResolver that
   * calls the original default resolver for DNS operations, and
   * implements its own cache policies on top of that, and then set
   * itself as the default resolver for all later code to use.
   */
  void setDefault()
  {
    g_resolver_set_default(cPtr!GResolver);
  }

  /**
   * Set the timeout applied to all resolver lookups. See #GResolver:timeout.
   */
  void setTimeout(uint timeoutMs)
  {
    g_resolver_set_timeout(cPtr!GResolver, timeoutMs);
  }

  /**
   * Emitted when the resolver notices that the system resolver
   * configuration has changed.
   */
  ulong connectReload(void delegate(Resolver resolver) dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto resolver = getVal!Resolver(_paramVals);
      _dgClosure.dlg(resolver);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("reload", closure, (flags & ConnectFlags.After) != 0);
  }
}
