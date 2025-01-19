module Gdk.VulkanContext;

import GObject.DClosure;
import Gdk.DrawContext;
import Gdk.Types;
import Gdk.c.functions;
import Gdk.c.types;
import Gid.gid;
import Gio.Initable;
import Gio.InitableT;

/**
 * `GdkVulkanContext` is an object representing the platform-specific
 * Vulkan draw context.
 * `GdkVulkanContext`s are created for a surface using
 * [Gdk.Surface.createVulkanContext], and the context will match
 * the characteristics of the surface.
 * Support for `GdkVulkanContext` is platform-specific and context creation
 * can fail, returning %NULL context.
 */
class VulkanContext : DrawContext, Initable
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
    return gdk_vulkan_context_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  mixin InitableT!();

  /**
   * Emitted when the images managed by this context have changed.
   * Usually this means that the swapchain had to be recreated,
   * for example in response to a change of the surface size.
   *   vulkanContext = the instance the signal is connected to
   */
  alias ImagesUpdatedCallback = void delegate(VulkanContext vulkanContext);

  /**
   * Connect to ImagesUpdated signal.
   * Params:
   *   dlg = signal delegate callback to connect
   *   after = Yes.After to execute callback after default handler, No.After to execute before (default)
   * Returns: Signal ID
   */
  ulong connectImagesUpdated(ImagesUpdatedCallback dlg, Flag!"After" after = No.After)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto vulkanContext = getVal!VulkanContext(_paramVals);
      _dgClosure.dlg(vulkanContext);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("images-updated", closure, after);
  }
}
