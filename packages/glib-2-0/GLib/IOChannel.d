module GLib.IOChannel;

import GLib.Boxed;
import GLib.ErrorG;
import GLib.String;
import GLib.Types;
import GLib.c.functions;
import GLib.c.types;
import Gid.gid;

/**
 * The `GIOChannel` data type aims to provide a portable method for
 * using file descriptors, pipes, and sockets, and integrating them
 * into the main event loop $(LPAREN)see [GLib.MainContext]$(RPAREN). Currently,
 * full support is available on UNIX platforms; support for Windows
 * is only partially complete.
 * To create a new `GIOChannel` on UNIX systems use
 * [GLib.IOChannel.unixNew]. This works for plain file descriptors,
 * pipes and sockets. Alternatively, a channel can be created for a
 * file in a system independent manner using [GLib.IOChannel.newFile].
 * Once a `GIOChannel` has been created, it can be used in a generic
 * manner with the functions [GLib.IOChannel.readChars],
 * [GLib.IOChannel.writeChars], [GLib.IOChannel.seekPosition],
 * and [GLib.IOChannel.shutdown].
 * To add a `GIOChannel` to the main event loop, use func@GLib.io_add_watch or
 * func@GLib.io_add_watch_full. Here you specify which events you are
 * interested in on the `GIOChannel`, and provide a function to be called
 * whenever these events occur.
 * `GIOChannel` instances are created with an initial reference count of 1.
 * [GLib.IOChannel.ref_] and [GLib.IOChannel.unref] can be used to
 * increment or decrement the reference count respectively. When the
 * reference count falls to 0, the `GIOChannel` is freed. $(LPAREN)Though it
 * isn’t closed automatically, unless it was created using
 * [GLib.IOChannel.newFile].$(RPAREN) Using func@GLib.io_add_watch or
 * func@GLib.io_add_watch_full increments a channel’s reference count.
 * The new functions [GLib.IOChannel.readChars],
 * [GLib.IOChannel.readLine], [GLib.IOChannel.readLineString],
 * [GLib.IOChannel.readToEnd], [GLib.IOChannel.writeChars],
 * [GLib.IOChannel.seekPosition], and [GLib.IOChannel.flush]
 * should not be mixed with the deprecated functions
 * [GLib.IOChannel.read], [GLib.IOChannel.write], and
 * [GLib.IOChannel.seek] on the same channel.
 */
