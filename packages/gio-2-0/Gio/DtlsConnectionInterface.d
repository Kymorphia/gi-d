module Gio.DtlsConnectionInterface;

import GObject.TypeInterface;
import Gid.gid;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * Virtual method table for a #GDtlsConnection implementation.
 */
class DtlsConnectionInterface
{
  GDtlsConnectionInterface cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.DtlsConnectionInterface");

    cInstance = *cast(GDtlsConnectionInterface*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property TypeInterface gIface()
  {
    return new TypeInterface(cast(GTypeInterface*)&(cast(GDtlsConnectionInterface*)cPtr).gIface);
  }

  alias AcceptCertificateFuncType = extern(C) bool function(GDtlsConnection* connection, GTlsCertificate* peerCert, GTlsCertificateFlags errors);

  @property AcceptCertificateFuncType acceptCertificate()
  {
    return (cast(GDtlsConnectionInterface*)cPtr).acceptCertificate;
  }

  alias HandshakeFuncType = extern(C) bool function(GDtlsConnection* conn, GCancellable* cancellable, GError** _err);

  @property HandshakeFuncType handshake()
  {
    return (cast(GDtlsConnectionInterface*)cPtr).handshake;
  }

  alias HandshakeAsyncFuncType = extern(C) void function(GDtlsConnection* conn, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property HandshakeAsyncFuncType handshakeAsync()
  {
    return (cast(GDtlsConnectionInterface*)cPtr).handshakeAsync;
  }

  alias HandshakeFinishFuncType = extern(C) bool function(GDtlsConnection* conn, GAsyncResult* result, GError** _err);

  @property HandshakeFinishFuncType handshakeFinish()
  {
    return (cast(GDtlsConnectionInterface*)cPtr).handshakeFinish;
  }

  alias ShutdownFuncType = extern(C) bool function(GDtlsConnection* conn, bool shutdownRead, bool shutdownWrite, GCancellable* cancellable, GError** _err);

  @property ShutdownFuncType shutdown()
  {
    return (cast(GDtlsConnectionInterface*)cPtr).shutdown;
  }

  alias ShutdownAsyncFuncType = extern(C) void function(GDtlsConnection* conn, bool shutdownRead, bool shutdownWrite, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property ShutdownAsyncFuncType shutdownAsync()
  {
    return (cast(GDtlsConnectionInterface*)cPtr).shutdownAsync;
  }

  alias ShutdownFinishFuncType = extern(C) bool function(GDtlsConnection* conn, GAsyncResult* result, GError** _err);

  @property ShutdownFinishFuncType shutdownFinish()
  {
    return (cast(GDtlsConnectionInterface*)cPtr).shutdownFinish;
  }

  alias SetAdvertisedProtocolsFuncType = extern(C) void function(GDtlsConnection* conn, const(char*)* protocols);

  @property SetAdvertisedProtocolsFuncType setAdvertisedProtocols()
  {
    return (cast(GDtlsConnectionInterface*)cPtr).setAdvertisedProtocols;
  }

  alias GetNegotiatedProtocolFuncType = extern(C) const(char)* function(GDtlsConnection* conn);

  @property GetNegotiatedProtocolFuncType getNegotiatedProtocol()
  {
    return (cast(GDtlsConnectionInterface*)cPtr).getNegotiatedProtocol;
  }

  alias GetBindingDataFuncType = extern(C) bool function(GDtlsConnection* conn, GTlsChannelBindingType type, GByteArray* data, GError** _err);

  @property GetBindingDataFuncType getBindingData()
  {
    return (cast(GDtlsConnectionInterface*)cPtr).getBindingData;
  }
}
