module Gio.TlsFileDatabase;

import GLib.ErrorG;
import GObject.ObjectG;
import Gid.gid;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * `GTlsFileDatabase` is implemented by [Gio.TlsDatabase] objects which
 * load their certificate information from a file. It is an interface which
 * TLS library specific subtypes implement.
 */
interface TlsFileDatabase
{

  static GType getType()
  {
    return g_tls_file_database_get_type();
  }

  /**
   * Creates a new #GTlsFileDatabase which uses anchor certificate authorities
   * in anchors to verify certificate chains.
   * The certificates in anchors must be PEM encoded.
   * Params:
   *   anchors = filename of anchor certificate authorities.
   * Returns: the new
   *   #GTlsFileDatabase, or %NULL on error
   */
  static TlsFileDatabase new_(string anchors);
}