class IOChannel : Boxed
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  void* cPtr(bool makeCopy = false)
  {
    return makeCopy ? copy_ : cInstancePtr;
  }

  static GType getType()
  {
    return g_io_channel_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Open a file filename as a #GIOChannel using mode mode. This
   * channel will be closed when the last reference to it is dropped,
   * so there is no need to call [GLib.IOChannel.close] $(LPAREN)though doing
   * so will not cause problems, as long as no attempt is made to
   * access the channel after it is closed$(RPAREN).
   * Params:
   *   filename = A string containing the name of a file
   *   mode = One of "r", "w", "a", "r+", "w+", "a+". These have
   *     the same meaning as in fopen$(LPAREN)$(RPAREN)
   * Returns: A #GIOChannel on success, %NULL on failure.
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
    auto _retval = _cretval ? new IOChannel(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Creates a new #GIOChannel given a file descriptor. On UNIX systems
   * this works for plain files, pipes, and sockets.
   * The returned #GIOChannel has a reference count of 1.
   * The default encoding for #GIOChannel is UTF-8. If your application
   * is reading output from a command using via pipe, you may need to set
   * the encoding to the encoding of the current locale $(LPAREN)see
   * [GLib.Global.getCharset]$(RPAREN) with the [GLib.IOChannel.setEncoding] function.
   * By default, the fd passed will not be closed when the final reference
   * to the #GIOChannel data structure is dropped.
   * If you want to read raw binary data without interpretation, then
   * call the [GLib.IOChannel.setEncoding] function with %NULL for the
   * encoding argument.
   * This function is available in GLib on Windows, too, but you should
   * avoid using it on Windows. The domain of file descriptors and
   * sockets overlap. There is no way for GLib to know which one you mean
   * in case the argument you pass to this function happens to be both a
   * valid file descriptor and socket. If that happens a warning is
   * issued, and GLib assumes that it is the file descriptor you mean.
   * Params:
   *   fd = a file descriptor.
   * Returns: a new #GIOChannel.
   */
  static IOChannel unixNew(int fd)
  {
    GIOChannel* _cretval;
    _cretval = g_io_channel_unix_new(fd);
    auto _retval = _cretval ? new IOChannel(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Close an IO channel. Any pending data to be written will be
   * flushed, ignoring errors. The channel will not be freed until the
   * last reference is dropped using [GLib.IOChannel.unref].

   * Deprecated: Use [GLib.IOChannel.shutdown] instead.
   */
  void close()
  {
    g_io_channel_close(cast(GIOChannel*)cPtr);
  }

  /**
   * Flushes the write buffer for the GIOChannel.
   * Returns: the status of the operation: One of
   *   %G_IO_STATUS_NORMAL, %G_IO_STATUS_AGAIN, or
   *   %G_IO_STATUS_ERROR.
   */
  IOStatus flush()
  {
    GIOStatus _cretval;
    GError *_err;
    _cretval = g_io_channel_flush(cast(GIOChannel*)cPtr, &_err);
    if (_err)
      throw new IOChannelException(_err);
    IOStatus _retval = cast(IOStatus)_cretval;
    return _retval;
  }

  /**
   * This function returns a #GIOCondition depending on whether there
   * is data to be read/space to write data in the internal buffers in
   * the #GIOChannel. Only the flags %G_IO_IN and %G_IO_OUT may be set.
   * Returns: A #GIOCondition
   */
  IOCondition getBufferCondition()
  {
    GIOCondition _cretval;
    _cretval = g_io_channel_get_buffer_condition(cast(GIOChannel*)cPtr);
    IOCondition _retval = cast(IOCondition)_cretval;
    return _retval;
  }

  /**
   * Gets the buffer size.
   * Returns: the size of the buffer.
   */
  size_t getBufferSize()
  {
    size_t _retval;
    _retval = g_io_channel_get_buffer_size(cast(GIOChannel*)cPtr);
    return _retval;
  }

  /**
   * Returns whether channel is buffered.
   * Returns: %TRUE if the channel is buffered.
   */
  bool getBuffered()
  {
    bool _retval;
    _retval = g_io_channel_get_buffered(cast(GIOChannel*)cPtr);
    return _retval;
  }

  /**
   * Returns whether the file/socket/whatever associated with channel
   * will be closed when channel receives its final unref and is
   * destroyed. The default value of this is %TRUE for channels created
   * by g_io_channel_new_file $(LPAREN)$(RPAREN), and %FALSE for all other channels.
   * Returns: %TRUE if the channel will be closed, %FALSE otherwise.
   */
  bool getCloseOnUnref()
  {
    bool _retval;
    _retval = g_io_channel_get_close_on_unref(cast(GIOChannel*)cPtr);
    return _retval;
  }

  /**
   * Gets the encoding for the input/output of the channel.
   * The internal encoding is always UTF-8. The encoding %NULL
   * makes the channel safe for binary data.
   * Returns: A string containing the encoding, this string is
   *   owned by GLib and must not be freed.
   */
  string getEncoding()
  {
    const(char)* _cretval;
    _cretval = g_io_channel_get_encoding(cast(GIOChannel*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Gets the current flags for a #GIOChannel, including read-only
   * flags such as %G_IO_FLAG_IS_READABLE.
   * The values of the flags %G_IO_FLAG_IS_READABLE and %G_IO_FLAG_IS_WRITABLE
   * are cached for internal use by the channel when it is created.
   * If they should change at some later point $(LPAREN)e.g. partial shutdown
   * of a socket with the UNIX shutdown$(LPAREN)$(RPAREN) function$(RPAREN), the user
   * should immediately call [GLib.IOChannel.getFlags] to update
   * the internal values of these flags.
   * Returns: the flags which are set on the channel
   */
  IOFlags getFlags()
  {
    GIOFlags _cretval;
    _cretval = g_io_channel_get_flags(cast(GIOChannel*)cPtr);
    IOFlags _retval = cast(IOFlags)_cretval;
    return _retval;
  }

  /**
   * This returns the string that #GIOChannel uses to determine
   * where in the file a line break occurs. A value of %NULL
   * indicates autodetection.
   * Params:
   *   length = a location to return the length of the line terminator
   * Returns: The line termination string. This value
   *   is owned by GLib and must not be freed.
   */
  string getLineTerm(out int length)
  {
    const(char)* _cretval;
    _cretval = g_io_channel_get_line_term(cast(GIOChannel*)cPtr, cast(int*)&length);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Initializes a #GIOChannel struct.
   * This is called by each of the above functions when creating a
   * #GIOChannel, and so is not often needed by the application
   * programmer $(LPAREN)unless you are creating a new type of #GIOChannel$(RPAREN).
   */
  void init_()
  {
    g_io_channel_init(cast(GIOChannel*)cPtr);
  }

  /**
   * Reads data from a #GIOChannel.
   * Params:
   *   buf = a buffer to read the data into $(LPAREN)which should be at least
   *     count bytes long$(RPAREN)
   *   bytesRead = returns the number of bytes actually read
   * Returns: %G_IO_ERROR_NONE if the operation was successful.

   * Deprecated: Use [GLib.IOChannel.readChars] instead.
   */
  IOError read(ref ubyte[] buf, out size_t bytesRead)
  {
    GIOError _cretval;
    size_t _count;
    _cretval = g_io_channel_read(cast(GIOChannel*)cPtr, buf.ptr, _count, cast(size_t*)&bytesRead);
    IOError _retval = cast(IOError)_cretval;
    return _retval;
  }

  /**
   * Replacement for [GLib.IOChannel.read] with the new API.
   * Params:
   *   buf = a buffer to read data into
   *   bytesRead = The number of bytes read. This may be
   *     zero even on success if count < 6 and the channel's encoding
   *     is non-%NULL. This indicates that the next UTF-8 character is
   *     too wide for the buffer.
   * Returns: the status of the operation.
   */
  IOStatus readChars(ref ubyte[] buf, out size_t bytesRead)
  {
    GIOStatus _cretval;
    size_t _count;
    GError *_err;
    _cretval = g_io_channel_read_chars(cast(GIOChannel*)cPtr, buf.ptr, _count, cast(size_t*)&bytesRead, &_err);
    if (_err)
      throw new IOChannelException(_err);
    IOStatus _retval = cast(IOStatus)_cretval;
    return _retval;
  }

  /**
   * Reads a line, including the terminating character$(LPAREN)s$(RPAREN),
   * from a #GIOChannel into a newly-allocated string.
   * str_return will contain allocated memory if the return
   * is %G_IO_STATUS_NORMAL.
   * Params:
   *   strReturn = The line read from the #GIOChannel, including the
   *     line terminator. This data should be freed with [GLib.Global.gfree]
   *     when no longer needed. This is a nul-terminated string.
   *     If a length of zero is returned, this will be %NULL instead.
   *   length = location to store length of the read data, or %NULL
   *   terminatorPos = location to store position of line terminator, or %NULL
   * Returns: the status of the operation.
   */
  IOStatus readLine(out string strReturn, out size_t length, out size_t terminatorPos)
  {
    GIOStatus _cretval;
    char* _strReturn;
    GError *_err;
    _cretval = g_io_channel_read_line(cast(GIOChannel*)cPtr, &_strReturn, cast(size_t*)&length, cast(size_t*)&terminatorPos, &_err);
    if (_err)
      throw new IOChannelException(_err);
    IOStatus _retval = cast(IOStatus)_cretval;
    strReturn = _strReturn.fromCString(true);
    return _retval;
  }

  /**
   * Reads a line from a #GIOChannel, using a #GString as a buffer.
   * Params:
   *   buffer = a #GString into which the line will be written.
   *     If buffer already contains data, the old data will
   *     be overwritten.
   *   terminatorPos = location to store position of line terminator, or %NULL
   * Returns: the status of the operation.
   */
  IOStatus readLineString(String buffer, out size_t terminatorPos)
  {
    GIOStatus _cretval;
    GError *_err;
    _cretval = g_io_channel_read_line_string(cast(GIOChannel*)cPtr, buffer ? cast(GString*)buffer.cPtr(false) : null, cast(size_t*)&terminatorPos, &_err);
    if (_err)
      throw new IOChannelException(_err);
    IOStatus _retval = cast(IOStatus)_cretval;
    return _retval;
  }

  /**
   * Reads all the remaining data from the file.
   * Params:
   *   strReturn = Location to
   *     store a pointer to a string holding the remaining data in the
   *     #GIOChannel. This data should be freed with [GLib.Global.gfree] when no
   *     longer needed. This data is terminated by an extra nul
   *     character, but there may be other nuls in the intervening data.
   * Returns: %G_IO_STATUS_NORMAL on success.
   *   This function never returns %G_IO_STATUS_EOF.
   */
  IOStatus readToEnd(out ubyte[] strReturn)
  {
    GIOStatus _cretval;
    size_t _length;
    ubyte* _strReturn;
    GError *_err;
    _cretval = g_io_channel_read_to_end(cast(GIOChannel*)cPtr, &_strReturn, &_length, &_err);
    if (_err)
      throw new IOChannelException(_err);
    IOStatus _retval = cast(IOStatus)_cretval;
    strReturn = _strReturn[0 .. _length];
    safeFree(cast(void*)_strReturn);
    return _retval;
  }

  /**
   * Reads a Unicode character from channel.
   * This function cannot be called on a channel with %NULL encoding.
   * Params:
   *   thechar = a location to return a character
   * Returns: a #GIOStatus
   */
  IOStatus readUnichar(out dchar thechar)
  {
    GIOStatus _cretval;
    GError *_err;
    _cretval = g_io_channel_read_unichar(cast(GIOChannel*)cPtr, cast(dchar*)&thechar, &_err);
    if (_err)
      throw new IOChannelException(_err);
    IOStatus _retval = cast(IOStatus)_cretval;
    return _retval;
  }

  /**
   * Sets the current position in the #GIOChannel, similar to the standard
   * library function fseek$(LPAREN)$(RPAREN).
   * Params:
   *   offset = an offset, in bytes, which is added to the position specified
   *     by type
   *   type = the position in the file, which can be %G_SEEK_CUR $(LPAREN)the current
   *     position$(RPAREN), %G_SEEK_SET $(LPAREN)the start of the file$(RPAREN), or %G_SEEK_END
   *     $(LPAREN)the end of the file$(RPAREN)
   * Returns: %G_IO_ERROR_NONE if the operation was successful.

   * Deprecated: Use [GLib.IOChannel.seekPosition] instead.
   */
  IOError seek(long offset, SeekType type)
  {
    GIOError _cretval;
    _cretval = g_io_channel_seek(cast(GIOChannel*)cPtr, offset, type);
    IOError _retval = cast(IOError)_cretval;
    return _retval;
  }

  /**
   * Replacement for [GLib.IOChannel.seek] with the new API.
   * Params:
   *   offset = The offset in bytes from the position specified by type
   *   type = a #GSeekType. The type %G_SEEK_CUR is only allowed in those
   *     cases where a call to g_io_channel_set_encoding $(LPAREN)$(RPAREN)
   *     is allowed. See the documentation for
   *     g_io_channel_set_encoding $(LPAREN)$(RPAREN) for details.
   * Returns: the status of the operation.
   */
  IOStatus seekPosition(long offset, SeekType type)
  {
    GIOStatus _cretval;
    GError *_err;
    _cretval = g_io_channel_seek_position(cast(GIOChannel*)cPtr, offset, type, &_err);
    if (_err)
      throw new IOChannelException(_err);
    IOStatus _retval = cast(IOStatus)_cretval;
    return _retval;
  }

  /**
   * Sets the buffer size.
   * Params:
   *   size = the size of the buffer, or 0 to let GLib pick a good size
   */
  void setBufferSize(size_t size)
  {
    g_io_channel_set_buffer_size(cast(GIOChannel*)cPtr, size);
  }

  /**
   * The buffering state can only be set if the channel's encoding
   * is %NULL. For any other encoding, the channel must be buffered.
   * A buffered channel can only be set unbuffered if the channel's
   * internal buffers have been flushed. Newly created channels or
   * channels which have returned %G_IO_STATUS_EOF
   * not require such a flush. For write-only channels, a call to
   * g_io_channel_flush $(LPAREN)$(RPAREN) is sufficient. For all other channels,
   * the buffers may be flushed by a call to g_io_channel_seek_position $(LPAREN)$(RPAREN).
   * This includes the possibility of seeking with seek type %G_SEEK_CUR
   * and an offset of zero. Note that this means that socket-based
   * channels cannot be set unbuffered once they have had data
   * read from them.
   * On unbuffered channels, it is safe to mix read and write
   * calls from the new and old APIs, if this is necessary for
   * maintaining old code.
   * The default state of the channel is buffered.
   * Params:
   *   buffered = whether to set the channel buffered or unbuffered
   */
  void setBuffered(bool buffered)
  {
    g_io_channel_set_buffered(cast(GIOChannel*)cPtr, buffered);
  }

  /**
   * Whether to close the channel on the final unref of the #GIOChannel
   * data structure. The default value of this is %TRUE for channels
   * created by g_io_channel_new_file $(LPAREN)$(RPAREN), and %FALSE for all other channels.
   * Setting this flag to %TRUE for a channel you have already closed
   * can cause problems when the final reference to the #GIOChannel is dropped.
   * Params:
   *   doClose = Whether to close the channel on the final unref of
   *     the GIOChannel data structure.
   */
  void setCloseOnUnref(bool doClose)
  {
    g_io_channel_set_close_on_unref(cast(GIOChannel*)cPtr, doClose);
  }

  /**
   * Sets the encoding for the input/output of the channel.
   * The internal encoding is always UTF-8. The default encoding
   * for the external file is UTF-8.
   * The encoding %NULL is safe to use with binary data.
   * The encoding can only be set if one of the following conditions
   * is true:
   * - The channel was just created, and has not been written to or read from yet.
   * - The channel is write-only.
   * - The channel is a file, and the file pointer was just repositioned
   * by a call to [GLib.IOChannel.seekPosition]. $(LPAREN)This flushes all the
   * internal buffers.$(RPAREN)
   * - The current encoding is %NULL or UTF-8.
   * - One of the $(LPAREN)new API$(RPAREN) read functions has just returned %G_IO_STATUS_EOF
   * $(LPAREN)or, in the case of [GLib.IOChannel.readToEnd], %G_IO_STATUS_NORMAL$(RPAREN).
   * -  One of the functions [GLib.IOChannel.readChars] or
   * [GLib.IOChannel.readUnichar] has returned %G_IO_STATUS_AGAIN or
   * %G_IO_STATUS_ERROR. This may be useful in the case of
   * %G_CONVERT_ERROR_ILLEGAL_SEQUENCE.
   * Returning one of these statuses from [GLib.IOChannel.readLine],
   * [GLib.IOChannel.readLineString], or [GLib.IOChannel.readToEnd]
   * does not guarantee that the encoding can be changed.
   * Channels which do not meet one of the above conditions cannot call
   * [GLib.IOChannel.seekPosition] with an offset of %G_SEEK_CUR, and, if
   * they are "seekable", cannot call [GLib.IOChannel.writeChars] after
   * calling one of the API "read" functions.
   * Params:
   *   encoding = the encoding type
   * Returns: %G_IO_STATUS_NORMAL if the encoding was successfully set
   */
  IOStatus setEncoding(string encoding)
  {
    GIOStatus _cretval;
    const(char)* _encoding = encoding.toCString(false);
    GError *_err;
    _cretval = g_io_channel_set_encoding(cast(GIOChannel*)cPtr, _encoding, &_err);
    if (_err)
      throw new IOChannelException(_err);
    IOStatus _retval = cast(IOStatus)_cretval;
    return _retval;
  }

  /**
   * Sets the $(LPAREN)writeable$(RPAREN) flags in channel to $(LPAREN)flags & %G_IO_FLAG_SET_MASK$(RPAREN).
   * Params:
   *   flags = the flags to set on the IO channel
   * Returns: the status of the operation.
   */
  IOStatus setFlags(IOFlags flags)
  {
    GIOStatus _cretval;
    GError *_err;
    _cretval = g_io_channel_set_flags(cast(GIOChannel*)cPtr, flags, &_err);
    if (_err)
      throw new IOChannelException(_err);
    IOStatus _retval = cast(IOStatus)_cretval;
    return _retval;
  }

  /**
   * This sets the string that #GIOChannel uses to determine
   * where in the file a line break occurs.
   * Params:
   *   lineTerm = The line termination string. Use %NULL for
   *     autodetect.  Autodetection breaks on "\n", "\r\n", "\r", "\0",
   *     and the Unicode paragraph separator. Autodetection should not be
   *     used for anything other than file-based channels.
   *   length = The length of the termination string. If -1 is passed, the
   *     string is assumed to be nul-terminated. This option allows
   *     termination strings with embedded nuls.
   */
  void setLineTerm(string lineTerm, int length)
  {
    const(char)* _lineTerm = lineTerm.toCString(false);
    g_io_channel_set_line_term(cast(GIOChannel*)cPtr, _lineTerm, length);
  }

  /**
   * Close an IO channel. Any pending data to be written will be
   * flushed if flush is %TRUE. The channel will not be freed until the
   * last reference is dropped using [GLib.IOChannel.unref].
   * Params:
   *   flush = if %TRUE, flush pending
   * Returns: the status of the operation.
   */
  IOStatus shutdown(bool flush)
  {
    GIOStatus _cretval;
    GError *_err;
    _cretval = g_io_channel_shutdown(cast(GIOChannel*)cPtr, flush, &_err);
    if (_err)
      throw new IOChannelException(_err);
    IOStatus _retval = cast(IOStatus)_cretval;
    return _retval;
  }

  /**
   * Returns the file descriptor of the #GIOChannel.
   * On Windows this function returns the file descriptor or socket of
   * the #GIOChannel.
   * Returns: the file descriptor of the #GIOChannel.
   */
  int unixGetFd()
  {
    int _retval;
    _retval = g_io_channel_unix_get_fd(cast(GIOChannel*)cPtr);
    return _retval;
  }

  /**
   * Writes data to a #GIOChannel.
   * Params:
   *   buf = the buffer containing the data to write
   *   count = the number of bytes to write
   *   bytesWritten = the number of bytes actually written
   * Returns: %G_IO_ERROR_NONE if the operation was successful.

   * Deprecated: Use [GLib.IOChannel.writeChars] instead.
   */
  IOError write(string buf, size_t count, out size_t bytesWritten)
  {
    GIOError _cretval;
    const(char)* _buf = buf.toCString(false);
    _cretval = g_io_channel_write(cast(GIOChannel*)cPtr, _buf, count, cast(size_t*)&bytesWritten);
    IOError _retval = cast(IOError)_cretval;
    return _retval;
  }

  /**
   * Replacement for [GLib.IOChannel.write] with the new API.
   * On seekable channels with encodings other than %NULL or UTF-8, generic
   * mixing of reading and writing is not allowed. A call to g_io_channel_write_chars $(LPAREN)$(RPAREN)
   * may only be made on a channel from which data has been read in the
   * cases described in the documentation for g_io_channel_set_encoding $(LPAREN)$(RPAREN).
   * Params:
   *   buf = a buffer to write data from
   *   bytesWritten = The number of bytes written. This can be nonzero
   *     even if the return value is not %G_IO_STATUS_NORMAL.
   *     If the return value is %G_IO_STATUS_NORMAL and the
   *     channel is blocking, this will always be equal
   *     to count if count >\= 0.
   * Returns: the status of the operation.
   */
  IOStatus writeChars(ubyte[] buf, out size_t bytesWritten)
  {
    GIOStatus _cretval;
    ptrdiff_t _count;
    if (buf)
      _count = cast(ptrdiff_t)buf.length;

    auto _buf = cast(const(ubyte)*)buf.ptr;
    GError *_err;
    _cretval = g_io_channel_write_chars(cast(GIOChannel*)cPtr, _buf, _count, cast(size_t*)&bytesWritten, &_err);
    if (_err)
      throw new IOChannelException(_err);
    IOStatus _retval = cast(IOStatus)_cretval;
    return _retval;
  }

  /**
   * Writes a Unicode character to channel.
   * This function cannot be called on a channel with %NULL encoding.
   * Params:
   *   thechar = a character
   * Returns: a #GIOStatus
   */
  IOStatus writeUnichar(dchar thechar)
  {
    GIOStatus _cretval;
    GError *_err;
    _cretval = g_io_channel_write_unichar(cast(GIOChannel*)cPtr, thechar, &_err);
    if (_err)
      throw new IOChannelException(_err);
    IOStatus _retval = cast(IOStatus)_cretval;
    return _retval;
  }

  /**
   * Converts an `errno` error number to a #GIOChannelError.
   * Params:
   *   en = an `errno` error number, e.g. `EINVAL`
   * Returns: a #GIOChannelError error number, e.g.
   *   %G_IO_CHANNEL_ERROR_INVAL.
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
