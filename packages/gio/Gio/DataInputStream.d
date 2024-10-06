module Gio.DataInputStream;

import GLib.ErrorG;
import GObject.ObjectG;
import Gid.gid;
import Gio.AsyncResult;
import Gio.AsyncResultT;
import Gio.BufferedInputStream;
import Gio.Cancellable;
import Gio.InputStream;
import Gio.Seekable;
import Gio.SeekableT;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * Data input stream implements [Gio.InputStream] and includes functions
 * for reading structured data directly from a binary input stream.
 */
class DataInputStream : BufferedInputStream
{

  this()
  {
  }

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_data_input_stream_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Creates a new data input stream for the base_stream.
   * Params:
   *   baseStream = a #GInputStream.
   * Returns: a new #GDataInputStream.
   */
  this(InputStream baseStream)
  {
    GDataInputStream* _cretval;
    _cretval = g_data_input_stream_new(baseStream ? cast(GInputStream*)baseStream.cPtr(false) : null);
    this(_cretval, true);
  }

  /**
   * Gets the byte order for the data input stream.
   * Returns: the stream's current #GDataStreamByteOrder.
   */
  DataStreamByteOrder getByteOrder()
  {
    GDataStreamByteOrder _cretval;
    _cretval = g_data_input_stream_get_byte_order(cast(GDataInputStream*)cPtr);
    DataStreamByteOrder _retval = cast(DataStreamByteOrder)_cretval;
    return _retval;
  }

  /**
   * Gets the current newline type for the stream.
   * Returns: #GDataStreamNewlineType for the given stream.
   */
  DataStreamNewlineType getNewlineType()
  {
    GDataStreamNewlineType _cretval;
    _cretval = g_data_input_stream_get_newline_type(cast(GDataInputStream*)cPtr);
    DataStreamNewlineType _retval = cast(DataStreamNewlineType)_cretval;
    return _retval;
  }

