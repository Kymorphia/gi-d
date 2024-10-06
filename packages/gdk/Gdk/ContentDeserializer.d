module Gdk.ContentDeserializer;

import GLib.ErrorG;
import GLib.Types;
import GObject.ObjectG;
import GObject.Types;
import GObject.Value;
import Gdk.Types;
import Gdk.c.functions;
import Gdk.c.types;
import Gid.gid;
import Gio.AsyncResult;
import Gio.AsyncResultT;
import Gio.Cancellable;
import Gio.InputStream;

/**
 * A `GdkContentDeserializer` is used to deserialize content received via
 * inter-application data transfers.
 * The `GdkContentDeserializer` transforms serialized content that is
 * identified by a mime type into an object identified by a GType.
 * GTK provides serializers and deserializers for common data types
 * such as text, colors, images or file lists. To register your own
 * deserialization functions, use func@content_register_deserializer.
 * Also see [Gdk.ContentSerializer].
 */
class ContentDeserializer : ObjectG, AsyncResult
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
    return gdk_content_deserializer_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin AsyncResultT!GdkContentDeserializer;

  /**
   * Gets the cancellable for the current operation.
   * This is the `GCancellable` that was passed to funcGdk.content_deserialize_async.
   * Returns: the cancellable for the current operation
   */
  Cancellable getCancellable()
  {
    GCancellable* _cretval;
    _cretval = gdk_content_deserializer_get_cancellable(cast(GdkContentDeserializer*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Cancellable(cast(GCancellable*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the `GType` to create an instance of.
   * Returns: the `GType` for the current operation
   */
  GType getGtype()
  {
    GType _retval;
    _retval = gdk_content_deserializer_get_gtype(cast(GdkContentDeserializer*)cPtr);
    return _retval;
  }

  /**
   * Gets the input stream for the current operation.
   * This is the stream that was passed to funcGdk.content_deserialize_async.
   * Returns: the input stream for the current operation
   */
  InputStream getInputStream()
  {
    GInputStream* _cretval;
    _cretval = gdk_content_deserializer_get_input_stream(cast(GdkContentDeserializer*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!InputStream(cast(GInputStream*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the mime type to deserialize from.
   * Returns: the mime type for the current operation
   */
  string getMimeType()
  {
    const(char)* _cretval;
    _cretval = gdk_content_deserializer_get_mime_type(cast(GdkContentDeserializer*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Gets the I/O priority for the current operation.
   * This is the priority that was passed to funcGdk.content_deserialize_async.
   * Returns: the I/O priority for the current operation
   */
  int getPriority()
  {
    int _retval;
    _retval = gdk_content_deserializer_get_priority(cast(GdkContentDeserializer*)cPtr);
    return _retval;
  }

  /**
   * Gets the data that was associated with the current operation.
   * See [Gdk.ContentDeserializer.setTaskData].
   * Returns: the task data for deserializer
   */
  void* getTaskData()
  {
    void* _retval;
    _retval = gdk_content_deserializer_get_task_data(cast(GdkContentDeserializer*)cPtr);
    return _retval;
  }

  /**
   * Gets the user data that was passed when the deserializer was registered.
   * Returns: the user data for this deserializer
   */
  void* getUserData()
  {
    void* _retval;
    _retval = gdk_content_deserializer_get_user_data(cast(GdkContentDeserializer*)cPtr);
    return _retval;
  }

  /**
   * Gets the `GValue` to store the deserialized object in.
   * Returns: the `GValue` for the current operation
   */
  Value getValue()
  {
    GValue* _cretval;
    _cretval = gdk_content_deserializer_get_value(cast(GdkContentDeserializer*)cPtr);
    auto _retval = _cretval ? new Value(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Indicate that the deserialization has ended with an error.
   * This function consumes error.
   * Params:
   *   error = a `GError`
   */
  void returnError(ErrorG error)
  {
    gdk_content_deserializer_return_error(cast(GdkContentDeserializer*)cPtr, error ? cast(GError*)error.cPtr : null);
  }

  /**
   * Indicate that the deserialization has been successfully completed.
   */
  void returnSuccess()
  {
    gdk_content_deserializer_return_success(cast(GdkContentDeserializer*)cPtr);
  }

  /**
   * Associate data with the current deserialization operation.
   * Params:
   *   data = data to associate with this operation
   *   notify = destroy notify for data
   */
  void setTaskData(void* data, DestroyNotify notify)
  {
    extern(C) void _notifyCallback(void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(DestroyNotify*)data;

      (*_dlg)();
    }
    gdk_content_deserializer_set_task_data(cast(GdkContentDeserializer*)cPtr, data, &_notifyCallback);
  }
}
