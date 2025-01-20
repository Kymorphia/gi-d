module Gio.TlsDatabaseClass;

import GObject.ObjectClass;
import Gid.gid;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * The class for #GTlsDatabase. Derived classes should implement the various
 * virtual methods. _async and _finish methods have a default
 * implementation that runs the corresponding sync method in a thread.
 */
class TlsDatabaseClass
{
  GTlsDatabaseClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.TlsDatabaseClass");

    cInstance = *cast(GTlsDatabaseClass*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property ObjectClass parentClass()
  {
    return new ObjectClass(cast(GObjectClass*)&(cast(GTlsDatabaseClass*)cPtr).parentClass);
  }

  alias VerifyChainFuncType = extern(C) GTlsCertificateFlags function(GTlsDatabase* self, GTlsCertificate* chain, const(char)* purpose, GSocketConnectable* identity, GTlsInteraction* interaction, GTlsDatabaseVerifyFlags flags, GCancellable* cancellable, GError** _err);

  @property VerifyChainFuncType verifyChain()
  {
    return (cast(GTlsDatabaseClass*)cPtr).verifyChain;
  }

  alias VerifyChainAsyncFuncType = extern(C) void function(GTlsDatabase* self, GTlsCertificate* chain, const(char)* purpose, GSocketConnectable* identity, GTlsInteraction* interaction, GTlsDatabaseVerifyFlags flags, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property VerifyChainAsyncFuncType verifyChainAsync()
  {
    return (cast(GTlsDatabaseClass*)cPtr).verifyChainAsync;
  }

  alias VerifyChainFinishFuncType = extern(C) GTlsCertificateFlags function(GTlsDatabase* self, GAsyncResult* result, GError** _err);

  @property VerifyChainFinishFuncType verifyChainFinish()
  {
    return (cast(GTlsDatabaseClass*)cPtr).verifyChainFinish;
  }

  alias CreateCertificateHandleFuncType = extern(C) char* function(GTlsDatabase* self, GTlsCertificate* certificate);

  @property CreateCertificateHandleFuncType createCertificateHandle()
  {
    return (cast(GTlsDatabaseClass*)cPtr).createCertificateHandle;
  }

  alias LookupCertificateForHandleFuncType = extern(C) GTlsCertificate* function(GTlsDatabase* self, const(char)* handle, GTlsInteraction* interaction, GTlsDatabaseLookupFlags flags, GCancellable* cancellable, GError** _err);

  @property LookupCertificateForHandleFuncType lookupCertificateForHandle()
  {
    return (cast(GTlsDatabaseClass*)cPtr).lookupCertificateForHandle;
  }

  alias LookupCertificateForHandleAsyncFuncType = extern(C) void function(GTlsDatabase* self, const(char)* handle, GTlsInteraction* interaction, GTlsDatabaseLookupFlags flags, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property LookupCertificateForHandleAsyncFuncType lookupCertificateForHandleAsync()
  {
    return (cast(GTlsDatabaseClass*)cPtr).lookupCertificateForHandleAsync;
  }

  alias LookupCertificateForHandleFinishFuncType = extern(C) GTlsCertificate* function(GTlsDatabase* self, GAsyncResult* result, GError** _err);

  @property LookupCertificateForHandleFinishFuncType lookupCertificateForHandleFinish()
  {
    return (cast(GTlsDatabaseClass*)cPtr).lookupCertificateForHandleFinish;
  }

  alias LookupCertificateIssuerFuncType = extern(C) GTlsCertificate* function(GTlsDatabase* self, GTlsCertificate* certificate, GTlsInteraction* interaction, GTlsDatabaseLookupFlags flags, GCancellable* cancellable, GError** _err);

  @property LookupCertificateIssuerFuncType lookupCertificateIssuer()
  {
    return (cast(GTlsDatabaseClass*)cPtr).lookupCertificateIssuer;
  }

  alias LookupCertificateIssuerAsyncFuncType = extern(C) void function(GTlsDatabase* self, GTlsCertificate* certificate, GTlsInteraction* interaction, GTlsDatabaseLookupFlags flags, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property LookupCertificateIssuerAsyncFuncType lookupCertificateIssuerAsync()
  {
    return (cast(GTlsDatabaseClass*)cPtr).lookupCertificateIssuerAsync;
  }

  alias LookupCertificateIssuerFinishFuncType = extern(C) GTlsCertificate* function(GTlsDatabase* self, GAsyncResult* result, GError** _err);

  @property LookupCertificateIssuerFinishFuncType lookupCertificateIssuerFinish()
  {
    return (cast(GTlsDatabaseClass*)cPtr).lookupCertificateIssuerFinish;
  }

  alias LookupCertificatesIssuedByFuncType = extern(C) GList* function(GTlsDatabase* self, GByteArray* issuerRawDn, GTlsInteraction* interaction, GTlsDatabaseLookupFlags flags, GCancellable* cancellable, GError** _err);

  @property LookupCertificatesIssuedByFuncType lookupCertificatesIssuedBy()
  {
    return (cast(GTlsDatabaseClass*)cPtr).lookupCertificatesIssuedBy;
  }

  alias LookupCertificatesIssuedByAsyncFuncType = extern(C) void function(GTlsDatabase* self, GByteArray* issuerRawDn, GTlsInteraction* interaction, GTlsDatabaseLookupFlags flags, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property LookupCertificatesIssuedByAsyncFuncType lookupCertificatesIssuedByAsync()
  {
    return (cast(GTlsDatabaseClass*)cPtr).lookupCertificatesIssuedByAsync;
  }

  alias LookupCertificatesIssuedByFinishFuncType = extern(C) GList* function(GTlsDatabase* self, GAsyncResult* result, GError** _err);

  @property LookupCertificatesIssuedByFinishFuncType lookupCertificatesIssuedByFinish()
  {
    return (cast(GTlsDatabaseClass*)cPtr).lookupCertificatesIssuedByFinish;
  }
}