  /**
   * Reads an unsigned 8-bit/1-byte value from stream.
   * Params:
   *   cancellable = optional #GCancellable object, %NULL to ignore.
   * Returns: an unsigned 8-bit/1-byte value read from the stream or `0`
   *   if an error occurred.
   */
  ubyte readByteData(Cancellable cancellable)
  {
    ubyte _retval;
    GError *_err;
    _retval = g_data_input_stream_read_byte(cast(GDataInputStream*)cPtr, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Reads a 16-bit/2-byte value from stream.
   * In order to get the correct byte order for this read operation,
   * see [Gio.DataInputStream.getByteOrder] and [Gio.DataInputStream.setByteOrder].
   * Params:
   *   cancellable = optional #GCancellable object, %NULL to ignore.
   * Returns: a signed 16-bit/2-byte value read from stream or `0` if
   *   an error occurred.
   */
  short readInt16(Cancellable cancellable)
  {
    short _retval;
    GError *_err;
    _retval = g_data_input_stream_read_int16(cast(GDataInputStream*)cPtr, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Reads a signed 32-bit/4-byte value from stream.
   * In order to get the correct byte order for this read operation,
   * see [Gio.DataInputStream.getByteOrder] and [Gio.DataInputStream.setByteOrder].
   * If cancellable is not %NULL, then the operation can be cancelled by
   * triggering the cancellable object from another thread. If the operation
   * was cancelled, the error %G_IO_ERROR_CANCELLED will be returned.
   * Params:
   *   cancellable = optional #GCancellable object, %NULL to ignore.
   * Returns: a signed 32-bit/4-byte value read from the stream or `0` if
   *   an error occurred.
   */
  int readInt32(Cancellable cancellable)
  {
    int _retval;
    GError *_err;
    _retval = g_data_input_stream_read_int32(cast(GDataInputStream*)cPtr, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Reads a 64-bit/8-byte value from stream.
   * In order to get the correct byte order for this read operation,
   * see [Gio.DataInputStream.getByteOrder] and [Gio.DataInputStream.setByteOrder].
   * If cancellable is not %NULL, then the operation can be cancelled by
   * triggering the cancellable object from another thread. If the operation
   * was cancelled, the error %G_IO_ERROR_CANCELLED will be returned.
   * Params:
   *   cancellable = optional #GCancellable object, %NULL to ignore.
   * Returns: a signed 64-bit/8-byte value read from stream or `0` if
   *   an error occurred.
   */
  long readInt64(Cancellable cancellable)
  {
    long _retval;
    GError *_err;
    _retval = g_data_input_stream_read_int64(cast(GDataInputStream*)cPtr, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * The asynchronous version of [Gio.DataInputStream.readLine].  It is
   * an error to have two outstanding calls to this function.
   * When the operation is finished, callback will be called. You
   * can then call [Gio.DataInputStream.readLineFinish] to get
   * the result of the operation.
   * Params:
   *   ioPriority = the [I/O priority][io-priority] of the request
   *   cancellable = optional #GCancellable object, %NULL to ignore.
   *   callback = callback to call when the request is satisfied.
   */
  void readLineAsync(int ioPriority, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(AsyncReadyCallback*)data;

      (*_dlg)(sourceObject ? ObjectG.getDObject!ObjectG(cast(void*)sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(cast(void*)res, false) : null);
    }

    auto _callback = freezeDelegate(cast(void*)&callback);
    g_data_input_stream_read_line_async(cast(GDataInputStream*)cPtr, ioPriority, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_callbackCallback, _callback);
  }

  /**
   * Finish an asynchronous call started by
   * [Gio.DataInputStream.readLineAsync].
   * Params:
   *   result = the #GAsyncResult that was provided to the callback.
   *   length = a #gsize to get the length of the data read in.
   * Returns: a string with the line that
   *   was read in $(LPAREN)without the newlines$(RPAREN).  Set length to a #gsize to
   *   get the length of the read line.  On an error, it will return
   *   %NULL and error will be set. For UTF-8 conversion errors, the set
   *   error domain is %G_CONVERT_ERROR.  If there's no content to read,
   *   it will still return %NULL, but error won't be set.
   */
  string readLineFinishUtf8(AsyncResult result, out size_t length)
  {
    char* _cretval;
    GError *_err;
    _cretval = g_data_input_stream_read_line_finish_utf8(cast(GDataInputStream*)cPtr, result ? cast(GAsyncResult*)(cast(ObjectG)result).cPtr(false) : null, cast(size_t*)&length, &_err);
    if (_err)
      throw new ErrorG(_err);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * Reads a UTF-8 encoded line from the data input stream.
   * If cancellable is not %NULL, then the operation can be cancelled by
   * triggering the cancellable object from another thread. If the operation
   * was cancelled, the error %G_IO_ERROR_CANCELLED will be returned.
   * Params:
   *   length = a #gsize to get the length of the data read in.
   *   cancellable = optional #GCancellable object, %NULL to ignore.
   * Returns: a NUL terminated UTF-8 string
   *   with the line that was read in $(LPAREN)without the newlines$(RPAREN).  Set
   *   length to a #gsize to get the length of the read line.  On an
   *   error, it will return %NULL and error will be set.  For UTF-8
   *   conversion errors, the set error domain is %G_CONVERT_ERROR.  If
   *   there's no content to read, it will still return %NULL, but error
   *   won't be set.
   */
  string readLineUtf8(out size_t length, Cancellable cancellable)
  {
    char* _cretval;
    GError *_err;
    _cretval = g_data_input_stream_read_line_utf8(cast(GDataInputStream*)cPtr, cast(size_t*)&length, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * Reads an unsigned 16-bit/2-byte value from stream.
   * In order to get the correct byte order for this read operation,
   * see [Gio.DataInputStream.getByteOrder] and [Gio.DataInputStream.setByteOrder].
   * Params:
   *   cancellable = optional #GCancellable object, %NULL to ignore.
   * Returns: an unsigned 16-bit/2-byte value read from the stream or `0` if
   *   an error occurred.
   */
  ushort readUint16(Cancellable cancellable)
  {
    ushort _retval;
    GError *_err;
    _retval = g_data_input_stream_read_uint16(cast(GDataInputStream*)cPtr, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Reads an unsigned 32-bit/4-byte value from stream.
   * In order to get the correct byte order for this read operation,
   * see [Gio.DataInputStream.getByteOrder] and [Gio.DataInputStream.setByteOrder].
   * If cancellable is not %NULL, then the operation can be cancelled by
   * triggering the cancellable object from another thread. If the operation
   * was cancelled, the error %G_IO_ERROR_CANCELLED will be returned.
   * Params:
   *   cancellable = optional #GCancellable object, %NULL to ignore.
   * Returns: an unsigned 32-bit/4-byte value read from the stream or `0` if
   *   an error occurred.
   */
  uint readUint32(Cancellable cancellable)
  {
    uint _retval;
    GError *_err;
    _retval = g_data_input_stream_read_uint32(cast(GDataInputStream*)cPtr, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Reads an unsigned 64-bit/8-byte value from stream.
   * In order to get the correct byte order for this read operation,
   * see [Gio.DataInputStream.getByteOrder].
   * If cancellable is not %NULL, then the operation can be cancelled by
   * triggering the cancellable object from another thread. If the operation
   * was cancelled, the error %G_IO_ERROR_CANCELLED will be returned.
   * Params:
   *   cancellable = optional #GCancellable object, %NULL to ignore.
   * Returns: an unsigned 64-bit/8-byte read from stream or `0` if
   *   an error occurred.
   */
  ulong readUint64(Cancellable cancellable)
  {
    ulong _retval;
    GError *_err;
    _retval = g_data_input_stream_read_uint64(cast(GDataInputStream*)cPtr, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Reads a string from the data input stream, up to the first
   * occurrence of any of the stop characters.
   * Note that, in contrast to [Gio.DataInputStream.readUntilAsync],
   * this function consumes the stop character that it finds.
   * Don't use this function in new code.  Its functionality is
   * inconsistent with [Gio.DataInputStream.readUntilAsync].  Both
   * functions will be marked as deprecated in a future release.  Use
   * [Gio.DataInputStream.readUpto] instead, but note that that function
   * does not consume the stop character.
   * Params:
   *   stopChars = characters to terminate the read.
   *   length = a #gsize to get the length of the data read in.
   *   cancellable = optional #GCancellable object, %NULL to ignore.
   * Returns: a string with the data that was read
   *   before encountering any of the stop characters. Set length to
   *   a #gsize to get the length of the string. This function will
   *   return %NULL on an error.

   * Deprecated: Use [Gio.DataInputStream.readUpto] instead, which has more
   *   consistent behaviour regarding the stop character.
   */
  string readUntil(string stopChars, out size_t length, Cancellable cancellable)
  {
    char* _cretval;
    const(char)* _stopChars = stopChars.toCString(false);
    GError *_err;
    _cretval = g_data_input_stream_read_until(cast(GDataInputStream*)cPtr, _stopChars, cast(size_t*)&length, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * The asynchronous version of [Gio.DataInputStream.readUntil].
   * It is an error to have two outstanding calls to this function.
   * Note that, in contrast to [Gio.DataInputStream.readUntil],
   * this function does not consume the stop character that it finds.  You
   * must read it for yourself.
   * When the operation is finished, callback will be called. You
   * can then call [Gio.DataInputStream.readUntilFinish] to get
   * the result of the operation.
   * Don't use this function in new code.  Its functionality is
   * inconsistent with [Gio.DataInputStream.readUntil].  Both functions
   * will be marked as deprecated in a future release.  Use
   * [Gio.DataInputStream.readUptoAsync] instead.
   * Params:
   *   stopChars = characters to terminate the read.
   *   ioPriority = the [I/O priority][io-priority] of the request
   *   cancellable = optional #GCancellable object, %NULL to ignore.
   *   callback = callback to call when the request is satisfied.

   * Deprecated: Use [Gio.DataInputStream.readUptoAsync] instead, which
   *   has more consistent behaviour regarding the stop character.
   */
  void readUntilAsync(string stopChars, int ioPriority, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(AsyncReadyCallback*)data;

      (*_dlg)(sourceObject ? ObjectG.getDObject!ObjectG(cast(void*)sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(cast(void*)res, false) : null);
    }

    const(char)* _stopChars = stopChars.toCString(false);
    auto _callback = freezeDelegate(cast(void*)&callback);
    g_data_input_stream_read_until_async(cast(GDataInputStream*)cPtr, _stopChars, ioPriority, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_callbackCallback, _callback);
  }

  /**
   * Finish an asynchronous call started by
   * [Gio.DataInputStream.readUntilAsync].
   * Params:
   *   result = the #GAsyncResult that was provided to the callback.
   *   length = a #gsize to get the length of the data read in.
   * Returns: a string with the data that was read
   *   before encountering any of the stop characters. Set length to
   *   a #gsize to get the length of the string. This function will
   *   return %NULL on an error.

   * Deprecated: Use [Gio.DataInputStream.readUptoFinish] instead, which
   *   has more consistent behaviour regarding the stop character.
   */
  string readUntilFinish(AsyncResult result, out size_t length)
  {
    char* _cretval;
    GError *_err;
    _cretval = g_data_input_stream_read_until_finish(cast(GDataInputStream*)cPtr, result ? cast(GAsyncResult*)(cast(ObjectG)result).cPtr(false) : null, cast(size_t*)&length, &_err);
    if (_err)
      throw new ErrorG(_err);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * Reads a string from the data input stream, up to the first
   * occurrence of any of the stop characters.
   * In contrast to [Gio.DataInputStream.readUntil], this function
   * does not consume the stop character. You have to use
   * [Gio.DataInputStream.readByteData] to get it before calling
   * [Gio.DataInputStream.readUpto] again.
   * Note that stop_chars may contain '\0' if stop_chars_len is
   * specified.
   * The returned string will always be nul-terminated on success.
   * Params:
   *   stopChars = characters to terminate the read
   *   stopCharsLen = length of stop_chars. May be -1 if stop_chars is
   *     nul-terminated
   *   length = a #gsize to get the length of the data read in
   *   cancellable = optional #GCancellable object, %NULL to ignore
   * Returns: a string with the data that was read
   *   before encountering any of the stop characters. Set length to
   *   a #gsize to get the length of the string. This function will
   *   return %NULL on an error
   */
  string readUpto(string stopChars, ptrdiff_t stopCharsLen, out size_t length, Cancellable cancellable)
  {
    char* _cretval;
    const(char)* _stopChars = stopChars.toCString(false);
    GError *_err;
    _cretval = g_data_input_stream_read_upto(cast(GDataInputStream*)cPtr, _stopChars, stopCharsLen, cast(size_t*)&length, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * The asynchronous version of [Gio.DataInputStream.readUpto].
   * It is an error to have two outstanding calls to this function.
   * In contrast to [Gio.DataInputStream.readUntil], this function
   * does not consume the stop character. You have to use
   * [Gio.DataInputStream.readByteData] to get it before calling
   * [Gio.DataInputStream.readUpto] again.
   * Note that stop_chars may contain '\0' if stop_chars_len is
   * specified.
   * When the operation is finished, callback will be called. You
   * can then call [Gio.DataInputStream.readUptoFinish] to get
   * the result of the operation.
   * Params:
   *   stopChars = characters to terminate the read
   *   stopCharsLen = length of stop_chars. May be -1 if stop_chars is
   *     nul-terminated
   *   ioPriority = the [I/O priority][io-priority] of the request
   *   cancellable = optional #GCancellable object, %NULL to ignore
   *   callback = callback to call when the request is satisfied
   */
  void readUptoAsync(string stopChars, ptrdiff_t stopCharsLen, int ioPriority, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(AsyncReadyCallback*)data;

      (*_dlg)(sourceObject ? ObjectG.getDObject!ObjectG(cast(void*)sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(cast(void*)res, false) : null);
    }

    const(char)* _stopChars = stopChars.toCString(false);
    auto _callback = freezeDelegate(cast(void*)&callback);
    g_data_input_stream_read_upto_async(cast(GDataInputStream*)cPtr, _stopChars, stopCharsLen, ioPriority, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_callbackCallback, _callback);
  }

  /**
   * Finish an asynchronous call started by
   * [Gio.DataInputStream.readUptoAsync].
   * Note that this function does not consume the stop character. You
   * have to use [Gio.DataInputStream.readByteData] to get it before calling
   * [Gio.DataInputStream.readUptoAsync] again.
   * The returned string will always be nul-terminated on success.
   * Params:
   *   result = the #GAsyncResult that was provided to the callback
   *   length = a #gsize to get the length of the data read in
   * Returns: a string with the data that was read
   *   before encountering any of the stop characters. Set length to
   *   a #gsize to get the length of the string. This function will
   *   return %NULL on an error.
   */
  string readUptoFinish(AsyncResult result, out size_t length)
  {
    char* _cretval;
    GError *_err;
    _cretval = g_data_input_stream_read_upto_finish(cast(GDataInputStream*)cPtr, result ? cast(GAsyncResult*)(cast(ObjectG)result).cPtr(false) : null, cast(size_t*)&length, &_err);
    if (_err)
      throw new ErrorG(_err);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * This function sets the byte order for the given stream. All subsequent
   * reads from the stream will be read in the given order.
   * Params:
   *   order = a #GDataStreamByteOrder to set.
   */
  void setByteOrder(DataStreamByteOrder order)
  {
    g_data_input_stream_set_byte_order(cast(GDataInputStream*)cPtr, order);
  }

  /**
   * Sets the newline type for the stream.
   * Note that using G_DATA_STREAM_NEWLINE_TYPE_ANY is slightly unsafe. If a read
   * chunk ends in "CR" we must read an additional byte to know if this is "CR" or
   * "CR LF", and this might block if there is no more data available.
   * Params:
   *   type = the type of new line return as #GDataStreamNewlineType.
   */
  void setNewlineType(DataStreamNewlineType type)
  {
    g_data_input_stream_set_newline_type(cast(GDataInputStream*)cPtr, type);
  }
}
