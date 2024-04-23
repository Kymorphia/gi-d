module Gio.Seekable;

import GLib.ErrorG;
import GLib.Types;
import Gid.Gid;
import Gio.Cancellable;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * #GSeekable is implemented by streams (implementations of
 * #GInputStream or #GOutputStream) that support seeking.
 *
 * Seekable streams largely fall into two categories: resizable and
 * fixed-size.
 *
 * #GSeekable on fixed-sized streams is approximately the same as POSIX
 * lseek() on a block device (for example: attempting to seek past the
 * end of the device is an error).  Fixed streams typically cannot be
 * truncated.
 *
 * #GSeekable on resizable streams is approximately the same as POSIX
 * lseek() on a normal file.  Seeking past the end and writing data will
 * usually cause the stream to resize by introducing zero bytes.
 */
interface Seekable
{

  static GType getType()
  {
    return g_seekable_get_type();
  }

  /**
   * %TRUE if @seekable can be seeked. %FALSE otherwise.
   */
  bool canSeek();

  /**
   * %TRUE if the stream can be truncated, %FALSE otherwise.
   */
  bool canTruncate();

  /**
   * %TRUE if successful. If an error
   * has occurred, this function will return %FALSE and set @error
   * appropriately if present.
   */
  bool seek(long offset, SeekType type, Cancellable cancellable);

  /**
   * the (positive or zero) offset from the beginning of the
   * buffer, zero if the target is not seekable.
   */
  long tell();

  /**
   * %TRUE if successful. If an error
   * has occurred, this function will return %FALSE and set @error
   * appropriately if present.
   */
  bool truncate(long offset, Cancellable cancellable);
}
