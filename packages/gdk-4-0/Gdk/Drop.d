module Gdk.Drop;

import GLib.ErrorG;
import GObject.ObjectG;
import GObject.Types;
import GObject.Value;
import Gdk.ContentFormats;
import Gdk.Device;
import Gdk.Display;
import Gdk.Drag;
import Gdk.Surface;
import Gdk.Types;
import Gdk.c.functions;
import Gdk.c.types;
import Gid.gid;
import Gio.AsyncResult;
import Gio.AsyncResultT;
import Gio.Cancellable;
import Gio.InputStream;
import Gio.Types;

/**
 * The `GdkDrop` object represents the target of an ongoing DND operation.
 * Possible drop sites get informed about the status of the ongoing drag
 * operation with events of type %GDK_DRAG_ENTER, %GDK_DRAG_LEAVE,
 * %GDK_DRAG_MOTION and %GDK_DROP_START. The `GdkDrop` object can be obtained
 * from these [Gdk.Event] types using [Gdk.DNDEvent.getDrop].
 * The actual data transfer is initiated from the target side via an async
 * read, using one of the `GdkDrop` methods for this purpose:
 * [Gdk.Drop.readAsync] or [Gdk.Drop.readValueAsync].
 * GTK provides a higher level abstraction based on top of these functions,
 * and so they are not normally needed in GTK applications. See the
 * "Drag and Drop" section of the GTK documentation for more information.
 */
