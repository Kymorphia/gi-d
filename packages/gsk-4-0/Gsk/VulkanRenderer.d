module Gsk.VulkanRenderer;

import Gid.gid;
import Gsk.Renderer;
import Gsk.Types;
import Gsk.c.functions;
import Gsk.c.types;

/**
 * A GSK renderer that is using Vulkan.
 * This renderer will fail to realize if Vulkan is not supported.
 */
class VulkanRenderer : Renderer
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return gsk_vulkan_renderer_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  this()
  {
    GskRenderer* _cretval;
    _cretval = gsk_vulkan_renderer_new();
    this(_cretval, true);
  }
}
