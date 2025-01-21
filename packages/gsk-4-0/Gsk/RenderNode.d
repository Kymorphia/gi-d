module Gsk.RenderNode;

import GLib.Bytes;
import GLib.ErrorG;
import Gid.gid;
import Graphene.Rect;
import Gsk.Types;
import Gsk.c.functions;
import Gsk.c.types;
import cairo.Context;

/**
 * `GskRenderNode` is the basic block in a scene graph to be
 * rendered using [Gsk.Renderer].
 * Each node has a parent, except the top-level node; each node may have
 * children nodes.
 * Each node has an associated drawing surface, which has the size of
 * the rectangle set when creating it.
 * Render nodes are meant to be transient; once they have been associated
 * to a [Gsk.Renderer] it's safe to release any reference you have on
 * them. All [Gsk.RenderNode]s are immutable, you can only specify their
 * properties during construction.
 */
class RenderNode
{
  GskRenderNode* cInstancePtr;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gsk.RenderNode");

    cInstancePtr = cast(GskRenderNode*)ptr;

    if (!ownedRef)
      gsk_render_node_ref(cInstancePtr);
  }

  ~this()
  {
    gsk_render_node_unref(cInstancePtr);
  }


  void* cPtr(bool addRef = false)
  {
    if (addRef)
      gsk_render_node_ref(cInstancePtr);

    return cInstancePtr;
  }

  /**
   * Loads data previously created via [Gsk.RenderNode.serialize].
   * For a discussion of the supported format, see that function.
   * Params:
   *   bytes = the bytes containing the data
   *   errorFunc = Callback on parsing errors
   * Returns: a new `GskRenderNode`
   */
  static RenderNode deserialize(Bytes bytes, ParseErrorFunc errorFunc)
  {
    extern(C) void _errorFuncCallback(const(GskParseLocation)* start, const(GskParseLocation)* end, const(GError)* error, void* userData)
    {
      auto _dlg = cast(ParseErrorFunc*)userData;

      (*_dlg)(*start, *end, error ? new ErrorG(cast(void*)error, false) : null);
    }

    GskRenderNode* _cretval;
    auto _errorFunc = cast(void*)&errorFunc;
    _cretval = gsk_render_node_deserialize(bytes ? cast(GBytes*)bytes.cPtr(false) : null, &_errorFuncCallback, _errorFunc);
    auto _retval = _cretval ? new RenderNode(cast(GskRenderNode*)_cretval, true) : null;
    return _retval;
  }

  /**
   * Draw the contents of node to the given cairo context.
   * Typically, you'll use this function to implement fallback rendering
   * of `GskRenderNode`s on an intermediate Cairo context, instead of using
   * the drawing context associated to a [Gdk.Surface]'s rendering buffer.
   * For advanced nodes that cannot be supported using Cairo, in particular
   * for nodes doing 3D operations, this function may fail.
   * Params:
   *   cr = cairo context to draw to
   */
  void draw(Context cr)
  {
    gsk_render_node_draw(cast(GskRenderNode*)cPtr, cr ? cast(cairo_t*)cr.cPtr(false) : null);
  }

  /**
   * Retrieves the boundaries of the node.
   * The node will not draw outside of its boundaries.
   * Params:
   *   bounds = return location for the boundaries
   */
  void getBounds(out Rect bounds)
  {
    graphene_rect_t _bounds;
    gsk_render_node_get_bounds(cast(GskRenderNode*)cPtr, &_bounds);
    bounds = new Rect(cast(void*)&_bounds, false);
  }

  /**
   * Returns the type of the node.
   * Returns: the type of the `GskRenderNode`
   */
  RenderNodeType getNodeType()
  {
    GskRenderNodeType _cretval;
    _cretval = gsk_render_node_get_node_type(cast(GskRenderNode*)cPtr);
    RenderNodeType _retval = cast(RenderNodeType)_cretval;
    return _retval;
  }

  /**
   * Serializes the node for later deserialization via
   * [Gsk.RenderNode.deserialize]. No guarantees are made about the format
   * used other than that the same version of GTK will be able to deserialize
   * the result of a call to [Gsk.RenderNode.serialize] and
   * [Gsk.RenderNode.deserialize] will correctly reject files it cannot open
   * that were created with previous versions of GTK.
   * The intended use of this functions is testing, benchmarking and debugging.
   * The format is not meant as a permanent storage format.
   * Returns: a `GBytes` representing the node.
   */
  Bytes serialize()
  {
    GBytes* _cretval;
    _cretval = gsk_render_node_serialize(cast(GskRenderNode*)cPtr);
    auto _retval = _cretval ? new Bytes(cast(void*)_cretval, true) : null;
    return _retval;
  }

  /**
   * This function is equivalent to calling [Gsk.RenderNode.serialize]
   * followed by funcGLib.file_set_contents.
   * See those two functions for details on the arguments.
   * It is mostly intended for use inside a debugger to quickly dump a render
   * node to a file for later inspection.
   * Params:
   *   filename = the file to save it to.
   * Returns: %TRUE if saving was successful
   */
  bool writeToFile(string filename)
  {
    bool _retval;
    const(char)* _filename = filename.toCString(false);
    GError *_err;
    _retval = gsk_render_node_write_to_file(cast(GskRenderNode*)cPtr, _filename, &_err);
    if (_err)
      throw new ErrorG(_err);
    return _retval;
  }
}
