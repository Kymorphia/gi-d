module Gio.FilterInputStream;

import GObject.ObjectG;
import Gid.gid;
import Gio.InputStream;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * Base class for input stream implementations that perform some
 * kind of filtering operation on a base stream. Typical examples
 * of filtering operations are character set conversion, compression
 * and byte order flipping.
 */
class FilterInputStream : InputStream
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
    return g_filter_input_stream_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Gets the base stream for the filter stream.
   * Returns: a #GInputStream.
   */
  InputStream getBaseStream()
  {
    GInputStream* _cretval;
    _cretval = g_filter_input_stream_get_base_stream(cast(GFilterInputStream*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!InputStream(cast(GInputStream*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns whether the base stream will be closed when stream is
   * closed.
   * Returns: %TRUE if the base stream will be closed.
   */
  bool getCloseBaseStream()
  {
    bool _retval;
    _retval = g_filter_input_stream_get_close_base_stream(cast(GFilterInputStream*)cPtr);
    return _retval;
  }

  /**
   * Sets whether the base stream will be closed when stream is closed.
   * Params:
   *   closeBase = %TRUE to close the base stream.
   */
  void setCloseBaseStream(bool closeBase)
  {
    g_filter_input_stream_set_close_base_stream(cast(GFilterInputStream*)cPtr, closeBase);
  }
}
