module Gdk.ContentSerializer;

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
import Gio.OutputStream;

/**
 * A `GdkContentSerializer` is used to serialize content for
 * inter-application data transfers.
 * The `GdkContentSerializer` transforms an object that is identified
 * by a GType into a serialized form $(LPAREN)i.e. a byte stream$(RPAREN) that is
 * identified by a mime type.
 * GTK provides serializers and deserializers for common data types
 * such as text, colors, images or file lists. To register your own
 * serialization functions, use func@Gdk.content_register_serializer.
 * Also see [Gdk.ContentDeserializer].
 */
class ContentSerializer : ObjectG, AsyncResult
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
    return gdk_content_serializer_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin AsyncResultT!();

  /**
   * Gets the cancellable for the current operation.
   * This is the `GCancellable` that was passed to funccontent_serialize_async.
   * Returns: the cancellable for the current operation
   */
  Cancellable getCancellable()
  {
    GCancellable* _cretval;
    _cretval = gdk_content_serializer_get_cancellable(cast(GdkContentSerializer*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Cancellable(cast(GCancellable*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the `GType` to of the object to serialize.
   * Returns: the `GType` for the current operation
   */
  GType getGtype()
  {
    GType _retval;
    _retval = gdk_content_serializer_get_gtype(cast(GdkContentSerializer*)cPtr);
    return _retval;
  }

  /**
   * Gets the mime type to serialize to.
   * Returns: the mime type for the current operation
   */
  string getMimeType()
  {
    const(char)* _cretval;
    _cretval = gdk_content_serializer_get_mime_type(cast(GdkContentSerializer*)cPtr);
    string _retval = _cretval.fromCString(false);
    return _retval;
  }

  /**
   * Gets the output stream for the current operation.
   * This is the stream that was passed to funccontent_serialize_async.
   * Returns: the output stream for the current operation
   */
  OutputStream getOutputStream()
  {
    GOutputStream* _cretval;
    _cretval = gdk_content_serializer_get_output_stream(cast(GdkContentSerializer*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!OutputStream(cast(GOutputStream*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the I/O priority for the current operation.
   * This is the priority that was passed to funccontent_serialize_async.
   * Returns: the I/O priority for the current operation
   */
  int getPriority()
  {
    int _retval;
    _retval = gdk_content_serializer_get_priority(cast(GdkContentSerializer*)cPtr);
    return _retval;
  }

  /**
   * Gets the data that was associated with the current operation.
   * See [Gdk.ContentSerializer.setTaskData].
   * Returns: the task data for serializer
   */
  void* getTaskData()
  {
    void* _retval;
    _retval = gdk_content_serializer_get_task_data(cast(GdkContentSerializer*)cPtr);
    return _retval;
  }

  /**
   * Gets the user data that was passed when the serializer was registered.
   * Returns: the user data for this serializer
   */
  void* getUserData()
  {
    void* _retval;
    _retval = gdk_content_serializer_get_user_data(cast(GdkContentSerializer*)cPtr);
    return _retval;
  }

  /**
   * Gets the `GValue` to read the object to serialize from.
   * Returns: the `GValue` for the current operation
   */
  Value getValue()
  {
    const(GValue)* _cretval;
    _cretval = gdk_content_serializer_get_value(cast(GdkContentSerializer*)cPtr);
    auto _retval = _cretval ? new Value(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Indicate that the serialization has ended with an error.
   * This function consumes error.
   * Params:
   *   error = a `GError`
   */
  void returnError(ErrorG error)
  {
    gdk_content_serializer_return_error(cast(GdkContentSerializer*)cPtr, error ? cast(GError*)error.cPtr : null);
  }

  /**
   * Indicate that the serialization has been successfully completed.
   */
  void returnSuccess()
  {
    gdk_content_serializer_return_success(cast(GdkContentSerializer*)cPtr);
  }

  /**
   * Associate data with the current serialization operation.
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
    gdk_content_serializer_set_task_data(cast(GdkContentSerializer*)cPtr, data, &_notifyCallback);
  }
}
