module Gio.TlsConnectionClass;

import GLib.ByteArray;
import GLib.Types;
import GLib.c.functions;
import Gid.Gid;
import Gio.AsyncResult;
import Gio.Cancellable;
import Gio.IOStreamClass;
import Gio.TlsCertificate;
import Gio.TlsConnection;
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
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GTlsConnectionClass))
  {
    return cast(T*)&cInstance;
  }

  @property IOStreamClass parentClass()
  {
    return new IOStreamClass(cast(GIOStreamClass*)&cPtr!GTlsConnectionClass.parentClass);
  }

  alias AcceptCertificateFuncType = extern(C) bool function(GTlsConnection* connection, GTlsCertificate* peerCert, GTlsCertificateFlags errors);

  @property AcceptCertificateFuncType acceptCertificate()
  {
    return cPtr!GTlsConnectionClass.acceptCertificate;
  }

  alias HandshakeFuncType = extern(C) bool function(GTlsConnection* conn, GCancellable* cancellable, GError** _err);

  @property HandshakeFuncType handshake()
  {
    return cPtr!GTlsConnectionClass.handshake;
  }

  alias HandshakeAsyncFuncType = extern(C) void function(GTlsConnection* conn, int ioPriority, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property HandshakeAsyncFuncType handshakeAsync()
  {
    return cPtr!GTlsConnectionClass.handshakeAsync;
  }

  alias HandshakeFinishFuncType = extern(C) bool function(GTlsConnection* conn, GAsyncResult* result, GError** _err);

  @property HandshakeFinishFuncType handshakeFinish()
  {
    return cPtr!GTlsConnectionClass.handshakeFinish;
  }

  alias GetBindingDataFuncType = extern(C) bool function(GTlsConnection* conn, GTlsChannelBindingType type, GByteArray* data, GError** _err);

  @property GetBindingDataFuncType getBindingData()
  {
    return cPtr!GTlsConnectionClass.getBindingData;
  }

  alias GetNegotiatedProtocolFuncType = extern(C) const(char)* function(GTlsConnection* conn);

  @property GetNegotiatedProtocolFuncType getNegotiatedProtocol()
  {
    return cPtr!GTlsConnectionClass.getNegotiatedProtocol;
  }
}
