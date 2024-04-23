module Gio.DtlsConnectionInterface;

import GLib.ByteArray;
import GLib.Types;
import GLib.c.functions;
import GObject.TypeInterface;
import GObject.Types;
import Gid.Gid;
import Gio.AsyncResult;
import Gio.Cancellable;
import Gio.DtlsConnection;
import Gio.TlsCertificate;
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
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GDtlsConnectionInterface))
  {
    return cast(T*)&cInstance;
  }

  @property TypeInterface gIface()
  {
    return new TypeInterface(cast(GTypeInterface*)&cPtr!GDtlsConnectionInterface.gIface);
  }

  alias AcceptCertificateFuncType = extern(C) bool function(GDtlsConnection* connection, GTlsCertificate* peerCert, GTlsCertificateFlags errors);

  @property AcceptCertificateFuncType acceptCertificate()
  {
    return cPtr!GDtlsConnectionInterface.acceptCertificate;
  }

  alias HandshakeFuncType = extern(C) bool function(GDtlsConnection* conn, GCancellable* cancellable, GError** _err);

  @property HandshakeFuncType handshake()
  {
    return cPtr!GDtlsConnectionInterface.handshake;
  }

  alias HandshakeAsyncFuncType = extern(C) void function(GDtlsConnection* conn, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property HandshakeAsyncFuncType handshakeAsync()
  {
    return cPtr!GDtlsConnectionInterface.handshakeAsync;
  }

  alias HandshakeFinishFuncType = extern(C) bool function(GDtlsConnection* conn, GAsyncResult* result, GError** _err);

  @property HandshakeFinishFuncType handshakeFinish()
  {
    return cPtr!GDtlsConnectionInterface.handshakeFinish;
  }

  alias ShutdownFuncType = extern(C) bool function(GDtlsConnection* conn, bool shutdownRead, bool shutdownWrite, GCancellable* cancellable, GError** _err);

  @property ShutdownFuncType shutdown()
  {
    return cPtr!GDtlsConnectionInterface.shutdown;
  }

  alias ShutdownAsyncFuncType = extern(C) void function(GDtlsConnection* conn, bool shutdownRead, bool shutdownWrite, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property ShutdownAsyncFuncType shutdownAsync()
  {
    return cPtr!GDtlsConnectionInterface.shutdownAsync;
  }

  alias ShutdownFinishFuncType = extern(C) bool function(GDtlsConnection* conn, GAsyncResult* result, GError** _err);

  @property ShutdownFinishFuncType shutdownFinish()
  {
    return cPtr!GDtlsConnectionInterface.shutdownFinish;
  }

  alias SetAdvertisedProtocolsFuncType = extern(C) void function(GDtlsConnection* conn, const(char*)* protocols);

  @property SetAdvertisedProtocolsFuncType setAdvertisedProtocols()
  {
    return cPtr!GDtlsConnectionInterface.setAdvertisedProtocols;
  }

  alias GetNegotiatedProtocolFuncType = extern(C) const(char)* function(GDtlsConnection* conn);

  @property GetNegotiatedProtocolFuncType getNegotiatedProtocol()
  {
    return cPtr!GDtlsConnectionInterface.getNegotiatedProtocol;
  }

  alias GetBindingDataFuncType = extern(C) bool function(GDtlsConnection* conn, GTlsChannelBindingType type, GByteArray* data, GError** _err);

  @property GetBindingDataFuncType getBindingData()
  {
    return cPtr!GDtlsConnectionInterface.getBindingData;
  }
}
