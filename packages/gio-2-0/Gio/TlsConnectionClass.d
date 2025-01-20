module Gio.TlsConnectionClass;

import Gid.gid;
import Gio.IOStreamClass;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * The class structure for the #GTlsConnection type.
 */
class TlsConnectionClass
{
  GTlsConnectionClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.TlsConnectionClass");

    cInstance = *cast(GTlsConnectionClass*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property IOStreamClass parentClass()
  {
    return new IOStreamClass(cast(GIOStreamClass*)&(cast(GTlsConnectionClass*)cPtr).parentClass);
  }

  alias AcceptCertificateFuncType = extern(C) bool function(GTlsConnection* connection, GTlsCertificate* peerCert, GTlsCertificateFlags errors);

  @property AcceptCertificateFuncType acceptCertificate()
  {
    return (cast(GTlsConnectionClass*)cPtr).acceptCertificate;
  }

  alias HandshakeFuncType = extern(C) bool function(GTlsConnection* conn, GCancellable* cancellable, GError** _err);

  @property HandshakeFuncType handshake()
  {
    return (cast(GTlsConnectionClass*)cPtr).handshake;
  }

  alias HandshakeAsyncFuncType = extern(C) void function(GTlsConnection* conn, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property HandshakeAsyncFuncType handshakeAsync()
  {
    return (cast(GTlsConnectionClass*)cPtr).handshakeAsync;
  }

  alias HandshakeFinishFuncType = extern(C) bool function(GTlsConnection* conn, GAsyncResult* result, GError** _err);

  @property HandshakeFinishFuncType handshakeFinish()
  {
    return (cast(GTlsConnectionClass*)cPtr).handshakeFinish;
  }

  alias GetBindingDataFuncType = extern(C) bool function(GTlsConnection* conn, GTlsChannelBindingType type, GByteArray* data, GError** _err);

  @property GetBindingDataFuncType getBindingData()
  {
    return (cast(GTlsConnectionClass*)cPtr).getBindingData;
  }

  alias GetNegotiatedProtocolFuncType = extern(C) const(char)* function(GTlsConnection* conn);

  @property GetNegotiatedProtocolFuncType getNegotiatedProtocol()
  {
    return (cast(GTlsConnectionClass*)cPtr).getNegotiatedProtocol;
  }
}
