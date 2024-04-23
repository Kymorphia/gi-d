module Gio.DataInputStream;

import GLib.ErrorG;
import GObject.ObjectG;
import GObject.Types;
import Gid.Gid;
import Gio.AsyncResult;
import Gio.BufferedInputStream;
import Gio.Cancellable;
import Gio.InputStream;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * Data input stream implements #GInputStream and includes functions for
 * reading structured data directly from a binary input stream.
 */
class DataInputStream : BufferedInputStream
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_data_input_stream_get_type();
  }

  /**
   * a new #GDataInputStream.
   */
  this(InputStream baseStream)
  {
    GDataInputStream* _cretval;
    _cretval = g_data_input_stream_new(baseStream ? baseStream.cPtr!GInputStream : null);
    this(_cretval, true);
  }

  /**
   * the @stream's current #GDataStreamByteOrder.
   */
  DataStreamByteOrder getByteOrder()
  {
    GDataStreamByteOrder _cretval;
    _cretval = g_data_input_stream_get_byte_order(cPtr!GDataInputStream);
    DataStreamByteOrder _retval = cast(DataStreamByteOrder)_cretval;
    return _retval;
  }

  /**
   * #GDataStreamNewlineType for the given @stream.
   */
  DataStreamNewlineType getNewlineType()
  {
    GDataStreamNewlineType _cretval;
    _cretval = g_data_input_stream_get_newline_type(cPtr!GDataInputStream);
    DataStreamNewlineType _retval = cast(DataStreamNewlineType)_cretval;
    return _retval;
  }

  /**
   * an unsigned 8-bit/1-byte value read from the @stream or `0`
   * if an error occurred.
   */
  ubyte readByteData(Cancellable cancellable)
  {
    ubyte _retval;
    GError *_err;
    _retval = g_data_input_stream_read_byte(cPtr!GDataInputStream, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * a signed 16-bit/2-byte value read from @stream or `0` if
   * an error occurred.
   */
  short readInt16(Cancellable cancellable)
  {
    short _retval;
    GError *_err;
    _retval = g_data_input_stream_read_int16(cPtr!GDataInputStream, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * a signed 32-bit/4-byte value read from the @stream or `0` if
   * an error occurred.
   */
  int readInt32(Cancellable cancellable)
  {
    int _retval;
    GError *_err;
    _retval = g_data_input_stream_read_int32(cPtr!GDataInputStream, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * a signed 64-bit/8-byte value read from @stream or `0` if
   * an error occurred.
   */
  long readInt64(Cancellable cancellable)
  {
    long _retval;
    GError *_err;
    _retval = g_data_input_stream_read_int64(cPtr!GDataInputStream, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * The asynchronous version of g_data_input_stream_read_line().  It is
   * an error to have two outstanding calls to this function.
   *
   * When the operation is finished, @callback will be called. You
   * can then call g_data_input_stream_read_line_finish() to get
   * the result of the operation.
   */
  void readLineAsync(int ioPriority, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    ptrFreezeGC(cast(void*)&callback);
    g_data_input_stream_read_line_async(cPtr!GDataInputStream, ioPriority, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * a string with the line that
   * was read in (without the newlines).  Set @length to a #gsize to
   * get the length of the read line.  On an error, it will return
   * %NULL and @error will be set. For UTF-8 conversion errors, the set
   * error domain is %G_CONVERT_ERROR.  If there's no content to read,
   * it will still return %NULL, but @error won't be set.
   */
  string readLineFinishUtf8(AsyncResult result, out size_t length)
  {
    char* _cretval;
    GError *_err;
    _cretval = g_data_input_stream_read_line_finish_utf8(cPtr!GDataInputStream, result ? (cast(ObjectG)result).cPtr!GAsyncResult : null, cast(size_t*)&length, &_err);
    if (_err)
      throw new ErrorG(_err);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * a NUL terminated UTF-8 string
   * with the line that was read in (without the newlines).  Set
   * @length to a #gsize to get the length of the read line.  On an
   * error, it will return %NULL and @error will be set.  For UTF-8
   * conversion errors, the set error domain is %G_CONVERT_ERROR.  If
   * there's no content to read, it will still return %NULL, but @error
   * won't be set.
   */
  string readLineUtf8(out size_t length, Cancellable cancellable)
  {
    char* _cretval;
    GError *_err;
    _cretval = g_data_input_stream_read_line_utf8(cPtr!GDataInputStream, cast(size_t*)&length, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * an unsigned 16-bit/2-byte value read from the @stream or `0` if
   * an error occurred.
   */
  ushort readUint16(Cancellable cancellable)
  {
    ushort _retval;
    GError *_err;
    _retval = g_data_input_stream_read_uint16(cPtr!GDataInputStream, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * an unsigned 32-bit/4-byte value read from the @stream or `0` if
   * an error occurred.
   */
  uint readUint32(Cancellable cancellable)
  {
    uint _retval;
    GError *_err;
    _retval = g_data_input_stream_read_uint32(cPtr!GDataInputStream, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * an unsigned 64-bit/8-byte read from @stream or `0` if
   * an error occurred.
   */
  ulong readUint64(Cancellable cancellable)
  {
    ulong _retval;
    GError *_err;
    _retval = g_data_input_stream_read_uint64(cPtr!GDataInputStream, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * a string with the data that was read
   * before encountering any of the stop characters. Set @length to
   * a #gsize to get the length of the string. This function will
   * return %NULL on an error.
   */
  string readUntil(string stopChars, out size_t length, Cancellable cancellable)
  {
    char* _cretval;
    const(char)* _stopChars = stopChars.toCString(false);
    GError *_err;
    _cretval = g_data_input_stream_read_until(cPtr!GDataInputStream, _stopChars, cast(size_t*)&length, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * The asynchronous version of g_data_input_stream_read_until().
   * It is an error to have two outstanding calls to this function.
   *
   * Note that, in contrast to g_data_input_stream_read_until(),
   * this function does not consume the stop character that it finds.  You
   * must read it for yourself.
   *
   * When the operation is finished, @callback will be called. You
   * can then call g_data_input_stream_read_until_finish() to get
   * the result of the operation.
   *
   * Don't use this function in new code.  Its functionality is
   * inconsistent with g_data_input_stream_read_until().  Both functions
   * will be marked as deprecated in a future release.  Use
   * g_data_input_stream_read_upto_async() instead.
   */
  void readUntilAsync(string stopChars, int ioPriority, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    const(char)* _stopChars = stopChars.toCString(false);
    ptrFreezeGC(cast(void*)&callback);
    g_data_input_stream_read_until_async(cPtr!GDataInputStream, _stopChars, ioPriority, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * a string with the data that was read
   * before encountering any of the stop characters. Set @length to
   * a #gsize to get the length of the string. This function will
   * return %NULL on an error.
   */
  string readUntilFinish(AsyncResult result, out size_t length)
  {
    char* _cretval;
    GError *_err;
    _cretval = g_data_input_stream_read_until_finish(cPtr!GDataInputStream, result ? (cast(ObjectG)result).cPtr!GAsyncResult : null, cast(size_t*)&length, &_err);
    if (_err)
      throw new ErrorG(_err);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * a string with the data that was read
   * before encountering any of the stop characters. Set @length to
   * a #gsize to get the length of the string. This function will
   * return %NULL on an error
   */
  string readUpto(string stopChars, ptrdiff_t stopCharsLen, out size_t length, Cancellable cancellable)
  {
    char* _cretval;
    const(char)* _stopChars = stopChars.toCString(false);
    GError *_err;
    _cretval = g_data_input_stream_read_upto(cPtr!GDataInputStream, _stopChars, stopCharsLen, cast(size_t*)&length, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * The asynchronous version of g_data_input_stream_read_upto().
   * It is an error to have two outstanding calls to this function.
   *
   * In contrast to g_data_input_stream_read_until(), this function
   * does not consume the stop character. You have to use
   * g_data_input_stream_read_byte() to get it before calling
   * g_data_input_stream_read_upto() again.
   *
   * Note that @stop_chars may contain '\0' if @stop_chars_len is
   * specified.
   *
   * When the operation is finished, @callback will be called. You
   * can then call g_data_input_stream_read_upto_finish() to get
   * the result of the operation.
   */
  void readUptoAsync(string stopChars, ptrdiff_t stopCharsLen, int ioPriority, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);

      (*(cast(AsyncReadyCallback*)data))(sourceObject ? ObjectG.getDObject!ObjectG(sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(res, false) : null);
    }

    const(char)* _stopChars = stopChars.toCString(false);
    ptrFreezeGC(cast(void*)&callback);
    g_data_input_stream_read_upto_async(cPtr!GDataInputStream, _stopChars, stopCharsLen, ioPriority, cancellable ? cancellable.cPtr!GCancellable : null, &_callbackCallback, cast(void*)&callback);
  }

  /**
   * a string with the data that was read
   * before encountering any of the stop characters. Set @length to
   * a #gsize to get the length of the string. This function will
   * return %NULL on an error.
   */
  string readUptoFinish(AsyncResult result, out size_t length)
  {
    char* _cretval;
    GError *_err;
    _cretval = g_data_input_stream_read_upto_finish(cPtr!GDataInputStream, result ? (cast(ObjectG)result).cPtr!GAsyncResult : null, cast(size_t*)&length, &_err);
    if (_err)
      throw new ErrorG(_err);
    string _retval = _cretval.fromCString(true);
    return _retval;
  }

  /**
   * This function sets the byte order for the given @stream. All subsequent
   * reads from the @stream will be read in the given @order.
   */
  void setByteOrder(DataStreamByteOrder order)
  {
    g_data_input_stream_set_byte_order(cPtr!GDataInputStream, order);
  }

  /**
   * Sets the newline type for the @stream.
   *
   * Note that using G_DATA_STREAM_NEWLINE_TYPE_ANY is slightly unsafe. If a read
   * chunk ends in "CR" we must read an additional byte to know if this is "CR" or
   * "CR LF", and this might block if there is no more data available.
   */
  void setNewlineType(DataStreamNewlineType type)
  {
    g_data_input_stream_set_newline_type(cPtr!GDataInputStream, type);
  }
}
