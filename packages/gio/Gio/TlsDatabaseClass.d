module Gio.TlsDatabaseClass;

import GLib.ByteArray;
import GLib.List;
import GLib.Types;
import GLib.c.functions;
import GObject.ObjectClass;
import GObject.Types;
import Gid.Gid;
import Gio.AsyncResult;
import Gio.Cancellable;
import Gio.SocketConnectable;
import Gio.TlsCertificate;
import Gio.TlsDatabase;
import Gio.TlsInteraction;
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
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GTlsDatabaseClass))
  {
    return cast(T*)&cInstance;
  }

  @property ObjectClass parentClass()
  {
    return new ObjectClass(cast(GObjectClass*)&cPtr!GTlsDatabaseClass.parentClass);
  }

  alias VerifyChainFuncType = extern(C) GTlsCertificateFlags function(GTlsDatabase* self, GTlsCertificate* chain, const(char)* purpose, GSocketConnectable* identity, GTlsInteraction* interaction, GTlsDatabaseVerifyFlags flags, GCancellable* cancellable, GError** _err);

  @property VerifyChainFuncType verifyChain()
  {
    return cPtr!GTlsDatabaseClass.verifyChain;
  }

  alias VerifyChainAsyncFuncType = extern(C) void function(GTlsDatabase* self, GTlsCertificate* chain, const(char)* purpose, GSocketConnectable* identity, GTlsInteraction* interaction, GTlsDatabaseVerifyFlags flags, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property VerifyChainAsyncFuncType verifyChainAsync()
  {
    return cPtr!GTlsDatabaseClass.verifyChainAsync;
  }

  alias VerifyChainFinishFuncType = extern(C) GTlsCertificateFlags function(GTlsDatabase* self, GAsyncResult* result, GError** _err);

  @property VerifyChainFinishFuncType verifyChainFinish()
  {
    return cPtr!GTlsDatabaseClass.verifyChainFinish;
  }

  alias CreateCertificateHandleFuncType = extern(C) char* function(GTlsDatabase* self, GTlsCertificate* certificate);

  @property CreateCertificateHandleFuncType createCertificateHandle()
  {
    return cPtr!GTlsDatabaseClass.createCertificateHandle;
  }

  alias LookupCertificateForHandleFuncType = extern(C) GTlsCertificate* function(GTlsDatabase* self, const(char)* handle, GTlsInteraction* interaction, GTlsDatabaseLookupFlags flags, GCancellable* cancellable, GError** _err);

  @property LookupCertificateForHandleFuncType lookupCertificateForHandle()
  {
    return cPtr!GTlsDatabaseClass.lookupCertificateForHandle;
  }

  alias LookupCertificateForHandleAsyncFuncType = extern(C) void function(GTlsDatabase* self, const(char)* handle, GTlsInteraction* interaction, GTlsDatabaseLookupFlags flags, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property LookupCertificateForHandleAsyncFuncType lookupCertificateForHandleAsync()
  {
    return cPtr!GTlsDatabaseClass.lookupCertificateForHandleAsync;
  }

  alias LookupCertificateForHandleFinishFuncType = extern(C) GTlsCertificate* function(GTlsDatabase* self, GAsyncResult* result, GError** _err);

  @property LookupCertificateForHandleFinishFuncType lookupCertificateForHandleFinish()
  {
    return cPtr!GTlsDatabaseClass.lookupCertificateForHandleFinish;
  }

  alias LookupCertificateIssuerFuncType = extern(C) GTlsCertificate* function(GTlsDatabase* self, GTlsCertificate* certificate, GTlsInteraction* interaction, GTlsDatabaseLookupFlags flags, GCancellable* cancellable, GError** _err);

  @property LookupCertificateIssuerFuncType lookupCertificateIssuer()
  {
    return cPtr!GTlsDatabaseClass.lookupCertificateIssuer;
  }

  alias LookupCertificateIssuerAsyncFuncType = extern(C) void function(GTlsDatabase* self, GTlsCertificate* certificate, GTlsInteraction* interaction, GTlsDatabaseLookupFlags flags, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property LookupCertificateIssuerAsyncFuncType lookupCertificateIssuerAsync()
  {
    return cPtr!GTlsDatabaseClass.lookupCertificateIssuerAsync;
  }

  alias LookupCertificateIssuerFinishFuncType = extern(C) GTlsCertificate* function(GTlsDatabase* self, GAsyncResult* result, GError** _err);

  @property LookupCertificateIssuerFinishFuncType lookupCertificateIssuerFinish()
  {
    return cPtr!GTlsDatabaseClass.lookupCertificateIssuerFinish;
  }

  alias LookupCertificatesIssuedByFuncType = extern(C) GList* function(GTlsDatabase* self, GByteArray* issuerRawDn, GTlsInteraction* interaction, GTlsDatabaseLookupFlags flags, GCancellable* cancellable, GError** _err);

  @property LookupCertificatesIssuedByFuncType lookupCertificatesIssuedBy()
  {
    return cPtr!GTlsDatabaseClass.lookupCertificatesIssuedBy;
  }

  alias LookupCertificatesIssuedByAsyncFuncType = extern(C) void function(GTlsDatabase* self, GByteArray* issuerRawDn, GTlsInteraction* interaction, GTlsDatabaseLookupFlags flags, GCancellable* cancellable, GAsyncReadyCallback callback, void* userData);

  @property LookupCertificatesIssuedByAsyncFuncType lookupCertificatesIssuedByAsync()
  {
    return cPtr!GTlsDatabaseClass.lookupCertificatesIssuedByAsync;
  }

  alias LookupCertificatesIssuedByFinishFuncType = extern(C) GList* function(GTlsDatabase* self, GAsyncResult* result, GError** _err);

  @property LookupCertificatesIssuedByFinishFuncType lookupCertificatesIssuedByFinish()
  {
    return cPtr!GTlsDatabaseClass.lookupCertificatesIssuedByFinish;
  }
}
