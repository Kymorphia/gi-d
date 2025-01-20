module Gio.ConverterIfaceProxy;

import GObject.ObjectG;
import Gio.Converter;
import Gio.ConverterT;

/// Proxy object for Gio.Converter interface when a GObject has no applicable D binding
class ConverterIfaceProxy : IfaceProxy, Converter
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
    return typeid(Converter);
  }

  mixin ConverterT!();
}
