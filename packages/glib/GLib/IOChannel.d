module GLib.IOChannel;

import GLib.Boxed;
import GLib.ErrorG;
import GLib.String;
import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.Gid;

/**
 * A data structure representing an IO Channel. The fields should be
 * considered private and should only be accessed with the following
 * functions.
 */
class IOChannel : Boxed
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  T* cPtr(T)(bool makeCopy = false)
  if (is(T == GIOChannel))
  {
    return makeCopy ? copy_!T : cast(T*)cInstancePtr;
  }

  static GType getType()
  {
    return g_io_channel_get_type();
  }

  /**
   * A #GIOChannel on success, %NULL on failure.
   */
  static IOChannel newFile(string filename, string mode)
  {
    GIOChannel* _cretval;
    const(char)* _filename = filename.toCString(false);
    const(char)* _mode = mode.toCString(false);
    GError *_err;
    _cretval = g_io_channel_new_file(_filename, _mode, &_err);
    if (_err)
      throw new IOChannelException(_err);
    IOChannel _retval = new IOChannel(cast(GIOChannel*)_cretval, true);
    return _retval;
  }

  /**
   * a new #GIOChannel.
   */
  static IOChannel unixNew(int fd)
  {
    GIOChannel* _cretval;
    _cretval = g_io_channel_unix_new(fd);
    IOChannel _retval = new IOChannel(cast(GIOChannel*)_cretval, true);
    return _retval;
  }

  /**
   * Close an IO channel. Any pending data to be written will be
   * flushed, ignoring errors. The channel will not be freed until the
   * last reference is dropped using g_io_channel_unref().
   */
  void close()
  {
    g_io_channel_close(cPtr!GIOChannel);
  }

  /**
   * the status of the operation: One of
   * %G_IO_STATUS_NORMAL, %G_IO_STATUS_AGAIN, or
   * %G_IO_STATUS_ERROR.
   */
  IOStatus flush()
  {
    GIOStatus _cretval;
    GError *_err;
    _cretval = g_io_channel_flush(cPtr!GIOChannel, &_err);
    if (_err)
      throw new IOChannelException(_err);
    IOStatus _retval = cast(IOStatus)_cretval;
    return _retval;
  }

  /**
   * A #GIOCondition
   */
  IOCondition getBufferCondition()
  {
    GIOCondition _cretval;
    _cretval = g_io_channel_get_buffer_condition(cPtr!GIOChannel);
    IOCondition _retval = cast(IOCondition)_cretval;
    return _retval;
  }

  /**
   * the size of the buffer.
   */
  size_t getBufferSize()
  {
    size_t _retval;
    _retval = g_io_channel_get_buffer_size(cPtr!GIOChannel);
    return _retval;
  }

  /**
   * %TRUE if the @channel is buffered.
   */
  bool getBuffered()
  {
    bool _retval;
    _retval = g_io_channel_get_buffered(cPtr!GIOChannel);
    return _retval;
  }

  /**
   * %TRUE if the channel will be closed, %FALSE otherwise.
   */
  bool getCloseOnUnref()
  {
    bool _retval;
    _retval = g_io_channel_get_close_on_unref(cPtr!GIOChannel);
    return _retval;
  }

  /**
   * A string containing the encoding, this string is
   * owned by GLib and must not be freed.
   */
  string getEncoding()
  {
    const(char)* _cretval;
    _cretval = g_io_channel_get_encoding(cPtr!GIOChannel);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * the flags which are set on the channel
   */
  IOFlags getFlags()
  {
    GIOFlags _cretval;
    _cretval = g_io_channel_get_flags(cPtr!GIOChannel);
    IOFlags _retval = cast(IOFlags)_cretval;
    return _retval;
  }

  /**
   * The line termination string. This value
   * is owned by GLib and must not be freed.
   */
  string getLineTerm(out int length)
  {
    const(char)* _cretval;
    _cretval = g_io_channel_get_line_term(cPtr!GIOChannel, cast(int*)&length);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Initializes a #GIOChannel struct.
   *
   * This is called by each of the above functions when creating a
   * #GIOChannel, and so is not often needed by the application
   * programmer (unless you are creating a new type of #GIOChannel).
   */
  void init_()
  {
    g_io_channel_init(cPtr!GIOChannel);
  }

  /**
   * %G_IO_ERROR_NONE if the operation was successful.
   */
  IOError read(ref ubyte[] buf, out size_t bytesRead)
  {
    GIOError _cretval;
    _cretval = g_io_channel_read(cPtr!GIOChannel, buf.ptr, buf ? cast(size_t)buf.length : 0, cast(size_t*)&bytesRead);
    IOError _retval = cast(IOError)_cretval;
    return _retval;
  }

  /**
   * the status of the operation.
   */
  IOStatus readChars(ref ubyte[] buf, out size_t bytesRead)
  {
    GIOStatus _cretval;
    GError *_err;
    _cretval = g_io_channel_read_chars(cPtr!GIOChannel, buf.ptr, buf ? cast(size_t)buf.length : 0, cast(size_t*)&bytesRead, &_err);
    if (_err)
      throw new IOChannelException(_err);
    IOStatus _retval = cast(IOStatus)_cretval;
    return _retval;
  }

  /**
   * the status of the operation.
   */
  IOStatus readLine(out string strReturn, out size_t length, out size_t terminatorPos)
  {
    GIOStatus _cretval;
    char* _strReturn;
    GError *_err;
    _cretval = g_io_channel_read_line(cPtr!GIOChannel, &_strReturn, cast(size_t*)&length, cast(size_t*)&terminatorPos, &_err);
    if (_err)
      throw new IOChannelException(_err);
    IOStatus _retval = cast(IOStatus)_cretval;
    strReturn = _strReturn.fromCString(true);
    return _retval;
  }

  /**
   * the status of the operation.
   */
  IOStatus readLineString(String buffer, out size_t terminatorPos)
  {
    GIOStatus _cretval;
    GError *_err;
    _cretval = g_io_channel_read_line_string(cPtr!GIOChannel, buffer ? buffer.cPtr!GString : null, cast(size_t*)&terminatorPos, &_err);
    if (_err)
      throw new IOChannelException(_err);
    IOStatus _retval = cast(IOStatus)_cretval;
    return _retval;
  }

  /**
   * %G_IO_STATUS_NORMAL on success.
   * This function never returns %G_IO_STATUS_EOF.
   */
  IOStatus readToEnd(out ubyte[] strReturn)
  {
    GIOStatus _cretval;
    ubyte* _strReturn;
    size_t _length;
    GError *_err;
    _cretval = g_io_channel_read_to_end(cPtr!GIOChannel, &_strReturn, &_length, &_err);
    if (_err)
      throw new IOChannelException(_err);
    IOStatus _retval = cast(IOStatus)_cretval;
    strReturn = _strReturn[0 .. _length];
    g_free(cast(void*)_strReturn);
    return _retval;
  }

  /**
   * a #GIOStatus
   */
  IOStatus readUnichar(out dchar thechar)
  {
    GIOStatus _cretval;
    GError *_err;
    _cretval = g_io_channel_read_unichar(cPtr!GIOChannel, cast(dchar*)&thechar, &_err);
    if (_err)
      throw new IOChannelException(_err);
    IOStatus _retval = cast(IOStatus)_cretval;
    return _retval;
  }

  /**
   * %G_IO_ERROR_NONE if the operation was successful.
   */
  IOError seek(long offset, SeekType type)
  {
    GIOError _cretval;
    _cretval = g_io_channel_seek(cPtr!GIOChannel, offset, type);
    IOError _retval = cast(IOError)_cretval;
    return _retval;
  }

  /**
   * the status of the operation.
   */
  IOStatus seekPosition(long offset, SeekType type)
  {
    GIOStatus _cretval;
    GError *_err;
    _cretval = g_io_channel_seek_position(cPtr!GIOChannel, offset, type, &_err);
    if (_err)
      throw new IOChannelException(_err);
    IOStatus _retval = cast(IOStatus)_cretval;
    return _retval;
  }

  /**
   * Sets the buffer size.
   */
  void setBufferSize(size_t size)
  {
    g_io_channel_set_buffer_size(cPtr!GIOChannel, size);
  }

  /**
   * The buffering state can only be set if the channel's encoding
   * is %NULL. For any other encoding, the channel must be buffered.
   *
   * A buffered channel can only be set unbuffered if the channel's
   * internal buffers have been flushed. Newly created channels or
   * channels which have returned %G_IO_STATUS_EOF
   * not require such a flush. For write-only channels, a call to
   * g_io_channel_flush () is sufficient. For all other channels,
   * the buffers may be flushed by a call to g_io_channel_seek_position ().
   * This includes the possibility of seeking with seek type %G_SEEK_CUR
   * and an offset of zero. Note that this means that socket-based
   * channels cannot be set unbuffered once they have had data
   * read from them.
   *
   * On unbuffered channels, it is safe to mix read and write
   * calls from the new and old APIs, if this is necessary for
   * maintaining old code.
   *
   * The default state of the channel is buffered.
   */
  void setBuffered(bool buffered)
  {
    g_io_channel_set_buffered(cPtr!GIOChannel, buffered);
  }

  /**
   * Whether to close the channel on the final unref of the #GIOChannel
   * data structure. The default value of this is %TRUE for channels
   * created by g_io_channel_new_file (), and %FALSE for all other channels.
   *
   * Setting this flag to %TRUE for a channel you have already closed
   * can cause problems when the final reference to the #GIOChannel is dropped.
   */
  void setCloseOnUnref(bool doClose)
  {
    g_io_channel_set_close_on_unref(cPtr!GIOChannel, doClose);
  }

  /**
   * %G_IO_STATUS_NORMAL if the encoding was successfully set
   */
  IOStatus setEncoding(string encoding)
  {
    GIOStatus _cretval;
    const(char)* _encoding = encoding.toCString(false);
    GError *_err;
    _cretval = g_io_channel_set_encoding(cPtr!GIOChannel, _encoding, &_err);
    if (_err)
      throw new IOChannelException(_err);
    IOStatus _retval = cast(IOStatus)_cretval;
    return _retval;
  }

  /**
   * the status of the operation.
   */
  IOStatus setFlags(IOFlags flags)
  {
    GIOStatus _cretval;
    GError *_err;
    _cretval = g_io_channel_set_flags(cPtr!GIOChannel, flags, &_err);
    if (_err)
      throw new IOChannelException(_err);
    IOStatus _retval = cast(IOStatus)_cretval;
    return _retval;
  }

  /**
   * This sets the string that #GIOChannel uses to determine
   * where in the file a line break occurs.
   */
  void setLineTerm(string lineTerm, int length)
  {
    const(char)* _lineTerm = lineTerm.toCString(false);
    g_io_channel_set_line_term(cPtr!GIOChannel, _lineTerm, length);
  }

  /**
   * the status of the operation.
   */
  IOStatus shutdown(bool flush)
  {
    GIOStatus _cretval;
    GError *_err;
    _cretval = g_io_channel_shutdown(cPtr!GIOChannel, flush, &_err);
    if (_err)
      throw new IOChannelException(_err);
    IOStatus _retval = cast(IOStatus)_cretval;
    return _retval;
  }

  /**
   * the file descriptor of the #GIOChannel.
   */
  int unixGetFd()
  {
    int _retval;
    _retval = g_io_channel_unix_get_fd(cPtr!GIOChannel);
    return _retval;
  }

  /**
   * %G_IO_ERROR_NONE if the operation was successful.
   */
  IOError write(string buf, size_t count, out size_t bytesWritten)
  {
    GIOError _cretval;
    const(char)* _buf = buf.toCString(false);
    _cretval = g_io_channel_write(cPtr!GIOChannel, _buf, count, cast(size_t*)&bytesWritten);
    IOError _retval = cast(IOError)_cretval;
    return _retval;
  }

  /**
   * the status of the operation.
   */
  IOStatus writeChars(ubyte[] buf, out size_t bytesWritten)
  {
    GIOStatus _cretval;
    auto _buf = cast(const(ubyte)*)buf.ptr;
    GError *_err;
    _cretval = g_io_channel_write_chars(cPtr!GIOChannel, _buf, buf ? cast(ptrdiff_t)buf.length : 0, cast(size_t*)&bytesWritten, &_err);
    if (_err)
      throw new IOChannelException(_err);
    IOStatus _retval = cast(IOStatus)_cretval;
    return _retval;
  }

  /**
   * a #GIOStatus
   */
  IOStatus writeUnichar(dchar thechar)
  {
    GIOStatus _cretval;
    GError *_err;
    _cretval = g_io_channel_write_unichar(cPtr!GIOChannel, thechar, &_err);
    if (_err)
      throw new IOChannelException(_err);
    IOStatus _retval = cast(IOStatus)_cretval;
    return _retval;
  }

  /**
   * a #GIOChannelError error number, e.g.
   * %G_IO_CHANNEL_ERROR_INVAL.
   */
  static IOChannelError errorFromErrno(int en)
  {
    GIOChannelError _cretval;
    _cretval = g_io_channel_error_from_errno(en);
    IOChannelError _retval = cast(IOChannelError)_cretval;
    return _retval;
  }

  static Quark errorQuark()
  {
    Quark _retval;
    _retval = g_io_channel_error_quark();
    return _retval;
  }
}

class IOChannelException : ErrorG
{
  this(GError* err)
  {
    super(err);
  }

  this(Code code, string msg)
  {
    super(IOChannel.errorQuark, cast(int)code, msg);
  }

  alias Code = GIOChannelError;
}
