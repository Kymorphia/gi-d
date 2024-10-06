module Gsk.TextureNode;

import GObject.ObjectG;
import Gdk.Texture;
import Gid.gid;
import Graphene.Rect;
import Gsk.RenderNode;
import Gsk.Types;
import Gsk.c.functions;
import Gsk.c.types;

/**
 * A render node for a `GdkTexture`.
 */
class TextureNode : RenderNode
{

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gsk.TextureNode");

    super(cast(GskRenderNode*)ptr, ownedRef);
  }

  /**
   * Creates a `GskRenderNode` that will render the given
   * texture into the area given by bounds.
   * Note that GSK applies linear filtering when textures are
   * scaled and transformed. See [Gsk.TextureScaleNode]
   * for a way to influence filtering.
   * Params:
   *   texture = the `GdkTexture`
   *   bounds = the rectangle to render the texture into
   * Returns: A new `GskRenderNode`
   */
  this(Texture texture, Rect bounds)
  {
    GskRenderNode* _cretval;
    _cretval = gsk_texture_node_new(texture ? cast(GdkTexture*)texture.cPtr(false) : null, bounds ? cast(graphene_rect_t*)bounds.cPtr(false) : null);
    this(_cretval, true);
  }

  /**
   * Retrieves the `GdkTexture` used when creating this `GskRenderNode`.
   * Returns: the `GdkTexture`
   */
  Texture getTexture()
  {
    GdkTexture* _cretval;
    _cretval = gsk_texture_node_get_texture(cast(GskRenderNode*)cPtr);
    auto _retval = _cretval ? ObjectG.getDObject!Texture(cast(GdkTexture*)_cretval, false) : null;
    return _retval;
  }
}
