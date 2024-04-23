module Gio.TlsBackendT;

public import GObject.ObjectG;
public import GObject.Types;
public import Gid.Gid;
public import Gio.TlsDatabase;
public import Gio.Types;
public import Gio.c.functions;
public import Gio.c.types;

/**
 * TLS (Transport Layer Security, aka SSL) and DTLS backend.
 */
template TlsBackendT(TStruct)
{

  /**
   * a #GTlsBackend, which will be a
   * dummy object if no TLS backend is available
   */
  static TlsBackend getDefault()
  {
    GTlsBackend* _cretval;
    _cretval = g_tls_backend_get_default();
    TlsBackend _retval = ObjectG.getDObject!TlsBackend(cast(GTlsBackend*)_cretval, false);
    return _retval;
  }

  /**
   * the #GType of @backend's #GTlsCertificate
   * implementation.
   */
  override GType getCertificateType()
  {
    GType _retval;
    _retval = g_tls_backend_get_certificate_type(cPtr!GTlsBackend);
    return _retval;
  }

  /**
   * the #GType of @backend's #GTlsClientConnection
   * implementation.
   */
  override GType getClientConnectionType()
  {
    GType _retval;
    _retval = g_tls_backend_get_client_connection_type(cPtr!GTlsBackend);
    return _retval;
  }

  /**
   * the default database, which should be
   * unreffed when done.
   */
  override TlsDatabase getDefaultDatabase()
  {
    GTlsDatabase* _cretval;
    _cretval = g_tls_backend_get_default_database(cPtr!GTlsBackend);
    TlsDatabase _retval = ObjectG.getDObject!TlsDatabase(cast(GTlsDatabase*)_cretval, true);
    return _retval;
  }

  /**
   * the #GType of @backend’s #GDtlsClientConnection
   * implementation, or %G_TYPE_INVALID if this backend doesn’t support DTLS.
   */
  override GType getDtlsClientConnectionType()
  {
    GType _retval;
    _retval = g_tls_backend_get_dtls_client_connection_type(cPtr!GTlsBackend);
    return _retval;
  }

  /**
   * the #GType of @backend’s #GDtlsServerConnection
   * implementation, or %G_TYPE_INVALID if this backend doesn’t support DTLS.
   */
  override GType getDtlsServerConnectionType()
  {
    GType _retval;
    _retval = g_tls_backend_get_dtls_server_connection_type(cPtr!GTlsBackend);
    return _retval;
  }

  /**
   * the #GType of backend's #GTlsFileDatabase implementation.
   */
  override GType getFileDatabaseType()
  {
    GType _retval;
    _retval = g_tls_backend_get_file_database_type(cPtr!GTlsBackend);
    return _retval;
  }

  /**
   * the #GType of @backend's #GTlsServerConnection
   * implementation.
   */
  override GType getServerConnectionType()
  {
    GType _retval;
    _retval = g_tls_backend_get_server_connection_type(cPtr!GTlsBackend);
    return _retval;
  }

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
  override void setDefaultDatabase(TlsDatabase database)
  {
    g_tls_backend_set_default_database(cPtr!GTlsBackend, database ? database.cPtr!GTlsDatabase : null);
  }

  /**
   * whether DTLS is supported
   */
  override bool supportsDtls()
  {
    bool _retval;
    _retval = g_tls_backend_supports_dtls(cPtr!GTlsBackend);
    return _retval;
  }

  /**
   * whether or not TLS is supported
   */
  override bool supportsTls()
  {
    bool _retval;
    _retval = g_tls_backend_supports_tls(cPtr!GTlsBackend);
    return _retval;
  }
}
