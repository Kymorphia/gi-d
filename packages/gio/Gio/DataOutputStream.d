module Gio.DataOutputStream;

import GLib.ErrorG;
import GObject.ObjectG;
import Gid.Gid;
import Gio.Cancellable;
import Gio.FilterOutputStream;
import Gio.OutputStream;
import Gio.Seekable;
import Gio.SeekableT;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * Data output stream implements #GOutputStream and includes functions for
 * writing data directly to an output stream.
 */
class DataOutputStream : FilterOutputStream, Seekable
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return g_data_output_stream_get_type();
  }

  mixin SeekableT!GDataOutputStream;

  /**
   * #GDataOutputStream.
   */
  this(OutputStream baseStream)
  {
    GDataOutputStream* _cretval;
    _cretval = g_data_output_stream_new(baseStream ? baseStream.cPtr!GOutputStream : null);
    this(_cretval, true);
  }

  /**
   * the #GDataStreamByteOrder for the @stream.
   */
  DataStreamByteOrder getByteOrder()
  {
    GDataStreamByteOrder _cretval;
    _cretval = g_data_output_stream_get_byte_order(cPtr!GDataOutputStream);
    DataStreamByteOrder _retval = cast(DataStreamByteOrder)_cretval;
    return _retval;
  }

  /**
   * %TRUE if @data was successfully added to the @stream.
   */
  bool putByte(ubyte data, Cancellable cancellable)
  {
    bool _retval;
    GError *_err;
    _retval = g_data_output_stream_put_byte(cPtr!GDataOutputStream, data, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * %TRUE if @data was successfully added to the @stream.
   */
  bool putInt16(short data, Cancellable cancellable)
  {
    bool _retval;
    GError *_err;
    _retval = g_data_output_stream_put_int16(cPtr!GDataOutputStream, data, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * %TRUE if @data was successfully added to the @stream.
   */
  bool putInt32(int data, Cancellable cancellable)
  {
    bool _retval;
    GError *_err;
    _retval = g_data_output_stream_put_int32(cPtr!GDataOutputStream, data, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * %TRUE if @data was successfully added to the @stream.
   */
  bool putInt64(long data, Cancellable cancellable)
  {
    bool _retval;
    GError *_err;
    _retval = g_data_output_stream_put_int64(cPtr!GDataOutputStream, data, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * %TRUE if @string was successfully added to the @stream.
   */
  bool putString(string str, Cancellable cancellable)
  {
    bool _retval;
    const(char)* _str = str.toCString(false);
    GError *_err;
    _retval = g_data_output_stream_put_string(cPtr!GDataOutputStream, _str, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * %TRUE if @data was successfully added to the @stream.
   */
  bool putUint16(ushort data, Cancellable cancellable)
  {
    bool _retval;
    GError *_err;
    _retval = g_data_output_stream_put_uint16(cPtr!GDataOutputStream, data, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * %TRUE if @data was successfully added to the @stream.
   */
  bool putUint32(uint data, Cancellable cancellable)
  {
    bool _retval;
    GError *_err;
    _retval = g_data_output_stream_put_uint32(cPtr!GDataOutputStream, data, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * %TRUE if @data was successfully added to the @stream.
   */
  bool putUint64(ulong data, Cancellable cancellable)
  {
    bool _retval;
    GError *_err;
    _retval = g_data_output_stream_put_uint64(cPtr!GDataOutputStream, data, cancellable ? cancellable.cPtr!GCancellable : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Sets the byte order of the data output stream to @order.
   */
  void setByteOrder(DataStreamByteOrder order)
  {
    g_data_output_stream_set_byte_order(cPtr!GDataOutputStream, order);
  }
}
