module Gdk.Drag;

import GObject.DClosure;
import GObject.ObjectG;
import GObject.Types;
import Gdk.ContentFormats;
import Gdk.ContentProvider;
import Gdk.Device;
import Gdk.Display;
import Gdk.Surface;
import Gdk.Types;
import Gdk.c.functions;
import Gdk.c.types;
import Gid.gid;

/**
 * The `GdkDrag` object represents the source of an ongoing DND operation.
 * A `GdkDrag` is created when a drag is started, and stays alive for duration of
 * the DND operation. After a drag has been started with [Gdk.Drag.begin],
 * the caller gets informed about the status of the ongoing drag operation
 * with signals on the `GdkDrag` object.
 * GTK provides a higher level abstraction based on top of these functions,
 * and so they are not normally needed in GTK applications. See the
 * "Drag and Drop" section of the GTK documentation for more information.
 */
class Drag : ObjectG
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
    return gdk_drag_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Starts a drag and creates a new drag context for it.
   * This function is called by the drag source. After this call, you
   * probably want to set up the drag icon using the surface returned
   * by [Gdk.Drag.getDragSurface].
   * This function returns a reference to the [Gdk.Drag] object,
   * but GTK keeps its own reference as well, as long as the DND operation
   * is going on.
   * Note: if actions include %GDK_ACTION_MOVE, you need to listen for
   * the signalGdk.Drag::dnd-finished signal and delete the data at
   * the source if [Gdk.Drag.getSelectedAction] returns
   * %GDK_ACTION_MOVE.
   * Params:
   *   surface = the source surface for this drag
   *   device = the device that controls this drag
   *   content = the offered content
   *   actions = the actions supported by this drag
   *   dx = the x offset to device's position where the drag nominally started
   *   dy = the y offset to device's position where the drag nominally started
   * Returns: a newly created `GdkDrag`
   */
  static Drag begin(Surface surface, Device device, ContentProvider content, DragAction actions, double dx, double dy)
  {
    GdkDrag* _cretval;
    _cretval = gdk_drag_begin(surface ? cast(GdkSurface*)surface.cPtr(false) : null, device ? cast(GdkDevice*)device.cPtr(false) : null, content ? cast(GdkContentProvider*)content.cPtr(false) : null, actions, dx, dy);
    auto _retval = _cretval ? ObjectG.getDObject!Drag(cast(GdkDrag*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Informs GDK that the drop ended.
   * Passing %FALSE for success may trigger a drag cancellation
   * animation.
   * This function is called by the drag source, and should be the
   * last call before dropping the reference to the drag.
   * The `GdkDrag` will only take the first [Gdk.Drag.dropDone]
   * call as effective, if this function is called multiple times,
   * all subsequent calls will be ignored.
   * Params:
   *   success = whether the drag was ultimatively successful
   */
  void dropDone(bool success)
  {
    gdk_drag_drop_done(cast(GdkDrag*)cPtr, success);
  }

  /**
   * Determines the bitmask of possible actions proposed by the source.
   * Returns: the `GdkDragAction` flags
   */
  DragAction getActions()
  {
    GdkDragAction _cretval;
    _cretval = gdk_drag_get_actions(cast(GdkDrag*)cPtr);
    DragAction _retval = cast(DragAction)_cretval;
    return _retval;
  }

  /**
   * Returns the `GdkContentProvider` associated to the `GdkDrag` object.
   * Returns: The `GdkContentProvider` associated to drag.
   */
  ContentProvider getContent()
  {
    GdkContentProvider* _cretval;
    _cretval = gdk_drag_get_content(cast(GdkDrag*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!ContentProvider(cast(GdkContentProvider*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns the `GdkDevice` associated to the `GdkDrag` object.
   * Returns: The `GdkDevice` associated to drag.
   */
  Device getDevice()
  {
    GdkDevice* _cretval;
    _cretval = gdk_drag_get_device(cast(GdkDrag*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Device(cast(GdkDevice*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Gets the `GdkDisplay` that the drag object was created for.
   * Returns: a `GdkDisplay`
   */
  Display getDisplay()
  {
    GdkDisplay* _cretval;
    _cretval = gdk_drag_get_display(cast(GdkDrag*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Display(cast(GdkDisplay*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Returns the surface on which the drag icon should be rendered
   * during the drag operation.
   * Note that the surface may not be available until the drag operation
   * has begun. GDK will move the surface in accordance with the ongoing
   * drag operation. The surface is owned by drag and will be destroyed
   * when the drag operation is over.
   * Returns: the drag surface
   */
  Surface getDragSurface()
  {
    GdkSurface* _cretval;
    _cretval = gdk_drag_get_drag_surface(cast(GdkDrag*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Surface(cast(GdkSurface*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Retrieves the formats supported by this `GdkDrag` object.
   * Returns: a `GdkContentFormats`
   */
  ContentFormats getFormats()
  {
    GdkContentFormats* _cretval;
    _cretval = gdk_drag_get_formats(cast(GdkDrag*)cPtr);
    auto _retval = _cretval ? new ContentFormats(cast(void*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Determines the action chosen by the drag destination.
   * Returns: a `GdkDragAction` value
   */
  DragAction getSelectedAction()
  {
    GdkDragAction _cretval;
    _cretval = gdk_drag_get_selected_action(cast(GdkDrag*)cPtr);
    DragAction _retval = cast(DragAction)_cretval;
    return _retval;
  }

  /**
   * Returns the `GdkSurface` where the drag originates.
   * Returns: The `GdkSurface` where the drag originates
   */
  Surface getSurface()
  {
    GdkSurface* _cretval;
    _cretval = gdk_drag_get_surface(cast(GdkDrag*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Surface(cast(GdkSurface*)_cretval, false) : null;
    return _retval;
  }

  /**
   * Sets the position of the drag surface that will be kept
   * under the cursor hotspot.
   * Initially, the hotspot is at the top left corner of the drag surface.
   * Params:
   *   hotX = x coordinate of the drag surface hotspot
   *   hotY = y coordinate of the drag surface hotspot
   */
  void setHotspot(int hotX, int hotY)
  {
    gdk_drag_set_hotspot(cast(GdkDrag*)cPtr, hotX, hotY);
  }

  /**
   * Emitted when the drag operation is cancelled.
   * Params
   *   reason = The reason the drag was cancelled
   *   drag = the instance the signal is connected to
   */
  alias CancelCallback = void delegate(DragCancelReason reason, Drag drag);

  /**
   * Connect to Cancel signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectCancel(CancelCallback dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 2, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto drag = getVal!Drag(_paramVals);
      auto reason = getVal!DragCancelReason(&_paramVals[1]);
      _dgClosure.dlg(reason, drag);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("cancel", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * Emitted when the destination side has finished reading all data.
   * The drag object can now free all miscellaneous data.
   *   drag = the instance the signal is connected to
   */
  alias DndFinishedCallback = void delegate(Drag drag);

  /**
   * Connect to DndFinished signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectDndFinished(DndFinishedCallback dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto drag = getVal!Drag(_paramVals);
      _dgClosure.dlg(drag);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("dnd-finished", closure, (flags & ConnectFlags.After) != 0);
  }

  /**
   * Emitted when the drop operation is performed on an accepting client.
   *   drag = the instance the signal is connected to
   */
  alias DropPerformedCallback = void delegate(Drag drag);

  /**
   * Connect to DropPerformed signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectDropPerformed(DropPerformedCallback dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto drag = getVal!Drag(_paramVals);
      _dgClosure.dlg(drag);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("drop-performed", closure, (flags & ConnectFlags.After) != 0);
  }
}
