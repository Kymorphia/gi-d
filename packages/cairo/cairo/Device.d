module cairo.Device;

import GLib.Boxed;
import Gid.gid;
import cairo.Types;
import cairo.c.functions;
import cairo.c.types;

/**
 * A #cairo_device_t represents the driver interface for drawing
 * operations to a #cairo_surface_t.  There are different subtypes of
 * #cairo_device_t for different drawing backends.
 * The type of a device can be queried with [cairo.Device.getDeviceType].
 * Memory management of #cairo_device_t is done with
 * [cairo.Device.reference] and [cairo.Device.destroy].
 */
class Device : Boxed
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
    return cairo_gobject_device_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Acquires the device for the current thread. This function will block
   * until no other thread has acquired the device.
   * If the return value is %CAIRO_STATUS_SUCCESS, you successfully acquired the
   * device. From now on your thread owns the device and no other thread will be
   * able to acquire it until a matching call to [cairo.Device.release]. It is
   * allowed to recursively acquire the device multiple times from the same
   * thread.
   * <note><para>You must never acquire two different devices at the same time
   * unless this is explicitly allowed. Otherwise the possibility of deadlocks
   * exist.
   * As various Cairo functions can acquire devices when called, these functions
   * may also cause deadlocks when you call them with an acquired device. So you
   * must not have a device acquired when calling them. These functions are
   * marked in the documentation.
   * </para></note>
   * Returns: %CAIRO_STATUS_SUCCESS on success or an error code if
   *   the device is in an error state and could not be
   *   acquired. After a successful call to [cairo.Device.acquire],
   *   a matching call to [cairo.Device.release] is required.
   */
  Status acquire()
  {
    cairo_status_t _cretval;
    _cretval = cairo_device_acquire(cast(cairo_device_t*)cPtr);
    Status _retval = cast(Status)_cretval;
    return _retval;
  }

  /**
   * This function finishes the device and drops all references to
   * external resources. All surfaces, fonts and other objects created
   * for this device will be finished, too.
   * Further operations on the device will not affect the device but
   * will instead trigger a %CAIRO_STATUS_DEVICE_FINISHED error.
   * When the last call to [cairo.Device.destroy] decreases the
   * reference count to zero, cairo will call [cairo.Device.finish] if
   * it hasn't been called already, before freeing the resources
   * associated with the device.
   * This function may acquire devices.
   */
  void finish()
  {
    cairo_device_finish(cast(cairo_device_t*)cPtr);
  }

  /**
   * Finish any pending operations for the device and also restore any
   * temporary modifications cairo has made to the device's state.
   * This function must be called before switching from using the
   * device with Cairo to operating on it directly with native APIs.
   * If the device doesn't support direct access, then this function
   * does nothing.
   * This function may acquire devices.
   */
  void flush()
  {
    cairo_device_flush(cast(cairo_device_t*)cPtr);
  }

  /**
   * This function returns the type of the device. See #cairo_device_type_t
   * for available types.
   * Returns: The type of device.
   */
  DeviceType getDeviceType()
  {
    cairo_device_type_t _cretval;
    _cretval = cairo_device_get_type(cast(cairo_device_t*)cPtr);
    DeviceType _retval = cast(DeviceType)_cretval;
    return _retval;
  }

  /**
   * Return user data previously attached to device using the
   * specified key.  If no user data has been attached with the given
   * key this function returns %NULL.
   * Params:
   *   key = the address of the #cairo_user_data_key_t the user data was
   *     attached to
   * Returns: the user data previously attached or %NULL.
   */
  void* getUserData(UserDataKey key)
  {
    void* _retval;
    _retval = cairo_device_get_user_data(cast(cairo_device_t*)cPtr, &key);
    return _retval;
  }

  /**
   * Returns the total elapsed time of the observation.
   * Returns: the elapsed time, in nanoseconds.
   */
  double observerElapsed()
  {
    double _retval;
    _retval = cairo_device_observer_elapsed(cast(cairo_device_t*)cPtr);
    return _retval;
  }

  /**
   * Returns the elapsed time of the fill operations.
   * Returns: the elapsed time, in nanoseconds.
   */
  double observerFillElapsed()
  {
    double _retval;
    _retval = cairo_device_observer_fill_elapsed(cast(cairo_device_t*)cPtr);
    return _retval;
  }

  /**
   * Returns the elapsed time of the glyph operations.
   * Returns: the elapsed time, in nanoseconds.
   */
  double observerGlyphsElapsed()
  {
    double _retval;
    _retval = cairo_device_observer_glyphs_elapsed(cast(cairo_device_t*)cPtr);
    return _retval;
  }

  /**
   * Returns the elapsed time of the mask operations.
   * Returns: the elapsed time, in nanoseconds
   */
  double observerMaskElapsed()
  {
    double _retval;
    _retval = cairo_device_observer_mask_elapsed(cast(cairo_device_t*)cPtr);
    return _retval;
  }

  /**
   * Returns the elapsed time of the paint operations.
   * Returns: the elapsed time, in nanoseconds.
   */
  double observerPaintElapsed()
  {
    double _retval;
    _retval = cairo_device_observer_paint_elapsed(cast(cairo_device_t*)cPtr);
    return _retval;
  }

  /**
   * Returns the elapsed time of the stroke operations.
   * Returns: the elapsed time, in nanoseconds.
   */
  double observerStrokeElapsed()
  {
    double _retval;
    _retval = cairo_device_observer_stroke_elapsed(cast(cairo_device_t*)cPtr);
    return _retval;
  }

  /**
   * Releases a device previously acquired using [cairo.Device.acquire]. See
   * that function for details.
   */
  void release()
  {
    cairo_device_release(cast(cairo_device_t*)cPtr);
  }

  /**
   * Checks whether an error has previously occurred for this
   * device.
   * Returns: %CAIRO_STATUS_SUCCESS on success or an error code if
   *   the device is in an error state.
   */
  Status status()
  {
    cairo_status_t _cretval;
    _cretval = cairo_device_status(cast(cairo_device_t*)cPtr);
    Status _retval = cast(Status)_cretval;
    return _retval;
  }
}
