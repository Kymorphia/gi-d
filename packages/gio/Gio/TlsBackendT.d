module Gio.TlsBackendT;

public import GObject.ObjectG;
public import GObject.Types;
public import Gid.gid;
public import Gio.TlsDatabase;
public import Gio.Types;
public import Gio.c.functions;
public import Gio.c.types;

/**
 * TLS $(LPAREN)Transport Layer Security, aka SSL$(RPAREN) and DTLS backend. This is an
 * internal type used to coordinate the different classes implemented
 * by a TLS backend.
 */
template TlsBackendT(TStruct)
{

  /**
   * Gets the default #GTlsBackend for the system.
   * Returns: a #GTlsBackend, which will be a
   *   dummy object if no TLS backend is available
   */
  static TlsBackend getDefault()
  {
    GTlsBackend* _cretval;
    _cretval = g_tls_backend_get_default();
    auto _retval = _cretval ? ObjectG.getDObject!TlsBackend(cast(GTlsBackend*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the #GType of backend's #GTlsCertificate implementation.
   * Returns: the #GType of backend's #GTlsCertificate
   *   implementation.
   */
  override GType getCertificateType()
  {
    GType _retval;
    _retval = g_tls_backend_get_certificate_type(cast(GTlsBackend*)cPtr);
    return _retval;
  }

  /**
   * Gets the #GType of backend's #GTlsClientConnection implementation.
   * Returns: the #GType of backend's #GTlsClientConnection
   *   implementation.
   */
  override GType getClientConnectionType()
  {
    GType _retval;
    _retval = g_tls_backend_get_client_connection_type(cast(GTlsBackend*)cPtr);
    return _retval;
  }

  /**
   * Gets the default #GTlsDatabase used to verify TLS connections.
   * Returns: the default database, which should be
   *   unreffed when done.
   */
  override TlsDatabase getDefaultDatabase()
  {
    GTlsDatabase* _cretval;
    _cretval = g_tls_backend_get_default_database(cast(GTlsBackend*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!TlsDatabase(cast(GTlsDatabase*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Gets the #GType of backend’s #GDtlsClientConnection implementation.
   * Returns: the #GType of backend’s #GDtlsClientConnection
   *   implementation, or %G_TYPE_INVALID if this backend doesn’t support DTLS.
   */
  override GType getDtlsClientConnectionType()
  {
    GType _retval;
    _retval = g_tls_backend_get_dtls_client_connection_type(cast(GTlsBackend*)cPtr);
    return _retval;
  }

  /**
   * Gets the #GType of backend’s #GDtlsServerConnection implementation.
   * Returns: the #GType of backend’s #GDtlsServerConnection
   *   implementation, or %G_TYPE_INVALID if this backend doesn’t support DTLS.
   */
  override GType getDtlsServerConnectionType()
  {
    GType _retval;
    _retval = g_tls_backend_get_dtls_server_connection_type(cast(GTlsBackend*)cPtr);
    return _retval;
  }

  /**
   * Gets the #GType of backend's #GTlsFileDatabase implementation.
   * Returns: the #GType of backend's #GTlsFileDatabase implementation.
   */
  override GType getFileDatabaseType()
  {
    GType _retval;
    _retval = g_tls_backend_get_file_database_type(cast(GTlsBackend*)cPtr);
    return _retval;
  }

  /**
   * Gets the #GType of backend's #GTlsServerConnection implementation.
   * Returns: the #GType of backend's #GTlsServerConnection
   *   implementation.
   */
  override GType getServerConnectionType()
  {
    GType _retval;
    _retval = g_tls_backend_get_server_connection_type(cast(GTlsBackend*)cPtr);
    return _retval;
  }

  /**
   * Set the default #GTlsDatabase used to verify TLS connections
   * Any subsequent call to [Gio.TlsBackend.getDefaultDatabase] will return
   * the database set in this call.  Existing databases and connections are not
   * modified.
   * Setting a %NULL default database will reset to using the system default
   * database as if [Gio.TlsBackend.setDefaultDatabase] had never been called.
   * Params:
   *   database = the #GTlsDatabase
   */
  override void setDefaultDatabase(TlsDatabase database)
  {
    g_tls_backend_set_default_database(cast(GTlsBackend*)cPtr, database ? cast(GTlsDatabase*)database.cPtr(false) : null);
  }

  /**
   * Checks if DTLS is supported. DTLS support may not be available even if TLS
   * support is available, and vice-versa.
   * Returns: whether DTLS is supported
   */
  override bool supportsDtls()
  {
    bool _retval;
    _retval = g_tls_backend_supports_dtls(cast(GTlsBackend*)cPtr);
    return _retval;
  }

  /**
   * Checks if TLS is supported; if this returns %FALSE for the default
   * #GTlsBackend, it means no "real" TLS backend is available.
   * Returns: whether or not TLS is supported
   */
  override bool supportsTls()
  {
    bool _retval;
    _retval = g_tls_backend_supports_tls(cast(GTlsBackend*)cPtr);
    return _retval;
  }
}
