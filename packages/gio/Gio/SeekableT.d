module Gio.SeekableT;

public import GLib.ErrorG;
public import GLib.Types;
public import Gid.Gid;
public import Gio.Cancellable;
public import Gio.Types;
public import Gio.c.functions;
public import Gio.c.types;

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
template SeekableT(TStruct)
{

  /**
   * %TRUE if @seekable can be seeked. %FALSE otherwise.
   */
  override bool canSeek()
  {
    bool _retval;
    _retval = g_seekable_can_seek(cPtr!GSeekable);
    return _retval;
  }

  /**
   * %TRUE if the stream can be truncated, %FALSE otherwise.
   */
  override bool canTruncate()
  {
    bool _retval;
    _retval = g_seekable_can_truncate(cPtr!GSeekable);
    return _retval;
  }

  /**
   * %TRUE if successful. If an error
   * has occurred, this function will return %FALSE and set @error
   * appropriately if present.
   */
  override bool seek(long offset, SeekType type, Cancellable cancellable)
  {
    bool _retval;
    GError *_err;
    _retval = g_seekable_seek(cPtr!GSeekable, offset, type, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * the (positive or zero) offset from the beginning of the
   * buffer, zero if the target is not seekable.
   */
  override long tell()
  {
    long _retval;
    _retval = g_seekable_tell(cPtr!GSeekable);
    return _retval;
  }

  /**
   * %TRUE if successful. If an error
   * has occurred, this function will return %FALSE and set @error
   * appropriately if present.
   */
  override bool truncate(long offset, Cancellable cancellable)
  {
    bool _retval;
    GError *_err;
    _retval = g_seekable_truncate(cPtr!GSeekable, offset, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }
}
