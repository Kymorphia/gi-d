module Gio.TlsBackendInterface;

import GObject.TypeInterface;
import Gid.gid;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * Provides an interface for describing TLS-related types.
 */
class TlsBackendInterface
{
  GTlsBackendInterface cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.TlsBackendInterface");

    cInstance = *cast(GTlsBackendInterface*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property TypeInterface gIface()
  {
    return new TypeInterface(cast(GTypeInterface*)&(cast(GTlsBackendInterface*)cPtr).gIface);
  }

  alias SupportsTlsFuncType = extern(C) bool function(GTlsBackend* backend);

  @property SupportsTlsFuncType supportsTls()
  {
    return (cast(GTlsBackendInterface*)cPtr).supportsTls;
  }

  alias GetCertificateTypeFuncType = extern(C) GType function();

  @property GetCertificateTypeFuncType getCertificateType()
  {
    return (cast(GTlsBackendInterface*)cPtr).getCertificateType;
  }

  alias GetClientConnectionTypeFuncType = extern(C) GType function();

  @property GetClientConnectionTypeFuncType getClientConnectionType()
  {
    return (cast(GTlsBackendInterface*)cPtr).getClientConnectionType;
  }

  alias GetServerConnectionTypeFuncType = extern(C) GType function();

  @property GetServerConnectionTypeFuncType getServerConnectionType()
  {
    return (cast(GTlsBackendInterface*)cPtr).getServerConnectionType;
  }

  alias GetFileDatabaseTypeFuncType = extern(C) GType function();

  @property GetFileDatabaseTypeFuncType getFileDatabaseType()
  {
    return (cast(GTlsBackendInterface*)cPtr).getFileDatabaseType;
  }

  alias GetDefaultDatabaseFuncType = extern(C) GTlsDatabase* function(GTlsBackend* backend);

  @property GetDefaultDatabaseFuncType getDefaultDatabase()
  {
    return (cast(GTlsBackendInterface*)cPtr).getDefaultDatabase;
  }

  alias SupportsDtlsFuncType = extern(C) bool function(GTlsBackend* backend);

  @property SupportsDtlsFuncType supportsDtls()
  {
    return (cast(GTlsBackendInterface*)cPtr).supportsDtls;
  }

  alias GetDtlsClientConnectionTypeFuncType = extern(C) GType function();

  @property GetDtlsClientConnectionTypeFuncType getDtlsClientConnectionType()
  {
    return (cast(GTlsBackendInterface*)cPtr).getDtlsClientConnectionType;
  }

  alias GetDtlsServerConnectionTypeFuncType = extern(C) GType function();

  @property GetDtlsServerConnectionTypeFuncType getDtlsServerConnectionType()
  {
    return (cast(GTlsBackendInterface*)cPtr).getDtlsServerConnectionType;
  }
}
