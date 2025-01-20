module PangoCairo.FontIfaceProxy;

import GObject.ObjectG;
import PangoCairo.Font;
import PangoCairo.FontT;

/// Proxy object for PangoCairo.Font interface when a GObject has no applicable D binding
class FontIfaceProxy : IfaceProxy, Font
{
  this()
  {
  }

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  override TypeInfo_Interface getIface()
  {
    return typeid(Font);
  }

  mixin FontT!();
}
