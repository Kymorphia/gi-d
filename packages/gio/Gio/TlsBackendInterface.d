module Gio.TlsBackendInterface;

import GLib.c.functions;
import GObject.TypeInterface;
import GObject.Types;
import Gid.Gid;
import Gio.TlsBackend;
import Gio.TlsDatabase;
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
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GTlsBackendInterface))
  {
    return cast(T*)&cInstance;
  }

  @property TypeInterface gIface()
  {
    return new TypeInterface(cast(GTypeInterface*)&cPtr!GTlsBackendInterface.gIface);
  }

  alias SupportsTlsFuncType = extern(C) bool function(GTlsBackend* backend);

  @property SupportsTlsFuncType supportsTls()
  {
    return cPtr!GTlsBackendInterface.supportsTls;
  }

  alias GetCertificateTypeFuncType = extern(C) GType function();

  @property GetCertificateTypeFuncType getCertificateType()
  {
    return cPtr!GTlsBackendInterface.getCertificateType;
  }

  alias GetClientConnectionTypeFuncType = extern(C) GType function();

  @property GetClientConnectionTypeFuncType getClientConnectionType()
  {
    return cPtr!GTlsBackendInterface.getClientConnectionType;
  }

  alias GetServerConnectionTypeFuncType = extern(C) GType function();

  @property GetServerConnectionTypeFuncType getServerConnectionType()
  {
    return cPtr!GTlsBackendInterface.getServerConnectionType;
  }

  alias GetFileDatabaseTypeFuncType = extern(C) GType function();

  @property GetFileDatabaseTypeFuncType getFileDatabaseType()
  {
    return cPtr!GTlsBackendInterface.getFileDatabaseType;
  }

  alias GetDefaultDatabaseFuncType = extern(C) GTlsDatabase* function(GTlsBackend* backend);

  @property GetDefaultDatabaseFuncType getDefaultDatabase()
  {
    return cPtr!GTlsBackendInterface.getDefaultDatabase;
  }

  alias SupportsDtlsFuncType = extern(C) bool function(GTlsBackend* backend);

  @property SupportsDtlsFuncType supportsDtls()
  {
    return cPtr!GTlsBackendInterface.supportsDtls;
  }

  alias GetDtlsClientConnectionTypeFuncType = extern(C) GType function();

  @property GetDtlsClientConnectionTypeFuncType getDtlsClientConnectionType()
  {
    return cPtr!GTlsBackendInterface.getDtlsClientConnectionType;
  }

  alias GetDtlsServerConnectionTypeFuncType = extern(C) GType function();

  @property GetDtlsServerConnectionTypeFuncType getDtlsServerConnectionType()
  {
    return cPtr!GTlsBackendInterface.getDtlsServerConnectionType;
  }
}
