module Gio.DataOutputStream;

import GLib.ErrorG;
import Gid.gid;
import Gio.Cancellable;
import Gio.FilterOutputStream;
import Gio.OutputStream;
import Gio.Seekable;
import Gio.SeekableT;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * Data output stream implements [Gio.OutputStream] and includes functions
 * for writing data directly to an output stream.
 */
class DataOutputStream : FilterOutputStream, Seekable
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
    return g_data_output_stream_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin SeekableT!();

  /**
   * Creates a new data output stream for base_stream.
   * Params:
   *   baseStream = a #GOutputStream.
   * Returns: #GDataOutputStream.
   */
  this(OutputStream baseStream)
  {
    GDataOutputStream* _cretval;
    _cretval = g_data_output_stream_new(baseStream ? cast(GOutputStream*)baseStream.cPtr(false) : null);
    this(_cretval, true);
  }

  /**
   * Gets the byte order for the stream.
   * Returns: the #GDataStreamByteOrder for the stream.
   */
  DataStreamByteOrder getByteOrder()
  {
    GDataStreamByteOrder _cretval;
    _cretval = g_data_output_stream_get_byte_order(cast(GDataOutputStream*)cPtr);
    DataStreamByteOrder _retval = cast(DataStreamByteOrder)_cretval;
    return _retval;
  }

  /**
   * Puts a byte into the output stream.
   * Params:
   *   data = a #guchar.
   *   cancellable = optional #GCancellable object, %NULL to ignore.
   * Returns: %TRUE if data was successfully added to the stream.
   */
  bool putByte(ubyte data, Cancellable cancellable)
  {
    bool _retval;
    GError *_err;
    _retval = g_data_output_stream_put_byte(cast(GDataOutputStream*)cPtr, data, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Puts a signed 16-bit integer into the output stream.
   * Params:
   *   data = a #gint16.
   *   cancellable = optional #GCancellable object, %NULL to ignore.
   * Returns: %TRUE if data was successfully added to the stream.
   */
  bool putInt16(short data, Cancellable cancellable)
  {
    bool _retval;
    GError *_err;
    _retval = g_data_output_stream_put_int16(cast(GDataOutputStream*)cPtr, data, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Puts a signed 32-bit integer into the output stream.
   * Params:
   *   data = a #gint32.
   *   cancellable = optional #GCancellable object, %NULL to ignore.
   * Returns: %TRUE if data was successfully added to the stream.
   */
  bool putInt32(int data, Cancellable cancellable)
  {
    bool _retval;
    GError *_err;
    _retval = g_data_output_stream_put_int32(cast(GDataOutputStream*)cPtr, data, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Puts a signed 64-bit integer into the stream.
   * Params:
   *   data = a #gint64.
   *   cancellable = optional #GCancellable object, %NULL to ignore.
   * Returns: %TRUE if data was successfully added to the stream.
   */
  bool putInt64(long data, Cancellable cancellable)
  {
    bool _retval;
    GError *_err;
    _retval = g_data_output_stream_put_int64(cast(GDataOutputStream*)cPtr, data, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Puts a string into the output stream.
   * Params:
   *   str = a string.
   *   cancellable = optional #GCancellable object, %NULL to ignore.
   * Returns: %TRUE if string was successfully added to the stream.
   */
  bool putString(string str, Cancellable cancellable)
  {
    bool _retval;
    const(char)* _str = str.toCString(false);
    GError *_err;
    _retval = g_data_output_stream_put_string(cast(GDataOutputStream*)cPtr, _str, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Puts an unsigned 16-bit integer into the output stream.
   * Params:
   *   data = a #guint16.
   *   cancellable = optional #GCancellable object, %NULL to ignore.
   * Returns: %TRUE if data was successfully added to the stream.
   */
  bool putUint16(ushort data, Cancellable cancellable)
  {
    bool _retval;
    GError *_err;
    _retval = g_data_output_stream_put_uint16(cast(GDataOutputStream*)cPtr, data, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Puts an unsigned 32-bit integer into the stream.
   * Params:
   *   data = a #guint32.
   *   cancellable = optional #GCancellable object, %NULL to ignore.
   * Returns: %TRUE if data was successfully added to the stream.
   */
  bool putUint32(uint data, Cancellable cancellable)
  {
    bool _retval;
    GError *_err;
    _retval = g_data_output_stream_put_uint32(cast(GDataOutputStream*)cPtr, data, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Puts an unsigned 64-bit integer into the stream.
   * Params:
   *   data = a #guint64.
   *   cancellable = optional #GCancellable object, %NULL to ignore.
   * Returns: %TRUE if data was successfully added to the stream.
   */
  bool putUint64(ulong data, Cancellable cancellable)
  {
    bool _retval;
    GError *_err;
    _retval = g_data_output_stream_put_uint64(cast(GDataOutputStream*)cPtr, data, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Sets the byte order of the data output stream to order.
   * Params:
   *   order = a %GDataStreamByteOrder.
   */
  void setByteOrder(DataStreamByteOrder order)
  {
    g_data_output_stream_set_byte_order(cast(GDataOutputStream*)cPtr, order);
  }
}
