module Gio.Seekable;

public import Gio.SeekableIfaceProxy;
import GLib.ErrorG;
import GLib.Types;
import Gid.gid;
import Gio.Cancellable;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * `GSeekable` is implemented by streams $(LPAREN)implementations of
 * [Gio.InputStream] or [Gio.OutputStream]$(RPAREN) that support seeking.
 * Seekable streams largely fall into two categories: resizable and
 * fixed-size.
 * `GSeekable` on fixed-sized streams is approximately the same as POSIX
 * [`lseek$(LPAREN)$(RPAREN)`]$(LPAREN)$(RPAREN)(man:lseek2) on a block device $(LPAREN)for example: attempting to seek
 * past the end of the device is an error$(RPAREN).  Fixed streams typically cannot be
 * truncated.
 * `GSeekable` on resizable streams is approximately the same as POSIX
 * [`lseek$(LPAREN)$(RPAREN)`]$(LPAREN)$(RPAREN)(man:lseek2) on a normal file.  Seeking past the end and writing
 * data will usually cause the stream to resize by introducing zero bytes.
 */
interface Seekable
{

  static GType getType()
  {
    return g_seekable_get_type();
  }

  /**
   * Tests if the stream supports the #GSeekableIface.
   * Returns: %TRUE if seekable can be seeked. %FALSE otherwise.
   */
  bool canSeek();

  /**
   * Tests if the length of the stream can be adjusted with
   * [Gio.Seekable.truncate].
   * Returns: %TRUE if the stream can be truncated, %FALSE otherwise.
   */
  bool canTruncate();

  /**
   * Seeks in the stream by the given offset, modified by type.
   * Attempting to seek past the end of the stream will have different
   * results depending on if the stream is fixed-sized or resizable.  If
   * the stream is resizable then seeking past the end and then writing
   * will result in zeros filling the empty space.  Seeking past the end
   * of a resizable stream and reading will result in EOF.  Seeking past
   * the end of a fixed-sized stream will fail.
   * Any operation that would result in a negative offset will fail.
   * If cancellable is not %NULL, then the operation can be cancelled by
   * triggering the cancellable object from another thread. If the operation
   * was cancelled, the error %G_IO_ERROR_CANCELLED will be returned.
   * Params:
   *   offset = a #goffset.
   *   type = a #GSeekType.
   *   cancellable = optional #GCancellable object, %NULL to ignore.
   * Returns: %TRUE if successful. If an error
   *   has occurred, this function will return %FALSE and set error
   *   appropriately if present.
   */
  bool seek(long offset, SeekType type, Cancellable cancellable);

  /**
   * Tells the current position within the stream.
   * Returns: the $(LPAREN)positive or zero$(RPAREN) offset from the beginning of the
   *   buffer, zero if the target is not seekable.
   */
  long tell();

  /**
   * Sets the length of the stream to offset. If the stream was previously
   * larger than offset, the extra data is discarded. If the stream was
   * previously shorter than offset, it is extended with NUL $(LPAREN)'\0'$(RPAREN) bytes.
   * If cancellable is not %NULL, then the operation can be cancelled by
   * triggering the cancellable object from another thread. If the operation
   * was cancelled, the error %G_IO_ERROR_CANCELLED will be returned. If an
   * operation was partially finished when the operation was cancelled the
   * partial result will be returned, without an error.
   * Params:
   *   offset = new length for seekable, in bytes.
   *   cancellable = optional #GCancellable object, %NULL to ignore.
   * Returns: %TRUE if successful. If an error
   *   has occurred, this function will return %FALSE and set error
   *   appropriately if present.
   */
  bool truncate(long offset, Cancellable cancellable);
}
