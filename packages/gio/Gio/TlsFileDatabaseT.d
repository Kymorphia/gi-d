module Gio.TlsFileDatabaseT;

public import GLib.ErrorG;
public import GObject.ObjectG;
public import Gid.Gid;
public import Gio.Types;
public import Gio.c.functions;
public import Gio.c.types;

/**
 * #GTlsFileDatabase is implemented by #GTlsDatabase objects which load
 * their certificate information from a file. It is an interface which
 * TLS library specific subtypes implement.
 */
template TlsFileDatabaseT(TStruct)
{

  /**
   * the new
   * #GTlsFileDatabase, or %NULL on error
   */
  static TlsFileDatabase new_(string anchors)
  {
    GTlsDatabase* _cretval;
    const(char)* _anchors = anchors.toCString(false);
    GError *_err;
    _cretval = g_tls_file_database_new(_anchors, &_err);
    if (_err)
      throw new ErrorG(_err);
    TlsFileDatabase _retval = ObjectG.getDObject!TlsFileDatabase(cast(GTlsDatabase*)_cretval, true);
    return _retval;
  }
}
