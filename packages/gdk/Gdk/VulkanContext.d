module Gdk.VulkanContext;

import GObject.DClosure;
import GObject.Types;
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

  mixin InitableT!GdkVulkanContext;

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
   *   flags = connection flags
   * Returns: Signal ID
   */
  ulong connectImagesUpdated(ImagesUpdatedCallback dlg, ConnectFlags flags = ConnectFlags.Default)
  {
    extern(C) void _cmarshal(GClosure* _closure, GValue* _returnValue, uint _nParams, const(GValue)* _paramVals, void* _invocHint, void* _marshalData)
    {
      assert(_nParams == 1, "Unexpected number of signal parameters");
      auto _dgClosure = cast(DGClosure!(typeof(dlg))*)_closure;
      auto vulkanContext = getVal!VulkanContext(_paramVals);
      _dgClosure.dlg(vulkanContext);
    }

    auto closure = new DClosure(dlg, &_cmarshal);
    return connectSignalClosure("images-updated", closure, (flags & ConnectFlags.After) != 0);
  }
}
