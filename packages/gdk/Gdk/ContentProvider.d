module Gdk.ContentProvider;

import GLib.Bytes;
import GLib.ErrorG;
import GObject.DClosure;
import GObject.ObjectG;
import GObject.Types;
import GObject.Value;
import Gdk.ContentFormats;
import Gdk.Types;
import Gdk.c.functions;
import Gdk.c.types;
import Gid.gid;
import Gio.AsyncResult;
import Gio.AsyncResultT;
import Gio.Cancellable;
import Gio.OutputStream;
import Gio.Types;

/**
 * A `GdkContentProvider` is used to provide content for the clipboard or
 * for drag-and-drop operations in a number of formats.
 * To create a `GdkContentProvider`, use [Gdk.ContentProvider.newForValue]
 * or [Gdk.ContentProvider.newForBytes].
 * GDK knows how to handle common text and image formats out-of-the-box. See
 * [Gdk.ContentSerializer] and [Gdk.ContentDeserializer] if you want
 * to add support for application-specific data formats.
 */
class ContentProvider : ObjectG
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
    return gdk_content_provider_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Create a content provider that provides the given bytes as data for
   * the given mime_type.
   * Params:
   *   mimeType = the mime type
   *   bytes = a `GBytes` with the data for mime_type
   * Returns: a new `GdkContentProvider`
   */
  static ContentProvider newForBytes(string mimeType, Bytes bytes)
  {
    GdkContentProvider* _cretval;
    const(char)* _mimeType = mimeType.toCString(false);
    _cretval = gdk_content_provider_new_for_bytes(_mimeType, bytes ? cast(GBytes*)bytes.cPtr(false) : null);
    auto _retval = _cretval ? ObjectG.getDObject!ContentProvider(cast(GdkContentProvider*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Create a content provider that provides the given value.
   * Params:
   *   value = a `GValue`
   * Returns: a new `GdkContentProvider`
   */
  static ContentProvider newForValue(Value value)
  {
    GdkContentProvider* _cretval;
    _cretval = gdk_content_provider_new_for_value(value ? cast(GValue*)value.cPtr(false) : null);
    auto _retval = _cretval ? ObjectG.getDObject!ContentProvider(cast(GdkContentProvider*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Emits the ::content-changed signal.
   */
  void contentChanged()
  {
    gdk_content_provider_content_changed(cast(GdkContentProvider*)cPtr);
  }

  /**
   * Gets the contents of provider stored in value.
   * The value will have been initialized to the `GType` the value should be
   * provided in. This given `GType` does not need to be listed in the formats
   * returned by [Gdk.ContentProvider.refFormats]. However, if the
   * given `GType` is not supported, this operation can fail and
   * `G_IO_ERROR_NOT_SUPPORTED` will be reported.
   * Params:
   *   value = the `GValue` to fill
   * Returns: %TRUE if the value was set successfully. Otherwise
   *   error will be set to describe the failure.
   */
  bool getValue(out Value value)
  {
    bool _retval;
    GValue _value;
    GError *_err;
    _retval = gdk_content_provider_get_value(cast(GdkContentProvider*)cPtr, &_value, &_err);
    if (_err)
      throw new ErrorG(_err);
    value = new Value(cast(void*)&_value, false);
    return _retval;
  }

  /**
   * Gets the formats that the provider can provide its current contents in.
   * Returns: The formats of the provider
   */
  ContentFormats refFormats()
  {
    GdkContentFormats* _cretval;
    _cretval = gdk_content_provider_ref_formats(cast(GdkContentProvider*)cPtr);
    auto _retval = _cretval ? new ContentFormats(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Gets the formats that the provider suggests other applications to store
   * the data in.
   * An example of such an application would be a clipboard manager.
   * This can be assumed to be a subset of [Gdk.ContentProvider.refFormats].
   * Returns: The storable formats of the provider
   */
  ContentFormats refStorableFormats()
  {
    GdkContentFormats* _cretval;
    _cretval = gdk_content_provider_ref_storable_formats(cast(GdkContentProvider*)cPtr);
    auto _retval = _cretval ? new ContentFormats(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Asynchronously writes the contents of provider to stream in the given
   * mime_type.
   * When the operation is finished callback will be called. You must then call
   * [Gdk.ContentProvider.writeMimeTypeFinish] to get the result
   * of the operation.
   * The given mime type does not need to be listed in the formats returned by
   * [Gdk.ContentProvider.refFormats]. However, if the given `GType` is
   * not supported, `G_IO_ERROR_NOT_SUPPORTED` will be reported.
   * The given stream will not be closed.
   * Params:
   *   mimeType = the mime type to provide the data in
   *   stream = the `GOutputStream` to write to
   *   ioPriority = I/O priority of the request.
   *   cancellable = optional `GCancellable` object, %NULL to ignore.
   *   callback = callback to call when the request is satisfied
   */
  void writeMimeTypeAsync(string mimeType, OutputStream stream, int ioPriority, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(AsyncReadyCallback*)data;

      (*_dlg)(sourceObject ? ObjectG.getDObject!ObjectG(cast(void*)sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(cast(void*)res, false) : null);
    }

    const(char)* _mimeType = mimeType.toCString(false);
    auto _callback = freezeDelegate(cast(void*)&callback);
    gdk_content_provider_write_mime_type_async(cast(GdkContentProvider*)cPtr, _mimeType, stream ? cast(GOutputStream*)stream.cPtr(false) : null, ioPriority, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_callbackCallback, _callback);
  }

  /**
   * Finishes an asynchronous write operation.
   * See [Gdk.ContentProvider.writeMimeTypeAsync].
   * Params:
   *   result = a `GAsyncResult`
   * Returns: %TRUE if the operation was completed successfully. Otherwise
   *   error will be set to describe the failure.
   */
  bool writeMimeTypeFinish(AsyncResult result)
  {
    bool _retval;
    GError *_err;
    _retval = gdk_content_provider_write_mime_type_finish(cast(GdkContentProvider*)cPtr, result ? cast(GAsyncResult*)(cast(ObjectG)result).cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }

  /**
   * Emitted whenever the content provided by this provider has changed.
   *   contentProvider = the instance the signal is connected to
   */
  alias ContentChangedCallback = void delegate(ContentProvider contentProvider);

  /**
   * Connect to ContentChanged signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectContentChanged(ContentChangedCallback dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto contentProvider = getVal!ContentProvider(_paramVals);
      _dgClosure.dlg(contentProvider);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("content-changed", closure, (flags & ConnectFlags.After) != 0);
  }
}
