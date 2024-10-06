module Gio.TlsInteractionClass;

import Gid.gid;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * The class for #GTlsInteraction. Derived classes implement the various
 * virtual interaction methods to handle TLS interactions.
 * Derived classes can choose to implement whichever interactions methods they'd
 * like to support by overriding those virtual methods in their class
 * initialization function. If a derived class implements an async method,
 * it must also implement the corresponding finish method.
 * The synchronous interaction methods should implement to display modal dialogs,
 * and the asynchronous methods to display modeless dialogs.
 * If the user cancels an interaction, then the result should be
 * %G_TLS_INTERACTION_FAILED and the error should be set with a domain of
 * %G_IO_ERROR and code of %G_IO_ERROR_CANCELLED.
 */
class TlsInteractionClass
{
  GTlsInteractionClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.TlsInteractionClass");

    cInstance = *cast(GTlsInteractionClass*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  alias AskPasswordFuncType = extern(C) GTlsInteractionResult function(GTlsInteraction* interaction, GTlsPassword* password, GCancellable* cancellable, GError** _err);

  @property AskPasswordFuncType askPassword()
  {
    return (cast(GTlsInteractionClass*)cPtr).askPassword;
  }

  alias AskPasswordAsyncFuncType = extern(C) void function(GTlsInteraction* interaction, GTlsPassword* password, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property AskPasswordAsyncFuncType askPasswordAsync()
  {
    return (cast(GTlsInteractionClass*)cPtr).askPasswordAsync;
  }

  alias AskPasswordFinishFuncType = extern(C) GTlsInteractionResult function(GTlsInteraction* interaction, GAsyncResult* result, GError** _err);

  @property AskPasswordFinishFuncType askPasswordFinish()
  {
    return (cast(GTlsInteractionClass*)cPtr).askPasswordFinish;
  }

  alias RequestCertificateFuncType = extern(C) GTlsInteractionResult function(GTlsInteraction* interaction, GTlsConnection* connection, GTlsCertificateRequestFlags flags, GCancellable* cancellable, GError** _err);

  @property RequestCertificateFuncType requestCertificate()
  {
    return (cast(GTlsInteractionClass*)cPtr).requestCertificate;
  }

  alias RequestCertificateAsyncFuncType = extern(C) void function(GTlsInteraction* interaction, GTlsConnection* connection, GTlsCertificateRequestFlags flags, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property RequestCertificateAsyncFuncType requestCertificateAsync()
  {
    return (cast(GTlsInteractionClass*)cPtr).requestCertificateAsync;
  }

  alias RequestCertificateFinishFuncType = extern(C) GTlsInteractionResult function(GTlsInteraction* interaction, GAsyncResult* result, GError** _err);

  @property RequestCertificateFinishFuncType requestCertificateFinish()
  {
    return (cast(GTlsInteractionClass*)cPtr).requestCertificateFinish;
  }
}
