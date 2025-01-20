module Pango.FontClass;

import GObject.ObjectClass;
import Gid.gid;
import Pango.Types;
import Pango.c.functions;
import Pango.c.types;

class FontClass
{
  PangoFontClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Pango.FontClass");

    cInstance = *cast(PangoFontClass*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property ObjectClass parentClass()
  {
    return new ObjectClass(cast(GObjectClass*)&(cast(PangoFontClass*)cPtr).parentClass);
  }

  alias DescribeFuncType = extern(C) PangoFontDescription* function(PangoFont* font);

  @property DescribeFuncType describe()
  {
    return (cast(PangoFontClass*)cPtr).describe;
  }

  alias GetCoverageFuncType = extern(C) PangoCoverage* function(PangoFont* font, PangoLanguage* language);

  @property GetCoverageFuncType getCoverage()
  {
    return (cast(PangoFontClass*)cPtr).getCoverage;
  }

  alias GetGlyphExtentsFuncType = extern(C) void function(PangoFont* font, PangoGlyph glyph, PangoRectangle* inkRect, PangoRectangle* logicalRect);

  @property GetGlyphExtentsFuncType getGlyphExtents()
  {
    return (cast(PangoFontClass*)cPtr).getGlyphExtents;
  }

  alias GetMetricsFuncType = extern(C) PangoFontMetrics* function(PangoFont* font, PangoLanguage* language);

  @property GetMetricsFuncType getMetrics()
  {
    return (cast(PangoFontClass*)cPtr).getMetrics;
  }

  alias GetFontMapFuncType = extern(C) PangoFontMap* function(PangoFont* font);

  @property GetFontMapFuncType getFontMap()
  {
    return (cast(PangoFontClass*)cPtr).getFontMap;
  }

  alias DescribeAbsoluteFuncType = extern(C) PangoFontDescription* function(PangoFont* font);

  @property DescribeAbsoluteFuncType describeAbsolute()
  {
    return (cast(PangoFontClass*)cPtr).describeAbsolute;
  }

  alias GetFeaturesFuncType = extern(C) void function(PangoFont* font, hb_feature_t* features, uint len, uint* numFeatures);

  @property GetFeaturesFuncType getFeatures()
  {
    return (cast(PangoFontClass*)cPtr).getFeatures;
  }

  alias CreateHbFontFuncType = extern(C) hb_font_t* function(PangoFont* font);

  @property CreateHbFontFuncType createHbFont()
  {
    return (cast(PangoFontClass*)cPtr).createHbFont;
  }
}
