module PangoCairo.FontMapIfaceProxy;

import GObject.ObjectG;
import PangoCairo.FontMap;
import PangoCairo.FontMapT;

/// Proxy object for PangoCairo.FontMap interface when a GObject has no applicable D binding
class FontMapIfaceProxy : IfaceProxy, FontMap
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
    return typeid(FontMap);
  }

  mixin FontMapT!();
}
