module Gio.TlsBackend;

import GObject.ObjectG;
import GObject.Types;
import Gid.Gid;
import Gio.TlsDatabase;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * TLS (Transport Layer Security, aka SSL) and DTLS backend.
 */
interface TlsBackend
{

  static GType getType()
  {
    return g_tls_backend_get_type();
  }

  /**
   * a #GTlsBackend, which will be a
   * dummy object if no TLS backend is available
   */
  static TlsBackend getDefault();

  /**
   * the #GType of @backend's #GTlsCertificate
   * implementation.
   */
  GType getCertificateType();

  /**
   * the #GType of @backend's #GTlsClientConnection
   * implementation.
   */
  GType getClientConnectionType();

  /**
   * the default database, which should be
   * unreffed when done.
   */
  TlsDatabase getDefaultDatabase();

  /**
   * the #GType of @backend’s #GDtlsClientConnection
   * implementation, or %G_TYPE_INVALID if this backend doesn’t support DTLS.
   */
  GType getDtlsClientConnectionType();

  /**
   * the #GType of @backend’s #GDtlsServerConnection
   * implementation, or %G_TYPE_INVALID if this backend doesn’t support DTLS.
   */
  GType getDtlsServerConnectionType();

  /**
   * the #GType of backend's #GTlsFileDatabase implementation.
   */
  GType getFileDatabaseType();

  /**
   * the #GType of @backend's #GTlsServerConnection
   * implementation.
   */
  GType getServerConnectionType();

  /**
   * Set the default #GTlsDatabase used to verify TLS connections
   *
   * Any subsequent call to g_tls_backend_get_default_database() will return
   * the database set in this call.  Existing databases and connections are not
   * modified.
   *
   * Setting a %NULL default database will reset to using the system default
   * database as if g_tls_backend_set_default_database() had never been called.
   */
  void setDefaultDatabase(TlsDatabase database);

  /**
   * whether DTLS is supported
   */
  bool supportsDtls();

  /**
   * whether or not TLS is supported
   */
  bool supportsTls();
}
