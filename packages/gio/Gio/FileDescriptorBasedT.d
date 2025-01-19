module Gio.FileDescriptorBasedT;

public import Gio.FileDescriptorBasedIfaceProxy;
public import Gid.gid;
public import Gio.Types;
public import Gio.c.functions;
public import Gio.c.types;

/**
 * `GFileDescriptorBased` is an interface for file descriptor based IO.
 * It is implemented by streams $(LPAREN)implementations of [Gio.InputStream] or
 * [Gio.OutputStream]$(RPAREN) that are based on file descriptors.
 * Note that `<gio/gfiledescriptorbased.h>` belongs to the UNIX-specific
 * GIO interfaces, thus you have to use the `gio-unix-2.0.pc` pkg-config
 * file or the `GioUnix-2.0` GIR namespace when using it.
 */
template FileDescriptorBasedT()
{

  /**
   * Gets the underlying file descriptor.
   * Returns: The file descriptor
   */
  override int getFd()
  {
    int _retval;
    _retval = g_file_descriptor_based_get_fd(cast(GFileDescriptorBased*)cPtr);
    return _retval;
  }
}
