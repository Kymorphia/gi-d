module Pango.FontsetClass;

import GObject.ObjectClass;
import Gid.gid;
import Pango.Types;
import Pango.c.functions;
import Pango.c.types;

/**
 * The `PangoFontsetClass` structure holds the virtual functions for
 * a particular `PangoFontset` implementation.
 */
class FontsetClass
{
  PangoFontsetClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Pango.FontsetClass");

    cInstance = *cast(PangoFontsetClass*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property ObjectClass parentClass()
  {
    return new ObjectClass(cast(GObjectClass*)&(cast(PangoFontsetClass*)cPtr).parentClass);
  }

  alias GetFontFuncType = extern(C) PangoFont* function(PangoFontset* fontset, uint wc);

  @property GetFontFuncType getFont()
  {
    return (cast(PangoFontsetClass*)cPtr).getFont;
  }

  alias GetMetricsFuncType = extern(C) PangoFontMetrics* function(PangoFontset* fontset);

  @property GetMetricsFuncType getMetrics()
  {
    return (cast(PangoFontsetClass*)cPtr).getMetrics;
  }

  alias GetLanguageFuncType = extern(C) PangoLanguage* function(PangoFontset* fontset);

  @property GetLanguageFuncType getLanguage()
  {
    return (cast(PangoFontsetClass*)cPtr).getLanguage;
  }

  alias ForeachFuncType = extern(C) void function(PangoFontset* fontset, PangoFontsetForeachFunc func, void* data);

  @property ForeachFuncType foreach_()
  {
    return (cast(PangoFontsetClass*)cPtr).foreach_;
  }
}
