module Gio.FileDescriptorBasedT;

public import Gid.Gid;
public import Gio.Types;
public import Gio.c.functions;
public import Gio.c.types;

/**
 * #GFileDescriptorBased is implemented by streams (implementations of
 * #GInputStream or #GOutputStream) that are based on file descriptors.
 *
 * Note that `<gio/gfiledescriptorbased.h>` belongs to the UNIX-specific
 * GIO interfaces, thus you have to use the `gio-unix-2.0.pc` pkg-config
 * file when using it.
 */
template FileDescriptorBasedT(TStruct)
{

  /**
   * The file descriptor
   */
  override int getFd()
  {
    int _retval;
    _retval = g_file_descriptor_based_get_fd(cPtr!GFileDescriptorBased);
    return _retval;
  }
}
