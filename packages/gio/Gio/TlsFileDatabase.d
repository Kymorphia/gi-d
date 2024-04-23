module Gio.TlsFileDatabase;

import GLib.ErrorG;
import GObject.ObjectG;
import Gid.Gid;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * #GTlsFileDatabase is implemented by #GTlsDatabase objects which load
 * their certificate information from a file. It is an interface which
 * TLS library specific subtypes implement.
 */
interface TlsFileDatabase
{

  static GType getType()
  {
    return g_tls_file_database_get_type();
  }

  /**
   * the new
   * #GTlsFileDatabase, or %NULL on error
   */
  static TlsFileDatabase new_(string anchors);
}
