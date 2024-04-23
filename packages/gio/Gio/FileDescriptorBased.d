module Gio.FileDescriptorBased;

import Gid.Gid;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * #GFileDescriptorBased is implemented by streams (implementations of
 * #GInputStream or #GOutputStream) that are based on file descriptors.
 *
 * Note that `<gio/gfiledescriptorbased.h>` belongs to the UNIX-specific
 * GIO interfaces, thus you have to use the `gio-unix-2.0.pc` pkg-config
 * file when using it.
 */
interface FileDescriptorBased
{

  static GType getType()
  {
    return g_file_descriptor_based_get_type();
  }

  /**
   * The file descriptor
   */
  int getFd();
}
