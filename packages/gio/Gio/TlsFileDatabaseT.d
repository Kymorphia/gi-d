module Gio.TlsFileDatabaseT;

public import Gio.TlsFileDatabaseIfaceProxy;
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
template TlsFileDatabaseT()
{

}
