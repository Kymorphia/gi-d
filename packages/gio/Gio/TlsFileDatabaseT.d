module Gio.TlsFileDatabaseT;

public import GLib.ErrorG;
public import GObject.ObjectG;
public import Gid.gid;
public import Gio.Types;
public import Gio.c.functions;
public import Gio.c.types;

/**
 * `GTlsFileDatabase` is implemented by [Gio.TlsDatabase] objects which
 * load their certificate information from a file. It is an interface which
 * TLS library specific subtypes implement.
 */
template TlsFileDatabaseT(TStruct)
{

  /**
   * Creates a new #GTlsFileDatabase which uses anchor certificate authorities
   * in anchors to verify certificate chains.
   * The certificates in anchors must be PEM encoded.
   * Params:
   *   anchors = filename of anchor certificate authorities.
   * Returns: the new
   *   #GTlsFileDatabase, or %NULL on error
   */
  static TlsFileDatabase new_(string anchors)
  {
    GTlsDatabase* _cretval;
    const(char)* _anchors = anchors.toCString(false);
    GError *_err;
    _cretval = g_tls_file_database_new(_anchors, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = _cretval ? ObjectG.getDObject!TlsFileDatabase(cast(GTlsDatabase*)_cretval, true) : null;
    return _retval;
  }
}