class Drop : ObjectG
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
    return gdk_drop_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Ends the drag operation after a drop.
   * The action must be a single action selected from the actions
   * available via [Gdk.Drop.getActions].
   * Params:
   *   action = the action performed by the destination or 0 if the drop failed
   */
  void finish(DragAction action)
  {
    gdk_drop_finish(cast(GdkDrop*)cPtr, action);
  }

  /**
   * Returns the possible actions for this `GdkDrop`.
   * If this value contains multiple actions - i.e.
   * funcGdk.DragAction.is_unique returns %FALSE for the result -
   * [Gdk.Drop.finish] must choose the action to use when
   * accepting the drop. This will only happen if you passed
   * %GDK_ACTION_ASK as one of the possible actions in
   * [Gdk.Drop.status]. %GDK_ACTION_ASK itself will not
   * be included in the actions returned by this function.
   * This value may change over the lifetime of the [Gdk.Drop]
   * both as a response to source side actions as well as to calls to
   * [Gdk.Drop.status] or [Gdk.Drop.finish]. The source
   * side will not change this value anymore once a drop has started.
   * Returns: The possible `GdkDragActions`
   */
  DragAction getActions()
  {
    GdkDragAction _cretval;
    _cretval = gdk_drop_get_actions(cast(GdkDrop*)cPtr);
    DragAction _retval = cast(DragAction)_cretval;
    return _retval;
  }

  /**
   * Returns the `GdkDevice` performing the drop.
   * Returns: The `GdkDevice` performing the drop.
   */
  Device getDevice()
  {
    GdkDevice* _cretval;
    _cretval = gdk_drop_get_device(cast(GdkDrop*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Device(cast(GdkDevice*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the `GdkDisplay` that self was created for.
   * Returns: a `GdkDisplay`
   */
  Display getDisplay()
  {
    GdkDisplay* _cretval;
    _cretval = gdk_drop_get_display(cast(GdkDrop*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Display(cast(GdkDisplay*)_cretval, false) : null;
    return _retval;
  }

  /**
   * If this is an in-app drag-and-drop operation, returns the `GdkDrag`
   * that corresponds to this drop.
   * If it is not, %NULL is returned.
   * Returns: the corresponding `GdkDrag`
   */
  Drag getDrag()
  {
    GdkDrag* _cretval;
    _cretval = gdk_drop_get_drag(cast(GdkDrop*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Drag(cast(GdkDrag*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns the `GdkContentFormats` that the drop offers the data
   * to be read in.
   * Returns: The possible `GdkContentFormats`
   */
  ContentFormats getFormats()
  {
    GdkContentFormats* _cretval;
    _cretval = gdk_drop_get_formats(cast(GdkDrop*)cPtr);
    auto _retval = _cretval ? new ContentFormats(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns the `GdkSurface` performing the drop.
   * Returns: The `GdkSurface` performing the drop.
   */
  Surface getSurface()
  {
    GdkSurface* _cretval;
    _cretval = gdk_drop_get_surface(cast(GdkDrop*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Surface(cast(GdkSurface*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Finishes an async drop read operation.
   * Note that you must not use blocking read calls on the returned stream
   * in the GTK thread, since some platforms might require communication with
   * GTK to complete the data transfer. You can use async APIs such as
   * [Gio.InputStream.readBytesAsync].
   * See [Gdk.Drop.readAsync].
   * Params:
   *   result = a `GAsyncResult`
   *   outMimeType = return location for the used mime type
   * Returns: the `GInputStream`
   */
  InputStream readFinish(AsyncResult result, out string outMimeType)
  {
    GInputStream* _cretval;
    char* _outMimeType;
    GError *_err;
    _cretval = gdk_drop_read_finish(cast(GdkDrop*)cPtr, result ? cast(GAsyncResult*)(cast(ObjectG)result).cPtr(false) : null, &_outMimeType, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = _cretval ? ObjectG.getDObject!InputStream(cast(GInputStream*)_cretval, true) : null;
    outMimeType = _outMimeType.fromCString(false);
    return _retval;
  }

  /**
   * Asynchronously request the drag operation's contents converted
   * to the given type.
   * When the operation is finished callback will be called. You must
   * then call [Gdk.Drop.readValueFinish] to get the resulting
   * `GValue`.
   * For local drag-and-drop operations that are available in the given
   * `GType`, the value will be copied directly. Otherwise, GDK will
   * try to use funcGdk.content_deserialize_async to convert the data.
   * Params:
   *   type = a `GType` to read
   *   ioPriority = the I/O priority of the request.
   *   cancellable = optional `GCancellable` object, %NULL to ignore.
   *   callback = callback to call when the request is satisfied
   */
  void readValueAsync(GType type, int ioPriority, Cancellable cancellable, AsyncReadyCallback callback)
  {
    extern(C) void _callbackCallback(ObjectC* sourceObject, GAsyncResult* res, void* data)
    {
      ptrThawGC(data);
      auto _dlg = cast(AsyncReadyCallback*)data;

      (*_dlg)(sourceObject ? ObjectG.getDObject!ObjectG(cast(void*)sourceObject, false) : null, res ? ObjectG.getDObject!AsyncResult(cast(void*)res, false) : null);
    }

    auto _callback = freezeDelegate(cast(void*)&callback);
    gdk_drop_read_value_async(cast(GdkDrop*)cPtr, type, ioPriority, cancellable ? cast(GCancellable*)cancellable.cPtr(false) : null, &_callbackCallback, _callback);
  }

  /**
   * Finishes an async drop read.
   * See [Gdk.Drop.readValueAsync].
   * Params:
   *   result = a `GAsyncResult`
   * Returns: a `GValue` containing the result.
   */
  Value readValueFinish(AsyncResult result)
  {
    const(GValue)* _cretval;
    GError *_err;
    _cretval = gdk_drop_read_value_finish(cast(GdkDrop*)cPtr, result ? cast(GAsyncResult*)(cast(ObjectG)result).cPtr(false) : null, &_err);
    if (_err)
      throw new ErrorG(_err);
    auto _retval = _cretval ? new Value(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Selects all actions that are potentially supported by the destination.
   * When calling this function, do not restrict the passed in actions to
   * the ones provided by [Gdk.Drop.getActions]. Those actions may
   * change in the future, even depending on the actions you provide here.
   * The preferred action is a hint to the drag-and-drop mechanism about which
   * action to use when multiple actions are possible.
   * This function should be called by drag destinations in response to
   * %GDK_DRAG_ENTER or %GDK_DRAG_MOTION events. If the destination does
   * not yet know the exact actions it supports, it should set any possible
   * actions first and then later call this function again.
   * Params:
   *   actions = Supported actions of the destination, or 0 to indicate
   *     that a drop will not be accepted
   *   preferred = A unique action that's a member of actions indicating the
   *     preferred action
   */
  void status(DragAction actions, DragAction preferred)
  {
    gdk_drop_status(cast(GdkDrop*)cPtr, actions, preferred);
  }
}
